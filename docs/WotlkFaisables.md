# Hauts faits WotLK faisables sur Forever

Croisement du 2026-11-11 entre [WotlkAchievements.md](WotlkAchievements.md)
(lignes encore sans statut) et [WagoStatistics.md](WagoStatistics.md).

## Méthode

On ne compare pas les noms mais ce que mesure chaque haut fait. Les tables
`Criteria` et `CriteriaTree` de wago.tools donnent, pour chaque haut fait WotLK
(données retail, mêmes id) et chaque statistique Forever, le type de critère et
sa cible (ex. « victoires honorables », « gagner sur la carte 489 »).

Un haut fait est retenu si :
- chacun de ses critères correspond à une statistique Forever qui mesure
  **exactement** ce critère et rien d'autre ;
- aucun critère n'ajoute de condition (« en une seule bataille », « sans
  mourir », « en moins de X minutes ») : une statistique ne sait pas le vérifier ;
- l'arbre de critères est respecté (ET, OU, somme) ;
- le palier est atteignable sur Forever.

Écartés : les 5 « prix de cuisine de Dalaran » (statistique 1976, toujours 0 sur
Forever), les quêtes journalières (la statistique 98 compte toutes les quêtes),
les réputations précises lues par les statistiques 926 / 1466 (elles ne donnent
qu'un total).

Colonne « 9b » : la statistique sert déjà dans [ProposedAchievements.md](ProposedAchievements.md)
(étape 9b). Le haut fait WotLK peut alors remplacer ou compléter notre proposition
avec son nom officiel.

## 1. Par statistique (39 HF)

### Général (12)

| id | Nom | Description | Pts | Stat | Seuil | 9b |
| --- | --- | --- | --- | --- | --- | --- |
| 546 | Chambre forte | Acheter 7 emplacements de sac supplémentaires. | 10 | 928 | 7 | |
| 1176 | Le fric, c'est chic | Ramasser 100 pièces d'or en butin. | 10 | 333 (or) | 100 po | 1111 |
| 1177 | Le fric, c'est chic | Ramasser 1 000 pièces d'or en butin. | 10 | 333 (or) | 1 000 po | 1112 |
| 1178 | Le fric, c'est chic | Ramasser 5 000 pièces d'or en butin. | 10 | 333 (or) | 5 000 po | |
| 1180 | Le fric, c'est chic | Ramasser 10 000 pièces d'or en butin. | 10 | 333 (or) | 10 000 po | |
| 1181 | Le fric, c'est chic | Ramasser 25 000 pièces d'or en butin. | 10 | 333 (or) | 25 000 po | |
| 2141 | Gardien d'écuries | Obtenir 10 montures. | 10 | 339 | 10 | 1202 |
| 2142 | L'écurie se remplit | Obtenir 25 montures. | 10 | 339 | 25 | 1203 |
| 2143 | À la tête de la cavalerie | Obtenir 50 montures. | 10 | 339 | 50 | |
| 2536 | Une montagne de montures (Alliance) | Obtenir 100 montures. | 10 | 339 | 100 | |
| 2537 | Une montagne de montures (Horde) | Obtenir 100 montures. | 10 | 339 | 100 | |
| 1182 | Gagne-pain | Obtenir 10 000 pièces d'or en récompenses de quêtes. | 10 | 326 (or) | 10 000 po | |

2536 / 2537 : un seul HF commun suffit chez nous (HF communs Horde / Alliance).
50 et 100 montures : à vérifier qu'il y en a assez sur Forever.

### Joueur contre Joueur (21)

| id | Nom | Description | Pts | Stat | Seuil | 9b |
| --- | --- | --- | --- | --- | --- | --- |
| 238 | Une victoire honorable | Obtenir une victoire honorable. | 10 | 588 | 1 | 6001 |
| 513 | 100 victoires honorables | Obtenir 100 victoires honorables. | 10 | 588 | 100 | 6002 |
| 515 | 500 victoires honorables | Obtenir 500 victoires honorables. | 10 | 588 | 500 | |
| 516 | 1 000 victoires honorables | Obtenir 1 000 victoires honorables. | 10 | 588 | 1 000 | 6003 |
| 512 | 5 000 victoires honorables | Obtenir 5 000 victoires honorables. | 10 | 588 | 5 000 | 6004 |
| 509 | 10 000 victoires honorables | Obtenir 10 000 victoires honorables. | 10 | 588 | 10 000 | 6005 |
| 239 | 25 000 victoires honorables | Obtenir 25 000 victoires honorables. | 10 | 588 | 25 000 | |
| 869 | 50 000 victoires honorables | Obtenir 50 000 victoires honorables. | 10 | 588 | 50 000 | |
| 870 | 100 000 victoires honorables | Obtenir 100 000 victoires honorables. | 10 | 588 | 100 000 | |
| 1157 | Duel-icieux | Gagner un duel contre un autre personnage. | 10 | 319 | 1 | 6011 |
| 166 | Victoire dans le goulet des Chanteguerres | Gagner dans le goulet des Chanteguerres. | 10 | 105 | 1 | 6123 |
| 167 | Vétéran du goulet des Chanteguerres | Obtenir 100 victoires dans le goulet des Chanteguerres. | 10 | 105 | 100 | |
| 199 | Capture du drapeau | Porter et capturer soi-même le drapeau dans le goulet des Chanteguerres. | 10 | 395 | 1 | 6131 |
| 200 | Défenseur obstiné | Ramener 50 drapeaux en défense dans le goulet des Chanteguerres. | 10 | 586 | 50 | 6133 (10) |
| 154 | Victoire dans le bassin Arathi | Gagner dans le bassin Arathi. | 10 | 51 | 1 | 6122 |
| 155 | Vétéran du bassin Arathi | Obtenir 100 victoires au bassin Arathi. | 10 | 51 | 100 | |
| 157 | À la rescousse ! | Venir 50 fois à la rescousse d'une base du bassin Arathi en récupérant le drapeau. | 10 | 64349 | 50 | 6137 (10) |
| 158 | Cap ou pas cap ? | Capturer 50 drapeaux au bassin Arathi. | 10 | 64348 | 50 | 6136 (10) |
| 218 | Victoire dans la vallée d'Alterac | Gagner dans la vallée d'Alterac. | 10 | 49 | 1 | 6121 |
| 219 | Vétéran de la vallée d'Alterac | Obtenir 100 victoires dans la vallée d'Alterac. | 10 | 49 | 100 | |
| 222 | Défense des tours | Défendre 50 tours dans la vallée d'Alterac. | 10 | 393 | 50 | 6135 (10) |

### Métiers > Pêche (6)

| id | Nom | Description | Pts | Stat | Seuil | 9b |
| --- | --- | --- | --- | --- | --- | --- |
| 1556 | 25 poissons | Pêcher 25 objets. | 10 | 1456 | 25 | |
| 1557 | 50 poissons | Pêcher 50 objets. | 10 | 1456 | 50 | |
| 1558 | 100 poissons | Pêcher 100 objets. | 10 | 1456 | 100 | 4031 (1518) |
| 1559 | 250 poissons | Pêcher 250 objets. | 10 | 1456 | 250 | |
| 1560 | 500 poissons | Pêcher 500 objets. | 10 | 1456 | 500 | |
| 1561 | 1 000 poissons | Pêcher 1 000 objets. | 10 | 1456 | 1 000 | 4032 (1518) |

WotLK compte « poissons et autres objets pêchés » (1456), notre 9b comptait
« poissons pêchés » (1518). Prendre 1456 pour coller à WotLK.

## 2. Bonus : faisables par une autre API (19 HF)

Pas de statistique, mais une fonction du jeu donne l'information, rétroactive
comme le reste. Nouveau type de critère à créer : `reputation` (faction exaltée,
`C_Reputation` / `GetFactionInfoByID`, à vérifier sur Forever). Les métiers
utilisent le type `profession` existant. Toutes les factions ci-dessous existent
dans la table `Faction` de Forever.

### Réputation de champs de bataille (8)

| id | Nom | Description | Pts | Faction |
| --- | --- | --- | --- | --- |
| 712 | Voltigeur Chanteguerre (Horde) | Être exalté auprès des voltigeurs Chanteguerre. | 10 | 889 |
| 713 | Sentinelle d'Aile-argent (Alliance) | Être exalté auprès des sentinelles d'Aile-argent. | 10 | 890 |
| 710 | Profanateur (Horde) | Être exalté auprès des Profanateurs réprouvés. | 10 | 510 |
| 711 | Chevalier d'Arathor (Alliance) | Être exalté auprès de la ligue d'Arathor. | 10 | 509 |
| 708 | Héros du clan Loup-de-givre (Horde) | Être exalté auprès du clan Loup-de-givre. | 10 | 729 |
| 709 | Héros de la garde Foudrepique (Alliance) | Être exalté auprès de la garde Foudrepique. | 10 | 730 |
| 714 | Conquérant (Horde) | Être exalté auprès des factions du goulet, du bassin Arathi et de la vallée d'Alterac. | 20 | 889, 510, 729 |
| 907 | Le justicier (Alliance) | Être exalté auprès des factions du goulet, du bassin Arathi et de la vallée d'Alterac. | 20 | 890, 509, 730 |

Gardés séparés comme dans WoW : chaque personnage ne voit que ceux de son camp
(champ `faction` des données). 714 / 907 sont des métas des 3 HF de leur camp.

### Réputation classique (5)

| id | Nom | Description | Pts | Faction |
| --- | --- | --- | --- | --- |
| 944 | Il y a de l'amour dans ce tunnel | Être exalté auprès des Grumegueules. | 15 | 576 |
| 946 | L'Aube d'argent | Être exalté auprès de l'Aube d'argent. | 15 | 529 |
| 955 | Les Hydraxiens | Être exalté auprès des Hydraxiens. | 10 | 749 |
| 956 | Progéniture de Nozdormu | Être exalté auprès de la Progéniture de Nozdormu. | 10 | 910 |
| 957 | Héros de la tribu Zandalar | Être exalté auprès de la tribu Zandalar. | 10 | 270 |

### Métiers secondaires (6)

| id | Nom | Description | Pts | Rang |
| --- | --- | --- | --- | --- |
| 121 | Compagnon cuisinier | Devenir un compagnon cuisinier. | 10 | Cuisine 150 |
| 122 | Expert cuisinier | Devenir un expert cuisinier. | 10 | Cuisine 225 |
| 126 | Compagnon pêcheur | Devenir un compagnon pêcheur. | 10 | Pêche 150 |
| 127 | Expert pêcheur | Devenir un expert pêcheur. | 10 | Pêche 225 |
| 131 | Compagnon secouriste | Devenir un compagnon secouriste. | 10 | Secourisme 150 |
| 132 | Expert secouriste | Devenir expert secouriste. | 10 | Secourisme 225 |

Ils forment une série avec nos HF à 300 (Artisan cuisinier, Artisan pêcheur,
Artisan secouriste).

## 3. Oubliés par le premier croisement (11 HF)

Trouvés ensuite en relisant la catégorie Réputation.

### Réputations exaltées (9), statistique 377

| id | Nom | Description | Pts | Seuil |
| --- | --- | --- | --- | --- |
| 522 | Quelqu'un m'aime | Monter une réputation jusqu'à Exalté. | 10 | 1 |
| 523 | 5 réputations exaltées | Monter 5 réputations jusqu'à Exalté. | 10 | 5 |
| 524 | 10 réputations exaltées | Monter 10 réputations jusqu'à Exalté. | 10 | 10 |
| 521 | 15 réputations exaltées | Monter 15 réputations jusqu'à Exalté. | 10 | 15 |
| 520 | 20 réputations exaltées | Monter 20 réputations jusqu'à Exalté. | 10 | 20 |
| 519 | 25 réputations exaltées | Monter 25 réputations jusqu'à Exalté. | 10 | 25 |
| 518 | 30 réputations exaltées | Monter 30 réputations jusqu'à Exalté. | 10 | 30 |
| 1014 | 35 réputations exaltées | Être exalté auprès de 35 factions. | 10 | 35 |
| 1015 | 40 réputations exaltées | Être exalté auprès de 40 factions. | 10 | 40 |

Forever a 75 factions avec une réputation : 35 et 40 sont durs mais possibles.

### Ambassadeurs (2), réputation

| id | Nom | Description | Pts | Factions |
| --- | --- | --- | --- | --- |
| 948 | Ambassadeur de l'Alliance (Alliance) | Être exalté auprès des 5 races de sa faction. | 10 | 72, 47, 54, 69 |
| 762 | Ambassadeur de la Horde (Horde) | Être exalté auprès des 5 races de sa faction. | 10 | 76, 81, 68, 530 |

Adaptés : 4 races par camp sur Forever (pas d'Exodar ni de Lune-d'argent).
Chez nous, méta de 4 HF « exalté auprès de <capitale> », un par faction (pas
dans WotLK).

## Bilan

| Groupe | HF WotLK |
| --- | --- |
| Par statistique | 39 |
| Par API (réputation, métier) | 19 |
| Oubliés, ajoutés ensuite | 11 |
| **Total faisable** | **69** |

Tous sont faits dans HF Forever : 76 HF chez nous (id 97 à 172), les deux
« Une montagne de montures » n'en faisant qu'un, plus les 8 HF de capitale.

## Correspondance avec HF Forever

| WotLK | HF Forever |
| --- | --- |
| 546 | 97 |
| 1176, 1177, 1178, 1180, 1181 | 98 à 102 |
| 1182 | 103 |
| 2141, 2142, 2143 | 104 à 106 |
| 2536, 2537 | 107 |
| 238, 513, 515, 516, 512, 509, 239, 869, 870 | 108 à 116 |
| 1157 | 117 |
| 166, 167, 199, 200 | 118 à 121 |
| 154, 155, 157, 158 | 122 à 125 |
| 218, 219, 222 | 126 à 128 |
| 1556 à 1561 | 129 à 134 |
| 121, 122 | 135, 136 |
| 126, 127 | 137, 138 |
| 131, 132 | 139, 140 |
| 712, 713 | 141, 142 |
| 710, 711 | 143, 144 |
| 708, 709 | 145, 146 |
| 714, 907 | 147, 148 |
| 944, 946, 955, 956, 957 | 149 à 153 |
| 522, 523, 524, 521, 520, 519, 518, 1014, 1015 | 154 à 162 |
| 948, 762 | 163, 164 (capitales : 165 à 172) |

Sur les 829 lignes encore sans statut, les autres demandent des quêtes précises,
des objets, des sorts, des PNJ précis ou des conditions de combat : pas de
statistique Forever pour ça. Elles pourront passer en 🔴 ou devenir des HF « à
nous » détectés en direct (voir le Backlog).
