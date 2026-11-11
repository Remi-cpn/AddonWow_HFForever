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
L.DATA_ERR_MAP = "map %s not found in the game"
L.DATA_ERR_EXPLORE_TOTAL = "no exploration total for map %s (art %s), see Data/ExplorationTotals.lua"

-------------------------------------------------------------------------------
-- Catégories et hauts faits, rangés par id (Data/Categories.lua et
-- Data/Achievements.lua). Zones et boss : noms officiels du build Forever
-- (wago.tools, tables UiMap et Achievement en enUS). Noms de hauts faits :
-- le nom officiel WotLK quand le même haut fait existe (docs/WotlkAchievements.md),
-- sinon un nom dans le même style.
-------------------------------------------------------------------------------

-- [id de catégorie] = nom
L.CATEGORY_NAMES = {
	[1] = "General",
	[2] = "Quests",
	[3] = "Exploration",
	[31] = "Eastern Kingdoms",
	[32] = "Kalimdor",
	[6] = "Player vs. Player",
	[61] = "Warsong Gulch",
	[62] = "Arathi Basin",
	[63] = "Alterac Valley",
	[4] = "Professions",
	[5] = "Dungeons",
	[51] = "Classic",
	[52] = "Forever",
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
	-- Exploration (57 n'est pas « World Explorer » de WotLK : sans Outreterre
	-- ni Norfendre)
	[56] = "Explore Zephras Isle",
	[57] = "Explorer",
	-- Métiers. En WotLK, « Master » = 375 et « Grand Master » = 450 : 300 se
	-- dit « Artisan ».
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
	[76] = "Stormwind Stockade",
	[77] = "Blackfathom Deeps",
	[78] = "Gnomeregan",
	[79] = "Razorfen Kraul",
	[80] = "Scarlet Halls",
	[81] = "Scarlet Monastery",
	[82] = "Razorfen Downs",
	[83] = "Uldaman",
	[84] = "Zul'Farrak",
	[85] = "Maraudon",
	[86] = "Sunken Temple",
	[87] = "Blackrock Depths",
	[88] = "Dire Maul",
	[89] = "Lower Blackrock Spire",
	[90] = "Upper Blackrock Spire",
	[91] = "Scholomance",
	[92] = "Stratholme",
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
	[57] = "Explore the Eastern Kingdoms and Kalimdor.",
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
	[76] = "Defeat Bazil Thredd in the Stormwind Stockade.",
	[77] = "Defeat Aku'mai in Blackfathom Deeps.",
	[78] = "Defeat Mekgineer Thermaplugg in Gnomeregan.",
	[79] = "Defeat Charlga Razorflank in Razorfen Kraul.",
	[80] = "Defeat Flameweaver Koegler in the Scarlet Halls.",
	[81] = "Defeat Scarlet Commander Mograine in the Scarlet Monastery.",
	[82] = "Defeat Amnennar the Coldbringer in Razorfen Downs.",
	[83] = "Defeat Archaedas in Uldaman.",
	[84] = "Defeat Chief Ukorz Sandscalp in Zul'Farrak.",
	[85] = "Defeat Princess Theradras in Maraudon.",
	[86] = "Defeat the Shade of Eranikus in the Sunken Temple.",
	[87] = "Defeat Emperor Dagran Thaurissan in Blackrock Depths.",
	[88] = "Defeat King Gordok in Dire Maul.",
	[89] = "Defeat Overlord Wyrmthalak in Lower Blackrock Spire.",
	[90] = "Defeat General Drakkisath in Upper Blackrock Spire.",
	[91] = "Defeat Darkmaster Gandling in Scholomance.",
	[92] = "Defeat Baron Rivendare in Stratholme.",
	-- Donjons de Forever
	[93] = "Defeat Rath'mael in the Ruins of Lordaeron.",
	[94] = "Defeat the Shade of the Archmage in the City of Dalaran.",
	[95] = "Defeat Blazeroar in Alcaz Prison.",
	[96] = "Defeat Nanaya on the Shaper's Terrace.",
	-- Général : banque, argent, montures
	[97] = "Buy 7 additional bank slots.",
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
	[76] = { "Bazil Thredd" },
	[77] = { "Aku'mai" },
	[78] = { "Mekgineer Thermaplugg" },
	[79] = { "Charlga Razorflank" },
	-- Statistique 6786 : Koegler en frFR ; son titre enUS (Whitemane) est un
	-- ancien libellé de Blizzard qui ne correspond plus.
	[80] = { "Flameweaver Koegler" },
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
}
