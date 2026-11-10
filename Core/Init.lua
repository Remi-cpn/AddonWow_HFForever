-- Premier fichier chargé : prépare le namespace commun.
-- WoW passe à chaque fichier le nom de l'addon et une table privée partagée
-- (ns). Tout le code vit dans ns. Les seules globales sont celles que WoW
-- impose : la sauvegarde HFForeverDB, la fenêtre HFFAchievementFrame (pour
-- la fermeture par Échap) et les SLASH_HFFOREVER* des commandes.
local addonName, ns = ...

ns.name = addonName
ns.version = C_AddOns.GetAddOnMetadata(addonName, "Version") or "?"
-- Même valeur que IconTexture dans le .toc.
ns.icon = "Interface\\Icons\\Achievement_General"
-- Remplace une icône introuvable dans le client.
ns.fallbackIcon = "Interface\\Icons\\INV_Misc_QuestionMark"

-- Rempli par les fichiers de Data/.
ns.Data = {}
