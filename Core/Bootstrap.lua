-- Dernier fichier chargé : écoute les événements de démarrage.
local addonName, ns = ...

local L = ns.L
local Log = ns.Log

local eventFrame = CreateFrame("Frame")

local function OnAddonLoaded(loadedName)
	-- ADDON_LOADED arrive pour chaque addon.
	if loadedName ~= addonName then
		return
	end
	eventFrame:UnregisterEvent("ADDON_LOADED")
	ns.Database:Init()
	ns.Registry:Build()
	ns.MinimapButton:Init()
	ns.Toasts:Init()
	ns.MainWindow:Init()
	ns.Options:Init()
end

local function OnPlayerLogin()
	Log.Info(L.LOADED, ns.version)
	Log.Debug("Bootstrap: PLAYER_LOGIN reçu")
	ns.Engine:Start()
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
	if event == "ADDON_LOADED" then
		OnAddonLoaded(...)
	elseif event == "PLAYER_LOGIN" then
		OnPlayerLogin()
	end
end)
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
