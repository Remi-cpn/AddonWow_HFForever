-- Tabards en double : Forever a recréé des tabards sous un second numéro
-- d'objet, avec le même nom. Pour « Dix tabards » et « Timbré de tabards »,
-- chaque tabard ne compte qu'une fois : [numéro en double] = numéro retenu.
-- Source : tables Item et ItemSparse du build Forever 1.60.1.70938
-- (InventoryType 19), noms identiques.
local _, ns = ...

ns.Data.tabardAliases = {
	[272694] = 15196,  -- Tabard de soldat
	[272449] = 15197,  -- Tabard d'éclaireur
	[272695] = 15198,  -- Couleurs de chevalier
	[272450] = 15199,  -- Héraut du Garde de pierre
	[282294] = 5976,   -- Tabard de guilde
}
