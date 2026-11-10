-- Colonne des catégories de la fenêtre (à gauche).
-- Clone de la logique de Blizzard_AchievementUI/Mainline (export Forever) :
-- AchievementFrameCategories_MakeCategoryList, _SelectElementData,
-- _UpdateDataProvider et AchievementCategoryTemplateMixin:Init.
-- Les données viennent uniquement de ns.API.
--
-- Une catégorie est un « élément » :
--   { id, parent, isChild, collapsed, hidden, selected }
--   id = SUMMARY_ID pour le Résumé (en tête de liste, comme chez Blizzard)
--   parent = true pour une catégorie qui a des sous-catégories,
--            ou l'id de la catégorie mère pour une sous-catégorie
local _, ns = ...

local L = ns.L
local Log = ns.Log

local CategoryList = {}
ns.CategoryList = CategoryList

CategoryList.SUMMARY_ID = "summary"
local SUMMARY_ID = CategoryList.SUMMARY_ID

local TEMPLATE = "HFFCategoryTemplate"
-- Largeur de la colonne (ACHIEVEMENTUI_CATEGORIESWIDTH de Blizzard).
local CATEGORIES_WIDTH = 175

local categoriesFrame = nil  -- HFFAchievementFrame.Categories
local elements = {}          -- tous les éléments, dans l'ordre d'affichage
local selected = nil         -- élément sélectionné
local onCategoryChanged = nil -- callback(categoryID) fourni par MainWindow

-- Construit la liste : Résumé, catégories de premier niveau, et chaque
-- sous-catégorie juste après sa mère (masquée tant que la mère est fermée).
local function BuildElements()
	local source = ns.API.GetCategoryList()
	local list = { { id = SUMMARY_ID } }

	for _, id in ipairs(source) do
		local _, parent = ns.API.GetCategoryInfo(id)
		if parent == -1 then
			list[#list + 1] = { id = id }
		end
	end

	-- En partant de la fin, chaque insertion juste après la mère garde les
	-- sous-catégories dans l'ordre de Data/Categories.lua.
	for i = #source, 1, -1 do
		local _, parent = ns.API.GetCategoryInfo(source[i])
		for j, category in ipairs(list) do
			if category.id == parent then
				category.parent = true
				category.collapsed = true
				table.insert(list, j + 1, {
					id = source[i],
					parent = category.id,
					hidden = true,
					isChild = true,
				})
				break
			end
		end
	end
	return list
end

-- Total et obtenus d'une catégorie, sous-catégories comprises
-- (AchievementFrame_GetCategoryTotalNumAchievements de Blizzard).
local function GetCategoryTotals(categoryID)
	if categoryID == SUMMARY_ID then
		return ns.API.GetNumCompletedAchievements()
	end
	local total, completed = ns.API.GetCategoryNumAchievements(categoryID)
	for _, element in ipairs(elements) do
		if element.isChild and element.parent == categoryID then
			local childTotal, childCompleted = ns.API.GetCategoryNumAchievements(element.id)
			total = total + childTotal
			completed = completed + childCompleted
		end
	end
	return total, completed
end

-- Infobulle : nom et barre de progression, comme chez Blizzard.
local function OnButtonEnter(button)
	local total, completed = GetCategoryTotals(button.categoryID)
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	GameTooltip:SetMinimumWidth(128, true)
	GameTooltip:SetText(button.Label:GetText(), 1, 1, 1, nil, true)
	GameTooltip_ShowStatusBar(GameTooltip, 0, total, completed, completed .. "/" .. total)
	GameTooltip:Show()
end

local function OnButtonLeave()
	GameTooltip:SetMinimumWidth(0, false)
	GameTooltip:Hide()
end

local function UpdateDataProvider()
	local dataProvider = CreateDataProvider()
	for _, element in ipairs(elements) do
		if not element.hidden then
			dataProvider:Insert(element)
		end
	end
	categoriesFrame.ScrollBox:SetDataProvider(dataProvider, ScrollBoxConstants.RetainScrollPosition)
end

-- Met à jour la surbrillance de tous les boutons visibles.
local function RefreshSelectionHighlight()
	categoriesFrame.ScrollBox:ForEachFrame(function(frame, element)
		if element.selected then
			frame.Button:LockHighlight()
		else
			frame.Button:UnlockHighlight()
		end
	end)
end

-- Sélectionne un élément (clone de AchievementFrameCategories_SelectElementData) :
-- un clic sur une catégorie mère l'ouvre ou la ferme, et ferme les autres.
function CategoryList:Select(element)
	local categoryChanged = not selected or selected.id ~= element.id
	-- Revenir d'une sous-catégorie à sa mère ne referme pas la mère.
	local changeCollapsed = not (element.parent and selected and selected.parent == element.id)
	local isChild = element.isChild

	for _, other in ipairs(elements) do
		other.selected = false
		if not isChild and changeCollapsed and not other.isChild then
			if other ~= element then
				other.collapsed = true
			end
		end
	end

	if not isChild then
		local collapsed = element.collapsed
		if changeCollapsed and element.parent then
			collapsed = not element.collapsed
			element.collapsed = collapsed
		end
		for _, other in ipairs(elements) do
			if other.isChild then
				other.hidden = not (other.parent == element.id and not collapsed)
			end
		end
	end

	element.selected = true
	selected = element

	if not isChild and changeCollapsed then
		UpdateDataProvider()
	end
	RefreshSelectionHighlight()

	if categoryChanged then
		Log.Debug("CategoryList: catégorie", element.id)
		onCategoryChanged(element.id)
	end
end

-- Sélectionne une catégorie par son id, en ouvrant sa mère si besoin
-- (pour ouvrir la fenêtre sur un haut fait, depuis un toast par exemple).
function CategoryList:SelectCategory(categoryID)
	for _, element in ipairs(elements) do
		if element.id == categoryID then
			if element.isChild then
				for _, other in ipairs(elements) do
					if other.isChild then
						other.hidden = other.parent ~= element.parent
					elseif other.id == element.parent then
						other.collapsed = false
					end
				end
				UpdateDataProvider()
			end
			self:Select(element)
			categoriesFrame.ScrollBox:ScrollToElementData(element, ScrollBoxConstants.AlignCenter)
			return
		end
	end
end

-- Remplit un bouton de catégorie (clone de AchievementCategoryTemplateMixin:Init).
local function InitButton(frame, element)
	local button = frame.Button
	if not button.initialized then
		button:SetScript("OnClick", function()
			CategoryList:Select(frame:GetElementData())
		end)
		button:SetScript("OnEnter", OnButtonEnter)
		button:SetScript("OnLeave", OnButtonLeave)
		button.initialized = true
	end

	if element.isChild then
		button:SetWidth(CATEGORIES_WIDTH - 25)
		button.Label:SetFontObject("GameFontHighlight")
		button.Background:SetVertexColor(0.6, 0.6, 0.6)
	else
		button:SetWidth(CATEGORIES_WIDTH - 10)
		button.Label:SetFontObject("GameFontNormal")
		button.Background:SetVertexColor(1, 1, 1)
	end

	local name
	if element.id == SUMMARY_ID then
		name = L.CATEGORY_SUMMARY
	else
		name = ns.API.GetCategoryInfo(element.id)
	end
	button.Label:SetText(name)
	button.categoryID = element.id

	if element.selected then
		button:LockHighlight()
	else
		button:UnlockHighlight()
	end
end

-- Appelé une fois par MainWindow:Init.
function CategoryList:Init(frame, categoryChangedCallback)
	categoriesFrame = frame
	onCategoryChanged = categoryChangedCallback

	local view = CreateScrollBoxListLinearView()
	view:SetElementInitializer(TEMPLATE, InitButton)
	ScrollUtil.InitScrollBoxListWithScrollBar(frame.ScrollBox, frame.ScrollBar, view)

	elements = BuildElements()
	UpdateDataProvider()
	Log.Debug("CategoryList:", #elements, "éléments")
end

-- À l'ouverture de la fenêtre : rafraîchit la liste et sélectionne le
-- Résumé si rien ne l'est encore.
function CategoryList:Refresh()
	UpdateDataProvider()
	if not selected then
		self:Select(elements[1])
	end
end

function CategoryList:GetSelectedCategory()
	return selected and selected.id
end
