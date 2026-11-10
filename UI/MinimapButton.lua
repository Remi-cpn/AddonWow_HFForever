-- Bouton de la minimap : LibDataBroker décrit le bouton, LibDBIcon
-- l'affiche, gère le déplacement, sauvegarde la position et ajoute l'entrée
-- du compartiment d'addons.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local LDB = LibStub("LibDataBroker-1.1")
local LDBIcon = LibStub("LibDBIcon-1.0")

local MinimapButton = {}
ns.MinimapButton = MinimapButton

-- Aussi affiché tel quel dans le compartiment d'addons.
local BUTTON_NAME = "HF Forever"

-- Accroché à UIParent et pas au cadre cliqué : dans le compartiment
-- d'addons, ce cadre se ferme aussitôt et emporterait le menu.
local function ShowContextMenu()
	MenuUtil.CreateContextMenu(UIParent, function(_, rootDescription)
		rootDescription:CreateTitle(L.ADDON_TITLE)
		rootDescription:CreateButton(L.MENU_OPEN, function()
			ns.MainWindow:Toggle()
		end)
		rootDescription:CreateButton(L.MENU_OPTIONS, function()
			ns.Options:Open()
		end)
	end)
end

-- LibDBIcon transmet aussi le bouton de souris depuis le compartiment.
local function OnClick(_, mouseButton)
	Log.Debug("MinimapButton: clic", mouseButton)
	if mouseButton == "LeftButton" then
		ns.MainWindow:Toggle()
	elseif mouseButton == "RightButton" then
		ShowContextMenu()
	end
end

local function OnTooltipShow(tooltip)
	tooltip:AddLine(L.ADDON_TITLE)
	tooltip:AddLine(L.MINIMAP_TOOLTIP_CLICK, 1, 1, 1)
	tooltip:AddLine(L.MINIMAP_TOOLTIP_RIGHTCLICK, 1, 1, 1)
end

-- Après Database:Init : LibDBIcon lit et écrit directement dans la table
-- des réglages.
function MinimapButton:Init()
	local dataObject = LDB:NewDataObject(BUTTON_NAME, {
		type = "launcher",
		text = L.ADDON_TITLE,
		icon = ns.icon,
		OnClick = OnClick,
		OnTooltipShow = OnTooltipShow,
	})
	LDBIcon:Register(BUTTON_NAME, dataObject, ns.Database:GetMinimapSettings())
	Log.Debug("MinimapButton: enregistré, masqué =", ns.Database:GetMinimapSettings().hide)
end

function MinimapButton:IsShown()
	return not ns.Database:GetMinimapSettings().hide
end

-- LibDBIcon:Show/Hide n'enregistrent pas l'état.
function MinimapButton:SetShown(show)
	ns.Database:GetMinimapSettings().hide = not show
	if show then
		LDBIcon:Show(BUTTON_NAME)
	else
		LDBIcon:Hide(BUTTON_NAME)
	end
	Log.Debug("MinimapButton: affiché =", show)
end

function MinimapButton:Toggle()
	self:SetShown(not self:IsShown())
	return self:IsShown()
end
