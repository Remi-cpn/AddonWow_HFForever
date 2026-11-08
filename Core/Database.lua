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
	-- Réglages du bouton de minimap, lus et écrits par LibDBIcon :
	-- hide (masqué), minimapPos (angle en degrés), showInCompartment.
	minimap = {
		hide = false,
		showInCompartment = true,
	},
	-- Réglages des toasts
	toasts = {
		sound = true,
	},
	-- [achievementID] = { date = horodatage, character = "Nom-Royaume",
	--                     retroactive = true si détecté à la connexion,
	--                     donc accompli avant, date réelle inconnue }
	completed = {},
	-- Meilleure progression vue, tous personnages confondus :
	-- [achievementID] = { [criteriaIndex] = quantité }
	progress = {},
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

-- Table des réglages du bouton de minimap. On la donne telle quelle à
-- LibDBIcon, qui y sauvegarde lui-même la position quand on déplace le bouton.
function Database:GetMinimapSettings()
	return data.minimap
end

function Database:IsToastSoundEnabled()
	return data.toasts.sound == true
end

function Database:SetToastSoundEnabled(enabled)
	data.toasts.sound = enabled and true or false
end

function Database:GetSchemaVersion()
	return data.schemaVersion
end

-- Enregistrement d'un haut fait obtenu ({ date, character }), ou nil.
function Database:GetCompletion(achievementID)
	return data.completed[achievementID]
end

-- Toute la table des hauts faits obtenus. À lire seulement, jamais modifier.
function Database:GetAllCompletions()
	return data.completed
end

-- Enregistre un haut fait obtenu. Ne fait rien s'il l'est déjà.
function Database:SetCompleted(achievementID, character, retroactive)
	if data.completed[achievementID] then
		return
	end
	data.completed[achievementID] = {
		date = time(),
		character = character,
		retroactive = retroactive or nil,
	}
end

-- Meilleure progression enregistrée pour un critère (0 si aucune).
function Database:GetProgress(achievementID, criteriaIndex)
	local entry = data.progress[achievementID]
	return entry and entry[criteriaIndex] or 0
end

-- Enregistre une progression si elle dépasse la meilleure connue.
-- Renvoie la meilleure valeur après mise à jour.
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

-- Efface hauts faits obtenus et progression (pour tester la détection
-- rétroactive). Les réglages (debug, minimap) sont conservés.
function Database:ResetAchievements()
	data.completed = {}
	data.progress = {}
end

-- Nombre de hauts faits obtenus enregistrés.
function Database:CountCompleted()
	local count = 0
	for _ in pairs(data.completed) do
		count = count + 1
	end
	return count
end
