-- Bouton autour de la minimap, via LibDataBroker (la description du bouton)
-- et LibDBIcon (l'affichage, le glisser autour de la minimap, la sauvegarde
-- de la position). LibDBIcon ajoute aussi l'entrée du compartiment d'addons.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local LDB = LibStub("LibDataBroker-1.1")
local LDBIcon = LibStub("LibDBIcon-1.0")

local MinimapButton = {}
ns.MinimapButton = MinimapButton

-- Nom d'enregistrement auprès de LibDBIcon. Il est aussi affiché tel quel
-- dans le compartiment d'addons.
local BUTTON_NAME = "HF Forever"

local function OnClick(_, mouseButton)
	Log.Debug("MinimapButton: clic", mouseButton)
	if mouseButton == "LeftButton" then
		ns.MainWindow:Toggle()
	end
end

local function OnTooltipShow(tooltip)
	tooltip:AddLine(L.ADDON_TITLE)
	tooltip:AddLine(L.MINIMAP_TOOLTIP_CLICK, 1, 1, 1)
	tooltip:AddLine(L.MINIMAP_TOOLTIP_DRAG, 1, 1, 1)
end

-- À appeler une fois la sauvegarde chargée (ADDON_LOADED), car LibDBIcon
-- lit et écrit directement dans la table des réglages.
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

-- LibDBIcon:Show/Hide n'enregistrent pas l'état, on le sauvegarde nous-mêmes.
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
