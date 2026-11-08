-- Dernier fichier chargé : écoute les événements de démarrage.
local addonName, ns = ...

local L = ns.L
local Log = ns.Log

-- Frame anonyme (sans nom) : elle ne crée donc pas de globale.
local eventFrame = CreateFrame("Frame")

local function OnAddonLoaded(loadedName)
	-- ADDON_LOADED se déclenche pour chaque addon, on ne garde que le nôtre.
	if loadedName ~= addonName then
		return
	end
	eventFrame:UnregisterEvent("ADDON_LOADED")
	ns.Database:Init()
	ns.Registry:Build()
	ns.MinimapButton:Init()
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
