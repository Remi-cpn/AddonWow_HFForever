-- Registre : vérifie les données de Data/ puis construit des index pour
-- retrouver vite une catégorie ou un haut fait par son id.
-- Une entrée invalide est signalée en rouge dans le chat et ignorée, le reste
-- de l'addon continue de fonctionner.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Registry = {}
ns.Registry = Registry

local categoriesById = {}         -- [id] = catégorie
local categoryOrder = {}          -- liste des id, dans l'ordre d'affichage
local achievementsById = {}       -- [id] = haut fait
local achievementsByCategory = {} -- [categoryID] = liste de hauts faits
local nextById = {}               -- [id] = id du haut fait suivant de la série
local achievementCount = 0
local errorCount = 0

local function ReportError(fmt, ...)
	errorCount = errorCount + 1
	Log.Error(fmt, ...)
end

local function IsValidId(id)
	return type(id) == "number" and id > 0 and id == math.floor(id)
end

local function IsNonEmptyString(value)
	return type(value) == "string" and value ~= ""
end

local function BuildCategories()
	for index, category in ipairs(ns.Data.categories or {}) do
		local id = category.id
		if not IsValidId(id) then
			ReportError(L.DATA_ERR_CATEGORY_ID, index)
		elseif categoriesById[id] then
			ReportError(L.DATA_ERR_CATEGORY_DUP, id)
		elseif not IsNonEmptyString(category.name) then
			ReportError(L.DATA_ERR_CATEGORY_NAME, id)
		else
			categoriesById[id] = category
			categoryOrder[#categoryOrder + 1] = id
			achievementsByCategory[id] = {}
		end
	end

	-- Les parents sont vérifiés à la fin, car un parent peut être déclaré
	-- après sa sous-catégorie.
	for _, id in ipairs(categoryOrder) do
		local parent = categoriesById[id].parent
		if parent ~= nil and not categoriesById[parent] then
			ReportError(L.DATA_ERR_CATEGORY_PARENT, id, parent)
			categoriesById[id].parent = nil
		end
	end
end

-- Vérifie un critère. Renvoie true s'il est utilisable.
local function ValidateCriterion(achievementID, index, criterion)
	local criteriaType = type(criterion) == "table" and ns.CriteriaTypes[criterion.type]
	if not criteriaType then
		ReportError(L.DATA_ERR_CRITERIA_TYPE, achievementID, index,
			type(criterion) == "table" and criterion.type or "?")
		return false
	end
	for _, field in ipairs(criteriaType.fields) do
		if criterion[field] == nil then
			ReportError(L.DATA_ERR_CRITERIA_FIELD, achievementID, index, field)
			return false
		end
	end
	return true
end

-- Vérifie un haut fait. Renvoie true s'il est utilisable.
local function ValidateAchievement(achievement)
	local id = achievement.id
	if not IsNonEmptyString(achievement.name) then
		ReportError(L.DATA_ERR_ACH_FIELD, id, "name")
		return false
	end
	if type(achievement.description) ~= "string" then
		ReportError(L.DATA_ERR_ACH_FIELD, id, "description")
		return false
	end
	if type(achievement.points) ~= "number" then
		ReportError(L.DATA_ERR_ACH_FIELD, id, "points")
		return false
	end
	if not categoriesById[achievement.category] then
		ReportError(L.DATA_ERR_ACH_CATEGORY, id, achievement.category)
		return false
	end
	if type(achievement.criteria) ~= "table" or #achievement.criteria == 0 then
		ReportError(L.DATA_ERR_CRITERIA_EMPTY, id)
		return false
	end
	for index, criterion in ipairs(achievement.criteria) do
		if not ValidateCriterion(id, index, criterion) then
			return false
		end
	end
	return true
end

-- Une icône absente ne bloque pas le haut fait : on met l'icône de secours.
-- GetFileIDFromPath renvoie nil quand le fichier n'existe pas dans le client.
local function CheckIcon(achievement)
	if type(achievement.icon) ~= "string" or not GetFileIDFromPath(achievement.icon) then
		ReportError(L.DATA_ERR_ICON, achievement.id, achievement.icon)
		achievement.icon = ns.fallbackIcon
	end
end

local function BuildAchievements()
	for index, achievement in ipairs(ns.Data.achievements or {}) do
		local id = achievement.id
		if not IsValidId(id) then
			ReportError(L.DATA_ERR_ACH_ID, index)
		elseif achievementsById[id] then
			ReportError(L.DATA_ERR_ACH_DUP, id)
		elseif ValidateAchievement(achievement) then
			CheckIcon(achievement)
			achievementsById[id] = achievement
			local list = achievementsByCategory[achievement.category]
			list[#list + 1] = achievement
			achievementCount = achievementCount + 1
		end
	end

	-- Séries : vérifiées à la fin, comme les parents de catégories.
	for id, achievement in pairs(achievementsById) do
		local previous = achievement.previous
		if previous ~= nil then
			if not achievementsById[previous] then
				ReportError(L.DATA_ERR_ACH_PREVIOUS, id, previous)
				achievement.previous = nil
			else
				nextById[previous] = id
			end
		end
	end
end

-- Appelé une fois au chargement (ADDON_LOADED), après la sauvegarde.
function Registry:Build()
	BuildCategories()
	BuildAchievements()
	Log.Debug("Registry:", #categoryOrder, "catégories,", achievementCount,
		"hauts faits,", errorCount, "erreur(s)")
end

function Registry:GetCategory(categoryID)
	return categoriesById[categoryID]
end

-- Liste des id de catégories dans l'ordre d'affichage. À lire seulement.
function Registry:GetCategoryOrder()
	return categoryOrder
end

function Registry:GetAchievement(achievementID)
	return achievementsById[achievementID]
end

-- Liste des hauts faits d'une catégorie, ou nil si la catégorie n'existe pas.
function Registry:GetCategoryAchievements(categoryID)
	return achievementsByCategory[categoryID]
end

function Registry:GetNextInSeries(achievementID)
	return nextById[achievementID]
end

function Registry:GetAchievementCount()
	return achievementCount
end

-- Parcours de tous les hauts faits : for id, achievement in Registry:Iterate()
function Registry:Iterate()
	return pairs(achievementsById)
end
