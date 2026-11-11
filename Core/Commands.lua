-- Commandes slash : /hff et /hfforever.
--
-- Commandes publiques : aide, minimap, son, scan, etat, et /hff seul.
-- Commandes de développement : debug, test, toast, reset. Elles sont dans le
-- bloc « debug » plus bas (balises de début et de fin du packager) : le
-- packager CurseForge / Wago le transforme en commentaire dans la version
-- publiée, elles n'y existent donc pas. En local (copie du dépôt), les
-- balises ne sont que des commentaires et tout fonctionne.
local _, ns = ...

local L = ns.L
local Log = ns.Log

-- [nom de la sous-commande] = function(argument)
local handlers = {}

-- Rempli dans le bloc debug : reste vide dans la version publiée.
local devHelp = {}

handlers.aide = function()
	Log.Info(L.CMD_HELP_HEADER)
	Log.Info(L.CMD_HELP_OPEN)
	Log.Info(L.CMD_HELP_MINIMAP)
	Log.Info(L.CMD_HELP_SOUND)
	Log.Info(L.CMD_HELP_SCAN)
	Log.Info(L.CMD_HELP_STATUS)
	Log.Info(L.CMD_HELP_HELP)
	if #devHelp > 0 then
		Log.Info(L.CMD_HELP_DEV_HEADER)
		for _, line in ipairs(devHelp) do
			Log.Info(line)
		end
	end
end

-- Active ou coupe le son des toasts.
handlers.son = function()
	local enabled = not ns.Database:IsToastSoundEnabled()
	ns.Database:SetToastSoundEnabled(enabled)
	Log.Info(enabled and L.SOUND_ON or L.SOUND_OFF)
end

-- Force une évaluation de tous les critères.
handlers.scan = function()
	Log.Info(L.SCAN_REQUESTED)
	ns.Engine:RequestEvaluation("commande /hff scan")
end

handlers.minimap = function()
	local shown = ns.MinimapButton:Toggle()
	Log.Info(shown and L.MINIMAP_SHOWN or L.MINIMAP_HIDDEN)
end

handlers.etat = function()
	local db = ns.Database
	local minimap = db:GetMinimapSettings()
	Log.Info(L.STATUS_SCHEMA, db:GetSchemaVersion())
	Log.Info(L.STATUS_DEBUG, db:IsDebug() and L.YES or L.NO)
	Log.Info(L.STATUS_COMPLETED, db:CountCompleted())
	Log.Info(L.STATUS_CHARACTERS, db:GetNumCharacters())
	-- minimapPos reste nil tant que le bouton n'a jamais été déplacé.
	Log.Info(L.STATUS_MINIMAP, minimap.hide and L.NO or L.YES, tostring(minimap.minimapPos))
end

-- Sans argument : ouvrir la fenêtre.
handlers[""] = function()
	ns.MainWindow:Toggle()
end

-- Noms anglais : les deux formes marchent quelle que soit la langue du
-- client ; l'aide montre celle de la langue.
handlers.help = handlers.aide
handlers.sound = handlers.son
handlers.status = handlers.etat

--@debug@
-- ===== Commandes de développement (absentes de la version publiée) =====

devHelp = {
	L.CMD_HELP_DEBUG,
	L.CMD_HELP_TEST,
	L.CMD_HELP_TOAST,
	L.CMD_HELP_RESET,
}

-- Toasts de test : /hff toast [nombre] ou /hff toast resume
handlers.toast = function(argument)
	if argument == "resume" or argument == "summary" then
		ns.Toasts:ShowSummary(7, 70)
		return
	end
	local count = math.max(1, math.min(tonumber(argument) or 1, 10))
	local shown = 0
	for _, categoryID in ipairs(ns.API.GetCategoryList()) do
		for index = 1, ns.API.GetCategoryNumAchievements(categoryID) do
			if shown >= count then
				return
			end
			ns.Toasts:ShowAchievement((ns.API.GetAchievementInfo(categoryID, index)))
			shown = shown + 1
		end
	end
end

-- Efface les hauts faits obtenus puis relance une détection rétroactive.
-- Irréversible : demande « confirmer » en argument.
handlers.reset = function(argument)
	if argument ~= "confirmer" and argument ~= "confirm" then
		Log.Info(L.RESET_CONFIRM_NEEDED)
		return
	end
	ns.Database:ResetAchievements()
	Log.Info(L.RESET_DONE)
	ns.Engine:RequestRetroactiveScan()
end

-- Joint toutes les valeurs (même nil) avec " | " pour les afficher.
local function JoinValues(...)
	return strjoin(" | ", tostringall(...))
end

-- Détail d'une catégorie : chaque haut fait, ses critères et sa série.
local function PrintCategoryDetails(categoryID)
	local API = ns.API
	local total = API.GetCategoryNumAchievements(categoryID)
	for index = 1, total do
		local id = API.GetAchievementInfo(categoryID, index)
		Log.Info(L.TEST_ACHIEVEMENT, JoinValues(API.GetAchievementInfo(categoryID, index)))
		for criteriaIndex = 1, API.GetAchievementNumCriteria(id) do
			Log.Info(L.TEST_CRITERIA, criteriaIndex,
				JoinValues(API.GetAchievementCriteriaInfo(id, criteriaIndex)))
		end
		Log.Info(L.TEST_SERIES, tostring(API.GetPreviousAchievement(id)),
			tostring((API.GetNextAchievement(id))))
	end
end

-- Sans argument : une ligne par catégorie et les totaux.
-- Avec un id de catégorie : le détail de cette catégorie.
handlers.test = function(argument)
	local API = ns.API

	if argument ~= "" then
		local categoryID = tonumber(argument)
		local name, parent = API.GetCategoryInfo(categoryID)
		if not name then
			Log.Info(L.TEST_UNKNOWN_CATEGORY, argument)
			return
		end
		local total, completed = API.GetCategoryNumAchievements(categoryID)
		Log.Info(L.TEST_CATEGORY, categoryID, name, parent, total, completed)
		PrintCategoryDetails(categoryID)
		return
	end

	local categories = API.GetCategoryList()
	Log.Info(L.TEST_CATEGORY_LIST, JoinValues(unpack(categories)))
	for _, categoryID in ipairs(categories) do
		local name, parent = API.GetCategoryInfo(categoryID)
		local total, completed = API.GetCategoryNumAchievements(categoryID)
		Log.Info(L.TEST_CATEGORY, categoryID, name, parent, total, completed)
	end

	local total, completed = API.GetNumCompletedAchievements()
	Log.Info(L.TEST_TOTALS, completed, total, API.GetTotalAchievementPoints())
	local latest = { API.GetLatestCompletedAchievements() }
	Log.Info(L.TEST_LATEST, #latest > 0 and JoinValues(unpack(latest)) or L.TEST_NONE)
end

handlers.debug = function()
	local enabled = not ns.Database:IsDebug()
	ns.Database:SetDebug(enabled)
	Log.Info(enabled and L.DEBUG_ON or L.DEBUG_OFF)
	Log.Debug("Commands: debug =", enabled)
end
--@end-debug@

local function OnSlashCommand(msg)
	-- Premier mot en minuscules = la commande, le reste = l'argument.
	local command, argument = strtrim(msg or ""):match("^(%S*)%s*(.-)$")
	command = command:lower()
	Log.Debug("Commands: reçu", "'" .. command .. "'", "argument", "'" .. argument .. "'")

	local handler = handlers[command]
	if handler then
		handler(argument)
	else
		Log.Info(L.CMD_UNKNOWN, command)
	end
end

-- Globales imposées par WoW pour une commande slash.
SLASH_HFFOREVER1 = "/hff"
SLASH_HFFOREVER2 = "/hfforever"
SlashCmdList.HFFOREVER = OnSlashCommand
