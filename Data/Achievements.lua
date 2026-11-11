-- Définitions des hauts faits. Données uniquement, aucune logique, aucun texte.
-- L'ordre de la liste est l'ordre d'affichage dans chaque catégorie.
-- La liste validée est décrite dans docs/ProposedAchievements.md.
--
--   id          : numéro unique et DÉFINITIF, la sauvegarde s'en sert. Un
--                 nouveau haut fait prend le numéro libre suivant (135), quel
--                 que soit l'endroit où il est rangé. Ne jamais changer ni
--                 réutiliser un numéro.
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
--
-- Les textes sont dans Locales/enUS.lua et Locales/frFR.lua, rangés par id :
-- L.ACHIEVEMENT_NAMES, L.ACHIEVEMENT_DESCRIPTIONS, L.ACHIEVEMENT_REWARDS et
-- L.CRITERIA_TEXTS (texte d'un critère, à la place du nom de la statistique).
local _, ns = ...

local CAT = ns.Data.CAT
local ICONS = "Interface\\Icons\\"

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
	-- Général : banque, argent, montures (hauts faits WotLK de même nom)
	---------------------------------------------------------------------------
	{
		-- Statistique 928 « Emplacements en banque supplémentaires achetés »
		id = 97, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "INV_Box_01",
		criteria = { { type = "statistic", id = 928, value = 7 } },
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
		-- Statistique 339 « Montures possédées » : le meilleur personnage compte
		-- (une même monture sur deux personnages ne compte qu'une fois).
		id = 104, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Mount_RidingElekk",
		criteria = { { type = "statistic", id = 339, value = 10 } },
	},
	{
		id = 105, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Mount_RidingElekkElite_Green",
		criteria = { { type = "statistic", id = 339, value = 25 } },
		previous = 104,
	},
	{
		id = 106, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Mount_Mammoth_Black",
		criteria = { { type = "statistic", id = 339, value = 50 } },
		previous = 105,
	},
	{
		-- WotLK en a deux (2536 Alliance, 2537 Horde) : un seul ici.
		id = 107, category = CAT.GENERAL, points = 10,
		icon = ICONS .. "Ability_Hunter_Pet_DragonHawk",
		criteria = { { type = "statistic", id = 339, value = 100 } },
		previous = 106,
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
	-- Exploration : île de Zéphras (personnages Skyborne uniquement)
	---------------------------------------------------------------------------
	{
		id = 56, category = CAT.EXPLORATION, points = 10,
		icon = ICONS .. "INV_Misc_Map_01",
		criteria = { { type = "explore", mapID = 2521 } },
	},

	---------------------------------------------------------------------------
	-- Exploration : méta global (comme « Explorateur » de WotLK, 50 points).
	-- Sans l'île de Zéphras (personnages Skyborne uniquement) : obtenable par tous.
	---------------------------------------------------------------------------
	{
		id = 57, category = CAT.EXPLORATION, points = 50,
		icon = ICONS .. "INV_Misc_Map09",
		criteria = {
			{ type = "achievement", id = 35 },
			{ type = "achievement", id = 55 },
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
	{
		id = 70, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "INV_Misc_Food_15",
		criteria = { { type = "profession", skillLine = 185, value = 300 } },
	},
	{
		id = 71, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Trade_Fishing",
		criteria = { { type = "profession", skillLine = 356, value = 300 } },
	},
	{
		id = 72, category = CAT.PROFESSIONS, points = 10,
		icon = ICONS .. "Spell_Holy_SealOfSacrifice",
		criteria = { { type = "profession", skillLine = 129, value = 300 } },
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
	-- Donjons classiques : statistique « Morts de <boss> » >= 1. Le nom du
	-- boss affiché dans le critère vient de L.CRITERIA_TEXTS.
	-- Gouffre de Ragefeu n'y est pas : sur Forever, la statistique 15027
	-- (Bazzalan) augmente aussi en finissant la salle des Thanes, on ne peut
	-- pas savoir lequel des deux donjons a été fait.
	---------------------------------------------------------------------------
	{
		id = 73, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_EdwinVancleef",
		criteria = { { type = "statistic", id = 63570, value = 1 } }, -- Mortemines
	},
	{
		id = 74, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_Mutanus_the_Devourer",
		criteria = { { type = "statistic", id = 15028, value = 1 } }, -- Cavernes des Lamentations
	},
	{
		id = 75, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_ArchmageArugal",
		criteria = { { type = "statistic", id = 1092, value = 1 } }, -- Donjon d'Ombrecroc
	},
	{
		id = 76, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_Bazil_Thredd",
		criteria = { { type = "statistic", id = 15029, value = 1 } }, -- La Prison
	},
	{
		id = 77, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_Bazil_Akumai",
		criteria = { { type = "statistic", id = 6137, value = 1 } }, -- Profondeurs de Brassenoire
	},
	{
		id = 78, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Gizmo_02",
		criteria = { { type = "statistic", id = 6140, value = 1 } }, -- Gnomeregan
	},
	{
		id = 79, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_CharlgaRazorflank",
		criteria = { { type = "statistic", id = 6139, value = 1 } }, -- Kraal de Tranchebauge
	},
	{
		id = 80, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Spell_Fire_FlameBolt",
		criteria = { { type = "statistic", id = 6786, value = 1 } }, -- Salles Écarlates
	},
	{
		id = 81, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Spell_Holy_SealOfMight",
		criteria = { { type = "statistic", id = 1093, value = 1 } }, -- Monastère écarlate
	},
	{
		id = 82, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Spell_Frost_FrostNova",
		criteria = { { type = "statistic", id = 6141, value = 1 } }, -- Souilles de Tranchebauge
	},
	{
		id = 83, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_Archaedas",
		criteria = { { type = "statistic", id = 6142, value = 1 } }, -- Uldaman
	},
	{
		id = 84, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_ChiefUkorzSandscalp",
		criteria = { { type = "statistic", id = 1094, value = 1 } }, -- Zul'Farrak
	},
	{
		id = 85, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_PrincessTheradras",
		criteria = { { type = "statistic", id = 6143, value = 1 } }, -- Maraudon
	},
	{
		id = 86, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_ShadeOfEranikus",
		criteria = { { type = "statistic", id = 6144, value = 1 } }, -- Temple englouti
	},
	{
		id = 87, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_EmperorDagranThaurissan",
		criteria = { { type = "statistic", id = 1095, value = 1 } }, -- Profondeurs de Rochenoire
	},
	{
		id = 88, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "INV_Crown_01",
		criteria = { { type = "statistic", id = 6146, value = 1 } }, -- Hache-Tripes
	},
	{
		id = 89, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_Overlord_Wyrmthalak",
		criteria = { { type = "statistic", id = 6145, value = 1 } }, -- Pic Rochenoire inférieur
	},
	{
		id = 90, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Achievement_Boss_GeneralDrakkisath",
		criteria = { { type = "statistic", id = 1096, value = 1 } }, -- Pic Rochenoire supérieur
	},
	{
		id = 91, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Spell_Shadow_Charm",
		criteria = { { type = "statistic", id = 15030, value = 1 } }, -- Scholomance
	},
	{
		id = 92, category = CAT.DUNGEONS_CLASSIC, points = 10,
		icon = ICONS .. "Spell_Shadow_RaiseDead",
		criteria = { { type = "statistic", id = 15031, value = 1 } }, -- Stratholme
	},

	---------------------------------------------------------------------------
	-- Donjons de Forever : statistique « Morts de <boss> » >= 1
	-- Salle des Thanes n'y est pas : sa statistique 63573 (Durgen) reste à 0
	-- après le donjon terminé ; la victoire est comptée dans celle de Ragefeu.
	---------------------------------------------------------------------------
	{
		id = 93, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "INV_Misc_Head_Undead_01",
		criteria = { { type = "statistic", id = 63571, value = 1 } }, -- Ruines de Lordaeron
	},
	{
		id = 94, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "Spell_Arcane_PortalDalaran",
		criteria = { { type = "statistic", id = 63572, value = 1 } }, -- Cité de Dalaran
	},
	{
		id = 95, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "INV_Misc_Key_14",
		criteria = { { type = "statistic", id = 63575, value = 1 } }, -- Prison d'Alcaz
	},
	{
		id = 96, category = CAT.DUNGEONS_FOREVER, points = 10,
		icon = ICONS .. "INV_Misc_Gem_Variety_02",
		criteria = { { type = "statistic", id = 63574, value = 1 } }, -- Terrasse du Façonneur
	},
}
