-- Colonne des versions, à gauche de l'onglet « Notes de version ».
-- Copie de UI/CategoryList.lua (même comportement : une mère s'ouvre au
-- clic et ferme les autres), gardée à part pour ne rien changer à la
-- colonne des hauts faits. Les éléments viennent de Data/Changelog.lua.
--
-- Élément de la liste : { id, versions, parent, isChild, collapsed, hidden, selected }
--   id = LATEST_ID pour « Dernière version », toujours en tête
--   id = "1.x" pour une série (mère), "1.1.0" pour une version (fille)
--   versions = versions affichées à droite quand l'élément est choisi
--   parent = true pour une série, id de la série pour une version
local _, ns = ...

local L = ns.L
local Log = ns.Log

local ChangelogCategories = {}
ns.ChangelogCategories = ChangelogCategories

ChangelogCategories.LATEST_ID = "latest"
local LATEST_ID = ChangelogCategories.LATEST_ID

local TEMPLATE = "HFFCategoryTemplate"
local CATEGORIES_WIDTH = 175 -- ACHIEVEMENTUI_CATEGORIESWIDTH

local categoriesFrame = nil
local elements = {}           -- tous les éléments, dans l'ordre d'affichage
local selected = nil
local onSelectionChanged = nil -- callback(versions) de UI/Changelog.lua

-- « 1.1.0 » -> « 1.x »
local function SeriesOf(version)
	local major = version:match("^(%d+)%.")
	return (major or version) .. ".x"
end

-- Dernière version, puis chaque série (la plus récente en haut) suivie de
-- ses versions, masquées tant que la série est fermée. Data/Changelog.lua
-- est déjà dans l'ordre, la plus récente en tête.
local function BuildElements()
	local changelog = ns.Data.changelog
	local list = {}
	if changelog[1] then
		list[1] = { id = LATEST_ID, versions = { changelog[1] } }
	end

	local seriesByID = {}
	for _, entry in ipairs(changelog) do
		local seriesID = SeriesOf(entry.version)
		local series = seriesByID[seriesID]
		if not series then
			series = { id = seriesID, versions = {}, parent = true, collapsed = true }
			seriesByID[seriesID] = series
			list[#list + 1] = series
		end
		series.versions[#series.versions + 1] = entry
	end

	-- Les versions juste après leur série.
	local ordered = {}
	for _, element in ipairs(list) do
		ordered[#ordered + 1] = element
		if element.parent == true then
			for _, entry in ipairs(element.versions) do
				ordered[#ordered + 1] = {
					id = entry.version,
					versions = { entry },
					parent = element.id,
					hidden = true,
					isChild = true,
				}
			end
		end
	end
	return ordered
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

-- Même règle que CategoryList:Select : un clic sur une série l'ouvre ou la
-- ferme, et ferme les autres.
function ChangelogCategories:Select(element)
	local changed = not selected or selected.id ~= element.id
	-- Revenir d'une version à sa série ne referme pas la série.
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

	if changed then
		Log.Debug("ChangelogCategories:", element.id)
		onSelectionChanged(element.versions)
	end
end

-- À chaque arrivée sur l'onglet : « Dernière version », comme le Résumé.
function ChangelogCategories:SelectLatest()
	if elements[1] and not elements[1].selected then
		self:Select(elements[1])
	end
	categoriesFrame.ScrollBox:ScrollToBegin()
end

local function InitButton(frame, element)
	local button = frame.Button
	if not button.initialized then
		button:SetScript("OnClick", function()
			ChangelogCategories:Select(frame:GetElementData())
		end)
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

	if element.id == LATEST_ID then
		button.Label:SetText(L.CHANGELOG_LATEST)
	else
		button.Label:SetText(element.id)
	end

	if element.selected then
		button:LockHighlight()
	else
		button:UnlockHighlight()
	end
end

-- Appelé une fois par Changelog:Init.
function ChangelogCategories:Init(frame, selectionChangedCallback)
	categoriesFrame = frame
	onSelectionChanged = selectionChangedCallback

	local view = CreateScrollBoxListLinearView()
	view:SetElementInitializer(TEMPLATE, InitButton)
	ScrollUtil.InitScrollBoxListWithScrollBar(frame.ScrollBox, frame.ScrollBar, view)

	elements = BuildElements()
	UpdateDataProvider()
	Log.Debug("ChangelogCategories:", #elements, "éléments")
end
