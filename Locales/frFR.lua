-- Tous les textes affichés au joueur. L'interface est en français uniquement.
-- Une clé absente renvoie son propre nom entre crochets : ça se voit
-- tout de suite en jeu au lieu de provoquer une erreur.
local _, ns = ...

local L = setmetatable({}, {
	__index = function(_, key)
		return "[" .. tostring(key) .. "]"
	end,
})
ns.L = L

-- Messages généraux
L.ADDON_TITLE = "HF Forever"
L.LOADED = "version %s chargée. Tape /hff aide pour la liste des commandes."

-- Commandes slash
L.CMD_HELP_HEADER = "Commandes disponibles :"
L.CMD_HELP_OPEN = "/hff : ouvre la fenêtre des hauts faits"
L.CMD_HELP_DEBUG = "/hff debug : active ou désactive le mode debug"
L.CMD_HELP_MINIMAP = "/hff minimap : affiche ou masque le bouton de la minimap"
L.CMD_HELP_STATUS = "/hff etat : affiche l'état de la sauvegarde"
L.CMD_HELP_TEST = "/hff test : affiche ce que renvoient les fonctions d'accès aux données"
L.CMD_HELP_HELP = "/hff aide : affiche cette aide"
L.CMD_UNKNOWN = "commande inconnue : « %s ». Tape /hff aide."
L.WINDOW_NOT_READY = "la fenêtre n'existe pas encore (étape 7)."

-- Mode debug
L.DEBUG_ON = "mode debug activé."
L.DEBUG_OFF = "mode debug désactivé."

-- Bouton de minimap
L.MINIMAP_TOOLTIP_CLICK = "Clic gauche : ouvrir les hauts faits"
L.MINIMAP_TOOLTIP_DRAG = "Glisser : déplacer autour de la minimap"
L.MINIMAP_SHOWN = "bouton de la minimap affiché."
L.MINIMAP_HIDDEN = "bouton de la minimap masqué. Tape /hff minimap pour le réafficher."

-- État de la sauvegarde
L.STATUS_SCHEMA = "version du format de sauvegarde : %d"
L.STATUS_DEBUG = "mode debug : %s"
L.STATUS_COMPLETED = "hauts faits obtenus enregistrés : %d"
L.STATUS_MINIMAP = "bouton de la minimap : %s (position : %s)"
L.YES = "oui"
L.NO = "non"

-- Textes des critères (Core/CriteriaTypes.lua)
L.CRITERIA_LEVEL = "Atteindre le niveau %d"

-- Erreurs dans les données (Core/Registry.lua). Toujours %s, même pour les nombres.
L.DATA_ERR_CATEGORY_ID = "Data/Categories.lua, entrée n°%s : id manquant ou invalide"
L.DATA_ERR_CATEGORY_DUP = "catégorie %s : id en double"
L.DATA_ERR_CATEGORY_NAME = "catégorie %s : nom manquant"
L.DATA_ERR_CATEGORY_PARENT = "catégorie %s : catégorie mère %s inexistante"
L.DATA_ERR_ACH_ID = "Data/Achievements.lua, entrée n°%s : id manquant ou invalide"
L.DATA_ERR_ACH_DUP = "haut fait %s : id en double"
L.DATA_ERR_ACH_FIELD = "haut fait %s : champ « %s » manquant ou invalide"
L.DATA_ERR_ACH_CATEGORY = "haut fait %s : catégorie %s inexistante"
L.DATA_ERR_ACH_PREVIOUS = "haut fait %s : haut fait précédent %s inexistant"
L.DATA_ERR_CRITERIA_EMPTY = "haut fait %s : aucun critère"
L.DATA_ERR_CRITERIA_TYPE = "haut fait %s, critère %s : type « %s » inconnu"
L.DATA_ERR_CRITERIA_FIELD = "haut fait %s, critère %s : champ « %s » manquant"
L.DATA_ERR_ICON = "haut fait %s : icône introuvable (%s), icône de secours utilisée"

-- Commande /hff test
L.TEST_CATEGORY_LIST = "GetCategoryList : %s"
L.TEST_CATEGORY = "catégorie %s : %s, parent %s, %s HF dont %s obtenus"
L.TEST_ACHIEVEMENT = "  GetAchievementInfo : %s"
L.TEST_CRITERIA = "    critère %s : %s"
L.TEST_SERIES = "    série : précédent %s, suivant %s"
L.TEST_TOTALS = "GetNumCompletedAchievements : %s / %s, points : %s"
L.TEST_LATEST = "GetLatestCompletedAchievements : %s"
L.TEST_NONE = "aucun"
