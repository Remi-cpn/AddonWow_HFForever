-- Définitions des hauts faits. Données uniquement, aucune logique.
-- L'ordre de la liste est l'ordre d'affichage dans chaque catégorie.
--
--   id          : nombre unique et DÉFINITIF (la sauvegarde s'en sert,
--                 ne jamais le changer ni le réutiliser)
--   category    : id d'une catégorie de Data/Categories.lua
--   points      : points du haut fait
--   icon        : chemin de l'icône (Interface\\Icons\\...)
--   name        : nom affiché
--   description : texte affiché sous le nom
--   criteria    : liste de critères, TOUS doivent être remplis.
--                 Types disponibles : voir Core/CriteriaTypes.lua
--   previous    : (facultatif) id du haut fait précédent d'une série
--   reward      : (facultatif) texte de récompense, purement décoratif
local _, ns = ...

ns.Data.achievements = {
	-- Hauts faits de test (étape 3), à remplacer par la vraie liste (étape 4)
	{
		id = 1001,
		category = 1,
		points = 10,
		icon = "Interface\\Icons\\Achievement_Level_10",
		name = "Niveau 10",
		description = "Atteindre le niveau 10.",
		criteria = {
			{ type = "level", value = 10 },
		},
	},
	{
		id = 1002,
		category = 1,
		points = 10,
		icon = "Interface\\Icons\\Achievement_Level_20",
		name = "Niveau 20",
		description = "Atteindre le niveau 20.",
		criteria = {
			{ type = "level", value = 20 },
		},
		previous = 1001,
	},
	{
		id = 1003,
		category = 1,
		points = 10,
		icon = "Interface\\Icons\\Achievement_Level_30",
		name = "Niveau 30",
		description = "Atteindre le niveau 30.",
		criteria = {
			{ type = "level", value = 30 },
		},
		previous = 1002,
	},
}
