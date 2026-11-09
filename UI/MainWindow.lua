-- Fenêtre principale des hauts faits : comportement du cadre défini dans
-- UI/MainWindow.xml (onglets, déplacement, fermeture, en-tête des points).
-- Le contenu des onglets arrive aux étapes 7b (liste) et 7c (résumé).
--
-- Le bouton de minimap, /hff et le clic sur un toast appellent tous
-- MainWindow:Toggle().
local _, ns = ...

local L = ns.L
local Log = ns.Log

local MainWindow = {}
ns.MainWindow = MainWindow

local TAB_SUMMARY = 1
local TAB_ACHIEVEMENTS = 2
-- Écart entre le texte et les bords d'un onglet (valeur de Blizzard).
local TAB_PADDING = 30

-- Fichiers et atlas utilisés par le cadre : vérifiés au démarrage, car
-- beaucoup d'éléments de retail manquent dans le client Forever.
local REQUIRED_FILES = {
	"Interface\\AchievementFrame\\UI-Achievement-MetalBorder-Left",
	"Interface\\AchievementFrame\\UI-Achievement-MetalBorder-Top",
	"Interface\\AchievementFrame\\UI-Achievement-MetalBorder-Joint",
	"Interface\\AchievementFrame\\UI-Achievement-WoodBorder-Corner",
	"Interface\\AchievementFrame\\UI-Achievement-WoodBorder",
	"Interface\\AchievementFrame\\UI-Achievement-Parchment",
	"Interface\\AchievementFrame\\UI-Achievement-AchievementWatermark",
	"Interface\\AchievementFrame\\UI-Achievement-AchievementBackground",
	"Interface\\AchievementFrame\\UI-Achievement-Header",
	"Interface\\AchievementFrame\\UI-Achievement-TinyShield",
}
local REQUIRED_ATLASES = {
	"UI-Background-Rock-Brown",
}

local frame = nil -- HFFAchievementFrame, défini dans UI/MainWindow.xml

-- Joue un son d'interface de la table SOUNDKIT s'il existe sur Forever
-- (PlaySound(nil) provoquerait une erreur).
local function PlayUISound(soundKit)
	if soundKit then
		PlaySound(soundKit)
	end
end

local function CheckAssets()
	for _, path in ipairs(REQUIRED_FILES) do
		if not GetFileIDFromPath(path) then
			Log.Error(L.WINDOW_FILE_MISSING, path)
		end
	end
	for _, atlas in ipairs(REQUIRED_ATLASES) do
		if not C_Texture.GetAtlasInfo(atlas) then
			Log.Error(L.WINDOW_ATLAS_MISSING, atlas)
		end
	end
end

local function UpdateHeader()
	frame.Header.Points:SetText(ns.API.GetTotalAchievementPoints())
end

local function SelectTab(tabID)
	PanelTemplates_SetTab(frame, tabID)
	frame.Summary:SetShown(tabID == TAB_SUMMARY)
	frame.Achievements:SetShown(tabID == TAB_ACHIEVEMENTS)
	Log.Debug("MainWindow: onglet", tabID)
end

local function SetupTab(tab, text)
	tab:SetText(text)
	PanelTemplates_TabResize(tab, TAB_PADDING)
	tab:SetScript("OnClick", function(self)
		SelectTab(self:GetID())
		PlayUISound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
	end)
end

-- Appelé une fois au chargement (ADDON_LOADED).
function MainWindow:Init()
	frame = HFFAchievementFrame
	CheckAssets()

	frame.Header.Title:SetText(L.WINDOW_HEADER_TITLE)

	-- Onglets : les fonctions PanelTemplates_* de Blizzard lisent frame.Tabs.
	frame.Tabs = { frame.Tab1, frame.Tab2 }
	SetupTab(frame.Tab1, L.TAB_SUMMARY)
	SetupTab(frame.Tab2, L.TAB_ACHIEVEMENTS)
	PanelTemplates_SetNumTabs(frame, #frame.Tabs)
	SelectTab(TAB_SUMMARY)

	-- Déplacement en faisant glisser l'en-tête, comme sur retail.
	frame.Header:RegisterForDrag("LeftButton")
	frame.Header:SetScript("OnDragStart", function()
		frame:StartMoving()
	end)
	frame.Header:SetScript("OnDragStop", function()
		frame:StopMovingOrSizing()
	end)

	frame:SetScript("OnShow", function()
		UpdateHeader()
		PlayUISound(SOUNDKIT.ACHIEVEMENT_MENU_OPEN)
	end)
	frame:SetScript("OnHide", function()
		PlayUISound(SOUNDKIT.ACHIEVEMENT_MENU_CLOSE)
	end)

	-- Fermeture par Échap : Blizzard ferme les fenêtres listées dans
	-- UISpecialFrames. On ajoute notre nom à la liste, sans rien remplacer.
	table.insert(UISpecialFrames, frame:GetName())

	-- Total de points à jour quand un haut fait est obtenu fenêtre ouverte.
	ns.Engine:RegisterListener(function()
		if frame:IsShown() then
			UpdateHeader()
		end
	end)
	Log.Debug("MainWindow: prête")
end

-- Ouvre ou ferme la fenêtre. achievementID (facultatif, clic sur un toast) :
-- ouvre la fenêtre sur ce haut fait. La sélection arrivera à l'étape 7b ;
-- pour l'instant on ouvre l'onglet Hauts faits.
function MainWindow:Toggle(achievementID)
	if not frame then
		return
	end
	if achievementID then
		frame:Show()
		SelectTab(TAB_ACHIEVEMENTS)
		Log.Debug("MainWindow: ouverture sur le haut fait", achievementID)
		return
	end
	frame:SetShown(not frame:IsShown())
end
