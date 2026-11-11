-- Catégories de hauts faits. Données uniquement, aucune logique.
-- L'ordre de la liste est l'ordre d'affichage dans la fenêtre.
-- Les noms sont dans Locales/ (L.CATEGORY_NAMES[id]).
--
--   id     : nombre unique et définitif
--   parent : (facultatif) id de la catégorie mère, pour une sous-catégorie
local _, ns = ...

-- Noms lisibles des id, utilisés par Data/Achievements.lua (category = CAT.QUESTS).
local CAT = {
	GENERAL = 1,
	QUESTS = 2,
	EXPLORATION = 3,
	EASTERN_KINGDOMS = 31,
	KALIMDOR = 32,
	PVP = 6,
	WARSONG_GULCH = 61,
	ARATHI_BASIN = 62,
	ALTERAC_VALLEY = 63,
	PROFESSIONS = 4,
	REPUTATION = 7,
	DUNGEONS = 5,
	DUNGEONS_CLASSIC = 51,
	DUNGEONS_FOREVER = 52,
}
ns.Data.CAT = CAT

ns.Data.categories = {
	{ id = CAT.GENERAL },
	{ id = CAT.QUESTS },
	{ id = CAT.EXPLORATION },
	{ id = CAT.EASTERN_KINGDOMS, parent = CAT.EXPLORATION },
	{ id = CAT.KALIMDOR, parent = CAT.EXPLORATION },
	{ id = CAT.PVP },
	{ id = CAT.WARSONG_GULCH, parent = CAT.PVP },
	{ id = CAT.ARATHI_BASIN, parent = CAT.PVP },
	{ id = CAT.ALTERAC_VALLEY, parent = CAT.PVP },
	{ id = CAT.PROFESSIONS },
	{ id = CAT.REPUTATION },
	{ id = CAT.DUNGEONS },
	{ id = CAT.DUNGEONS_CLASSIC, parent = CAT.DUNGEONS },
	{ id = CAT.DUNGEONS_FOREVER, parent = CAT.DUNGEONS },
}
