-- Premier fichier chargé : prépare le namespace partagé par tous les fichiers.
-- WoW passe à chaque fichier deux valeurs : le nom de l'addon et une table
-- privée commune (ns). Tout l'addon vit dans ns, on n'ajoute aucune globale.
local addonName, ns = ...

ns.name = addonName
ns.version = C_AddOns.GetAddOnMetadata(addonName, "Version") or "?"
