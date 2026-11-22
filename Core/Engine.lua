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
	"UPDATE_FACTION",           -- réputations
	"PLAYER_EQUIPMENT_CHANGED", -- tabard, qualité de l'équipement
	"NEW_PET_ADDED",            -- mascottes
	"NEW_MOUNT_ADDED",          -- montures
	"NEW_RECIPE_LEARNED",       -- recettes de métier
}

-- Boss vaincu : la victoire est enregistrée (Database:RecordBossKill) avant
-- l'évaluation. Les deux événements arrivent souvent pour la même victoire ;
-- l'enregistrer deux fois ne change rien.
local BOSS_EVENTS = {
	"ENCOUNTER_END",            -- encounterID, nom, difficulté, taille, success (1 = victoire)
	"BOSS_KILL",                -- encounterID, nom
}

-- Historique du butin (C_LootHistory) : un objet a reçu des jets. Les jets
-- de 100 du joueur sont enregistrés (Database:RecordPerfectRoll) avant
-- l'évaluation.
local LOOT_EVENTS = {
	"LOOT_HISTORY_UPDATE_DROP",     -- encounterID, lootListKey
	"LOOT_HISTORY_ONE_HUNDRED_ROLL", -- encounterID, lootListKey
}

-- Coiffeur : nouvelle apparence validée. La coupe est enregistrée
-- (Database:RecordHaircut) avant l'évaluation. Les deux événements peuvent
-- arriver pour la même coupe ; l'enregistrer deux fois ne change rien.
local BARBER_EVENTS = {
	"BARBER_SHOP_APPEARANCE_APPLIED",
	"BARBER_SHOP_RESULT",           -- success
}

-- Types de jet (Enum.EncounterLootDropRollState) : besoin (spé principale
-- ou secondaire) et cupidité. Valeurs de repli : celles de la documentation
-- de l'API de Forever.
local ROLL_STATE = Enum and Enum.EncounterLootDropRollState or {}
local ROLL_KINDS = {
	[ROLL_STATE.NeedMainSpec or 0] = "need",
	[ROLL_STATE.NeedOffSpec or 1] = "need",
	[ROLL_STATE.Greed or 3] = "greed",
}
local PERFECT_ROLL = 100
-- Qualité supérieure (bleu) ou mieux, comme le haut fait d'origine.
local MIN_ROLL_QUALITY = Enum and Enum.ItemQuality and Enum.ItemQuality.Rare or 3

local eventFrame = CreateFrame("Frame")
local loginTime = nil          -- GetTime() à la connexion
local playerGUID = nil         -- clé du personnage dans la progression
local pendingReason = nil      -- évaluation programmée, avec sa raison
local forceRetroactive = false -- demandé par /hff reset
local listeners = {}
local evaluationListeners = {}

-- callback(achievementIDs, retroactive) est appelé une fois par évaluation
-- qui a obtenu au moins un haut fait (toasts, fenêtre).
function Engine:RegisterListener(callback)
	listeners[#listeners + 1] = callback
end

-- callback() est appelé après chaque évaluation, même sans haut fait obtenu :
-- la progression a pu changer (suivi des objectifs).
function Engine:RegisterEvaluationListener(callback)
	evaluationListeners[#evaluationListeners + 1] = callback
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
		local total = ns.Database:UpdateProgress(criterion.progressKey, playerGUID,
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

-- Note le tabard porté (critère « tabards ») : à la connexion et à chaque
-- changement d'équipement, qui demandent tous deux une évaluation. Un
-- tabard en double (Data/Tabards.lua) est noté sous son numéro retenu, pour
-- ne compter qu'une fois.
local function RecordEquippedTabard()
	local itemID = GetInventoryItemID("player", INVSLOT_TABARD or 19)
	if type(itemID) == "number" then
		itemID = ns.Data.tabardAliases[itemID] or itemID
		ns.Database:RecordTabard(itemID, playerGUID)
	end
end

local function RunEvaluation(reason)
	if InCombatLockdown() then
		Log.Debug("Engine: en combat, évaluation reportée (" .. reason .. ")")
		pendingReason = reason
		eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end
	RecordEquippedTabard()

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

	for _, callback in ipairs(evaluationListeners) do
		local ok, message = pcall(callback)
		if not ok then
			Log.Error(L.ENGINE_LISTENER_ERROR, message)
		end
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

-- Une valeur « secrète » (masquée aux addons pendant certains combats) ne
-- peut pas être lue : la victoire est alors ignorée.
local function IsReadableNumber(value)
	if issecretvalue and issecretvalue(value) then
		return false
	end
	return type(value) == "number" and value > 0
end

local function RecordBossKill(encounterID, encounterName)
	if not IsReadableNumber(encounterID) then
		return false
	end
	ns.Database:RecordBossKill(encounterID, playerGUID)
	Log.Debug("Engine: boss vaincu", encounterID, encounterName)
	return true
end

local function IsSecret(value)
	return issecretvalue ~= nil and issecretvalue(value)
end

-- Qualité d'un objet par son lien : l'API, sinon la couleur du lien
-- (« |cnIQ3: »), si l'objet n'est pas encore en cache.
local function GetLinkQuality(link)
	local quality = C_Item and C_Item.GetItemQualityByID and C_Item.GetItemQualityByID(link)
	if type(quality) == "number" then
		return quality
	end
	return tonumber(link:match("|cnIQ(%d):"))
end

-- Jets de 100 du joueur sur cet objet ; true si au moins un est enregistré.
local function RecordPerfectRolls(encounterID, lootListKey)
	if not (C_LootHistory and C_LootHistory.GetSortedInfoForDrop) then
		return false
	end
	if type(encounterID) ~= "number" or type(lootListKey) ~= "number"
		or IsSecret(encounterID) or IsSecret(lootListKey) then
		return false
	end
	local info = C_LootHistory.GetSortedInfoForDrop(encounterID, lootListKey)
	if type(info) ~= "table" or type(info.itemHyperlink) ~= "string" then
		return false
	end
	local quality = GetLinkQuality(info.itemHyperlink)
	if not quality or quality < MIN_ROLL_QUALITY then
		return false
	end
	local recorded = false
	for _, rollInfo in ipairs(info.rollInfos or {}) do
		local roll, state = rollInfo.roll, rollInfo.state
		if rollInfo.isSelf and not IsSecret(roll) and roll == PERFECT_ROLL then
			local kind = ROLL_KINDS[state]
			if kind then
				ns.Database:RecordPerfectRoll(kind, playerGUID)
				Log.Debug("Engine: jet de 100", kind, info.itemHyperlink)
				recorded = true
			end
		end
	end
	return recorded
end

-- Rares tués (critère « rare »). Le jeu n'en garde aucune trace : un rare
-- compte quand il meurt en cible sans être pris par un autre joueur
-- (UnitIsTapDenied), ou quand on fouille son cadavre. Chaque créature
-- (GUID) n'est comptée qu'une fois par session.
local rareNpcs = {}      -- [npcID] = true : les rares des critères « rare »
local countedRares = {}  -- [GUID] = true : créatures déjà comptées
local watchedRare = nil  -- GUID de la cible rare vivante surveillée

-- Numéro de créature d'un GUID « Creature-0-serveur-instance-zone-npcID-... ».
local function GetNpcID(guid)
	if type(guid) ~= "string" or IsSecret(guid) then
		return nil
	end
	local kind, _, _, _, _, npcID = strsplit("-", guid)
	if kind == "Creature" or kind == "Vehicle" then
		return tonumber(npcID)
	end
	return nil
end

local function CountRare(guid)
	local npcID = GetNpcID(guid)
	if not npcID or not rareNpcs[npcID] or countedRares[guid] then
		return
	end
	countedRares[guid] = true
	if ns.Database:RecordRareKill(npcID, playerGUID) then
		Log.Debug("Engine: rare tué", npcID)
		Engine:RequestEvaluation("rare")
	end
end

-- Mort de la cible et prise par un autre joueur ; nil si illisible.
local function ReadTargetDeath()
	local dead, denied = UnitIsDead("target"), UnitIsTapDenied("target")
	if IsSecret(dead) or IsSecret(denied) then
		return nil
	end
	return dead, denied
end

local function StopWatchingRare()
	watchedRare = nil
	eventFrame:UnregisterEvent("UNIT_HEALTH")
end

-- Nouvelle cible : un rare déjà mort est compté tout de suite, un rare
-- vivant est surveillé jusqu'à sa mort (UNIT_HEALTH).
local function OnTargetChanged()
	StopWatchingRare()
	local guid = UnitGUID("target")
	local npcID = GetNpcID(guid)
	if not npcID or not rareNpcs[npcID] or countedRares[guid] then
		return
	end
	local dead, denied = ReadTargetDeath()
	if dead == nil then
		return
	end
	if dead then
		if not denied then
			CountRare(guid)
		end
		return
	end
	watchedRare = guid
	eventFrame:RegisterUnitEvent("UNIT_HEALTH", "target")
end

local function OnTargetHealth()
	local guid = UnitGUID("target")
	if IsSecret(guid) or guid ~= watchedRare then
		return
	end
	local dead, denied = ReadTargetDeath()
	if not dead then
		return
	end
	if not denied then
		CountRare(guid)
	end
	StopWatchingRare()
end

-- Fenêtre de butin : chaque créature fouillée compte. GetLootSourceInfo
-- renvoie GUID, quantité, GUID, quantité... pour chaque emplacement.
local function OnLootReady()
	for slot = 1, GetNumLootItems() do
		local sources = { GetLootSourceInfo(slot) }
		for index = 1, #sources, 2 do
			CountRare(sources[index])
		end
	end
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
	if event == "PLAYER_TARGET_CHANGED" then
		OnTargetChanged()
		return
	end
	if event == "UNIT_HEALTH" then
		OnTargetHealth()
		return
	end
	if event == "LOOT_READY" then
		OnLootReady()
		return
	end
	if event == "LOOT_HISTORY_UPDATE_DROP" or event == "LOOT_HISTORY_ONE_HUNDRED_ROLL" then
		if RecordPerfectRolls(...) then
			Engine:RequestEvaluation(event)
		end
		return
	end
	if event == "BARBER_SHOP_APPEARANCE_APPLIED" or event == "BARBER_SHOP_RESULT" then
		local success = ...
		if event == "BARBER_SHOP_RESULT" and success ~= true then
			return
		end
		ns.Database:RecordHaircut(playerGUID)
		Log.Debug("Engine: nouvelle coupe", event)
		Engine:RequestEvaluation(event)
		return
	end
	if event == "ENCOUNTER_END" then
		local encounterID, encounterName, _, _, success = ...
		if success == 1 and RecordBossKill(encounterID, encounterName) then
			Engine:RequestEvaluation(event)
		end
		return
	end
	if event == "BOSS_KILL" then
		if RecordBossKill(...) then
			Engine:RequestEvaluation(event)
		end
		return
	end
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
	for _, event in ipairs(BOSS_EVENTS) do
		eventFrame:RegisterEvent(event)
	end
	-- Rares : ceux des critères « rare » chargés par le registre.
	for _, achievement in ns.Registry:Iterate() do
		for _, criterion in ipairs(achievement.criteria) do
			if criterion.type == "rare" then
				rareNpcs[criterion.id] = true
			end
		end
	end
	eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	eventFrame:RegisterEvent("LOOT_READY")
	-- pcall : un événement absent du client lèverait une erreur.
	for _, event in ipairs(LOOT_EVENTS) do
		if not pcall(eventFrame.RegisterEvent, eventFrame, event) then
			Log.Debug("Engine: événement absent", event)
		end
	end
	for _, event in ipairs(BARBER_EVENTS) do
		if not pcall(eventFrame.RegisterEvent, eventFrame, event) then
			Log.Debug("Engine: événement absent", event)
		end
	end
	C_Timer.After(INITIAL_DELAY_SECONDS, function()
		Engine:RequestEvaluation("connexion")
	end)
	Log.Debug("Engine: démarré")
end
