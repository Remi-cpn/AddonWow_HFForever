-- Commandes slash : /hff et /hfforever.
local _, ns = ...

local L = ns.L
local Log = ns.Log

-- Chaque sous-commande est une fonction rangée dans cette table, comme un
-- tableau de pointeurs de fonctions en C.
local handlers = {}

handlers.aide = function()
	Log.Info(L.CMD_HELP_HEADER)
	Log.Info(L.CMD_HELP_OPEN)
	Log.Info(L.CMD_HELP_DEBUG)
	Log.Info(L.CMD_HELP_MINIMAP)
	Log.Info(L.CMD_HELP_STATUS)
	Log.Info(L.CMD_HELP_HELP)
end

handlers.debug = function()
	local enabled = not ns.Database:IsDebug()
	ns.Database:SetDebug(enabled)
	Log.Info(enabled and L.DEBUG_ON or L.DEBUG_OFF)
	Log.Debug("Commands: debug =", enabled)
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
	-- minimapPos reste nil tant que le bouton n'a jamais été déplacé.
	Log.Info(L.STATUS_MINIMAP, minimap.hide and L.NO or L.YES, tostring(minimap.minimapPos))
end

-- Sans argument : ouvrir la fenêtre.
handlers[""] = function()
	ns.MainWindow:Toggle()
end

local function OnSlashCommand(msg)
	-- Premier mot en minuscules, espaces retirés.
	local command = strtrim(msg or ""):match("^(%S*)"):lower()
	Log.Debug("Commands: reçu", "'" .. command .. "'")

	local handler = handlers[command]
	if handler then
		handler()
	else
		Log.Info(L.CMD_UNKNOWN, command)
	end
end

-- WoW impose ces globales pour déclarer une commande slash.
-- Le nom HFFOREVER est propre à l'addon, il ne remplace rien de Blizzard.
SLASH_HFFOREVER1 = "/hff"
SLASH_HFFOREVER2 = "/hfforever"
SlashCmdList.HFFOREVER = OnSlashCommand
