-- Nombre total de morceaux de carte à découvrir, par art de carte (UiMapArtID).
-- Une zone est entièrement explorée quand le nombre de morceaux renvoyés par
-- C_MapExplorationInfo.GetExploredMapTextures(uiMapID) atteint ce total.
-- L'art d'une zone se retrouve en jeu avec C_Map.GetMapArtID(uiMapID).
--
-- Source : tables du jeu (build 1.60.1) extraites par l'addon OpenMap
-- (Data/Forever/Reveal.lua), en comptant les morceaux de chaque art.
-- Vérifié en jeu : Forêt d'Elwynn (art 2153) = 12.
-- Données uniquement, à regénérer plutôt qu'à modifier à la main.
local _, ns = ...

ns.Data.explorationTotals = {
	[1194] = 11, [1200] = 15, [1202] = 25, [1205] = 15, [1206] = 16, [1207] = 14,
	[1209] = 9, [1210] = 16, [1211] = 15, [1212] = 13, [1213] = 22, [1214] = 12,
	[1215] = 14, [1216] = 18, [1220] = 7, [1224] = 10, [1228] = 12, [1233] = 3,
	[1235] = 13, [1236] = 11, [1238] = 27, [1239] = 11, [1240] = 14, [1243] = 15,
	[1244] = 11, [1247] = 9, [1248] = 18, [1249] = 9, [1250] = 11, [1251] = 15,
	[1252] = 16, [1253] = 7, [1254] = 20, [1259] = 19, [1260] = 12, [1261] = 7,
	[1263] = 1, [1264] = 7, [1266] = 13, [1273] = 3, [1997] = 9, [2031] = 15,
	[2054] = 13, [2121] = 11, [2126] = 17, [2130] = 15, [2132] = 7, [2133] = 15,
	[2134] = 23, [2147] = 16, [2148] = 9, [2149] = 10, [2150] = 3, [2151] = 18,
	[2152] = 13, [2153] = 12, [2154] = 12, [2156] = 11, [2157] = 7, [2158] = 15,
	[2159] = 14, [2160] = 26, [2161] = 11, [2162] = 14, [2164] = 13, [2165] = 14,
	[2166] = 15, [2167] = 18, [2168] = 19, [2169] = 11, [2170] = 16, [2171] = 9,
	[2173] = 7, [2174] = 12, [2175] = 1, [2177] = 7, [2178] = 11, [2179] = 20,
	[2180] = 11, [2181] = 25, [2182] = 9, [2184] = 7, [2185] = 13, [2186] = 3,
}
