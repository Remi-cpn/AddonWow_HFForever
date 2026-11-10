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
L.CMD_HELP_TEST = "/hff test [catégorie] : résumé des données, ou détail d'une catégorie (ex. /hff test 51)"
L.CMD_HELP_TOAST = "/hff toast [nombre|resume] : affiche des toasts de test"
L.CMD_HELP_SOUND = "/hff son : active ou coupe le son des toasts"
L.SOUND_ON = "son des toasts activé."
L.SOUND_OFF = "son des toasts coupé."
L.CMD_HELP_SCAN = "/hff scan : relance la détection des hauts faits"

-- Toasts (UI/Toasts.lua)
L.TOAST_UNLOCKED = "Haut fait obtenu"
L.TOAST_RETRO_TITLE = "Hauts faits déjà accomplis"
L.TOAST_RETRO_NAME = "%d hauts faits détectés"
L.TOAST_ATLAS_MISSING = "atlas de toast introuvable : %s"
L.CMD_HELP_RESET = "/hff reset confirmer : efface les hauts faits obtenus et relance la détection"
L.CMD_HELP_HELP = "/hff aide : affiche cette aide"
L.CMD_HELP_DEV_HEADER = "Commandes de développement (absentes de la version publiée) :"
L.SCAN_REQUESTED = "détection relancée."
L.RESET_CONFIRM_NEEDED = "ceci efface tous les hauts faits obtenus. Tape /hff reset confirmer pour continuer."
L.RESET_DONE = "hauts faits effacés, nouvelle détection en cours..."

-- Moteur de détection (Core/Engine.lua)
L.ENGINE_EARNED = "|cffffff00Haut fait obtenu : %s|r (%d points)"
L.ENGINE_RETRO_SUMMARY = "%d haut(s) fait(s) déjà accompli(s) détecté(s)."
L.ENGINE_CRITERIA_ERROR = "haut fait %s, critère %s : erreur de lecture (%s)"
L.ENGINE_LISTENER_ERROR = "erreur dans un abonné du moteur : %s"
L.CMD_UNKNOWN = "commande inconnue : « %s ». Tape /hff aide."

-- Fenêtre principale (UI/MainWindow.lua)
L.WINDOW_HEADER_TITLE = "Points de hauts faits du compte"
L.TAB_ACHIEVEMENTS = "Hauts faits"
L.CATEGORY_SUMMARY = "Résumé"
L.BACK = "Retour"
-- Lignes de hauts faits (UI/AchievementList.lua). Quand Blizzard a le même
-- texte, on reprend le sien (déjà traduit par le jeu), avec un texte de secours.
L.ACCOUNT_WIDE = ACCOUNT_WIDE_ACHIEVEMENT or "Haut fait de compte"
L.ACCOUNT_WIDE_COMPLETED = ACCOUNT_WIDE_ACHIEVEMENT_COMPLETED or "Haut fait de compte obtenu"
L.EARNED_BY = "Obtenu par %s"
L.HIDE_COMPLETED = "Masquer les obtenus"
L.META_COMPLETED_DATE = ACHIEVEMENT_META_COMPLETED_DATE or "Obtenu le %s"
-- Panneau Résumé (UI/Summary.lua), mêmes textes que Blizzard quand ils existent.
L.SUMMARY_LATEST = LATEST_UNLOCKED_ACHIEVEMENTS or "Derniers hauts faits obtenus"
L.SUMMARY_EMPTY = NO_COMPLETED_ACHIEVEMENTS or "Aucun haut fait obtenu"
L.SUMMARY_PROGRESS = ACHIEVEMENT_CATEGORY_PROGRESS or "Aperçu de la progression"
L.SUMMARY_COMPLETED = ACHIEVEMENTS_COMPLETED or "Hauts faits accomplis"
L.SUMMARY_INCOMPLETE = SUMMARY_ACHIEVEMENT_INCOMPLETE or "Haut fait suggéré"
L.SUMMARY_INCOMPLETE_TEXT = SUMMARY_ACHIEVEMENT_INCOMPLETE_TEXT or "Vous n'avez pas encore obtenu ce haut fait."
-- Recherche (UI/Search.lua), mêmes textes que Blizzard quand ils existent.
L.SEARCH_SHOW_ALL = ENCOUNTER_JOURNAL_SHOW_SEARCH_RESULTS or "Afficher les %d résultats"
L.SEARCH_RESULTS_TITLE = ENCOUNTER_JOURNAL_SEARCH_RESULTS or "Résultats de recherche pour « %s » (%d)"
L.SEARCH_COMPLETED = ACHIEVEMENTFRAME_FILTER_COMPLETED or "Accomplis"
L.SEARCH_INCOMPLETE = ACHIEVEMENTFRAME_FILTER_INCOMPLETE or "Non accomplis"
L.WINDOW_FILE_MISSING = "texture de la fenêtre introuvable : %s"
L.WINDOW_ATLAS_MISSING = "atlas de la fenêtre introuvable : %s"

-- Panneau d'options (UI/Options.lua)
L.OPTION_MINIMAP = "Bouton de la minimap"
L.OPTION_MINIMAP_TOOLTIP = "Affiche le bouton de HF Forever autour de la minimap. L'entrée du compartiment d'addons reste toujours disponible."
L.OPTION_TOASTS = "Afficher les toasts"
L.OPTION_TOASTS_TOOLTIP = "Affiche une alerte à l'écran quand un haut fait est obtenu. Le message dans le chat reste toujours affiché."
L.OPTION_SOUND = "Son des toasts"
L.OPTION_SOUND_TOOLTIP = "Joue le son de haut fait avec chaque toast."

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
L.CRITERIA_EXPLORE = "Explorer : %s"
L.CRITERIA_PROFESSION = "%s : %d"
L.CRITERIA_PROFESSION_ANY = "Un métier principal : %d"

-- Noms des métiers, par id de ligne de compétence (skillLine)
L.PROFESSION_NAMES = {
	[129] = "Secourisme",
	[164] = "Forge",
	[165] = "Travail du cuir",
	[171] = "Alchimie",
	[182] = "Herboristerie",
	[185] = "Cuisine",
	[186] = "Minage",
	[197] = "Couture",
	[202] = "Ingénierie",
	[333] = "Enchantement",
	[356] = "Pêche",
	[393] = "Dépeçage",
}

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
L.DATA_ERR_CRITERIA_INVALID = "haut fait %s, critère %s : %s"
L.DATA_ERR_META_TARGET = "haut fait %s, critère %s : haut fait visé %s inexistant, méta retiré"
-- Messages des contrôles par type (validate dans Core/CriteriaTypes.lua)
L.DATA_ERR_STATISTIC = "statistique %s introuvable dans le jeu"
L.DATA_ERR_MAP = "carte %s introuvable dans le jeu"
L.DATA_ERR_EXPLORE_TOTAL = "pas de total d'exploration pour la carte %s (art %s), voir Data/ExplorationTotals.lua"

-- Commande /hff test
L.TEST_CATEGORY_LIST = "GetCategoryList : %s"
L.TEST_CATEGORY = "catégorie %s : %s, parent %s, %s HF dont %s obtenus"
L.TEST_ACHIEVEMENT = "  GetAchievementInfo : %s"
L.TEST_CRITERIA = "    critère %s : %s"
L.TEST_SERIES = "    série : précédent %s, suivant %s"
L.TEST_TOTALS = "GetNumCompletedAchievements : %s / %s, points : %s"
L.TEST_LATEST = "GetLatestCompletedAchievements : %s"
L.TEST_NONE = "aucun"
L.TEST_UNKNOWN_CATEGORY = "catégorie « %s » inconnue. Tape /hff test pour la liste."
