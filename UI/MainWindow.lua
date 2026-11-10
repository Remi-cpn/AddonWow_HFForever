-- Fenêtre principale des hauts faits : comportement du cadre défini dans
-- UI/MainWindow.xml (onglet, déplacement, fermeture, en-tête des points,
-- bouton Retour). Comme chez Blizzard, le « Résumé » est la première
-- catégorie de la liste de gauche (UI/CategoryList.lua) : le choisir
-- affiche le panneau Résumé (UI/Summary.lua), les autres catégories affichent la
-- liste des hauts faits (UI/AchievementList.lua).
--
-- Le bouton de minimap, /hff et le clic sur un toast appellent tous
-- MainWindow:Toggle().
local _, ns = ...

local L = ns.L
local Log = ns.Log

local MainWindow = {}
ns.MainWindow = MainWindow

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
	"Interface\\AchievementFrame\\UI-Achievement-Category-Background",
	"Interface\\AchievementFrame\\UI-Achievement-Category-Highlight",
	-- Lignes de hauts faits (UI/AchievementList.xml)
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
	-- Panneau Résumé (UI/Summary.xml)
	"Interface\\AchievementFrame\\UI-Achievement-RecentHeader",
	"Interface\\AchievementFrame\\UI-Achievement-StatusBar-Highlight",
	"Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar",
	-- Recherche (UI/Search.xml et cadre SearchResults)
	"Interface\\FrameGeneral\\UI-Background-Rock",
}
local REQUIRED_ATLASES = {
	"UI-Background-Rock-Brown",
	-- Recherche
	"search-highlight",
	"search-highlight-large",
	"search-iconframe-large",
	"_search-rowbg",
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

-- Affiche le panneau qui correspond à la catégorie choisie à gauche.
local function OnCategoryChanged(categoryID)
	local isSummary = categoryID == ns.CategoryList.SUMMARY_ID
	frame.Summary:SetShown(isSummary)
	frame.Achievements:SetShown(not isSummary)
	if not isSummary then
		ns.AchievementList:ShowCategory(categoryID)
	end
end

-- Appelé une fois au chargement (ADDON_LOADED).
function MainWindow:Init()
	frame = HFFAchievementFrame
	CheckAssets()

	frame.Header.Title:SetText(L.WINDOW_HEADER_TITLE)

	-- Onglet unique : les fonctions PanelTemplates_* de Blizzard lisent frame.Tabs.
	frame.Tabs = { frame.Tab1 }
	frame.Tab1:SetText(L.TAB_ACHIEVEMENTS)
	PanelTemplates_TabResize(frame.Tab1, TAB_PADDING)
	PanelTemplates_SetNumTabs(frame, #frame.Tabs)
	PanelTemplates_SetTab(frame, 1)

	-- Bouton Retour : grisé tant qu'il n'y a pas d'historique de navigation.
	frame.HeaderDetails.Back:SetText(L.BACK)
	frame.HeaderDetails.Back:Disable()

	ns.AchievementList:Init(frame.Achievements)
	ns.Summary:Init(frame.Summary)
	ns.CategoryList:Init(frame.Categories, OnCategoryChanged)

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
		ns.CategoryList:Refresh()
		PlayUISound(SOUNDKIT.ACHIEVEMENT_MENU_OPEN)
	end)
	frame:SetScript("OnHide", function()
		PlayUISound(SOUNDKIT.ACHIEVEMENT_MENU_CLOSE)
	end)
	-- Après le SetScript ci-dessus : la recherche s'accroche à OnHide.
	ns.Search:Init(frame)

	-- Fermeture par Échap : Blizzard ferme les fenêtres listées dans
	-- UISpecialFrames. On ajoute notre nom à la liste, sans rien remplacer.
	table.insert(UISpecialFrames, frame:GetName())

	-- Points et liste à jour quand un haut fait est obtenu fenêtre ouverte.
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

-- Ouvre la fenêtre sur un haut fait : sélectionne sa catégorie, puis déplie
-- sa ligne et la centre (clic sur un toast ou sur un critère de méta).
-- Renvoie false si le haut fait est inconnu.
function MainWindow:ShowAchievement(achievementID)
	local achievement = frame and ns.Registry:GetAchievement(achievementID)
	if not achievement then
		return false
	end
	frame:Show()
	ns.CategoryList:SelectCategory(achievement.category)
	ns.AchievementList:SelectAchievement(achievementID)
	Log.Debug("MainWindow: ouverture sur le haut fait", achievementID)
	return true
end

-- Ouvre ou ferme la fenêtre. achievementID (facultatif) : ouvre la fenêtre
-- sur ce haut fait, voir ShowAchievement.
function MainWindow:Toggle(achievementID)
	if not frame then
		return
	end
	if achievementID and self:ShowAchievement(achievementID) then
		return
	end
	frame:SetShown(not frame:IsShown())
end
