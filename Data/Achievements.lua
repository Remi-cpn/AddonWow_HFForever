-- Définitions des hauts faits. Données uniquement, aucune logique, aucun texte.
-- L'ordre de la liste est l'ordre d'affichage dans chaque catégorie.
-- La liste validée est décrite dans docs/ProposedAchievements.md.
--
--   id          : numéro unique et DÉFINITIF, la sauvegarde s'en sert. Un
--                 nouveau haut fait prend le numéro libre suivant (295), quel
--                 que soit l'endroit où il est rangé. Ne jamais changer ni
--                 réutiliser un numéro. Numéros retirés, à ne jamais
--                 réutiliser : 76, 80, 176, 177.
--   category    : une constante CAT de Data/Categories.lua
--   points      : points du haut fait
--   icon        : chemin de l'icône (Interface\\Icons\\...)
--   criteria    : liste de critères, TOUS doivent être remplis.
--                 Types disponibles : voir Core/CriteriaTypes.lua
--                 combine (facultatif, sur un critère) : "sum" additionne
--                 les personnages du compte (compteurs : quêtes, monstres
--                 tués...). Par défaut "max" : le meilleur personnage compte
--                 (niveau, métier, exploration, boss vaincu une fois).
--   previous    : (facultatif) id du haut fait précédent d'une série
--   faction     : (facultatif) "Horde" ou "Alliance" : haut fait réservé à
--                 ce camp, invisible pour les personnages de l'autre camp
--
-- Les textes sont dans Locales/enUS.lua et Locales/frFR.lua, rangés par id :
-- L.ACHIEVEMENT_NAMES, L.ACHIEVEMENT_DESCRIPTIONS, L.ACHIEVEMENT_REWARDS et
-- L.CRITERIA_TEXTS (texte d'un critère, à la place du nom de la statistique).
local _, ns = ...

local CAT = ns.Data.CAT
local ICONS = "Interface\\Icons\\"

-- Hauts faits natifs de Forever qui listent les donjons, un critère par
-- donjon ou par aile (critère « boss », champ native).
local SPELEO_NOVICE, SPELEO_EXPERIENCED, SPELEO_EXPERT = 62031, 62032, 62033

ns.Data.achievements = {
	---------------------------------------------------------------------------
	-- Général : niveaux
	---------------------------------------------------------------------------
	{
		id = 1, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Achievement_Level_10",
		criteria = { { type = "level", value = 10 } },
	},
	{
		id = 2, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Achievement_Level_20",
		criteria = { { type = "level", value = 20 } },
		previous = 1,
	},
	{
		id = 3, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Achievement_Level_30",
		criteria = { { type = "level", value = 30 } },
		previous = 2,
	},
	{
		id = 4, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Achievement_Level_40",
		criteria = { { type = "level", value = 40 } },
		previous = 3,
	},
	{
		id = 5, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Achievement_Level_50",
		criteria = { { type = "level", value = 50 } },
		previous = 4,
	},
	{
		id = 6, category = CAT.GENERAL, points = 25,
		icon = ICONS .. "Achievement_Level_60",
		criteria = { { type = "level", value = 60 } },
		previous = 5,
	},

	---------------------------------------------------------------------------
	-- Général : banque, argent, montures
	---------------------------------------------------------------------------
	{
		-- Les 8 emplacements de banque achetables (C_Bank). La statistique 928
		-- n'est pas tenue à jour sur Forever.
		id = 97, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Box_01",
		criteria = { { type = "bankSlots", value = 8 } },
	},
	{
		-- Statistique 333 « Argent ramassé », en pièces d'or
		id = 98, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Misc_Coin_06",
		criteria = { { type = "money", id = 333, value = 100, combine = "sum" } },
	},
	{
		id = 99, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Misc_Coin_04",
		criteria = { { type = "money", id = 333, value = 1000, combine = "sum" } },
		previous = 98,
	},
	{
		id = 100, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Misc_Coin_03",
		criteria = { { type = "money", id = 333, value = 5000, combine = "sum" } },
		previous = 99,
	},
	{
		id = 101, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Misc_Coin_02",
		criteria = { { type = "money", id = 333, value = 10000, combine = "sum" } },
		previous = 100,
	},
	{
		id = 102, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Misc_Coin_01",
		criteria = { { type = "money", id = 333, value = 25000, combine = "sum" } },
		previous = 101,
	},
	{
		-- Statistique 326 « Argent obtenu en récompense de quêtes »
		id = 103, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Misc_Coin_16",
		criteria = { { type = "money", id = 326, value = 10000, combine = "sum" } },
	},
	{
		-- Montures et mascottes : nombre lu dans les journaux du jeu (les
		-- statistiques 338 / 339 ne sont pas tenues à jour sur Forever). Le
		-- meilleur personnage compte.
		id = 104, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Mount_RidingElekk",
		criteria = { { type = "collection", what = "mounts", value = 10 } },
	},
	{
		id = 105, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Mount_RidingElekkElite_Green",
		criteria = { { type = "collection", what = "mounts", value = 25 } },
		previous = 104,
	},
	{
		id = 106, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Mount_Mammoth_Black",
		criteria = { { type = "collection", what = "mounts", value = 50 } },
		previous = 105,
	},
	{
		-- Commun aux deux camps.
		id = 107, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_DragonHawk",
		criteria = { { type = "collection", what = "mounts", value = 100 } },
		previous = 106,
	},
	{
		id = 186, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Box_PetCarrier_01",
		criteria = { { type = "collection", what = "pets", value = 1 } },
	},
	{
		id = 187, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Box_PetCarrier_01",
		criteria = { { type = "collection", what = "pets", value = 15 } },
		previous = 186,
	},
	{
		id = 188, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Box_PetCarrier_01",
		criteria = { { type = "collection", what = "pets", value = 25 } },
		previous = 187,
	},
	{
		id = 189, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Box_PetCarrier_01",
		criteria = { { type = "collection", what = "pets", value = 50 } },
		previous = 188,
	},
	{
		id = 190, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Box_PetCarrier_01",
		criteria = { { type = "collection", what = "pets", value = 75 } },
		previous = 189,
	},

	---------------------------------------------------------------------------
	-- Général : monte, compétences, équipement (le meilleur personnage compte)
	-- Compétences : 762 monte, 162 mains nues et armes de pugilat.
	---------------------------------------------------------------------------
	{
		id = 178, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Mount_RidingHorse",
		criteria = { { type = "skill", id = 762, value = 75 } },
	},
	{
		id = 179, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Mount_BlackPanther",
		criteria = { { type = "skill", id = 762, value = 150 } },
		previous = 178,
	},
	{
		id = 180, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Warrior_SecondWind",
		criteria = { { type = "skill", id = 162, value = 300 } },
	},
	{
		id = 181, category = CAT.GENERAL, points = 25,
		icon = ICONS .. "Ability_Warrior_OffensiveStance",
		criteria = { { type = "weaponSkills", count = 4, value = 300 } },
	},
	{
		-- Détecté dès qu'un tabard est porté, même une seule fois.
		id = 182, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Shirt_GuildTabard_01",
		criteria = { { type = "tabard" } },
	},
	{
		-- Tabards différents, notés quand ils sont portés (critère tabards).
		id = 220, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Shirt_GuildTabard_01",
		criteria = { { type = "tabards", value = 10 } },
	},
	{
		id = 221, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Chest_Cloth_30",
		criteria = { { type = "tabards", value = 25 } },
		previous = 220,
	},
	{
		-- Nouvelle coupe validée chez le coiffeur, vue en direct, ou
		-- statistique 1147 « Argent dépensé chez le coiffeur » non nulle (vide
		-- sur Forever pour l'instant).
		id = 219, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Misc_Comb_02",
		criteria = { { type = "haircut", id = 1147 } },
	},
	{
		-- Jets de 100 sur un objet supérieur ou mieux (critère perfectRoll).
		id = 222, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Misc_Coin_04",
		criteria = { { type = "perfectRoll", what = "greed" } },
	},
	{
		id = 223, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Misc_Coin_01",
		criteria = { { type = "perfectRoll", what = "need" } },
	},
	{
		-- Tous les emplacements en même temps, vu au moins une fois.
		id = 183, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Spell_Frost_WizardMark",
		criteria = { { type = "gearQuality", quality = 3 } },
	},
	{
		id = 185, category = CAT.GENERAL, points = 25,
		icon = ICONS .. "INV_Enchant_VoidCrystal",
		criteria = { { type = "gearQuality", quality = 4 } },
		previous = 183,
	},

	---------------------------------------------------------------------------
	-- Quêtes : statistique 98 « Quêtes achevées », additionnée sur le compte
	---------------------------------------------------------------------------
	{
		id = 7, category = CAT.QUESTS, points = 10,
		icon = ICONS .. "Achievement_Quests_Completed_01",
		criteria = { { type = "statistic", id = 98, value = 50, combine = "sum" } },
	},
	{
		id = 8, category = CAT.QUESTS, points = 10,
		icon = ICONS .. "Achievement_Quests_Completed_02",
		criteria = { { type = "statistic", id = 98, value = 100, combine = "sum" } },
		previous = 7,
	},
	{
		id = 9, category = CAT.QUESTS, points = 10,
		icon = ICONS .. "Achievement_Quests_Completed_03",
		criteria = { { type = "statistic", id = 98, value = 250, combine = "sum" } },
		previous = 8,
	},
	{
		id = 10, category = CAT.QUESTS, points = 10,
		icon = ICONS .. "Achievement_Quests_Completed_04",
		criteria = { { type = "statistic", id = 98, value = 500, combine = "sum" } },
		previous = 9,
	},
	{
		id = 11, category = CAT.QUESTS, points = 25,
		icon = ICONS .. "Achievement_Quests_Completed_05",
		criteria = { { type = "statistic", id = 98, value = 1000, combine = "sum" } },
		previous = 10,
	},
	{
		id = 191, category = CAT.QUESTS, points = 10,
		icon = ICONS .. "Achievement_Quests_Completed_06",
		criteria = { { type = "statistic", id = 98, value = 1500, combine = "sum" } },
		previous = 11,
	},
	{
		id = 192, category = CAT.QUESTS, points = 10,
		icon = ICONS .. "Achievement_Quests_Completed_07",
		criteria = { { type = "statistic", id = 98, value = 2000, combine = "sum" } },
		previous = 191,
	},
	{
		id = 193, category = CAT.QUESTS, points = 50,
		icon = ICONS .. "Achievement_Quests_Completed_08",
		criteria = { { type = "statistic", id = 98, value = 3000, combine = "sum" } },
		previous = 192,
	},
	{
		-- Quêtes 338 « Les vertes collines de Strangleronce » et 208 « La
		-- chasse au gros gibier », les dernières d'Hemet Nesingwary.
		id = 184, category = CAT.QUESTS, points = 10,
		icon = ICONS .. "Ability_Mount_WhiteTiger",
		criteria = {
			{ type = "quest", id = 338 },
			{ type = "quest", id = 208 },
		},
	},
	{
		-- Quête 84195 « Garder le meilleur pour la fin », dernière de la suite
		-- de Valthalak (amélioration de donjon de Forever). Même critère que
		-- les hauts faits natifs 62054 et 64014, dont l'icône est reprise.
		id = 294, category = CAT.QUESTS, points = 10,
		icon = ICONS .. "Achievement_Dungeon_UpperBlackrockSpire",
		criteria = { { type = "quest", id = 84195 } },
	},

	---------------------------------------------------------------------------
	-- Exploration : Royaumes de l'Est (une zone = un uiMapID)
	---------------------------------------------------------------------------
	{
		id = 12, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1416 } }, -- Montagnes d'Alterac
	},
	{
		id = 13, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1417 } }, -- Hautes-terres d'Arathi
	},
	{
		id = 14, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1418 } }, -- Terres ingrates
	},
	{
		id = 15, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1419 } }, -- Terres foudroyées
	},
	{
		id = 16, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1420 } }, -- Clairières de Tirisfal
	},
	{
		id = 17, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1421 } }, -- Forêt des Pins-Argentés
	},
	{
		id = 18, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1422 } }, -- Maleterres de l'Ouest
	},
	{
		id = 19, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1423 } }, -- Maleterres de l'Est
	},
	{
		id = 20, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1424 } }, -- Contreforts de Hautebrande
	},
	{
		id = 21, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1425 } }, -- Les Hinterlands
	},
	{
		id = 22, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1426 } }, -- Dun Morogh
	},
	{
		id = 23, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1427 } }, -- Gorge des Vents brûlants
	},
	{
		id = 24, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1428 } }, -- Steppes ardentes
	},
	{
		id = 25, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1429 } }, -- Forêt d'Elwynn
	},
	{
		id = 26, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1430 } }, -- Défilé de Deuillevent
	},
	{
		id = 27, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1431 } }, -- Bois de la Pénombre
	},
	{
		id = 28, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1432 } }, -- Loch Modan
	},
	{
		id = 29, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1433 } }, -- Les Carmines
	},
	{
		id = 30, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1434 } }, -- Vallée de Strangleronce
	},
	{
		id = 31, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1435 } }, -- Marais des Chagrins
	},
	{
		id = 32, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1436 } }, -- Marche de l'Ouest
	},
	{
		id = 33, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 1437 } }, -- Les Paluns
	},
	{
		id = 34, category = CAT.EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = { { type = "explore", mapID = 2548 } }, -- Rives Claires (Forever)
	},
	{
		id = 35, category = CAT.EASTERN_KINGDOMS, points = 25,
		icon = ICONS .. "Achievement_Zone_EasternKingdoms_01",
		criteria = {
			{ type = "achievement", id = 12 }, { type = "achievement", id = 13 },
			{ type = "achievement", id = 14 }, { type = "achievement", id = 15 },
			{ type = "achievement", id = 16 }, { type = "achievement", id = 17 },
			{ type = "achievement", id = 18 }, { type = "achievement", id = 19 },
			{ type = "achievement", id = 20 }, { type = "achievement", id = 21 },
			{ type = "achievement", id = 22 }, { type = "achievement", id = 23 },
			{ type = "achievement", id = 24 }, { type = "achievement", id = 25 },
			{ type = "achievement", id = 26 }, { type = "achievement", id = 27 },
			{ type = "achievement", id = 28 }, { type = "achievement", id = 29 },
			{ type = "achievement", id = 30 }, { type = "achievement", id = 31 },
			{ type = "achievement", id = 32 }, { type = "achievement", id = 33 },
			{ type = "achievement", id = 34 },
		},
	},

	---------------------------------------------------------------------------
	-- Exploration : Kalimdor
	-- Reflet-de-Lune n'y est pas : sa carte n'a qu'un morceau, affiché d'office
	-- par le jeu, impossible de savoir si la zone a été explorée.
	---------------------------------------------------------------------------
	{
		id = 36, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1411 } }, -- Durotar
	},
	{
		id = 37, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1412 } }, -- Mulgore
	},
	{
		id = 38, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1413 } }, -- Les Tarides
	},
	{
		id = 39, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1438 } }, -- Teldrassil
	},
	{
		id = 40, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1439 } }, -- Sombrivage
	},
	{
		id = 41, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1440 } }, -- Orneval
	},
	{
		id = 42, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1441 } }, -- Mille pointes
	},
	{
		id = 43, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1442 } }, -- Les Serres-Rocheuses
	},
	{
		id = 44, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1443 } }, -- Désolace
	},
	{
		id = 45, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1444 } }, -- Féralas
	},
	{
		id = 46, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1445 } }, -- Marécage d'Âprefange
	},
	{
		id = 47, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1446 } }, -- Tanaris
	},
	{
		id = 48, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1447 } }, -- Azshara
	},
	{
		id = 49, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1448 } }, -- Gangrebois
	},
	{
		id = 50, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1449 } }, -- Cratère d'Un'Goro
	},
	{
		id = 51, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1451 } }, -- Silithus
	},
	{
		id = 52, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 1452 } }, -- Berceau-de-l'Hiver
	},
	{
		id = 53, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 2482 } }, -- Mont Hyjal (Forever)
	},
	{
		id = 54, category = CAT.KALIMDOR, points = 10,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = { { type = "explore", mapID = 2652 } }, -- Shen'dralas (Forever)
	},
	{
		id = 55, category = CAT.KALIMDOR, points = 25,
		icon = ICONS .. "Achievement_Zone_Kalimdor_01",
		criteria = {
			{ type = "achievement", id = 36 }, { type = "achievement", id = 37 },
			{ type = "achievement", id = 38 }, { type = "achievement", id = 39 },
			{ type = "achievement", id = 40 }, { type = "achievement", id = 41 },
			{ type = "achievement", id = 42 }, { type = "achievement", id = 43 },
			{ type = "achievement", id = 44 }, { type = "achievement", id = 45 },
			{ type = "achievement", id = 46 }, { type = "achievement", id = 47 },
			{ type = "achievement", id = 48 }, { type = "achievement", id = 49 },
			{ type = "achievement", id = 50 }, { type = "achievement", id = 51 },
			{ type = "achievement", id = 52 }, { type = "achievement", id = 53 },
			{ type = "achievement", id = 54 },
		},
	},

	---------------------------------------------------------------------------
	-- Exploration : île de Zéphras (ouverte à tous)
	---------------------------------------------------------------------------
	{
		id = 56, category = CAT.EXPLORATION, points = 10,
		icon = ICONS .. "INV_Misc_Map_01",
		criteria = { { type = "explore", mapID = 2521 } },
	},

	---------------------------------------------------------------------------
	-- Exploration : méta global (50 points) : les deux continents et l'île
	-- de Zéphras (ajoutée en 1.3.0 : l'île est ouverte à tous).
	---------------------------------------------------------------------------
	{
		id = 57, category = CAT.EXPLORATION, points = 50,
		icon = ICONS .. "INV_Misc_Map09",
		criteria = {
			{ type = "achievement", id = 35 },
			{ type = "achievement", id = 55 },
			{ type = "achievement", id = 56 },
		},
	},

	---------------------------------------------------------------------------
	-- Exploration : livres de bibliothèque (liste dans Data/Books.lua). Paliers
	-- des quêtes 78150 (10), 79536 (20), 82208 (25) et 84394 (30). Le
	-- meilleur personnage compte : les livres sont liés au personnage.
	---------------------------------------------------------------------------
	{
		id = 224, category = CAT.EXPLORATION, points = 10,
		icon = ICONS .. "INV_Misc_Book_07",
		criteria = { { type = "questCount", what = "libraryBooks", value = 10 } },
	},
	{
		id = 225, category = CAT.EXPLORATION, points = 10,
		icon = ICONS .. "INV_Misc_Book_06",
		criteria = { { type = "questCount", what = "libraryBooks", value = 20 } },
		previous = 224,
	},
	{
		id = 226, category = CAT.EXPLORATION, points = 10,
		icon = ICONS .. "INV_Misc_Book_08",
		criteria = { { type = "questCount", what = "libraryBooks", value = 25 } },
		previous = 225,
	},
	{
		id = 227, category = CAT.EXPLORATION, points = 25,
		icon = ICONS .. "INV_Misc_Book_17",
		criteria = { { type = "questCount", what = "libraryBooks", value = 30 } },
		previous = 226,
	},
	{
		-- Sac de couchage douillet (objet 211527) : quête cachée 79976 « Ça
		-- doit être ici », dernière étape de la piste des notes. Icône de
		-- l'objet.
		id = 228, category = CAT.EXPLORATION, points = 10,
		icon = ICONS .. "INV_Misc_Bag_BigBagofEnchantments",
		criteria = { { type = "quest", id = 79976 } },
	},

	---------------------------------------------------------------------------
	-- Rares : tuer tous les rares d'une carte (critère « rare », un par
	-- rare). Sous-catégories Royaumes de l'Est et Kalimdor (cartes et méta du
	-- continent) ; l'île de Zéphras et le méta final à la racine, comme dans
	-- Exploration. Donjons : voir plus bas (274 à 293). Le jeu ne garde aucune trace des rares tués : ils sont vus
	-- en direct (Engine), donc pas rétroactifs.
	-- Liste : RareScanner, recoupée avec NaowhForever_DiscoveryData (rares
	-- propres à Forever). Retirés : rares amicaux pour un camp (Naowh,
	-- Questie), monstres de l'invasion du Fléau, boss mondiaux et seigneurs
	-- élémentaires invoqués, Lyn l'Ignoré (boss de donjon). Un rare qui
	-- parcourt plusieurs cartes n'est compté que sur sa carte principale.
	-- Noms : L.RARE_NAMES. Icône : famille d'un rare de la carte (Wowhead).
	---------------------------------------------------------------------------
	{
		-- Montagnes d'Alterac, carte 1416 (8 rares). Icône : Narillasanz
		id = 229, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Dragon_01",
		criteria = {
			{ type = "rare", id = 14281 }, -- Jimmy the Bleeder
			{ type = "rare", id = 14223 }, -- Cranky Benj
			{ type = "rare", id = 14222 }, -- Araga
			{ type = "rare", id = 14221 }, -- Gravis Slipknot
			{ type = "rare", id = 2452 }, -- Skhowl
			{ type = "rare", id = 2258 }, -- Stone Fury
			{ type = "rare", id = 2453 }, -- Lo'Grosh
			{ type = "rare", id = 2447 }, -- Narillasanz
		},
	},
	{
		-- Hautes-terres d'Arathi, carte 1417 (11 rares). Icône : Zalas Witherbark
		id = 230, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Troll_02",
		criteria = {
			{ type = "rare", id = 2600 }, -- Singer
			{ type = "rare", id = 217836 }, -- Needletooth
			{ type = "rare", id = 2603 }, -- Kovork
			{ type = "rare", id = 2606 }, -- Nimar the Slayer
			{ type = "rare", id = 2598 }, -- Darbel Montrose
			{ type = "rare", id = 2604 }, -- Molok the Crusher
			{ type = "rare", id = 2602 }, -- Ruul Onestone
			{ type = "rare", id = 2605 }, -- Zalas Witherbark
			{ type = "rare", id = 2779 }, -- Prince Nazjak
			{ type = "rare", id = 2601 }, -- Foulbelly
			{ type = "rare", id = 2609 }, -- Geomancer Flintdagger
		},
	},
	{
		-- Terres ingrates, carte 1418 (10 rares). Icône : Broken Tooth
		id = 231, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Cat",
		criteria = {
			{ type = "rare", id = 2751 }, -- War Golem
			{ type = "rare", id = 2850 }, -- Broken Tooth
			{ type = "rare", id = 2753 }, -- Barnabus
			{ type = "rare", id = 7057 }, -- Digmaster Shovelphlange
			{ type = "rare", id = 2744 }, -- Shadowforge Commander
			{ type = "rare", id = 2749 }, -- Siege Golem
			{ type = "rare", id = 14224 }, -- 7:XT
			{ type = "rare", id = 2754 }, -- Anathemus
			{ type = "rare", id = 2752 }, -- Rumbler
			{ type = "rare", id = 2931 }, -- Zaricotl
		},
	},
	{
		-- Terres foudroyées, carte 1419 (9 rares). Icône : Grunter
		id = 232, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Boar",
		criteria = {
			{ type = "rare", id = 8296 }, -- Mojo the Twisted
			{ type = "rare", id = 8302 }, -- Deatheye
			{ type = "rare", id = 8303 }, -- Grunter
			{ type = "rare", id = 8300 }, -- Ravage
			{ type = "rare", id = 8299 }, -- Spiteflayer
			{ type = "rare", id = 8301 }, -- Clack the Reaver
			{ type = "rare", id = 8298 }, -- Akubar the Seer
			{ type = "rare", id = 8297 }, -- Magronos the Unyielding
			{ type = "rare", id = 8304 }, -- Dreadscorn
		},
	},
	{
		-- Clairières de Tirisfal, carte 1420 (13 rares). Icône : Lost Soul
		id = 233, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Undead_01",
		criteria = {
			{ type = "rare", id = 274300 }, -- Coldrasp
			{ type = "rare", id = 1531 }, -- Lost Soul
			{ type = "rare", id = 276061 }, -- Decrepit Harvester
			{ type = "rare", id = 1936 }, -- Farmer Solliden
			{ type = "rare", id = 1533 }, -- Tormented Spirit
			{ type = "rare", id = 10356 }, -- Bayne
			{ type = "rare", id = 271080 }, -- Blightsculler
			{ type = "rare", id = 1910 }, -- Muad
			{ type = "rare", id = 10357 }, -- Ressan the Needler
			{ type = "rare", id = 276089 }, -- The Condemned One
			{ type = "rare", id = 1911 }, -- Deeb
			{ type = "rare", id = 10358 }, -- Fellicent's Shade
			{ type = "rare", id = 10359 }, -- Sri'skulk
		},
	},
	{
		-- Forêt des Pins-Argentés, carte 1421 (6 rares). Icône : Krethis Shadowspinner
		id = 234, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Spider",
		criteria = {
			{ type = "rare", id = 12431 }, -- Gorefang
			{ type = "rare", id = 12432 }, -- Old Vicejaw
			{ type = "rare", id = 12433 }, -- Krethis Shadowspinner
			{ type = "rare", id = 2283 }, -- Ravenclaw Regent
			{ type = "rare", id = 1944 }, -- Rot Hide Bruiser
			{ type = "rare", id = 1948 }, -- Snarlmane
		},
	},
	{
		-- Maleterres de l'Ouest, carte 1422 (12 rares). Icône : Scarlet
		id = 235, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Human_01",
		criteria = {
			{ type = "rare", id = 1847 }, -- Foulmane
			{ type = "rare", id = 1848 }, -- Lord Maldazzar
			{ type = "rare", id = 1844 }, -- Foreman Marcrid
			{ type = "rare", id = 1850 }, -- Putridius
			{ type = "rare", id = 1885 }, -- Scarlet Smith
			{ type = "rare", id = 1841 }, -- Scarlet Executioner
			{ type = "rare", id = 1837 }, -- Scarlet Judge
			{ type = "rare", id = 1838 }, -- Scarlet Interrogator
			{ type = "rare", id = 1843 }, -- Foreman Jerris
			{ type = "rare", id = 1851 }, -- The Husk
			{ type = "rare", id = 1839 }, -- Scarlet High Clerist
			{ type = "rare", id = 1849 }, -- Dreadwhisper
		},
	},
	{
		-- Maleterres de l'Est, carte 1423 (11 rares). Icône : Scourge
		-- Deux Abbendis : 10828 (classique) et 243893 (Forever), à deux
		-- endroits différents d'après Naowh et RareScanner.
		id = 236, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Scourge_01",
		criteria = {
			{ type = "rare", id = 10827 }, -- Deathspeaker Selendre
			{ type = "rare", id = 10825 }, -- Gish the Unmoving
			{ type = "rare", id = 10821 }, -- Hed'mush the Rotting
			{ type = "rare", id = 10826 }, -- Lord Darkscythe
			{ type = "rare", id = 10822 }, -- Warlord Thresh'jin
			{ type = "rare", id = 10828 }, -- High General Abbendis
			{ type = "rare", id = 10823 }, -- Zul'Brin Warpbranch
			{ type = "rare", id = 243893 }, -- High General Abbendis
			{ type = "rare", id = 243046 }, -- Scarlet Captain
			{ type = "rare", id = 10820 }, -- Duke Ragereaver
			{ type = "rare", id = 16184 }, -- Nerubian Overseer
		},
	},
	{
		-- Contreforts de Hautebrande, carte 1424 (7 rares). Icône : Tamra Stormpike
		id = 237, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Dwarf_01",
		criteria = {
			{ type = "rare", id = 14279 }, -- Creepthess
			{ type = "rare", id = 211951 }, -- Koartul
			{ type = "rare", id = 14280 }, -- Big Samras
			{ type = "rare", id = 14278 }, -- Ro'Bark
			{ type = "rare", id = 14275 }, -- Tamra Stormpike
			{ type = "rare", id = 14276 }, -- Scargil
			{ type = "rare", id = 14277 }, -- Lady Zephris
		},
	},
	{
		-- Les Hinterlands, carte 1425 (10 rares). Icône : Zul'arek Hatefowler
		id = 238, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Troll_01",
		criteria = {
			{ type = "rare", id = 8211 }, -- Old Cliff Jumper
			{ type = "rare", id = 8219 }, -- Zul'arek Hatefowler
			{ type = "rare", id = 8210 }, -- Razortalon
			{ type = "rare", id = 8218 }, -- Witherheart the Stalker
			{ type = "rare", id = 8216 }, -- Retherokk the Berserker
			{ type = "rare", id = 8212 }, -- The Reak
			{ type = "rare", id = 8215 }, -- Grimungous
			{ type = "rare", id = 8213 }, -- Ironback
			{ type = "rare", id = 8217 }, -- Mith'rethis the Enchanter
			{ type = "rare", id = 221333 }, -- Doomkin
		},
	},
	{
		-- Dun Morogh, carte 1426 (8 rares). Icône : Bjarn
		id = 239, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Bear",
		criteria = {
			{ type = "rare", id = 208812 }, -- Jorul
			{ type = "rare", id = 1137 }, -- Edan the Howler
			{ type = "rare", id = 276111 }, -- Ghostfang
			{ type = "rare", id = 1132 }, -- Timber
			{ type = "rare", id = 8503 }, -- Gibblewilt
			{ type = "rare", id = 1260 }, -- Great Father Arctikus
			{ type = "rare", id = 1130 }, -- Bjarn
			{ type = "rare", id = 1119 }, -- Hammerspine
		},
	},
	{
		-- Gorge des Vents brûlants, carte 1427 (11 rares). Icône : Slave Master Blackheart
		id = 240, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Dwarf_02",
		criteria = {
			{ type = "rare", id = 8279 }, -- Faulty War Golem
			{ type = "rare", id = 8280 }, -- Shleipnarr
			{ type = "rare", id = 8277 }, -- Rekk'tilac
			{ type = "rare", id = 8281 }, -- Scald
			{ type = "rare", id = 8283 }, -- Slave Master Blackheart
			{ type = "rare", id = 8278 }, -- Smoldar
			{ type = "rare", id = 8282 }, -- Highlord Mastrogonde
			{ type = "rare", id = 228721 }, -- Lieutenant Skarresh
			{ type = "rare", id = 228728 }, -- Flamebringer Kelris
			{ type = "rare", id = 228970 }, -- Galenges
			{ type = "rare", id = 228969 }, -- Lord Gazzran
		},
	},
	{
		-- Steppes ardentes, carte 1428 (9 rares). Icône : Hematos
		id = 241, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Dragon_Black",
		criteria = {
			{ type = "rare", id = 10077 }, -- Deathmaw
			{ type = "rare", id = 9604 }, -- Gorgon'och
			{ type = "rare", id = 9602 }, -- Hahk'Zor
			{ type = "rare", id = 10078 }, -- Terrorspark
			{ type = "rare", id = 8981 }, -- Malfunctioning Reaver
			{ type = "rare", id = 8978 }, -- Thauris Balgarr
			{ type = "rare", id = 8979 }, -- Gruklash
			{ type = "rare", id = 8976 }, -- Hematos
			{ type = "rare", id = 10119 }, -- Volchan
		},
	},
	{
		-- Forêt d'Elwynn, carte 1429 (7 rares). Icône : Narg the Taskmaster
		id = 242, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Gnoll_01",
		criteria = {
			{ type = "rare", id = 276189 }, -- Matriarch Bristlefur
			{ type = "rare", id = 99 }, -- Morgaine the Sly
			{ type = "rare", id = 79 }, -- Narg the Taskmaster
			{ type = "rare", id = 276180 }, -- Elder Finseer
			{ type = "rare", id = 61 }, -- Thuros Lightfingers
			{ type = "rare", id = 472 }, -- Fedfennel
			{ type = "rare", id = 100 }, -- Gruff Swiftbite
		},
	},
	{
		-- Bois de la Pénombre, carte 1431 (6 rares). Icône : Lupos
		id = 243, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Wolf",
		criteria = {
			{ type = "rare", id = 521 }, -- Lupos
			{ type = "rare", id = 574 }, -- Naraxis
			{ type = "rare", id = 503 }, -- Lord Malathrom
			{ type = "rare", id = 771 }, -- Commander Felstrom
			{ type = "rare", id = 507 }, -- Fenros
			{ type = "rare", id = 534 }, -- Nefaru
		},
	},
	{
		-- Loch Modan, carte 1432 (8 rares). Icône : Large Loch Crocolisk
		id = 244, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Crocolisk",
		criteria = {
			{ type = "rare", id = 1425 }, -- Grizlak
			{ type = "rare", id = 210107 }, -- Kackle
			{ type = "rare", id = 14268 }, -- Lord Condar
			{ type = "rare", id = 14267 }, -- Emogg the Crusher
			{ type = "rare", id = 14266 }, -- Shanda the Spinner
			{ type = "rare", id = 1399 }, -- Magosh
			{ type = "rare", id = 1398 }, -- Boss Galgosh
			{ type = "rare", id = 2476 }, -- Large Loch Crocolisk
		},
	},
	{
		-- Les Carmines, carte 1433 (10 rares). Icône : Kazon
		id = 245, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Orc_01",
		criteria = {
			{ type = "rare", id = 14271 }, -- Ribchaser
			{ type = "rare", id = 14272 }, -- Snarlflare
			{ type = "rare", id = 14270 }, -- Squiddic
			{ type = "rare", id = 14269 }, -- Seeker Aqualon
			{ type = "rare", id = 616 }, -- Chatter
			{ type = "rare", id = 214456 }, -- Dro'zem the Blasphemous
			{ type = "rare", id = 14273 }, -- Boulderheart
			{ type = "rare", id = 947 }, -- Rohh the Silent
			{ type = "rare", id = 584 }, -- Kazon
			{ type = "rare", id = 208845 }, -- Par'kourc
		},
	},
	{
		-- Vallée de Strangleronce, carte 1434 (10 rares). Icône : Kurmokk
		id = 246, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Gorilla",
		criteria = {
			{ type = "rare", id = 14487 }, -- Gluggle
			{ type = "rare", id = 14488 }, -- Roloch
			{ type = "rare", id = 14491 }, -- Kurmokk
			{ type = "rare", id = 14492 }, -- Verifonix
			{ type = "rare", id = 723 }, -- Mosh'Ogg Butcher
			{ type = "rare", id = 14490 }, -- Rippa
			{ type = "rare", id = 2541 }, -- Lord Sakrasis
			{ type = "rare", id = 1552 }, -- Scale Belly
			{ type = "rare", id = 9046 }, -- Scarshield Quartermaster
			{ type = "rare", id = 11383 }, -- High Priestess Hai'watna
		},
	},
	{
		-- Marais des Chagrins, carte 1435 (7 rares). Icône : Jade
		id = 247, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Dragon_Green",
		criteria = {
			{ type = "rare", id = 1106 }, -- Lost One Cook
			{ type = "rare", id = 763 }, -- Lost One Chieftain
			{ type = "rare", id = 14448 }, -- Molt Thorn
			{ type = "rare", id = 14446 }, -- Fingat
			{ type = "rare", id = 14447 }, -- Gilmorian
			{ type = "rare", id = 14445 }, -- Lord Captain Wyrmak
			{ type = "rare", id = 1063 }, -- Jade
		},
	},
	{
		-- Marche de l'Ouest, carte 1436 (8 rares). Icône : Vultros
		id = 248, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Vulture",
		criteria = {
			{ type = "rare", id = 1424 }, -- Master Digger
			{ type = "rare", id = 519 }, -- Slark
			{ type = "rare", id = 506 }, -- Sergeant Brashclaw
			{ type = "rare", id = 520 }, -- Brack
			{ type = "rare", id = 572 }, -- Leprithus
			{ type = "rare", id = 573 }, -- Foe Reaper 4000
			{ type = "rare", id = 462 }, -- Vultros
			{ type = "rare", id = 208847 }, -- The Snatcher
		},
	},
	{
		-- Les Paluns, carte 1437 (9 rares). Icône : Mirelow
		id = 249, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Spell_Frost_SummonWaterElemental",
		criteria = {
			{ type = "rare", id = 2090 }, -- Ma'ruk Wyrmscale
			{ type = "rare", id = 14425 }, -- Gnawbone
			{ type = "rare", id = 1112 }, -- Leech Widow
			{ type = "rare", id = 211965 }, -- Carrodin
			{ type = "rare", id = 14424 }, -- Mirelow
			{ type = "rare", id = 2108 }, -- Garneg Charskull
			{ type = "rare", id = 1037 }, -- Dragonmaw Battlemaster
			{ type = "rare", id = 14433 }, -- Sludginn
			{ type = "rare", id = 1140 }, -- Razormaw Matriarch
		},
	},
	{
		-- Rives Claires, carte 2548 (6 rares). Icône : Scaldaron
		id = 250, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Dragon_01",
		criteria = {
			{ type = "rare", id = 256410 }, -- Reginald Holmsby
			{ type = "rare", id = 256892 }, -- Kargra the Blind
			{ type = "rare", id = 257034 }, -- Mad Marrius
			{ type = "rare", id = 258032 }, -- Twilight Forgemaster
			{ type = "rare", id = 259758 }, -- Gul'gash
			{ type = "rare", id = 263141 }, -- Scaldaron
		},
	},
	{
		-- Capitales : Hurlevent et Fossoyeuse (2 rares). Icône : Sewer Beast
		id = 251, category = CAT.RARES_EASTERN_KINGDOMS, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Crocolisk",
		criteria = {
			{ type = "rare", id = 3581 }, -- Sewer Beast
			{ type = "rare", id = 204070 }, -- Soboz
		},
	},
	{
		-- Durotar, carte 1411 (9 rares). Icône : Death Flayer
		id = 252, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Scorpid",
		criteria = {
			{ type = "rare", id = 208124 }, -- Raluk
			{ type = "rare", id = 5826 }, -- Geolord Mottle
			{ type = "rare", id = 276198 }, -- Shal'ma
			{ type = "rare", id = 5808 }, -- Warlord Kolkanis
			{ type = "rare", id = 5809 }, -- Watch Commander Zalaphil
			{ type = "rare", id = 5824 }, -- Captain Flat Tusk
			{ type = "rare", id = 5823 }, -- Death Flayer
			{ type = "rare", id = 5822 }, -- Felweaver Scornn
			{ type = "rare", id = 276194 }, -- Dustwind Eggtender
		},
	},
	{
		-- Mulgore, carte 1412 (10 rares). Icône : The Rake
		id = 253, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Cat",
		criteria = {
			{ type = "rare", id = 205382 }, -- Mokwa
			{ type = "rare", id = 3068 }, -- Mazzranache
			{ type = "rare", id = 5786 }, -- Snagglespear
			{ type = "rare", id = 276109 }, -- Snarlsnout
			{ type = "rare", id = 5807 }, -- The Rake
			{ type = "rare", id = 5787 }, -- Enforcer Emilgund
			{ type = "rare", id = 5785 }, -- Sister Hatelash
			{ type = "rare", id = 3056 }, -- Ghost Howl
			{ type = "rare", id = 276105 }, -- Stormherald Ukta
			{ type = "rare", id = 276108 }, -- Thornstarter Igleg
		},
	},
	{
		-- Les Tarides, carte 1413 (27 rares). Icône : Takk the Leaper
		id = 254, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Raptor",
		criteria = {
			{ type = "rare", id = 5865 }, -- Dishu
			{ type = "rare", id = 209742 }, -- Desert Mirage
			{ type = "rare", id = 3270 }, -- Elder Mystic Razorsnout
			{ type = "rare", id = 3470 }, -- Rathorian
			{ type = "rare", id = 5837 }, -- Stonearm
			{ type = "rare", id = 5838 }, -- Brokespear
			{ type = "rare", id = 5841 }, -- Rocklance
			{ type = "rare", id = 5829 }, -- Snort the Heckler
			{ type = "rare", id = 5836 }, -- Engineer Whirleygig
			{ type = "rare", id = 5835 }, -- Foreman Grills
			{ type = "rare", id = 5863 }, -- Geopriest Gukk'rok
			{ type = "rare", id = 5830 }, -- Sister Rathtalon
			{ type = "rare", id = 3295 }, -- Sludge Beast
			{ type = "rare", id = 5842 }, -- Takk the Leaper
			{ type = "rare", id = 3398 }, -- Gesharahan
			{ type = "rare", id = 5831 }, -- Swiftmane
			{ type = "rare", id = 5864 }, -- Swinegart Spearhide
			{ type = "rare", id = 5828 }, -- Humar the Pridelord
			{ type = "rare", id = 5849 }, -- Digger Flameforge
			{ type = "rare", id = 3253 }, -- Silithid Harvester
			{ type = "rare", id = 5832 }, -- Thunderstomp
			{ type = "rare", id = 5834 }, -- Azzere the Skyblade
			{ type = "rare", id = 5848 }, -- Malgin Barleybrew
			{ type = "rare", id = 5859 }, -- Hagg Taurenbane
			{ type = "rare", id = 5827 }, -- Brontus
			{ type = "rare", id = 5851 }, -- Captain Gerogg Hammertoe
			{ type = "rare", id = 7895 }, -- Ambassador Bloodrage
		},
	},
	{
		-- Teldrassil, carte 1438 (9 rares). Icône : Duskstalker
		id = 255, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Cat",
		criteria = {
			{ type = "rare", id = 14432 }, -- Threggil
			{ type = "rare", id = 14428 }, -- Uruson
			{ type = "rare", id = 14431 }, -- Fury Shelda
			{ type = "rare", id = 209928 }, -- Mowgh
			{ type = "rare", id = 276099 }, -- Wrathvine
			{ type = "rare", id = 14430 }, -- Duskstalker
			{ type = "rare", id = 276101 }, -- Nightscreech
			{ type = "rare", id = 14429 }, -- Grimmaw
			{ type = "rare", id = 3535 }, -- Blackmoss the Fetid
		},
	},
	{
		-- Sombrivage, carte 1439 (9 rares). Icône : Strider Clutchmother
		id = 256, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_TallStrider",
		criteria = {
			{ type = "rare", id = 2175 }, -- Shadowclaw
			{ type = "rare", id = 2191 }, -- Licillin
			{ type = "rare", id = 7017 }, -- Lord Sinslayer
			{ type = "rare", id = 2186 }, -- Carnivous the Breaker
			{ type = "rare", id = 7015 }, -- Flagglemurk the Cruel
			{ type = "rare", id = 2184 }, -- Lady Moongazer
			{ type = "rare", id = 2192 }, -- Firecaller Radison
			{ type = "rare", id = 2172 }, -- Strider Clutchmother
			{ type = "rare", id = 7016 }, -- Lady Vespira
		},
	},
	{
		-- Orneval, carte 1440 (12 rares). Icône : Ursol'lok
		id = 257, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Bear",
		criteria = {
			{ type = "rare", id = 3735 }, -- Apothecary Falthis
			{ type = "rare", id = 10559 }, -- Lady Vespia
			{ type = "rare", id = 10644 }, -- Mist Howler
			{ type = "rare", id = 10643 }, -- Mugglefin
			{ type = "rare", id = 10641 }, -- Branch Snapper
			{ type = "rare", id = 10639 }, -- Rorgish Jowl
			{ type = "rare", id = 3773 }, -- Akkrilus
			{ type = "rare", id = 10642 }, -- Eck'alom
			{ type = "rare", id = 10640 }, -- Oakpaw
			{ type = "rare", id = 3792 }, -- Terrowulf Packlord
			{ type = "rare", id = 12037 }, -- Ursol'lok
			{ type = "rare", id = 10647 }, -- Prince Raze
		},
	},
	{
		-- Mille pointes, carte 1441 (7 rares). Icône : Vile Sting
		id = 258, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Scorpid",
		criteria = {
			{ type = "rare", id = 14426 }, -- Harb Foulmountain
			{ type = "rare", id = 14427 }, -- Gibblesnik
			{ type = "rare", id = 5933 }, -- Achellios the Banished
			{ type = "rare", id = 5934 }, -- Heartrazor
			{ type = "rare", id = 5937 }, -- Vile Sting
			{ type = "rare", id = 4132 }, -- Silithid Ravager
			{ type = "rare", id = 5935 }, -- Ironeye the Invincible
		},
	},
	{
		-- Les Serres-Rocheuses, carte 1442 (8 rares). Icône : Pridewing Patriarch
		id = 259, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Mount_Wyvern_01",
		criteria = {
			{ type = "rare", id = 5932 }, -- Taskmaster Whipfang
			{ type = "rare", id = 5931 }, -- Foreman Rigger
			{ type = "rare", id = 4015 }, -- Pridewing Patriarch
			{ type = "rare", id = 5928 }, -- Sorrow Wing
			{ type = "rare", id = 5930 }, -- Sister Riven
			{ type = "rare", id = 5915 }, -- Brother Ravenoak
			{ type = "rare", id = 4030 }, -- Vengeful Ancient
			{ type = "rare", id = 4066 }, -- Nal'taszar
		},
	},
	{
		-- Désolace, carte 1443 (5 rares). Icône : Prince Kellen
		id = 260, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Spell_Shadow_SummonFelGuard",
		criteria = {
			{ type = "rare", id = 14225 }, -- Prince Kellen
			{ type = "rare", id = 14228 }, -- Giggler
			{ type = "rare", id = 14229 }, -- Accursed Slitherblade
			{ type = "rare", id = 14227 }, -- Hissperak
			{ type = "rare", id = 14226 }, -- Kaskk
		},
	},
	{
		-- Féralas, carte 1444 (13 rares). Icône : Old Grizzlegut
		-- Skarr, Mushgog et La Razza : champions de l'arène de Hache-Tripes,
		-- un seul à la fois.
		id = 261, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Bear",
		criteria = {
			{ type = "rare", id = 5356 }, -- Snarler
			{ type = "rare", id = 5352 }, -- Old Grizzlegut
			{ type = "rare", id = 5354 }, -- Gnarl Leafbrother
			{ type = "rare", id = 5345 }, -- Diamond Head
			{ type = "rare", id = 5343 }, -- Lady Szallah
			{ type = "rare", id = 222726 }, -- Tyrant of the Hive
			{ type = "rare", id = 5350 }, -- Qirot
			{ type = "rare", id = 5347 }, -- Antilus the Soarer
			{ type = "rare", id = 5346 }, -- Bloodroar the Stalker
			{ type = "rare", id = 5349 }, -- Arash-ethis
			{ type = "rare", id = 11498 }, -- Skarr the Unbreakable
			{ type = "rare", id = 11447 }, -- Mushgog
			{ type = "rare", id = 11497 }, -- The Razza
		},
	},
	{
		-- Marécage d'Âprefange, carte 1445 (10 rares). Icône : Hayoc
		id = 262, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_WindSerpent",
		criteria = {
			{ type = "rare", id = 14231 }, -- Drogoth the Roamer
			{ type = "rare", id = 14230 }, -- Burgle Eye
			{ type = "rare", id = 14232 }, -- Dart
			{ type = "rare", id = 14233 }, -- Ripscale
			{ type = "rare", id = 4380 }, -- Darkmist Widow
			{ type = "rare", id = 14234 }, -- Hayoc
			{ type = "rare", id = 14237 }, -- Oozeworm
			{ type = "rare", id = 14235 }, -- The Rot
			{ type = "rare", id = 14236 }, -- Lord Angler
			{ type = "rare", id = 4339 }, -- Brimgore
		},
	},
	{
		-- Tanaris, carte 1446 (10 rares). Icône : Murderous Blisterpaw
		id = 263, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Hyena",
		criteria = {
			{ type = "rare", id = 8208 }, -- Murderous Blisterpaw
			{ type = "rare", id = 222243 }, -- Zopilote
			{ type = "rare", id = 8199 }, -- Warleader Krazzilak
			{ type = "rare", id = 8207 }, -- Greater Firebird
			{ type = "rare", id = 8200 }, -- Jin'Zallah the Sandbringer
			{ type = "rare", id = 8203 }, -- Kregg Keelhaul
			{ type = "rare", id = 8202 }, -- Cyclok the Mad
			{ type = "rare", id = 8205 }, -- Haarka the Ravenous
			{ type = "rare", id = 8201 }, -- Omgorn the Lost
			{ type = "rare", id = 8204 }, -- Soriid the Devourer
		},
	},
	{
		-- Azshara, carte 1447 (10 rares). Icône : Varo'then
		id = 264, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "INV_Misc_Head_Elf_02",
		criteria = {
			{ type = "rare", id = 8660 }, -- The Evalcharr
			{ type = "rare", id = 6118 }, -- Varo'then's Ghost
			{ type = "rare", id = 6651 }, -- Gatekeeper Rageroar
			{ type = "rare", id = 6648 }, -- Antilos
			{ type = "rare", id = 6650 }, -- General Fangferror
			{ type = "rare", id = 6649 }, -- Lady Sesspira
			{ type = "rare", id = 6647 }, -- Magister Hawkhelm
			{ type = "rare", id = 6652 }, -- Master Feardred
			{ type = "rare", id = 13896 }, -- Scalebeard
			{ type = "rare", id = 6646 }, -- Monnos the Elder
		},
	},
	{
		-- Gangrebois, carte 1448 (7 rares). Icône : Death Howl
		id = 265, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Wolf",
		criteria = {
			{ type = "rare", id = 14339 }, -- Death Howl
			{ type = "rare", id = 14344 }, -- Mongress
			{ type = "rare", id = 14342 }, -- Ragepaw
			{ type = "rare", id = 14345 }, -- The Ongar
			{ type = "rare", id = 14340 }, -- Alshirr Banebreath
			{ type = "rare", id = 7104 }, -- Dessecus
			{ type = "rare", id = 7137 }, -- Immolatus
		},
	},
	{
		-- Cratère d'Un'Goro, carte 1449 (5 rares). Icône : King Mosh
		id = 266, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Devilsaur",
		criteria = {
			{ type = "rare", id = 6581 }, -- Ravasaur Matriarch
			{ type = "rare", id = 6585 }, -- Uhk'loc
			{ type = "rare", id = 6582 }, -- Clutchmother Zavas
			{ type = "rare", id = 6583 }, -- Gruff
			{ type = "rare", id = 6584 }, -- King Mosh
		},
	},
	{
		-- Silithus, carte 1451 (10 rares). Icône : Rex Ashil
		id = 267, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_Silithid",
		criteria = {
			{ type = "rare", id = 14476 }, -- Krellack
			{ type = "rare", id = 14472 }, -- Gretheer
			{ type = "rare", id = 14475 }, -- Rex Ashil
			{ type = "rare", id = 14477 }, -- Grubthor
			{ type = "rare", id = 14478 }, -- Huricanian
			{ type = "rare", id = 14474 }, -- Zora
			{ type = "rare", id = 224965 }, -- Khonsu
			{ type = "rare", id = 14473 }, -- Lapress
			{ type = "rare", id = 14479 }, -- Twilight Lord Everun
			{ type = "rare", id = 14471 }, -- Setis
		},
	},
	{
		-- Berceau-de-l'Hiver, carte 1452 (8 rares). Icône : Azurous
		id = 268, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "INV_Misc_Head_Dragon_Blue",
		criteria = {
			{ type = "rare", id = 10197 }, -- Mezzir the Howler
			{ type = "rare", id = 10196 }, -- General Colbatann
			{ type = "rare", id = 10200 }, -- Rak'shiri
			{ type = "rare", id = 228814 }, -- Arcterris
			{ type = "rare", id = 10202 }, -- Azurous
			{ type = "rare", id = 10199 }, -- Grizzle Snowpaw
			{ type = "rare", id = 10198 }, -- Kashoch the Reaver
			{ type = "rare", id = 10201 }, -- Lady Hederine
		},
	},
	{
		-- Mont Hyjal, carte 2482 (7 rares). Icône : Death Wailer
		id = 269, category = CAT.RARES_KALIMDOR, points = 10,
		icon = ICONS .. "INV_Misc_Head_Undead_02",
		criteria = {
			{ type = "rare", id = 255183 }, -- Jezerelle the Swaying
			{ type = "rare", id = 260823 }, -- Overseer Myoleth
			{ type = "rare", id = 266901 }, -- Pexmit
			{ type = "rare", id = 249226 }, -- Death Wailer
			{ type = "rare", id = 249238 }, -- Legion Hulk
			{ type = "rare", id = 256830 }, -- Bannerwing Survivor
			{ type = "rare", id = 263935 }, -- Old Rusthowl
		},
	},
	{
		-- Île de Zéphras, carte 2521 (8 rares). Icône : Tel'daeor
		-- Seulement dans le méta final (Terminator).
		id = 270, category = CAT.RARES, points = 10,
		icon = ICONS .. "INV_Misc_Head_Elf_01",
		criteria = {
			{ type = "rare", id = 255887 }, -- Slydris
			{ type = "rare", id = 259394 }, -- Snapbeak the Quick
			{ type = "rare", id = 256028 }, -- The Lost One
			{ type = "rare", id = 256492 }, -- Fernfeather
			{ type = "rare", id = 259398 }, -- Galemender Delanea
			{ type = "rare", id = 250936 }, -- Den'dralass
			{ type = "rare", id = 259388 }, -- Mystmane
			{ type = "rare", id = 259385 }, -- Tel'daeor the Stormspeaker
		},
	},
	{
		-- Méta : Royaumes de l'Est (cartes et capitales)
		id = 271, category = CAT.RARES_EASTERN_KINGDOMS, points = 25,
		icon = ICONS .. "Achievement_BG_Xkills_AVgraveyard",
		criteria = {
			{ type = "achievement", id = 229 }, { type = "achievement", id = 230 },
			{ type = "achievement", id = 231 }, { type = "achievement", id = 232 },
			{ type = "achievement", id = 233 }, { type = "achievement", id = 234 },
			{ type = "achievement", id = 235 }, { type = "achievement", id = 236 },
			{ type = "achievement", id = 237 }, { type = "achievement", id = 238 },
			{ type = "achievement", id = 239 }, { type = "achievement", id = 240 },
			{ type = "achievement", id = 241 }, { type = "achievement", id = 242 },
			{ type = "achievement", id = 243 }, { type = "achievement", id = 244 },
			{ type = "achievement", id = 245 }, { type = "achievement", id = 246 },
			{ type = "achievement", id = 247 }, { type = "achievement", id = 248 },
			{ type = "achievement", id = 249 }, { type = "achievement", id = 250 },
			{ type = "achievement", id = 251 },
		},
	},
	{
		-- Méta : Kalimdor
		id = 272, category = CAT.RARES_KALIMDOR, points = 25,
		icon = ICONS .. "Achievement_Scenario_TombofForgottenKings",
		criteria = {
			{ type = "achievement", id = 252 }, { type = "achievement", id = 253 },
			{ type = "achievement", id = 254 }, { type = "achievement", id = 255 },
			{ type = "achievement", id = 256 }, { type = "achievement", id = 257 },
			{ type = "achievement", id = 258 }, { type = "achievement", id = 259 },
			{ type = "achievement", id = 260 }, { type = "achievement", id = 261 },
			{ type = "achievement", id = 262 }, { type = "achievement", id = 263 },
			{ type = "achievement", id = 264 }, { type = "achievement", id = 265 },
			{ type = "achievement", id = 266 }, { type = "achievement", id = 267 },
			{ type = "achievement", id = 268 }, { type = "achievement", id = 269 },
		},
	},
	{
		-- Méta final : les deux continents et l'île de Zéphras.
		id = 273, category = CAT.RARES, points = 50,
		icon = ICONS .. "Achievement_Boss_LichKing",
		criteria = {
			{ type = "achievement", id = 271 },
			{ type = "achievement", id = 272 },
			{ type = "achievement", id = 270 },
		},
	},

	---------------------------------------------------------------------------
	-- Rares > Donjons : un haut fait par donjon, les rares de la grotte
	-- d'entrée avec leur donjon (cartes « entrée » de RareScanner). Icône :
	-- celle du haut fait du donjon. Tous hostiles ou neutres (Questie et
	-- FactionTemplate), sauf ceux propres à Forever, sans faction connue.
	---------------------------------------------------------------------------
	{
		-- Mortemines et sa grotte d'entrée
		id = 274, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_EdwinVancleef",
		criteria = {
			{ type = "rare", id = 3586 }, -- Miner Johnson
			{ type = "rare", id = 596 }, -- Brainwashed Noble
			{ type = "rare", id = 599 }, -- Marisa du'Paige
		},
	},
	{
		-- Cavernes des Lamentations et leur entrée
		id = 275, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_Mutanus_the_Devourer",
		criteria = {
			{ type = "rare", id = 5912 }, -- Deviate Faerie Dragon
			{ type = "rare", id = 3652 }, -- Trigore the Lasher
			{ type = "rare", id = 3672 }, -- Boahn
		},
	},
	{
		-- Donjon d'Ombrecroc
		id = 276, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_ArchmageArugal",
		criteria = {
			{ type = "rare", id = 211764 }, -- Gefell
			{ type = "rare", id = 211765 }, -- Gemela
			{ type = "rare", id = 3872 }, -- Deathsworn Captain
		},
	},
	{
		-- Kraal de Tranchebauge
		id = 277, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_CharlgaRazorflank",
		criteria = {
			{ type = "rare", id = 4425 }, -- Blind Hunter
			{ type = "rare", id = 4438 }, -- Razorfen Spearhide
			{ type = "rare", id = 4842 }, -- Earthcaller Halmgar
		},
	},
	{
		-- Gnomeregan
		id = 278, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "INV_Gizmo_02",
		criteria = {
			{ type = "rare", id = 6228 }, -- Dark Iron Ambassador
		},
	},
	{
		-- Monastère écarlate (cimetière)
		id = 279, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "INV_Misc_Bone_HumanSkull_01",
		criteria = {
			{ type = "rare", id = 6488 }, -- Fallen Champion
			{ type = "rare", id = 6489 }, -- Ironspine
			{ type = "rare", id = 6490 }, -- Azshir the Sleepless (neutre)
		},
	},
	{
		-- Zul'Farrak
		id = 280, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_ChiefUkorzSandscalp",
		criteria = {
			{ type = "rare", id = 10080 }, -- Sandarr Dunereaver
			{ type = "rare", id = 10081 }, -- Dustwraith
			{ type = "rare", id = 10082 }, -- Zerillis
		},
	},
	{
		-- Maraudon
		id = 281, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_PrincessTheradras",
		criteria = {
			{ type = "rare", id = 12237 }, -- Meshlok the Harvester
		},
	},
	{
		-- Temple englouti (carte de l'entrée chez RareScanner)
		id = 282, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_ShadeOfEranikus",
		criteria = {
			{ type = "rare", id = 5399 }, -- Veyzhak the Cannibal
			{ type = "rare", id = 5400 }, -- Zekkis
		},
	},
	{
		-- Profondeurs de Rochenoire et leur entrée
		id = 283, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_EmperorDagranThaurissan",
		criteria = {
			{ type = "rare", id = 8923 }, -- Panzor the Invincible
			{ type = "rare", id = 9024 }, -- Pyromancer Loregrain
			{ type = "rare", id = 9041 }, -- Warder Stilgiss
			{ type = "rare", id = 9042 }, -- Verek
			{ type = "rare", id = 8924 }, -- The Behemoth
		},
	},
	{
		-- Bas du pic Rochenoire
		id = 284, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_Overlord_Wyrmthalak",
		criteria = {
			{ type = "rare", id = 10263 }, -- Burning Felguard
			{ type = "rare", id = 10376 }, -- Crystal Fang
			{ type = "rare", id = 9217 }, -- Spirestone Lord Magus
			{ type = "rare", id = 9218 }, -- Spirestone Battle Lord
			{ type = "rare", id = 9219 }, -- Spirestone Butcher
			{ type = "rare", id = 9596 }, -- Bannok Grimaxe
			{ type = "rare", id = 9718 }, -- Ghok Bashguud
		},
	},
	{
		-- Sommet du pic Rochenoire
		id = 285, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Achievement_Boss_GeneralDrakkisath",
		criteria = {
			{ type = "rare", id = 10509 }, -- Jed Runewatcher
			{ type = "rare", id = 10899 }, -- Goraluk Anvilcrack
		},
	},
	{
		-- Hache-Tripes (aile Ouest)
		id = 286, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "INV_Misc_Book_11",
		criteria = {
			{ type = "rare", id = 11467 }, -- Tsu'zee
			{ type = "rare", id = 14506 }, -- Lord Hel'nurath
		},
	},
	{
		-- Stratholme (les deux côtés)
		id = 287, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Spell_DeathKnight_ArmyOfTheDead",
		criteria = {
			{ type = "rare", id = 10558 }, -- Hearthsinger Forresten (neutre)
			{ type = "rare", id = 10393 }, -- Skul
			{ type = "rare", id = 10809 }, -- Stonespine
		},
	},
	{
		-- Ruines de Lordaeron (Forever)
		id = 288, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Undead_01",
		criteria = {
			{ type = "rare", id = 255699 }, -- Lordaeron Captain
		},
	},
	{
		-- Cité Submergée (Forever)
		id = 289, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Spell_Frost_SummonWaterElemental",
		criteria = {
			{ type = "rare", id = 260468 }, -- "Pyromancer" Braxton
			{ type = "rare", id = 264172 }, -- Umbra
			{ type = "rare", id = 264177 }, -- Gill
		},
	},
	{
		-- Bastion Krol'dok (Forever)
		id = 290, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "INV_Misc_Key_13",
		criteria = {
			{ type = "rare", id = 262716 }, -- Kroog
		},
	},
	{
		-- Repaire des Noiregueules (Forever), intérieur compris
		id = 291, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "INV_Misc_MonsterClaw_04",
		criteria = {
			{ type = "rare", id = 250034 }, -- Tunnelweb Matriarch
			{ type = "rare", id = 269111 }, -- Gortek the Apprentice
			{ type = "rare", id = 269104 }, -- Moontouched Wanderer
		},
	},
	{
		-- Cité de Dalaran (Forever) : Lyn l'Ignoré, boss secret qu'on fait
		-- apparaître avec le Tome de Dalaran (RareScanner le range à tort dans
		-- les montagnes d'Alterac). L'ancien haut fait 177, retiré, le
		-- détectait par la rencontre ; ici, par la mort en cible ou la fouille.
		id = 292, category = CAT.RARES_DUNGEONS, points = 10,
		icon = ICONS .. "Spell_Arcane_PortalDalaran",
		criteria = {
			{ type = "rare", id = 247032 }, -- Lyn the Ignored
		},
	},
	{
		-- Méta : tous les donjons
		id = 293, category = CAT.RARES_DUNGEONS, points = 25,
		icon = ICONS .. "Achievement_Dungeon_TombOfSargeras",
		criteria = {
			{ type = "achievement", id = 274 }, { type = "achievement", id = 275 },
			{ type = "achievement", id = 276 }, { type = "achievement", id = 277 },
			{ type = "achievement", id = 278 }, { type = "achievement", id = 279 },
			{ type = "achievement", id = 280 }, { type = "achievement", id = 281 },
			{ type = "achievement", id = 282 }, { type = "achievement", id = 283 },
			{ type = "achievement", id = 284 }, { type = "achievement", id = 285 },
			{ type = "achievement", id = 286 }, { type = "achievement", id = 287 },
			{ type = "achievement", id = 288 }, { type = "achievement", id = 289 },
			{ type = "achievement", id = 290 }, { type = "achievement", id = 291 },
			{ type = "achievement", id = 292 },
		},
	},

	---------------------------------------------------------------------------
	-- JcJ : statistique 588 « Nombre total de victoires honorables » et 319
	-- « Duels gagnés »,
	-- additionnées sur le compte
	---------------------------------------------------------------------------
	{
		id = 108, category = CAT.PVP, points = 10,
		icon = ICONS .. "Achievement_PVP_P_01",
		criteria = { { type = "statistic", id = 588, value = 1, combine = "sum" } },
	},
	{
		id = 109, category = CAT.PVP, points = 10,
		icon = ICONS .. "Achievement_PVP_P_02",
		criteria = { { type = "statistic", id = 588, value = 100, combine = "sum" } },
		previous = 108,
	},
	{
		id = 110, category = CAT.PVP, points = 10,
		icon = ICONS .. "Achievement_PVP_P_03",
		criteria = { { type = "statistic", id = 588, value = 500, combine = "sum" } },
		previous = 109,
	},
	{
		id = 111, category = CAT.PVP, points = 10,
		icon = ICONS .. "Achievement_PVP_P_04",
		criteria = { { type = "statistic", id = 588, value = 1000, combine = "sum" } },
		previous = 110,
	},
	{
		id = 112, category = CAT.PVP, points = 10,
		icon = ICONS .. "Achievement_PVP_P_06",
		criteria = { { type = "statistic", id = 588, value = 5000, combine = "sum" } },
		previous = 111,
	},
	{
		id = 113, category = CAT.PVP, points = 10,
		icon = ICONS .. "Achievement_PVP_P_09",
		criteria = { { type = "statistic", id = 588, value = 10000, combine = "sum" } },
		previous = 112,
	},
	{
		id = 114, category = CAT.PVP, points = 10,
		icon = ICONS .. "Achievement_PVP_P_11",
		criteria = { { type = "statistic", id = 588, value = 25000, combine = "sum" } },
		previous = 113,
	},
	{
		id = 115, category = CAT.PVP, points = 10,
		icon = ICONS .. "Achievement_PVP_P_14",
		criteria = { { type = "statistic", id = 588, value = 50000, combine = "sum" } },
		previous = 114,
	},
	{
		id = 116, category = CAT.PVP, points = 10,
		icon = ICONS .. "Achievement_PVP_P_15",
		criteria = { { type = "statistic", id = 588, value = 100000, combine = "sum" } },
		previous = 115,
	},
	{
		id = 117, category = CAT.PVP, points = 10,
		icon = ICONS .. "Ability_DualWieldSpecialization",
		criteria = { { type = "statistic", id = 319, value = 1, combine = "sum" } },
	},
	{
		-- Conquérant (Horde) : méta des trois réputations de champ de bataille
		id = 147, category = CAT.PVP, points = 20, faction = "Horde",
		icon = ICONS .. "INV_Misc_TabardPVP_04",
		criteria = {
			{ type = "achievement", id = 141 }, -- Voltigeur Chanteguerre
			{ type = "achievement", id = 143 }, -- Profanateur
			{ type = "achievement", id = 145 }, -- Héros du clan Loup-de-givre
		},
	},
	{
		-- Le justicier (Alliance)
		id = 148, category = CAT.PVP, points = 20, faction = "Alliance",
		icon = ICONS .. "INV_Misc_TabardPVP_03",
		criteria = {
			{ type = "achievement", id = 142 }, -- Sentinelle d'Aile-argent
			{ type = "achievement", id = 144 }, -- Chevalier d'Arathor
			{ type = "achievement", id = 146 }, -- Héros de la garde Foudrepique
		},
	},

	---------------------------------------------------------------------------
	-- JcJ : goulet des Chanteguerres
	-- 105 victoires, 395 drapeaux capturés, 586 drapeaux ramenés
	---------------------------------------------------------------------------
	{
		id = 118, category = CAT.WARSONG_GULCH, points = 10,
		icon = ICONS .. "Achievement_BG_winWSG",
		criteria = { { type = "statistic", id = 105, value = 1, combine = "sum" } },
	},
	{
		id = 119, category = CAT.WARSONG_GULCH, points = 10,
		icon = ICONS .. "Achievement_BG_win_WSG_X_times",
		criteria = { { type = "statistic", id = 105, value = 100, combine = "sum" } },
		previous = 118,
	},
	{
		id = 120, category = CAT.WARSONG_GULCH, points = 10,
		icon = ICONS .. "Achievement_BG_captureflag_WSG",
		criteria = { { type = "statistic", id = 395, value = 1, combine = "sum" } },
	},
	{
		id = 121, category = CAT.WARSONG_GULCH, points = 10,
		icon = ICONS .. "Achievement_BG_interruptX_flagcapture_attempts",
		criteria = { { type = "statistic", id = 586, value = 50, combine = "sum" } },
	},
	{
		id = 141, category = CAT.WARSONG_GULCH, points = 10, faction = "Horde",
		icon = ICONS .. "Ability_Warrior_WarCry",
		criteria = { { type = "reputation", factionID = 889 } }, -- Voltigeurs Chanteguerre
	},
	{
		id = 142, category = CAT.WARSONG_GULCH, points = 10, faction = "Alliance",
		icon = ICONS .. "Ability_Racial_ShadowMeld",
		criteria = { { type = "reputation", factionID = 890 } }, -- Sentinelles d'Aile-argent
	},

	---------------------------------------------------------------------------
	-- JcJ : bassin Arathi
	-- 51 victoires, 64349 bases défendues, 64348 bases attaquées (Forever)
	---------------------------------------------------------------------------
	{
		id = 122, category = CAT.ARATHI_BASIN, points = 10,
		icon = ICONS .. "Achievement_BG_winAB",
		criteria = { { type = "statistic", id = 51, value = 1, combine = "sum" } },
	},
	{
		id = 123, category = CAT.ARATHI_BASIN, points = 10,
		icon = ICONS .. "Achievement_BG_win_AB_X_times",
		criteria = { { type = "statistic", id = 51, value = 100, combine = "sum" } },
		previous = 122,
	},
	{
		id = 124, category = CAT.ARATHI_BASIN, points = 10,
		icon = ICONS .. "Ability_Warrior_VictoryRush",
		criteria = { { type = "statistic", id = 64349, value = 50, combine = "sum" } },
	},
	{
		id = 125, category = CAT.ARATHI_BASIN, points = 10,
		icon = ICONS .. "Achievement_BG_takeXflags_AB",
		criteria = { { type = "statistic", id = 64348, value = 50, combine = "sum" } },
	},
	{
		id = 143, category = CAT.ARATHI_BASIN, points = 10, faction = "Horde",
		icon = ICONS .. "Spell_Shadow_PsychicHorrors",
		criteria = { { type = "reputation", factionID = 510 } }, -- Profanateurs
	},
	{
		id = 144, category = CAT.ARATHI_BASIN, points = 10, faction = "Alliance",
		icon = ICONS .. "Ability_Warrior_RallyingCry",
		criteria = { { type = "reputation", factionID = 509 } }, -- Ligue d'Arathor
	},

	---------------------------------------------------------------------------
	-- JcJ : vallée d'Alterac
	-- 49 victoires, 393 tours défendues
	---------------------------------------------------------------------------
	{
		id = 126, category = CAT.ALTERAC_VALLEY, points = 10,
		icon = ICONS .. "Achievement_BG_winAV",
		criteria = { { type = "statistic", id = 49, value = 1, combine = "sum" } },
	},
	{
		id = 127, category = CAT.ALTERAC_VALLEY, points = 10,
		icon = ICONS .. "Achievement_BG_win_AV_X_times",
		criteria = { { type = "statistic", id = 49, value = 100, combine = "sum" } },
		previous = 126,
	},
	{
		id = 128, category = CAT.ALTERAC_VALLEY, points = 10,
		icon = ICONS .. "Achievement_BG_defendXtowers_AV",
		criteria = { { type = "statistic", id = 393, value = 50, combine = "sum" } },
	},
	{
		id = 145, category = CAT.ALTERAC_VALLEY, points = 10, faction = "Horde",
		icon = ICONS .. "INV_Jewelry_FrostwolfTrinket_05",
		criteria = { { type = "reputation", factionID = 729 } }, -- Clan Loup-de-givre
	},
	{
		id = 146, category = CAT.ALTERAC_VALLEY, points = 10, faction = "Alliance",
		icon = ICONS .. "INV_Jewelry_StormPikeTrinket_05",
		criteria = { { type = "reputation", factionID = 730 } }, -- Garde Foudrepique
	},

	---------------------------------------------------------------------------
	-- JcJ : îles des Sombrelances (champ de bataille de Forever)
	-- 64176 victoires, 64352 drapeaux capturés, 64350 bases attaquées.
	-- Réputations : celles du haut fait natif 62049, dont l'icône sert au 213.
	---------------------------------------------------------------------------
	{
		id = 213, category = CAT.DARKSPEAR_ISLANDS, points = 10,
		icon = ICONS .. "Trade_Archaeology_Troll_Tablet",
		criteria = { { type = "statistic", id = 64176, value = 1, combine = "sum" } },
	},
	{
		id = 214, category = CAT.DARKSPEAR_ISLANDS, points = 10,
		icon = ICONS .. "INV_Misc_Head_Troll_01",
		criteria = { { type = "statistic", id = 64176, value = 100, combine = "sum" } },
		previous = 213,
	},
	{
		id = 215, category = CAT.DARKSPEAR_ISLANDS, points = 10,
		icon = ICONS .. "Achievement_BG_captureflag_EOS",
		criteria = { { type = "statistic", id = 64352, value = 50, combine = "sum" } },
	},
	{
		id = 216, category = CAT.DARKSPEAR_ISLANDS, points = 10,
		icon = ICONS .. "Ability_Warrior_Charge",
		criteria = { { type = "statistic", id = 64350, value = 50, combine = "sum" } },
	},
	{
		id = 217, category = CAT.DARKSPEAR_ISLANDS, points = 10, faction = "Horde",
		icon = ICONS .. "Achievement_Character_Troll_Male",
		criteria = { { type = "reputation", factionID = 2798 } }, -- Chevaucheurs sombrelances
	},
	{
		id = 218, category = CAT.DARKSPEAR_ISLANDS, points = 10, faction = "Alliance",
		icon = ICONS .. "Spell_Arcane_TeleportTheramore",
		criteria = { { type = "reputation", factionID = 2799 } }, -- Troupe d'intervention de Theramore
	},

	---------------------------------------------------------------------------
	-- Métiers (skillLine = id de la ligne de compétence du métier)
	---------------------------------------------------------------------------
	{
		id = 58, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Note_01",
		criteria = { { type = "profession", value = 150 } },
	},
	{
		id = 59, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Note_01",
		criteria = { { type = "profession", value = 225 } },
		previous = 58,
	},
	{
		id = 60, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Note_01",
		criteria = { { type = "profession", value = 300 } },
		previous = 59,
	},
	{
		id = 61, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Alchemy",
		criteria = { { type = "profession", skillLine = 171, value = 300 } },
	},
	{
		id = 62, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_BlackSmithing",
		criteria = { { type = "profession", skillLine = 164, value = 300 } },
	},
	{
		id = 63, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Engraving",
		criteria = { { type = "profession", skillLine = 333, value = 300 } },
	},
	{
		id = 64, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Engineering",
		criteria = { { type = "profession", skillLine = 202, value = 300 } },
	},
	{
		id = 65, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Herbalism",
		criteria = { { type = "profession", skillLine = 182, value = 300 } },
	},
	{
		id = 66, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_LeatherWorking",
		criteria = { { type = "profession", skillLine = 165, value = 300 } },
	},
	{
		id = 67, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Mining",
		criteria = { { type = "profession", skillLine = 186, value = 300 } },
	},
	{
		id = 68, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Pelt_Wolf_01",
		criteria = { { type = "profession", skillLine = 393, value = 300 } },
	},
	{
		id = 69, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Tailoring",
		criteria = { { type = "profession", skillLine = 197, value = 300 } },
	},
	-- Métiers secondaires : séries 150, 225, 300
	{
		id = 135, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Food_15",
		criteria = { { type = "profession", skillLine = 185, value = 150 } },
	},
	{
		id = 136, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Food_15",
		criteria = { { type = "profession", skillLine = 185, value = 225 } },
		previous = 135,
	},
	{
		id = 70, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Food_15",
		criteria = { { type = "profession", skillLine = 185, value = 300 } },
		previous = 136,
	},
	-- Recettes de cuisine connues, comptées dans Data/Recipes.lua (la
	-- statistique 1745 compte chaque recette deux fois sur Forever). Par
	-- personnage : le meilleur compte.
	{
		id = 194, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Food_66",
		criteria = { { type = "recipes", skillLine = 185, value = 25 } },
	},
	{
		id = 195, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Food_65",
		criteria = { { type = "recipes", skillLine = 185, value = 50 } },
		previous = 194,
	},
	{
		id = 196, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Food_60",
		criteria = { { type = "recipes", skillLine = 185, value = 75 } },
		previous = 195,
	},
	{
		id = 197, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Food_13",
		criteria = { { type = "recipes", skillLine = 185, value = 100 } },
		previous = 196,
	},
	{
		id = 137, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Fishing",
		criteria = { { type = "profession", skillLine = 356, value = 150 } },
	},
	{
		id = 138, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Fishing",
		criteria = { { type = "profession", skillLine = 356, value = 225 } },
		previous = 137,
	},
	{
		id = 71, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Fishing",
		criteria = { { type = "profession", skillLine = 356, value = 300 } },
		previous = 138,
	},
	{
		id = 139, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Spell_Holy_SealOfSacrifice",
		criteria = { { type = "profession", skillLine = 129, value = 150 } },
	},
	{
		id = 140, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Spell_Holy_SealOfSacrifice",
		criteria = { { type = "profession", skillLine = 129, value = 225 } },
		previous = 139,
	},
	{
		id = 72, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Spell_Holy_SealOfSacrifice",
		criteria = { { type = "profession", skillLine = 129, value = 300 } },
		previous = 140,
	},

	---------------------------------------------------------------------------
	-- Métiers : pêche, statistique 1456 « Poissons et autres objets pêchés »,
	-- additionnée sur le compte
	---------------------------------------------------------------------------
	{
		id = 129, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Fish_50",
		criteria = { { type = "statistic", id = 1456, value = 25, combine = "sum" } },
	},
	{
		id = 130, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Fish_50",
		criteria = { { type = "statistic", id = 1456, value = 50, combine = "sum" } },
		previous = 129,
	},
	{
		id = 131, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Fish_50",
		criteria = { { type = "statistic", id = 1456, value = 100, combine = "sum" } },
		previous = 130,
	},
	{
		id = 132, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Fish_50",
		criteria = { { type = "statistic", id = 1456, value = 250, combine = "sum" } },
		previous = 131,
	},
	{
		id = 133, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Fish_50",
		criteria = { { type = "statistic", id = 1456, value = 500, combine = "sum" } },
		previous = 132,
	},
	{
		id = 134, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Fish_50",
		criteria = { { type = "statistic", id = 1456, value = 1000, combine = "sum" } },
		previous = 133,
	},

	---------------------------------------------------------------------------
	-- Réputation : être exalté (le meilleur personnage compte)
	-- Série : statistique 377 « Plus grand nombre de réputations exaltées »
	---------------------------------------------------------------------------
	{
		id = 154, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Achievement_Reputation_01",
		criteria = { { type = "statistic", id = 377, value = 1 } },
	},
	{
		id = 155, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Achievement_Reputation_01",
		criteria = { { type = "statistic", id = 377, value = 5 } },
		previous = 154,
	},
	{
		id = 156, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Achievement_Reputation_02",
		criteria = { { type = "statistic", id = 377, value = 10 } },
		previous = 155,
	},
	{
		id = 157, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Achievement_Reputation_03",
		criteria = { { type = "statistic", id = 377, value = 15 } },
		previous = 156,
	},
	{
		id = 158, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Achievement_Reputation_04",
		criteria = { { type = "statistic", id = 377, value = 20 } },
		previous = 157,
	},
	{
		id = 159, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Achievement_Reputation_05",
		criteria = { { type = "statistic", id = 377, value = 25 } },
		previous = 158,
	},
	{
		id = 160, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Achievement_Reputation_06",
		criteria = { { type = "statistic", id = 377, value = 30 } },
		previous = 159,
	},
	{
		id = 161, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Achievement_Reputation_07",
		criteria = { { type = "statistic", id = 377, value = 35 } },
		previous = 160,
	},
	{
		id = 162, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Achievement_Reputation_08",
		criteria = { { type = "statistic", id = 377, value = 40 } },
		previous = 161,
	},
	-- Capitales de l'Alliance : étapes de l'Ambassadeur
	{
		id = 165, category = CAT.REPUTATION, points = 10, faction = "Alliance",
		icon = ICONS .. "Spell_Arcane_TeleportStormWind",
		criteria = { { type = "reputation", factionID = 72 } }, -- Stormwind
	},
	{
		id = 166, category = CAT.REPUTATION, points = 10, faction = "Alliance",
		icon = ICONS .. "Spell_Arcane_TeleportIronForge",
		criteria = { { type = "reputation", factionID = 47 } }, -- Forgefer
	},
	{
		id = 167, category = CAT.REPUTATION, points = 10, faction = "Alliance",
		icon = ICONS .. "Achievement_Character_Gnome_Male",
		criteria = { { type = "reputation", factionID = 54 } }, -- Exilés de Gnomeregan
	},
	{
		id = 168, category = CAT.REPUTATION, points = 10, faction = "Alliance",
		icon = ICONS .. "Spell_Arcane_TeleportDarnassus",
		criteria = { { type = "reputation", factionID = 69 } }, -- Darnassus
	},
	{
		-- Ambassadeur de l'Alliance : les 4 races de l'Alliance sur Forever.
		id = 163, category = CAT.REPUTATION, points = 10, faction = "Alliance",
		icon = ICONS .. "Achievement_PVP_A_16",
		criteria = {
			{ type = "achievement", id = 165 }, { type = "achievement", id = 166 },
			{ type = "achievement", id = 167 }, { type = "achievement", id = 168 },
		},
	},
	-- Capitales de la Horde : étapes de l'Ambassadeur
	{
		id = 169, category = CAT.REPUTATION, points = 10, faction = "Horde",
		icon = ICONS .. "Spell_Arcane_TeleportOrgrimmar",
		criteria = { { type = "reputation", factionID = 76 } }, -- Orgrimmar
	},
	{
		id = 170, category = CAT.REPUTATION, points = 10, faction = "Horde",
		icon = ICONS .. "Spell_Arcane_TeleportThunderBluff",
		criteria = { { type = "reputation", factionID = 81 } }, -- Thunder Bluff
	},
	{
		id = 171, category = CAT.REPUTATION, points = 10, faction = "Horde",
		icon = ICONS .. "Spell_Arcane_TeleportUnderCity",
		criteria = { { type = "reputation", factionID = 68 } }, -- Fossoyeuse
	},
	{
		id = 172, category = CAT.REPUTATION, points = 10, faction = "Horde",
		icon = ICONS .. "Achievement_Character_Troll_Male",
		criteria = { { type = "reputation", factionID = 530 } }, -- Trolls Darkspear
	},
	{
		-- Ambassadeur de la Horde : 4 races sur Forever (pas de Lune-d'argent).
		id = 164, category = CAT.REPUTATION, points = 10, faction = "Horde",
		icon = ICONS .. "Achievement_PVP_H_16",
		criteria = {
			{ type = "achievement", id = 169 }, { type = "achievement", id = 170 },
			{ type = "achievement", id = 171 }, { type = "achievement", id = 172 },
		},
	},
	{
		id = 149, category = CAT.REPUTATION, points = 15,
		icon = ICONS .. "Achievement_Reputation_Timbermaw",
		criteria = { { type = "reputation", factionID = 576 } }, -- Grumegueules
	},
	{
		id = 150, category = CAT.REPUTATION, points = 15,
		icon = ICONS .. "INV_Jewelry_Talisman_07",
		criteria = { { type = "reputation", factionID = 529 } }, -- Aube d'argent
	},
	{
		id = 151, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "Spell_Frost_SummonWaterElemental_2",
		criteria = { { type = "reputation", factionID = 749 } }, -- Hydraxiens
	},
	{
		id = 152, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "INV_Misc_Head_Dragon_Bronze",
		criteria = { { type = "reputation", factionID = 910 } }, -- Progéniture de Nozdormu
	},
	{
		id = 153, category = CAT.REPUTATION, points = 10,
		icon = ICONS .. "INV_Bijou_Green",
		criteria = { { type = "reputation", factionID = 270 } }, -- Tribu Zandalar
	},

	---------------------------------------------------------------------------
	-- Donjons classiques : critère « boss » = boss principal vaincu (celui que
	-- retient le haut fait natif Spéléologue de Forever), par trois sources :
	--   native     : critère du haut fait natif, rétroactif et tenu par le jeu ;
	--   statistic  : « Morts de <boss> », rétroactive mais pas toujours tenue
	--                à jour sur Forever ;
	--   encounters : rencontre vue en direct (table DungeonEncounter, plusieurs
	--                ids quand le boss existe en plusieurs difficultés).
	-- asset de native : l'id affiché par le jeu (GetAchievementCriteriaInfo),
	-- relevé en jeu le 2026-11-16. Le nom du boss vient de L.CRITERIA_TEXTS.
	-- Monastère écarlate, Hache-Tripes et Stratholme : un haut fait par aile,
	-- plus un méta comme les hauts faits officiels.
	---------------------------------------------------------------------------
	{
		-- Critère natif commun aux deux donjons ; rencontres : Taragaman,
		-- Bazzalan (Ragefeu), Durgen Mornemartel (Thanes).
		id = 207, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Spell_Shadow_SummonFelGuard",
		criteria = { { type = "boss", encounters = { 2733, 2735, 3496 },
			native = { achievement = SPELEO_NOVICE, asset = 0 } } }, -- Gouffre de Ragefeu ou salle des Thanes
	},
	{
		id = 73, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_EdwinVancleef",
		criteria = { { type = "boss", encounters = { 2747 }, statistic = 63570,
			native = { achievement = SPELEO_NOVICE, asset = 639 } } }, -- Mortemines
	},
	{
		id = 74, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_Mutanus_the_Devourer",
		criteria = { { type = "boss", encounters = { 592 }, statistic = 15028,
			native = { achievement = SPELEO_NOVICE, asset = 3654 } } }, -- Cavernes des Lamentations
	},
	{
		id = 75, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_ArchmageArugal",
		criteria = { { type = "boss", encounters = { 2755 }, statistic = 1092,
			native = { achievement = SPELEO_NOVICE, asset = 4275 } } }, -- Donjon d'Ombrecroc
	},
	-- Le 76 (prison de Hurlevent) est retiré : donjon fermé à la Horde, et
	-- absent des hauts faits natifs. Son numéro ne doit jamais être réutilisé.
	{
		id = 77, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_Bazil_Akumai",
		criteria = { { type = "boss", encounters = { 2910, 2767, 2891 }, statistic = 6137,
			native = { achievement = SPELEO_EXPERIENCED, asset = 4829 } } }, -- Profondeurs de Brassenoire
	},
	{
		id = 78, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Gizmo_02",
		criteria = { { type = "boss", encounters = { 2772, 2940 }, statistic = 6140,
			native = { achievement = SPELEO_EXPERIENCED, asset = 7800 } } }, -- Gnomeregan
	},
	{
		id = 79, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_CharlgaRazorflank",
		criteria = { { type = "boss", encounters = { 2778 }, statistic = 6139,
			native = { achievement = SPELEO_EXPERIENCED, asset = 4421 } } }, -- Kraal de Tranchebauge
	},
	-- Monastère écarlate : une aile par haut fait, puis le méta. Le 80
	-- (« Salles Écarlates », statistique 6786) est retiré : doublon de la
	-- cathédrale. Son numéro ne doit jamais être réutilisé.
	{
		id = 198, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Misc_Bone_HumanSkull_01",
		criteria = { { type = "boss", encounters = { 2779 },
			native = { achievement = SPELEO_EXPERIENCED, asset = 4543 } } }, -- Cimetière : mage de sang Thalnos
	},
	{
		id = 199, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Misc_Book_09",
		criteria = { { type = "boss", encounters = { 447 },
			native = { achievement = SPELEO_EXPERIENCED, asset = 6487 } } }, -- Bibliothèque : arcaniste Doan
	},
	{
		id = 200, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Axe_10",
		criteria = { { type = "boss", encounters = { 448 },
			native = { achievement = SPELEO_EXPERIENCED, asset = 3975 } } }, -- Armurerie : Hérode
	},
	{
		-- Le natif demande Mograine ; la rencontre 450 (Blanchetête) se
		-- termine avec lui.
		id = 81, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Shield_05",
		criteria = { { type = "boss", encounters = { 450 }, statistic = 1093,
			native = { achievement = SPELEO_EXPERIENCED, asset = 3976 } } }, -- Cathédrale : commandant Mograine
	},
	{
		id = 201, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Helmet_52",
		criteria = {
			{ type = "achievement", id = 198 }, { type = "achievement", id = 199 },
			{ type = "achievement", id = 200 }, { type = "achievement", id = 81 },
		},
	},
	{
		id = 82, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Spell_Frost_FrostNova",
		criteria = { { type = "boss", encounters = { 2785 }, statistic = 6141,
			native = { achievement = SPELEO_EXPERT, asset = 7358 } } }, -- Souilles de Tranchebauge
	},
	{
		id = 83, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_Archaedas",
		criteria = { { type = "boss", encounters = { 554 }, statistic = 6142,
			native = { achievement = SPELEO_EXPERT, asset = 2748 } } }, -- Uldaman
	},
	{
		id = 84, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_ChiefUkorzSandscalp",
		criteria = { { type = "boss", encounters = { 600 }, statistic = 1094,
			native = { achievement = SPELEO_EXPERT, asset = 7267 } } }, -- Zul'Farrak
	},
	{
		id = 85, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_PrincessTheradras",
		criteria = { { type = "boss", encounters = { 429 }, statistic = 6143,
			native = { achievement = SPELEO_EXPERT, asset = 12201 } } }, -- Maraudon
	},
	{
		id = 86, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_ShadeOfEranikus",
		criteria = { { type = "boss", encounters = { 3584, 493, 2959 }, statistic = 6144,
			native = { achievement = SPELEO_EXPERT, asset = 5709 } } }, -- Temple englouti
	},
	{
		id = 87, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_EmperorDagranThaurissan",
		criteria = { { type = "boss", encounters = { 2790 }, statistic = 1095,
			native = { achievement = SPELEO_EXPERT, asset = 9019 } } }, -- Profondeurs de Rochenoire
	},
	-- Hache-Tripes : une aile par haut fait, puis le méta.
	{
		id = 202, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Misc_Key_14",
		criteria = { { type = "boss", encounters = { 346 },
			native = { achievement = SPELEO_EXPERT, asset = 11492 } } }, -- Est : Alzzin le Modeleur
	},
	{
		-- Boss principal retenu par le natif et le haut fait officiel :
		-- Immol'thar, pas le prince Tortheldrin (dernier de l'aile).
		id = 203, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Misc_Book_11",
		criteria = { { type = "boss", encounters = { 349 },
			native = { achievement = SPELEO_EXPERT, asset = 11496 } } }, -- Ouest : Immol'thar
	},
	{
		id = 88, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Misc_Bone_OrcSkull_01",
		criteria = { { type = "boss", encounters = { 368 }, statistic = 6146,
			native = { achievement = SPELEO_EXPERT, asset = 11501 } } }, -- Nord : roi Gordok
	},
	{
		id = 204, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Ability_Warrior_DecisiveStrike",
		criteria = {
			{ type = "achievement", id = 202 }, { type = "achievement", id = 203 },
			{ type = "achievement", id = 88 },
		},
	},
	{
		id = 89, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_Overlord_Wyrmthalak",
		criteria = { { type = "boss", encounters = { 275 }, statistic = 6145,
			native = { achievement = SPELEO_EXPERT, asset = 9568 } } }, -- Pic Rochenoire inférieur
	},
	{
		id = 90, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_GeneralDrakkisath",
		criteria = { { type = "boss", encounters = { 3069 }, statistic = 1096,
			native = { achievement = SPELEO_EXPERT, asset = 10363 } } }, -- Pic Rochenoire supérieur
	},
	{
		id = 91, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Spell_Shadow_Charm",
		criteria = { { type = "boss", encounters = { 2801 }, statistic = 15030,
			native = { achievement = SPELEO_EXPERT, asset = 1853 } } }, -- Scholomance
	},
	-- Stratholme : un côté par haut fait, puis le méta.
	{
		-- Côté vivant : le jeu donne 478 comme id du critère natif (l'id de
		-- la rencontre de Balnazzar), et non le PNJ 10813 de wago.tools.
		id = 205, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Misc_Bone_ElfSkull_01",
		criteria = { { type = "boss", encounters = { 478 },
			native = { achievement = SPELEO_EXPERT, asset = 478 } } }, -- Grande porte : Balnazzar
	},
	{
		id = 92, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Misc_Bone_HumanSkull_01",
		criteria = { { type = "boss", encounters = { 484 }, statistic = 15031,
			native = { achievement = SPELEO_EXPERT, asset = 10440 } } }, -- Entrée de service : baron Vaillefendre
	},
	{
		id = 206, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Spell_DeathKnight_ArmyOfTheDead",
		criteria = {
			{ type = "achievement", id = 205 }, { type = "achievement", id = 92 },
		},
	},

	---------------------------------------------------------------------------
	-- Donjons de Forever : critère « boss », comme les donjons classiques.
	-- La salle des Thanes est avec le gouffre de Ragefeu (207). Les hauts
	-- faits 176 (gardiens de la terrasse) et 177 (Lyn l'Ignoré), boss
	-- facultatifs, sont retirés : numéros à ne jamais réutiliser.
	---------------------------------------------------------------------------
	{
		id = 93, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "INV_Misc_Head_Undead_01",
		criteria = { { type = "boss", encounters = { 3354 }, statistic = 63571,
			native = { achievement = SPELEO_NOVICE, asset = 250657 } } }, -- Ruines de Lordaeron
	},
	-- 209 à 212 : pas de statistique de victoires dans le jeu, critère natif
	-- et rencontre seuls. Icônes : celles de ForeverDungeonJournal.
	{
		id = 209, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "INV_Pick_02",
		criteria = { { type = "boss", encounters = { 3482 },
			native = { achievement = SPELEO_NOVICE, asset = 260326 } } }, -- Excavations : les Paluns
	},
	{
		id = 94, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "Spell_Arcane_PortalDalaran",
		criteria = { { type = "boss", encounters = { 3303 }, statistic = 63572,
			native = { achievement = SPELEO_EXPERIENCED, asset = 246020 } } }, -- Cité de Dalaran
	},
	{
		-- Min'loth a deux créatures (260243 pour le natif, 260274) ; une
		-- seule rencontre.
		id = 210, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "Spell_Frost_SummonWaterElemental",
		criteria = { { type = "boss", encounters = { 3479 },
			native = { achievement = SPELEO_EXPERIENCED, asset = 260243 } } }, -- Cité Submergée
	},
	{
		id = 211, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "INV_Misc_Key_13",
		criteria = { { type = "boss", encounters = { 3451 },
			native = { achievement = SPELEO_EXPERIENCED, asset = 258968 } } }, -- Bastion Krol'dok
	},
	{
		id = 95, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "INV_Misc_Key_14",
		criteria = { { type = "boss", encounters = { 3409 }, statistic = 63575,
			native = { achievement = SPELEO_EXPERT, asset = 255702 } } }, -- Prison d'Alcaz
	},
	{
		id = 96, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "INV_Misc_Gem_Variety_02",
		criteria = { { type = "boss", encounters = { 3502 }, statistic = 63574,
			native = { achievement = SPELEO_EXPERT, asset = 261809 } } }, -- Terrasse du Façonneur
	},
	{
		id = 212, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "INV_Misc_MonsterClaw_04",
		criteria = { { type = "boss", encounters = { 3334 },
			native = { achievement = SPELEO_EXPERT, asset = 247234 } } }, -- Repaire des Noiregueules
	},
	{
		-- Méta de tous les donjons, classiques et de Forever : rangé dans la
		-- catégorie Donjons elle-même, pas dans une sous-catégorie.
		id = 208, category = CAT.DUNGEONS, points = 20,
		icon = ICONS .. "INV_Helmet_74",
		criteria = {
			{ type = "achievement", id = 207 }, { type = "achievement", id = 73 },
			{ type = "achievement", id = 74 }, { type = "achievement", id = 75 },
			{ type = "achievement", id = 77 }, { type = "achievement", id = 78 },
			{ type = "achievement", id = 79 }, { type = "achievement", id = 201 },
			{ type = "achievement", id = 82 }, { type = "achievement", id = 83 },
			{ type = "achievement", id = 84 }, { type = "achievement", id = 85 },
			{ type = "achievement", id = 86 }, { type = "achievement", id = 87 },
			{ type = "achievement", id = 204 }, { type = "achievement", id = 89 },
			{ type = "achievement", id = 90 }, { type = "achievement", id = 91 },
			{ type = "achievement", id = 206 }, { type = "achievement", id = 93 },
			{ type = "achievement", id = 209 }, { type = "achievement", id = 94 },
			{ type = "achievement", id = 210 }, { type = "achievement", id = 211 },
			{ type = "achievement", id = 95 }, { type = "achievement", id = 96 },
			{ type = "achievement", id = 212 },
		},
	},

	---------------------------------------------------------------------------
	-- Raids : critère « boss ». Sommet d'Hyjal et profondeurs des Saisons
	-- n'ont pas de rencontre dans les données de Forever : statistique seule.
	---------------------------------------------------------------------------
	{
		id = 173, category = CAT.RAIDS, points = 10,
		icon = ICONS .. "Achievement_Boss_Onyxia",
		criteria = { { type = "boss", encounters = { 1084 }, statistic = 1098 } }, -- Repaire d'Onyxia
	},
	{
		id = 174, category = CAT.RAIDS, points = 10,
		icon = ICONS .. "Spell_Nature_Regeneration",
		criteria = { { type = "statistic", id = 63580, value = 1 } }, -- Sommet d'Hyjal
	},
	{
		id = 175, category = CAT.RAIDS, points = 10,
		icon = ICONS .. "Spell_Shadow_Twilight",
		criteria = { { type = "statistic", id = 63581, value = 1 } }, -- Profondeurs des Saisons
	},
}
