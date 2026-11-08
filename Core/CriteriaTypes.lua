-- Types de critères connus. Chaque type déclare :
--   fields      : champs obligatoires du critère dans Data/Achievements.lua
--   progressBar : true si l'UI doit afficher une barre de progression
--   describe(c) : texte du critère affiché au joueur
--   goal(c)     : quantité à atteindre (pour la barre et le texte x / y)
-- La détection (savoir si le critère est rempli) arrive à l'étape 5.
local _, ns = ...

local L = ns.L

local CriteriaTypes = {}
ns.CriteriaTypes = CriteriaTypes

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
}
