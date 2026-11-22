-- Suivi des hauts faits dans le suivi des objectifs de Blizzard
-- (ObjectiveTrackerFrame), comme le module des hauts faits du jeu
-- (Blizzard_AchievementObjectiveTracker.lua), avec nos données.
--
--   - Liste par personnage, MAX_TRACKED hauts faits au plus
--     (Database:GetTracked).
--   - Module rangé juste après celui des hauts faits de Blizzard.
--   - Pour chaque haut fait : son nom, puis ses conditions non remplies
--     (MAX_CRITERIA au plus, puis « ... »).
--   - Clic : ouvre la fenêtre sur le haut fait ; Maj + clic : ne plus le
--     suivre ; clic droit : menu.
--   - Mis à jour à chaque évaluation du moteur ; un haut fait obtenu sort
--     du suivi.
-- Le cadre est dans UI/Tracker.xml, chargé après ce fichier.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Tracker = {}
ns.Tracker = Tracker

local MAX_TRACKED = 10
local MAX_CRITERIA = 5
local CRITERIA_TYPE_ACHIEVEMENT = "achievement"
local CRITERIA_FLAG_PROGRESS_BAR = 0x00000001
-- Rang après le module des hauts faits de Blizzard (son uiOrder + 0,5).
local ORDER_AFTER_BLIZZARD = 0.5
local DEFAULT_BLIZZARD_ORDER = 6
local REGISTER_RETRY_SECONDS = 1

local function ShowError(message)
	UIErrorsFrame:AddMessage(message, 1.0, 0.1, 0.1, 1.0)
end

local function GetModule()
	return HFFAchievementTracker
end

local function Refresh()
	local module = GetModule()
	if module then
		module:MarkDirty()
	end
end

function Tracker:IsTracked(achievementID)
	return ns.Database:IsTracked(achievementID)
end

-- Ajoute ou retire un haut fait du suivi. true s'il est suivi après l'appel.
function Tracker:Toggle(achievementID)
	if ns.Database:IsTracked(achievementID) then
		self:Untrack(achievementID)
		return false
	end
	if #ns.Database:GetTracked() >= MAX_TRACKED then
		ShowError(L.TRACK_TOO_MANY:format(MAX_TRACKED))
		return false
	end
	local completed
	ns.API.RunAsSelf(function()
		completed = select(4, ns.API.GetAchievementInfo(achievementID))
	end)
	if completed then
		ShowError(L.TRACK_COMPLETED)
		return false
	end
	ns.Database:SetTracked(achievementID, true)
	Refresh()
	return true
end

function Tracker:Untrack(achievementID)
	ns.Database:SetTracked(achievementID, false)
	Refresh()
	-- La case « Suivre » de la fenêtre suit.
	if ns.AchievementList.Refresh and HFFAchievementFrame and HFFAchievementFrame:IsShown() then
		ns.AchievementList:Refresh()
	end
end

-- [[ Module du suivi des objectifs ]]

local settings = {
	headerText = L.TRACKER_HEADER,
	blockTemplate = "ObjectiveTrackerAnimBlockTemplate",
	lineTemplate = "ObjectiveTrackerAnimLineTemplate",
}

HFFAchievementTrackerMixin = CreateFromMixins(ObjectiveTrackerModuleMixin, settings)

-- Texte d'une condition, comme le module de Blizzard : « x/y nom » pour une
-- barre de progression, le nom du haut fait visé pour un méta.
local function GetCriterionText(criteriaString, criteriaType, flags, assetID, quantityString)
	if bit.band(flags, CRITERIA_FLAG_PROGRESS_BAR) == CRITERIA_FLAG_PROGRESS_BAR then
		return (quantityString:gsub(" / ", "/")) .. " " .. criteriaString
	end
	if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then
		local _, name = ns.API.GetAchievementInfo(assetID)
		return name or criteriaString
	end
	return criteriaString
end

function HFFAchievementTrackerMixin:AddAchievement(achievementID, name)
	local block = self:GetBlock(achievementID)
	block:SetHeader(name)
	local colorStyle = OBJECTIVE_TRACKER_COLOR["Normal"]
	local numCriteria = ns.API.GetAchievementNumCriteria(achievementID)
	local numShown, numIncomplete = 0, 0
	for index = 1, numCriteria do
		local _, _, criteriaCompleted = ns.API.GetAchievementCriteriaInfo(achievementID, index)
		if not criteriaCompleted then
			numIncomplete = numIncomplete + 1
		end
	end
	for index = 1, numCriteria do
		local criteriaString, criteriaType, criteriaCompleted, _, _, _, flags, assetID, quantityString =
			ns.API.GetAchievementCriteriaInfo(achievementID, index)
		if not criteriaCompleted then
			if numShown == MAX_CRITERIA and numIncomplete > MAX_CRITERIA then
				block:AddObjective("Extra", "...", nil, nil, OBJECTIVE_DASH_STYLE_HIDE)
				break
			end
			local text = GetCriterionText(criteriaString, criteriaType, flags, assetID, quantityString)
			block:AddObjective(index, text, nil, nil, OBJECTIVE_DASH_STYLE_SHOW, colorStyle)
			numShown = numShown + 1
		end
	end
	return self:LayoutBlock(block)
end

function HFFAchievementTrackerMixin:LayoutContents()
	-- Les données du joueur, même si la fenêtre inspecte un autre joueur.
	ns.API.RunAsSelf(function()
		for _, achievementID in ipairs(ns.Database:GetTracked()) do
			local _, name, _, completed = ns.API.GetAchievementInfo(achievementID)
			if name and not completed then
				if not self:AddAchievement(achievementID, name) then
					return
				end
			end
		end
	end)
end

local function OpenAchievement(achievementID)
	-- En cours d'inspection : retour à ses propres hauts faits d'abord.
	if ns.API.GetInspectedName() then
		ns.MainWindow:Hide()
	end
	ns.MainWindow:ShowAchievement(achievementID)
end

function HFFAchievementTrackerMixin:OnBlockHeaderClick(block, mouseButton)
	local achievementID = block.id
	if IsModifiedClick("QUESTWATCHTOGGLE") then
		Tracker:Untrack(achievementID)
	elseif mouseButton ~= "RightButton" then
		OpenAchievement(achievementID)
	else
		MenuUtil.CreateContextMenu(self:GetContextMenuParent(), function(_, rootDescription)
			local name
			ns.API.RunAsSelf(function()
				name = select(2, ns.API.GetAchievementInfo(achievementID))
			end)
			rootDescription:CreateTitle(name or "")
			rootDescription:CreateButton(L.TRACKER_VIEW, function()
				OpenAchievement(achievementID)
			end)
			rootDescription:CreateButton(L.TRACKER_STOP, function()
				Tracker:Untrack(achievementID)
			end)
		end)
	end
end

-- Rattache le module au suivi des objectifs, une fois celui-ci prêt
-- (ObjectiveTrackerManager:Init, après PLAYER_ENTERING_WORLD et
-- VARIABLES_LOADED).
local function Register()
	local module = GetModule()
	local manager, container = ObjectiveTrackerManager, ObjectiveTrackerFrame
	if not module or not manager or not container then
		Log.Debug("Tracker: suivi des objectifs absent")
		return
	end
	if not manager.containers or not manager.containers[container] then
		C_Timer.After(REGISTER_RETRY_SECONDS, Register)
		return
	end
	if not manager.canAddModules then
		return
	end
	local blizzard = AchievementObjectiveTracker
	module.uiOrder = (blizzard and blizzard.uiOrder or DEFAULT_BLIZZARD_ORDER) + ORDER_AFTER_BLIZZARD
	manager:SetModuleContainer(module, container)
	Log.Debug("Tracker: module rattaché")
end

-- Appelé à ADDON_LOADED.
function Tracker:Init()
	if not GetModule() then
		return
	end
	EventUtil.ContinueAfterAllEvents(Register, "PLAYER_ENTERING_WORLD", "VARIABLES_LOADED")
	ns.Engine:RegisterEvaluationListener(Refresh)
	ns.Engine:RegisterListener(function(achievementIDs)
		for _, achievementID in ipairs(achievementIDs) do
			ns.Database:UntrackEverywhere(achievementID)
		end
		Refresh()
	end)
end
