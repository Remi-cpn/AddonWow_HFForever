-- Panneau d'options dans Échap > Options > AddOns > HF Forever.
-- API officielle Settings de Blizzard (Blizzard_Settings_Shared) : une
-- catégorie verticale avec des cases à cocher.
--
-- Réglages « proxy » : le panneau lit et écrit par nos propres fonctions
-- (Database, MinimapButton), pas directement dans la sauvegarde. Il reste
-- donc d'accord avec /hff son et /hff minimap.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Options = {}
ns.Options = Options

local category = nil

-- Ajoute une case à cocher. variable : nom unique du réglage auprès de
-- Blizzard (préfixé HFForever_ pour ne gêner aucun autre addon).
local function AddCheckbox(variable, name, tooltip, getValue, setValue)
	local setting = Settings.RegisterProxySetting(category, variable,
		Settings.VarType.Boolean, name, Settings.Default.True, getValue, setValue)
	Settings.CreateCheckbox(category, setting, tooltip)
end

-- Appelé une fois au chargement (ADDON_LOADED), après Database:Init.
function Options:Init()
	category = Settings.RegisterVerticalLayoutCategory(L.ADDON_TITLE)

	AddCheckbox("HFForever_ShowMinimapButton", L.OPTION_MINIMAP, L.OPTION_MINIMAP_TOOLTIP,
		function()
			return ns.MinimapButton:IsShown()
		end,
		function(value)
			ns.MinimapButton:SetShown(value)
		end)

	AddCheckbox("HFForever_ShowToasts", L.OPTION_TOASTS, L.OPTION_TOASTS_TOOLTIP,
		function()
			return ns.Database:IsToastEnabled()
		end,
		function(value)
			ns.Database:SetToastEnabled(value)
		end)

	AddCheckbox("HFForever_ToastSound", L.OPTION_SOUND, L.OPTION_SOUND_TOOLTIP,
		function()
			return ns.Database:IsToastSoundEnabled()
		end,
		function(value)
			ns.Database:SetToastSoundEnabled(value)
		end)

	Settings.RegisterAddOnCategory(category)
	Log.Debug("Options: panneau enregistré")
end

-- Ouvre le panneau d'options sur HF Forever (clic droit sur l'icône).
function Options:Open()
	if category then
		Settings.OpenToCategory(category:GetID())
	end
end
