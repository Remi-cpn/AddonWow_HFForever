-- Fenêtre des hauts faits (cadre dans UI/MainWindow.xml).
-- Comme chez Blizzard, « Résumé » est la première catégorie de la colonne
-- de gauche : il affiche UI/Summary.lua, les autres catégories affichent
-- UI/AchievementList.lua.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local MainWindow = {}
ns.MainWindow = MainWindow

local TAB_PADDING = 30 -- marge du texte d'un onglet, valeur de Blizzard

-- Vérifiés au chargement : beaucoup de textures de retail manquent dans le
-- client Forever, et une texture absente s'affiche en vert sans erreur.
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
	"Interface\\AchievementFrame\\UI-Achievement-Category-Background",
	"Interface\\AchievementFrame\\UI-Achievement-Category-Highlight",
	-- Lignes de hauts faits
	"Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal",
	"Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated",
	"Interface\\AchievementFrame\\UI-Achievement-Tsunami-Corners",
	"Interface\\AchievementFrame\\UI-Achievement-Borders",
	"Interface\\AchievementFrame\\UI-Achievement-Reward-Background",
	"Interface\\AchievementFrame\\UI-Achievement-PlusMinus",
	"Interface\\AchievementFrame\\UI-Achievement-Bling",
	"Interface\\AchievementFrame\\UI-Achievement-IconFrame",
	"Interface\\AchievementFrame\\UI-Achievement-Shields",
	"Interface\\AchievementFrame\\UI-Achievement-Criteria-Check",
	"Interface\\AchievementFrame\\UI-Achievement-ProgressBar-Border",
	"Interface\\AchievementFrame\\UI-Achievement-Progressive-IconBorder",
	"Interface\\AchievementFrame\\UI-Achievement-Progressive-Shield",
	"Interface\\AchievementFrame\\AccountLevel-AchievementHeader",
	"Interface\\PaperDollInfoFrame\\UI-Character-ReputationBar-Highlight",
	"Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar",
	-- Résumé
	"Interface\\AchievementFrame\\UI-Achievement-RecentHeader",
	"Interface\\AchievementFrame\\UI-Achievement-StatusBar-Highlight",
	"Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar",
	-- Recherche
	"Interface\\FrameGeneral\\UI-Background-Rock",
}
local REQUIRED_ATLASES = {
	"UI-Background-Rock-Brown",
	"search-highlight",
	"search-highlight-large",
	"search-iconframe-large",
	"_search-rowbg",
}

local frame = nil -- HFFAchievementFrame

-- Certains SOUNDKIT de retail n'existent pas sur Forever, et PlaySound(nil)
-- lève une erreur.
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

local function OnCategoryChanged(categoryID)
	local isSummary = categoryID == ns.CategoryList.SUMMARY_ID
	frame.Summary:SetShown(isSummary)
	frame.Achievements:SetShown(not isSummary)
	if not isSummary then
		ns.AchievementList:ShowCategory(categoryID)
	end
end

-- Appelé une fois à ADDON_LOADED.
function MainWindow:Init()
	frame = HFFAchievementFrame
	CheckAssets()

	frame.Header.Title:SetText(L.WINDOW_HEADER_TITLE)

	-- Les fonctions PanelTemplates_* de Blizzard lisent frame.Tabs.
	frame.Tabs = { frame.Tab1 }
	frame.Tab1:SetText(L.TAB_ACHIEVEMENTS)
	PanelTemplates_TabResize(frame.Tab1, TAB_PADDING)
	PanelTemplates_SetNumTabs(frame, #frame.Tabs)
	PanelTemplates_SetTab(frame, 1)

	-- Grisé : il n'y a pas encore d'historique de navigation.
	frame.HeaderDetails.Back:SetText(L.BACK)
	frame.HeaderDetails.Back:Disable()

	ns.AchievementList:Init(frame.Achievements, frame.HeaderDetails.HideCompleted, frame.HeaderDetails.SearchBox)
	ns.Summary:Init(frame.Summary)
	ns.CategoryList:Init(frame.Categories, OnCategoryChanged)

	frame.Header:RegisterForDrag("LeftButton")
	frame.Header:SetScript("OnDragStart", function()
		frame:StartMoving()
	end)
	frame.Header:SetScript("OnDragStop", function()
		frame:StopMovingOrSizing()
	end)

	frame:SetScript("OnShow", function()
		UpdateHeader()
		ns.CategoryList:Refresh()
		PlayUISound(SOUNDKIT.ACHIEVEMENT_MENU_OPEN)
	end)
	frame:SetScript("OnHide", function()
		PlayUISound(SOUNDKIT.ACHIEVEMENT_MENU_CLOSE)
	end)
	-- Après le SetScript("OnHide") : Search s'y accroche avec HookScript.
	ns.Search:Init(frame)

	-- Fermeture par Échap.
	table.insert(UISpecialFrames, frame:GetName())

	ns.Engine:RegisterListener(function()
		if frame:IsShown() then
			UpdateHeader()
			if frame.Achievements:IsShown() then
				ns.AchievementList:Refresh()
			end
			if frame.Summary:IsShown() then
				ns.Summary:Refresh()
			end
		end
	end)
	Log.Debug("MainWindow: prête")
end

function MainWindow:Show()
	if frame then
		frame:Show()
	end
end

-- Ouvre la fenêtre, sélectionne la catégorie du haut fait, puis déplie sa
-- ligne et la centre. false si le haut fait est inconnu.
function MainWindow:ShowAchievement(achievementID)
	local categoryID = frame and ns.API.GetAchievementCategory(achievementID)
	if not categoryID then
		return false
	end
	frame:Show()
	ns.CategoryList:SelectCategory(categoryID)
	ns.AchievementList:SelectAchievement(achievementID)
	Log.Debug("MainWindow: ouverture sur le haut fait", achievementID)
	return true
end

-- Avec un achievementID connu, ouvre la fenêtre sur ce haut fait au lieu
-- de basculer.
function MainWindow:Toggle(achievementID)
	if not frame then
		return
	end
	if achievementID and self:ShowAchievement(achievementID) then
		return
	end
	frame:SetShown(not frame:IsShown())
end
