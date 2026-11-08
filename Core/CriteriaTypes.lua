-- Types de critères connus. Chaque type déclare :
--   fields       : champs obligatoires du critère dans Data/Achievements.lua
--   progressBar  : true/false, ou fonction(c) -> booléen : afficher une barre
--                  de progression dans l'UI
--   describe(c)  : texte du critère affiché au joueur
--   goal(c)      : quantité à atteindre (pour la barre et le texte x / y)
--   validate(c)  : (facultatif) contrôle au chargement. Renvoie un message
--                  d'erreur si le critère est inutilisable, nil sinon.
--   current(c)   : progression actuelle du personnage connecté (un nombre).
--                  Le critère est rempli quand current(c) >= goal(c).
--                  Appelée par le moteur (Core/Engine.lua), jamais en combat.
local _, ns = ...

local L = ns.L

local CriteriaTypes = {}
ns.CriteriaTypes = CriteriaTypes

-- Nom d'une statistique de Forever (ex. « Quêtes achevées »), ou nil.
-- Les statistiques partagent la base des hauts faits de Blizzard.
local function GetStatisticName(statisticID)
	return select(2, GetAchievementInfo(statisticID))
end

-- Total de morceaux de carte d'une zone, ou nil si inconnu.
local function GetExplorationTotal(mapID)
	local artID = C_Map.GetMapArtID(mapID)
	return artID and ns.Data.explorationTotals[artID]
end

-- Valeur d'une statistique sous forme de nombre. GetStatistic renvoie du
-- texte : "--" quand la valeur est nulle, et peut-être des séparateurs de
-- milliers pour les grands nombres. On ne garde que les chiffres.
local function GetStatisticNumber(statisticID)
	local text = GetStatistic(statisticID)
	if type(text) ~= "string" then
		return 0
	end
	return tonumber((text:gsub("%D", ""))) or 0
end

-- Rang d'un métier du personnage. skillLine = nil : meilleur des deux
-- métiers principaux. GetProfessions renvoie les index des métiers
-- (2 principaux puis les secondaires), nil pour un emplacement vide.
local function GetProfessionRank(skillLine)
	local prof1, prof2, sec1, sec2, sec3, sec4, sec5 = GetProfessions()
	local best = 0
	if skillLine == nil then
		for _, index in pairs({ prof1, prof2 }) do
			local rank = select(3, GetProfessionInfo(index))
			best = math.max(best, rank or 0)
		end
		return best
	end
	for _, index in pairs({ prof1, prof2, sec1, sec2, sec3, sec4, sec5 }) do
		local _, _, rank, _, _, _, line = GetProfessionInfo(index)
		if line == skillLine then
			return rank or 0
		end
	end
	return 0
end

-- Atteindre un niveau. Exemple : { type = "level", value = 10 }
CriteriaTypes.level = {
	fields = { "value" },
	progressBar = true,
	describe = function(criterion)
		return L.CRITERIA_LEVEL:format(criterion.value)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	current = function()
		return UnitLevel("player") or 0
	end,
}

-- Valeur d'une statistique de Forever (GetStatistic) >= value.
-- Exemple : { type = "statistic", id = 98, value = 50 }
-- text (facultatif) remplace le nom de la statistique dans l'UI.
CriteriaTypes.statistic = {
	fields = { "id", "value" },
	progressBar = function(criterion)
		return criterion.value > 1
	end,
	describe = function(criterion)
		return criterion.text or GetStatisticName(criterion.id) or tostring(criterion.id)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	validate = function(criterion)
		if not GetStatisticName(criterion.id) then
			return L.DATA_ERR_STATISTIC:format(tostring(criterion.id))
		end
	end,
	current = function(criterion)
		return GetStatisticNumber(criterion.id)
	end,
}

-- Explorer entièrement une zone. Exemple : { type = "explore", mapID = 1429 }
CriteriaTypes.explore = {
	fields = { "mapID" },
	progressBar = true,
	describe = function(criterion)
		local info = C_Map.GetMapInfo(criterion.mapID)
		return L.CRITERIA_EXPLORE:format(info and info.name or tostring(criterion.mapID))
	end,
	goal = function(criterion)
		return GetExplorationTotal(criterion.mapID) or 1
	end,
	validate = function(criterion)
		if not C_Map.GetMapInfo(criterion.mapID) then
			return L.DATA_ERR_MAP:format(tostring(criterion.mapID))
		end
		if not GetExplorationTotal(criterion.mapID) then
			return L.DATA_ERR_EXPLORE_TOTAL:format(tostring(criterion.mapID),
				tostring(C_Map.GetMapArtID(criterion.mapID)))
		end
	end,
	-- Nombre de morceaux de carte déjà découverts dans la zone.
	current = function(criterion)
		local explored = C_MapExplorationInfo.GetExploredMapTextures(criterion.mapID)
		return explored and #explored or 0
	end,
}

-- Rang dans un métier. skillLine = id du métier (voir L.PROFESSION_NAMES).
-- Sans skillLine : n'importe quel métier principal.
-- Exemples : { type = "profession", skillLine = 171, value = 300 }
--            { type = "profession", value = 150 }
CriteriaTypes.profession = {
	fields = { "value" },
	progressBar = true,
	describe = function(criterion)
		if not criterion.skillLine then
			return L.CRITERIA_PROFESSION_ANY:format(criterion.value)
		end
		local name = L.PROFESSION_NAMES[criterion.skillLine] or tostring(criterion.skillLine)
		return L.CRITERIA_PROFESSION:format(name, criterion.value)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	current = function(criterion)
		return GetProfessionRank(criterion.skillLine)
	end,
}

-- Obtenir un autre haut fait de l'addon (pour les métas).
-- Exemple : { type = "achievement", id = 3001 }
-- L'existence de l'id est vérifiée par le Registry, une fois tous les hauts
-- faits chargés.
CriteriaTypes.achievement = {
	fields = { "id" },
	progressBar = false,
	describe = function(criterion)
		local achievement = ns.Registry:GetAchievement(criterion.id)
		return achievement and achievement.name or tostring(criterion.id)
	end,
	goal = function()
		return 1
	end,
	current = function(criterion)
		return ns.Database:GetCompletion(criterion.id) and 1 or 0
	end,
}
