-- Catégories de hauts faits. Données uniquement, aucune logique.
-- L'ordre de la liste est l'ordre d'affichage dans la fenêtre.
--
--   id     : nombre unique et définitif
--   name   : nom affiché
--   parent : (facultatif) id de la catégorie mère, pour une sous-catégorie
local _, ns = ...

ns.Data.categories = {
	{ id = 1, name = "Général" },
}
