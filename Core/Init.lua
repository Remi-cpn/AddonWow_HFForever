-- Premier fichier chargé : prépare le namespace commun.
-- WoW passe à chaque fichier le nom de l'addon et une table privée partagée
-- (ns). Tout le code vit dans ns. Les seules globales sont celles que WoW
-- impose : la sauvegarde HFForeverDB, la fenêtre HFFAchievementFrame (pour
-- la fermeture par Échap) et les SLASH_HFFOREVER* des commandes.
local addonName, ns = ...

ns.name = addonName
-- Hors zip publié, le packager n'a pas remplacé @project-version@.
ns.version = C_AddOns.GetAddOnMetadata(addonName, "Version") or "?"
if ns.version:find("@", 1, true) then
	ns.version = "dev"
end
-- Logo de l'addon (bouton de minimap, compartiment, toast résumé). Même
-- valeur que IconTexture dans le .toc. Source en grand : docs/HFForever_Logo.png.
ns.icon = "Interface\\AddOns\\HFForever\\Media\\HFForever_Icon"
-- Remplace une icône introuvable dans le client.
ns.fallbackIcon = "Interface\\Icons\\INV_Misc_QuestionMark"

-- Bouclier des points de hauts faits, celui de l'en-tête de la fenêtre
-- (UI/MainWindow.xml) : texture 32 x 32 dont seul le coin de 20 x 20 sert.
-- Renvoie le code à insérer dans un texte (infobulle, menu).
function ns.ShieldMarkup(size)
	return ("|TInterface\\AchievementFrame\\UI-Achievement-TinyShield:%d:%d:0:0:32:32:0:20:0:20|t")
		:format(size, size)
end

-- Rempli par les fichiers de Data/.
ns.Data = {}
