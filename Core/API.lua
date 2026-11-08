-- Fonctions d'accès aux données, avec les mêmes noms, arguments et valeurs
-- de retour (dans le même ordre) que l'API de hauts faits de Blizzard.
-- L'UI ne lit les données que par ici : elle ne connaît ni le Registry, ni
-- la sauvegarde, ni le moteur.
--
-- Attention : ce sont des fonctions de ns.API, pas des globales. Les
-- fonctions de Blizzard du même nom ne sont jamais touchées.
local _, ns = ...

local Registry = ns.Registry
local Database = ns.Database

local API = {}
ns.API = API

-- Même valeur que le drapeau Blizzard « afficher en barre de progression ».
local CRITERIA_FLAG_PROGRESS_BAR = 0x00000001

-- Nombre de hauts faits renvoyés par GetLatestCompletedAchievements.
local MAX_LATEST = 5

-- GetAchievementInfo accepte (achievementID) ou (categoryID, index).
local function ResolveAchievement(idOrCategory, index)
	if index then
		local list = Registry:GetCategoryAchievements(idOrCategory)
		return list and list[index]
	end
	return Registry:GetAchievement(idOrCategory)
end

-- Liste des id de catégories (copie, l'appelant peut la modifier).
function API.GetCategoryList()
	local copy = {}
	for i, id in ipairs(Registry:GetCategoryOrder()) do
		copy[i] = id
	end
	return copy
end

-- Renvoie : title, parentCategoryID (-1 si catégorie de premier niveau), flags
function API.GetCategoryInfo(categoryID)
	local category = Registry:GetCategory(categoryID)
	if not category then
		return nil
	end
	return category.name, category.parent or -1, 0
end

-- Renvoie : numItems, numCompleted, numIncomplete
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

-- Renvoie, comme Blizzard : id, name, points, completed, month, day, year,
-- description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy,
-- isStatistic. L'année est sur 2 chiffres (24 pour 2024), comme chez Blizzard.
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
		month, day, year, achievement.description, 0, achievement.icon,
		achievement.reward or "", false, completed, earnedBy, false
end

function API.GetAchievementNumCriteria(achievementID)
	local achievement = Registry:GetAchievement(achievementID)
	return achievement and #achievement.criteria or 0
end

-- Renvoie, comme Blizzard : criteriaString, criteriaType, completed,
-- quantity, reqQuantity, charName, flags, assetID, quantityString,
-- criteriaID, eligible.
-- Différence : criteriaType est notre nom de type ("level"...), pas un nombre.
function API.GetAchievementCriteriaInfo(achievementID, criteriaIndex)
	local achievement = Registry:GetAchievement(achievementID)
	local criterion = achievement and achievement.criteria[criteriaIndex]
	if not criterion then
		return nil
	end

	local criteriaType = ns.CriteriaTypes[criterion.type]
	local reqQuantity = criteriaType.goal and criteriaType.goal(criterion) or 1
	-- Tant que le moteur (étape 5) n'existe pas, un critère est rempli
	-- seulement si tout le haut fait est obtenu.
	local completed = Database:GetCompletion(achievementID) ~= nil
	local quantity = completed and reqQuantity or 0
	local flags = criteriaType.progressBar and CRITERIA_FLAG_PROGRESS_BAR or 0

	return criteriaType.describe(criterion), criterion.type, completed,
		quantity, reqQuantity, nil, flags, nil,
		("%d / %d"):format(quantity, reqQuantity), criteriaIndex, true
end

-- Renvoie : id du haut fait précédent de la série, ou nil
function API.GetPreviousAchievement(achievementID)
	local achievement = Registry:GetAchievement(achievementID)
	return achievement and achievement.previous
end

-- Renvoie : id du haut fait suivant de la série, completed ; ou nil
function API.GetNextAchievement(achievementID)
	local nextID = Registry:GetNextInSeries(achievementID)
	if not nextID then
		return nil
	end
	return nextID, Database:GetCompletion(nextID) ~= nil
end

-- Renvoie jusqu'à 5 id, du plus récent au plus ancien (plusieurs valeurs,
-- comme Blizzard, pas une table).
function API.GetLatestCompletedAchievements()
	local entries = {}
	for id, record in pairs(Database:GetAllCompletions()) do
		-- Un haut fait retiré de Data/ peut rester dans la sauvegarde : on l'ignore.
		if Registry:GetAchievement(id) then
			entries[#entries + 1] = { id = id, date = record.date }
		end
	end
	table.sort(entries, function(a, b)
		return a.date > b.date
	end)

	local ids = {}
	for i = 1, math.min(MAX_LATEST, #entries) do
		ids[i] = entries[i].id
	end
	return unpack(ids)
end

-- Renvoie : total, completed
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
