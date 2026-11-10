-- Noms et descriptions des hauts faits en anglais, pour tous les clients sauf
-- le français (Data/ est écrit en français). Appliqué par Registry:Build.
-- Zones et boss : noms officiels du build Forever (wago.tools, tables UiMap
-- et Achievement en enUS). Noms de hauts faits : ceux de Blizzard quand le
-- nôtre est déjà le nom Blizzard, sinon une traduction du nôtre.
--
-- achievements[id] = { name, description, criteriaText = texte du critère 1 }
if GetLocale() == "frFR" then
	return
end

local _, ns = ...

ns.Data.translation = {
	categories = {
		[1] = "General",
		[2] = "Quests",
		[3] = "Exploration",
		[31] = "Eastern Kingdoms",
		[32] = "Kalimdor",
		[4] = "Professions",
		[5] = "Dungeons",
		[51] = "Classic",
		[52] = "Forever",
	},

	achievements = {
		-- Général
		[1001] = { name = "Level 10", description = "Reach level 10." },
		[1002] = { name = "Level 20", description = "Reach level 20." },
		[1003] = { name = "Level 30", description = "Reach level 30." },
		[1004] = { name = "Level 40", description = "Reach level 40." },
		[1005] = { name = "Level 50", description = "Reach level 50." },
		[1006] = { name = "Level 60", description = "Reach level 60." },

		-- Quêtes
		[2001] = { name = "Adventurer", description = "Complete 50 quests." },
		[2002] = { name = "Seasoned Adventurer", description = "Complete 100 quests." },
		[2003] = { name = "Accomplished Adventurer", description = "Complete 250 quests." },
		[2004] = { name = "Quest Hero", description = "Complete 500 quests." },
		[2005] = { name = "Quest Legend", description = "Complete 1000 quests." },

		-- Exploration : Royaumes de l'Est
		[3001] = { name = "Explore Alterac Mountains", description = "Reveal the entire map of Alterac Mountains." },
		[3002] = { name = "Explore Arathi Highlands", description = "Reveal the entire map of Arathi Highlands." },
		[3003] = { name = "Explore Badlands", description = "Reveal the entire map of Badlands." },
		[3004] = { name = "Explore Blasted Lands", description = "Reveal the entire map of Blasted Lands." },
		[3005] = { name = "Explore Tirisfal Glades", description = "Reveal the entire map of Tirisfal Glades." },
		[3006] = { name = "Explore Silverpine Forest", description = "Reveal the entire map of Silverpine Forest." },
		[3007] = { name = "Explore Western Plaguelands", description = "Reveal the entire map of Western Plaguelands." },
		[3008] = { name = "Explore Eastern Plaguelands", description = "Reveal the entire map of Eastern Plaguelands." },
		[3009] = { name = "Explore Hillsbrad Foothills", description = "Reveal the entire map of Hillsbrad Foothills." },
		[3010] = { name = "Explore The Hinterlands", description = "Reveal the entire map of The Hinterlands." },
		[3011] = { name = "Explore Dun Morogh", description = "Reveal the entire map of Dun Morogh." },
		[3012] = { name = "Explore Searing Gorge", description = "Reveal the entire map of Searing Gorge." },
		[3013] = { name = "Explore Burning Steppes", description = "Reveal the entire map of Burning Steppes." },
		[3014] = { name = "Explore Elwynn Forest", description = "Reveal the entire map of Elwynn Forest." },
		[3015] = { name = "Explore Deadwind Pass", description = "Reveal the entire map of Deadwind Pass." },
		[3016] = { name = "Explore Duskwood", description = "Reveal the entire map of Duskwood." },
		[3017] = { name = "Explore Loch Modan", description = "Reveal the entire map of Loch Modan." },
		[3018] = { name = "Explore Redridge Mountains", description = "Reveal the entire map of Redridge Mountains." },
		[3019] = { name = "Explore Stranglethorn Vale", description = "Reveal the entire map of Stranglethorn Vale." },
		[3020] = { name = "Explore Swamp of Sorrows", description = "Reveal the entire map of Swamp of Sorrows." },
		[3021] = { name = "Explore Westfall", description = "Reveal the entire map of Westfall." },
		[3022] = { name = "Explore Wetlands", description = "Reveal the entire map of Wetlands." },
		[3023] = { name = "Explore Riverglades", description = "Reveal the entire map of Riverglades." },
		[3050] = { name = "Eastern Kingdoms Explorer", description = "Explore every zone of the Eastern Kingdoms." },

		-- Exploration : Kalimdor
		[3101] = { name = "Explore Durotar", description = "Reveal the entire map of Durotar." },
		[3102] = { name = "Explore Mulgore", description = "Reveal the entire map of Mulgore." },
		[3103] = { name = "Explore The Barrens", description = "Reveal the entire map of The Barrens." },
		[3104] = { name = "Explore Teldrassil", description = "Reveal the entire map of Teldrassil." },
		[3105] = { name = "Explore Darkshore", description = "Reveal the entire map of Darkshore." },
		[3106] = { name = "Explore Ashenvale", description = "Reveal the entire map of Ashenvale." },
		[3107] = { name = "Explore Thousand Needles", description = "Reveal the entire map of Thousand Needles." },
		[3108] = { name = "Explore Stonetalon Mountains", description = "Reveal the entire map of Stonetalon Mountains." },
		[3109] = { name = "Explore Desolace", description = "Reveal the entire map of Desolace." },
		[3110] = { name = "Explore Feralas", description = "Reveal the entire map of Feralas." },
		[3111] = { name = "Explore Dustwallow Marsh", description = "Reveal the entire map of Dustwallow Marsh." },
		[3112] = { name = "Explore Tanaris", description = "Reveal the entire map of Tanaris." },
		[3113] = { name = "Explore Azshara", description = "Reveal the entire map of Azshara." },
		[3114] = { name = "Explore Felwood", description = "Reveal the entire map of Felwood." },
		[3115] = { name = "Explore Un'Goro Crater", description = "Reveal the entire map of Un'Goro Crater." },
		[3117] = { name = "Explore Silithus", description = "Reveal the entire map of Silithus." },
		[3118] = { name = "Explore Winterspring", description = "Reveal the entire map of Winterspring." },
		[3119] = { name = "Explore Mount Hyjal", description = "Reveal the entire map of Mount Hyjal." },
		[3120] = { name = "Explore Shen'dralas", description = "Reveal the entire map of Shen'dralas." },
		[3150] = { name = "Kalimdor Explorer", description = "Explore every zone of Kalimdor." },

		-- Exploration
		[3201] = { name = "Explore Zephras Isle", description = "Reveal the entire map of Zephras Isle." },
		[3300] = { name = "Explorer", description = "Explore the Eastern Kingdoms and Kalimdor." },

		-- Métiers
		[4001] = { name = "Journeyman", description = "Reach 150 in a primary profession." },
		[4002] = { name = "Expert", description = "Reach 225 in a primary profession." },
		[4003] = { name = "Artisan", description = "Reach 300 in a primary profession." },
		[4011] = { name = "Master Alchemist", description = "Reach 300 in Alchemy." },
		[4012] = { name = "Master Blacksmith", description = "Reach 300 in Blacksmithing." },
		[4013] = { name = "Master Enchanter", description = "Reach 300 in Enchanting." },
		[4014] = { name = "Master Engineer", description = "Reach 300 in Engineering." },
		[4015] = { name = "Master Herbalist", description = "Reach 300 in Herbalism." },
		[4016] = { name = "Master Leatherworker", description = "Reach 300 in Leatherworking." },
		[4017] = { name = "Master Miner", description = "Reach 300 in Mining." },
		[4018] = { name = "Master Skinner", description = "Reach 300 in Skinning." },
		[4019] = { name = "Master Tailor", description = "Reach 300 in Tailoring." },
		[4021] = { name = "Master Chef", description = "Reach 300 in Cooking." },
		[4022] = { name = "Master Angler", description = "Reach 300 in Fishing." },
		[4023] = { name = "Master Medic", description = "Reach 300 in First Aid." },

		-- Donjons classiques
		[5002] = { name = "Deadmines", description = "Defeat Edwin VanCleef in the Deadmines.", criteriaText = "Edwin VanCleef" },
		[5003] = { name = "Wailing Caverns", description = "Defeat Mutanus the Devourer in the Wailing Caverns.", criteriaText = "Mutanus the Devourer" },
		[5004] = { name = "Shadowfang Keep", description = "Defeat Archmage Arugal in Shadowfang Keep.", criteriaText = "Archmage Arugal" },
		[5005] = { name = "Stormwind Stockade", description = "Defeat Bazil Thredd in the Stormwind Stockade.", criteriaText = "Bazil Thredd" },
		[5006] = { name = "Blackfathom Deeps", description = "Defeat Aku'mai in Blackfathom Deeps.", criteriaText = "Aku'mai" },
		[5007] = { name = "Gnomeregan", description = "Defeat Mekgineer Thermaplugg in Gnomeregan.", criteriaText = "Mekgineer Thermaplugg" },
		[5008] = { name = "Razorfen Kraul", description = "Defeat Charlga Razorflank in Razorfen Kraul.", criteriaText = "Charlga Razorflank" },
		-- Statistique 6786 : Koegler en frFR ; son titre enUS (Whitemane) est
		-- un ancien libellé de Blizzard qui ne correspond plus.
		[5009] = { name = "Scarlet Halls", description = "Defeat Flameweaver Koegler in the Scarlet Halls.", criteriaText = "Flameweaver Koegler" },
		[5010] = { name = "Scarlet Monastery", description = "Defeat Scarlet Commander Mograine in the Scarlet Monastery.", criteriaText = "Scarlet Commander Mograine" },
		[5011] = { name = "Razorfen Downs", description = "Defeat Amnennar the Coldbringer in Razorfen Downs.", criteriaText = "Amnennar the Coldbringer" },
		[5012] = { name = "Uldaman", description = "Defeat Archaedas in Uldaman.", criteriaText = "Archaedas" },
		[5013] = { name = "Zul'Farrak", description = "Defeat Chief Ukorz Sandscalp in Zul'Farrak.", criteriaText = "Chief Ukorz Sandscalp" },
		[5014] = { name = "Maraudon", description = "Defeat Princess Theradras in Maraudon.", criteriaText = "Princess Theradras" },
		[5015] = { name = "Sunken Temple", description = "Defeat the Shade of Eranikus in the Sunken Temple.", criteriaText = "Shade of Eranikus" },
		[5016] = { name = "Blackrock Depths", description = "Defeat Emperor Dagran Thaurissan in Blackrock Depths.", criteriaText = "Emperor Dagran Thaurissan" },
		[5017] = { name = "Dire Maul", description = "Defeat King Gordok in Dire Maul.", criteriaText = "King Gordok" },
		[5018] = { name = "Lower Blackrock Spire", description = "Defeat Overlord Wyrmthalak in Lower Blackrock Spire.", criteriaText = "Overlord Wyrmthalak" },
		[5019] = { name = "Upper Blackrock Spire", description = "Defeat General Drakkisath in Upper Blackrock Spire.", criteriaText = "General Drakkisath" },
		[5020] = { name = "Scholomance", description = "Defeat Darkmaster Gandling in Scholomance.", criteriaText = "Darkmaster Gandling" },
		[5021] = { name = "Stratholme", description = "Defeat Baron Rivendare in Stratholme.", criteriaText = "Baron Rivendare" },

		-- Donjons de Forever
		[5102] = { name = "Ruins of Lordaeron", description = "Defeat Rath'mael in the Ruins of Lordaeron.", criteriaText = "Rath'mael" },
		[5103] = { name = "City of Dalaran", description = "Defeat the Shade of the Archmage in the City of Dalaran.", criteriaText = "Shade of the Archmage" },
		[5104] = { name = "Alcaz Prison", description = "Defeat Blazeroar in Alcaz Prison.", criteriaText = "Blazeroar" },
		[5105] = { name = "Shaper's Terrace", description = "Defeat Nanaya on the Shaper's Terrace.", criteriaText = "Nanaya" },
	},
}
