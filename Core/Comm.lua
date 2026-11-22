-- Échanges entre joueurs qui ont HF Forever, par messages d'addon chuchotés
-- (C_ChatInfo.SendAddonMessage, canal WHISPER : invisibles dans le chat).
--
-- Protocole, version PROTOCOL. Un message = « version:type:champ:... »
-- (« : » plutôt que « | », caractère d'échappement du chat) :
--   REQ            demande du résumé
--   SUM:p:n        réponse : p points, n hauts faits obtenus
--   LST            demande de la liste des hauts faits obtenus
--   DAT:i:t:liste  réponse en t morceaux, voici le i-ème ; liste =
--                  « id.date,id.date... », nombres en base 36, date en
--                  secondes (time())
-- Un message d'une autre version ou d'un type inconnu est ignoré : une
-- version plus récente de l'addon peut ajouter des types sans casser les
-- anciennes.
--
-- Limites, pour rester sous le seuil d'envoi du serveur :
--   - une demande de résumé toutes les SEND_INTERVAL secondes ;
--   - pas de nouvelle demande au même joueur avant RETRY_SECONDS ;
--   - une réponse au plus par joueur toutes les REPLY_INTERVAL secondes
--     (LIST_REPLY_INTERVAL pour la liste) ;
--   - les morceaux de la liste partent à CHUNK_DELAY secondes d'écart ;
--   - un résumé ou une liste reçus restent valables CACHE_SECONDS.
-- Pendant les restrictions de messagerie (C_ChatInfo.InChatMessagingLockdown,
-- en combat ou en instance), rien n'est envoyé.
local _, ns = ...

local Log = ns.Log

local Comm = {}
ns.Comm = Comm

local PREFIX = "HFForever"
local PROTOCOL = 1
local SEPARATOR = ":"
local LIST_SEPARATOR = ","
local PAIR_SEPARATOR = "."

local CACHE_SECONDS = 300
local RETRY_SECONDS = 30
local SEND_INTERVAL = 1
local REPLY_INTERVAL = 10
local LIST_REPLY_INTERVAL = 30
local LIST_TIMEOUT = 15
local CHUNK_DELAY = 0.3
-- Un message d'addon fait au plus 255 caractères : place pour l'en-tête.
local MAX_PAYLOAD = 230

local SEND_SUCCESS = Enum and Enum.SendAddonMessageResult
	and Enum.SendAddonMessageResult.Success or 0

local eventFrame = CreateFrame("Frame")
local summaries = {}   -- [« Nom-Royaume »] = { points, count, time }
local requested = {}   -- [« Nom-Royaume »] = GetTime() de la dernière demande
local replied = {}     -- [« Nom-Royaume »] = GetTime() de la dernière réponse
local lastSend = 0
local listeners = {}
local lists = {}        -- [« Nom-Royaume »] = { completed, time } reçues
local incoming = {}     -- [« Nom-Royaume »] = { total, parts = {} } en cours
local pendingLists = {} -- [« Nom-Royaume »] = callback de RequestList
local listReplied = {}  -- [« Nom-Royaume »] = GetTime() de la dernière liste envoyée

local function IsSecret(value)
	return issecretvalue ~= nil and issecretvalue(value)
end

-- « Nom-Royaume », la forme de l'expéditeur dans CHAT_MSG_ADDON : royaume
-- normalisé (sans espaces ni tirets, comme GetNormalizedRealmName). Un nom
-- sans royaume est du royaume du joueur.
function Comm.FullName(name, realm)
	if type(name) ~= "string" or name == "" or IsSecret(name) then
		return nil
	end
	local base, nameRealm = name:match("^([^-]+)-(.+)$")
	if base then
		name, realm = base, nameRealm
	end
	if type(realm) ~= "string" or realm == "" or IsSecret(realm) then
		realm = GetNormalizedRealmName()
	end
	if type(realm) ~= "string" or realm == "" then
		return nil
	end
	return name .. "-" .. (realm:gsub("[%s%-]", ""))
end

local function IsLockedDown()
	return C_ChatInfo.InChatMessagingLockdown ~= nil and C_ChatInfo.InChatMessagingLockdown()
end

-- true si le message est parti.
local function Send(target, ...)
	if IsLockedDown() then
		return false
	end
	local message = table.concat({ PROTOCOL, ... }, SEPARATOR)
	local ok, result = pcall(C_ChatInfo.SendAddonMessage, PREFIX, message, "WHISPER", target)
	-- Code de retour (Enum.SendAddonMessageResult), ou true sur les clients
	-- plus anciens.
	if not ok or (result ~= SEND_SUCCESS and result ~= true) then
		Log.Debug("Comm: envoi refusé", target, ok and tostring(result) or result)
		return false
	end
	return true
end

-- callback(name) est appelé quand un résumé arrive pour name.
function Comm:RegisterListener(callback)
	listeners[#listeners + 1] = callback
end

-- points, count si un résumé récent est connu pour ce joueur, sinon nil.
function Comm:GetSummary(name)
	local summary = summaries[name]
	if summary and GetTime() - summary.time < CACHE_SECONDS then
		return summary.points, summary.count
	end
	return nil
end

-- Demande le résumé d'un joueur, si les limites le permettent.
function Comm:RequestSummary(name)
	if not name or self:GetSummary(name) then
		return
	end
	local now = GetTime()
	if now - (requested[name] or -RETRY_SECONDS) < RETRY_SECONDS
		or now - lastSend < SEND_INTERVAL then
		return
	end
	if Send(name, "REQ") then
		requested[name] = now
		lastSend = now
	end
end

-- Le partage est toujours actif : tout joueur qui a HF Forever répond.
local function OnRequest(sender)
	local now = GetTime()
	if now - (replied[sender] or -REPLY_INTERVAL) < REPLY_INTERVAL then
		return
	end
	if Send(sender, "SUM", ns.API.GetOwnSummary()) then
		replied[sender] = now
	end
end

local DIGITS = "0123456789abcdefghijklmnopqrstuvwxyz"

local function ToBase36(number)
	if number <= 0 then
		return "0"
	end
	local text = ""
	while number > 0 do
		local digit = number % 36
		text = DIGITS:sub(digit + 1, digit + 1) .. text
		number = math.floor(number / 36)
	end
	return text
end

-- Liste des hauts faits obtenus, découpée en morceaux de MAX_PAYLOAD.
local function BuildChunks()
	local ids = {}
	local dates = ns.API.GetOwnCompletionDates()
	for id in pairs(dates) do
		ids[#ids + 1] = id
	end
	table.sort(ids)
	local chunks, current = {}, ""
	for _, id in ipairs(ids) do
		local pair = ToBase36(id) .. PAIR_SEPARATOR .. ToBase36(dates[id])
		if current ~= "" and #current + #pair + 1 > MAX_PAYLOAD then
			chunks[#chunks + 1] = current
			current = ""
		end
		current = current == "" and pair or (current .. LIST_SEPARATOR .. pair)
	end
	chunks[#chunks + 1] = current
	return chunks
end

local function OnListRequest(sender)
	local now = GetTime()
	if now - (listReplied[sender] or -LIST_REPLY_INTERVAL) < LIST_REPLY_INTERVAL then
		return
	end
	listReplied[sender] = now
	local chunks = BuildChunks()
	for index, chunk in ipairs(chunks) do
		C_Timer.After((index - 1) * CHUNK_DELAY, function()
			Send(sender, "DAT", index, #chunks, chunk)
		end)
	end
	Log.Debug("Comm: liste envoyée à", sender, #chunks, "morceau(x)")
end

local function FinishList(sender, completed)
	local callback = pendingLists[sender]
	pendingLists[sender] = nil
	if completed then
		lists[sender] = { completed = completed, time = GetTime() }
	end
	if callback then
		local ok, message = pcall(callback, sender, completed)
		if not ok then
			Log.Debug("Comm: erreur de l'inspection", message)
		end
	end
end

local function ParseList(parts, total)
	local completed = {}
	for index = 1, total do
		for pair in parts[index]:gmatch("[^" .. LIST_SEPARATOR .. "]+") do
			local id, when = strsplit(PAIR_SEPARATOR, pair)
			id, when = tonumber(id, 36), tonumber(when, 36)
			if id and when then
				completed[id] = { date = when }
			end
		end
	end
	return completed
end

local function OnListChunk(sender, index, total, payload)
	index, total = tonumber(index), tonumber(total)
	if not index or not total or index < 1 or index > total or not pendingLists[sender] then
		return
	end
	local state = incoming[sender]
	if not state or state.total ~= total then
		state = { total = total, parts = {}, received = 0 }
		incoming[sender] = state
	end
	if not state.parts[index] then
		state.parts[index] = payload or ""
		state.received = state.received + 1
	end
	if state.received == total then
		incoming[sender] = nil
		FinishList(sender, ParseList(state.parts, total))
	end
end

-- true si la liste de ce joueur est connue et récente : RequestList répondra
-- tout de suite.
function Comm:HasList(name)
	local cached = lists[name]
	return cached ~= nil and GetTime() - cached.time < CACHE_SECONDS
end

-- Liste des hauts faits obtenus par un joueur. callback(name, completed)
-- est appelé avec completed = { [achievementID] = { date } }, ou nil si le
-- joueur ne répond pas (pas d'addon, ancienne version, hors ligne). false si
-- la demande n'a pas pu partir (restrictions de messagerie).
function Comm:RequestList(name, callback)
	if self:HasList(name) then
		callback(name, lists[name].completed)
		return true
	end
	if not Send(name, "LST") then
		return false
	end
	pendingLists[name] = callback
	incoming[name] = nil
	C_Timer.After(LIST_TIMEOUT, function()
		if pendingLists[name] == callback then
			incoming[name] = nil
			FinishList(name, nil)
		end
	end)
	return true
end

local function OnSummary(sender, points, count)
	points, count = tonumber(points), tonumber(count)
	if not points or not count then
		return
	end
	summaries[sender] = { points = points, count = count, time = GetTime() }
	for _, callback in ipairs(listeners) do
		local ok, message = pcall(callback, sender)
		if not ok then
			Log.Debug("Comm: erreur d'un abonné", message)
		end
	end
end

eventFrame:SetScript("OnEvent", function(_, _, prefix, text, channel, sender)
	if IsSecret(prefix) or prefix ~= PREFIX or channel ~= "WHISPER"
		or IsSecret(text) or type(text) ~= "string" then
		return
	end
	sender = Comm.FullName(sender)
	if not sender then
		return
	end
	local version, kind, first, second, third = strsplit(SEPARATOR, text)
	if tonumber(version) ~= PROTOCOL then
		return
	end
	if kind == "REQ" then
		OnRequest(sender)
	elseif kind == "SUM" then
		OnSummary(sender, first, second)
	elseif kind == "LST" then
		OnListRequest(sender)
	elseif kind == "DAT" then
		OnListChunk(sender, first, second, third)
	end
end)

-- Appelé au PLAYER_LOGIN.
function Comm:Init()
	local ok = pcall(C_ChatInfo.RegisterAddonMessagePrefix, PREFIX)
	if not ok then
		Log.Debug("Comm: préfixe refusé", PREFIX)
		return
	end
	eventFrame:RegisterEvent("CHAT_MSG_ADDON")
	-- Lu par UI/PlayerTooltip.lua, dont le crochet est posé avant.
	Comm.ready = true
	Log.Debug("Comm: prêt")
end
