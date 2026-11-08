-- Premier fichier chargé : prépare le namespace partagé par tous les fichiers.
-- WoW passe à chaque fichier deux valeurs : le nom de l'addon et une table
-- privée commune (ns). Tout l'addon vit dans ns, on n'ajoute aucune globale.
local addonName, ns = ...

ns.name = addonName
ns.version = C_AddOns.GetAddOnMetadata(addonName, "Version") or "?"
-- Icône de l'addon (bouton minimap, compartiment). Même valeur que IconTexture du .toc.
ns.icon = "Interface\\Icons\\Achievement_General"
-- Icône utilisée quand un haut fait n'en précise pas ou qu'elle est introuvable.
ns.fallbackIcon = "Interface\\Icons\\INV_Misc_QuestionMark"

-- Tables remplies par les fichiers du dossier Data (catégories, hauts faits).
ns.Data = {}
