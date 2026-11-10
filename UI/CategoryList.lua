-- Colonne des catégories, à gauche de la fenêtre.
-- Clone de Blizzard_AchievementUI/Mainline : AchievementFrameCategories_
-- MakeCategoryList, _SelectElementData, _UpdateDataProvider et
-- AchievementCategoryTemplateMixin:Init.
--
-- Élément de la liste : { id, parent, isChild, collapsed, hidden, selected }
--   id = SUMMARY_ID pour le Résumé, toujours en tête
--   parent = true pour une catégorie qui a des filles, id de la mère pour une fille
local _, ns = ...

local L = ns.L
local Log = ns.Log
local API = ns.API

local CategoryList = {}
ns.CategoryList = CategoryList

CategoryList.SUMMARY_ID = "summary"
local SUMMARY_ID = CategoryList.SUMMARY_ID

local TEMPLATE = "HFFCategoryTemplate"
local CATEGORIES_WIDTH = 175 -- ACHIEVEMENTUI_CATEGORIESWIDTH

local categoriesFrame = nil
local elements = {}           -- tous les éléments, dans l'ordre d'affichage
local selected = nil
local onCategoryChanged = nil -- callback(categoryID) de MainWindow

-- Résumé, catégories de premier niveau, puis chaque fille juste après sa
-- mère, masquée tant que la mère est fermée.
local function BuildElements()
	local source = API.GetCategoryList()
	local list = { { id = SUMMARY_ID } }

	for _, id in ipairs(source) do
		local _, parent = API.GetCategoryInfo(id)
		if parent == -1 then
			list[#list + 1] = { id = id }
		end
	end

	-- Parcours à l'envers : insérer chaque fille juste après sa mère garde
	-- l'ordre de Data/Categories.lua.
	for i = #source, 1, -1 do
		local _, parent = API.GetCategoryInfo(source[i])
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

local function GetCategoryTotals(categoryID)
	if categoryID == SUMMARY_ID then
		return API.GetNumCompletedAchievements()
	end
	return API.GetCategoryTotalNumAchievements(categoryID)
end

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

local function RefreshSelectionHighlight()
	categoriesFrame.ScrollBox:ForEachFrame(function(frame, element)
		if element.selected then
			frame.Button:LockHighlight()
		else
			frame.Button:UnlockHighlight()
		end
	end)
end

-- Un clic sur une mère l'ouvre ou la ferme, et ferme les autres
-- (AchievementFrameCategories_SelectElementData).
function CategoryList:Select(element)
	local categoryChanged = not selected or selected.id ~= element.id
	-- Revenir d'une fille à sa mère ne referme pas la mère.
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

-- Sélectionne une catégorie par son id et ouvre sa mère si besoin (toast,
-- Résumé, recherche). Déjà sélectionnée, elle reste telle quelle : un
-- nouveau Select replierait une mère ouverte.
function CategoryList:SelectCategory(categoryID)
	for _, element in ipairs(elements) do
		if element.id == categoryID then
			if not element.selected then
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
			end
			categoriesFrame.ScrollBox:ScrollToElementData(element, ScrollBoxConstants.AlignCenter)
			return
		end
	end
end

-- AchievementCategoryTemplateMixin:Init
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
		name = API.GetCategoryInfo(element.id)
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

-- À l'ouverture de la fenêtre. Sans sélection, choisit le Résumé.
function CategoryList:Refresh()
	UpdateDataProvider()
	if not selected then
		self:Select(elements[1])
	end
end
