-- Sauvegarde du compte (SavedVariable HFForeverDB).
-- Le reste du code passe toujours par ce module et ne touche jamais
-- HFForeverDB directement.
local _, ns = ...

local Database = {}
ns.Database = Database

-- À incrémenter si la forme des données change, pour pouvoir migrer les
-- anciennes sauvegardes.
local SCHEMA_VERSION = 1

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
	-- Meilleure progression vue, tous personnages confondus :
	-- [achievementID] = { [criteriaIndex] = quantité }
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

-- nil jusqu'à ADDON_LOADED.
local data = nil

-- Appelé une fois, à ADDON_LOADED, quand WoW a chargé la sauvegarde.
function Database:Init()
	if type(HFForeverDB) ~= "table" then
		HFForeverDB = {}
	end
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

-- 0 si aucune progression enregistrée.
function Database:GetProgress(achievementID, criteriaIndex)
	local entry = data.progress[achievementID]
	return entry and entry[criteriaIndex] or 0
end

-- Garde la meilleure valeur vue et la renvoie.
function Database:UpdateProgress(achievementID, criteriaIndex, quantity)
	local entry = data.progress[achievementID]
	if not entry then
		entry = {}
		data.progress[achievementID] = entry
	end
	if quantity > (entry[criteriaIndex] or 0) then
		entry[criteriaIndex] = quantity
	end
	return entry[criteriaIndex] or 0
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
