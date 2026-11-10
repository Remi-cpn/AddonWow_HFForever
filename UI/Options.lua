-- Page HF Forever dans Échap > Options > AddOns (API Settings de Blizzard).
-- Réglages proxy : le panneau lit et écrit par Database et MinimapButton,
-- ce qui le garde d'accord avec /hff son et /hff minimap.
local _, ns = ...

local L = ns.L
local Log = ns.Log

local Options = {}
ns.Options = Options

local category = nil

-- variable : nom unique du réglage chez Blizzard, préfixé pour ne pas
-- entrer en conflit avec un autre addon.
local function AddCheckbox(variable, name, tooltip, getValue, setValue)
	local setting = Settings.RegisterProxySetting(category, variable,
		Settings.VarType.Boolean, name, Settings.Default.True, getValue, setValue)
	Settings.CreateCheckbox(category, setting, tooltip)
end

-- Appelé une fois à ADDON_LOADED, après Database:Init.
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

-- OpenSettingsPanel est une fonction à restrictions : en combat, on
-- prévient plutôt que de ne rien faire.
function Options:Open()
	if not category then
		return
	end
	if InCombatLockdown() then
		Log.Info(L.OPTIONS_IN_COMBAT)
		return
	end
	Settings.OpenToCategory(category:GetID())
end
