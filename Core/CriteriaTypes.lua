-- Types de critères connus. Chaque type déclare :
--   fields       : champs obligatoires du critère dans Data/Achievements.lua
--   progressBar  : true/false, ou fonction(c) -> booléen : afficher une barre
--                  de progression dans l'UI
--   describe(c)  : texte du critère affiché au joueur
--   goal(c)      : quantité à atteindre (pour la barre et le texte x / y)
--   asset(c)     : (facultatif) id de l'objet visé, renvoyé comme assetID par
--                  ns.API.GetAchievementCriteriaInfo (ex. le haut fait d'un méta)
--   validate(c)  : (facultatif) contrôle au chargement. Renvoie un message
--                  d'erreur si le critère est inutilisable, nil sinon.
--   key(c)       : (facultatif) clé de la progression dans la sauvegarde. Par
--                  défaut "type:cible" (voir Core/Registry.lua).
--   current(c)   : progression actuelle du personnage connecté (un nombre).
--                  Le critère est rempli quand current(c) >= goal(c).
--                  Appelée par le moteur (Core/Engine.lua), jamais en combat.
local _, ns = ...

local L = ns.L

local CriteriaTypes = {}
ns.CriteriaTypes = CriteriaTypes

-- Nom d'une statistique de Forever, ou nil. Les statistiques sont lues avec
-- GetAchievementInfo, comme chez Blizzard.
local function GetStatisticName(statisticID)
	return select(2, GetAchievementInfo(statisticID))
end

-- Total de morceaux de carte d'une zone, ou nil si inconnu.
local function GetExplorationTotal(mapID)
	local artID = C_Map.GetMapArtID(mapID)
	return artID and ns.Data.explorationTotals[artID]
end

-- GetStatistic renvoie du texte ("--" pour zéro). Seuls les chiffres sont
-- gardés, ce qui écarte aussi un éventuel séparateur de milliers.
local function GetStatisticNumber(statisticID)
	local text = GetStatistic(statisticID)
	if type(text) ~= "string" then
		return 0
	end
	return tonumber((text:gsub("%D", ""))) or 0
end

-- Pièces d'or d'une statistique d'argent (333 « or ramassé », 326 « or des
-- quêtes »). GetStatistic renvoie alors chaque pièce suivie de son icône :
-- "12|TInterface\\MoneyFrame\\UI-GoldIcon:0:0:2:0|t 34|T...SilverIcon...|t".
-- Seul le nombre devant l'icône d'or compte (argent et cuivre ignorés).
-- Sans aucune icône, le texte est pris comme un nombre de pièces de cuivre.
-- Format à confirmer en jeu : /dump GetStatistic(333)
local function GetStatisticGold(statisticID)
	local text = GetStatistic(statisticID)
	if type(text) ~= "string" then
		return 0
	end
	if not text:find("|T", 1, true) then
		return math.floor(GetStatisticNumber(statisticID) / 10000)
	end
	for amount, texture in text:gmatch("([^|]*)|T([^|]*)|t") do
		if texture:find("[Gg]old") then
			return tonumber((amount:gsub("%D", ""))) or 0
		end
	end
	return 0
end

-- Réputation d'une faction : nom, rang (1 = Haï ... 8 = Exalté) et valeur
-- absolue (0 = début de Neutre, 42000 = début d'Exalté), ou nil si la faction
-- est inconnue. C_Reputation si le client l'a, sinon l'ancienne fonction.
local EXALTED_STANDING = 8
local EXALTED_VALUE = 42000

local function GetReputation(factionID)
	if C_Reputation and C_Reputation.GetFactionDataByID then
		local data = C_Reputation.GetFactionDataByID(factionID)
		if data and data.name then
			return data.name, data.reaction, data.currentStanding
		end
	end
	if GetFactionInfoByID then
		local name, _, standingID, _, _, barValue = GetFactionInfoByID(factionID)
		if name then
			return name, standingID, barValue
		end
	end
end

-- Rang d'un métier du personnage. skillLine = nil : meilleur des deux
-- métiers principaux. GetProfessions renvoie les index des métiers
-- (2 principaux puis les secondaires), nil pour un emplacement vide.
local function GetProfessionRank(skillLine)
	local prof1, prof2, sec1, sec2, sec3, sec4, sec5 = GetProfessions()
	local best = 0
	if skillLine == nil then
		for _, index in pairs({ prof1, prof2 }) do
			local rank = select(3, GetProfessionInfo(index))
			best = math.max(best, rank or 0)
		end
		return best
	end
	for _, index in pairs({ prof1, prof2, sec1, sec2, sec3, sec4, sec5 }) do
		local _, _, rank, _, _, _, line = GetProfessionInfo(index)
		if line == skillLine then
			return rank or 0
		end
	end
	return 0
end

-- Quête terminée par le personnage (rétroactif : le jeu garde la liste).
local function IsQuestDone(questID)
	if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
		return C_QuestLog.IsQuestFlaggedCompleted(questID) == true
	end
	return IsQuestFlaggedCompleted ~= nil and IsQuestFlaggedCompleted(questID) == true
end

-- Compétences de la fenêtre Compétences de Forever (C_SkillInfo), lues par
-- leur id : pas de nom traduit à comparer. nil si la compétence n'est pas
-- apprise.
local function GetSkillInfo(skillID)
	if not (C_SkillInfo and C_SkillInfo.GetSkillLineInfoByID) then
		return nil
	end
	return C_SkillInfo.GetSkillLineInfoByID(skillID)
end

local RIDING_SKILL_ID = 762

-- Sorts de monte, au cas où Forever les donne sans la compétence 762 :
-- [sort] = rang de monte qu'il représente.
local RIDING_SPELLS = { [33388] = 75, [33391] = 150 }

local function GetSkillRank(skillID)
	local info = GetSkillInfo(skillID)
	local rank = info and info.rank or 0
	if skillID == RIDING_SKILL_ID and C_SpellBook and C_SpellBook.IsSpellKnown then
		for spellID, spellRank in pairs(RIDING_SPELLS) do
			if C_SpellBook.IsSpellKnown(spellID) then
				rank = math.max(rank, spellRank)
			end
		end
	end
	return rank
end

-- Compétences d'armes, liste de la fenêtre Compétences de Forever
-- (Blizzard_UIPanels_Game/Camelot/SkillsFrame.lua), sans Combat farouche.
-- 162 = armes de pugilat et mains nues.
local WEAPON_SKILL_IDS = {
	43, 44, 45, 46, 54, 55, 136, 160, 162, 172, 173, 176, 226, 228, 229,
}

-- Nombre de compétences d'armes au moins au rang minRank.
local function CountWeaponSkills(minRank)
	local count = 0
	for _, skillID in ipairs(WEAPON_SKILL_IDS) do
		if GetSkillRank(skillID) >= minRank then
			count = count + 1
		end
	end
	return count
end

-- Emplacements comptés pour « un objet dans chaque emplacement » : tête,
-- cou, épaules, dos, torse, poignets, mains, taille, jambes, pieds, 2
-- anneaux, 2 bijoux, main droite, main gauche. Sans chemise, tabard ni
-- objet à distance (pas toutes les classes en ont un).
local GEAR_SLOTS = { 1, 2, 3, 15, 5, 9, 10, 6, 7, 8, 11, 12, 13, 14, 16, 17 }
local MAIN_HAND_SLOT, OFF_HAND_SLOT, TABARD_SLOT = 16, 17, 19

local function IsTwoHandedEquipped()
	local itemID = GetInventoryItemID("player", MAIN_HAND_SLOT)
	if not itemID then
		return false
	end
	-- Sur Forever, la fonction n'existe plus qu'en C_Item.GetItemInfoInstant.
	local getInfo = C_Item and C_Item.GetItemInfoInstant or GetItemInfoInstant
	local equipLoc = select(4, getInfo(itemID))
	return equipLoc == "INVTYPE_2HWEAPON"
end

-- Emplacements portant un objet de qualité minQuality ou mieux (3 = rare,
-- bleu ; 4 = épique, violet). Avec une arme à deux mains, la main gauche
-- vide compte comme remplie.
local function CountGearSlotsOfQuality(minQuality)
	local count = 0
	for _, slot in ipairs(GEAR_SLOTS) do
		local quality = GetInventoryItemQuality("player", slot)
		if quality and quality >= minQuality then
			count = count + 1
		elseif slot == OFF_HAND_SLOT and not GetInventoryItemID("player", slot)
				and IsTwoHandedEquipped() then
			count = count + 1
		end
	end
	return count
end

-- Nombre de mascottes ou de montures possédées, lu dans les journaux de
-- Forever : le même chiffre que celui affiché en haut de chaque journal.
-- (Les statistiques 338 et 339 ne sont pas tenues à jour sur Forever.)
local function CountPets()
	if not (C_PetJournal and C_PetJournal.GetNumPets) then
		return 0
	end
	local _, numOwned = C_PetJournal.GetNumPets()
	return numOwned or 0
end

-- Même calcul que Blizzard_MountCollection.lua : montures obtenues, sans
-- celles masquées pour ce personnage.
local function CountMounts()
	if not (C_MountJournal and C_MountJournal.GetMountIDs) then
		return 0
	end
	local count = 0
	for _, mountID in ipairs(C_MountJournal.GetMountIDs()) do
		local _, _, _, _, _, _, _, _, _, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(mountID)
		if isCollected and hideOnChar ~= true then
			count = count + 1
		end
	end
	return count
end

local COLLECTION_COUNTERS = { pets = CountPets, mounts = CountMounts }

-- Le joueur connaît-il ce sort (une recette apprise en est un) ?
local function IsSpellKnown(spellID)
	if C_SpellBook and C_SpellBook.IsSpellKnown and C_SpellBook.IsSpellKnown(spellID) then
		return true
	end
	return IsPlayerSpell ~= nil and IsPlayerSpell(spellID) == true
end

-- Recettes connues d'un métier, d'après la liste de Data/Recipes.lua.
local function CountKnownRecipes(skillLine)
	local count = 0
	for _, spellID in ipairs(ns.Data.recipes[skillLine] or {}) do
		if IsSpellKnown(spellID) then
			count = count + 1
		end
	end
	return count
end

-- Atteindre un niveau. Exemple : { type = "level", value = 10 }
CriteriaTypes.level = {
	fields = { "value" },
	progressBar = true,
	describe = function(criterion)
		return L.CRITERIA_LEVEL:format(criterion.value)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	current = function()
		return UnitLevel("player") or 0
	end,
}

-- Valeur d'une statistique de Forever (GetStatistic) >= value.
-- Exemple : { type = "statistic", id = 98, value = 50 }
-- text (facultatif) remplace le nom de la statistique dans l'UI.
CriteriaTypes.statistic = {
	fields = { "id", "value" },
	progressBar = function(criterion)
		return criterion.value > 1
	end,
	describe = function(criterion)
		return criterion.text or GetStatisticName(criterion.id) or tostring(criterion.id)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	validate = function(criterion)
		if not GetStatisticName(criterion.id) then
			return L.DATA_ERR_STATISTIC:format(tostring(criterion.id))
		end
	end,
	current = function(criterion)
		return GetStatisticNumber(criterion.id)
	end,
}

-- Statistique d'argent de Forever >= value pièces d'or.
-- Exemple : { type = "money", id = 333, value = 100 }
-- text (facultatif) remplace le nom de la statistique dans l'UI.
CriteriaTypes.money = {
	fields = { "id", "value" },
	progressBar = true,
	describe = CriteriaTypes.statistic.describe,
	goal = CriteriaTypes.statistic.goal,
	validate = CriteriaTypes.statistic.validate,
	current = function(criterion)
		return GetStatisticGold(criterion.id)
	end,
}

-- Statistique d'argent différente de zéro, quel que soit le montant (pièces
-- d'or, d'argent ou de cuivre). Exemple : { type = "moneyAny", id = 1147 }
-- (argent dépensé chez le coiffeur). Les icônes de pièces (|T...|t) sont
-- retirées avant de chercher un chiffre non nul : leurs chemins en contiennent.
CriteriaTypes.moneyAny = {
	fields = { "id" },
	progressBar = false,
	describe = CriteriaTypes.statistic.describe,
	goal = function()
		return 1
	end,
	validate = CriteriaTypes.statistic.validate,
	current = function(criterion)
		local text = GetStatistic(criterion.id)
		if type(text) ~= "string" then
			return 0
		end
		return text:gsub("|T.-|t", ""):find("[1-9]") and 1 or 0
	end,
}

-- Nouvelle coupe chez le coiffeur : vue en direct par Engine
-- (Database:RecordHaircut), ou statistique id d'argent dépensé chez le
-- coiffeur non nulle, au cas où le jeu la tiendrait à jour.
-- Exemple : { type = "haircut", id = 1147 }
CriteriaTypes.haircut = {
	fields = { "id" },
	progressBar = false,
	describe = function()
		return L.CRITERIA_HAIRCUT
	end,
	goal = function()
		return 1
	end,
	validate = CriteriaTypes.statistic.validate,
	current = function(criterion)
		if ns.Database:HasHaircut() then
			return 1
		end
		return CriteriaTypes.moneyAny.current(criterion)
	end,
}

-- Emplacements de sac de banque achetés par le personnage (le meilleur
-- compte). L'API compte aussi l'emplacement de base, offert : il est retiré.
-- Exemple : { type = "bankSlots", value = 8 }
CriteriaTypes.bankSlots = {
	fields = { "value" },
	progressBar = true,
	describe = function()
		return L.CRITERIA_BANK_SLOTS
	end,
	goal = function(criterion)
		return criterion.value
	end,
	current = function()
		if not (C_Bank and C_Bank.FetchNumPurchasedBankTabs and Enum.BankType) then
			return 0
		end
		local count = C_Bank.FetchNumPurchasedBankTabs(Enum.BankType.Character)
		if type(count) ~= "number" then
			return 0
		end
		return math.max(0, count - 1)
	end,
}

-- Explorer entièrement une zone. Exemple : { type = "explore", mapID = 1429 }
CriteriaTypes.explore = {
	fields = { "mapID" },
	progressBar = true,
	describe = function(criterion)
		local info = C_Map.GetMapInfo(criterion.mapID)
		return L.CRITERIA_EXPLORE:format(info and info.name or tostring(criterion.mapID))
	end,
	goal = function(criterion)
		return GetExplorationTotal(criterion.mapID) or 1
	end,
	validate = function(criterion)
		if not C_Map.GetMapInfo(criterion.mapID) then
			return L.DATA_ERR_MAP:format(tostring(criterion.mapID))
		end
		if not GetExplorationTotal(criterion.mapID) then
			return L.DATA_ERR_EXPLORE_TOTAL:format(tostring(criterion.mapID),
				tostring(C_Map.GetMapArtID(criterion.mapID)))
		end
	end,
	-- Nombre de morceaux de carte déjà découverts dans la zone.
	current = function(criterion)
		local explored = C_MapExplorationInfo.GetExploredMapTextures(criterion.mapID)
		return explored and #explored or 0
	end,
}

-- Rang dans un métier. skillLine = id du métier (voir L.PROFESSION_NAMES).
-- Sans skillLine : n'importe quel métier principal.
-- Exemples : { type = "profession", skillLine = 171, value = 300 }
--            { type = "profession", value = 150 }
CriteriaTypes.profession = {
	fields = { "value" },
	progressBar = true,
	describe = function(criterion)
		if not criterion.skillLine then
			return L.CRITERIA_PROFESSION_ANY:format(criterion.value)
		end
		local name = L.PROFESSION_NAMES[criterion.skillLine] or tostring(criterion.skillLine)
		return L.CRITERIA_PROFESSION:format(name, criterion.value)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	current = function(criterion)
		return GetProfessionRank(criterion.skillLine)
	end,
}

-- Quête terminée. Exemple : { type = "quest", id = 208 }
-- text (facultatif) remplace le nom de la quête dans l'UI.
CriteriaTypes.quest = {
	fields = { "id" },
	progressBar = false,
	describe = function(criterion)
		if criterion.text then
			return criterion.text
		end
		local title = C_QuestLog and C_QuestLog.GetTitleForQuestID
			and C_QuestLog.GetTitleForQuestID(criterion.id)
		return title or L.CRITERIA_QUEST:format(criterion.id)
	end,
	goal = function()
		return 1
	end,
	current = function(criterion)
		return IsQuestDone(criterion.id) and 1 or 0
	end,
}

-- Rang d'une compétence par son id (762 monte, 162 mains nues...).
-- Exemple : { type = "skill", id = 762, value = 75 }
-- text (facultatif) remplace le nom de la compétence, utile tant qu'elle
-- n'est pas apprise (le jeu ne donne son nom qu'une fois apprise).
CriteriaTypes.skill = {
	fields = { "id", "value" },
	progressBar = true,
	describe = function(criterion)
		local info = GetSkillInfo(criterion.id)
		local name = criterion.text or (info and info.name) or tostring(criterion.id)
		return L.CRITERIA_PROFESSION:format(name, criterion.value)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	current = function(criterion)
		return GetSkillRank(criterion.id)
	end,
}

-- count compétences d'armes au moins au rang value.
-- Exemple : { type = "weaponSkills", count = 4, value = 300 }
CriteriaTypes.weaponSkills = {
	fields = { "count", "value" },
	progressBar = true,
	describe = function(criterion)
		return L.CRITERIA_WEAPON_SKILLS:format(criterion.value)
	end,
	goal = function(criterion)
		return criterion.count
	end,
	current = function(criterion)
		return CountWeaponSkills(criterion.value)
	end,
}

-- Collection : what = "pets" (mascottes) ou "mounts" (montures).
-- Exemple : { type = "collection", what = "pets", value = 15 }
CriteriaTypes.collection = {
	fields = { "what", "value" },
	progressBar = function(criterion)
		return criterion.value > 1
	end,
	describe = function(criterion)
		return L.CRITERIA_COLLECTION[criterion.what] or tostring(criterion.what)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	validate = function(criterion)
		if not COLLECTION_COUNTERS[criterion.what] then
			return L.DATA_ERR_COLLECTION:format(tostring(criterion.what))
		end
	end,
	current = function(criterion)
		return COLLECTION_COUNTERS[criterion.what]()
	end,
}

-- Critère d'un haut fait natif de Forever rempli ? On le cherche par l'id que
-- le jeu donne (assetID, 8e valeur de GetAchievementCriteriaInfo), pas par
-- sa position dans la liste.
local function IsNativeCriterionDone(achievementID, assetID)
	if not (GetAchievementNumCriteria and GetAchievementCriteriaInfo) then
		return false
	end
	for index = 1, GetAchievementNumCriteria(achievementID) or 0 do
		local _, _, completed, _, _, _, _, asset = GetAchievementCriteriaInfo(achievementID, index)
		if asset == assetID and completed then
			return true
		end
	end
	return false
end

-- Boss vaincu, par plusieurs sources : une seule suffit.
--   native     : (facultatif) critère d'un haut fait natif de Forever
--                (Spéléologue novice 62031, expérimenté 62032, expert 62033),
--                { achievement = id, asset = id affiché par le jeu }.
--                Rétroactif et tenu par le jeu : la source la plus sûre.
--   statistic  : (facultatif) statistique « Morts de <boss> », rétroactive
--                quand Forever la tient à jour.
--   encounters : ids de rencontre (table DungeonEncounter) ; la victoire est
--                vue en direct par le moteur (ENCOUNTER_END / BOSS_KILL),
--                donc pas rétroactive.
-- Exemple : { type = "boss", encounters = { 2755 }, statistic = 1092,
--             native = { achievement = 62031, asset = 4275 } }
-- text (facultatif) : nom du boss affiché dans l'UI.
CriteriaTypes.boss = {
	fields = { "encounters" },
	progressBar = false,
	-- Clé de progression : le premier id de rencontre (la cible du critère).
	key = function(criterion)
		return "boss:" .. tostring(criterion.encounters[1])
	end,
	describe = function(criterion)
		return criterion.text
			or (criterion.statistic and GetStatisticName(criterion.statistic))
			or tostring(criterion.encounters[1])
	end,
	goal = function()
		return 1
	end,
	validate = function(criterion)
		if type(criterion.encounters) ~= "table" or #criterion.encounters == 0 then
			return L.DATA_ERR_ENCOUNTERS
		end
		if criterion.statistic and not GetStatisticName(criterion.statistic) then
			return L.DATA_ERR_STATISTIC:format(tostring(criterion.statistic))
		end
		local native = criterion.native
		if native ~= nil and (type(native) ~= "table" or type(native.achievement) ~= "number"
				or type(native.asset) ~= "number") then
			return L.DATA_ERR_NATIVE
		end
	end,
	current = function(criterion)
		local native = criterion.native
		if native and IsNativeCriterionDone(native.achievement, native.asset) then
			return 1
		end
		if criterion.statistic and GetStatisticNumber(criterion.statistic) >= 1 then
			return 1
		end
		for _, encounterID in ipairs(criterion.encounters) do
			if ns.Database:HasBossKill(encounterID) then
				return 1
			end
		end
		return 0
	end,
}

-- Recettes connues d'un métier (liste dans Data/Recipes.lua).
-- Exemple : { type = "recipes", skillLine = 185, value = 25 }
CriteriaTypes.recipes = {
	fields = { "skillLine", "value" },
	progressBar = true,
	describe = function(criterion)
		local name = L.PROFESSION_NAMES[criterion.skillLine] or tostring(criterion.skillLine)
		return L.CRITERIA_RECIPES:format(name)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	validate = function(criterion)
		if not ns.Data.recipes[criterion.skillLine] then
			return L.DATA_ERR_RECIPES:format(tostring(criterion.skillLine))
		end
	end,
	current = function(criterion)
		return CountKnownRecipes(criterion.skillLine)
	end,
}

-- Porter un tabard. Exemple : { type = "tabard" }
CriteriaTypes.tabard = {
	fields = {},
	progressBar = false,
	describe = function()
		return L.CRITERIA_TABARD
	end,
	goal = function()
		return 1
	end,
	current = function()
		return GetInventoryItemID("player", TABARD_SLOT) and 1 or 0
	end,
}

-- Nombre de quêtes terminées dans une liste de Data/Books.lua (ns.Data.
-- questLists), par personnage : le meilleur compte (combine max), une même
-- quête faite par deux personnages ne compte qu'une fois.
-- Exemple : { type = "questCount", what = "libraryBooks", value = 10 }
CriteriaTypes.questCount = {
	fields = { "what", "value" },
	progressBar = true,
	describe = function(criterion)
		return L.CRITERIA_QUEST_LISTS[criterion.what] or tostring(criterion.what)
	end,
	goal = function(criterion)
		return criterion.value
	end,
	validate = function(criterion)
		if type(ns.Data.questLists[criterion.what]) ~= "table" then
			return L.DATA_ERR_QUEST_LIST:format(tostring(criterion.what))
		end
	end,
	current = function(criterion)
		local count = 0
		for _, questID in ipairs(ns.Data.questLists[criterion.what]) do
			if IsQuestDone(questID) then
				count = count + 1
			end
		end
		return count
	end,
}

-- Nombre de tabards différents équipés par les personnages du compte, notés
-- par Engine à chaque évaluation (Database:RecordTabard). Seul le tabard
-- porté se lit : ceux portés avant l'installation de l'addon ne comptent
-- qu'une fois remis. Exemple : { type = "tabards", value = 10 }
CriteriaTypes.tabards = {
	fields = { "value" },
	progressBar = true,
	describe = function()
		return L.CRITERIA_TABARDS
	end,
	goal = function(criterion)
		return criterion.value
	end,
	current = function()
		return ns.Database:CountTabards()
	end,
}

-- Un rare tué par un personnage du compte, vu en direct par Engine
-- (Database:RecordRareKill). Pas rétroactif. id = numéro de la créature.
-- Exemple : { type = "rare", id = 79 }
CriteriaTypes.rare = {
	fields = { "id" },
	progressBar = false,
	describe = function(criterion)
		return L.RARE_NAMES[criterion.id] or tostring(criterion.id)
	end,
	goal = function()
		return 1
	end,
	current = function(criterion)
		return ns.Database:HasRareKill(criterion.id) and 1 or 0
	end,
}

-- Un jet de 100 sur un objet de qualité supérieure ou mieux, noté par
-- Engine depuis l'historique du butin (Database:RecordPerfectRoll). Pas
-- rétroactif. Exemple : { type = "perfectRoll", what = "greed" }
-- what : « need » (besoin) ou « greed » (cupidité).
CriteriaTypes.perfectRoll = {
	fields = { "what" },
	progressBar = false,
	describe = function(criterion)
		return L.CRITERIA_PERFECT_ROLL[criterion.what] or tostring(criterion.what)
	end,
	goal = function()
		return 1
	end,
	validate = function(criterion)
		if criterion.what ~= "need" and criterion.what ~= "greed" then
			return L.DATA_ERR_PERFECT_ROLL:format(tostring(criterion.what))
		end
	end,
	current = function(criterion)
		return ns.Database:HasPerfectRoll(criterion.what) and 1 or 0
	end,
}

-- Un objet de qualité quality ou mieux dans chaque emplacement de GEAR_SLOTS
-- en même temps. Exemple : { type = "gearQuality", quality = 3 }
CriteriaTypes.gearQuality = {
	fields = { "quality" },
	progressBar = true,
	describe = function(criterion)
		return L.CRITERIA_GEAR_QUALITY[criterion.quality] or tostring(criterion.quality)
	end,
	goal = function()
		return #GEAR_SLOTS
	end,
	current = function(criterion)
		return CountGearSlotsOfQuality(criterion.quality)
	end,
}

-- Être exalté auprès d'une faction. factionID = id de la table Faction.
-- Exemple : { type = "reputation", factionID = 529 }
-- La barre va de Neutre (0) à Exalté (42000) ; en dessous de Neutre, 0.
-- Pas de contrôle au chargement : la réputation n'est peut-être pas encore
-- connue à ADDON_LOADED, une faction introuvable reste simplement à 0.
CriteriaTypes.reputation = {
	fields = { "factionID" },
	progressBar = true,
	describe = function(criterion)
		local name = GetReputation(criterion.factionID)
		return criterion.text or name or tostring(criterion.factionID)
	end,
	goal = function()
		return EXALTED_VALUE
	end,
	current = function(criterion)
		local name, standing, value = GetReputation(criterion.factionID)
		if not name then
			return 0
		end
		if (standing or 0) >= EXALTED_STANDING then
			return EXALTED_VALUE
		end
		return math.max(0, math.min(EXALTED_VALUE - 1, value or 0))
	end,
}

-- Obtenir un autre haut fait de l'addon (métas).
-- Exemple : { type = "achievement", id = 12 }
-- L'id visé est vérifié par le Registry, quand tous les hauts faits sont chargés.
CriteriaTypes.achievement = {
	fields = { "id" },
	progressBar = false,
	asset = function(criterion)
		return criterion.id
	end,
	describe = function(criterion)
		local achievement = ns.Registry:GetAchievement(criterion.id)
		return achievement and achievement.name or tostring(criterion.id)
	end,
	goal = function()
		return 1
	end,
	current = function(criterion)
		return ns.Database:GetCompletion(criterion.id) and 1 or 0
	end,
}
