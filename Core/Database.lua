-- Sauvegarde du compte (SavedVariable HFForeverDB).
-- Le reste du code passe toujours par ce module et ne touche jamais
-- HFForeverDB directement.
local _, ns = ...

local Database = {}
ns.Database = Database

-- À incrémenter si la forme des données change, pour pouvoir migrer les
-- anciennes sauvegardes.
-- 2 : progression enregistrée par personnage (avant : meilleure valeur seule).
-- 3 : hauts faits renumérotés de 1 à 96 (avant : 1001, 2001, 3001...).
-- 4 : progression rangée par ce que mesure le critère (avant : sa position).
local SCHEMA_VERSION = 4

-- Schéma 4 : hauts faits dont les critères ont changé avant la v1 (barres
-- de réputation devenues des métas). Avec l'ancienne progression relue, ils
-- ont pu être donnés à tort : la migration les retire, le scan les redonne
-- s'ils sont vraiment obtenus.
local REDEFINED_IDS = { 147, 148, 163, 164 }

-- Schéma 3 : [ancien id] = nouvel id. Sert uniquement à convertir une
-- sauvegarde plus ancienne ; ne pas modifier.
local RENUMBERED_IDS = {
	[1001] = 1, [1002] = 2, [1003] = 3, [1004] = 4, [1005] = 5, [1006] = 6,
	[2001] = 7, [2002] = 8, [2003] = 9, [2004] = 10, [2005] = 11,
	[3001] = 12, [3002] = 13, [3003] = 14, [3004] = 15, [3005] = 16,
	[3006] = 17, [3007] = 18, [3008] = 19, [3009] = 20, [3010] = 21,
	[3011] = 22, [3012] = 23, [3013] = 24, [3014] = 25, [3015] = 26,
	[3016] = 27, [3017] = 28, [3018] = 29, [3019] = 30, [3020] = 31,
	[3021] = 32, [3022] = 33, [3023] = 34, [3050] = 35,
	[3101] = 36, [3102] = 37, [3103] = 38, [3104] = 39, [3105] = 40,
	[3106] = 41, [3107] = 42, [3108] = 43, [3109] = 44, [3110] = 45,
	[3111] = 46, [3112] = 47, [3113] = 48, [3114] = 49, [3115] = 50,
	[3117] = 51, [3118] = 52, [3119] = 53, [3120] = 54, [3150] = 55,
	[3201] = 56, [3300] = 57,
	[4001] = 58, [4002] = 59, [4003] = 60,
	[4011] = 61, [4012] = 62, [4013] = 63, [4014] = 64, [4015] = 65,
	[4016] = 66, [4017] = 67, [4018] = 68, [4019] = 69,
	[4021] = 70, [4022] = 71, [4023] = 72,
	[5002] = 73, [5003] = 74, [5004] = 75, [5005] = 76, [5006] = 77,
	[5007] = 78, [5008] = 79, [5009] = 80, [5010] = 81, [5011] = 82,
	[5012] = 83, [5013] = 84, [5014] = 85, [5015] = 86, [5016] = 87,
	[5017] = 88, [5018] = 89, [5019] = 90, [5020] = 91, [5021] = 92,
	[5102] = 93, [5103] = 94, [5104] = 95, [5105] = 96,
}

-- Complétées dans la sauvegarde quand elles manquent.
local DEFAULTS = {
	schemaVersion = SCHEMA_VERSION,
	debug = false,
	-- Lu et écrit par LibDBIcon : hide, minimapPos (angle), showInCompartment.
	minimap = {
		hide = false,
		showInCompartment = true,
	},
	-- enabled : toasts de déblocage (le message dans le chat reste toujours).
	toasts = {
		enabled = true,
		sound = true,
	},
	-- [achievementID] = { date, order, character = "Nom-Royaume",
	--                     retroactive = true si détecté à la connexion }
	-- Pour un haut fait rétroactif, la date est celle de la détection : la
	-- vraie date d'obtention n'est pas connue.
	completed = {},
	-- Meilleure valeur vue pour chaque personnage (clé : son GUID) :
	-- [achievementID] = { [progressKey] = { [guid] = quantité } }
	-- progressKey : "type:cible" du critère, voir Core/Registry.lua.
	-- Les personnages sont combinés à la lecture, voir Database:GetProgress.
	progress = {},
}

-- Ajoute récursivement les clés manquantes, sans écraser les valeurs présentes.
local function ApplyDefaults(target, defaults)
	for key, value in pairs(defaults) do
		if target[key] == nil then
			if type(value) == "table" then
				target[key] = {}
				ApplyDefaults(target[key], value)
			else
				target[key] = value
			end
		elseif type(value) == "table" and type(target[key]) == "table" then
			ApplyDefaults(target[key], value)
		end
	end
end

-- Retire les entrées de completed qui n'ont pas la bonne forme (fichier de
-- sauvegarde modifié à la main) : le reste de l'addon peut alors lire
-- record.date sans vérifier.
local function RemoveInvalidCompletions(completed)
	for id, record in pairs(completed) do
		if type(record) ~= "table" or type(record.date) ~= "number" then
			completed[id] = nil
		end
	end
end

-- Met à jour une sauvegarde d'un ancien schéma. La progression est effacée
-- (le scan de la connexion la relit) ; les hauts faits obtenus sont gardés.
--   2 : la progression du schéma 1 ne dit pas de quel personnage elle vient.
--   3 : les hauts faits obtenus passent à leur nouvel id ; un id inconnu
--       (haut fait retiré avant la v1) est abandonné.
--   4 : les clés de progression changent ; REDEFINED_IDS sont retirés.
local function Migrate(db)
	local version = db.schemaVersion or SCHEMA_VERSION
	if version < 2 then
		db.progress = {}
	end
	if version < 3 then
		local renumbered = {}
		for oldID, record in pairs(type(db.completed) == "table" and db.completed or {}) do
			local newID = RENUMBERED_IDS[oldID]
			if newID then
				renumbered[newID] = record
			end
		end
		db.completed = renumbered
		db.progress = {}
	end
	if version < 4 then
		if type(db.completed) == "table" then
			for _, id in ipairs(REDEFINED_IDS) do
				db.completed[id] = nil
			end
		end
		db.progress = {}
	end
	db.schemaVersion = SCHEMA_VERSION
end

-- nil jusqu'à ADDON_LOADED.
local data = nil

-- Appelé une fois, à ADDON_LOADED, quand WoW a chargé la sauvegarde.
function Database:Init()
	if type(HFForeverDB) ~= "table" then
		HFForeverDB = {}
	end
	Migrate(HFForeverDB)
	ApplyDefaults(HFForeverDB, DEFAULTS)
	RemoveInvalidCompletions(HFForeverDB.completed)
	data = HFForeverDB
	ns.Log.Debug("Database: sauvegarde prête, schéma", data.schemaVersion)
end

function Database:IsDebug()
	return data ~= nil and data.debug == true
end

function Database:SetDebug(enabled)
	data.debug = enabled and true or false
end

-- Donnée telle quelle à LibDBIcon, qui y enregistre la position du bouton.
function Database:GetMinimapSettings()
	return data.minimap
end

function Database:IsToastSoundEnabled()
	return data.toasts.sound == true
end

function Database:SetToastSoundEnabled(enabled)
	data.toasts.sound = enabled and true or false
end

function Database:IsToastEnabled()
	return data.toasts.enabled == true
end

function Database:SetToastEnabled(enabled)
	data.toasts.enabled = enabled and true or false
end

function Database:GetSchemaVersion()
	return data.schemaVersion
end

-- { date, order, character, retroactive }, ou nil si pas obtenu.
function Database:GetCompletion(achievementID)
	return data.completed[achievementID]
end

-- Ne pas modifier la table renvoyée.
function Database:GetAllCompletions()
	return data.completed
end

-- Sans effet si le haut fait est déjà enregistré.
function Database:SetCompleted(achievementID, character, retroactive)
	if data.completed[achievementID] then
		return
	end
	-- time() est à la seconde près : order départage les hauts faits
	-- obtenus dans la même seconde, par exemple lors d'un scan rétroactif.
	data.completionCounter = (data.completionCounter or 0) + 1
	data.completed[achievementID] = {
		date = time(),
		order = data.completionCounter,
		character = character,
		retroactive = retroactive or nil,
	}
end

-- Progression d'un critère, tous personnages confondus. combine vient du
-- critère (Data/Achievements.lua) : "sum" additionne les personnages, sinon
-- le meilleur personnage compte. 0 si aucune progression enregistrée.
function Database:GetProgress(achievementID, progressKey, combine)
	local entry = data.progress[achievementID]
	local perCharacter = entry and entry[progressKey]
	if type(perCharacter) ~= "table" then
		return 0
	end
	local result = 0
	for _, quantity in pairs(perCharacter) do
		if type(quantity) == "number" then
			if combine == "sum" then
				result = result + quantity
			else
				result = math.max(result, quantity)
			end
		end
	end
	return result
end

-- Garde la meilleure valeur vue pour ce personnage, puis renvoie la
-- progression combinée (voir GetProgress).
function Database:UpdateProgress(achievementID, progressKey, guid, quantity, combine)
	local entry = data.progress[achievementID]
	if not entry then
		entry = {}
		data.progress[achievementID] = entry
	end
	local perCharacter = entry[progressKey]
	if type(perCharacter) ~= "table" then
		perCharacter = {}
		entry[progressKey] = perCharacter
	end
	if quantity > (perCharacter[guid] or 0) then
		perCharacter[guid] = quantity
	end
	return self:GetProgress(achievementID, progressKey, combine)
end

-- Nombre de personnages différents vus dans la progression (/hff etat).
function Database:GetNumCharacters()
	local seen, count = {}, 0
	for _, entry in pairs(data.progress) do
		for _, perCharacter in pairs(entry) do
			if type(perCharacter) == "table" then
				for guid in pairs(perCharacter) do
					if not seen[guid] then
						seen[guid] = true
						count = count + 1
					end
				end
			end
		end
	end
	return count
end

-- Efface hauts faits et progression ; les réglages sont conservés.
function Database:ResetAchievements()
	data.completed = {}
	data.progress = {}
end

function Database:CountCompleted()
	local count = 0
	for _ in pairs(data.completed) do
		count = count + 1
	end
	return count
end
