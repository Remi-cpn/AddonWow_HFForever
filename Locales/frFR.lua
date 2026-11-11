-- Textes de l'interface en français, pour les clients frFR uniquement.
-- Remplace ceux de Locales/enUS.lua ; une clé oubliée ici reste en anglais.
-- Les noms et descriptions des hauts faits et des catégories sont en fin de
-- fichier, rangés par id (celui de Data/).
if GetLocale() ~= "frFR" then
	return
end

local _, ns = ...
local L = ns.L

L.LOG_SEPARATOR = " : "
L.LOG_ERROR_PREFIX = "HF Forever erreur"
L.LOADED = "version %s chargée. Tape /hff aide pour la liste des commandes."

-- Commandes slash (Core/Commands.lua)
L.CMD_HELP_HEADER = "Commandes disponibles :"
L.CMD_HELP_OPEN = "/hff : ouvre la fenêtre des hauts faits"
L.CMD_HELP_MINIMAP = "/hff minimap : affiche ou masque le bouton de la minimap"
L.CMD_HELP_SOUND = "/hff son : active ou coupe le son des toasts"
L.CMD_HELP_SCAN = "/hff scan : relance la détection des hauts faits"
L.CMD_HELP_STATUS = "/hff etat : affiche l'état de la sauvegarde"
L.CMD_HELP_HELP = "/hff aide : affiche cette aide"
L.CMD_HELP_DEV_HEADER = "Commandes de développement (absentes de la version publiée) :"
L.CMD_HELP_DEBUG = "/hff debug : active ou désactive le mode debug"
L.CMD_HELP_TEST = "/hff test [catégorie] : résumé des données, ou détail d'une catégorie (ex. /hff test 51)"
L.CMD_HELP_TOAST = "/hff toast [nombre|resume] : affiche des toasts de test"
L.CMD_HELP_RESET = "/hff reset confirmer : efface les hauts faits obtenus et relance la détection"
L.CMD_UNKNOWN = "commande inconnue : « %s ». Tape /hff aide."
L.SOUND_ON = "son des toasts activé."
L.SOUND_OFF = "son des toasts coupé."
L.SCAN_REQUESTED = "détection relancée."
L.RESET_CONFIRM_NEEDED = "ceci efface tous les hauts faits obtenus. Tape /hff reset confirmer pour continuer."
L.RESET_DONE = "hauts faits effacés, nouvelle détection en cours..."
L.DEBUG_ON = "mode debug activé."
L.DEBUG_OFF = "mode debug désactivé."
L.MINIMAP_SHOWN = "bouton de la minimap affiché."
L.MINIMAP_HIDDEN = "bouton de la minimap masqué. Tape /hff minimap pour le réafficher."

-- /hff etat
L.STATUS_SCHEMA = "version du format de sauvegarde : %d"
L.STATUS_DEBUG = "mode debug : %s"
L.STATUS_COMPLETED = "hauts faits obtenus enregistrés : %d"
L.STATUS_CHARACTERS = "personnages comptés dans la progression : %d"
L.STATUS_MINIMAP = "bouton de la minimap : %s (position : %s)"
L.YES = "oui"
L.NO = "non"

-- /hff test
L.TEST_CATEGORY_LIST = "GetCategoryList : %s"
L.TEST_CATEGORY = "catégorie %s : %s, parent %s, %s HF dont %s obtenus"
L.TEST_ACHIEVEMENT = "  GetAchievementInfo : %s"
L.TEST_CRITERIA = "    critère %s : %s"
L.TEST_SERIES = "    série : précédent %s, suivant %s"
L.TEST_TOTALS = "GetNumCompletedAchievements : %s / %s, points : %s"
L.TEST_LATEST = "GetLatestCompletedAchievements : %s"
L.TEST_NONE = "aucun"
L.TEST_UNKNOWN_CATEGORY = "catégorie « %s » inconnue. Tape /hff test pour la liste."

-- Moteur (Core/Engine.lua)
L.ENGINE_EARNED = "|cffffff00Haut fait obtenu : %s|r (%d points)"
L.ENGINE_RETRO_SUMMARY = "%d haut(s) fait(s) déjà accompli(s) détecté(s)."
L.ENGINE_CRITERIA_ERROR = "haut fait %s, critère %s : erreur de lecture (%s)"
L.ENGINE_LISTENER_ERROR = "erreur dans un abonné du moteur : %s"

-- Toasts (UI/Toasts.lua)
L.TOAST_UNLOCKED = "Haut fait obtenu"
L.TOAST_RETRO_TITLE = "Hauts faits déjà accomplis"
L.TOAST_RETRO_NAME = "%d hauts faits détectés"
L.TOAST_ATLAS_MISSING = "atlas de toast introuvable : %s"

-- Fenêtre. Les textes repris de Blizzard (voir enUS.lua) sont déjà en
-- français sur un client frFR ; seuls les textes de secours sont redonnés.
L.WINDOW_HEADER_TITLE = "Points de hauts faits du compte"
L.TAB_ACHIEVEMENTS = ACHIEVEMENTS or "Hauts faits"
L.CATEGORY_SUMMARY = ACHIEVEMENT_SUMMARY_CATEGORY or "Résumé"
L.BACK = BACK or "Retour"
L.WINDOW_FILE_MISSING = "texture de la fenêtre introuvable : %s"
L.WINDOW_ATLAS_MISSING = "atlas de la fenêtre introuvable : %s"
L.ACCOUNT_WIDE = ACCOUNT_WIDE_ACHIEVEMENT or "Haut fait de compte"
L.ACCOUNT_WIDE_COMPLETED = ACCOUNT_WIDE_ACHIEVEMENT_COMPLETED or "Haut fait de compte obtenu"
L.EARNED_BY = "Obtenu par %s"
L.HIDE_COMPLETED = "Masquer les obtenus"
L.META_COMPLETED_DATE = ACHIEVEMENT_META_COMPLETED_DATE or "Obtenu le %s"

-- Résumé
L.SUMMARY_LATEST = LATEST_UNLOCKED_ACHIEVEMENTS or "Derniers hauts faits obtenus"
L.SUMMARY_EMPTY = NO_COMPLETED_ACHIEVEMENTS or "Aucun haut fait obtenu"
L.SUMMARY_PROGRESS = ACHIEVEMENT_CATEGORY_PROGRESS or "Aperçu de la progression"
L.SUMMARY_COMPLETED = ACHIEVEMENTS_COMPLETED or "Hauts faits accomplis"
L.SUMMARY_INCOMPLETE = SUMMARY_ACHIEVEMENT_INCOMPLETE or "Haut fait suggéré"
L.SUMMARY_INCOMPLETE_TEXT = SUMMARY_ACHIEVEMENT_INCOMPLETE_TEXT or "Vous n'avez pas encore obtenu ce haut fait."

-- Recherche
L.SEARCH_SHOW_ALL = ENCOUNTER_JOURNAL_SHOW_SEARCH_RESULTS or "Afficher les %d résultats"
L.SEARCH_RESULTS_TITLE = ENCOUNTER_JOURNAL_SEARCH_RESULTS or "Résultats de recherche pour « %s » (%d)"
L.SEARCH_COMPLETED = ACHIEVEMENTFRAME_FILTER_COMPLETED or "Accomplis"
L.SEARCH_INCOMPLETE = ACHIEVEMENTFRAME_FILTER_INCOMPLETE or "Non accomplis"

-- Options
L.OPTION_MINIMAP = "Bouton de la minimap"
L.OPTION_MINIMAP_TOOLTIP = "Affiche le bouton de HF Forever autour de la minimap. L'entrée du compartiment d'addons reste toujours disponible."
L.OPTION_TOASTS = "Afficher les toasts"
L.OPTION_TOASTS_TOOLTIP = "Affiche une alerte à l'écran quand un haut fait est obtenu. Le message dans le chat reste toujours affiché."
L.OPTION_SOUND = "Son des toasts"
L.OPTION_SOUND_TOOLTIP = "Joue le son de haut fait avec chaque toast."
L.OPTIONS_IN_COMBAT = "les options ne s'ouvrent pas en combat."

-- Bouton de minimap
L.MINIMAP_TOOLTIP_CLICK = "Clic gauche : ouvrir les hauts faits"
L.MINIMAP_TOOLTIP_RIGHTCLICK = "Clic droit : menu"
L.MENU_OPEN = "Ouvrir les hauts faits"
L.MENU_OPTIONS = "Options"

-- Critères
L.CRITERIA_LEVEL = "Atteindre le niveau %d"
L.CRITERIA_EXPLORE = "Explorer : %s"
L.CRITERIA_PROFESSION = "%s : %d"
L.CRITERIA_PROFESSION_ANY = "Un métier principal : %d"

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

-- Erreurs dans les données
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
L.DATA_ERR_CRITERIA_COMBINE = "haut fait %s, critère %s : combine « %s » inconnu (max ou sum)"
L.DATA_ERR_META_TARGET = "haut fait %s, critère %s : haut fait visé %s inexistant, méta retiré"
L.DATA_ERR_STATISTIC = "statistique %s introuvable dans le jeu"
L.DATA_ERR_MAP = "carte %s introuvable dans le jeu"
L.DATA_ERR_EXPLORE_TOTAL = "pas de total d'exploration pour la carte %s (art %s), voir Data/ExplorationTotals.lua"

-------------------------------------------------------------------------------
-- Catégories et hauts faits, rangés par id. Chaque entrée remplace celle de
-- Locales/enUS.lua ; un id oublié ici reste en anglais.
-------------------------------------------------------------------------------

local function Override(target, values)
	for id, text in pairs(values) do
		target[id] = text
	end
end

Override(L.CATEGORY_NAMES, {
	[1] = "Général",
	[2] = "Quêtes",
	[3] = "Exploration",
	[31] = "Royaumes de l'Est",
	[32] = "Kalimdor",
	[6] = "Joueur contre Joueur",
	[61] = "Goulet des Chanteguerres",
	[62] = "Bassin Arathi",
	[63] = "Vallée d'Alterac",
	[4] = "Métiers",
	[5] = "Donjons",
	[51] = "Classiques",
	[52] = "Forever",
})

Override(L.ACHIEVEMENT_NAMES, {
	-- Général
	[1] = "Niveau 10",
	[2] = "Niveau 20",
	[3] = "Niveau 30",
	[4] = "Niveau 40",
	[5] = "Niveau 50",
	[6] = "Niveau 60",
	-- Quêtes
	[7] = "50 quêtes achevées",
	[8] = "100 quêtes achevées",
	[9] = "250 quêtes achevées",
	[10] = "500 quêtes achevées",
	[11] = "1 000 quêtes achevées",
	-- Exploration : Royaumes de l'Est (forme officielle « Exploration de... »,
	-- noms de zone de la carte de Forever)
	[12] = "Exploration des montagnes d'Alterac",
	[13] = "Exploration des Hautes-terres d'Arathi",
	[14] = "Exploration des Terres ingrates",
	[15] = "Exploration des Terres foudroyées",
	[16] = "Exploration des clairières de Tirisfal",
	[17] = "Exploration de la forêt des Pins-Argentés",
	[18] = "Exploration des Maleterres de l'Ouest",
	[19] = "Exploration des Maleterres de l'Est",
	[20] = "Exploration des contreforts de Hautebrande",
	[21] = "Exploration des Hinterlands",
	[22] = "Exploration de Dun Morogh",
	[23] = "Exploration de la gorge des Vents brûlants",
	[24] = "Exploration des steppes Ardentes",
	[25] = "Exploration de la forêt d'Elwynn",
	[26] = "Exploration du défilé de Deuillevent",
	[27] = "Exploration du bois de la Pénombre",
	[28] = "Exploration du Loch Modan",
	[29] = "Exploration des Carmines",
	[30] = "Exploration de la vallée de Strangleronce",
	[31] = "Exploration du marais des Chagrins",
	[32] = "Exploration de la marche de l'Ouest",
	[33] = "Exploration des Paluns",
	[34] = "Exploration des Rives Claires",
	[35] = "Exploration des Royaumes de l'Est",
	-- Exploration : Kalimdor
	[36] = "Exploration de Durotar",
	[37] = "Exploration de Mulgore",
	[38] = "Exploration des Tarides",
	[39] = "Exploration de Teldrassil",
	[40] = "Exploration de Sombrivage",
	[41] = "Exploration d'Orneval",
	[42] = "Exploration des Mille pointes",
	[43] = "Exploration des Serres-Rocheuses",
	[44] = "Exploration de Désolace",
	[45] = "Exploration de Féralas",
	[46] = "Exploration du marécage d'Âprefange",
	[47] = "Exploration de Tanaris",
	[48] = "Exploration d'Azshara",
	[49] = "Exploration de Gangrebois",
	[50] = "Exploration du cratère d'Un'Goro",
	[51] = "Exploration de Silithus",
	[52] = "Exploration du Berceau-de-l'Hiver",
	[53] = "Exploration du mont Hyjal",
	[54] = "Exploration de Shen'dralas",
	[55] = "Exploration de Kalimdor",
	-- Exploration (57 n'est pas « Grand explorateur » de WotLK : sans Outreterre
	-- ni Norfendre)
	[56] = "Exploration de l'île de Zéphras",
	[57] = "Explorateur",
	-- Métiers. En WotLK, « Maître » = 375 et « Grand maître » = 450 : 300 se
	-- dit « Artisan ».
	[58] = "Compagnon de métier",
	[59] = "Expert de métier",
	[60] = "Artisan de métier",
	[61] = "Artisan alchimiste",
	[62] = "Artisan forgeron",
	[63] = "Artisan enchanteur",
	[64] = "Artisan ingénieur",
	[65] = "Artisan herboriste",
	[66] = "Artisan travailleur du cuir",
	[67] = "Artisan mineur",
	[68] = "Artisan dépeceur",
	[69] = "Artisan tailleur",
	[70] = "Artisan cuisinier",
	[71] = "Artisan pêcheur",
	[72] = "Artisan secouriste",
	-- Donjons classiques
	[73] = "Mortemines",
	[74] = "Cavernes des Lamentations",
	[75] = "Donjon d'Ombrecroc",
	[76] = "Prison de Hurlevent",
	[77] = "Profondeurs de Brassenoire",
	[78] = "Gnomeregan",
	[79] = "Kraal de Tranchebauge",
	[80] = "Salles Écarlates",
	[81] = "Monastère écarlate",
	[82] = "Souilles de Tranchebauge",
	[83] = "Uldaman",
	[84] = "Zul'Farrak",
	[85] = "Maraudon",
	[86] = "Temple englouti",
	[87] = "Profondeurs de Rochenoire",
	[88] = "Hache-Tripes", -- pas « Roi de Haches-Tripes » : roi Gordok seul
	[89] = "Bas du pic Rochenoire",
	[90] = "Sommet du pic Rochenoire",
	[91] = "Scholomance",
	[92] = "Stratholme",
	-- Donjons de Forever
	[93] = "Ruines de Lordaeron",
	[94] = "Cité de Dalaran",
	[95] = "Prison d'Alcaz",
	[96] = "Terrasse du Façonneur",
	-- Général : banque, argent, montures
	[97] = "Chambre forte",
	[98] = "Le fric, c'est chic",
	[99] = "Le fric, c'est chic",
	[100] = "Le fric, c'est chic",
	[101] = "Le fric, c'est chic",
	[102] = "Le fric, c'est chic",
	[103] = "Gagne-pain",
	[104] = "Gardien d'écuries",
	[105] = "L'écurie se remplit",
	[106] = "À la tête de la cavalerie",
	[107] = "Une montagne de montures",
	-- JcJ
	[108] = "Une victoire honorable",
	[109] = "100 victoires honorables",
	[110] = "500 victoires honorables",
	[111] = "1 000 victoires honorables",
	[112] = "5 000 victoires honorables",
	[113] = "10 000 victoires honorables",
	[114] = "25 000 victoires honorables",
	[115] = "50 000 victoires honorables",
	[116] = "100 000 victoires honorables",
	[117] = "Duel-icieux",
	[118] = "Victoire dans le goulet des Chanteguerres",
	[119] = "Vétéran du goulet des Chanteguerres",
	[120] = "Capture du drapeau",
	[121] = "Défenseur obstiné",
	[122] = "Victoire dans le bassin Arathi",
	[123] = "Vétéran du bassin Arathi",
	[124] = "À la rescousse !",
	[125] = "Cap ou pas cap ?",
	[126] = "Victoire dans la vallée d'Alterac",
	[127] = "Vétéran de la vallée d'Alterac",
	[128] = "Défense des tours",
	-- Métiers : pêche
	[129] = "25 poissons",
	[130] = "50 poissons",
	[131] = "100 poissons",
	[132] = "250 poissons",
	[133] = "500 poissons",
	[134] = "1 000 poissons",
})

Override(L.ACHIEVEMENT_DESCRIPTIONS, {
	-- Général
	[1] = "Atteindre le niveau 10.",
	[2] = "Atteindre le niveau 20.",
	[3] = "Atteindre le niveau 30.",
	[4] = "Atteindre le niveau 40.",
	[5] = "Atteindre le niveau 50.",
	[6] = "Atteindre le niveau 60.",
	-- Quêtes
	[7] = "Terminer 50 quêtes.",
	[8] = "Terminer 100 quêtes.",
	[9] = "Terminer 250 quêtes.",
	[10] = "Terminer 500 quêtes.",
	[11] = "Terminer 1000 quêtes.",
	-- Exploration : Royaumes de l'Est
	[12] = "Révéler toute la carte des montagnes d'Alterac.",
	[13] = "Révéler toute la carte des Hautes-terres d'Arathi.",
	[14] = "Révéler toute la carte des Terres ingrates.",
	[15] = "Révéler toute la carte des Terres foudroyées.",
	[16] = "Révéler toute la carte des clairières de Tirisfal.",
	[17] = "Révéler toute la carte de la forêt des Pins-Argentés.",
	[18] = "Révéler toute la carte des Maleterres de l'Ouest.",
	[19] = "Révéler toute la carte des Maleterres de l'Est.",
	[20] = "Révéler toute la carte des contreforts de Hautebrande.",
	[21] = "Révéler toute la carte des Hinterlands.",
	[22] = "Révéler toute la carte de Dun Morogh.",
	[23] = "Révéler toute la carte de la gorge des Vents brûlants.",
	[24] = "Révéler toute la carte des steppes Ardentes.",
	[25] = "Révéler toute la carte de la forêt d'Elwynn.",
	[26] = "Révéler toute la carte du défilé de Deuillevent.",
	[27] = "Révéler toute la carte du bois de la Pénombre.",
	[28] = "Révéler toute la carte du Loch Modan.",
	[29] = "Révéler toute la carte des Carmines.",
	[30] = "Révéler toute la carte de la vallée de Strangleronce.",
	[31] = "Révéler toute la carte du marais des Chagrins.",
	[32] = "Révéler toute la carte de la marche de l'Ouest.",
	[33] = "Révéler toute la carte des Paluns.",
	[34] = "Révéler toute la carte des Rives Claires.",
	[35] = "Explorer toutes les zones des Royaumes de l'Est.",
	-- Exploration : Kalimdor
	[36] = "Révéler toute la carte de Durotar.",
	[37] = "Révéler toute la carte de Mulgore.",
	[38] = "Révéler toute la carte des Tarides.",
	[39] = "Révéler toute la carte de Teldrassil.",
	[40] = "Révéler toute la carte de Sombrivage.",
	[41] = "Révéler toute la carte d'Orneval.",
	[42] = "Révéler toute la carte de Mille pointes.",
	[43] = "Révéler toute la carte des Serres-Rocheuses.",
	[44] = "Révéler toute la carte de Désolace.",
	[45] = "Révéler toute la carte de Féralas.",
	[46] = "Révéler toute la carte du marécage d'Âprefange.",
	[47] = "Révéler toute la carte de Tanaris.",
	[48] = "Révéler toute la carte d'Azshara.",
	[49] = "Révéler toute la carte de Gangrebois.",
	[50] = "Révéler toute la carte du cratère d'Un'Goro.",
	[51] = "Révéler toute la carte de Silithus.",
	[52] = "Révéler toute la carte de Berceau-de-l'Hiver.",
	[53] = "Révéler toute la carte du mont Hyjal.",
	[54] = "Révéler toute la carte de Shen'dralas.",
	[55] = "Explorer toutes les zones de Kalimdor.",
	-- Exploration
	[56] = "Révéler toute la carte de l'île de Zéphras.",
	[57] = "Explorer les Royaumes de l'Est et Kalimdor.",
	-- Métiers
	[58] = "Atteindre 150 dans un métier principal.",
	[59] = "Atteindre 225 dans un métier principal.",
	[60] = "Atteindre 300 dans un métier principal.",
	[61] = "Atteindre 300 en Alchimie.",
	[62] = "Atteindre 300 en Forge.",
	[63] = "Atteindre 300 en Enchantement.",
	[64] = "Atteindre 300 en Ingénierie.",
	[65] = "Atteindre 300 en Herboristerie.",
	[66] = "Atteindre 300 en Travail du cuir.",
	[67] = "Atteindre 300 en Minage.",
	[68] = "Atteindre 300 en Dépeçage.",
	[69] = "Atteindre 300 en Couture.",
	[70] = "Atteindre 300 en Cuisine.",
	[71] = "Atteindre 300 en Pêche.",
	[72] = "Atteindre 300 en Secourisme.",
	-- Donjons classiques
	[73] = "Vaincre Edwin VanCleef dans les Mortemines.",
	[74] = "Vaincre Mutanus le Dévoreur dans les cavernes des Lamentations.",
	[75] = "Vaincre l'archimage Arugal dans le donjon d'Ombrecroc.",
	[76] = "Vaincre Bazil Thredd dans la prison de Hurlevent.",
	[77] = "Vaincre Aku'mai dans les profondeurs de Brassenoire.",
	[78] = "Vaincre le mekgénieur Thermojoncteur dans Gnomeregan.",
	[79] = "Vaincre Charlga Trancheflanc dans le kraal de Tranchebauge.",
	[80] = "Vaincre le tisseur de flammes Koegler dans les salles Écarlates.",
	[81] = "Vaincre le commandant écarlate Mograine dans le Monastère écarlate.",
	[82] = "Vaincre Amnennar le Porte-Froid dans les souilles de Tranchebauge.",
	[83] = "Vaincre Archaedas dans Uldaman.",
	[84] = "Vaincre le chef Ukorz Scalpessable dans Zul'Farrak.",
	[85] = "Vaincre la princesse Theradras dans Maraudon.",
	[86] = "Vaincre l'ombre d'Eranikus dans le temple englouti.",
	[87] = "Vaincre l'empereur Dagran Thaurissan dans les profondeurs de Rochenoire.",
	[88] = "Vaincre le roi Gordok dans Hache-Tripes.",
	[89] = "Vaincre le seigneur Wyrmthalak dans le pic Rochenoire inférieur.",
	[90] = "Vaincre le général Drakkisath dans le pic Rochenoire supérieur.",
	[91] = "Vaincre le sombre maître Gandling dans la Scholomance.",
	[92] = "Vaincre le baron Vaillefendre dans Stratholme.",
	-- Donjons de Forever
	[93] = "Vaincre Rath'mael dans les ruines de Lordaeron.",
	[94] = "Vaincre l'Ombre de l'archimage dans la cité de Dalaran.",
	[95] = "Vaincre Rugiflamme dans la prison d'Alcaz.",
	[96] = "Vaincre Nanaya sur la terrasse du Façonneur.",
	-- Général : banque, argent, montures
	[97] = "Acheter 7 emplacements de sac supplémentaires.",
	[98] = "Ramasser 100 pièces d'or en butin.",
	[99] = "Ramasser 1 000 pièces d'or en butin.",
	[100] = "Ramasser 5 000 pièces d'or en butin.",
	[101] = "Ramasser 10 000 pièces d'or en butin.",
	[102] = "Ramasser 25 000 pièces d'or en butin.",
	[103] = "Obtenir 10 000 pièces d'or en récompenses de quêtes.",
	[104] = "Obtenir 10 montures.",
	[105] = "Obtenir 25 montures.",
	[106] = "Obtenir 50 montures.",
	[107] = "Obtenir 100 montures.",
	-- JcJ
	[108] = "Obtenir une victoire honorable.",
	[109] = "Obtenir 100 victoires honorables.",
	[110] = "Obtenir 500 victoires honorables.",
	[111] = "Obtenir 1 000 victoires honorables.",
	[112] = "Obtenir 5 000 victoires honorables.",
	[113] = "Obtenir 10 000 victoires honorables.",
	[114] = "Obtenir 25 000 victoires honorables.",
	[115] = "Obtenir 50 000 victoires honorables.",
	[116] = "Obtenir 100 000 victoires honorables.",
	[117] = "Gagner un duel contre un autre personnage.",
	[118] = "Gagner dans le goulet des Chanteguerres.",
	[119] = "Obtenir 100 victoires dans le goulet des Chanteguerres.",
	[120] = "Porter et capturer soi-même le drapeau dans le goulet des Chanteguerres.",
	[121] = "Ramener 50 drapeaux en défense dans le goulet des Chanteguerres.",
	[122] = "Gagner dans le bassin Arathi.",
	[123] = "Obtenir 100 victoires au bassin Arathi.",
	[124] = "Venir 50 fois à la rescousse d'une base du bassin Arathi en récupérant le drapeau.",
	[125] = "Capturer 50 drapeaux au bassin Arathi.",
	[126] = "Gagner dans la vallée d'Alterac.",
	[127] = "Obtenir 100 victoires dans la vallée d'Alterac.",
	[128] = "Défendre 50 tours dans la vallée d'Alterac.",
	-- Métiers : pêche
	[129] = "Pêcher 25 objets.",
	[130] = "Pêcher 50 objets.",
	[131] = "Pêcher 100 objets.",
	[132] = "Pêcher 250 objets.",
	[133] = "Pêcher 500 objets.",
	[134] = "Pêcher 1 000 objets.",
})

Override(L.CRITERIA_TEXTS, {
	-- Donjons classiques
	[73] = { "Edwin VanCleef" },
	[74] = { "Mutanus le Dévoreur" },
	[75] = { "Archimage Arugal" },
	[76] = { "Bazil Thredd" },
	[77] = { "Aku'mai" },
	[78] = { "Mekgénieur Thermojoncteur" },
	[79] = { "Charlga Trancheflanc" },
	[80] = { "Tisseur de flammes Koegler" },
	[81] = { "Commandant écarlate Mograine" },
	[82] = { "Amnennar le Porte-Froid" },
	[83] = { "Archaedas" },
	[84] = { "Chef Ukorz Scalpessable" },
	[85] = { "Princesse Theradras" },
	[86] = { "Ombre d'Eranikus" },
	[87] = { "Empereur Dagran Thaurissan" },
	[88] = { "Roi Gordok" },
	[89] = { "Seigneur Wyrmthalak" },
	[90] = { "Général Drakkisath" },
	[91] = { "Sombre maître Gandling" },
	[92] = { "Baron Vaillefendre" },
	-- Donjons de Forever
	[93] = { "Rath'mael" },
	[94] = { "Ombre de l'archimage" },
	[95] = { "Rugiflamme" },
	[96] = { "Nanaya" },
})
