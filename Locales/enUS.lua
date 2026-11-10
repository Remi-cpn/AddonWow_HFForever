-- Textes de l'interface, en anglais : langue de base, utilisée par tous les
-- clients sauf le français (Locales/frFR.lua remplace ces textes).
-- Une clé absente renvoie son nom entre crochets : visible en jeu, sans
-- erreur Lua.
-- Les noms et descriptions des hauts faits sont dans Locales/Achievements_enUS.lua.
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
L.DATA_ERR_META_TARGET = "achievement %s, criteria %s: target achievement %s does not exist, meta removed"
L.DATA_ERR_STATISTIC = "statistic %s not found in the game"
L.DATA_ERR_MAP = "map %s not found in the game"
L.DATA_ERR_EXPLORE_TOTAL = "no exploration total for map %s (art %s), see Data/ExplorationTotals.lua"
