-- Affichage dans le chat : messages normaux et logs de debug.
local _, ns = ...

local Log = {}
ns.Log = Log

local PREFIX = "|cffffd100HF Forever|r : "
local DEBUG_PREFIX = "|cff66ccff[HFF debug]|r "
local ERROR_PREFIX = "|cffff4040HF Forever erreur|r : "

-- Message normal, toujours affiché. Utilise string.format comme printf en C.
function Log.Info(fmt, ...)
	print(PREFIX .. fmt:format(...))
end

-- Erreur, toujours affichée en rouge. Les arguments sont convertis en texte
-- avant le format : utiliser %s dans fmt, même pour les nombres.
function Log.Error(fmt, ...)
	print(ERROR_PREFIX .. fmt:format(tostringall(...)))
end

-- Log de debug, affiché seulement si le mode debug est actif.
-- Les arguments sont convertis en texte et séparés par des espaces, donc on
-- peut passer n'importe quoi (nil, booléens, nombres) sans risquer d'erreur.
-- Exemple : Log.Debug("Scan", "quêtes", count)
function Log.Debug(...)
	if not ns.Database:IsDebug() then
		return
	end
	print(DEBUG_PREFIX .. strjoin(" ", tostringall(...)))
end
