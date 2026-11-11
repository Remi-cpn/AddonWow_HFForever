-- Accès aux données avec les mêmes noms, arguments et valeurs de retour que
-- l'API de hauts faits de Blizzard. L'UI ne lit rien d'autre : ni le
-- Registry, ni la sauvegarde, ni le moteur.
-- Ce sont des fonctions de ns.API : les fonctions Blizzard du même nom ne
-- sont pas touchées.
local _, ns = ...

local Registry = ns.Registry
local Database = ns.Database

local API = {}
ns.API = API

-- Valeurs des drapeaux Blizzard EVALUATION_TREE_FLAG_PROGRESS_BAR et
-- ACHIEVEMENT_FLAGS_ACCOUNT. Tous nos hauts faits sont à l'échelle du compte.
local CRITERIA_FLAG_PROGRESS_BAR = 0x00000001
local ACHIEVEMENT_FLAG_ACCOUNT = 0x00020000

local MAX_LATEST = 5

-- Ordre d'affichage d'une catégorie, comme sur retail : les obtenus d'abord,
-- puis les autres, chaque groupe dans l'ordre de Data/Achievements.lua.
local function GetDisplayOrder(categoryID)
	local list = Registry:GetCategoryAchievements(categoryID)
	if not list then
		return nil
	end
	local completed, incomplete = {}, {}
	for _, achievement in ipairs(list) do
		if Database:GetCompletion(achievement.id) then
			completed[#completed + 1] = achievement
		else
			incomplete[#incomplete + 1] = achievement
		end
	end
	for _, achievement in ipairs(incomplete) do
		completed[#completed + 1] = achievement
	end
	return completed
end

-- (achievementID) ou (categoryID, index), index dans l'ordre d'affichage.
local function ResolveAchievement(idOrCategory, index)
	if index then
		local list = GetDisplayOrder(idOrCategory)
		return list and list[index]
	end
	return Registry:GetAchievement(idOrCategory)
end

-- Copie : l'appelant peut la modifier.
function API.GetCategoryList()
	local copy = {}
	for i, id in ipairs(Registry:GetCategoryOrder()) do
		copy[i] = id
	end
	return copy
end

-- title, parentCategoryID (-1 au premier niveau), flags
function API.GetCategoryInfo(categoryID)
	local category = Registry:GetCategory(categoryID)
	if not category then
		return nil
	end
	return category.name, category.parent or -1, 0
end

-- numItems, numCompleted, numIncomplete
function API.GetCategoryNumAchievements(categoryID)
	local list = Registry:GetCategoryAchievements(categoryID)
	if not list then
		return 0, 0, 0
	end
	local completed = 0
	for _, achievement in ipairs(list) do
		if Database:GetCompletion(achievement.id) then
			completed = completed + 1
		end
	end
	return #list, completed, #list - completed
end

-- total, completed, sous-catégories comprises. Chez Blizzard, c'est une
-- fonction de l'UI (AchievementFrame_GetCategoryTotalNumAchievements) ; elle
-- est ici parce que la liste des catégories et le Résumé en ont besoin.
function API.GetCategoryTotalNumAchievements(categoryID)
	local total, completed = API.GetCategoryNumAchievements(categoryID)
	for _, id in ipairs(Registry:GetCategoryOrder()) do
		if Registry:GetCategory(id).parent == categoryID then
			local childTotal, childCompleted = API.GetCategoryNumAchievements(id)
			total = total + childTotal
			completed = completed + childCompleted
		end
	end
	return total, completed
end

-- id de la catégorie du haut fait, ou nil.
function API.GetAchievementCategory(achievementID)
	local achievement = Registry:GetAchievement(achievementID)
	return achievement and achievement.category
end

-- id, name, points, completed, month, day, year, description, flags, icon,
-- rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic.
-- L'année est sur 2 chiffres, comme chez Blizzard.
function API.GetAchievementInfo(idOrCategory, index)
	local achievement = ResolveAchievement(idOrCategory, index)
	if not achievement then
		return nil
	end

	local record = Database:GetCompletion(achievement.id)
	local completed = record ~= nil
	local month, day, year, earnedBy
	if record then
		local when = date("*t", record.date)
		month, day, year = when.month, when.day, when.year % 100
		earnedBy = record.character
	end

	return achievement.id, achievement.name, achievement.points, completed,
		month, day, year, achievement.description, ACHIEVEMENT_FLAG_ACCOUNT, achievement.icon,
		achievement.reward or "", false, completed, earnedBy, false
end

function API.GetAchievementNumCriteria(achievementID)
	local achievement = Registry:GetAchievement(achievementID)
	return achievement and #achievement.criteria or 0
end

-- criteriaString, criteriaType, completed, quantity, reqQuantity, charName,
-- flags, assetID, quantityString, criteriaID, eligible.
-- Différences avec Blizzard : criteriaType est notre nom de type ("level"),
-- pas un nombre ; assetID n'est renseigné que pour un critère de méta.
function API.GetAchievementCriteriaInfo(achievementID, criteriaIndex)
	local achievement = Registry:GetAchievement(achievementID)
	local criterion = achievement and achievement.criteria[criteriaIndex]
	if not criterion then
		return nil
	end

	local criteriaType = ns.CriteriaTypes[criterion.type]
	local reqQuantity = criteriaType.goal and criteriaType.goal(criterion) or 1
	-- Plafonnée à l'objectif : 179 quêtes pour un objectif de 50 donne 50 / 50.
	local quantity = Database:GetProgress(achievementID, criterion.progressKey, criterion.combine)
	if Database:GetCompletion(achievementID) then
		quantity = reqQuantity
	end
	quantity = math.min(quantity, reqQuantity)
	local completed = quantity >= reqQuantity
	local progressBar = criteriaType.progressBar
	if type(progressBar) == "function" then
		progressBar = progressBar(criterion)
	end
	local flags = progressBar and CRITERIA_FLAG_PROGRESS_BAR or 0
	local assetID = criteriaType.asset and criteriaType.asset(criterion) or nil

	return criteriaType.describe(criterion), criterion.type, completed,
		quantity, reqQuantity, nil, flags, assetID,
		("%d / %d"):format(quantity, reqQuantity), criteriaIndex, true
end

-- id du haut fait précédent dans la série, ou nil.
function API.GetPreviousAchievement(achievementID)
	local achievement = Registry:GetAchievement(achievementID)
	return achievement and achievement.previous
end

-- id du suivant dans la série et s'il est obtenu, ou nil.
function API.GetNextAchievement(achievementID)
	local nextID = Registry:GetNextInSeries(achievementID)
	if not nextID then
		return nil
	end
	return nextID, Database:GetCompletion(nextID) ~= nil
end

-- Jusqu'à 5 id, du plus récent au plus ancien, en valeurs multiples comme
-- chez Blizzard.
function API.GetLatestCompletedAchievements()
	local entries = {}
	for id, record in pairs(Database:GetAllCompletions()) do
		-- Un haut fait retiré de Data/ peut rester dans la sauvegarde.
		if Registry:GetAchievement(id) then
			entries[#entries + 1] = { id = id, date = record.date, order = record.order or 0 }
		end
	end
	-- À date égale, le dernier enregistré passe d'abord (order vaut 0 dans
	-- les sauvegardes plus anciennes), puis l'id, pour un ordre stable.
	table.sort(entries, function(a, b)
		if a.date ~= b.date then
			return a.date > b.date
		end
		if a.order ~= b.order then
			return a.order > b.order
		end
		return a.id > b.id
	end)

	local ids = {}
	for i = 1, math.min(MAX_LATEST, #entries) do
		ids[i] = entries[i].id
	end
	return unpack(ids)
end

-- total, completed
function API.GetNumCompletedAchievements()
	local completed = 0
	for id in Registry:Iterate() do
		if Database:GetCompletion(id) then
			completed = completed + 1
		end
	end
	return Registry:GetAchievementCount(), completed
end

function API.GetTotalAchievementPoints()
	local points = 0
	for id, achievement in Registry:Iterate() do
		if Database:GetCompletion(id) then
			points = points + achievement.points
		end
	end
	return points
end
