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
L.TOOLTIP_LABEL = "Haut fait :"
L.MENU_INSPECT = "Inspecter les hauts faits"
L.TRACKER_HEADER = "Hauts faits (HF Forever)"
L.TRACK = "Suivre"
L.TRACK_TOOLTIP = "Cochez pour suivre ce haut fait dans le suivi des objectifs."
L.UNTRACK_TOOLTIP = "Décochez pour ne plus suivre ce haut fait."
L.TRACK_TOO_MANY = "Vous ne pouvez suivre que %d hauts faits à la fois."
L.TRACK_COMPLETED = "Ce haut fait est déjà obtenu."
L.TRACKER_VIEW = "Voir le haut fait"
L.TRACKER_STOP = "Ne plus suivre"
L.INSPECT_REQUESTED = "demande des hauts faits de %s..."
L.INSPECT_NO_REPLY = "%s n'a pas répondu : il lui faut HF Forever à jour."
L.INSPECT_UNAVAILABLE = "le jeu bloque les messages d'addon en ce moment (combat ou instance) : réessayez plus tard."
L.WINDOW_INSPECT_TITLE = "Hauts faits de %s"
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
-- Onglet des notes de version (UI/Changelog.lua)
L.TAB_CHANGELOG = "Notes de version"
L.CHANGELOG_LATEST = "Dernière version"
L.CHANGELOG_VERSION = "Version %s"
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
L.CRITERIA_QUEST = "Quête %d"
L.CRITERIA_WEAPON_SKILLS = "Compétences d'armes à %d"
L.CRITERIA_TABARD = "Tabard équipé"
L.CRITERIA_TABARDS = "Tabards différents équipés"
L.CRITERIA_BANK_SLOTS = "Emplacements de banque achetés"
L.CRITERIA_HAIRCUT = "Nouvelle coupe chez le coiffeur"
L.CRITERIA_QUEST_LISTS = {
	libraryBooks = "Livres de bibliothèque rendus",
}
L.CRITERIA_PERFECT_ROLL = {
	greed = "Obtenir 100 sur un jet de cupidité",
	need = "Obtenir 100 sur un jet de besoin",
}
L.CRITERIA_RECIPES = "Recettes connues : %s"
L.CRITERIA_COLLECTION = {
	pets = "Mascottes",
	mounts = "Montures",
}
L.CRITERIA_GEAR_QUALITY = {
	[3] = "Emplacements en qualité supérieure ou mieux",
	[4] = "Emplacements en qualité épique",
}

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
L.DATA_ERR_COLLECTION = "collection « %s » inconnue (pets ou mounts)"
L.DATA_ERR_RECIPES = "pas de liste de recettes pour le métier %s, voir Data/Recipes.lua"
L.DATA_ERR_ENCOUNTERS = "encounters doit contenir au moins un id de rencontre"
L.DATA_ERR_NATIVE = "native doit être { achievement = id, asset = id }"
L.DATA_ERR_PERFECT_ROLL = "jet « %s » inconnu (need ou greed)"
L.DATA_ERR_QUEST_LIST = "liste de quêtes « %s » inconnue, voir Data/Books.lua"
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
	[8] = "Rares",
	[81] = "Royaumes de l'Est",
	[82] = "Kalimdor",
	[83] = "Donjons",
	[6] = "Joueur contre Joueur",
	[61] = "Goulet des Chanteguerres",
	[62] = "Bassin Arathi",
	[63] = "Vallée d'Alterac",
	[64] = "Îles des Sombrelances",
	[4] = "Métiers",
	[7] = "Réputation",
	[5] = "Donjons",
	[51] = "Classiques",
	[52] = "Forever",
	[53] = "Raids",
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
	-- Exploration
	[56] = "Exploration de l'île de Zéphras",
	[57] = "Explorateur",
	-- Métiers (300 = « Artisan »)
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
	[77] = "Profondeurs de Brassenoire",
	[78] = "Gnomeregan",
	[79] = "Kraal de Tranchebauge",
	[81] = "Monastère Écarlate - cathédrale",
	[82] = "Souilles de Tranchebauge",
	[83] = "Uldaman",
	[84] = "Zul'Farrak",
	[85] = "Maraudon",
	[86] = "Temple englouti",
	[87] = "Profondeurs de Rochenoire",
	[88] = "Haches-Tripes - Nord",
	[89] = "Bas du pic Rochenoire",
	[90] = "Sommet du pic Rochenoire",
	[91] = "Scholomance",
	[92] = "Stratholme - Entrée de service",
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
	-- Métiers secondaires
	[135] = "Compagnon cuisinier",
	[136] = "Expert cuisinier",
	[137] = "Compagnon pêcheur",
	[138] = "Expert pêcheur",
	[139] = "Compagnon secouriste",
	[140] = "Expert secouriste",
	-- JcJ : réputations (141, 143, 145, 147 Horde ; 142, 144, 146, 148 Alliance)
	[141] = "Voltigeur Chanteguerre",
	[142] = "Sentinelle d'Aile-argent",
	[143] = "Profanateur",
	[144] = "Chevalier d'Arathor",
	[145] = "Héros du clan Loup-de-givre",
	[146] = "Héros de la garde Foudrepique",
	[147] = "Conquérant",
	[148] = "Le justicier",
	-- Réputation
	[149] = "Il y a de l'amour dans ce tunnel",
	[150] = "L'Aube d'argent",
	[151] = "Les Hydraxiens",
	[152] = "Progéniture de Nozdormu",
	[153] = "Héros de la tribu Zandalar",
	[154] = "Quelqu'un m'aime",
	[155] = "5 réputations exaltées",
	[156] = "10 réputations exaltées",
	[157] = "15 réputations exaltées",
	[158] = "20 réputations exaltées",
	[159] = "25 réputations exaltées",
	[160] = "30 réputations exaltées",
	[161] = "35 réputations exaltées",
	[162] = "40 réputations exaltées",
	[163] = "Ambassadeur de l'Alliance",
	[164] = "Ambassadeur de la Horde",
	-- Capitales : nom de la faction, comme « L'Aube d'argent »
	[165] = "Stormwind",
	[166] = "Forgefer",
	[167] = "Exilés de Gnomeregan",
	[168] = "Darnassus",
	[169] = "Orgrimmar",
	[170] = "Thunder Bluff",
	[171] = "Fossoyeuse",
	[172] = "Trolls Darkspear",
	-- Raids
	[173] = "Repaire d'Onyxia",
	[174] = "Sommet d'Hyjal",
	[175] = "Profondeurs des Saisons",
	-- Monte, compétences, équipement, quêtes
	[178] = "En selle !",
	[179] = "L'équipée sauvage",
	[180] = "Qui a commandé une salade de phalanges ?",
	[181] = "Maître d'armes",
	[182] = "Représentant",
	[183] = "Qualité supérieure",
	[184] = "Les vertes collines de Strangleronce",
	[185] = "Qualité épique",
	-- Mascottes
	[186] = "Je peux le garder ?",
	[187] = "De nombreux familiers",
	[188] = "Pléthore de familiers",
	[189] = "Les aimer comme ils vous aiment",
	[190] = "La chasse au p'tit gibier",
	-- Quêtes
	[191] = "1 500 quêtes achevées",
	[192] = "2 000 quêtes achevées",
	[193] = "3 000 quêtes achevées",
	-- Métiers : recettes de cuisine
	[194] = "Commis",
	[195] = "Cuistot",
	[196] = "Chef de partie",
	[197] = "Sous chef",
	-- Donjons : ailes (noms du Dungeon Journal) et métas
	[198] = "Monastère Écarlate - cimetière",
	[199] = "Monastère Écarlate - bibliothèque",
	[200] = "Monastère Écarlate - armurerie",
	[201] = "Monastère écarlate",
	[202] = "Haches-Tripes - Est",
	[203] = "Haches-Tripes - Ouest",
	[204] = "Roi de Haches-Tripes",
	[205] = "Stratholme - Grande porte",
	[206] = "Stratholme",
	[207] = "Gouffre de Ragefeu ou salle des Thanes",
	[208] = "L'écumeur pour toujours",
	-- Donjons de Forever (suite)
	[209] = "Excavations : les Paluns",
	[210] = "Cité Submergée",
	[211] = "Bastion Krol'dok",
	[212] = "Repaire des Noiregueules",
	-- JcJ : îles des Sombrelances
	[213] = "Victoire sur les îles des Sombrelances",
	[214] = "Vétéran des îles des Sombrelances",
	[215] = "Drapeaux capturés",
	[216] = "Bases attaquées",
	[217] = "Chevaucheur sombrelance",
	[218] = "Troupe d'intervention de Theramore",
	-- Général : coiffeur, tabards
	[219] = "Coupe et brushing",
	[220] = "Dix tabards",
	[221] = "Timbré de tabards",
	-- Général : jets de dés
	[222] = "Cupide",
	[223] = "Nécessiteux",
	-- Exploration : livres de bibliothèque
	[224] = "Ami de la bibliothèque",
	[225] = "Mécène de la bibliothèque",
	[226] = "Rat de bibliothèque",
	[227] = "Bibliothécaire émérite",
	[228] = "Bonne nuit les petits",
	-- Exploration : rares
	[229] = "Chasseur de têtes des montagnes d'Alterac",
	[230] = "Chasseur de têtes des Hautes-terres d'Arathi",
	[231] = "Chasseur de têtes des Terres ingrates",
	[232] = "Chasseur de têtes des Terres foudroyées",
	[233] = "Chasseur de têtes des clairières de Tirisfal",
	[234] = "Chasseur de têtes de la forêt des Pins-Argentés",
	[235] = "Chasseur de têtes des Maleterres de l'Ouest",
	[236] = "Chasseur de têtes des Maleterres de l'Est",
	[237] = "Chasseur de têtes des contreforts de Hautebrande",
	[238] = "Chasseur de têtes des Hinterlands",
	[239] = "Chasseur de têtes de Dun Morogh",
	[240] = "Chasseur de têtes de la gorge des Vents brûlants",
	[241] = "Chasseur de têtes des steppes Ardentes",
	[242] = "Chasseur de têtes de la forêt d'Elwynn",
	[243] = "Chasseur de têtes du bois de la Pénombre",
	[244] = "Chasseur de têtes du Loch Modan",
	[245] = "Chasseur de têtes des Carmines",
	[246] = "Chasseur de têtes de la vallée de Strangleronce",
	[247] = "Chasseur de têtes du marais des Chagrins",
	[248] = "Chasseur de têtes de la marche de l'Ouest",
	[249] = "Chasseur de têtes des Paluns",
	[250] = "Chasseur de têtes des Rives Claires",
	[251] = "Chasseur de têtes des capitales",
	[252] = "Chasseur de têtes de Durotar",
	[253] = "Chasseur de têtes de Mulgore",
	[254] = "Chasseur de têtes des Tarides",
	[255] = "Chasseur de têtes de Teldrassil",
	[256] = "Chasseur de têtes de Sombrivage",
	[257] = "Chasseur de têtes d'Orneval",
	[258] = "Chasseur de têtes des Mille pointes",
	[259] = "Chasseur de têtes des Serres-Rocheuses",
	[260] = "Chasseur de têtes de Désolace",
	[261] = "Chasseur de têtes de Féralas",
	[262] = "Chasseur de têtes du marécage d'Âprefange",
	[263] = "Chasseur de têtes de Tanaris",
	[264] = "Chasseur de têtes d'Azshara",
	[265] = "Chasseur de têtes de Gangrebois",
	[266] = "Chasseur de têtes du cratère d'Un'Goro",
	[267] = "Chasseur de têtes de Silithus",
	[268] = "Chasseur de têtes du Berceau-de-l'Hiver",
	[269] = "Chasseur de têtes du mont Hyjal",
	[270] = "Chasseur de têtes de l'île de Zéphras",
	[271] = "Chasseur de têtes des Royaumes de l'Est",
	[272] = "Chasseur de têtes de Kalimdor",
	[273] = "Terminator",
	[274] = "Chasseur de têtes des Mortemines",
	[275] = "Chasseur de têtes des cavernes des Lamentations",
	[276] = "Chasseur de têtes du donjon d'Ombrecroc",
	[277] = "Chasseur de têtes du kraal de Tranchebauge",
	[278] = "Chasseur de têtes de Gnomeregan",
	[279] = "Chasseur de têtes du Monastère écarlate",
	[280] = "Chasseur de têtes de Zul'Farrak",
	[281] = "Chasseur de têtes de Maraudon",
	[282] = "Chasseur de têtes du temple Englouti",
	[283] = "Chasseur de têtes des profondeurs de Rochenoire",
	[284] = "Chasseur de têtes du bas du pic Rochenoire",
	[285] = "Chasseur de têtes du sommet du pic Rochenoire",
	[286] = "Chasseur de têtes de Hache-Tripes",
	[287] = "Chasseur de têtes de Stratholme",
	[288] = "Chasseur de têtes des ruines de Lordaeron",
	[289] = "Chasseur de têtes de la Cité Submergée",
	[290] = "Chasseur de têtes du bastion Krol'dok",
	[291] = "Chasseur de têtes du repaire des Noiregueules",
	[292] = "Chasseur de têtes de la cité de Dalaran",
	[293] = "Chasseur de têtes des donjons",
	-- Quêtes : suite de Valthalak
	[294] = "Seigneur Valthalak tué",
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
	[57] = "Explorer les Royaumes de l'Est, Kalimdor et l'île de Zéphras.",
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
	[77] = "Vaincre Aku'mai dans les profondeurs de Brassenoire.",
	[78] = "Vaincre le mekgénieur Thermojoncteur dans Gnomeregan.",
	[79] = "Vaincre Charlga Trancheflanc dans le kraal de Tranchebauge.",
	[81] = "Vaincre le commandant écarlate Mograine dans la cathédrale du Monastère écarlate.",
	[82] = "Vaincre Amnennar le Porte-Froid dans les souilles de Tranchebauge.",
	[83] = "Vaincre Archaedas dans Uldaman.",
	[84] = "Vaincre le chef Ukorz Scalpessable dans Zul'Farrak.",
	[85] = "Vaincre la princesse Theradras dans Maraudon.",
	[86] = "Vaincre l'ombre d'Eranikus dans le temple englouti.",
	[87] = "Vaincre l'empereur Dagran Thaurissan dans les profondeurs de Rochenoire.",
	[88] = "Vaincre le roi Gordok dans l'aile nord de Hache-Tripes.",
	[89] = "Vaincre le seigneur Wyrmthalak dans le pic Rochenoire inférieur.",
	[90] = "Vaincre le général Drakkisath dans le pic Rochenoire supérieur.",
	[91] = "Vaincre le sombre maître Gandling dans la Scholomance.",
	[92] = "Vaincre le baron Vaillefendre dans Stratholme, par l'entrée de service.",
	-- Donjons de Forever
	[93] = "Vaincre Rath'mael dans les ruines de Lordaeron.",
	[94] = "Vaincre l'Ombre de l'archimage dans la cité de Dalaran.",
	[95] = "Vaincre Rugiflamme dans la prison d'Alcaz.",
	[96] = "Vaincre Nanaya sur la terrasse du Façonneur.",
	-- Général : banque, argent, montures
	[97] = "Acheter les 8 emplacements de sac de banque.",
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
	-- Métiers secondaires
	[135] = "Devenir un compagnon cuisinier.",
	[136] = "Devenir un expert cuisinier.",
	[137] = "Devenir un compagnon pêcheur.",
	[138] = "Devenir un expert pêcheur.",
	[139] = "Devenir un compagnon secouriste.",
	[140] = "Devenir expert secouriste.",
	-- JcJ : réputations
	[141] = "Être exalté auprès des voltigeurs Chanteguerre.",
	[142] = "Être exalté auprès des sentinelles d'Aile-argent.",
	[143] = "Être exalté auprès des Profanateurs réprouvés.",
	[144] = "Être exalté auprès de la ligue d'Arathor.",
	[145] = "Être exalté auprès du clan Loup-de-givre.",
	[146] = "Être exalté auprès de la garde Foudrepique.",
	[147] = "Être exalté auprès des factions du goulet des Chanteguerres, du bassin Arathi et de la vallée d'Alterac.",
	[148] = "Être exalté auprès des factions du goulet des Chanteguerres, du bassin Arathi et de la vallée d'Alterac.",
	-- Réputation
	[149] = "Être exalté auprès des Grumegueules.",
	[150] = "Être exalté auprès de l'Aube d'argent.",
	[151] = "Être exalté auprès des Hydraxiens.",
	[152] = "Être exalté auprès de la Progéniture de Nozdormu.",
	[153] = "Être exalté auprès de la tribu Zandalar.",
	[154] = "Monter une réputation jusqu'à Exalté.",
	[155] = "Monter 5 réputations jusqu'à Exalté.",
	[156] = "Monter 10 réputations jusqu'à Exalté.",
	[157] = "Monter 15 réputations jusqu'à Exalté.",
	[158] = "Monter 20 réputations jusqu'à Exalté.",
	[159] = "Monter 25 réputations jusqu'à Exalté.",
	[160] = "Monter 30 réputations jusqu'à Exalté.",
	[161] = "Être exalté auprès de 35 factions.",
	[162] = "Être exalté auprès de 40 factions.",
	-- 4 races par camp sur Forever
	[163] = "Être exalté auprès des 4 races de sa faction.",
	[164] = "Être exalté auprès des 4 races de sa faction.",
	[165] = "Être exalté auprès de Stormwind.",
	[166] = "Être exalté auprès de Forgefer.",
	[167] = "Être exalté auprès des Exilés de Gnomeregan.",
	[168] = "Être exalté auprès de Darnassus.",
	[169] = "Être exalté auprès d'Orgrimmar.",
	[170] = "Être exalté auprès de Thunder Bluff.",
	[171] = "Être exalté auprès de Fossoyeuse.",
	[172] = "Être exalté auprès des Trolls Darkspear.",
	[173] = "Vaincre Onyxia dans le repaire d'Onyxia.",
	[174] = "Vaincre le roi sauvage au sommet d'Hyjal.",
	[175] = "Vaincre Sonya Sanctombre dans les profondeurs des Saisons.",
	[178] = "Apprendre la compétence Apprenti cavalier.",
	[179] = "Apprendre la compétence Compagnon cavalier.",
	[180] = "Obtenir un score de 300 avec la compétence Mains nues.",
	[181] = "Obtenir un score de 300 dans 4 compétences d'armes.",
	[182] = "Equiper un tabard.",
	[183] = "Équiper un objet de qualité supérieure dans chaque emplacement.",
	[184] = "Achever toutes les quêtes d'Hemet Nesingwary dans la vallée de Strangleronce, y compris « Les vertes collines de Strangleronce » et « La chasse au gros gibier ».",
	[185] = "Équiper un objet de qualité épique dans chaque emplacement.",
	[186] = "Obtenir une mascotte.",
	[187] = "Collecter 15 mascottes différentes.",
	[188] = "Collecter 25 mascottes différentes.",
	[189] = "Collecter 50 mascottes différentes.",
	[190] = "Collecter 75 mascottes différentes.",
	[191] = "Achever 1 500 quêtes.",
	[192] = "Achever 2 000 quêtes.",
	[193] = "Achever 3 000 quêtes.",
	[194] = "Apprendre 25 recettes de cuisine.",
	[195] = "Apprendre 50 recettes de cuisine.",
	[196] = "Apprendre 75 recettes de cuisine.",
	[197] = "Apprendre 100 recettes de cuisine.",
	[198] = "Vaincre le mage de sang Thalnos dans le cimetière du Monastère écarlate.",
	[199] = "Vaincre l'arcaniste Doan dans la bibliothèque du Monastère écarlate.",
	[200] = "Vaincre Hérode dans l'armurerie du Monastère écarlate.",
	[201] = "Vaincre la Croisade écarlate dans le Monastère écarlate.",
	[202] = "Vaincre Alzzin le Modeleur dans l'aile est de Hache-Tripes.",
	[203] = "Vaincre Immol'thar dans l'aile ouest de Hache-Tripes.",
	[204] = "Triompher de chaque aile de Hache-Tripes.",
	[205] = "Vaincre Balnazzar dans Stratholme, par la grande porte.",
	[206] = "Triompher des pièges maléfiques qui hantent Stratholme.",
	[207] = "Vaincre le dernier boss du gouffre de Ragefeu ou de la salle des Thanes.",
	[208] = "Accomplir les hauts faits de donjon listés ci-dessous.",
	[209] = "Vaincre le Gardien des reliques dans les excavations des Paluns.",
	[210] = "Vaincre Min'loth le Serpent dans la cité Submergée.",
	[211] = "Vaincre le suzerain Mugg dans le bastion Krol'dok.",
	[212] = "Vaincre Varrox Mornesabot dans le repaire des Noiregueules.",
	[213] = "Gagner sur les îles des Sombrelances.",
	[214] = "Obtenir 100 victoires sur les îles des Sombrelances.",
	[215] = "Capturer 50 drapeaux sur les îles des Sombrelances.",
	[216] = "Attaquer 50 bases sur les îles des Sombrelances.",
	[217] = "Être exalté auprès des chevaucheurs sombrelances.",
	[218] = "Être exalté auprès de la troupe d'intervention de Theramore.",
	[219] = "Aller dans un salon de coiffure et changer de coupe.",
	[220] = "Équiper 10 tabards différents.",
	[221] = "Équiper 25 tabards différents.",
	[222] = "Gagner un jet de cupidité sur un objet de qualité supérieure ou mieux en obtenant 100.",
	[223] = "Gagner un jet de besoin sur un objet de qualité supérieure ou mieux en obtenant 100.",
	[224] = "Rendre 10 livres de bibliothèque.",
	[225] = "Rendre 20 livres de bibliothèque.",
	[226] = "Rendre 25 livres de bibliothèque.",
	[227] = "Rendre 30 livres de bibliothèque.",
	[228] = "Suivre la piste des notes cachées jusqu'au sac de couchage douillet.",
	[229] = "Tuer tous les rares des montagnes d'Alterac.",
	[230] = "Tuer tous les rares des Hautes-terres d'Arathi.",
	[231] = "Tuer tous les rares des Terres ingrates.",
	[232] = "Tuer tous les rares des Terres foudroyées.",
	[233] = "Tuer tous les rares des clairières de Tirisfal.",
	[234] = "Tuer tous les rares de la forêt des Pins-Argentés.",
	[235] = "Tuer tous les rares des Maleterres de l'Ouest.",
	[236] = "Tuer tous les rares des Maleterres de l'Est.",
	[237] = "Tuer tous les rares des contreforts de Hautebrande.",
	[238] = "Tuer tous les rares des Hinterlands.",
	[239] = "Tuer tous les rares de Dun Morogh.",
	[240] = "Tuer tous les rares de la gorge des Vents brûlants.",
	[241] = "Tuer tous les rares des steppes Ardentes.",
	[242] = "Tuer tous les rares de la forêt d'Elwynn.",
	[243] = "Tuer tous les rares du bois de la Pénombre.",
	[244] = "Tuer tous les rares du Loch Modan.",
	[245] = "Tuer tous les rares des Carmines.",
	[246] = "Tuer tous les rares de la vallée de Strangleronce.",
	[247] = "Tuer tous les rares du marais des Chagrins.",
	[248] = "Tuer tous les rares de la marche de l'Ouest.",
	[249] = "Tuer tous les rares des Paluns.",
	[250] = "Tuer tous les rares des Rives Claires.",
	[251] = "Tuer tous les rares de Hurlevent et de Fossoyeuse.",
	[252] = "Tuer tous les rares de Durotar.",
	[253] = "Tuer tous les rares de Mulgore.",
	[254] = "Tuer tous les rares des Tarides.",
	[255] = "Tuer tous les rares de Teldrassil.",
	[256] = "Tuer tous les rares de Sombrivage.",
	[257] = "Tuer tous les rares d'Orneval.",
	[258] = "Tuer tous les rares des Mille pointes.",
	[259] = "Tuer tous les rares des Serres-Rocheuses.",
	[260] = "Tuer tous les rares de Désolace.",
	[261] = "Tuer tous les rares de Féralas.",
	[262] = "Tuer tous les rares du marécage d'Âprefange.",
	[263] = "Tuer tous les rares de Tanaris.",
	[264] = "Tuer tous les rares d'Azshara.",
	[265] = "Tuer tous les rares de Gangrebois.",
	[266] = "Tuer tous les rares du cratère d'Un'Goro.",
	[267] = "Tuer tous les rares de Silithus.",
	[268] = "Tuer tous les rares du Berceau-de-l'Hiver.",
	[269] = "Tuer tous les rares du mont Hyjal.",
	[270] = "Tuer tous les rares de l'île de Zéphras.",
	[271] = "Accomplir les hauts faits de chasseur de têtes des Royaumes de l'Est.",
	[272] = "Accomplir les hauts faits de chasseur de têtes de Kalimdor.",
	[273] = "Accomplir Chasseur de têtes des Royaumes de l'Est, Chasseur de têtes de Kalimdor et Chasseur de têtes de l'île de Zéphras.",
	[274] = "Tuer tous les rares des Mortemines et de leur grotte d'entrée.",
	[275] = "Tuer tous les rares des cavernes des Lamentations et de leur grotte d'entrée.",
	[276] = "Tuer tous les rares du donjon d'Ombrecroc.",
	[277] = "Tuer tous les rares du kraal de Tranchebauge.",
	[278] = "Tuer tous les rares de Gnomeregan.",
	[279] = "Tuer tous les rares du Monastère écarlate.",
	[280] = "Tuer tous les rares de Zul'Farrak.",
	[281] = "Tuer tous les rares de Maraudon.",
	[282] = "Tuer tous les rares du temple Englouti.",
	[283] = "Tuer tous les rares des profondeurs de Rochenoire et de leur entrée.",
	[284] = "Tuer tous les rares du bas du pic Rochenoire.",
	[285] = "Tuer tous les rares du sommet du pic Rochenoire.",
	[286] = "Tuer tous les rares de Hache-Tripes.",
	[287] = "Tuer tous les rares de Stratholme.",
	[288] = "Tuer tous les rares des ruines de Lordaeron.",
	[289] = "Tuer tous les rares de la Cité Submergée.",
	[290] = "Tuer tous les rares du bastion Krol'dok.",
	[291] = "Tuer tous les rares du repaire des Noiregueules.",
	[292] = "Faire apparaître et tuer Lyn l'Ignoré dans la cité de Dalaran.",
	[293] = "Accomplir les hauts faits de chasseur de têtes des donjons.",
	[294] = "Terminer la suite de quêtes qui commence par Une proposition sérieuse et finit par Garder le meilleur pour la fin.",
})

Override(L.CRITERIA_TEXTS, {
	-- Donjons classiques
	[73] = { "Edwin VanCleef" },
	[74] = { "Mutanus le Dévoreur" },
	[75] = { "Archimage Arugal" },
	[77] = { "Aku'mai" },
	[78] = { "Mekgénieur Thermojoncteur" },
	[79] = { "Charlga Trancheflanc" },
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
	[209] = { "Gardien des reliques" },
	[210] = { "Min'loth le Serpent" },
	[211] = { "Suzerain Mugg" },
	[212] = { "Varrox Mornesabot" },
	[154] = { "Une réputation exaltée" },
	[173] = { "Onyxia" },
	[174] = { "Roi sauvage" },
	[175] = { "Sonya Sanctombre" },
	[178] = { "Monte" },
	[179] = { "Monte" },
	[180] = { "Mains nues" },
	[184] = { "Les vertes collines de Strangleronce", "La chasse au gros gibier" },
	[228] = { "Ça doit être ici" },
	[294] = { "Garder le meilleur pour la fin" },
	-- Ailes de donjon
	[198] = { "Mage de sang Thalnos" },
	[199] = { "Arcaniste Doan" },
	[200] = { "Hérode" },
	[202] = { "Alzzin le Modeleur" },
	[203] = { "Immol'thar" },
	[205] = { "Balnazzar" },
	[207] = { "Gouffre de Ragefeu ou salle des Thanes" },
})

-- Noms des rares, ceux du client français (relevés dans le cache de noms
-- de RareScanner, qui les demande au jeu).
Override(L.RARE_NAMES, {
	-- Montagnes d'Alterac
	[14281] = "Jimmy le Saignant",
	[14223] = "Benj le teigneux",
	[14222] = "Araga",
	[14221] = "Gravis Slipknot",
	[2452] = "Grybou",
	[2258] = "Furie-de-pierre",
	[2453] = "Lo'Grosh",
	[2447] = "Narillasanz",
	-- Hautes-terres d'Arathi
	[2600] = "Singer",
	[217836] = "Dent-pointue",
	[2603] = "Kovork",
	[2606] = "Nimar le Pourfendeur",
	[2598] = "Darbel Montrose",
	[2604] = "Molok l’Anéantisseur",
	[2602] = "Ruul Onestone",
	[2605] = "Zalas Witherbark",
	[2779] = "Prince Nazjak",
	[2601] = "Foulbelly",
	[2609] = "Géomancien Dague-de-silex",
	-- Terres ingrates
	[2751] = "Golem de guerre",
	[2850] = "Brèchedent",
	[2753] = "Barnabus",
	[7057] = "Maître des fouilles Shovelphlange",
	[2744] = "Commandant Ombreforge",
	[2749] = "Golem de siège",
	[14224] = "7:XT",
	[2754] = "Anathemus",
	[2752] = "Grondeur",
	[2931] = "Zaricotl",
	-- Terres foudroyées
	[8296] = "Mojo le Tordu",
	[8302] = "Oeil-de-mort",
	[8303] = "Grunter",
	[8300] = "Ravage",
	[8299] = "Ecorchebile",
	[8301] = "Clack le Ravageur",
	[8298] = "Akubar le Prophète",
	[8297] = "Magronos l'Inflexible",
	[8304] = "Dériseffroi",
	-- Clairières de Tirisfal
	[274300] = "Râlefroid",
	[1531] = "Ame égarée",
	[276061] = "Moissonneur décrépit",
	[1936] = "Fermier de Solliden",
	[1533] = "Esprit tourmenté",
	[10356] = "Bayne",
	[271080] = "Ramepeste",
	[1910] = "Muad",
	[10357] = "Ressan le Harceleur",
	[276089] = "Le condamné",
	[1911] = "Deeb",
	[10358] = "Ombre de Fellicent",
	[10359] = "Sri'skulk",
	-- Forêt des Pins-Argentés
	[12431] = "Gorefang",
	[12432] = "Vieux Vile mâchoire",
	[12433] = "Krethis Shadowspinner",
	[2283] = "Régent Ravenclaw",
	[1944] = "Cogneur Poil-Putride",
	[1948] = "Snarlmane",
	-- Maleterres de l'Ouest
	[1847] = "Vilcrin",
	[1848] = "Seigneur Maldazzar",
	[1844] = "Contremaître Marcrid",
	[1850] = "Putridius",
	[1885] = "Forgeron écarlate",
	[1841] = "Bourreau écarlate",
	[1837] = "Juge écarlate",
	[1838] = "Inquisiteur écarlate",
	[1843] = "Contremaître Jerris",
	[1851] = "La Bogue",
	[1839] = "Grand prêtre écarlate",
	[1849] = "Bruissangoisse",
	-- Maleterres de l'Est
	[10827] = "Nécrorateur Selendre",
	[10825] = "Gish l'Immobile",
	[10821] = "Hed'mush le Pourrissant",
	[10826] = "Seigneur Sombrefaux",
	[10822] = "Seigneur de guerre Thresh'jin",
	[10828] = "Grand général Abbendis",
	[10823] = "Zul'Brin Warpbranch",
	[243893] = "Grand général Abbendis",
	[243046] = "Capitaine écarlate",
	[10820] = "Duc Ravarage",
	[16184] = "Surveillant nérubien",
	-- Contreforts de Hautebrande
	[14279] = "Insinueuse",
	[211951] = "Koartul",
	[14280] = "Gros Samras",
	[14278] = "Ro'Bark",
	[14275] = "Tamra Foudrepique",
	[14276] = "Scargil",
	[14277] = "Dame Zephris",
	-- Les Hinterlands
	[8211] = "Vieux Saute-falaise",
	[8219] = "Zul'arek Volaillaîne",
	[8210] = "Trancheserre",
	[8218] = "Flétricoeur le Traqueur",
	[8216] = "Retherokk le Berserker",
	[8212] = "Le Jonc",
	[8215] = "Grimungous",
	[8213] = "Dos-de-fer",
	[8217] = "Mith'rethis l'Enchanteur",
	[221333] = "Funestien",
	-- Dun Morogh
	[208812] = "Jorul",
	[1137] = "Edan le Hurleur",
	[276111] = "Croc-Fantôme",
	[1132] = "Grumeux",
	[8503] = "Gibblewilt",
	[1260] = "Grand-père Arctikus",
	[1130] = "Bjarn",
	[1119] = "Martelléchine",
	-- Gorge des Vents brûlants
	[8279] = "Golem de guerre défaillant",
	[8280] = "Shleipnarr",
	[8277] = "Rekk'tilac",
	[8281] = "Brûlar",
	[8283] = "Maître des esclaves Blackheart",
	[8278] = "Fumar",
	[8282] = "Généralissime Mastrogonde",
	[228721] = "Lieutenant Skarresh",
	[228728] = "Porte-flamme Kelris",
	[228970] = "Galenges",
	[228969] = "Seigneur Gazzran",
	-- Steppes ardentes
	[10077] = "Gueule-du-trépas",
	[9604] = "Gorgon'och",
	[9602] = "Hahk'Zor",
	[10078] = "Lueur terrifiante",
	[8981] = "Ravageur défectueux",
	[8978] = "Thauris Balgarr",
	[8979] = "Gruklash",
	[8976] = "Hematos",
	[10119] = "Volchan",
	-- Forêt d'Elwynn
	[276189] = "Matriarche rebrousse-poil",
	[99] = "Morgaine la rusée",
	[79] = "Narg le Sous-chef",
	[276180] = "Ancien Aileronaugure",
	[61] = "Thuros Doigts-agiles",
	[472] = "Fenouillard",
	[100] = "Gruff Mord-vite",
	-- Bois de la Pénombre
	[521] = "Lupos",
	[574] = "Naraxis",
	[503] = "Seigneur Malathrom",
	[771] = "Commandant Gangretrombe",
	[507] = "Fenros",
	[534] = "Nefaru",
	-- Loch Modan
	[1425] = "Grizlak",
	[210107] = "Rikane",
	[14268] = "Seigneur Condar",
	[14267] = "Emogg le Broyeur",
	[14266] = "Shanda la Tisseuse",
	[1399] = "Magosh",
	[1398] = "Boss Galgosh",
	[2476] = "Grand crocilisque du loch",
	-- Les Carmines
	[14271] = "Chassecôtes",
	[14272] = "Grondefuse",
	[14270] = "Squiddic",
	[14269] = "Aqualon le Chercheur",
	[616] = "Cliqueteuse",
	[214456] = "Dro'zem le Blasphémateur",
	[14273] = "Rochecoeur",
	[947] = "Rohh le silencieux",
	[584] = "Kazon",
	[208845] = "Par'kourc",
	-- Vallée de Strangleronce
	[14487] = "Gluggle",
	[14488] = "Roloch",
	[14491] = "Kurmokk",
	[14492] = "Verifonix",
	[723] = "Boucher Mosh'Ogg",
	[14490] = "Rippa",
	[2541] = "Seigneur Sakrasis",
	[1552] = "Ventrécaille",
	[9046] = "Intendant du Bouclier balafré",
	[11383] = "Grande prêtresse Hai'watna",
	-- Marais des Chagrins
	[1106] = "Cuisinier perdu",
	[763] = "Chef Perdu",
	[14448] = "Rougeronce",
	[14446] = "Fingat",
	[14447] = "Gilmorian",
	[14445] = "Seigneur-capitaine Wyrmak",
	[1063] = "Jade",
	-- Marche de l'Ouest
	[1424] = "Maître Terrassier",
	[519] = "Slark",
	[506] = "Sergent Brashclaw",
	[520] = "Brack",
	[572] = "Leprithus",
	[573] = "Découpeur 4000",
	[462] = "Vultros",
	[208847] = "Le Voleur",
	-- Les Paluns
	[2090] = "Ma'ruk Wyrmscale",
	[14425] = "Ronge-les-os",
	[1112] = "Veuve sanguine",
	[211965] = "Carrodin",
	[14424] = "Bas-boueux",
	[2108] = "Garneg Charskull",
	[1037] = "Maître de guerre Dragonmaw",
	[14433] = "Bouillasseux",
	[1140] = "Matriarche tranchegueules",
	-- Rives Claires
	[256410] = "Reginald Holmsby",
	[256892] = "Kargra l'Aveugle",
	[257034] = "Marrius le Maboul",
	[258032] = "Maître-forge du Crépuscule",
	[259758] = "Gul'gash",
	[263141] = "Scaldaron",
	-- Capitales
	[3581] = "Bête des égouts",
	[204070] = "Soboz",
	-- Durotar
	[208124] = "Raluk",
	[5826] = "Géomaîtresse Mottle",
	[276198] = "Shal'ma",
	[5808] = "Seigneur de guerre Kolkanis",
	[5809] = "Commandant de la garde Zalaphil",
	[5824] = "Capitaine Plate-défense",
	[5823] = "Ecorcheur mortel",
	[5822] = "Gangretisseur Scornn",
	[276194] = "Couve-oeufs terrevent",
	-- Mulgore
	[205382] = "Mokwa",
	[3068] = "Mazzranache",
	[5786] = "Travépieu",
	[276109] = "Grondegroin",
	[5807] = "Le Rake",
	[5787] = "Massacreur Emilgund",
	[5785] = "Sœur Cinglehaine",
	[3056] = "Hurleur fantomatique",
	[276105] = "Héraut de la tempête Ukta",
	[276108] = "Boute-épines Igleg",
	-- Les Tarides
	[5865] = "Dishu",
	[209742] = "Mirage du désert",
	[3270] = "Ancienne mystique Tranchegroin",
	[3470] = "Rathorian",
	[5837] = "Bras-de-pierre",
	[5838] = "Brise-épieu",
	[5841] = "Rochelance",
	[5829] = "Snort la Moqueuse",
	[5836] = "Ingénieur Whirleygig",
	[5835] = "Contremaître Grills",
	[5863] = "Géoprêtresse Gukk'rok",
	[5830] = "Sœur Rathtalon",
	[3295] = "Limace bestiale",
	[5842] = "Takk le Bondisseur",
	[3398] = "Gesharahan",
	[5831] = "Vif-crins",
	[5864] = "Peau-piquante Swinegart",
	[5828] = "Humar le Fier",
	[5849] = "Terrassier Flameforge",
	[3253] = "Moissonneur silithide",
	[5832] = "Grondeterre",
	[5834] = "Azzere la lame céleste",
	[5848] = "Malgin Barleybrew",
	[5859] = "Hagg Taurenbane",
	[5827] = "Brontus",
	[5851] = "Capitaine Gerogg Hammertoe",
	[7895] = "Ambassadeur Ragesang",
	-- Teldrassil
	[14432] = "Threggil",
	[14428] = "Uruson",
	[14431] = "Furie Shelda",
	[209928] = "Mowgh",
	[276099] = "Irevigne",
	[14430] = "Traqueur du crépuscule",
	[276101] = "Noctecri",
	[14429] = "Grimmaw",
	[3535] = "Noiremousse le Fétide",
	-- Sombrivage
	[2175] = "Ombregriffe",
	[2191] = "Licillin",
	[7017] = "Seigneur Salvassio",
	[2186] = "Carnivous le Casseur",
	[7015] = "Flagglemurk le Cruel",
	[2184] = "Dame Moongazer",
	[2192] = "Flamboyeur Radison",
	[2172] = "Matriarche trotteuse",
	[7016] = "Dame Vespira",
	-- Orneval
	[3735] = "Apothicaire Falthis",
	[10559] = "Dame Vespia",
	[10644] = "Hurleur des brumes",
	[10643] = "Moldaileron",
	[10641] = "Brise-branche",
	[10639] = "Joufflu le croquant",
	[3773] = "Akkrilus",
	[10642] = "Eck'alom",
	[10640] = "Chênepatte",
	[3792] = "Chef de meute Frayeloup",
	[12037] = "Ursol'lok",
	[10647] = "Prince Raze",
	-- Mille pointes
	[14426] = "Harb Foulmountain",
	[14427] = "Gibblesnik",
	[5933] = "Achellios le Banni",
	[5934] = "Tranchecoeur",
	[5937] = "Dardeur",
	[4132] = "Ravageur silithide",
	[5935] = "Ferregard l’Invincible",
	-- Les Serres-Rocheuses
	[5932] = "Sous-chef Fouettecroc",
	[5931] = "Contremaître Rigger",
	[4015] = "Patriarche Aile-fière",
	[5928] = "Ailes du désespoir",
	[5930] = "Sœur Riven",
	[5915] = "Frère Ravenoak",
	[4030] = "Ancien vengeur",
	[4066] = "Nal'taszar",
	-- Désolace
	[14225] = "Prince Kellen",
	[14228] = "Glousse",
	[14229] = "Ondulame maudit",
	[14227] = "Hissperak",
	[14226] = "Kaskk",
	-- Féralas
	[5356] = "Grogneur",
	[5352] = "Vieux Grisebedaine",
	[5354] = "Gnarl Frèrefeuilles",
	[5345] = "Tête-de-diamant",
	[5343] = "Dame Szallah",
	[222726] = "Tyran de la ruche",
	[5350] = "Qirot",
	[5347] = "Antilus le Planeur",
	[5346] = "Rugissang le Traqueur",
	[5349] = "Arash-ethis",
	[11498] = "Bâlhafr l'Invaincu",
	[11447] = "Mushgog",
	[11497] = "La Razza",
	-- Marécage d'Âprefange
	[14231] = "Dorgoth le Vagabond",
	[14230] = "Pique-les-yeux",
	[14232] = "Flèche",
	[14233] = "Arrachécaille",
	[4380] = "Veuve de Sombrebrume",
	[14234] = "Hayoc",
	[14237] = "Ver de limon",
	[14235] = "La Pourriture",
	[14236] = "Seigneur Angler",
	[4339] = "Soufresang",
	-- Tanaris
	[8208] = "Brûlepatte meurtrier",
	[222243] = "Zopilote",
	[8199] = "Chef de guerre Krazzilak",
	[8207] = "Grand oiseau de feu",
	[8200] = "Jin'Zallah Porte-sable",
	[8203] = "Kregg Keelhaul",
	[8202] = "Cyclok le Fol",
	[8205] = "Haarka le Féroce",
	[8201] = "Omgorn l'Egaré",
	[8204] = "Soriid le Dévoreur",
	-- Azshara
	[8660] = "L'Evalcharr",
	[6118] = "Fantôme de Varo'then",
	[6651] = "Portier Hurlerage",
	[6648] = "Antilos",
	[6650] = "Général Crocdangoiffe",
	[6649] = "Dame Sesspira",
	[6647] = "Magistère Hawkhelm",
	[6652] = "Maître Trouilleffroi",
	[13896] = "Barbe-d'écailles",
	[6646] = "Monnos l’Ancien",
	-- Gangrebois
	[14339] = "Hurlemort",
	[14344] = "Mongress",
	[14342] = "Ragepatte",
	[14345] = "L'Ongar",
	[14340] = "Alshirr Souffléau",
	[7104] = "Dessecus",
	[7137] = "Immolatus",
	-- Cratère d'Un'Goro
	[6581] = "Matriarche ravasaure",
	[6585] = "Uhk'loc",
	[6582] = "Matriarche Zavas",
	[6583] = "Gruff",
	[6584] = "Roi Mosh",
	-- Silithus
	[14476] = "Krellack",
	[14472] = "Gretheer",
	[14475] = "Rex Ashil",
	[14477] = "Grubthor",
	[14478] = "Ouraganien",
	[14474] = "Zora",
	[224965] = "Khonsu",
	[14473] = "Lapress",
	[14479] = "Seigneur du crépuscule Everun",
	[14471] = "Setis",
	-- Berceau-de-l'Hiver
	[10197] = "Mezzir le hurleur",
	[10196] = "Général Colbatann",
	[10200] = "Rak'shiri",
	[228814] = "Arcterris",
	[10202] = "Azurous",
	[10199] = "Grison Neigepatte",
	[10198] = "Kashoch le ravageur",
	[10201] = "Dame Hederine",
	-- Mont Hyjal
	[255183] = "Jezerelle l'Endiablée",
	[260823] = "Surveillant Myoleth",
	[266901] = "Pexmit",
	[249226] = "Pleureuse de la mort",
	[249238] = "Mastodonte de la Légion",
	[256830] = "Survivant des Aile-bannière",
	[263935] = "Vieux Hurlerouille",
	-- Île de Zéphras
	[255887] = "Slydris",
	[259394] = "Claquerostre le Rapide",
	[256028] = "L'Introuvable",
	[256492] = "Plume-Fougère",
	[259398] = "Soignetrombe Delanea",
	[250936] = "Den'dralass",
	[259388] = "Crin-de-brume",
	[259385] = "Tel'daeor le Parlorage",
	-- Donjons
	[3586] = "Mineur Johnson",
	[596] = "Noble manipulé",
	[599] = "Marisa du'Paige",
	[5912] = "Dragon féérique déviant",
	[3652] = "Trigore le Flagelleur",
	[3672] = "Boahn",
	[211764] = "Gefell",
	[211765] = "Gémela",
	[3872] = "Capitaine Ligemort",
	[4425] = "Chasseur aveugle",
	[4438] = "Lanceur de Tranchebauge",
	[4842] = "Implorateur de la terre Halmgar",
	[6228] = "Ambassadeur Sombrefer",
	[6488] = "Champion mort",
	[6489] = "Echine-de-fer",
	[6490] = "Azshir le Sans-sommeil",
	[10080] = "Sandarr Ravadune",
	[10081] = "Ame en peine poudreuse",
	[10082] = "Zerillis",
	[12237] = "Meshlok le Moissonneur",
	[5399] = "Veyzhak le Cannibale",
	[5400] = "Zekkis",
	[8923] = "Panzor l'Invincible",
	[9024] = "Pyromancien Loregrain",
	[9041] = "Gardien Stilgiss",
	[9042] = "Verek",
	[8924] = "Le Béhémoth",
	[10263] = "Gangregarde ardent",
	[10376] = "Croc cristallin",
	[9217] = "Seigneur magus Pierre-du-pic",
	[9218] = "Seigneur de guerre Pierre-du-pic",
	[9219] = "Boucher Pierre-du-pic",
	[9596] = "Bannok Grimaxe",
	[9718] = "Ghok Bashguud",
	[10509] = "Jed Runewatcher",
	[10899] = "Goraluk Anvilcrack",
	[11467] = "Tsu'zee",
	[14506] = "Seigneur Hel'nurath",
	[10558] = "Hearthsinger Forresten",
	[10393] = "Krân",
	[10809] = "Echine-de-pierre",
	[255699] = "Capitaine de Lordaeron",
	[260468] = "« Pyromancien » Braxton",
	[264172] = "Umbra",
	[264177] = "Gill",
	[262716] = "Kroog",
	[250034] = "Matriarche tissetunnel",
	[269111] = "Gortek l'apprenti",
	[269104] = "Vagabond frôlelune",
	[247032] = "Lyn l'Ignoré",
})
