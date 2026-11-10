-- Liste des hauts faits d'une catégorie (partie droite de la fenêtre).
-- Clone de la logique de Blizzard_AchievementUI/Mainline (export Forever) :
-- AchievementFrameAchievements_OnLoad / _UpdateDataProvider,
-- AchievementTemplateMixin (Init, Collapse, Expand, Saturate, Desaturate,
-- CalculateSelectedHeight, DisplayObjectives), AchievementsObjectivesMixin,
-- AchievementObjectives_DisplayCriteria et _DisplayProgressiveAchievement.
-- Retiré : guilde, suivi d'objectifs, lien dans le chat, manette.
--
-- Un clic sur une ligne la déplie (critères, barres de progression, hauts
-- faits demandés par un méta, ou petites icônes de la série) ; un second
-- clic la replie. Une seule ligne dépliée à la fois, comme chez Blizzard.
-- Les données viennent uniquement de ns.API.
local _, ns = ...

local L = ns.L
local Log = ns.Log
local API = ns.API

local AchievementList = {}
ns.AchievementList = AchievementList

local TEMPLATE = "HFFAchievementTemplate"

-- Valeurs de Blizzard (ACHIEVEMENTBUTTON_* et ACHIEVEMENTUI_*).
local COLLAPSED_HEIGHT = 84
local DESCRIPTION_HEIGHT = 20
local CRITERIA_ROW_HEIGHT = 15
local META_ROW_HEIGHT = 28
local MAX_CONTENT_WIDTH = 330
local CRITERIA_CHECK_WIDTH = 20
local MAX_LINES_COLLAPSED = 3
local LABEL_WIDTH = 320
local PROGRESSIVE_HEIGHT = 50
local PROGRESSIVE_WIDTH = 42
local MINIS_PER_ROW = 6
local FORCE_COLUMNS_MAX_WIDTH = 220
local FORCE_COLUMNS_MIN_CRITERIA = 20
local FORCE_COLUMNS_LEFT_OFFSET = -10
local FORCE_COLUMNS_RIGHT_OFFSET = 24

-- Drapeaux de Blizzard : haut fait de compte (ACHIEVEMENT_FLAGS_ACCOUNT) et
-- critère affiché en barre (EVALUATION_TREE_FLAG_PROGRESS_BAR).
local FLAG_ACCOUNT = 0x00020000
local CRITERIA_FLAG_PROGRESS_BAR = 0x00000001
-- Type de critère « obtenir un autre haut fait » (nom de type de ns.CriteriaTypes).
local CRITERIA_TYPE_ACHIEVEMENT = "achievement"

-- Couleurs de bordure de Blizzard (ACHIEVEMENT_RED/BLUE_BORDER_COLOR).
local RED_BORDER = { 0.7, 0.15, 0.05 }
local BLUE_BORDER = { 0.129, 0.671, 0.875 }

local BORDERS_FILE = "Interface\\AchievementFrame\\UI-Achievement-Borders"
local ACCOUNT_HEADER_FILE = "Interface\\AchievementFrame\\AccountLevel-AchievementHeader"
local SHIELDS_FILE = "Interface\\AchievementFrame\\UI-Achievement-Shields"
local SHIELDS_NOPOINTS_FILE = "Interface\\AchievementFrame\\UI-Achievement-Shields-NoPoints"
local MINI_SHIELD_FILE = "Interface\\AchievementFrame\\UI-Achievement-Progressive-Shield"
local MINI_SHIELD_NOPOINTS_FILE = "Interface\\AchievementFrame\\UI-Achievement-Progressive-Shield-NoPoints"

local listFrame = nil         -- HFFAchievementFrame.Achievements
local selectionBehavior = nil -- sélection « intrusive » de Blizzard (une ligne dépliée)
local objectives = nil        -- cadre des critères, posé dans la ligne dépliée
local fontHeight = nil        -- hauteur d'une ligne de description
local textCheckWidth = nil    -- largeur du texte "- " devant un critère non rempli
-- Textures absentes du client Forever : on se rabat sur l'équivalent présent.
local hasAccountHeader = true
local hasNoPointsShield = true
local hasNoPointsMiniShield = true

-- Points d'une série : somme des points de ce haut fait et des précédents
-- (AchievementButton_GetProgressivePoints).
local function GetProgressivePoints(achievementID)
	local _, _, total = API.GetAchievementInfo(achievementID)
	local previous = API.GetPreviousAchievement(achievementID)
	while previous do
		local _, _, points = API.GetAchievementInfo(previous)
		total = total + points
		previous = API.GetPreviousAchievement(previous)
	end
	return total or 0
end

-- Texte des points dans le bouclier (AchievementShield_SetPoints).
local function SetShieldPoints(points, fontString)
	if points == 0 then
		fontString:SetText("")
		return
	end
	if points < 100 then
		fontString:SetFontObject(AchievementPointsFont)
	else
		fontString:SetFontObject(AchievementPointsFontSmall)
	end
	fontString:SetText(points)
end

-- [[ Cadre des critères (AchievementsObjectivesMixin) ]]

local Objectives = {}

function Objectives:Clear()
	for _, pool in pairs(self.pools) do
		pool:ReleaseAll()
	end
	self.criterias = {}
	self.progressBars = {}
	self.minis = {}
	self.metas = {}
	self:ClearAllPoints()
	self:SetHeight(0)
end

-- Renvoie l'élément n° index de la collection, en le créant au besoin.
-- setup(frame) est appelé une seule fois par cadre créé.
function Objectives:GetElementAtIndex(poolKey, collection, index, setup)
	local found = collection[index]
	if found then
		return found
	end
	local frame = self.pools[poolKey]:Acquire()
	if setup and not frame.hffSetup then
		setup(frame)
		frame.hffSetup = true
	end
	table.insert(collection, frame)
	frame:Show()
	return frame
end

-- Infobulle d'une petite icône de série (OnEnter de MiniAchievementTemplate).
local function OnMiniEnter(mini)
	GameTooltip:SetOwner(mini, "ANCHOR_RIGHT")
	if mini.name then
		GameTooltip:AddDoubleLine(mini.name, mini.date, nil, nil, nil, 0.5, 0.5, 0.5)
	end
	if mini.desc then
		GameTooltip:AddLine(mini.desc, 1, 1, 1, true)
	end
	for i = 1, mini.numCriteria or 0 do
		GameTooltip:AddLine(mini.criteria[i])
	end
	GameTooltip:Show()
end

local function SetupMini(mini)
	mini:SetScript("OnEnter", OnMiniEnter)
	mini:SetScript("OnLeave", GameTooltip_Hide)
end

-- Critère de méta : infobulle avec la date, clic pour ouvrir le haut fait visé
-- (AchievementMetaCriteriaMixin).
local function SetupMeta(meta)
	meta:SetScript("OnEnter", function(self)
		if self.date then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(L.META_COMPLETED_DATE:format(self.date), 1, 1, 1, true)
			GameTooltip:Show()
		end
	end)
	meta:SetScript("OnLeave", GameTooltip_Hide)
	meta:SetScript("OnClick", function(self)
		ns.MainWindow:ShowAchievement(self.id)
	end)
end

function Objectives:GetCriteria(index)
	return self:GetElementAtIndex("criteria", self.criterias, index)
end

function Objectives:GetProgressBar(index)
	return self:GetElementAtIndex("progressBar", self.progressBars, index)
end

function Objectives:GetMiniAchievement(index)
	return self:GetElementAtIndex("mini", self.minis, index, SetupMini)
end

function Objectives:GetMeta(index)
	return self:GetElementAtIndex("meta", self.metas, index, SetupMeta)
end

-- Petites icônes de la série, de la première à celle-ci
-- (AchievementObjectives_DisplayProgressiveAchievement).
function Objectives:DisplayProgressiveAchievement(id)
	local series = { id }
	local previous = API.GetPreviousAchievement(id)
	while previous do
		table.insert(series, 1, previous)
		previous = API.GetPreviousAchievement(previous)
	end

	for index, achievementID in ipairs(series) do
		local _, name, points, _, month, day, year, description, _, icon = API.GetAchievementInfo(achievementID)
		local mini = self:GetMiniAchievement(index)
		mini:Show()
		mini:ClearAllPoints()
		mini:SetParent(self)
		mini.Icon:SetTexture(icon)
		if index == 1 then
			mini:SetPoint("TOPLEFT", self, "TOPLEFT", -4, -4)
		elseif index % MINIS_PER_ROW == 1 then
			mini:SetPoint("TOPLEFT", self:GetMiniAchievement(index - MINIS_PER_ROW), "BOTTOMLEFT", 0, -8)
		else
			mini:SetPoint("TOPLEFT", self:GetMiniAchievement(index - 1), "TOPRIGHT", 4, 0)
		end

		if points > 0 then
			mini.Points:SetText(points)
			mini.Points:Show()
			mini.Shield:SetTexture(MINI_SHIELD_FILE)
		else
			mini.Points:Hide()
			mini.Shield:SetTexture(hasNoPointsMiniShield and MINI_SHIELD_NOPOINTS_FILE or MINI_SHIELD_FILE)
		end

		-- Critères listés dans l'infobulle, en vert si remplis, gris sinon.
		mini.criteria = {}
		mini.numCriteria = API.GetAchievementNumCriteria(achievementID)
		for criteriaIndex = 1, mini.numCriteria do
			local criteriaString, _, criteriaCompleted = API.GetAchievementCriteriaInfo(achievementID, criteriaIndex)
			local color = criteriaCompleted and "|cff00ff00" or "|cff808080"
			mini.criteria[criteriaIndex] = color .. " - " .. criteriaString .. "|r"
		end
		mini.name = name
		mini.desc = description
		mini.date = month and FormatShortDate(day, month, year) or nil
	end

	self:SetHeight(math.ceil(#series / MINIS_PER_ROW) * PROGRESSIVE_HEIGHT)
	self:SetWidth(math.min(#series, MINIS_PER_ROW) * PROGRESSIVE_WIDTH)
end

-- Critères du haut fait : textes, barres de progression et hauts faits
-- demandés par un méta (AchievementObjectives_DisplayCriteria).
function Objectives:DisplayCriteria(id)
	local numCriteria = API.GetAchievementNumCriteria(id)
	if numCriteria == 0 then
		self:SetHeight(0)
		return
	end

	if not textCheckWidth then
		local criteria = self:GetCriteria(1)
		criteria.Name:SetText("- ")
		textCheckWidth = criteria.Name:GetStringWidth()
	end

	local textStrings, progressBars, metas = 0, 0, 0
	local numMetaRows, numCriteriaRows = 0, 0
	local firstMeta
	local maxCriteriaWidth = 0

	for i = 1, numCriteria do
		local criteriaString, criteriaType, completed, quantity, reqQuantity, _, flags, assetID, quantityString = API.GetAchievementCriteriaInfo(id, i)

		if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then
			metas = metas + 1
			local meta = self:GetMeta(metas)
			meta:ClearAllPoints()
			if metas == 1 then
				-- Placé plus bas, une fois connu le nombre de critères texte.
				firstMeta = meta
				numMetaRows = numMetaRows + 1
			elseif metas % 2 == 0 then
				meta:SetPoint("LEFT", self:GetMeta(metas - 1), "RIGHT", 35, 0)
			else
				meta:SetPoint("TOPLEFT", self:GetMeta(metas - 2), "BOTTOMLEFT", 0, 2)
				numMetaRows = numMetaRows + 1
			end

			local metaID, metaName, _, _, month, day, year, _, _, icon = API.GetAchievementInfo(assetID)
			meta.date = month and FormatShortDate(day, month, year) or nil
			meta.id = metaID
			meta.Label:SetText(metaName)
			meta.Icon:SetTexture(icon)

			if self.completed and completed then
				meta.Check:Show()
				meta.Border:SetVertexColor(1, 1, 1, 1)
				meta.Icon:SetVertexColor(1, 1, 1, 1)
				meta.Label:SetShadowOffset(0, 0)
				meta.Label:SetTextColor(0, 0, 0, 1)
			elseif completed then
				meta.Check:Show()
				meta.Border:SetVertexColor(1, 1, 1, 1)
				meta.Icon:SetVertexColor(1, 1, 1, 1)
				meta.Label:SetShadowOffset(1, -1)
				meta.Label:SetTextColor(0, 1, 0, 1)
			else
				meta.Check:Hide()
				meta.Border:SetVertexColor(0.75, 0.75, 0.75, 1)
				meta.Icon:SetVertexColor(0.55, 0.55, 0.55, 1)
				meta.Label:SetShadowOffset(1, -1)
				meta.Label:SetTextColor(0.6, 0.6, 0.6, 1)
			end
			meta:SetParent(self)
			meta:Show()

		elseif bit.band(flags, CRITERIA_FLAG_PROGRESS_BAR) == CRITERIA_FLAG_PROGRESS_BAR then
			progressBars = progressBars + 1
			local bar = self:GetProgressBar(progressBars)
			bar:ClearAllPoints()
			if progressBars == 1 then
				bar:SetPoint("TOP", self, "TOP", 4, -4)
			else
				bar:SetPoint("TOP", self:GetProgressBar(progressBars - 1), "BOTTOM", 0, 0)
			end
			bar.Text:SetText(quantityString)
			bar:SetMinMaxValues(0, reqQuantity)
			bar:SetValue(quantity)
			bar:SetParent(self)
			bar:Show()
			numCriteriaRows = numCriteriaRows + 1

		else
			textStrings = textStrings + 1
			local criteria = self:GetCriteria(textStrings)
			criteria:ClearAllPoints()
			if textStrings == 1 then
				if numCriteria == 1 then
					criteria:SetPoint("TOP", self, "TOP", -14, 0)
				else
					criteria:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
				end
			else
				criteria:SetPoint("TOPLEFT", self:GetCriteria(textStrings - 1), "BOTTOMLEFT", 0, 0)
			end

			if self.completed and completed then
				criteria.Name:SetTextColor(0, 0, 0, 1)
				criteria.Name:SetShadowOffset(0, 0)
			elseif completed then
				criteria.Name:SetTextColor(0, 1, 0, 1)
				criteria.Name:SetShadowOffset(1, -1)
			else
				criteria.Name:SetTextColor(0.6, 0.6, 0.6, 1)
				criteria.Name:SetShadowOffset(1, -1)
			end

			local stringWidth, maxContentWidth
			if completed then
				maxContentWidth = MAX_CONTENT_WIDTH - CRITERIA_CHECK_WIDTH
				criteria.Check:SetPoint("LEFT", 18, -3)
				criteria.Name:SetPoint("LEFT", criteria.Check, "RIGHT", 0, 2)
				criteria.Check:Show()
				criteria.Name:SetText(criteriaString)
				stringWidth = math.min(criteria.Name:GetStringWidth(), maxContentWidth)
			else
				maxContentWidth = MAX_CONTENT_WIDTH - textCheckWidth
				criteria.Check:SetPoint("LEFT", 0, -3)
				criteria.Name:SetPoint("LEFT", criteria.Check, "RIGHT", 5, 2)
				criteria.Check:Hide()
				criteria.Name:SetText("- " .. criteriaString)
				-- Le "- " ne compte pas dans la largeur.
				stringWidth = math.min(criteria.Name:GetStringWidth() - textCheckWidth, maxContentWidth)
			end
			if criteria.Name:GetWidth() > maxContentWidth then
				criteria.Name:SetWidth(maxContentWidth)
			end
			criteria:SetParent(self)
			criteria:Show()
			criteria:SetWidth(stringWidth + CRITERIA_CHECK_WIDTH)
			maxCriteriaWidth = math.max(maxCriteriaWidth, stringWidth + CRITERIA_CHECK_WIDTH)
			numCriteriaRows = numCriteriaRows + 1
		end
	end

	if textStrings > 0 and progressBars > 0 then
		-- Barres en premier, critères texte en dessous.
		local first = self:GetCriteria(1)
		first:ClearAllPoints()
		if textStrings == 1 then
			first:SetPoint("TOP", self:GetProgressBar(progressBars), "BOTTOM", -14, -4)
		else
			first:SetPoint("TOP", self:GetProgressBar(progressBars), "BOTTOM", 0, -4)
			first:SetPoint("LEFT", self, "LEFT", 0, 0)
		end
	elseif textStrings > 1 then
		-- Plusieurs colonnes si les critères sont courts.
		local numColumns = math.floor(MAX_CONTENT_WIDTH / maxCriteriaWidth)
		local forceColumns = false
		if numColumns == 1 and textStrings >= FORCE_COLUMNS_MIN_CRITERIA and maxCriteriaWidth <= FORCE_COLUMNS_MAX_WIDTH then
			numColumns = 2
			forceColumns = true
		end
		if numColumns > 1 then
			local rows, position = 1, 0
			for i, criteria in ipairs(self.criterias) do
				position = position + 1
				if position > numColumns then
					position = position - numColumns
					rows = rows + 1
				end
				criteria:ClearAllPoints()
				if rows == 1 then
					local xOffset = 0
					if forceColumns then
						xOffset = position == 1 and FORCE_COLUMNS_LEFT_OFFSET or FORCE_COLUMNS_RIGHT_OFFSET
					end
					criteria:SetPoint("TOPLEFT", self, "TOPLEFT", (position - 1) * (MAX_CONTENT_WIDTH / numColumns) + xOffset, 0)
				else
					criteria:SetPoint("TOPLEFT", self.criterias[position + (rows - 2) * numColumns], "BOTTOMLEFT", 0, 0)
				end
			end
			numCriteriaRows = math.ceil(numCriteriaRows / numColumns)
		end
	end

	if firstMeta then
		local yOffsetMeta = -8 - numCriteriaRows * CRITERIA_ROW_HEIGHT
		if metas == 1 then
			firstMeta:SetPoint("TOP", self, "TOP", 0, yOffsetMeta)
		else
			firstMeta:SetPoint("TOPLEFT", self, "TOPLEFT", 20, yOffsetMeta)
		end
	end

	local height = numMetaRows * META_ROW_HEIGHT + numCriteriaRows * CRITERIA_ROW_HEIGHT
	if metas > 0 or progressBars > 0 then
		height = height + 10
	end
	self:SetHeight(height)
end

local function CreateObjectivesFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	Mixin(frame, Objectives)
	frame.pools = {
		criteria = CreateFramePool("Frame", frame, "HFFAchievementCriteriaTemplate"),
		progressBar = CreateFramePool("StatusBar", frame, "HFFAchievementProgressBarTemplate"),
		mini = CreateFramePool("Frame", frame, "HFFMiniAchievementTemplate"),
		meta = CreateFramePool("Button", frame, "HFFMetaCriteriaTemplate"),
	}
	-- Comme Blizzard (clearOnClose) : tout est libéré quand le cadre est caché.
	frame:SetScript("OnHide", frame.Clear)
	frame:Clear()
	frame:Hide()
	return frame
end

-- [[ Ligne de haut fait (AchievementTemplateMixin) ]]

local Button = {}

-- Hauteur d'une ligne dépliée, calculée avant affichage avec les textes
-- témoins (AchievementTemplateMixin.CalculateSelectedHeight).
local function CalculateSelectedHeight(elementData)
	local totalHeight = COLLAPSED_HEIGHT
	local objectivesHeight
	local placeholder = listFrame.PlaceholderName

	if not textCheckWidth then
		placeholder:SetText("- ")
		textCheckWidth = placeholder:GetStringWidth()
	end

	-- Par id et pas par index : l'index d'un haut fait change quand il est
	-- obtenu (les obtenus passent en tête de la catégorie).
	local id, _, _, completed, _, _, _, description, _, _, rewardText = API.GetAchievementInfo(elementData.id)
	if completed and API.GetPreviousAchievement(id) then
		local count = 1
		local previous = API.GetPreviousAchievement(id)
		while previous do
			count = count + 1
			previous = API.GetPreviousAchievement(previous)
		end
		objectivesHeight = math.ceil(count / MINIS_PER_ROW) * PROGRESSIVE_HEIGHT
	else
		local maxCriteriaWidth = 0
		local textStrings, progressBars, metas = 0, 0, 0
		local numMetaRows, numCriteriaRows = 0, 0
		for i = 1, API.GetAchievementNumCriteria(id) do
			local criteriaString, criteriaType, criteriaCompleted, _, _, _, flags, assetID = API.GetAchievementCriteriaInfo(id, i)
			if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then
				metas = metas + 1
				if metas == 1 or metas % 2 ~= 0 then
					numMetaRows = numMetaRows + 1
				end
			elseif bit.band(flags, CRITERIA_FLAG_PROGRESS_BAR) == CRITERIA_FLAG_PROGRESS_BAR then
				progressBars = progressBars + 1
				numCriteriaRows = numCriteriaRows + 1
			else
				textStrings = textStrings + 1
				local stringWidth, maxContentWidth
				if criteriaCompleted then
					maxContentWidth = MAX_CONTENT_WIDTH - CRITERIA_CHECK_WIDTH
					placeholder:SetText(criteriaString)
					stringWidth = math.min(placeholder:GetStringWidth(), maxContentWidth)
				else
					maxContentWidth = MAX_CONTENT_WIDTH - textCheckWidth
					placeholder:SetText("- " .. criteriaString)
					stringWidth = math.min(placeholder:GetStringWidth() - textCheckWidth, maxContentWidth)
				end
				if placeholder:GetWidth() > maxContentWidth then
					placeholder:SetWidth(maxContentWidth)
				end
				maxCriteriaWidth = math.max(maxCriteriaWidth, stringWidth + CRITERIA_CHECK_WIDTH)
				numCriteriaRows = numCriteriaRows + 1
			end
		end

		if textStrings > 1 and progressBars == 0 then
			local numColumns = math.floor(MAX_CONTENT_WIDTH / maxCriteriaWidth)
			if numColumns == 1 and textStrings >= FORCE_COLUMNS_MIN_CRITERIA and maxCriteriaWidth <= FORCE_COLUMNS_MAX_WIDTH then
				numColumns = 2
			end
			if numColumns > 1 then
				numCriteriaRows = math.ceil(numCriteriaRows / numColumns)
			end
		end

		objectivesHeight = numMetaRows * META_ROW_HEIGHT + numCriteriaRows * CRITERIA_ROW_HEIGHT
		if metas > 0 or progressBars > 0 then
			objectivesHeight = objectivesHeight + 10
		end
	end

	totalHeight = totalHeight + objectivesHeight

	listFrame.PlaceholderHiddenDescription:SetText(description)
	local descriptionHeight = listFrame.PlaceholderHiddenDescription:GetHeight()
	local numLines = math.ceil(descriptionHeight / fontHeight)
	if totalHeight ~= COLLAPSED_HEIGHT or numLines > MAX_LINES_COLLAPSED then
		totalHeight = totalHeight + descriptionHeight - DESCRIPTION_HEIGHT
		if rewardText ~= "" then
			totalHeight = totalHeight + 4
		end
	end
	return totalHeight
end

-- Infobulle du bouclier : haut fait de compte, et personnage qui l'a obtenu
-- (AchievementShield_OnEnter, plus le nom du personnage que nous enregistrons).
local function OnShieldEnter(shield)
	local button = shield:GetParent()
	GameTooltip:SetOwner(shield, "ANCHOR_RIGHT")
	if button.completed then
		GameTooltip:AddLine(L.ACCOUNT_WIDE_COMPLETED)
		if shield.earnedBy then
			GameTooltip_AddNormalLine(GameTooltip, L.EARNED_BY:format(shield.earnedBy))
		end
	else
		GameTooltip:AddLine(L.ACCOUNT_WIDE)
	end
	GameTooltip:Show()
	-- Le survol du bouclier compte comme le survol de la ligne.
	button:OnEnter()
end

local function OnShieldLeave(shield)
	GameTooltip:Hide()
	shield:GetParent():OnLeave()
end

-- Appelé une fois, à la création de la ligne par la ScrollBox.
function Button:OnLoad()
	self.DateCompleted = self.Shield.DateCompleted
	if not fontHeight then
		local _, height = self.Description:GetFont()
		fontHeight = height
	end
	self.Description:SetHeight(fontHeight * MAX_LINES_COLLAPSED)
	self.Description:SetWidth(MAX_CONTENT_WIDTH)
	self.HiddenDescription:SetWidth(MAX_CONTENT_WIDTH)

	self:SetScript("OnClick", self.OnClick)
	self:SetScript("OnEnter", self.OnEnter)
	self:SetScript("OnLeave", self.OnLeave)
	self.Shield:SetScript("OnClick", function()
		self:OnClick()
	end)
	self.Shield:SetScript("OnEnter", OnShieldEnter)
	self.Shield:SetScript("OnLeave", OnShieldLeave)

	self:Collapse()
end

function Button:OnClick()
	selectionBehavior:ToggleSelect(self)
end

function Button:OnEnter()
	self.Highlight:Show()
end

function Button:OnLeave()
	if not self:IsSelected() then
		self.Highlight:Hide()
	end
end

function Button:IsSelected()
	return SelectionBehaviorMixin.IsIntrusiveSelected(self)
end

function Button:SetSelected()
	self:Init(self:GetElementData())
end

-- Le « + » / « - » en haut à gauche, si la ligne a quelque chose à déplier.
function Button:UpdatePlusMinusTexture()
	if not self.id then
		return
	end
	local show = API.GetAchievementNumCriteria(self.id) ~= 0
		or (self.completed and API.GetPreviousAchievement(self.id))
	if not show then
		self.PlusMinus:Hide()
		return
	end
	self.PlusMinus:Show()
	if self.collapsed and self.saturatedStyle then
		self.PlusMinus:SetTexCoord(0, 0.5, 0, 0.25)
	elseif self.collapsed then
		self.PlusMinus:SetTexCoord(0.5, 1, 0, 0.25)
	elseif self.saturatedStyle then
		self.PlusMinus:SetTexCoord(0, 0.5, 0.25, 0.5)
	else
		self.PlusMinus:SetTexCoord(0.5, 1, 0.25, 0.5)
	end
end

function Button:UpdateBackgroundForHeight(height)
	self.Background:SetTexCoord(0, 1, math.max(0, 1 - (height / 256)), 1)
end

function Button:Collapse()
	if self.collapsed then
		return
	end
	self.collapsed = true
	self:UpdatePlusMinusTexture()
	self:SetHeight(COLLAPSED_HEIGHT)
	self:UpdateBackgroundForHeight(COLLAPSED_HEIGHT)
	self.Description:Show()
	self.HiddenDescription:Hide()
	if not self:IsMouseOver() then
		self.Highlight:Hide()
	end
end

function Button:Expand(height)
	if not self.collapsed and self:GetHeight() == height then
		return
	end
	self.collapsed = nil
	self:UpdatePlusMinusTexture()
	self:SetHeight(height)
	self:UpdateBackgroundForHeight(height)
	self.HiddenDescription:Show()
	self.Description:Hide()
end

-- Couleurs d'un haut fait obtenu.
function Button:Saturate()
	self.Background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal")
	if self.accountWide then
		self.TitleBar:SetTexture(ACCOUNT_HEADER_FILE)
		self.TitleBar:SetTexCoord(0, 1, 0, 0.375)
		self:SetBackdropBorderColor(unpack(BLUE_BORDER))
		self.saturatedStyle = "account"
	else
		self.TitleBar:SetTexture(BORDERS_FILE)
		self.TitleBar:SetTexCoord(0, 1, 0.66015625, 0.73828125)
		self:SetBackdropBorderColor(unpack(RED_BORDER))
		self.saturatedStyle = "normal"
	end
	self.Shield.Points:SetVertexColor(1, 1, 1)
	self.Glow:SetVertexColor(1, 1, 1)
	self.Icon.bling:SetVertexColor(1, 1, 1, 1)
	self.Icon.frame:SetVertexColor(1, 1, 1, 1)
	self.Icon.texture:SetVertexColor(1, 1, 1, 1)
	self.Shield.Icon:SetTexCoord(0, 0.5, 0, 0.5)
	self.Reward:SetVertexColor(1, 0.82, 0)
	self.Label:SetVertexColor(1, 1, 1)
	self.Description:SetTextColor(0, 0, 0, 1)
	self.Description:SetShadowOffset(0, 0)
	self:UpdatePlusMinusTexture()
end

-- Couleurs d'un haut fait pas encore obtenu (grisé).
function Button:Desaturate()
	self.saturatedStyle = nil
	self.Background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
	if self.accountWide then
		self.TitleBar:SetTexture(ACCOUNT_HEADER_FILE)
		self.TitleBar:SetTexCoord(0, 1, 0.40625, 0.78125)
	else
		self.TitleBar:SetTexture(BORDERS_FILE)
		self.TitleBar:SetTexCoord(0, 1, 0.91796875, 0.99609375)
	end
	self.Glow:SetVertexColor(0.22, 0.17, 0.13)
	self.Icon.bling:SetVertexColor(0.6, 0.6, 0.6, 1)
	self.Icon.frame:SetVertexColor(0.75, 0.75, 0.75, 1)
	self.Icon.texture:SetVertexColor(0.55, 0.55, 0.55, 1)
	self.Shield.Icon:SetTexCoord(0.5, 1, 0, 0.5)
	self.Shield.Points:SetVertexColor(0.65, 0.65, 0.65)
	self.Reward:SetVertexColor(1, 0.82, 0)
	self.Label:SetVertexColor(0.65, 0.65, 0.65)
	self.Description:SetTextColor(1, 1, 1, 1)
	self.Description:SetShadowOffset(1, -1)
	self:UpdatePlusMinusTexture()
	self:SetBackdropBorderColor(0.5, 0.5, 0.5)
end

function Button:InitRewards(rewardText)
	if rewardText == "" then
		self.Reward:Hide()
		self.RewardBackground:Hide()
		return
	end
	self.Reward:SetText(rewardText)
	self.Reward:Show()
	self.RewardBackground:Show()
	if self.completed then
		self.RewardBackground:SetVertexColor(1, 1, 1)
	else
		self.RewardBackground:SetVertexColor(0.35, 0.35, 0.35)
	end
end

-- Pose le cadre des critères dans la ligne et renvoie la hauteur dépliée
-- (AchievementTemplateMixin:DisplayObjectives).
function Button:DisplayObjectives(id, completed)
	objectives:Clear()
	objectives:SetParent(self)
	objectives.completed = completed
	if completed and API.GetPreviousAchievement(id) then
		objectives:DisplayProgressiveAchievement(id)
		objectives:SetPoint("TOP", self.HiddenDescription, "BOTTOM", 0, -8)
	else
		objectives:DisplayCriteria(id)
		if objectives:GetHeight() > 0 then
			objectives:SetPoint("TOP", self.HiddenDescription, "BOTTOM", 0, -8)
			objectives:SetPoint("LEFT", self.Icon, "RIGHT", -5, -25)
			objectives:SetPoint("RIGHT", self.Shield, "LEFT", -10, 0)
		end
	end
	objectives:Show()

	local height = COLLAPSED_HEIGHT + objectives:GetHeight()
	if height ~= COLLAPSED_HEIGHT or self.numLines > MAX_LINES_COLLAPSED then
		height = height + self.HiddenDescription:GetHeight() - DESCRIPTION_HEIGHT
		if self.Reward:IsShown() then
			height = height + 4
		end
	end
	objectives.id = id
	return height
end

-- Remplit la ligne (AchievementTemplateMixin:Init).
function Button:Init(elementData)
	self.index = elementData.index
	self.id = elementData.id
	self.completed = nil

	local id, name, points, completed, month, day, year, description, flags, icon, rewardText, _, _, earnedBy =
		API.GetAchievementInfo(elementData.id) -- par id, voir CalculateSelectedHeight

	local saturatedStyle
	if hasAccountHeader and bit.band(flags, FLAG_ACCOUNT) == FLAG_ACCOUNT then
		self.accountWide = true
		saturatedStyle = "account"
	else
		self.accountWide = nil
		saturatedStyle = "normal"
	end
	self.Label:SetWidth(LABEL_WIDTH)
	self.Label:SetText(name)

	-- Dans une série, le bouclier affiche le total des points de la série.
	if API.GetPreviousAchievement(id) then
		SetShieldPoints(GetProgressivePoints(id), self.Shield.Points)
	else
		SetShieldPoints(points, self.Shield.Points)
	end
	if points > 0 or not hasNoPointsShield then
		self.Shield.Icon:SetTexture(SHIELDS_FILE)
	else
		self.Shield.Icon:SetTexture(SHIELDS_NOPOINTS_FILE)
	end
	self.Shield.earnedBy = earnedBy

	self.Description:SetText(description)
	self.HiddenDescription:SetText(description)
	self.numLines = math.ceil(self.HiddenDescription:GetHeight() / fontHeight)
	self.Icon.texture:SetTexture(icon)

	if completed then
		self.completed = true
		self.DateCompleted:SetText(FormatShortDate(day, month, year))
		self.DateCompleted:Show()
		if self.saturatedStyle ~= saturatedStyle then
			self:Saturate()
		end
	else
		self.DateCompleted:Hide()
		self:Desaturate()
	end

	self:InitRewards(rewardText)
	self:UpdatePlusMinusTexture()

	if SelectionBehaviorMixin.IsElementDataIntrusiveSelected(elementData) then
		self:Expand(self:DisplayObjectives(id, self.completed))
		self.Highlight:Show()
	else
		if objectives.id == self.id then
			objectives:Hide()
		end
		if not self:IsMouseOver() then
			self.Highlight:Hide()
		end
		self:Collapse()
	end
end

-- [[ Liste ]]

-- Appelé une fois par MainWindow:Init.
function AchievementList:Init(frame)
	listFrame = frame
	listFrame.PlaceholderHiddenDescription:SetWidth(MAX_CONTENT_WIDTH)
	objectives = CreateObjectivesFrame(listFrame)

	hasAccountHeader = GetFileIDFromPath(ACCOUNT_HEADER_FILE) ~= nil
	hasNoPointsShield = GetFileIDFromPath(SHIELDS_NOPOINTS_FILE) ~= nil
	hasNoPointsMiniShield = GetFileIDFromPath(MINI_SHIELD_NOPOINTS_FILE) ~= nil

	local view = CreateScrollBoxListLinearView()
	view:SetElementExtentCalculator(function(_, elementData)
		if SelectionBehaviorMixin.IsElementDataIntrusiveSelected(elementData) then
			return CalculateSelectedHeight(elementData)
		end
		return COLLAPSED_HEIGHT
	end)
	view:SetElementInitializer(TEMPLATE, function(button, elementData)
		if not button.hffLoaded then
			Mixin(button, Button)
			button:OnLoad()
			button.hffLoaded = true
		end
		button:Init(elementData)
	end)
	-- Une ligne recyclée par la ScrollBox rend le cadre des critères.
	view:SetElementResetter(function(button)
		if SelectionBehaviorMixin.IsIntrusiveSelected(button) then
			objectives:Clear()
		end
	end)
	view:SetPadding(2, 0, 0, 4, 0)
	ScrollUtil.InitScrollBoxListWithScrollBar(listFrame.ScrollBox, listFrame.ScrollBar, view)

	selectionBehavior = ScrollUtil.AddSelectionBehavior(listFrame.ScrollBox,
		SelectionBehaviorFlags.Deselectable, SelectionBehaviorFlags.Intrusive)
	selectionBehavior:RegisterCallback(SelectionBehaviorMixin.Event.OnSelectionChanged, function(_, elementData, selected)
		local button = listFrame.ScrollBox:FindFrame(elementData)
		if button then
			button:SetSelected(selected)
		end
	end, AchievementList)

	ScrollUtil.AddResizableChildrenBehavior(listFrame.ScrollBox)
	Log.Debug("AchievementList: prête")
end

-- Affiche les hauts faits d'une catégorie (AchievementFrameAchievements_UpdateDataProvider).
function AchievementList:ShowCategory(categoryID)
	self.categoryID = categoryID
	local dataProvider = CreateDataProvider()
	local numAchievements = API.GetCategoryNumAchievements(categoryID)
	for index = 1, numAchievements do
		local id = API.GetAchievementInfo(categoryID, index)
		dataProvider:Insert({ category = categoryID, index = index, id = id })
	end
	listFrame.ScrollBox:SetDataProvider(dataProvider)
end

-- Déplie un haut fait de la catégorie affichée et le centre à l'écran
-- (AchievementFrame_SelectAndScrollToAchievementId).
function AchievementList:SelectAchievement(achievementID)
	local dataProvider = listFrame.ScrollBox:GetDataProvider()
	if not dataProvider then
		return
	end
	local elementData = dataProvider:FindElementDataByPredicate(function(data)
		return data.id == achievementID
	end)
	if elementData then
		selectionBehavior:SelectElementData(elementData)
		-- Le dépliage change la hauteur : mise à jour avant de centrer.
		listFrame.ScrollBox:FullUpdate(ScrollBoxConstants.UpdateImmediately)
		listFrame.ScrollBox:ScrollToElementData(elementData, ScrollBoxConstants.AlignCenter)
	end
end

-- Redessine la catégorie affichée (haut fait obtenu fenêtre ouverte), en
-- gardant dépliée la ligne qui l'était.
function AchievementList:Refresh()
	if not self.categoryID then
		return
	end
	local selectedData = selectionBehavior:GetFirstSelectedElementData()
	local selectedID = selectedData and selectedData.id
	self:ShowCategory(self.categoryID)
	if selectedID then
		self:SelectAchievement(selectedID)
	end
end
