-- Fenêtre principale des hauts faits.
-- Pour l'instant un simple point d'entrée : la vraie fenêtre arrive à l'étape 7.
-- Le bouton de minimap et /hff appellent tous les deux MainWindow:Toggle(),
-- ils n'auront donc pas à changer quand la fenêtre existera.
local _, ns = ...

local MainWindow = {}
ns.MainWindow = MainWindow

function MainWindow:Toggle()
	ns.Log.Debug("MainWindow: Toggle demandé")
	ns.Log.Info(ns.L.WINDOW_NOT_READY)
end
