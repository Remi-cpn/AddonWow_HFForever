-- « Hauts faits (HF Forever) » dans le menu du clic droit sur un joueur :
-- demande la liste de ses hauts faits obtenus (Core/Comm.lua), puis ouvre
-- la fenêtre en consultation (MainWindow:ShowInspection). Sur soi-même,
-- ouvre simplement la fenêtre.
--
-- Menus visés (étiquettes MENU_UNIT_<type> de Blizzard_UnitPopupShared) :
-- portraits (soi, cible, focalisation, groupe, raid), noms du chat (FRIEND),
-- guilde et communautés. Rien pour une créature ni un joueur de l'autre
-- camp (ENEMY_PLAYER n'est pas visé).
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Inspect = {}
ns.Inspect = Inspect

-- Bouclier des points devant le texte du menu, à la taille du texte.
local MENU_ICON_SIZE = 14

local MENU_TAGS = {
	"MENU_UNIT_SELF",
	"MENU_UNIT_PLAYER",
	"MENU_UNIT_TARGET",
	"MENU_UNIT_FOCUS",
	"MENU_UNIT_PARTY",
	"MENU_UNIT_RAID",
	"MENU_UNIT_RAID_PLAYER",
	"MENU_UNIT_FRIEND",
	"MENU_UNIT_GUILD",
	"MENU_UNIT_CHAT_ROSTER",
	"MENU_UNIT_COMMUNITIES_GUILD_MEMBER",
	"MENU_UNIT_COMMUNITIES_WOW_MEMBER",
}

local function IsSecret(value)
	return issecretvalue ~= nil and issecretvalue(value)
end

local function ShortName(name)
	return name:match("^[^-]+") or name
end

local function GetMyName()
	return ns.Comm.FullName(UnitFullName("player"))
end

-- « Nom-Royaume » du joueur du menu, ou nil si ce n'est pas un joueur du
-- même camp. Avec une unité (portraits), on la lit ; sinon (chat, guilde),
-- nom et royaume viennent du menu.
local function GetMenuPlayerName(contextData)
	if type(contextData) ~= "table" then
		return nil
	end
	local unit = contextData.unit
	if unit and not IsSecret(unit) then
		local isMe = UnitIsUnit(unit, "player")
		if IsSecret(isMe) then
			return nil
		end
		if isMe then
			return GetMyName()
		end
		return ns.PlayerTooltip.GetPlayerName(unit)
	end
	return ns.Comm.FullName(contextData.name, contextData.server or contextData.surname)
end

-- Ouvre les hauts faits d'un joueur : les siens directement, ceux d'un autre
-- après sa réponse.
function Inspect:Open(name)
	if name == GetMyName() then
		-- En cours d'inspection : fermer d'abord, pour revenir à soi.
		ns.MainWindow:Hide()
		ns.MainWindow:Show()
		return
	end
	local short = ShortName(name)
	local cached = ns.Comm:HasList(name)
	local sent = ns.Comm:RequestList(name, function(_, completed)
		if completed then
			ns.MainWindow:ShowInspection(name, completed)
		else
			Log.Info(L.INSPECT_NO_REPLY, short)
		end
	end)
	if not sent then
		Log.Info(L.INSPECT_UNAVAILABLE)
	elseif not cached then
		Log.Info(L.INSPECT_REQUESTED, short)
	end
end

local function OnMenu(_, rootDescription, contextData)
	local name = GetMenuPlayerName(contextData)
	if not name then
		return
	end
	rootDescription:CreateDivider()
	local text = ns.ShieldMarkup(MENU_ICON_SIZE) .. " " .. L.MENU_INSPECT
	rootDescription:CreateButton(text, function()
		Inspect:Open(name)
	end)
end

-- Appelé au PLAYER_LOGIN, après Comm:Init.
function Inspect:Init()
	if not (Menu and Menu.ModifyMenu) then
		Log.Debug("Inspect: Menu.ModifyMenu absent")
		return
	end
	for _, tag in ipairs(MENU_TAGS) do
		Menu.ModifyMenu(tag, OnMenu)
	end
end
