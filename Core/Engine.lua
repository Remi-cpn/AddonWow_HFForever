-- Moteur de détection : évalue les critères et enregistre les hauts faits
-- obtenus.
--
--   1. Quelques secondes après la connexion, un scan complet lit l'état du
--      personnage : c'est la détection rétroactive.
--   2. Ensuite, les événements de WATCHED_EVENTS demandent une nouvelle
--      évaluation ; les demandes rapprochées sont regroupées.
--   3. Pas d'évaluation en combat, où certaines valeurs sont illisibles
--      (secret values) : elle attend la fin du combat.
--
-- Ce qui est obtenu pendant la première minute est marqué rétroactif : déjà
-- accompli avant la connexion, date réelle inconnue, annoncé par un seul
-- résumé au lieu d'un message par haut fait.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Engine = {}
ns.Engine = Engine

local INITIAL_DELAY_SECONDS = 3   -- laisse le jeu charger les statistiques
local THROTTLE_SECONDS = 1        -- regroupe les événements rapprochés
local RETROACTIVE_WINDOW = 60     -- secondes après la connexion
local MAX_PASSES = 5              -- passes successives pour les métas

-- Événements qui peuvent faire progresser un critère.
local WATCHED_EVENTS = {
	"PLAYER_LEVEL_UP",          -- niveau
	"QUEST_TURNED_IN",          -- quêtes (la statistique suit)
	"CRITERIA_UPDATE",          -- statistiques (boss vaincus, quêtes)
	"MAP_EXPLORATION_UPDATED",  -- exploration
	"SKILL_LINES_CHANGED",      -- métiers
}

local eventFrame = CreateFrame("Frame")
local loginTime = nil          -- GetTime() à la connexion
local playerGUID = nil         -- clé du personnage dans la progression
local pendingReason = nil      -- évaluation programmée, avec sa raison
local forceRetroactive = false -- demandé par /hff reset
local listeners = {}

-- callback(achievementIDs, retroactive) est appelé une fois par évaluation
-- qui a obtenu au moins un haut fait (toasts, fenêtre).
function Engine:RegisterListener(callback)
	listeners[#listeners + 1] = callback
end

local function GetCharacterName()
	local name, realm = UnitFullName("player")
	if realm and realm ~= "" then
		return name .. "-" .. realm
	end
	return name
end

local function IsInRetroactiveWindow()
	return forceRetroactive or (loginTime ~= nil and GetTime() - loginTime < RETROACTIVE_WINDOW)
end

-- Enregistre la progression de chaque critère ; true si tous sont remplis.
local function EvaluateAchievement(achievement)
	local allDone = true
	for index, criterion in ipairs(achievement.criteria) do
		local criteriaType = ns.CriteriaTypes[criterion.type]
		-- pcall : une erreur dans un critère ne bloque pas le reste du scan.
		local ok, current = pcall(criteriaType.current, criterion)
		if not ok or type(current) ~= "number" then
			Log.Error(L.ENGINE_CRITERIA_ERROR, achievement.id, index, current)
			current = 0
		end
		local total = ns.Database:UpdateProgress(achievement.id, index, playerGUID,
			current, criterion.combine)
		if total < criteriaType.goal(criterion) then
			allDone = false
		end
	end
	return allDone
end

local function NotifyListeners(achievementIDs, retroactive)
	for _, callback in ipairs(listeners) do
		local ok, message = pcall(callback, achievementIDs, retroactive)
		if not ok then
			Log.Error(L.ENGINE_LISTENER_ERROR, message)
		end
	end
end

local function AnnounceEarned(achievement)
	Log.Info(L.ENGINE_EARNED, achievement.name, achievement.points)
end

local function RunEvaluation(reason)
	if InCombatLockdown() then
		Log.Debug("Engine: en combat, évaluation reportée (" .. reason .. ")")
		pendingReason = reason
		eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	local startTime = debugprofilestop()
	local retroactive = IsInRetroactiveWindow()
	local character = GetCharacterName()
	local earned = {}

	-- Plusieurs passes : un méta peut dépendre d'un haut fait obtenu dans la
	-- même évaluation (zone, puis continent, puis Explorateur).
	for pass = 1, MAX_PASSES do
		local earnedThisPass = 0
		for id, achievement in ns.Registry:Iterate() do
			if not ns.Database:GetCompletion(id) and EvaluateAchievement(achievement) then
				ns.Database:SetCompleted(id, character, retroactive)
				earned[#earned + 1] = achievement
				earnedThisPass = earnedThisPass + 1
				Log.Debug("Engine: obtenu", id, achievement.name, "passe", pass,
					retroactive and "(rétroactif)" or "")
			end
		end
		if earnedThisPass == 0 then
			break
		end
	end

	if retroactive then
		if #earned > 0 then
			Log.Info(L.ENGINE_RETRO_SUMMARY, #earned)
		end
	else
		for _, achievement in ipairs(earned) do
			AnnounceEarned(achievement)
		end
	end
	if #earned > 0 then
		local ids = {}
		for index, achievement in ipairs(earned) do
			ids[index] = achievement.id
		end
		NotifyListeners(ids, retroactive)
	end

	forceRetroactive = false
	Log.Debug(("Engine: évaluation (%s) en %.1f ms, %d nouveau(x)"):format(
		reason, debugprofilestop() - startTime, #earned))
end

-- Les demandes reçues avant le départ de l'évaluation sont regroupées.
function Engine:RequestEvaluation(reason)
	if pendingReason then
		return
	end
	pendingReason = reason
	C_Timer.After(THROTTLE_SECONDS, function()
		local currentReason = pendingReason
		pendingReason = nil
		RunEvaluation(currentReason)
	end)
end

-- Après /hff reset : la prochaine évaluation est traitée comme rétroactive.
function Engine:RequestRetroactiveScan()
	forceRetroactive = true
	self:RequestEvaluation("rescan")
end

eventFrame:SetScript("OnEvent", function(_, event)
	if event == "PLAYER_REGEN_ENABLED" then
		eventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
		local reason = pendingReason or "fin du combat"
		pendingReason = nil
		Engine:RequestEvaluation(reason)
		return
	end
	Engine:RequestEvaluation(event)
end)

-- Appelé au PLAYER_LOGIN : branche les événements et lance le scan initial.
function Engine:Start()
	loginTime = GetTime()
	-- Lu une fois, hors combat. Le GUID ne change pas si le personnage est
	-- renommé ou change de royaume.
	playerGUID = UnitGUID("player") or GetCharacterName()
	for _, event in ipairs(WATCHED_EVENTS) do
		eventFrame:RegisterEvent(event)
	end
	C_Timer.After(INITIAL_DELAY_SECONDS, function()
		Engine:RequestEvaluation("connexion")
	end)
	Log.Debug("Engine: démarré")
end
