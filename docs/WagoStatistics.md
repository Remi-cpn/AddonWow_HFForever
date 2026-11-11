# Statistiques de Forever (wago.tools)

Relevé du 2026-11-11, build Forever `wowf` 1.60.1.70862. Source : table
`Achievement` (lignes dont `Flags` contient le bit 1) et `Achievement_Category`,
en frFR et enUS. Voir [WagoAchievements.md](WagoAchievements.md) pour les liens.

207 statistiques, lues en jeu avec `GetStatistic(id)` (texte) et
`GetAchievementInfo(id)` (nom).

## Colonne « Usage »

| Usage | Sens |
| --- | --- |
| `sum` | compteur : les personnages du compte s'additionnent |
| `max` | record ou état d'un personnage : le meilleur personnage compte |
| `argent` | montant en or : `GetStatistic` renvoie probablement un texte avec icônes de pièces, il faudra un lecteur dédié (à vérifier en jeu). Additionné (`sum`) sauf les records (`max`) |
| `texte` | renvoie un nom (« Bandage le plus utilisé »), pas un nombre : inutilisable |
| `moyenne` | moyenne par jour : inutilisable |
| `utilisé` | déjà utilisé par un haut fait de la v1 |

Flags rencontrés : 0x01 statistique, 0x08 somme de sous-critères, 0x10 affiche
l'élément le plus fréquent (`texte`), 0x20 nombre de critères remplis, 0x40
moyenne. 0x80000 est présent sur toutes les statistiques de boss, 0x100000 sur
quatre d'entre elles (rôle inconnu).

## Combat (141)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 193 | Plus gros dégâts effectués | Largest hit dealt | `max` |
| 527 | Plus gros dégâts subis | Largest hit received | `max` |
| 197 | Dégâts totaux infligés | Total damage done | `sum` |
| 528 | Dégâts totaux subis | Total damage received | `sum` |
| 189 | Plus gros soin | Largest heal cast | `max` |
| 829 | Plus gros soin reçu | Largest heal received | `max` |
| 198 | Total de soins effectués | Total healing done | `sum` |
| 830 | Montant total des soins reçus | Total healing received | `sum` |

## Compétences (132)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 1199 | Métiers appris | Professions learned | `max` |
| 1201 | Métiers au niveau maximum | Professions at maximum skill | `max` |
| 1200 | Compétences secondaires au niveau maximum | Secondary skills at maximum skill | `max` |
| 1202 | Compétences d'armes au niveau maximum | Weapon skills at maximum skill | `max` |

### Compétences secondaires (178)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 1524 | Compétence en cuisine | Cooking skill | `max` |
| 1525 | Quêtes journalières de cuisine achevées | Cooking daily quests completed | `sum` |
| 1745 | Recettes de cuisine connues | Cooking Recipes known | `max` |
| 1976 | Prix de cuisine de Dalaran obtenus | Dalaran Cooking Awards gained | `sum` (reste de WotLK, sans doute toujours 0) |
| 281 | Compétence en secourisme | First Aid skill | `max` |
| 1748 | Manuels de secourisme appris | First Aid Manuals learned | `max` |
| 1519 | Compétence en pêche | Fishing skill | `max` |
| 1518 | Poissons pêchés | Fish caught | `sum` |
| 1456 | Poissons et autres objets pêchés | Fish and other things caught | `sum` |
| 1526 | Quêtes journalières de pêche achevées | Fishing daily quests completed | `sum` |

### Métiers (173)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 1527 | Plus haut score de compétence en alchimie | Highest Alchemy skill | `max` |
| 1729 | Recettes d'alchimie apprises | Alchemy Recipes learned | `max` |
| 1532 | Plus haut score de compétence en forge | Highest Blacksmithing skill | `max` |
| 1730 | Plans de forge appris | Blacksmithing Plans learned | `max` |
| 1535 | Plus haut score de compétence en enchantement | Highest Enchanting skill | `max` |
| 178 | Formules d'enchantement apprises | Enchanting formulae learned | `max` |
| 183 | Matériaux obtenus par désenchantement | Materials produced from disenchanting | `sum` |
| 181 | Objets désenchantés | Items disenchanted | `sum` |
| 1544 | Plus haut score de compétence en ingénierie | Highest Engineering skill | `max` |
| 1734 | Schémas d'ingénierie appris | Engineering Schematics learned | `max` |
| 1538 | Plus haut score de compétence en herboristerie | Highest Herbalism skill | `max` |
| 1539 | Plus haut score de compétence en calligraphie | Highest Inscription skill | `max` (pas de calligraphie sur Forever) |
| 1735 | Calligraphies apprises | Inscriptions learned | `max` (idem) |
| 1536 | Plus haut score de compétence en travail du cuir | Highest Leatherworking skill | `max` |
| 1740 | Patrons de travail du cuir appris | Leatherworking Patterns learned | `max` |
| 1537 | Plus haut score de compétence en minage | Highest Mining skill | `max` |
| 3216 | Fontes apprises | Smelting Recipes learned | `max` |
| 1541 | Plus haut score de compétence en dépeçage | Highest Skinning skill | `max` |
| 1542 | Plus haut score de compétence en couture | Highest Tailoring skill | `max` |
| 1741 | Patrons de couture appris | Tailoring Patterns learned | `max` |

Les rangs de métier sont déjà lus par `GetProfessionInfo` (type `profession`).

## Donjons et raids (14807)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 932 | Nombre d'entrées dans des donjons à 5 | Total 5-player dungeons entered | `sum` |
| 933 | Nombre d'entrées dans des raids à 10 | Total 10-player raids entered | `sum` |
| 934 | Total de raids à 20 joueurs tentés | Total 20-player raids entered | `sum` |
| 64184 | Total de raids à 40 joueurs tentés | Total 40-player raids entered | `sum` |

### Boss (14821)

Une victoire suffit pour un haut fait de donjon : `max` (ou `sum` pour « tuer N fois »).

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 1093 | Morts du commandant écarlate Mograine (Monastère écarlate) | Scarlet Commander Mograine kills (Scarlet Monastery) | `utilisé` (5010) |
| 63570 | Morts d'Edwin VanCleef (Mortemines) | Edwin VanCleef Kills (Deadmines) | `utilisé` (5002) |
| 63571 | Morts de Rath'mael (ruines de Lordaeron) | Rath'mael Kills (Ruins of Lordaeron) | `utilisé` (5102) |
| 63572 | Morts de l'Ombre de l'archimage (cité de Dalaran) | Shade of the Archmage Kills (City of Dalaran) | `utilisé` (5103) |
| 1097 | Morts du baron Vaillefendre (Stratholme) | Baron Rivendare kills (Stratholme) | `max`, flag 0x100000 (doublon de 15031 ?) |
| 63589 | Morts de Lyn l'Ignoré (cité de Dalaran) | Lyn the Ignored Kills (City of Dalaran) | `max` (boss optionnel) |
| 63573 | Morts de Durgen Mornemartel (salle des Thanes) | Durgen Dirgehammer Kills (Hall of Thanes) | cassée (reste à 0, voir ProposedAchievements) |
| 63574 | Morts de Nanaya (terrasse du Façonneur) | Nanaya Kills (Shaper's Terrace) | `utilisé` (5105) |
| 63590 | Morts de Braise (terrasse du Façonneur) | Cinder Kills (Shaper's Terrace) | `max`, flag 0x100000 |
| 63592 | Morts de Fulguro (terrasse du Façonneur) | Bolt Kills (Shaper's Terrace) | `max`, flag 0x100000 |
| 63593 | Morts de Serre-neigeuse (terrasse du Façonneur) | Snowtalon Kills (Shaper's Terrace) | `max`, flag 0x100000 |
| 63575 | Morts de Rugiflamme (prison d'Alcaz) | Blazeroar Kills (Alcaz Prison) | `utilisé` (5104) |
| 63580 | Morts du roi sauvage (sommet d'Hyjal) | The Wild King kills (Hyjal Summit) | `max` |
| 63581 | Morts de Sonya Sanctombre (profondeurs des Saisons) | Sonya Darkhallow Kills (Barrow Deeps) | `max` |
| 15027 | Morts de Bazzalan (gouffre de Ragefeu) | Bazzalan kills (Ragefire Chasm) | cassée (compte la salle des Thanes) |
| 15028 | Morts de Mutanus le Dévoreur (cavernes des Lamentations) | Mutanus the Devourer kills (Wailing Caverns) | `utilisé` (5003) |
| 1092 | Morts de l'archimage Arugal (donjon d'Ombrecroc) | Archmage Arugal kills (Shadowfang Keep) | `utilisé` (5004) |
| 15029 | Morts de Bazil Thredd (prison de Hurlevent) | Bazil Thredd kills (Stormwind Stockade) | `utilisé` (5005) |
| 6137 | Morts d'Aku'mai (profondeurs de Brassenoire) | Aku'mai kills (Blackfathom Deeps) | `utilisé` (5006) |
| 6139 | Morts de Charlga Trancheflanc (Kraal de Tranchebauge) | Charlga Razorflank kills (Razorfen Kraul) | `utilisé` (5008) |
| 6140 | Morts du mekgénieur Thermojoncteur (Gnomeregan) | Mekgineer Thermaplugg kills (Gnomeregan) | `utilisé` (5007) |
| 6141 | Morts d'Amnennar le Porte-Froid (souilles de Tranchebauge) | Amnennar the Coldbringer kills (Razorfen Downs) | `utilisé` (5011) |
| 6786 | Morts du tisseur de flammes Koegler (salles Écarlates) | High Inquisitor Whitemane kills (Scarlet Monastery) | `utilisé` (5009, libellé enUS périmé) |
| 6142 | Morts d'Archaedas (Uldaman) | Archaedas kills (Uldaman) | `utilisé` (5012) |
| 1094 | Morts du chef Ukorz Scalpessable (Zul'Farrak) | Chief Ukorz Sandscalp kills (Zul'Farrak) | `utilisé` (5013) |
| 6143 | Morts de la princesse Theradras (Maraudon) | Princess Theradras kills (Maraudon) | `utilisé` (5014) |
| 6144 | Morts de l'ombre d'Eranikus (temple Englouti) | Shade of Eranikus kills (Sunken Temple) | `utilisé` (5015) |
| 1095 | Morts de Dagran Thaurissan (Profondeurs de Rochenoire) | Emperor Dagran Thaurissan kills (Blackrock Depths) | `utilisé` (5016) |
| 6146 | Morts du roi Gordok (Hache-Tripes) | King Gordok kills (Dire Maul) | `utilisé` (5017) |
| 6145 | Morts du seigneur Wyrmthalak (pic Rochenoire inférieur) | Overlord Wyrmthalak kills (Lower Blackrock Spire) | `utilisé` (5018) |
| 1096 | Morts du général Drakkisath (Pic Rochenoire supérieur) | General Drakkisath kills (Upper Blackrock Spire) | `utilisé` (5019) |
| 15030 | Morts du sombre maître Gandling (Scholomance) | Darkmaster Gandling kills (Scholomance) | `utilisé` (5020) |
| 15031 | Morts du baron Vaillefendre (Stratholme) | Baron Rivendare kills (Stratholme) | `utilisé` (5021) |
| 1098 | Morts d'Onyxia (Repaire d'Onyxia) | Onyxia kills (Onyxia's Lair) | `max` |

## Joueur contre Joueur (21)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 1501 | Nombre total de morts causées par d'autres personnages | Total deaths from other players | `sum` |
| 318 | Nombre total de morts causées par la faction adverse | Total deaths from opposite faction | `sum` |

### Champs de bataille (153)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 839 | Participations à des champs de bataille | Battlegrounds played | `sum` |
| 2396 | Champ de bataille le plus disputé | Battleground played the most | `texte` |
| 840 | Champs de bataille gagnés | Battlegrounds won | `sum` |
| 2397 | Champ de bataille le plus remporté | Battleground won the most | `texte` |
| 53 | Batailles pour la vallée d'Alterac | Alterac Valley battles | `sum` |
| 49 | Victoires dans la vallée d'Alterac | Alterac Valley victories | `sum` |
| 55 | Batailles pour le bassin Arathi | Arathi Basin battles | `sum` |
| 51 | Victoires dans le bassin Arathi | Arathi Basin victories | `sum` |
| 52 | Batailles pour le goulet des Chanteguerres | Warsong Gulch battles | `sum` |
| 105 | Victoires dans le goulet des Chanteguerres | Warsong Gulch victories | `sum` |
| 64179 | Combats sur les îles des Sombrelances | Darkspear Islands battles | `sum` |
| 64176 | Victoires sur les îles des Sombrelances | Darkspear Islands victories | `sum` |
| 393 | Tours de la vallée d'Alterac défendues | Alterac Valley towers defended | `sum` |
| 394 | Tours de la vallée d'Alterac capturées | Alterac Valley towers captured | `sum` |
| 395 | Drapeaux du goulet des Chanteguerres capturés | Warsong Gulch flags captured | `sum` |
| 586 | Drapeaux du goulet des Chanteguerres ramenés | Warsong Gulch flags returned | `sum` |
| 64348 | Bases du bassin Arathi attaquées | Arathi Basin bases assaulted | `sum` |
| 64349 | Bases du bassin Arathi défendues | Arathi Basin bases defended | `sum` |
| 64350 | Bases des îles des Sombrelances attaquées | Darkspear Islands bases assaulted | `sum` |
| 64351 | Bases des îles des Sombrelances défendues | Darkspear Islands bases defended | `sum` |
| 64352 | Drapeaux des îles des Sombrelances capturés | Darkspear Islands flags captured | `sum` |

### En extérieur (154)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 319 | Duels gagnés | Duels won | `sum` |
| 320 | Duels perdus | Duels lost | `sum` |

## Morts (122)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 60 | Nombre total de morts | Total deaths | `sum` |

### Champs de bataille (124)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 57 | Morts dans la Vallée d'Alterac | Deaths in Alterac Valley | `sum` |
| 59 | Morts dans le bassin Arathi | Deaths in Arathi Basin | `sum` |
| 56 | Morts dans le goulet des Chanteguerres | Deaths in Warsong Gulch | `sum` |
| 58 | Morts causées par Drek'Thar | Deaths from Drek'Thar | `sum` |
| 64182 | Morts sur les îles des Sombrelances | Deaths in Darkspear Islands | `sum` |
| 593 | Morts causées par Vanndar Foudrepique | Deaths from Vanndar Stormpike | `sum` |

### Donjons et raids (125)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 321 | Nombre total de morts en donjons et raids | Total raid and dungeon deaths | `sum` |
| 918 | Morts dans des donjons à 5 | Total deaths in 5-player dungeons | `sum` |
| 917 | Morts dans des raids à 10 | Total deaths in 10-player raids | `sum` |
| 64183 | Total de morts dans les raids à 20 joueurs | Total deaths in 20-player raids | `sum` |
| 64185 | Total de morts dans les raids à 40 joueurs | Total deaths in 40-player raids | `sum` |

### En extérieur (126)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 112 | Morts par noyade | Deaths from drowning | `sum` |
| 594 | Morts causées par Lardeur | Deaths from Hogger | `sum` |
| 113 | Morts de fatigue | Deaths from fatigue | `sum` |
| 114 | Morts des suites d'une chute | Deaths from falling | `sum` |
| 115 | Morts par le feu ou la lave | Deaths from fire and lava | `sum` |

### Résurrection (127)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 796 | Résurrections par des prêtres | Resurrected by priests | `sum` |
| 798 | Renaissances par des druides | Rebirthed by druids | `sum` |
| 1229 | Ressuscité par des druides | Revived by druids | `sum` (Ressusciter hors combat : sort absent en Classic ?) |
| 799 | Esprits ancestraux par des chamans | Spirit returned to body by shamans | `sum` |
| 800 | Rédemptions par des paladins | Redeemed by paladins | `sum` |
| 801 | Résurrections par pierres d'âmes | Resurrected by soulstones | `sum` |

## Personnage (130)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 64222 | Nombre de campements | Times camped | `sum` (propre à Forever) |
| 1149 | Respécialisations de talents | Talent tree respecs | `sum` |

### Consommables (145)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 344 | Bandages utilisés | Bandages used | `sum` |
| 1125 | Bandage le plus utilisé | Bandage used most | `texte` |
| 345 | Potions de soins consommées | Health potions consumed | `sum` |
| 922 | Potions de mana consommées | Mana potions consumed | `sum` |
| 923 | Élixirs consommés | Elixirs consumed | `sum` |
| 811 | Flacons consommés | Flasks consumed | `sum` |
| 346 | Boissons consommées | Beverages consumed | `sum` |
| 347 | Denrées consommées | Food eaten | `sum` |
| 812 | Pierres de soins utilisées | Healthstones used | `sum` |

### Richesse (140)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 328 | Quantité totale d'argent obtenu | Total gold acquired | `argent` (`sum`) |
| 753 | Argent gagné en moyenne par jour | Average gold earned per day | `moyenne` |
| 333 | Argent ramassé | Gold looted | `argent` (`sum`) |
| 326 | Argent obtenu en récompense de quêtes | Gold from quest rewards | `argent` (`sum`) |
| 919 | Argent gagné à l'hôtel des ventes | Gold earned from auctions | `argent` (`sum`) |
| 329 | Mises en vente à l'hôtel des ventes | Auctions posted | `sum` |
| 330 | Nombre d'achats à l'hôtel des ventes | Auction purchases | `sum` |
| 331 | Enchère la plus importante à l'hôtel des ventes | Most expensive bid on auction | `argent` (`max`) |
| 332 | Plus grosse vente à l'hôtel des ventes | Most expensive auction sold | `argent` (`max`) |
| 921 | Argent obtenu par les marchands | Gold from vendors | `argent` (`sum`) |
| 1146 | Argent dépensé en voyages | Gold spent on travel | `argent` (`sum`) |
| 1147 | Argent dépensé chez le coiffeur | Gold spent at barber shops | `argent` (`sum`) |
| 1148 | Argent dépensé en envoi de courriers | Gold spent on postage | `argent` (`sum`) |
| 1150 | Argent dépensé en respécialisations de talents | Gold spent on talent tree respecs | `argent` (`sum`) |
| 334 | Plus grande quantité d'argent possédée | Most gold ever owned | `argent` (`max`) |

### Réputation (147)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 377 | Plus grand nombre de réputations exaltées | Most factions at Exalted | `max` |
| 378 | Plus grand nombre de réputations révérées ou supérieures | Most factions at Revered or higher | `max` |
| 529 | Plus grand nombre de réputations honorées ou supérieures | Most factions at Honored or higher | `max` |
| 1466 | Plus grand nombre de réputations de l'Alliance exaltées | Most Alliance factions at Exalted | `max` |
| 926 | Plus grand nombre de réputations de la Horde exaltées | Most Horde factions at Exalted | `max` |
| 931 | Nombre total de factions rencontrées | Total factions encountered | `max` |

Les réputations ne s'additionnent pas : deux personnages exaltés auprès de la
même faction compteraient deux fois.

### Équipement (191)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 927 | Objets épiques équipés dans des emplacements d'objets | Equipped epic items in item slots | `max` |
| 342 | Objets épiques obtenus | Epic items acquired | `sum` |
| 341 | Objets épiques ramassés | Epic items looted | `sum` |
| 336 | Objets légendaires obtenus | Legendary items acquired | `sum` |
| 339 | Montures possédées | Mounts owned | `max` |
| 338 | Mascottes possédées | Vanity pets owned | `max` |
| 928 | Emplacements en banque supplémentaires achetés | Extra bank slots purchased | `max` |
| 1043 | Nombre de jets de cupidité sur du butin | Greed rolls made on loot | `sum` |
| 1044 | Nombre de jets de besoin sur du butin | Need rolls made on loot | `sum` |

## Quêtes (133)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 98 | Quêtes achevées | Quests completed | `utilisé` (2001 à 2005, `sum`) |
| 95 | Nombre moyen de quêtes achevées par jour | Average quests completed per day | `moyenne` |
| 94 | Quêtes abandonnées | Quests abandoned | `sum` |

## Social (131)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 1042 | Nombre de câlins | Number of hugs | `sum` |
| 1047 | Nombre d'utilisations de l'emote /consternant | Total facepalms | `sum` |
| 1067 | Nombre total d'apitoiements | Total times playing world's smallest violin | `sum` |
| 1066 | Nombre de MDR | Total times LOL'd | `sum` |
| 1045 | Nombre total d'acclamations | Total cheers | `sum` |
| 1065 | Nombre total de signes de la main | Total waves | `sum` |

## Victimes (128)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 1197 | Nombre total de victimes | Total kills | `sum` |
| 1198 | Victimes apportant de l'expérience ou de l'honneur | Total kills that grant experience or honor | `sum` |

### Coups fatals (137)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 1487 | Nombre total de coups fatals | Total Killing Blows | `sum` |
| 1488 | Coups fatals en extérieur | World Killing Blows | `sum` |
| 1489 | Continent où vous avez infligé le plus de coups fatals | Continent with the most Killing Blows | `texte` |
| 1491 | Coups fatals en champs de bataille | Battleground Killing Blows | `sum` |
| 1716 | Champ de bataille avec le plus de coups fatals | Battleground with the most Killing Blows | `texte` |
| 1495 | Coups fatals dans la vallée d'Alterac | Alterac Valley Killing Blows | `sum` |
| 1496 | Coups fatals dans le bassin Arathi | Arathi Basin Killing Blows | `sum` |
| 1497 | Coups fatals dans le goulet des Chanteguerres | Warsong Gulch Killing Blows | `sum` |
| 64181 | Coups fatals sur les îles des Sombrelances | Darkspear Islands Killing Blows | `sum` |

### Créatures (135)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 107 | Créatures tuées | Creatures killed | `sum` |
| 1337 | Types de créatures différentes tuées | Different creature types killed | `max` |
| 1336 | Type de créature le plus tué | Creature type killed the most | `texte` |
| 108 | Bestioles tuées | Critters killed | `sum` |

### Victoires honorables (136)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 588 | Nombre total de victoires honorables | Total Honorable Kills | `sum` |
| 381 | Victoires honorables en extérieur | World Honorable Kills | `sum` |
| 1458 | Continent où vous avez obtenu le plus de victoires honorables | Continent with the most Honorable Kills | `texte` |
| 382 | Victoires honorables en champs de bataille | Battleground Honorable Kills | `sum` |
| 1719 | Champ de bataille avec le plus de victoires honorables | Battleground with the most Honorable Kills | `texte` |
| 1113 | Victoires honorables dans la vallée d'Alterac | Alterac Valley Honorable Kills | `sum` |
| 1114 | Victoires honorables dans le bassin Arathi | Arathi Basin Honorable Kills | `sum` |
| 1115 | Victoires honorables dans le goulet des Chanteguerres | Warsong Gulch Honorable Kills | `sum` |
| 64180 | Victoires honorables sur les îles des Sombrelances | Darkspear Islands Honorable Kills | `sum` |

## Voyages (134)

| id | Nom | Name | Usage |
| --- | --- | --- | --- |
| 349 | Trajets aériens empruntés | Flight paths taken | `sum` |
| 2277 | Invocations acceptées | Summons accepted | `sum` |
| 350 | Portails de mages empruntés | Mage Portals taken | `sum` |
| 1339 | Portail de mage le plus emprunté | Mage portal taken most | `texte` |
| 353 | Nombre d'utilisations de la pierre de foyer | Number of times hearthed | `sum` |

## Bilan

| Usage | Nombre |
| --- | --- |
| utilisable (`sum`, `max`, `argent`) | 167 |
| déjà utilisé | 25 |
| `texte` ou `moyenne` | 11 |
| cassée ou absente de Forever | 4 (15027, 63573, 1539, 1735) |
