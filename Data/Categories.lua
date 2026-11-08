-- Catégories de hauts faits. Données uniquement, aucune logique.
-- L'ordre de la liste est l'ordre d'affichage dans la fenêtre.
--
--   id     : nombre unique et définitif
--   name   : nom affiché
--   parent : (facultatif) id de la catégorie mère, pour une sous-catégorie
local _, ns = ...

ns.Data.categories = {
	{ id = 1, name = "Général" },
	{ id = 2, name = "Quêtes" },
	{ id = 3, name = "Exploration" },
	{ id = 31, name = "Royaumes de l'Est", parent = 3 },
	{ id = 32, name = "Kalimdor", parent = 3 },
	{ id = 4, name = "Métiers" },
	{ id = 5, name = "Donjons" },
	{ id = 51, name = "Classiques", parent = 5 },
	{ id = 52, name = "Forever", parent = 5 },
}
