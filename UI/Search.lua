-- Recherche de hauts faits, en haut à droite de la fenêtre.
-- Clone de Blizzard_AchievementUI/Mainline : AchievementFrameSearchBox_*,
-- AchievementFrame_ShowSearchPreviewResults, _SetSearchPreviewSelection,
-- _ShowFullSearch, _UpdateFullSearchResults et
-- AchievementFullSearchResultsButtonMixin:Init.
--
-- Blizzard cherche côté serveur (SetAchievementSearchString) et affiche une
-- barre d'attente. Nos hauts faits sont en mémoire : recherche immédiate,
-- sans barre. Comme chez Blizzard, elle porte sur le nom et la description,
-- ce qui retrouve un haut fait par le nom de son boss.
local _, ns = ...

local L = ns.L
local Log = ns.Log
local API = ns.API

local Search = {}
ns.Search = Search

-- Valeurs de Blizzard. La place n° 6 de l'aperçu est « tous les résultats ».
local NUM_PREVIEWS = 5
local SHOW_ALL_INDEX = NUM_PREVIEWS + 1
local MIN_CHARACTERS = MIN_CHARACTER_SEARCH or 3

local searchBox = nil
local container = nil    -- aperçu sous la case
local previews = {}
local resultsFrame = nil -- fenêtre « tous les résultats »
local results = {}       -- id trouvés, dans l'ordre des catégories

-- PlaySound(nil) lève une erreur si le SOUNDKIT manque sur Forever.
local function PlayUISound(soundKit)
	if soundKit then
		PlaySound(soundKit)
	end
end

-- string.lower ne connaît pas les majuscules accentuées en UTF-8.
local ACCENTS = {
	["À"] = "à", ["Â"] = "â", ["Ä"] = "ä", ["Ç"] = "ç", ["É"] = "é", ["È"] = "è",
	["Ê"] = "ê", ["Ë"] = "ë", ["Î"] = "î", ["Ï"] = "ï", ["Ô"] = "ô", ["Ö"] = "ö",
	["Ù"] = "ù", ["Û"] = "û", ["Ü"] = "ü", ["Œ"] = "œ",
}
-- Pour que « ecarlate » trouve « Écarlate ».
local PLAIN = {
	["à"] = "a", ["â"] = "a", ["ä"] = "a", ["ç"] = "c", ["é"] = "e", ["è"] = "e",
	["ê"] = "e", ["ë"] = "e", ["î"] = "i", ["ï"] = "i", ["ô"] = "o", ["ö"] = "o",
	["ù"] = "u", ["û"] = "u", ["ü"] = "u", ["œ"] = "oe",
}

local function Normalize(text)
	text = text:lower()
	for upper, lower in pairs(ACCENTS) do
		text = text:gsub(upper, lower)
	end
	for accented, plain in pairs(PLAIN) do
		text = text:gsub(accented, plain)
	end
	return text
end

local function RunSearch(text)
	wipe(results)
	local needle = Normalize(text)
	for _, categoryID in ipairs(API.GetCategoryList()) do
		local count = API.GetCategoryNumAchievements(categoryID)
		for index = 1, count do
			local id, name, _, _, _, _, _, description = API.GetAchievementInfo(categoryID, index)
			if Normalize(name):find(needle, 1, true)
				or Normalize(description or ""):find(needle, 1, true) then
				results[#results + 1] = id
			end
		end
	end
	Log.Debug("Search:", text, #results, "résultat(s)")
end

-- Par exemple « Exploration > Kalimdor ».
local function GetCategoryPath(achievementID)
	local name, parent = API.GetCategoryInfo(API.GetAchievementCategory(achievementID))
	local path = name
	while parent ~= -1 do
		name, parent = API.GetCategoryInfo(parent)
		path = name .. " > " .. path
	end
	return path
end

-- [[ Aperçu ]]

local function HidePreview()
	container:Hide()
	for _, preview in ipairs(previews) do
		preview:Hide()
	end
	container.ShowAllSearchResults:Hide()
end

-- Flèches et survol. L'index boucle sur les lignes visibles.
local function SetPreviewSelection(selectedIndex)
	local numShown = 0
	for _, preview in ipairs(previews) do
		preview.SelectedTexture:Hide()
		if preview:IsShown() then
			numShown = numShown + 1
		end
	end
	if container.ShowAllSearchResults:IsShown() then
		numShown = numShown + 1
	end
	container.ShowAllSearchResults.SelectedTexture:Hide()

	if numShown <= 0 then
		selectedIndex = 1
	else
		selectedIndex = (selectedIndex - 1) % numShown + 1
	end
	searchBox.selectedIndex = selectedIndex

	if selectedIndex == SHOW_ALL_INDEX then
		container.ShowAllSearchResults.SelectedTexture:Show()
	else
		previews[selectedIndex].SelectedTexture:Show()
	end
end

local function ShowPreviewResults()
	local numResults = #results
	local lastButton
	for index, preview in ipairs(previews) do
		local achievementID = results[index]
		if achievementID then
			local _, name, _, _, _, _, _, _, _, icon = API.GetAchievementInfo(achievementID)
			preview.Name:SetText(name)
			preview.Icon:SetTexture(icon)
			preview.achievementID = achievementID
			preview:Show()
			lastButton = preview
		else
			preview.achievementID = nil
			preview:Hide()
		end
	end

	if numResults > NUM_PREVIEWS then
		container.ShowAllSearchResults.Text:SetText(L.SEARCH_SHOW_ALL:format(numResults))
		container.ShowAllSearchResults:Show()
		lastButton = container.ShowAllSearchResults
	else
		container.ShowAllSearchResults:Hide()
	end

	if numResults > 0 then
		SetPreviewSelection(1)
	end

	if lastButton then
		container.BorderAnchor:SetPoint("BOTTOM", lastButton, "BOTTOM", 0, -5)
		container.Background:Hide()
		container:Show()
	else
		container:Hide()
	end
end

local function UpdatePreview()
	if not searchBox:HasFocus() or strlenutf8(searchBox:GetText()) < MIN_CHARACTERS then
		HidePreview()
		return
	end
	ShowPreviewResults()
end

-- AchievementSearchPreviewButton_OnClick
local function SelectResult(achievementID)
	resultsFrame:Hide()
	HidePreview()
	searchBox:ClearFocus()
	ns.MainWindow:ShowAchievement(achievementID)
end

-- [[ Fenêtre « tous les résultats » ]]

local function InitResultButton(button, elementData)
	local achievementID = results[elementData.index]
	local _, name, _, completed, _, _, _, _, _, icon = API.GetAchievementInfo(achievementID)
	button.Name:SetText(name)
	button.Icon:SetTexture(icon)
	button.achievementID = achievementID
	button.ResultType:SetText(completed and L.SEARCH_COMPLETED or L.SEARCH_INCOMPLETE)
	button.Path:SetText(GetCategoryPath(achievementID))
	if not button.hffSetup then
		button:SetScript("OnClick", function(self)
			if self.achievementID then
				SelectResult(self.achievementID)
			end
		end)
		button.hffSetup = true
	end
end

local function ShowFullSearch()
	if #results == 0 then
		resultsFrame:Hide()
		return
	end
	resultsFrame.ScrollBox:SetDataProvider(CreateDataProviderByIndexCount(#results))
	resultsFrame.TitleText:SetText(L.SEARCH_RESULTS_TITLE:format(searchBox:GetText(), #results))
	HidePreview()
	searchBox:ClearFocus()
	resultsFrame:Show()
end

-- [[ Case de recherche ]]

local function OnTextChanged(self)
	SearchBoxTemplate_OnTextChanged(self)
	if strlenutf8(self:GetText()) >= MIN_CHARACTERS then
		RunSearch(self:GetText())
		UpdatePreview()
	else
		wipe(results)
		HidePreview()
	end
end

local function OnEnterPressed(self)
	if strlenutf8(self:GetText()) < MIN_CHARACTERS then
		return
	end
	if self.selectedIndex == SHOW_ALL_INDEX then
		if container.ShowAllSearchResults:IsShown() then
			container.ShowAllSearchResults:Click()
		end
	else
		local preview = previews[self.selectedIndex]
		if preview and preview:IsShown() then
			preview:Click()
		end
	end
end

local function OnKeyDown(self, key)
	if key == "UP" then
		SetPreviewSelection(self.selectedIndex - 1)
	elseif key == "DOWN" then
		SetPreviewSelection(self.selectedIndex + 1)
	end
end

-- Appelé une fois par MainWindow:Init.
function Search:Init(window)
	searchBox = window.HeaderDetails.SearchBox
	container = searchBox.SearchPreviewContainer
	resultsFrame = window.SearchResults
	for i = 1, NUM_PREVIEWS do
		previews[i] = container["SearchPreview" .. i]
	end

	-- Garde le focus quand la souris est sur l'aperçu : sinon, cliquer une
	-- ligne ferme l'aperçu avant que le clic ne soit pris en compte.
	searchBox.HasStickyFocus = function()
		return DoesAncestryIncludeAny(container, GetMouseFoci())
	end
	searchBox.selectedIndex = 1
	searchBox:SetScript("OnTextChanged", OnTextChanged)
	searchBox:SetScript("OnEnterPressed", OnEnterPressed)
	searchBox:SetScript("OnKeyDown", OnKeyDown)
	searchBox:SetScript("OnEditFocusLost", function(self)
		SearchBoxTemplate_OnEditFocusLost(self)
		HidePreview()
	end)
	searchBox:SetScript("OnEditFocusGained", function(self)
		SearchBoxTemplate_OnEditFocusGained(self)
		resultsFrame:Hide()
		UpdatePreview()
	end)
	searchBox:HookScript("OnShow", function(self)
		self:SetFrameLevel(self:GetParent():GetFrameLevel() + 7)
		SetPreviewSelection(1)
	end)

	for index, preview in ipairs(previews) do
		preview:SetScript("OnEnter", function()
			SetPreviewSelection(index)
		end)
		preview:SetScript("OnClick", function(self)
			if self.achievementID then
				SelectResult(self.achievementID)
			end
		end)
	end
	container.ShowAllSearchResults:SetScript("OnEnter", function()
		SetPreviewSelection(SHOW_ALL_INDEX)
	end)
	container.ShowAllSearchResults:SetScript("OnClick", function()
		ShowFullSearch()
		PlayUISound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	end)

	local view = CreateScrollBoxListLinearView()
	view:SetElementInitializer("HFFFullSearchResultsButtonTemplate", InitResultButton)
	ScrollUtil.InitScrollBoxListWithScrollBar(resultsFrame.ScrollBox, resultsFrame.ScrollBar, view)
	resultsFrame:SetScript("OnShow", function()
		PlayUISound(SOUNDKIT.IG_SPELLBOOK_OPEN)
	end)
	resultsFrame:SetScript("OnHide", function()
		PlayUISound(SOUNDKIT.IG_SPELLBOOK_CLOSE)
	end)

	-- Vidée à la fermeture de la fenêtre, comme dans AchievementFrame_OnHide.
	window:HookScript("OnHide", function()
		HidePreview()
		resultsFrame:Hide()
		searchBox:SetText("")
	end)
	Log.Debug("Search: prête")
end
