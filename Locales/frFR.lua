-- Tous les textes affichés au joueur. L'interface est en français uniquement.
-- Une clé absente renvoie son propre nom entre crochets : ça se voit
-- tout de suite en jeu au lieu de provoquer une erreur.
local _, ns = ...

local L = setmetatable({}, {
	__index = function(_, key)
		return "[" .. tostring(key) .. "]"
	end,
})
ns.L = L

-- Messages généraux
L.ADDON_TITLE = "HF Forever"
L.LOADED = "version %s chargée. Tape /hff aide pour la liste des commandes."

-- Commandes slash
L.CMD_HELP_HEADER = "Commandes disponibles :"
L.CMD_HELP_OPEN = "/hff : ouvre la fenêtre des hauts faits"
L.CMD_HELP_DEBUG = "/hff debug : active ou désactive le mode debug"
L.CMD_HELP_STATUS = "/hff etat : affiche l'état de la sauvegarde"
L.CMD_HELP_HELP = "/hff aide : affiche cette aide"
L.CMD_UNKNOWN = "commande inconnue : « %s ». Tape /hff aide."
L.WINDOW_NOT_READY = "la fenêtre n'existe pas encore (étape 7)."

-- Mode debug
L.DEBUG_ON = "mode debug activé."
L.DEBUG_OFF = "mode debug désactivé."

-- État de la sauvegarde
L.STATUS_SCHEMA = "version du format de sauvegarde : %d"
L.STATUS_DEBUG = "mode debug : %s"
L.STATUS_COMPLETED = "hauts faits obtenus enregistrés : %d"
L.YES = "oui"
L.NO = "non"
