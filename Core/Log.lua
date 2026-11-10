-- Messages dans le chat : normaux, erreurs et debug.
local _, ns = ...

local Log = {}
ns.Log = Log

-- Chargé après Locales/ : ns.L existe déjà.
local PREFIX = "|cffffd100HF Forever|r" .. ns.L.LOG_SEPARATOR
local DEBUG_PREFIX = "|cff66ccff[HFF debug]|r "
local ERROR_PREFIX = "|cffff4040" .. ns.L.LOG_ERROR_PREFIX .. "|r" .. ns.L.LOG_SEPARATOR

-- fmt suit la syntaxe de string.format.
function Log.Info(fmt, ...)
	print(PREFIX .. fmt:format(...))
end

-- Les arguments sont passés par tostring avant le format : fmt n'utilise
-- que %s, ce qui évite une erreur si une valeur est nil.
function Log.Error(fmt, ...)
	print(ERROR_PREFIX .. fmt:format(tostringall(...)))
end

-- Affiché seulement en mode debug. Accepte n'importe quelles valeurs,
-- séparées par des espaces : Log.Debug("Scan", "quêtes", count)
function Log.Debug(...)
	if not ns.Database:IsDebug() then
		return
	end
	print(DEBUG_PREFIX .. strjoin(" ", tostringall(...)))
end
