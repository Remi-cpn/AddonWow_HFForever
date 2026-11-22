-- Textes de l'interface, en anglais : langue de base, utilisée par tous les
-- clients sauf le français (Locales/frFR.lua remplace ces textes).
-- Une clé absente renvoie son nom entre crochets : visible en jeu, sans
-- erreur Lua.
-- Les noms et descriptions des hauts faits et des catégories sont en fin de
-- fichier, rangés par id (celui de Data/).
local _, ns = ...

local L = setmetatable({}, {
	__index = function(_, key)
		return "[" .. tostring(key) .. "]"
	end,
})
ns.L = L

L.ADDON_TITLE = "HF Forever"
-- Préfixes des messages du chat (Core/Log.lua). En anglais, pas d'espace
-- avant les deux-points ; en français, une espace.
L.LOG_SEPARATOR = ": "
L.LOG_ERROR_PREFIX = "HF Forever error"
L.LOADED = "version %s loaded. Type /hff help for the list of commands."

-- Commandes slash (Core/Commands.lua)
L.CMD_HELP_HEADER = "Available commands:"
L.CMD_HELP_OPEN = "/hff: opens the achievements window"
L.CMD_HELP_MINIMAP = "/hff minimap: shows or hides the minimap button"
L.CMD_HELP_SOUND = "/hff sound: turns the toast sound on or off"
L.CMD_HELP_SCAN = "/hff scan: runs achievement detection again"
L.CMD_HELP_STATUS = "/hff status: shows the saved data status"
L.CMD_HELP_HELP = "/hff help: shows this help"
L.CMD_HELP_DEV_HEADER = "Development commands (not in the released version):"
L.CMD_HELP_DEBUG = "/hff debug: turns debug mode on or off"
L.CMD_HELP_TEST = "/hff test [category]: data summary, or details of one category (e.g. /hff test 51)"
L.CMD_HELP_TOAST = "/hff toast [count|summary]: shows test toasts"
L.CMD_HELP_RESET = "/hff reset confirm: erases earned achievements and runs detection again"
L.CMD_UNKNOWN = "unknown command: \"%s\". Type /hff help."
L.SOUND_ON = "toast sound on."
L.SOUND_OFF = "toast sound off."
L.TOOLTIP_LABEL = "Achievements:"
L.MENU_INSPECT = "Inspect Achievements"
L.TRACKER_HEADER = "Achievements (HF Forever)"
L.TRACK = "Track"
L.TRACK_TOOLTIP = "Check to track this achievement in the objective tracker."
L.UNTRACK_TOOLTIP = "Uncheck to stop tracking this achievement."
L.TRACK_TOO_MANY = "You can only track %d achievements at a time."
L.TRACK_COMPLETED = "This achievement is already earned."
L.TRACKER_VIEW = "View achievement"
L.TRACKER_STOP = "Stop tracking"
L.INSPECT_REQUESTED = "asking %s for their achievements..."
L.INSPECT_NO_REPLY = "%s did not answer: they need an up-to-date HF Forever."
L.INSPECT_UNAVAILABLE = "the game blocks addon messages right now (combat or instance): try again later."
L.WINDOW_INSPECT_TITLE = "Achievements of %s"
L.SCAN_REQUESTED = "detection started again."
L.RESET_CONFIRM_NEEDED = "this erases all earned achievements. Type /hff reset confirm to continue."
L.RESET_DONE = "achievements erased, new detection in progress..."
L.DEBUG_ON = "debug mode on."
L.DEBUG_OFF = "debug mode off."
L.MINIMAP_SHOWN = "minimap button shown."
L.MINIMAP_HIDDEN = "minimap button hidden. Type /hff minimap to show it again."

-- /hff status
L.STATUS_SCHEMA = "save format version: %d"
L.STATUS_DEBUG = "debug mode: %s"
L.STATUS_COMPLETED = "earned achievements saved: %d"
L.STATUS_CHARACTERS = "characters counted in progress: %d"
L.STATUS_MINIMAP = "minimap button: %s (position: %s)"
L.YES = "yes"
L.NO = "no"

-- /hff test
L.TEST_CATEGORY_LIST = "GetCategoryList: %s"
L.TEST_CATEGORY = "category %s: %s, parent %s, %s achievements, %s earned"
L.TEST_ACHIEVEMENT = "  GetAchievementInfo: %s"
L.TEST_CRITERIA = "    criteria %s: %s"
L.TEST_SERIES = "    series: previous %s, next %s"
L.TEST_TOTALS = "GetNumCompletedAchievements: %s / %s, points: %s"
L.TEST_LATEST = "GetLatestCompletedAchievements: %s"
L.TEST_NONE = "none"
L.TEST_UNKNOWN_CATEGORY = "unknown category \"%s\". Type /hff test for the list."

-- Moteur (Core/Engine.lua)
L.ENGINE_EARNED = "|cffffff00Achievement earned: %s|r (%d points)"
L.ENGINE_RETRO_SUMMARY = "%d already completed achievement(s) detected."
L.ENGINE_CRITERIA_ERROR = "achievement %s, criteria %s: read error (%s)"
L.ENGINE_LISTENER_ERROR = "error in an engine listener: %s"

-- Toasts (UI/Toasts.lua)
L.TOAST_UNLOCKED = "Achievement Earned"
L.TOAST_RETRO_TITLE = "Already Completed"
L.TOAST_RETRO_NAME = "%d achievements detected"
L.TOAST_ATLAS_MISSING = "toast atlas not found: %s"

-- Fenêtre (UI/MainWindow.lua, UI/CategoryList.lua, UI/AchievementList.lua).
-- Quand Blizzard a le même texte, on prend le sien, déjà traduit par le
-- client ; le texte après « or » sert de secours.
L.WINDOW_HEADER_TITLE = "Account Achievement Points"
L.TAB_ACHIEVEMENTS = ACHIEVEMENTS or "Achievements"
L.CATEGORY_SUMMARY = ACHIEVEMENT_SUMMARY_CATEGORY or "Summary"
-- Onglet des notes de version (UI/Changelog.lua)
L.TAB_CHANGELOG = "Patch Notes"
L.CHANGELOG_LATEST = "Latest version"
L.CHANGELOG_VERSION = "Version %s"
L.BACK = BACK or "Back"
L.WINDOW_FILE_MISSING = "window texture not found: %s"
L.WINDOW_ATLAS_MISSING = "window atlas not found: %s"
L.ACCOUNT_WIDE = ACCOUNT_WIDE_ACHIEVEMENT or "Account-wide achievement"
L.ACCOUNT_WIDE_COMPLETED = ACCOUNT_WIDE_ACHIEVEMENT_COMPLETED or "Account-wide achievement earned"
L.EARNED_BY = "Earned by %s"
L.HIDE_COMPLETED = "Hide earned"
L.META_COMPLETED_DATE = ACHIEVEMENT_META_COMPLETED_DATE or "Earned on %s"

-- Résumé (UI/Summary.lua)
L.SUMMARY_LATEST = LATEST_UNLOCKED_ACHIEVEMENTS or "Recent Achievements"
L.SUMMARY_EMPTY = NO_COMPLETED_ACHIEVEMENTS or "No achievements earned"
L.SUMMARY_PROGRESS = ACHIEVEMENT_CATEGORY_PROGRESS or "Progress Overview"
L.SUMMARY_COMPLETED = ACHIEVEMENTS_COMPLETED or "Achievements Earned"
L.SUMMARY_INCOMPLETE = SUMMARY_ACHIEVEMENT_INCOMPLETE or "Suggested Achievement"
L.SUMMARY_INCOMPLETE_TEXT = SUMMARY_ACHIEVEMENT_INCOMPLETE_TEXT or "You have not earned this achievement yet."

-- Recherche (UI/Search.lua)
L.SEARCH_SHOW_ALL = ENCOUNTER_JOURNAL_SHOW_SEARCH_RESULTS or "Show all %d results"
L.SEARCH_RESULTS_TITLE = ENCOUNTER_JOURNAL_SEARCH_RESULTS or "Search results for \"%s\" (%d)"
L.SEARCH_COMPLETED = ACHIEVEMENTFRAME_FILTER_COMPLETED or "Earned"
L.SEARCH_INCOMPLETE = ACHIEVEMENTFRAME_FILTER_INCOMPLETE or "Incomplete"

-- Options (UI/Options.lua)
L.OPTION_MINIMAP = "Minimap button"
L.OPTION_MINIMAP_TOOLTIP = "Shows the HF Forever button around the minimap. The addon compartment entry is always available."
L.OPTION_TOASTS = "Show toasts"
L.OPTION_TOASTS_TOOLTIP = "Shows an on-screen alert when an achievement is earned. The chat message is always shown."
L.OPTION_SOUND = "Toast sound"
L.OPTION_SOUND_TOOLTIP = "Plays the achievement sound with each toast."
L.OPTIONS_IN_COMBAT = "options cannot be opened in combat."

-- Bouton de minimap (UI/MinimapButton.lua)
L.MINIMAP_TOOLTIP_CLICK = "Left-click: open achievements"
L.MINIMAP_TOOLTIP_RIGHTCLICK = "Right-click: menu"
L.MENU_OPEN = "Open achievements"
L.MENU_OPTIONS = "Options"

-- Critères (Core/CriteriaTypes.lua)
L.CRITERIA_LEVEL = "Reach level %d"
L.CRITERIA_EXPLORE = "Explore: %s"
L.CRITERIA_PROFESSION = "%s: %d"
L.CRITERIA_PROFESSION_ANY = "A primary profession: %d"
L.CRITERIA_QUEST = "Quest %d"
L.CRITERIA_WEAPON_SKILLS = "Weapon skills at %d"
L.CRITERIA_TABARD = "Tabard equipped"
L.CRITERIA_TABARDS = "Unique tabards equipped"
L.CRITERIA_BANK_SLOTS = "Bank slots purchased"
L.CRITERIA_HAIRCUT = "New haircut at a Barber Shop"
L.CRITERIA_QUEST_LISTS = {
	libraryBooks = "Library books turned in",
}
L.CRITERIA_PERFECT_ROLL = {
	greed = "Roll 100 on a greed roll",
	need = "Roll 100 on a need roll",
}
L.CRITERIA_RECIPES = "%s recipes known"
-- [what] = texte du critère « collection »
L.CRITERIA_COLLECTION = {
	pets = "Companion pets",
	mounts = "Mounts",
}
-- [qualité minimale] = texte du critère « gearQuality »
L.CRITERIA_GEAR_QUALITY = {
	[3] = "Slots with a superior item or better",
	[4] = "Slots with an epic item",
}

-- [skillLine] = nom du métier
L.PROFESSION_NAMES = {
	[129] = "First Aid",
	[164] = "Blacksmithing",
	[165] = "Leatherworking",
	[171] = "Alchemy",
	[182] = "Herbalism",
	[185] = "Cooking",
	[186] = "Mining",
	[197] = "Tailoring",
	[202] = "Engineering",
	[333] = "Enchanting",
	[356] = "Fishing",
	[393] = "Skinning",
}

-- Erreurs dans les données (Core/Registry.lua). Toujours %s, même pour les nombres.
L.DATA_ERR_CATEGORY_ID = "Data/Categories.lua, entry #%s: missing or invalid id"
L.DATA_ERR_CATEGORY_DUP = "category %s: duplicate id"
L.DATA_ERR_CATEGORY_NAME = "category %s: missing name"
L.DATA_ERR_CATEGORY_PARENT = "category %s: parent category %s does not exist"
L.DATA_ERR_ACH_ID = "Data/Achievements.lua, entry #%s: missing or invalid id"
L.DATA_ERR_ACH_DUP = "achievement %s: duplicate id"
L.DATA_ERR_ACH_FIELD = "achievement %s: missing or invalid field \"%s\""
L.DATA_ERR_ACH_CATEGORY = "achievement %s: category %s does not exist"
L.DATA_ERR_ACH_PREVIOUS = "achievement %s: previous achievement %s does not exist"
L.DATA_ERR_CRITERIA_EMPTY = "achievement %s: no criteria"
L.DATA_ERR_CRITERIA_TYPE = "achievement %s, criteria %s: unknown type \"%s\""
L.DATA_ERR_CRITERIA_FIELD = "achievement %s, criteria %s: missing field \"%s\""
L.DATA_ERR_ICON = "achievement %s: icon not found (%s), fallback icon used"
L.DATA_ERR_CRITERIA_INVALID = "achievement %s, criteria %s: %s"
L.DATA_ERR_CRITERIA_COMBINE = "achievement %s, criteria %s: combine \"%s\" unknown (max or sum)"
L.DATA_ERR_META_TARGET = "achievement %s, criteria %s: target achievement %s does not exist, meta removed"
L.DATA_ERR_STATISTIC = "statistic %s not found in the game"
L.DATA_ERR_COLLECTION = "unknown collection \"%s\" (pets or mounts)"
L.DATA_ERR_RECIPES = "no recipe list for profession %s, see Data/Recipes.lua"
L.DATA_ERR_ENCOUNTERS = "encounters must list at least one encounter ID"
L.DATA_ERR_NATIVE = "native must be { achievement = ID, asset = ID }"
L.DATA_ERR_PERFECT_ROLL = "unknown roll \"%s\" (need or greed)"
L.DATA_ERR_QUEST_LIST = "unknown quest list \"%s\", see Data/Books.lua"
L.DATA_ERR_MAP = "map %s not found in the game"
L.DATA_ERR_EXPLORE_TOTAL = "no exploration total for map %s (art %s), see Data/ExplorationTotals.lua"

-------------------------------------------------------------------------------
-- Catégories et hauts faits, rangés par id (Data/Categories.lua et
-- Data/Achievements.lua). Zones et boss : noms officiels du build Forever
-- (wago.tools, tables UiMap et Achievement en enUS). Noms de hauts faits :
-- les noms officiels de Blizzard quand ils existent, sinon un nom dans le
-- même style.
-------------------------------------------------------------------------------

-- [id de catégorie] = nom
L.CATEGORY_NAMES = {
	[1] = "General",
	[2] = "Quests",
	[3] = "Exploration",
	[31] = "Eastern Kingdoms",
	[32] = "Kalimdor",
	[8] = "Rares",
	[81] = "Eastern Kingdoms",
	[82] = "Kalimdor",
	[83] = "Dungeons",
	[6] = "Player vs. Player",
	[61] = "Warsong Gulch",
	[62] = "Arathi Basin",
	[63] = "Alterac Valley",
	[64] = "Darkspear Islands",
	[4] = "Professions",
	[7] = "Reputation",
	[5] = "Dungeons",
	[51] = "Classic",
	[52] = "Forever",
	[53] = "Raids",
}

-- [id de haut fait] = nom
L.ACHIEVEMENT_NAMES = {
	-- Général
	[1] = "Level 10",
	[2] = "Level 20",
	[3] = "Level 30",
	[4] = "Level 40",
	[5] = "Level 50",
	[6] = "Level 60",
	-- Quêtes
	[7] = "50 Quests Completed",
	[8] = "100 Quests Completed",
	[9] = "250 Quests Completed",
	[10] = "500 Quests Completed",
	[11] = "1000 Quests Completed",
	-- Exploration : Royaumes de l'Est
	[12] = "Explore Alterac Mountains",
	[13] = "Explore Arathi Highlands",
	[14] = "Explore Badlands",
	[15] = "Explore Blasted Lands",
	[16] = "Explore Tirisfal Glades",
	[17] = "Explore Silverpine Forest",
	[18] = "Explore Western Plaguelands",
	[19] = "Explore Eastern Plaguelands",
	[20] = "Explore Hillsbrad Foothills",
	[21] = "Explore The Hinterlands",
	[22] = "Explore Dun Morogh",
	[23] = "Explore Searing Gorge",
	[24] = "Explore Burning Steppes",
	[25] = "Explore Elwynn Forest",
	[26] = "Explore Deadwind Pass",
	[27] = "Explore Duskwood",
	[28] = "Explore Loch Modan",
	[29] = "Explore Redridge Mountains",
	[30] = "Explore Stranglethorn Vale",
	[31] = "Explore Swamp of Sorrows",
	[32] = "Explore Westfall",
	[33] = "Explore Wetlands",
	[34] = "Explore Riverglades",
	[35] = "Explore Eastern Kingdoms",
	-- Exploration : Kalimdor
	[36] = "Explore Durotar",
	[37] = "Explore Mulgore",
	[38] = "Explore The Barrens",
	[39] = "Explore Teldrassil",
	[40] = "Explore Darkshore",
	[41] = "Explore Ashenvale",
	[42] = "Explore Thousand Needles",
	[43] = "Explore Stonetalon Mountains",
	[44] = "Explore Desolace",
	[45] = "Explore Feralas",
	[46] = "Explore Dustwallow Marsh",
	[47] = "Explore Tanaris",
	[48] = "Explore Azshara",
	[49] = "Explore Felwood",
	[50] = "Explore Un'Goro Crater",
	[51] = "Explore Silithus",
	[52] = "Explore Winterspring",
	[53] = "Explore Mount Hyjal",
	[54] = "Explore Shen'dralas",
	[55] = "Explore Kalimdor",
	-- Exploration
	[56] = "Explore Zephras Isle",
	[57] = "Explorer",
	-- Métiers (300 = « Artisan »)
	[58] = "Professional Journeyman",
	[59] = "Professional Expert",
	[60] = "Professional Artisan",
	[61] = "Artisan Alchemist",
	[62] = "Artisan Blacksmith",
	[63] = "Artisan Enchanter",
	[64] = "Artisan Engineer",
	[65] = "Artisan Herbalist",
	[66] = "Artisan Leatherworker",
	[67] = "Artisan Miner",
	[68] = "Artisan Skinner",
	[69] = "Artisan Tailor",
	[70] = "Artisan Cook",
	[71] = "Artisan Fisherman",
	[72] = "Artisan in First Aid",
	-- Donjons classiques
	[73] = "Deadmines",
	[74] = "Wailing Caverns",
	[75] = "Shadowfang Keep",
	[77] = "Blackfathom Deeps",
	[78] = "Gnomeregan",
	[79] = "Razorfen Kraul",
	[81] = "Scarlet Monastery - Cathedral",
	[82] = "Razorfen Downs",
	[83] = "Uldaman",
	[84] = "Zul'Farrak",
	[85] = "Maraudon",
	[86] = "Sunken Temple",
	[87] = "Blackrock Depths",
	[88] = "Dire Maul - North",
	[89] = "Lower Blackrock Spire",
	[90] = "Upper Blackrock Spire",
	[91] = "Scholomance",
	[92] = "Stratholme - Service Entrance",
	-- Donjons de Forever
	[93] = "Ruins of Lordaeron",
	[94] = "City of Dalaran",
	[95] = "Alcaz Prison",
	[96] = "Shaper's Terrace",
	-- Général : banque, argent, montures
	[97] = "Safe Deposit",
	[98] = "Got My Mind On My Money",
	[99] = "Got My Mind On My Money",
	[100] = "Got My Mind On My Money",
	[101] = "Got My Mind On My Money",
	[102] = "Got My Mind On My Money",
	[103] = "The Bread Winner",
	[104] = "Stable Keeper",
	[105] = "Filling Up The Barn",
	[106] = "Leading the Cavalry",
	[107] = "Mountain o' Mounts",
	-- JcJ
	[108] = "An Honorable Kill",
	[109] = "100 Honorable Kills",
	[110] = "500 Honorable Kills",
	[111] = "1000 Honorable Kills",
	[112] = "5000 Honorable Kills",
	[113] = "10000 Honorable Kills",
	[114] = "25000 Honorable Kills",
	[115] = "50000 Honorable Kills",
	[116] = "100000 Honorable Kills",
	[117] = "Duel-icious",
	[118] = "Warsong Gulch Victory",
	[119] = "Warsong Gulch Veteran",
	[120] = "Capture the Flag",
	[121] = "Persistent Defender",
	[122] = "Arathi Basin Victory",
	[123] = "Arathi Basin Veteran",
	[124] = "To The Rescue!",
	[125] = "Me and the Cappin' Makin' It Happen",
	[126] = "Alterac Valley Victory",
	[127] = "Alterac Valley Veteran",
	[128] = "Tower Defense",
	-- Métiers : pêche
	[129] = "25 Fish",
	[130] = "50 Fish",
	[131] = "100 Fish",
	[132] = "250 Fish",
	[133] = "500 Fish",
	[134] = "1000 Fish",
	-- Métiers secondaires
	[135] = "Journeyman Cook",
	[136] = "Expert Cook",
	[137] = "Journeyman Fisherman",
	[138] = "Expert Fisherman",
	[139] = "Journeyman in First Aid",
	[140] = "Expert in First Aid",
	-- JcJ : réputations (141, 143, 145, 147 Horde ; 142, 144, 146, 148 Alliance)
	[141] = "Warsong Outrider",
	[142] = "Silverwing Sentinel",
	[143] = "The Defiler",
	[144] = "Knight of Arathor",
	[145] = "Hero of the Frostwolf Clan",
	[146] = "Hero of the Stormpike Guard",
	[147] = "The Conqueror",
	[148] = "The Justicar",
	-- Réputation
	[149] = "They Love Me In That Tunnel",
	[150] = "The Argent Dawn",
	[151] = "Hydraxian Waterlords",
	[152] = "Brood of Nozdormu",
	[153] = "Hero of the Zandalar Tribe",
	[154] = "Somebody Likes Me",
	[155] = "5 Exalted Reputations",
	[156] = "10 Exalted Reputations",
	[157] = "15 Exalted Reputations",
	[158] = "20 Exalted Reputations",
	[159] = "25 Exalted Reputations",
	[160] = "30 Exalted Reputations",
	[161] = "35 Exalted Reputations",
	[162] = "40 Exalted Reputations",
	[163] = "Ambassador of the Alliance",
	[164] = "Ambassador of the Horde",
	-- Capitales : nom de la faction, comme « The Argent Dawn »
	[165] = "Stormwind",
	[166] = "Ironforge",
	[167] = "Gnomeregan Exiles",
	[168] = "Darnassus",
	[169] = "Orgrimmar",
	[170] = "Thunder Bluff",
	[171] = "Undercity",
	[172] = "Darkspear Trolls",
	-- Raids
	[173] = "Onyxia's Lair",
	[174] = "Hyjal Summit",
	[175] = "Barrow Deeps",
	-- Monte, compétences, équipement, quêtes
	[178] = "Giddy Up!",
	[179] = "Fast and Furious",
	[180] = "Did Somebody Order a Knuckle Sandwich?",
	[181] = "Master of Arms",
	[182] = "Represent",
	[183] = "Superior",
	[184] = "The Green Hills of Stranglethorn",
	[185] = "Epic",
	-- Mascottes
	[186] = "Can I Keep Him?",
	[187] = "Plenty of Pets",
	[188] = "Plethora of Pets",
	[189] = "Shop Smart, Shop Pet...Smart",
	[190] = "Lil' Game Hunter",
	-- Quêtes
	[191] = "1500 Quests Completed",
	[192] = "2000 Quests Completed",
	[193] = "3000 Quests Completed",
	-- Métiers : recettes de cuisine
	[194] = "Lunch Lady",
	[195] = "Short Order Cook",
	[196] = "Chef de Partie",
	[197] = "Sous Chef",
	-- Donjons : ailes (noms du Dungeon Journal) et métas
	[198] = "Scarlet Monastery - Graveyard",
	[199] = "Scarlet Monastery - Library",
	[200] = "Scarlet Monastery - Armory",
	[201] = "Scarlet Monastery",
	[202] = "Dire Maul - East",
	[203] = "Dire Maul - West",
	[204] = "King of Dire Maul",
	[205] = "Stratholme - Main Gate",
	[206] = "Stratholme",
	[207] = "Ragefire Chasm or Hall of Thanes",
	[208] = "Forever Raider",
	-- Donjons de Forever (suite)
	[209] = "Excavation Site: Wetlands",
	[210] = "Drowned City",
	[211] = "Krol'dok Stronghold",
	[212] = "Blackmaw Hold",
	-- JcJ : îles des Sombrelances
	[213] = "Darkspear Islands Victory",
	[214] = "Darkspear Islands Veteran",
	[215] = "Flags Captured",
	[216] = "Bases Assaulted",
	[217] = "Darkspear Raider",
	[218] = "Theramore Expeditionary Force",
	-- Général : coiffeur, tabards
	[219] = "Shave and a Haircut",
	[220] = "Ten Tabards",
	[221] = "Twenty-Five Tabards",
	-- Général : jets de dés
	[222] = "Greedy",
	[223] = "Needy",
	-- Exploration : livres de bibliothèque
	[224] = "Friend of the Library",
	[225] = "Greater Friend of the Library",
	[226] = "Bookworm",
	[227] = "Master Librarian",
	[228] = "Good Night, Sleep Tight",
	-- Exploration : rares
	[229] = "Alterac Mountains Headhunter",
	[230] = "Arathi Highlands Headhunter",
	[231] = "Badlands Headhunter",
	[232] = "Blasted Lands Headhunter",
	[233] = "Tirisfal Glades Headhunter",
	[234] = "Silverpine Forest Headhunter",
	[235] = "Western Plaguelands Headhunter",
	[236] = "Eastern Plaguelands Headhunter",
	[237] = "Hillsbrad Foothills Headhunter",
	[238] = "The Hinterlands Headhunter",
	[239] = "Dun Morogh Headhunter",
	[240] = "Searing Gorge Headhunter",
	[241] = "Burning Steppes Headhunter",
	[242] = "Elwynn Forest Headhunter",
	[243] = "Duskwood Headhunter",
	[244] = "Loch Modan Headhunter",
	[245] = "Redridge Mountains Headhunter",
	[246] = "Stranglethorn Vale Headhunter",
	[247] = "Swamp of Sorrows Headhunter",
	[248] = "Westfall Headhunter",
	[249] = "Wetlands Headhunter",
	[250] = "Riverglades Headhunter",
	[251] = "Capital City Headhunter",
	[252] = "Durotar Headhunter",
	[253] = "Mulgore Headhunter",
	[254] = "The Barrens Headhunter",
	[255] = "Teldrassil Headhunter",
	[256] = "Darkshore Headhunter",
	[257] = "Ashenvale Headhunter",
	[258] = "Thousand Needles Headhunter",
	[259] = "Stonetalon Mountains Headhunter",
	[260] = "Desolace Headhunter",
	[261] = "Feralas Headhunter",
	[262] = "Dustwallow Marsh Headhunter",
	[263] = "Tanaris Headhunter",
	[264] = "Azshara Headhunter",
	[265] = "Felwood Headhunter",
	[266] = "Un'Goro Crater Headhunter",
	[267] = "Silithus Headhunter",
	[268] = "Winterspring Headhunter",
	[269] = "Mount Hyjal Headhunter",
	[270] = "Zephras Isle Headhunter",
	[271] = "Eastern Kingdoms Headhunter",
	[272] = "Kalimdor Headhunter",
	[273] = "Terminator",
	[274] = "Deadmines Headhunter",
	[275] = "Wailing Caverns Headhunter",
	[276] = "Shadowfang Keep Headhunter",
	[277] = "Razorfen Kraul Headhunter",
	[278] = "Gnomeregan Headhunter",
	[279] = "Scarlet Monastery Headhunter",
	[280] = "Zul'Farrak Headhunter",
	[281] = "Maraudon Headhunter",
	[282] = "Sunken Temple Headhunter",
	[283] = "Blackrock Depths Headhunter",
	[284] = "Lower Blackrock Spire Headhunter",
	[285] = "Upper Blackrock Spire Headhunter",
	[286] = "Dire Maul Headhunter",
	[287] = "Stratholme Headhunter",
	[288] = "Ruins of Lordaeron Headhunter",
	[289] = "Drowned City Headhunter",
	[290] = "Krol'dok Stronghold Headhunter",
	[291] = "Blackmaw Hold Headhunter",
	[292] = "City of Dalaran Headhunter",
	[293] = "Dungeon Headhunter",
	-- Quêtes : suite de Valthalak
	[294] = "Lord Valthalak Laid to Rest",
}

-- [id de haut fait] = description
L.ACHIEVEMENT_DESCRIPTIONS = {
	-- Général
	[1] = "Reach level 10.",
	[2] = "Reach level 20.",
	[3] = "Reach level 30.",
	[4] = "Reach level 40.",
	[5] = "Reach level 50.",
	[6] = "Reach level 60.",
	-- Quêtes
	[7] = "Complete 50 quests.",
	[8] = "Complete 100 quests.",
	[9] = "Complete 250 quests.",
	[10] = "Complete 500 quests.",
	[11] = "Complete 1000 quests.",
	-- Exploration : Royaumes de l'Est
	[12] = "Reveal the entire map of Alterac Mountains.",
	[13] = "Reveal the entire map of Arathi Highlands.",
	[14] = "Reveal the entire map of Badlands.",
	[15] = "Reveal the entire map of Blasted Lands.",
	[16] = "Reveal the entire map of Tirisfal Glades.",
	[17] = "Reveal the entire map of Silverpine Forest.",
	[18] = "Reveal the entire map of Western Plaguelands.",
	[19] = "Reveal the entire map of Eastern Plaguelands.",
	[20] = "Reveal the entire map of Hillsbrad Foothills.",
	[21] = "Reveal the entire map of The Hinterlands.",
	[22] = "Reveal the entire map of Dun Morogh.",
	[23] = "Reveal the entire map of Searing Gorge.",
	[24] = "Reveal the entire map of Burning Steppes.",
	[25] = "Reveal the entire map of Elwynn Forest.",
	[26] = "Reveal the entire map of Deadwind Pass.",
	[27] = "Reveal the entire map of Duskwood.",
	[28] = "Reveal the entire map of Loch Modan.",
	[29] = "Reveal the entire map of Redridge Mountains.",
	[30] = "Reveal the entire map of Stranglethorn Vale.",
	[31] = "Reveal the entire map of Swamp of Sorrows.",
	[32] = "Reveal the entire map of Westfall.",
	[33] = "Reveal the entire map of Wetlands.",
	[34] = "Reveal the entire map of Riverglades.",
	[35] = "Explore every zone of the Eastern Kingdoms.",
	-- Exploration : Kalimdor
	[36] = "Reveal the entire map of Durotar.",
	[37] = "Reveal the entire map of Mulgore.",
	[38] = "Reveal the entire map of The Barrens.",
	[39] = "Reveal the entire map of Teldrassil.",
	[40] = "Reveal the entire map of Darkshore.",
	[41] = "Reveal the entire map of Ashenvale.",
	[42] = "Reveal the entire map of Thousand Needles.",
	[43] = "Reveal the entire map of Stonetalon Mountains.",
	[44] = "Reveal the entire map of Desolace.",
	[45] = "Reveal the entire map of Feralas.",
	[46] = "Reveal the entire map of Dustwallow Marsh.",
	[47] = "Reveal the entire map of Tanaris.",
	[48] = "Reveal the entire map of Azshara.",
	[49] = "Reveal the entire map of Felwood.",
	[50] = "Reveal the entire map of Un'Goro Crater.",
	[51] = "Reveal the entire map of Silithus.",
	[52] = "Reveal the entire map of Winterspring.",
	[53] = "Reveal the entire map of Mount Hyjal.",
	[54] = "Reveal the entire map of Shen'dralas.",
	[55] = "Explore every zone of Kalimdor.",
	-- Exploration
	[56] = "Reveal the entire map of Zephras Isle.",
	[57] = "Explore the Eastern Kingdoms, Kalimdor and Zephras Isle.",
	-- Métiers
	[58] = "Reach 150 in a primary profession.",
	[59] = "Reach 225 in a primary profession.",
	[60] = "Reach 300 in a primary profession.",
	[61] = "Reach 300 in Alchemy.",
	[62] = "Reach 300 in Blacksmithing.",
	[63] = "Reach 300 in Enchanting.",
	[64] = "Reach 300 in Engineering.",
	[65] = "Reach 300 in Herbalism.",
	[66] = "Reach 300 in Leatherworking.",
	[67] = "Reach 300 in Mining.",
	[68] = "Reach 300 in Skinning.",
	[69] = "Reach 300 in Tailoring.",
	[70] = "Reach 300 in Cooking.",
	[71] = "Reach 300 in Fishing.",
	[72] = "Reach 300 in First Aid.",
	-- Donjons classiques
	[73] = "Defeat Edwin VanCleef in the Deadmines.",
	[74] = "Defeat Mutanus the Devourer in the Wailing Caverns.",
	[75] = "Defeat Archmage Arugal in Shadowfang Keep.",
	[77] = "Defeat Aku'mai in Blackfathom Deeps.",
	[78] = "Defeat Mekgineer Thermaplugg in Gnomeregan.",
	[79] = "Defeat Charlga Razorflank in Razorfen Kraul.",
	[81] = "Defeat Scarlet Commander Mograine in the Scarlet Monastery Cathedral.",
	[82] = "Defeat Amnennar the Coldbringer in Razorfen Downs.",
	[83] = "Defeat Archaedas in Uldaman.",
	[84] = "Defeat Chief Ukorz Sandscalp in Zul'Farrak.",
	[85] = "Defeat Princess Theradras in Maraudon.",
	[86] = "Defeat the Shade of Eranikus in the Sunken Temple.",
	[87] = "Defeat Emperor Dagran Thaurissan in Blackrock Depths.",
	[88] = "Defeat King Gordok in Dire Maul North.",
	[89] = "Defeat Overlord Wyrmthalak in Lower Blackrock Spire.",
	[90] = "Defeat General Drakkisath in Upper Blackrock Spire.",
	[91] = "Defeat Darkmaster Gandling in Scholomance.",
	[92] = "Defeat Baron Rivendare in Stratholme, through the Service Entrance.",
	-- Donjons de Forever
	[93] = "Defeat Rath'mael in the Ruins of Lordaeron.",
	[94] = "Defeat the Shade of the Archmage in the City of Dalaran.",
	[95] = "Defeat Blazeroar in Alcaz Prison.",
	[96] = "Defeat Nanaya on the Shaper's Terrace.",
	-- Général : banque, argent, montures
	[97] = "Buy all 8 bank bag slots.",
	[98] = "Loot 100 gold.",
	[99] = "Loot 1,000 gold.",
	[100] = "Loot 5,000 gold.",
	[101] = "Loot 10,000 gold.",
	[102] = "Loot 25,000 gold.",
	[103] = "Make 10,000 gold from quest rewards.",
	[104] = "Obtain 10 mounts.",
	[105] = "Obtain 25 mounts.",
	[106] = "Obtain 50 mounts.",
	[107] = "Obtain 100 mounts.",
	-- JcJ
	[108] = "Achieve an honorable kill.",
	[109] = "Get 100 honorable kills.",
	[110] = "Get 500 honorable kills.",
	[111] = "Get 1000 honorable kills.",
	[112] = "Get 5000 honorable kills.",
	[113] = "Get 10000 honorable kills.",
	[114] = "Get 25000 honorable kills.",
	[115] = "Get 50000 honorable kills.",
	[116] = "Get 100000 honorable kills.",
	[117] = "Win a duel against another player.",
	[118] = "Win Warsong Gulch.",
	[119] = "Complete 100 victories in Warsong Gulch.",
	[120] = "Personally carry and capture the flag in Warsong Gulch.",
	[121] = "Return 50 flags as a defender in Warsong Gulch.",
	[122] = "Win Arathi Basin.",
	[123] = "Complete 100 victories in Arathi Basin.",
	[124] = "Come to the defense of a base in Arathi Basin 50 times by recapping the flag.",
	[125] = "Take 50 flags in Arathi Basin.",
	[126] = "Win Alterac Valley.",
	[127] = "Complete 100 victories in Alterac Valley.",
	[128] = "Defend 50 towers in Alterac Valley.",
	-- Métiers : pêche
	[129] = "Fish up 25 items.",
	[130] = "Fish up 50 items.",
	[131] = "Fish up 100 items.",
	[132] = "Fish up 250 items.",
	[133] = "Fish up 500 items.",
	[134] = "Fish up 1000 items.",
	-- Métiers secondaires
	[135] = "Become a Journeyman Cook.",
	[136] = "Become an Expert Cook.",
	[137] = "Become a Journeyman Fisherman.",
	[138] = "Become an Expert Fisherman.",
	[139] = "Become a Journeyman in first aid.",
	[140] = "Become an Expert in first aid.",
	-- JcJ : réputations
	[141] = "Gain exalted reputation with the Warsong Outriders.",
	[142] = "Gain exalted reputation with the Silverwing Sentinels.",
	[143] = "Gain exalted reputation with The Forsaken Defilers.",
	[144] = "Gain exalted reputation with The League of Arathor.",
	[145] = "Gain exalted reputation with the Frostwolf Clan.",
	[146] = "Gain exalted reputation with the Stormpike Guard.",
	[147] = "Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.",
	[148] = "Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.",
	-- Réputation
	[149] = "Earn Exalted status with Timbermaw Hold.",
	[150] = "Earn Exalted status with the Argent Dawn.",
	[151] = "Earn Exalted status with the Hydraxian Waterlords.",
	[152] = "Earn Exalted status with the Brood of Nozdormu.",
	[153] = "Earn exalted status with the Zandalar Tribe.",
	[154] = "Raise a reputation to Exalted.",
	[155] = "Raise 5 reputations to Exalted.",
	[156] = "Raise 10 reputations to Exalted.",
	[157] = "Raise 15 reputations to Exalted.",
	[158] = "Raise 20 reputations to Exalted.",
	[159] = "Raise 25 reputations to Exalted.",
	[160] = "Raise 30 reputations to Exalted.",
	[161] = "Raise 35 reputations to Exalted.",
	[162] = "Raise 40 reputations to Exalted.",
	-- 4 races par camp sur Forever
	[163] = "Earn Exalted reputation with all four Alliance races.",
	[164] = "Earn Exalted reputation with all four Horde races.",
	[165] = "Earn Exalted status with Stormwind.",
	[166] = "Earn Exalted status with Ironforge.",
	[167] = "Earn Exalted status with the Gnomeregan Exiles.",
	[168] = "Earn Exalted status with Darnassus.",
	[169] = "Earn Exalted status with Orgrimmar.",
	[170] = "Earn Exalted status with Thunder Bluff.",
	[171] = "Earn Exalted status with Undercity.",
	[172] = "Earn Exalted status with the Darkspear Trolls.",
	[173] = "Defeat Onyxia in Onyxia's Lair.",
	[174] = "Defeat the Wild King in Hyjal Summit.",
	[175] = "Defeat Sonya Darkhallow in the Barrow Deeps.",
	[178] = "Learn the apprentice riding skill.",
	[179] = "Learn the journeyman riding skill.",
	[180] = "Raise your unarmed skill to 300.",
	[181] = "Raise four weapon skills to 300.",
	[182] = "Equip a tabard.",
	[183] = "Equip a superior item in every slot.",
	[184] = "Complete all of Hemet Nesingwary quests in Stranglethorn Vale up to and including The Green Hills of Stranglethorn and Big Game Hunter.",
	[185] = "Equip an epic item in every slot.",
	[186] = "Obtain a companion pet.",
	[187] = "Collect 15 unique companion pets.",
	[188] = "Collect 25 unique companion pets.",
	[189] = "Collect 50 unique companion pets.",
	[190] = "Collect 75 unique companion pets.",
	[191] = "Complete 1500 quests.",
	[192] = "Complete 2000 quests.",
	[193] = "Complete 3000 quests.",
	[194] = "Learn 25 cooking recipes.",
	[195] = "Learn 50 cooking recipes.",
	[196] = "Learn 75 cooking recipes.",
	[197] = "Learn 100 cooking recipes.",
	[198] = "Defeat Bloodmage Thalnos in the Scarlet Monastery Graveyard.",
	[199] = "Defeat Arcanist Doan in the Scarlet Monastery Library.",
	[200] = "Defeat Herod in the Scarlet Monastery Armory.",
	[201] = "Defeat the Scarlet Crusade within the Scarlet Monastery.",
	[202] = "Defeat Alzzin the Wildshaper in Dire Maul East.",
	[203] = "Defeat Immol'thar in Dire Maul West.",
	[204] = "Defeat each wing of Dire Maul.",
	[205] = "Defeat Balnazzar in Stratholme, through the Main Gate.",
	[206] = "Defeat the evil masterminds inhabiting Stratholme.",
	[207] = "Defeat the final boss of Ragefire Chasm or the Hall of Thanes.",
	[208] = "Complete the dungeon achievements listed below.",
	[209] = "Defeat the Relic Guardian in the Excavation Site: Wetlands.",
	[210] = "Defeat Min'loth the Serpent in the Drowned City.",
	[211] = "Defeat Overlord Mugg in Krol'dok Stronghold.",
	[212] = "Defeat Varrox Bleakhoof in Blackmaw Hold.",
	[213] = "Win the Darkspear Islands.",
	[214] = "Complete 100 victories in the Darkspear Islands.",
	[215] = "Capture 50 flags in the Darkspear Islands.",
	[216] = "Assault 50 bases in the Darkspear Islands.",
	[217] = "Gain exalted reputation with the Darkspear Raiders.",
	[218] = "Gain exalted reputation with the Theramore Expeditionary Force.",
	[219] = "Visit a Barber Shop and get your hair cut.",
	[220] = "Equip 10 unique tabards.",
	[221] = "Equip 25 unique tabards.",
	[222] = "Win a greed roll on a superior or better item by rolling 100.",
	[223] = "Win a need roll on a superior or better item by rolling 100.",
	[224] = "Turn in 10 library books.",
	[225] = "Turn in 20 library books.",
	[226] = "Turn in 25 library books.",
	[227] = "Turn in 30 library books.",
	[228] = "Follow the trail of hidden notes to the Cozy Sleeping Bag.",
	[229] = "Kill every rare in Alterac Mountains.",
	[230] = "Kill every rare in Arathi Highlands.",
	[231] = "Kill every rare in the Badlands.",
	[232] = "Kill every rare in the Blasted Lands.",
	[233] = "Kill every rare in Tirisfal Glades.",
	[234] = "Kill every rare in Silverpine Forest.",
	[235] = "Kill every rare in the Western Plaguelands.",
	[236] = "Kill every rare in the Eastern Plaguelands.",
	[237] = "Kill every rare in Hillsbrad Foothills.",
	[238] = "Kill every rare in The Hinterlands.",
	[239] = "Kill every rare in Dun Morogh.",
	[240] = "Kill every rare in Searing Gorge.",
	[241] = "Kill every rare in Burning Steppes.",
	[242] = "Kill every rare in Elwynn Forest.",
	[243] = "Kill every rare in Duskwood.",
	[244] = "Kill every rare in Loch Modan.",
	[245] = "Kill every rare in Redridge Mountains.",
	[246] = "Kill every rare in Stranglethorn Vale.",
	[247] = "Kill every rare in Swamp of Sorrows.",
	[248] = "Kill every rare in Westfall.",
	[249] = "Kill every rare in the Wetlands.",
	[250] = "Kill every rare in Riverglades.",
	[251] = "Kill every rare in Stormwind City and Undercity.",
	[252] = "Kill every rare in Durotar.",
	[253] = "Kill every rare in Mulgore.",
	[254] = "Kill every rare in The Barrens.",
	[255] = "Kill every rare in Teldrassil.",
	[256] = "Kill every rare in Darkshore.",
	[257] = "Kill every rare in Ashenvale.",
	[258] = "Kill every rare in Thousand Needles.",
	[259] = "Kill every rare in Stonetalon Mountains.",
	[260] = "Kill every rare in Desolace.",
	[261] = "Kill every rare in Feralas.",
	[262] = "Kill every rare in Dustwallow Marsh.",
	[263] = "Kill every rare in Tanaris.",
	[264] = "Kill every rare in Azshara.",
	[265] = "Kill every rare in Felwood.",
	[266] = "Kill every rare in Un'Goro Crater.",
	[267] = "Kill every rare in Silithus.",
	[268] = "Kill every rare in Winterspring.",
	[269] = "Kill every rare in Mount Hyjal.",
	[270] = "Kill every rare on Zephras Isle.",
	[271] = "Complete the Eastern Kingdoms headhunter achievements.",
	[272] = "Complete the Kalimdor headhunter achievements.",
	[273] = "Complete Eastern Kingdoms Headhunter, Kalimdor Headhunter and Zephras Isle Headhunter.",
	[274] = "Kill every rare in the Deadmines and its entrance cave.",
	[275] = "Kill every rare in the Wailing Caverns and its entrance cave.",
	[276] = "Kill every rare in Shadowfang Keep.",
	[277] = "Kill every rare in Razorfen Kraul.",
	[278] = "Kill every rare in Gnomeregan.",
	[279] = "Kill every rare in the Scarlet Monastery.",
	[280] = "Kill every rare in Zul'Farrak.",
	[281] = "Kill every rare in Maraudon.",
	[282] = "Kill every rare in the Sunken Temple.",
	[283] = "Kill every rare in Blackrock Depths and its entrance.",
	[284] = "Kill every rare in Lower Blackrock Spire.",
	[285] = "Kill every rare in Upper Blackrock Spire.",
	[286] = "Kill every rare in Dire Maul.",
	[287] = "Kill every rare in Stratholme.",
	[288] = "Kill every rare in the Ruins of Lordaeron.",
	[289] = "Kill every rare in the Drowned City.",
	[290] = "Kill every rare in Krol'dok Stronghold.",
	[291] = "Kill every rare in Blackmaw Hold.",
	[292] = "Summon and kill Lyn the Ignored in the City of Dalaran.",
	[293] = "Complete the dungeon headhunter achievements.",
	[294] = "Complete the questline beginning with An Earnest Proposition, and ending with Saving the Best for Last.",
}

-- [id de haut fait] = texte de récompense, purement décoratif (titre, objet...).
-- Aucun pour l'instant.
L.ACHIEVEMENT_REWARDS = {}

-- [id de haut fait] = { texte du critère 1, texte du critère 2... }
-- Remplace le nom de la statistique dans la liste des critères (nom du boss).
-- Un critère sans texte ici garde le texte calculé par Core/CriteriaTypes.lua.
L.CRITERIA_TEXTS = {
	-- Donjons classiques
	[73] = { "Edwin VanCleef" },
	[74] = { "Mutanus the Devourer" },
	[75] = { "Archmage Arugal" },
	[77] = { "Aku'mai" },
	[78] = { "Mekgineer Thermaplugg" },
	[79] = { "Charlga Razorflank" },
	[81] = { "Scarlet Commander Mograine" },
	[82] = { "Amnennar the Coldbringer" },
	[83] = { "Archaedas" },
	[84] = { "Chief Ukorz Sandscalp" },
	[85] = { "Princess Theradras" },
	[86] = { "Shade of Eranikus" },
	[87] = { "Emperor Dagran Thaurissan" },
	[88] = { "King Gordok" },
	[89] = { "Overlord Wyrmthalak" },
	[90] = { "General Drakkisath" },
	[91] = { "Darkmaster Gandling" },
	[92] = { "Baron Rivendare" },
	-- Donjons de Forever
	[93] = { "Rath'mael" },
	[94] = { "Shade of the Archmage" },
	[95] = { "Blazeroar" },
	[96] = { "Nanaya" },
	[209] = { "Relic Guardian" },
	[210] = { "Min'loth the Serpent" },
	[211] = { "Overlord Mugg" },
	[212] = { "Varrox Bleakhoof" },
	-- Sans barre (seuil 1) : le nom de la statistique 377 serait affiché
	[154] = { "One Exalted reputation" },
	[173] = { "Onyxia" },
	[174] = { "The Wild King" },
	[175] = { "Sonya Darkhallow" },
	-- Compétences : nom affiché même tant qu'elle n'est pas apprise
	[178] = { "Riding" },
	[179] = { "Riding" },
	[180] = { "Unarmed" },
	[184] = { "The Green Hills of Stranglethorn", "Big Game Hunter" },
	[228] = { "This Must Be The Place" },
	[294] = { "Saving the Best for Last" },
	-- Ailes de donjon
	[198] = { "Bloodmage Thalnos" },
	[199] = { "Arcanist Doan" },
	[200] = { "Herod" },
	[202] = { "Alzzin the Wildshaper" },
	[203] = { "Immol'thar" },
	[205] = { "Balnazzar" },
	[207] = { "Ragefire Chasm or Hall of Thanes" },
}

-- Noms des rares (critère « rare »), rangés par numéro de créature et par
-- carte, dans l'ordre de Data/Achievements.lua. Noms du jeu.
L.RARE_NAMES = {
	-- Montagnes d'Alterac
	[14281] = "Jimmy the Bleeder",
	[14223] = "Cranky Benj",
	[14222] = "Araga",
	[14221] = "Gravis Slipknot",
	[2452] = "Skhowl",
	[2258] = "Stone Fury",
	[2453] = "Lo'Grosh",
	[2447] = "Narillasanz",
	-- Hautes-terres d'Arathi
	[2600] = "Singer",
	[217836] = "Needletooth",
	[2603] = "Kovork",
	[2606] = "Nimar the Slayer",
	[2598] = "Darbel Montrose",
	[2604] = "Molok the Crusher",
	[2602] = "Ruul Onestone",
	[2605] = "Zalas Witherbark",
	[2779] = "Prince Nazjak",
	[2601] = "Foulbelly",
	[2609] = "Geomancer Flintdagger",
	-- Terres ingrates
	[2751] = "War Golem",
	[2850] = "Broken Tooth",
	[2753] = "Barnabus",
	[7057] = "Digmaster Shovelphlange",
	[2744] = "Shadowforge Commander",
	[2749] = "Siege Golem",
	[14224] = "7:XT",
	[2754] = "Anathemus",
	[2752] = "Rumbler",
	[2931] = "Zaricotl",
	-- Terres foudroyées
	[8296] = "Mojo the Twisted",
	[8302] = "Deatheye",
	[8303] = "Grunter",
	[8300] = "Ravage",
	[8299] = "Spiteflayer",
	[8301] = "Clack the Reaver",
	[8298] = "Akubar the Seer",
	[8297] = "Magronos the Unyielding",
	[8304] = "Dreadscorn",
	-- Clairières de Tirisfal
	[274300] = "Coldrasp",
	[1531] = "Lost Soul",
	[276061] = "Decrepit Harvester",
	[1936] = "Farmer Solliden",
	[1533] = "Tormented Spirit",
	[10356] = "Bayne",
	[271080] = "Blightsculler",
	[1910] = "Muad",
	[10357] = "Ressan the Needler",
	[276089] = "The Condemned One",
	[1911] = "Deeb",
	[10358] = "Fellicent's Shade",
	[10359] = "Sri'skulk",
	-- Forêt des Pins-Argentés
	[12431] = "Gorefang",
	[12432] = "Old Vicejaw",
	[12433] = "Krethis Shadowspinner",
	[2283] = "Ravenclaw Regent",
	[1944] = "Rot Hide Bruiser",
	[1948] = "Snarlmane",
	-- Maleterres de l'Ouest
	[1847] = "Foulmane",
	[1848] = "Lord Maldazzar",
	[1844] = "Foreman Marcrid",
	[1850] = "Putridius",
	[1885] = "Scarlet Smith",
	[1841] = "Scarlet Executioner",
	[1837] = "Scarlet Judge",
	[1838] = "Scarlet Interrogator",
	[1843] = "Foreman Jerris",
	[1851] = "The Husk",
	[1839] = "Scarlet High Clerist",
	[1849] = "Dreadwhisper",
	-- Maleterres de l'Est
	[10827] = "Deathspeaker Selendre",
	[10825] = "Gish the Unmoving",
	[10821] = "Hed'mush the Rotting",
	[10826] = "Lord Darkscythe",
	[10822] = "Warlord Thresh'jin",
	[10828] = "High General Abbendis",
	[10823] = "Zul'Brin Warpbranch",
	[243893] = "High General Abbendis",
	[243046] = "Scarlet Captain",
	[10820] = "Duke Ragereaver",
	[16184] = "Nerubian Overseer",
	-- Contreforts de Hautebrande
	[14279] = "Creepthess",
	[211951] = "Koartul",
	[14280] = "Big Samras",
	[14278] = "Ro'Bark",
	[14275] = "Tamra Stormpike",
	[14276] = "Scargil",
	[14277] = "Lady Zephris",
	-- Les Hinterlands
	[8211] = "Old Cliff Jumper",
	[8219] = "Zul'arek Hatefowler",
	[8210] = "Razortalon",
	[8218] = "Witherheart the Stalker",
	[8216] = "Retherokk the Berserker",
	[8212] = "The Reak",
	[8215] = "Grimungous",
	[8213] = "Ironback",
	[8217] = "Mith'rethis the Enchanter",
	[221333] = "Doomkin",
	-- Dun Morogh
	[208812] = "Jorul",
	[1137] = "Edan the Howler",
	[276111] = "Ghostfang",
	[1132] = "Timber",
	[8503] = "Gibblewilt",
	[1260] = "Great Father Arctikus",
	[1130] = "Bjarn",
	[1119] = "Hammerspine",
	-- Gorge des Vents brûlants
	[8279] = "Faulty War Golem",
	[8280] = "Shleipnarr",
	[8277] = "Rekk'tilac",
	[8281] = "Scald",
	[8283] = "Slave Master Blackheart",
	[8278] = "Smoldar",
	[8282] = "Highlord Mastrogonde",
	[228721] = "Lieutenant Skarresh",
	[228728] = "Flamebringer Kelris",
	[228970] = "Galenges",
	[228969] = "Lord Gazzran",
	-- Steppes ardentes
	[10077] = "Deathmaw",
	[9604] = "Gorgon'och",
	[9602] = "Hahk'Zor",
	[10078] = "Terrorspark",
	[8981] = "Malfunctioning Reaver",
	[8978] = "Thauris Balgarr",
	[8979] = "Gruklash",
	[8976] = "Hematos",
	[10119] = "Volchan",
	-- Forêt d'Elwynn
	[276189] = "Matriarch Bristlefur",
	[99] = "Morgaine the Sly",
	[79] = "Narg the Taskmaster",
	[276180] = "Elder Finseer",
	[61] = "Thuros Lightfingers",
	[472] = "Fedfennel",
	[100] = "Gruff Swiftbite",
	-- Bois de la Pénombre
	[521] = "Lupos",
	[574] = "Naraxis",
	[503] = "Lord Malathrom",
	[771] = "Commander Felstrom",
	[507] = "Fenros",
	[534] = "Nefaru",
	-- Loch Modan
	[1425] = "Grizlak",
	[210107] = "Kackle",
	[14268] = "Lord Condar",
	[14267] = "Emogg the Crusher",
	[14266] = "Shanda the Spinner",
	[1399] = "Magosh",
	[1398] = "Boss Galgosh",
	[2476] = "Large Loch Crocolisk",
	-- Les Carmines
	[14271] = "Ribchaser",
	[14272] = "Snarlflare",
	[14270] = "Squiddic",
	[14269] = "Seeker Aqualon",
	[616] = "Chatter",
	[214456] = "Dro'zem the Blasphemous",
	[14273] = "Boulderheart",
	[947] = "Rohh the Silent",
	[584] = "Kazon",
	[208845] = "Par'kourc",
	-- Vallée de Strangleronce
	[14487] = "Gluggle",
	[14488] = "Roloch",
	[14491] = "Kurmokk",
	[14492] = "Verifonix",
	[723] = "Mosh'Ogg Butcher",
	[14490] = "Rippa",
	[2541] = "Lord Sakrasis",
	[1552] = "Scale Belly",
	[9046] = "Scarshield Quartermaster",
	[11383] = "High Priestess Hai'watna",
	-- Marais des Chagrins
	[1106] = "Lost One Cook",
	[763] = "Lost One Chieftain",
	[14448] = "Molt Thorn",
	[14446] = "Fingat",
	[14447] = "Gilmorian",
	[14445] = "Lord Captain Wyrmak",
	[1063] = "Jade",
	-- Marche de l'Ouest
	[1424] = "Master Digger",
	[519] = "Slark",
	[506] = "Sergeant Brashclaw",
	[520] = "Brack",
	[572] = "Leprithus",
	[573] = "Foe Reaper 4000",
	[462] = "Vultros",
	[208847] = "The Snatcher",
	-- Les Paluns
	[2090] = "Ma'ruk Wyrmscale",
	[14425] = "Gnawbone",
	[1112] = "Leech Widow",
	[211965] = "Carrodin",
	[14424] = "Mirelow",
	[2108] = "Garneg Charskull",
	[1037] = "Dragonmaw Battlemaster",
	[14433] = "Sludginn",
	[1140] = "Razormaw Matriarch",
	-- Rives Claires
	[256410] = "Reginald Holmsby",
	[256892] = "Kargra the Blind",
	[257034] = "Mad Marrius",
	[258032] = "Twilight Forgemaster",
	[259758] = "Gul'gash",
	[263141] = "Scaldaron",
	-- Capitales
	[3581] = "Sewer Beast",
	[204070] = "Soboz",
	-- Durotar
	[208124] = "Raluk",
	[5826] = "Geolord Mottle",
	[276198] = "Shal'ma",
	[5808] = "Warlord Kolkanis",
	[5809] = "Watch Commander Zalaphil",
	[5824] = "Captain Flat Tusk",
	[5823] = "Death Flayer",
	[5822] = "Felweaver Scornn",
	[276194] = "Dustwind Eggtender",
	-- Mulgore
	[205382] = "Mokwa",
	[3068] = "Mazzranache",
	[5786] = "Snagglespear",
	[276109] = "Snarlsnout",
	[5807] = "The Rake",
	[5787] = "Enforcer Emilgund",
	[5785] = "Sister Hatelash",
	[3056] = "Ghost Howl",
	[276105] = "Stormherald Ukta",
	[276108] = "Thornstarter Igleg",
	-- Les Tarides
	[5865] = "Dishu",
	[209742] = "Desert Mirage",
	[3270] = "Elder Mystic Razorsnout",
	[3470] = "Rathorian",
	[5837] = "Stonearm",
	[5838] = "Brokespear",
	[5841] = "Rocklance",
	[5829] = "Snort the Heckler",
	[5836] = "Engineer Whirleygig",
	[5835] = "Foreman Grills",
	[5863] = "Geopriest Gukk'rok",
	[5830] = "Sister Rathtalon",
	[3295] = "Sludge Beast",
	[5842] = "Takk the Leaper",
	[3398] = "Gesharahan",
	[5831] = "Swiftmane",
	[5864] = "Swinegart Spearhide",
	[5828] = "Humar the Pridelord",
	[5849] = "Digger Flameforge",
	[3253] = "Silithid Harvester",
	[5832] = "Thunderstomp",
	[5834] = "Azzere the Skyblade",
	[5848] = "Malgin Barleybrew",
	[5859] = "Hagg Taurenbane",
	[5827] = "Brontus",
	[5851] = "Captain Gerogg Hammertoe",
	[7895] = "Ambassador Bloodrage",
	-- Teldrassil
	[14432] = "Threggil",
	[14428] = "Uruson",
	[14431] = "Fury Shelda",
	[209928] = "Mowgh",
	[276099] = "Wrathvine",
	[14430] = "Duskstalker",
	[276101] = "Nightscreech",
	[14429] = "Grimmaw",
	[3535] = "Blackmoss the Fetid",
	-- Sombrivage
	[2175] = "Shadowclaw",
	[2191] = "Licillin",
	[7017] = "Lord Sinslayer",
	[2186] = "Carnivous the Breaker",
	[7015] = "Flagglemurk the Cruel",
	[2184] = "Lady Moongazer",
	[2192] = "Firecaller Radison",
	[2172] = "Strider Clutchmother",
	[7016] = "Lady Vespira",
	-- Orneval
	[3735] = "Apothecary Falthis",
	[10559] = "Lady Vespia",
	[10644] = "Mist Howler",
	[10643] = "Mugglefin",
	[10641] = "Branch Snapper",
	[10639] = "Rorgish Jowl",
	[3773] = "Akkrilus",
	[10642] = "Eck'alom",
	[10640] = "Oakpaw",
	[3792] = "Terrowulf Packlord",
	[12037] = "Ursol'lok",
	[10647] = "Prince Raze",
	-- Mille pointes
	[14426] = "Harb Foulmountain",
	[14427] = "Gibblesnik",
	[5933] = "Achellios the Banished",
	[5934] = "Heartrazor",
	[5937] = "Vile Sting",
	[4132] = "Silithid Ravager",
	[5935] = "Ironeye the Invincible",
	-- Les Serres-Rocheuses
	[5932] = "Taskmaster Whipfang",
	[5931] = "Foreman Rigger",
	[4015] = "Pridewing Patriarch",
	[5928] = "Sorrow Wing",
	[5930] = "Sister Riven",
	[5915] = "Brother Ravenoak",
	[4030] = "Vengeful Ancient",
	[4066] = "Nal'taszar",
	-- Désolace
	[14225] = "Prince Kellen",
	[14228] = "Giggler",
	[14229] = "Accursed Slitherblade",
	[14227] = "Hissperak",
	[14226] = "Kaskk",
	-- Féralas
	[5356] = "Snarler",
	[5352] = "Old Grizzlegut",
	[5354] = "Gnarl Leafbrother",
	[5345] = "Diamond Head",
	[5343] = "Lady Szallah",
	[222726] = "Tyrant of the Hive",
	[5350] = "Qirot",
	[5347] = "Antilus the Soarer",
	[5346] = "Bloodroar the Stalker",
	[5349] = "Arash-ethis",
	[11498] = "Skarr the Unbreakable",
	[11447] = "Mushgog",
	[11497] = "The Razza",
	-- Marécage d'Âprefange
	[14231] = "Drogoth the Roamer",
	[14230] = "Burgle Eye",
	[14232] = "Dart",
	[14233] = "Ripscale",
	[4380] = "Darkmist Widow",
	[14234] = "Hayoc",
	[14237] = "Oozeworm",
	[14235] = "The Rot",
	[14236] = "Lord Angler",
	[4339] = "Brimgore",
	-- Tanaris
	[8208] = "Murderous Blisterpaw",
	[222243] = "Zopilote",
	[8199] = "Warleader Krazzilak",
	[8207] = "Greater Firebird",
	[8200] = "Jin'Zallah the Sandbringer",
	[8203] = "Kregg Keelhaul",
	[8202] = "Cyclok the Mad",
	[8205] = "Haarka the Ravenous",
	[8201] = "Omgorn the Lost",
	[8204] = "Soriid the Devourer",
	-- Azshara
	[8660] = "The Evalcharr",
	[6118] = "Varo'then's Ghost",
	[6651] = "Gatekeeper Rageroar",
	[6648] = "Antilos",
	[6650] = "General Fangferror",
	[6649] = "Lady Sesspira",
	[6647] = "Magister Hawkhelm",
	[6652] = "Master Feardred",
	[13896] = "Scalebeard",
	[6646] = "Monnos the Elder",
	-- Gangrebois
	[14339] = "Death Howl",
	[14344] = "Mongress",
	[14342] = "Ragepaw",
	[14345] = "The Ongar",
	[14340] = "Alshirr Banebreath",
	[7104] = "Dessecus",
	[7137] = "Immolatus",
	-- Cratère d'Un'Goro
	[6581] = "Ravasaur Matriarch",
	[6585] = "Uhk'loc",
	[6582] = "Clutchmother Zavas",
	[6583] = "Gruff",
	[6584] = "King Mosh",
	-- Silithus
	[14476] = "Krellack",
	[14472] = "Gretheer",
	[14475] = "Rex Ashil",
	[14477] = "Grubthor",
	[14478] = "Huricanian",
	[14474] = "Zora",
	[224965] = "Khonsu",
	[14473] = "Lapress",
	[14479] = "Twilight Lord Everun",
	[14471] = "Setis",
	-- Berceau-de-l'Hiver
	[10197] = "Mezzir the Howler",
	[10196] = "General Colbatann",
	[10200] = "Rak'shiri",
	[228814] = "Arcterris",
	[10202] = "Azurous",
	[10199] = "Grizzle Snowpaw",
	[10198] = "Kashoch the Reaver",
	[10201] = "Lady Hederine",
	-- Mont Hyjal
	[255183] = "Jezerelle the Swaying",
	[260823] = "Overseer Myoleth",
	[266901] = "Pexmit",
	[249226] = "Death Wailer",
	[249238] = "Legion Hulk",
	[256830] = "Bannerwing Survivor",
	[263935] = "Old Rusthowl",
	-- Île de Zéphras
	[255887] = "Slydris",
	[259394] = "Snapbeak the Quick",
	[256028] = "The Lost One",
	[256492] = "Fernfeather",
	[259398] = "Galemender Delanea",
	[250936] = "Den'dralass",
	[259388] = "Mystmane",
	[259385] = "Tel'daeor the Stormspeaker",
	-- Donjons
	[3586] = "Miner Johnson",
	[596] = "Brainwashed Noble",
	[599] = "Marisa du'Paige",
	[5912] = "Deviate Faerie Dragon",
	[3652] = "Trigore the Lasher",
	[3672] = "Boahn",
	[211764] = "Gefell",
	[211765] = "Gemela",
	[3872] = "Deathsworn Captain",
	[4425] = "Blind Hunter",
	[4438] = "Razorfen Spearhide",
	[4842] = "Earthcaller Halmgar",
	[6228] = "Dark Iron Ambassador",
	[6488] = "Fallen Champion",
	[6489] = "Ironspine",
	[6490] = "Azshir the Sleepless",
	[10080] = "Sandarr Dunereaver",
	[10081] = "Dustwraith",
	[10082] = "Zerillis",
	[12237] = "Meshlok the Harvester",
	[5399] = "Veyzhak the Cannibal",
	[5400] = "Zekkis",
	[8923] = "Panzor the Invincible",
	[9024] = "Pyromancer Loregrain",
	[9041] = "Warder Stilgiss",
	[9042] = "Verek",
	[8924] = "The Behemoth",
	[10263] = "Burning Felguard",
	[10376] = "Crystal Fang",
	[9217] = "Spirestone Lord Magus",
	[9218] = "Spirestone Battle Lord",
	[9219] = "Spirestone Butcher",
	[9596] = "Bannok Grimaxe",
	[9718] = "Ghok Bashguud",
	[10509] = "Jed Runewatcher",
	[10899] = "Goraluk Anvilcrack",
	[11467] = "Tsu'zee",
	[14506] = "Lord Hel'nurath",
	[10558] = "Hearthsinger Forresten",
	[10393] = "Skul",
	[10809] = "Stonespine",
	[255699] = "Lordaeron Captain",
	[260468] = "\"Pyromancer\" Braxton",
	[264172] = "Umbra",
	[264177] = "Gill",
	[262716] = "Kroog",
	[250034] = "Tunnelweb Matriarch",
	[269111] = "Gortek the Apprentice",
	[269104] = "Moontouched Wanderer",
	[247032] = "Lyn the Ignored",
}
