-- Vérifie les données de Data/ et construit les index par id.
-- Une entrée invalide est signalée dans le chat et ignorée : le reste de
-- l'addon fonctionne quand même.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Registry = {}
ns.Registry = Registry

local categoriesById = {}
local categoryOrder = {}          -- id des catégories, dans l'ordre de Data/Categories.lua
local achievementsById = {}
local achievementsByCategory = {} -- [categoryID] = liste, dans l'ordre de Data/Achievements.lua
local nextById = {}               -- [id] = haut fait suivant dans la série
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

	-- Après coup : une catégorie mère peut être déclarée après ses filles.
	for _, id in ipairs(categoryOrder) do
		local parent = categoriesById[id].parent
		if parent ~= nil and not categoriesById[parent] then
			ReportError(L.DATA_ERR_CATEGORY_PARENT, id, parent)
			categoriesById[id].parent = nil
		end
	end
end

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
	if criterion.combine ~= nil and criterion.combine ~= "max" and criterion.combine ~= "sum" then
		ReportError(L.DATA_ERR_CRITERIA_COMBINE, achievementID, index, tostring(criterion.combine))
		return false
	end
	if criteriaType.validate then
		local message = criteriaType.validate(criterion)
		if message then
			ReportError(L.DATA_ERR_CRITERIA_INVALID, achievementID, index, message)
			return false
		end
	end
	return true
end

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

-- Une icône absente du client ne bloque pas le haut fait : elle est
-- remplacée par l'icône de secours.
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

	-- Un méta qui vise un haut fait absent ne pourrait jamais être obtenu :
	-- on le retire.
	local invalid = {}
	for id, achievement in pairs(achievementsById) do
		for index, criterion in ipairs(achievement.criteria) do
			if criterion.type == "achievement" and not achievementsById[criterion.id] then
				ReportError(L.DATA_ERR_META_TARGET, id, index, criterion.id)
				invalid[id] = true
			end
		end
	end
	for id in pairs(invalid) do
		local achievement = achievementsById[id]
		achievementsById[id] = nil
		local list = achievementsByCategory[achievement.category]
		for i = #list, 1, -1 do
			if list[i] == achievement then
				table.remove(list, i)
			end
		end
		achievementCount = achievementCount - 1
	end

	-- Séries : previous peut viser un haut fait déclaré plus loin.
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

-- Data/ ne contient aucun texte : noms, descriptions et textes de critères
-- viennent des dictionnaires de Locales/, rangés par id. Copiés dans les
-- données avant les contrôles : un texte manquant y est signalé, et le reste
-- de l'addon lit simplement achievement.name.
local function ApplyTexts()
	for _, category in ipairs(ns.Data.categories or {}) do
		category.name = L.CATEGORY_NAMES[category.id]
	end
	for _, achievement in ipairs(ns.Data.achievements or {}) do
		local id = achievement.id
		achievement.name = L.ACHIEVEMENT_NAMES[id]
		achievement.description = L.ACHIEVEMENT_DESCRIPTIONS[id]
		achievement.reward = L.ACHIEVEMENT_REWARDS[id]
		local texts = L.CRITERIA_TEXTS[id]
		if texts and type(achievement.criteria) == "table" then
			for index, text in pairs(texts) do
				local criterion = achievement.criteria[index]
				if type(criterion) == "table" then
					criterion.text = text
				end
			end
		end
	end
end

-- Appelé une fois à ADDON_LOADED, après Database:Init.
function Registry:Build()
	ApplyTexts()
	BuildCategories()
	BuildAchievements()
	Log.Debug("Registry:", #categoryOrder, "catégories,", achievementCount,
		"hauts faits,", errorCount, "erreur(s)")
end

function Registry:GetCategory(categoryID)
	return categoriesById[categoryID]
end

-- Ne pas modifier la table renvoyée.
function Registry:GetCategoryOrder()
	return categoryOrder
end

function Registry:GetAchievement(achievementID)
	return achievementsById[achievementID]
end

-- nil si la catégorie n'existe pas.
function Registry:GetCategoryAchievements(categoryID)
	return achievementsByCategory[categoryID]
end

function Registry:GetNextInSeries(achievementID)
	return nextById[achievementID]
end

function Registry:GetAchievementCount()
	return achievementCount
end

-- for id, achievement in Registry:Iterate() do ... end
function Registry:Iterate()
	return pairs(achievementsById)
end
