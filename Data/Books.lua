-- Listes de quêtes comptées par le critère « questCount »
-- (Core/CriteriaTypes.lua) : [nom de la liste] = { id de quête, ... }.
local _, ns = ...

ns.Data.questLists = {
	-- Livres de bibliothèque : chaque livre est sa propre quête, rendue à
	-- Garion Wendell (Hurlevent) ou à Owen Thadd (Fossoyeuse). Les paliers
	-- 10 / 20 / 25 / 30 livres sont les quêtes 78150 « Ami de la
	-- bibliothèque » et 79536, 82208, 84394 « Mécène de la bibliothèque ».
	-- Source : addon NaowhForever (NaowhForever_Discovery/Data/Books.lua).
	-- Camp : A Alliance, H Horde, sinon les deux.
	libraryBooks = {
		-- Niveau 20
		79092, -- Archmage Theocritus' Research Journal
		79091, -- Archmage Antonidas: The Unabridged Autobiography (A)
		79093, -- Rumi of Gnomeregan: The Collected Works
		79095, -- The Apothecary's Metaphysical Primer
		79094, -- The Lessons of Ta'zo (H)
		79096, -- Ataeric: On Arcane Curiosities (H)
		78142, -- Bewitchments and Glamours
		78147, -- Crimes Against Anatomy
		78148, -- Runes of the Sorcerer-Kings
		78146, -- Goaz Scrolls
		78127, -- The Dalaran Digest, Vol. 23
		78124, -- Nar'thalas Almanac, Vol. 74
		78145, -- Arcanic Systems Manual
		79097, -- Baxtan: On Destructive Magics
		78143, -- Secrets of the Dreamers
		78149, -- Fury of the Land
		-- Niveau 35
		79535, -- Basilisks: Should Petrification be Feared?
		79947, -- Geomancy: The Stone-Cold Truth
		79948, -- Defensive Magics 101
		79952, -- RwlRwlRwlRwl!
		79949, -- A Web of Lies: Debunking Myths and Legends
		79950, -- Demons and You
		79951, -- Mummies: A Guide to the Unsavory Undead
		79953, -- A Luddite's Guide to Caring for Your Demonic Pet
		-- Niveau 45
		81947, -- Sanguine Sorcery
		81949, -- Legends of the Tidesages
		81952, -- Everyday Etiquette
		81953, -- Stonewrought Design
		81954, -- Venomous Journeys
		81955, -- A Mind of Metal
		81956, -- Conjurer's Codex
		81951, -- The Liminal and the Arcane (emplacement encore inconnu)
		-- Niveau 60
		84397, -- Northern Kalimdor - A Comprehensive Guide
		84402, -- Necromancy 101
		84398, -- A Study of the Light
		84399, -- Ka-Boom!
		84395, -- Undead Potatoes
		84396, -- Magma or Lava?
		84400, -- The Knight and the Lady
		84401, -- Scourge: Undead Menace or Misunderstood?
	},
}
