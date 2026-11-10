-- Panneau Résumé : derniers hauts faits obtenus et progression par catégorie.
-- Clone de la logique de Blizzard_AchievementUI/Mainline (export Forever) :
-- AchievementFrameSummary_UpdateAchievements, _UpdateSummaryProgressBars,
-- AchievementFrameSummaryCategoriesStatusBar_Update,
-- AchievementFrameSummaryAchievement_OnClick / _OnEnter et
-- AchievementComparisonPlayerButton_Saturate / _Desaturate.
-- Les données viennent uniquement de ns.API.
local _, ns = ...

local L = ns.L
local Log = ns.Log
local API = ns.API

local Summary = {}
ns.Summary = Summary

-- Nombre de derniers hauts faits affichés. Blizzard Mainline en affiche 3,
-- le cahier des charges de HF Forever en demande 5.
local MAX_ACHIEVEMENTS = 5

-- Quand moins de MAX_ACHIEVEMENTS hauts faits sont obtenus, les places
-- libres montrent, grisés, les premiers hauts faits non obtenus de cette
-- liste (ACHIEVEMENTUI_DEFAULTSUMMARYACHIEVEMENTS de Blizzard : niveau 10,
-- 50 quêtes, métier à 150...). Équivalents chez nous :
local DEFAULT_ACHIEVEMENTS = {
	1001, -- Niveau 10
	2001, -- 50 quêtes
	4001, -- Un métier principal à 150
	3001, -- Première zone d'exploration
	5002, -- Premier donjon classique
}

-- Barres de catégorie : largeur 234, 2 colonnes séparées de 20, lignes
-- séparées de 10 (positions de Blizzard).
local CATEGORY_COLUMN_GAP = 20
local CATEGORY_ROW_GAP = 10

local RED_BORDER = { 0.7, 0.15, 0.05 }
local BLUE_BORDER = { 0.129, 0.671, 0.875 }
local FLAG_ACCOUNT = 0x00020000
local ACCOUNT_HEADER_FILE = "Interface\\AchievementFrame\\AccountLevel-AchievementHeader"
local SHIELDS_FILE = "Interface\\AchievementFrame\\UI-Achievement-Shields"
local SHIELDS_NOPOINTS_FILE = "Interface\\AchievementFrame\\UI-Achievement-Shields-NoPoints"

local panel = nil       -- HFFAchievementFrame.Summary
local buttons = {}      -- lignes des derniers hauts faits
local categoryBars = {} -- barres de progression par catégorie
local hasAccountHeader = true
local hasNoPointsShield = true

-- [[ Ligne d'un haut fait récent ]]

local Button = {}

function Button:Saturate()
	self.Background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal")
	self.Shield.Points:SetVertexColor(1, 1, 1)
	if self.accountWide then
		self.TitleBar:SetTexture(ACCOUNT_HEADER_FILE)
		self.TitleBar:SetTexCoord(0, 1, 0, 0.375)
		self:SetBackdropBorderColor(unpack(BLUE_BORDER))
		self.saturatedStyle = "account"
	else
		self.TitleBar:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Borders")
		self.TitleBar:SetTexCoord(0, 1, 0.66015625, 0.73828125)
		self:SetBackdropBorderColor(unpack(RED_BORDER))
		self.saturatedStyle = "normal"
	end
	self.Glow:SetVertexColor(1, 1, 1)
	self.Icon.bling:SetVertexColor(1, 1, 1, 1)
	self.Icon.frame:SetVertexColor(1, 1, 1, 1)
	self.Icon.texture:SetVertexColor(1, 1, 1, 1)
	self.Shield.Icon:SetTexCoord(0, 0.5, 0, 0.5)
	self.Label:SetVertexColor(1, 1, 1)
	self.Description:SetTextColor(0, 0, 0, 1)
	self.Description:SetShadowOffset(0, 0)
end

function Button:Desaturate()
	self.saturatedStyle = nil
	self.Background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
	if self.accountWide then
		self.TitleBar:SetTexture(ACCOUNT_HEADER_FILE)
		self.TitleBar:SetTexCoord(0, 1, 0.40625, 0.78125)
	else
		self.TitleBar:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Borders")
		self.TitleBar:SetTexCoord(0, 1, 0.91796875, 0.99609375)
	end
	self.Glow:SetVertexColor(0.22, 0.17, 0.13)
	self.Icon.bling:SetVertexColor(0.6, 0.6, 0.6, 1)
	self.Icon.frame:SetVertexColor(0.75, 0.75, 0.75, 1)
	self.Icon.texture:SetVertexColor(0.55, 0.55, 0.55, 1)
	self.Shield.Icon:SetTexCoord(0.5, 1, 0, 0.5)
	self.Shield.Points:SetVertexColor(0.65, 0.65, 0.65)
	self.Label:SetVertexColor(0.65, 0.65, 0.65)
	self.Description:SetTextColor(1, 1, 1, 1)
	self.Description:SetShadowOffset(1, -1)
	self:SetBackdropBorderColor(0.5, 0.5, 0.5)
end

-- Clic : ouvre le haut fait. Dans une série déjà avancée, ouvre la dernière
-- étape obtenue (AchievementFrameSummaryAchievement_OnClick).
function Button:OnClick()
	local id = self.id
	local nextID, completed = API.GetNextAchievement(id)
	if nextID and completed then
		while nextID and completed do
			local newID
			newID, completed = API.GetNextAchievement(nextID)
			if completed then
				nextID = newID
			end
		end
		id = nextID
	end
	ns.MainWindow:ShowAchievement(id)
end

function Button:OnEnter()
	self.Highlight:Show()
	if self.tooltipTitle then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.tooltipTitle, 1, 1, 1)
		GameTooltip:AddLine(self.tooltip, nil, nil, nil, true)
		GameTooltip:Show()
	end
end

function Button:OnLeave()
	self.Highlight:Hide()
	GameTooltip:Hide()
end

-- Remplit la ligne avec un haut fait. Renvoie completed.
function Button:SetAchievement(achievementID)
	local id, name, points, completed, month, day, year, description, flags, icon = API.GetAchievementInfo(achievementID)
	self.accountWide = hasAccountHeader and bit.band(flags, FLAG_ACCOUNT) == FLAG_ACCOUNT or nil
	self.Label:SetText(name)
	self.Description:SetText(description)
	if points == 0 then
		self.Shield.Points:SetText("")
	else
		self.Shield.Points:SetFontObject(points < 100 and GameFontNormal or GameFontNormalSmall)
		self.Shield.Points:SetText(points)
	end
	if points > 0 or not hasNoPointsShield then
		self.Shield.Icon:SetTexture(SHIELDS_FILE)
	else
		self.Shield.Icon:SetTexture(SHIELDS_NOPOINTS_FILE)
	end
	self.Icon.texture:SetTexture(icon)
	self.id = id
	if completed then
		self.DateCompleted:SetText(FormatShortDate(day, month, year))
	else
		self.DateCompleted:SetText("")
	end
	self:Show()
	return completed
end

local function CreateAchievementButton(index)
	local button = CreateFrame("Button", nil, panel.Achievements, "HFFSummaryAchievementTemplate")
	Mixin(button, Button)
	if index == 1 then
		button:SetPoint("TOPLEFT", panel.Achievements.Header, "BOTTOMLEFT", 18, 2)
		button:SetPoint("TOPRIGHT", panel.Achievements.Header, "BOTTOMRIGHT", -18, 2)
	else
		button:SetPoint("TOPLEFT", buttons[index - 1], "BOTTOMLEFT", 0, 3)
		button:SetPoint("TOPRIGHT", buttons[index - 1], "BOTTOMRIGHT", 0, 3)
	end
	button.TitleBar:SetVertexColor(1, 1, 1, 0.5)
	button.TitleBar:SetAlpha(0.5)
	button:SetScript("OnClick", button.OnClick)
	button:SetScript("OnEnter", button.OnEnter)
	button:SetScript("OnLeave", button.OnLeave)
	button:Desaturate()
	return button
end

-- Derniers hauts faits obtenus, complétés par les hauts faits par défaut
-- grisés (AchievementFrameSummary_UpdateAchievements).
local function UpdateAchievements()
	local latest = { API.GetLatestCompletedAchievements() }
	local nextDefault = 1

	for i = 1, MAX_ACHIEVEMENTS do
		local button = buttons[i]
		if latest[i] then
			button:SetAchievement(latest[i])
			if button.saturatedStyle ~= (button.accountWide and "account" or "normal") then
				button:Saturate()
			end
			button.tooltipTitle = nil
		else
			-- Premier haut fait par défaut pas encore obtenu.
			local shown = false
			while DEFAULT_ACHIEVEMENTS[nextDefault] do
				local id = DEFAULT_ACHIEVEMENTS[nextDefault]
				nextDefault = nextDefault + 1
				if ns.Registry:GetAchievement(id) and not select(4, API.GetAchievementInfo(id)) then
					button:SetAchievement(id)
					button:Desaturate()
					button.tooltipTitle = L.SUMMARY_INCOMPLETE
					button.tooltip = L.SUMMARY_INCOMPLETE_TEXT
					shown = true
					break
				end
			end
			if not shown then
				button:Hide()
			end
		end
	end

	panel.Achievements.EmptyText:SetShown(#latest == 0)
end

-- [[ Progression par catégorie ]]

-- Total et obtenus d'une catégorie, sous-catégories comprises
-- (AchievementFrame_GetCategoryTotalNumAchievements).
local function GetCategoryTotals(categoryID)
	local total, completed = API.GetCategoryNumAchievements(categoryID)
	for _, id in ipairs(API.GetCategoryList()) do
		local _, parent = API.GetCategoryInfo(id)
		if parent == categoryID then
			local childTotal, childCompleted = API.GetCategoryNumAchievements(id)
			total = total + childTotal
			completed = completed + childCompleted
		end
	end
	return total, completed
end

-- Une barre par catégorie de premier niveau, sur 2 colonnes. Une dernière
-- barre seule sur sa ligne est centrée, comme la 11e chez Blizzard.
local function CreateCategoryBars()
	local topLevel = {}
	for _, id in ipairs(API.GetCategoryList()) do
		local _, parent = API.GetCategoryInfo(id)
		if parent == -1 then
			topLevel[#topLevel + 1] = id
		end
	end

	local categories = panel.Categories
	for i, categoryID in ipairs(topLevel) do
		local bar = CreateFrame("StatusBar", nil, categories, "HFFSummaryCategoryTemplate")
		bar.categoryID = categoryID
		bar.Label:SetText((API.GetCategoryInfo(categoryID)))
		bar.Button:SetScript("OnClick", function()
			ns.CategoryList:SelectCategory(categoryID)
		end)

		if i == 1 then
			bar:SetPoint("TOPLEFT", categories.StatusBar, "BOTTOMLEFT", 0, -13)
		elseif i % 2 == 0 then
			bar:SetPoint("TOPLEFT", categoryBars[i - 1], "TOPRIGHT", CATEGORY_COLUMN_GAP, 0)
		elseif i == #topLevel then
			bar:SetPoint("TOP", categoryBars[i - 2], "BOTTOMRIGHT", CATEGORY_COLUMN_GAP / 2, -CATEGORY_ROW_GAP)
		else
			bar:SetPoint("TOPLEFT", categoryBars[i - 2], "BOTTOMLEFT", 0, -CATEGORY_ROW_GAP)
		end
		categoryBars[i] = bar
	end
end

-- Barre du total et barres des catégories
-- (AchievementFrameSummaryCategoriesStatusBar_Update et _Category_OnShow).
local function UpdateCategories()
	local total, completed = API.GetNumCompletedAchievements()
	local statusBar = panel.Categories.StatusBar
	statusBar:SetMinMaxValues(0, total)
	statusBar:SetValue(completed)
	statusBar.Text:SetText(BreakUpLargeNumbers(completed) .. "/" .. BreakUpLargeNumbers(total))

	for _, bar in ipairs(categoryBars) do
		local categoryTotal, categoryCompleted = GetCategoryTotals(bar.categoryID)
		bar.Text:SetText(("%d/%d"):format(categoryCompleted, categoryTotal))
		bar:SetMinMaxValues(0, categoryTotal)
		bar:SetValue(categoryCompleted)
	end
end

-- [[ Panneau ]]

-- Appelé une fois par MainWindow:Init.
function Summary:Init(frame)
	panel = frame
	hasAccountHeader = GetFileIDFromPath(ACCOUNT_HEADER_FILE) ~= nil
	hasNoPointsShield = GetFileIDFromPath(SHIELDS_NOPOINTS_FILE) ~= nil

	panel.Achievements.Header.Title:SetText(L.SUMMARY_LATEST)
	panel.Achievements.EmptyText:SetText(L.SUMMARY_EMPTY)
	panel.Categories.Header.Title:SetText(L.SUMMARY_PROGRESS)
	panel.Categories.StatusBar.Title:SetText(L.SUMMARY_COMPLETED)

	for i = 1, MAX_ACHIEVEMENTS do
		buttons[i] = CreateAchievementButton(i)
	end
	CreateCategoryBars()

	panel:SetScript("OnShow", function()
		Summary:Refresh()
	end)
	Log.Debug("Summary: prêt,", #categoryBars, "catégories")
end

-- Met tout le panneau à jour (AchievementFrameSummary_Update).
function Summary:Refresh()
	UpdateCategories()
	UpdateAchievements()
end
