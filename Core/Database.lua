-- Persistance : la SavedVariable HFForeverDB, commune à tout le compte.
-- C'est la seule globale de l'addon (WoW l'impose pour la sauvegarde).
-- Le reste du code ne touche jamais HFForeverDB directement : il passe par
-- les fonctions de ce module.
local _, ns = ...

local Database = {}
ns.Database = Database

-- À incrémenter quand la forme des données sauvegardées change, pour
-- pouvoir migrer les anciennes sauvegardes plus tard.
local SCHEMA_VERSION = 1

-- Valeurs par défaut, complétées dans la sauvegarde si elles manquent.
local DEFAULTS = {
	schemaVersion = SCHEMA_VERSION,
	debug = false,
	-- [achievementID] = { date = horodatage }, rempli par le moteur (étape 5)
	completed = {},
}

-- Ajoute dans target les clés de defaults qui manquent, récursivement.
-- Les valeurs déjà présentes ne sont jamais écrasées.
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

-- Données en mémoire. nil tant que ADDON_LOADED n'est pas passé.
local data = nil

-- Appelé une seule fois, quand WoW a chargé la sauvegarde (ADDON_LOADED).
function Database:Init()
	if type(HFForeverDB) ~= "table" then
		HFForeverDB = {}
	end
	ApplyDefaults(HFForeverDB, DEFAULTS)
	data = HFForeverDB
	ns.Log.Debug("Database: sauvegarde prête, schéma", data.schemaVersion)
end

function Database:IsReady()
	return data ~= nil
end

function Database:IsDebug()
	return data ~= nil and data.debug == true
end

function Database:SetDebug(enabled)
	data.debug = enabled and true or false
end

function Database:GetSchemaVersion()
	return data.schemaVersion
end

-- Nombre de hauts faits obtenus enregistrés.
function Database:CountCompleted()
	local count = 0
	for _ in pairs(data.completed) do
		count = count + 1
	end
	return count
end
