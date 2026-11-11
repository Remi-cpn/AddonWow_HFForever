# Liste des hauts faits proposée (v1)

Statut : **proposition à valider**. Annote directement ce fichier (barre, ajoute, commente), je reporterai tes changements dans `Data/*.lua`.

Légende de faisabilité :
- 🟢 API vérifiée dans le code exporté de Forever, détection rétroactive possible
- 🟡 API présente mais à confirmer en jeu (commandes en fin de document)
- 🔴 impossible à détecter (raison donnée)

Règles communes :
- HF communs Horde / Alliance, à l'échelle du compte : obtenu dès qu'**un** personnage remplit les conditions. Par défaut le meilleur personnage compte (`max`) ; les compteurs marqués `sum` additionnent les personnages (depuis l'étape 9a, 2026-11-11).
- Rétroactif : au chargement, l'addon lit l'état du personnage connecté. Un autre personnage déjà avancé débloque ses HF à sa prochaine connexion.
- Points : barème WotLK (10 standard, 25 pour les gros HF).
- Les icônes manquantes sur Forever seront signalées au chargement (vérification de l'étape 3) et remplacées.

Plages d'id : Général 1000, Quêtes 2000, Exploration 3000, Métiers 4000, Donjons 5000.

---

## 1. Général : niveaux (6 HF) 🟢

Détection : `UnitLevel("player")`, au chargement et sur l'événement `PLAYER_LEVEL_UP`.

| id | Nom | Description | Points |
|---|---|---|---|
| 1001 | Niveau 10 | Atteindre le niveau 10. | 10 |
| 1002 | Niveau 20 | Atteindre le niveau 20. | 10 |
| 1003 | Niveau 30 | Atteindre le niveau 30. | 10 |
| 1004 | Niveau 40 | Atteindre le niveau 40. | 10 |
| 1005 | Niveau 50 | Atteindre le niveau 50. | 10 |
| 1006 | Niveau 60 | Atteindre le niveau 60. | 25 |

## 2. Quêtes : nombre de quêtes terminées (5 HF) 🟢

Détection : statistique de Forever n° 98 « Quêtes achevées » (`GetStatistic(98)`), vérifiée en jeu (179, identique à l'onglet Statistiques).
On n'utilise pas `C_QuestLog.GetAllCompletedQuestIDs()` : il renvoyait 224 car il compte aussi des quêtes internes invisibles.

| id | Nom | Description | Points |
|---|---|---|---|
| 2001 | Aventurier | Terminer 50 quêtes. | 10 |
| 2002 | Aventurier aguerri | Terminer 100 quêtes. | 10 |
| 2003 | Aventurier émérite | Terminer 250 quêtes. | 10 |
| 2004 | Héros des quêtes | Terminer 500 quêtes. | 10 |
| 2005 | Légende des quêtes | Terminer 1000 quêtes. | 25 |

## 3. Exploration (46 HF) 🟢

Test B validé : Forêt d'Elwynn (1429, art 2153) entièrement explorée, 12 morceaux découverts en jeu = 12 dans les tables.

Détection : `C_MapExplorationInfo.GetExploredMapTextures(uiMapID)` renvoie les morceaux de carte **découverts**. Le nombre **total** de morceaux par zone vient des tables du jeu, extraites par OpenMap (`Data/Forever/Reveal.lua`, build 1.60.1). Une zone est explorée quand découverts = total.
Au chargement et sur l'événement `MAP_EXPLORATION_UPDATED`.
À confirmer : le comptage sur une zone que tu as entièrement explorée (test B).

Sous-catégories : Royaumes de l'Est, Kalimdor. L'île de Zephras est à la racine de la catégorie Exploration (elle n'est sur aucun continent).

Les id de carte des zones propres à Forever sont vérifiés en jeu (test E) : 2482 Mont Hyjal, 2521 Île de Zéphras, 2548 Rives Claires, 2652 Shen'dralas.

### Royaumes de l'Est (23 + 1)

Un HF « Explorer <zone> » (10 points) par zone :
Montagnes d'Alterac (1416), Hautes-terres d'Arathi (1417), Terres ingrates (1418), Terres foudroyées (1419), Clairières de Tirisfal (1420), Forêt des Pins-Argentés (1421), Maleterres de l'Ouest (1422), Maleterres de l'Est (1423), Contreforts de Hautebrande (1424), Les Hinterlands (1425), Dun Morogh (1426), Gorge des Vents brûlants (1427), Steppes ardentes (1428), Forêt d'Elwynn (1429), Défilé de Deuillevent (1430), Bois de la Pénombre (1431), Loch Modan (1432), Les Carmines (1433), Vallée de Strangleronce (1434), Marais des Chagrins (1435), Marche de l'Ouest (1436), Les Paluns (1437), **Rives Claires (2548, Forever, côte est)**.

Méta : **Explorateur des Royaumes de l'Est** : obtenir tous les HF ci-dessus. 25 points.

### Kalimdor (20 + 1)

Durotar (1411), Mulgore (1412), Les Tarides (1413), Teldrassil (1438), Sombrivage (1439), Orneval (1440), Mille pointes (1441), Les Serres-Rocheuses (1442), Désolace (1443), Féralas (1444), Marécage d'Âprefange (1445), Tanaris (1446), Azshara (1447), Gangrebois (1448), Cratère d'Un'Goro (1449), Reflet-de-Lune (1450), Silithus (1451), Berceau-de-l'Hiver (1452), **Mont Hyjal (2482, Forever, par le Berceau-de-l'Hiver)**, **Shen'dralas (2652, Forever, au sud de Désolace)**.

Méta : **Explorateur de Kalimdor**. 25 points.

### Île de Zephras (1)

Île de Zephras (2521). Zone de départ des Skyborne, **accessible uniquement avec un personnage Skyborne** : ce HF n'est obtenable que si tu en crées un. Il ne compte dans aucun méta.

### Méta global (1), ajouté le 2026-11-10

**Explorateur** (3300) : obtenir Explorateur des Royaumes de l'Est et Explorateur de Kalimdor. 50 points, comme « Explorateur » de WotLK. Sans l'île de Zéphras, pour rester obtenable par tous. Icône `INV_Misc_Map09` (celle de « Exploration d'Azeroth » sur Forever).

Les noms français exacts seront lus en jeu avec `C_Map.GetMapInfo(id).name` pour être identiques à ceux de ta carte.

Nouveau type de critère : `achievement` (« obtenir le HF n° X »), pour les métas. 🟢 (lecture de notre propre sauvegarde).

## 4. Métiers (15 HF) 🟢

Test C validé : `GetProfessionInfo` renvoie bien rang et id (Forge 164, Minage 186, Secourisme 129, Pêche 356, Cuisine 185, identiques au tableau). Le « rang max » renvoyé est le plafond actuel du personnage (150 en Compagnon), on se base donc uniquement sur le rang.

Détection : `GetProfessions()` puis `GetProfessionInfo(index)` (rang et `skillLine`), au chargement et sur `SKILL_LINES_CHANGED`. On identifie le métier par son **id de ligne de compétence**, pas par son nom.
À confirmer : les id sur Forever (test C).
D'après les guides, le maximum est bien 300 sur Forever (rangs 75 / 150 / 225 / 300), et aucun métier propre aux Skyborne n'est mentionné (ils ont seulement leurs maîtres de métier sur Zephras).

| id | Nom | Description | Points |
|---|---|---|---|
| 4001 | Compagnon | Atteindre 150 dans un métier principal. | 10 |
| 4002 | Expert | Atteindre 225 dans un métier principal. | 10 |
| 4003 | Artisan | Atteindre 300 dans un métier principal. | 10 |
| 4011 | Maître alchimiste | Atteindre 300 en Alchimie (171). | 10 |
| 4012 | Maître forgeron | Atteindre 300 en Forge (164). | 10 |
| 4013 | Maître enchanteur | Atteindre 300 en Enchantement (333). | 10 |
| 4014 | Maître ingénieur | Atteindre 300 en Ingénierie (202). | 10 |
| 4015 | Maître herboriste | Atteindre 300 en Herboristerie (182). | 10 |
| 4016 | Maître travailleur du cuir | Atteindre 300 en Travail du cuir (165). | 10 |
| 4017 | Maître mineur | Atteindre 300 en Minage (186). | 10 |
| 4018 | Maître dépeceur | Atteindre 300 en Dépeçage (393). | 10 |
| 4019 | Maître tailleur | Atteindre 300 en Couture (197). | 10 |
| 4021 | Grand chef | Atteindre 300 en Cuisine (185). | 10 |
| 4022 | Maître pêcheur | Atteindre 300 en Pêche (356). | 10 |
| 4023 | Maître secouriste | Atteindre 300 en Secourisme (129). | 10 |

## 5. Donjons (26 HF) 🟢

Détection : statistiques de Forever, catégorie « Boss » (14821), « Morts de <boss> » ≥ 1. Vérifié en jeu : Bazzalan (Ragefeu) vaut 1, donc rétroactif.
Le registre vérifiera au chargement que chaque id de statistique existe encore (ligne rouge sinon).
Un HF à 10 points par donjon. Sous-catégories : Classiques, Forever.

### Classiques (21)

| id | Donjon | Boss (statistique) |
|---|---|---|
| 5001 | Gouffre de Ragefeu | Bazzalan (15027) |
| 5002 | Les Mortemines | Edwin VanCleef (63570) |
| 5003 | Cavernes des Lamentations | Mutanus le Dévoreur (15028) |
| 5004 | Donjon d'Ombrecroc | Archimage Arugal (1092) |
| 5005 | La Prison de Hurlevent | Bazil Thredd (15029) |
| 5006 | Profondeurs de Brassenoire | Aku'mai (6137) |
| 5007 | Gnomeregan | Mekgénieur Thermojoncteur (6140) |
| 5008 | Kraal de Tranchebauge | Charlga Trancheflanc (6139) |
| 5009 | Salles Écarlates | Tisseur de flammes Koegler (6786) |
| 5010 | Monastère écarlate | Commandant écarlate Mograine (1093) |
| 5011 | Souilles de Tranchebauge | Amnennar le Porte-Froid (6141) |
| 5012 | Uldaman | Archaedas (6142) |
| 5013 | Zul'Farrak | Chef Ukorz Scalpessable (1094) |
| 5014 | Maraudon | Princesse Theradras (6143) |
| 5015 | Temple englouti | Ombre d'Eranikus (6144) |
| 5016 | Profondeurs de Rochenoire | Empereur Dagran Thaurissan (1095) |
| 5017 | Hache-Tripes | Roi Gordok (6146) |
| 5018 | Pic Rochenoire inférieur | Seigneur Wyrmthalak (6145) |
| 5019 | Pic Rochenoire supérieur | Général Drakkisath (1096) |
| 5020 | Scholomance | Sombre maître Gandling (15030) |
| 5021 | Stratholme | Baron Vaillefendre (15031) |

Le Monastère écarlate n'a que 2 statistiques côté Forever (Salles Écarlates et Mograine) : pas de Cimetière ni d'Armurerie séparés.

### Forever (5 avec statistique)

| id | Donjon | Boss (statistique) |
|---|---|---|
| 5101 | Salle des Thanes | Durgen Mornemartel (63573) |
| 5102 | Ruines de Lordaeron | Rath'mael (63571) |
| 5103 | Cité de Dalaran | Ombre de l'archimage (63572), boss final |
| 5104 | Prison d'Alcaz | Rugiflamme (63575) |
| 5105 | Terrasse du Façonneur | Nanaya (63574) |

Cité de Dalaran : l'Ombre de l'archimage est le boss final (sommet de la Citadelle pourpre). Lyn l'Ignoré (63589) est un boss **optionnel**, invoqué avec le *Tome of Dalaran* : pas de HF en v1.

### 🔴 Sans statistique : reportés après la v1

Excavation Site: Wetlands, The Drowned City, Krol'dok Stronghold, Blackmaw Hold n'ont **aucune** statistique de boss sur Forever. Seule solution : l'événement `ENCOUNTER_END`, qui ne détecte que les **prochains** boss tués (pas rétroactif) et doit encore être vérifié avec les restrictions Midnight. Proposition : les ajouter dans une version suivante avec un type de critère `encounter`.

### Raids : hors v1

Les statistiques contiennent aussi Onyxia (1098), le roi sauvage (Sommet d'Hyjal, 63580) et Sonya Sanctombre (Profondeurs des Saisons, 63581). Ils serviront pour une catégorie Raids plus tard.

---

# Étape 9b : ajouts proposés à partir des statistiques (2026-11-11)

Statut : **proposition à valider**. Source : [WagoStatistics.md](WagoStatistics.md). Barre, change les paliers, les noms ou les points, je reporterai.

- Colonne « Comb. » : `sum` additionne les personnages, `max` garde le meilleur.
- Descriptions des `sum` : je propose d'ajouter « (tous personnages confondus) » à l'affichage, à valider.
- Icônes : choisies à l'écriture du code parmi celles qui existent sur Forever, vérifiées au chargement comme aujourd'hui.
- 🟡 = à vérifier en jeu avant de coder (commandes en bas de section).

Nouvelles catégories et plages d'id :

| Catégorie | id | Plage d'id |
| --- | --- | --- |
| Général > Richesse | 11 | 1100 |
| Général > Collections | 12 | 1200 |
| Général > Voyages | 13 | 1300 |
| Général > Vie quotidienne | 14 | 1400 |
| Général > Social | 15 | 1500 |
| JcJ | 6 | 6000 |
| JcJ > Champs de bataille | 61 | 6100 |
| Combat > Victimes | 71 | 7000 |
| Combat > Morts | 72 | 7100 |
| Réputation | 8 | 8000 |
| Donjons > Raids | 53 | 5200 |

Les niveaux (1001 à 1006) restent à la racine de Général.

## 9b.1 Quêtes (4 HF) 🟢

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 2006 | Infatigable | Terminer 2 500 quêtes. | 98 | `sum` | 25 |
| 2007 | Mémoire d'Azeroth | Terminer 5 000 quêtes. | 98 | `sum` | 25 |
| 2011 | Pas pour moi | Abandonner 10 quêtes. | 94 | `sum` | 10 |
| 2012 | Indécis | Abandonner 100 quêtes. | 94 | `sum` | 10 |

## 9b.2 Général > Richesse (11 HF) 🟡 format de l'or

Les statistiques d'or ne sont pas un simple nombre (voir le test en bas). Nouveau type de critère `money` avec une valeur en pièces d'or. Les autres (329, 330, 1149) sont des compteurs normaux 🟢.

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 1101 | Bourse garnie | Obtenir 100 pièces d'or au total. | 328 | `sum` | 10 |
| 1102 | Coffres pleins | Obtenir 1 000 pièces d'or au total. | 328 | `sum` | 10 |
| 1103 | Magnat | Obtenir 10 000 pièces d'or au total. | 328 | `sum` | 25 |
| 1111 | Fouille-poches | Ramasser 100 pièces d'or sur des monstres. | 333 | `sum` | 10 |
| 1112 | Détrousseur | Ramasser 1 000 pièces d'or sur des monstres. | 333 | `sum` | 10 |
| 1121 | Marchand | Mettre 10 objets en vente à l'hôtel des ventes. | 329 | `sum` | 10 |
| 1122 | Commissaire-priseur | Mettre 100 objets en vente à l'hôtel des ventes. | 329 | `sum` | 10 |
| 1123 | Acheteur compulsif | Acheter 100 objets à l'hôtel des ventes. | 330 | `sum` | 10 |
| 1131 | Changement de cap | Réinitialiser ses talents. | 1149 | `sum` | 10 |
| 1141 | Petit pécule | Posséder 100 pièces d'or en même temps. | 334 | `max` | 10 |
| 1142 | Fortune | Posséder 1 000 pièces d'or en même temps. | 334 | `max` | 25 |

## 9b.3 Général > Collections (8 HF) 🟡

À vérifier : que 339 / 338 comptent bien les montures et mascottes de Forever.

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 1201 | En selle | Obtenir une monture. | 339 | `max` | 10 |
| 1202 | Écurie | Obtenir 10 montures. | 339 | `max` | 10 |
| 1203 | Grande écurie | Obtenir 25 montures. | 339 | `max` | 25 |
| 1211 | Un ami fidèle | Obtenir une mascotte. | 338 | `max` | 10 |
| 1212 | Ménagerie | Obtenir 10 mascottes. | 338 | `max` | 10 |
| 1213 | Zoo ambulant | Obtenir 25 mascottes. | 338 | `max` | 25 |
| 1221 | Violet ! | Obtenir 10 objets épiques. | 342 | `sum` | 10 |
| 1222 | Légende vivante | Obtenir un objet légendaire. | 336 | `sum` | 25 |

## 9b.4 Général > Voyages (8 HF) 🟢

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 1301 | Passager | Emprunter 10 trajets aériens. | 349 | `sum` | 10 |
| 1302 | Habitué des airs | Emprunter 100 trajets aériens. | 349 | `sum` | 10 |
| 1303 | Grand voyageur | Emprunter 500 trajets aériens. | 349 | `sum` | 25 |
| 1311 | Retour au bercail | Utiliser 10 fois la pierre de foyer. | 353 | `sum` | 10 |
| 1312 | Casanier | Utiliser 100 fois la pierre de foyer. | 353 | `sum` | 10 |
| 1313 | Il n'y a rien de tel que son foyer | Utiliser 500 fois la pierre de foyer. | 353 | `sum` | 10 |
| 1321 | Raccourci | Emprunter 10 portails de mage. | 350 | `sum` | 10 |
| 1331 | On m'appelle | Accepter 10 invocations. | 2277 | `sum` | 10 |

## 9b.5 Général > Vie quotidienne (16 HF) 🟢 (campements 🟡)

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 1401 | Bon appétit | Manger 100 fois. | 347 | `sum` | 10 |
| 1402 | Gourmand | Manger 1 000 fois. | 347 | `sum` | 10 |
| 1411 | Désaltéré | Boire 100 fois. | 346 | `sum` | 10 |
| 1412 | Assoiffé | Boire 1 000 fois. | 346 | `sum` | 10 |
| 1421 | Une petite gorgée | Boire 10 potions de soins. | 345 | `sum` | 10 |
| 1422 | Accro aux potions | Boire 100 potions de soins. | 345 | `sum` | 10 |
| 1423 | Esprit clair | Boire 10 potions de mana. | 922 | `sum` | 10 |
| 1424 | Puits de mana | Boire 100 potions de mana. | 922 | `sum` | 10 |
| 1431 | Premiers secours | Utiliser 100 bandages. | 344 | `sum` | 10 |
| 1432 | Pierre de vie | Utiliser 10 pierres de soins. | 812 | `sum` | 10 |
| 1433 | Alchimie appliquée | Consommer 50 élixirs. | 923 | `sum` | 10 |
| 1434 | Préparé pour le raid | Consommer 10 flacons. | 811 | `sum` | 10 |
| 1441 | Campeur | Établir 10 campements. | 64222 | `sum` | 10 |
| 1442 | Vie sauvage | Établir 50 campements. | 64222 | `sum` | 10 |
| 1451 | Besoin ! | Faire 100 jets de besoin sur du butin. | 1044 | `sum` | 10 |
| 1452 | Cupidité | Faire 100 jets de cupidité sur du butin. | 1043 | `sum` | 10 |

## 9b.6 Général > Social (7 HF) 🟡 emotes avec cible ?

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 1501 | Câlin gratuit | Faire 10 câlins. | 1042 | `sum` | 10 |
| 1502 | Bon public | Rire 10 fois (/mdr). | 1066 | `sum` | 10 |
| 1503 | Supporter | Acclamer 10 fois. | 1045 | `sum` | 10 |
| 1504 | Salut ! | Faire 10 signes de la main. | 1065 | `sum` | 10 |
| 1505 | Consterné | Utiliser 10 fois /consternant. | 1047 | `sum` | 10 |
| 1506 | Le plus petit violon du monde | S'apitoyer 10 fois. | 1067 | `sum` | 10 |
| 1511 | Expressif | Obtenir les 6 HF ci-dessus (méta). | - | - | 10 |

## 9b.7 JcJ (12 HF) 🟢

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 6001 | Une victoire honorable | Obtenir une victoire honorable. | 588 | `sum` | 10 |
| 6002 | 100 victoires honorables | Obtenir 100 victoires honorables. | 588 | `sum` | 10 |
| 6003 | 1 000 victoires honorables | Obtenir 1 000 victoires honorables. | 588 | `sum` | 10 |
| 6004 | 5 000 victoires honorables | Obtenir 5 000 victoires honorables. | 588 | `sum` | 25 |
| 6005 | 10 000 victoires honorables | Obtenir 10 000 victoires honorables. | 588 | `sum` | 25 |
| 6011 | En garde | Gagner un duel. | 319 | `sum` | 10 |
| 6012 | Duelliste | Gagner 10 duels. | 319 | `sum` | 10 |
| 6013 | Maître duelliste | Gagner 100 duels. | 319 | `sum` | 25 |
| 6014 | Mauvais perdant | Perdre 10 duels. | 320 | `sum` | 10 |
| 6021 | Coup de grâce | Porter 100 coups fatals. | 1487 | `sum` | 10 |
| 6022 | Exécuteur | Porter 1 000 coups fatals. | 1487 | `sum` | 10 |
| 6023 | Bourreau | Porter 10 000 coups fatals. | 1487 | `sum` | 25 |

## 9b.8 JcJ > Champs de bataille (20 HF) 🟢

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 6101 | Baptême du feu | Participer à un champ de bataille. | 839 | `sum` | 10 |
| 6102 | Habitué des champs de bataille | Participer à 100 champs de bataille. | 839 | `sum` | 10 |
| 6103 | Vétéran des champs de bataille | Participer à 500 champs de bataille. | 839 | `sum` | 25 |
| 6111 | Première victoire | Gagner un champ de bataille. | 840 | `sum` | 10 |
| 6112 | Cent victoires | Gagner 100 champs de bataille. | 840 | `sum` | 10 |
| 6121 | Vainqueur de la vallée d'Alterac | Gagner la vallée d'Alterac. | 49 | `sum` | 10 |
| 6122 | Vainqueur du bassin Arathi | Gagner le bassin Arathi. | 51 | `sum` | 10 |
| 6123 | Vainqueur du goulet des Chanteguerres | Gagner le goulet des Chanteguerres. | 105 | `sum` | 10 |
| 6124 | Vainqueur des îles des Sombrelances | Gagner les îles des Sombrelances. | 64176 | `sum` | 10 |
| 6125 | Maître des champs de bataille | Obtenir les 4 HF ci-dessus (méta). | - | - | 25 |
| 6131 | Porte-drapeau | Capturer un drapeau dans le goulet des Chanteguerres. | 395 | `sum` | 10 |
| 6132 | Voleur de drapeaux | Capturer 10 drapeaux dans le goulet des Chanteguerres. | 395 | `sum` | 10 |
| 6133 | Gardien du drapeau | Ramener 10 drapeaux dans le goulet des Chanteguerres. | 586 | `sum` | 10 |
| 6134 | Preneur de tours | Capturer 10 tours dans la vallée d'Alterac. | 394 | `sum` | 10 |
| 6135 | Défenseur des tours | Défendre 10 tours dans la vallée d'Alterac. | 393 | `sum` | 10 |
| 6136 | Assaut sur Arathi | Attaquer 10 bases dans le bassin Arathi. | 64348 | `sum` | 10 |
| 6137 | Défense d'Arathi | Défendre 10 bases dans le bassin Arathi. | 64349 | `sum` | 10 |
| 6138 | Assaut sur les Sombrelances | Attaquer 10 bases sur les îles des Sombrelances. | 64350 | `sum` | 10 |
| 6139 | Défense des Sombrelances | Défendre 10 bases sur les îles des Sombrelances. | 64351 | `sum` | 10 |
| 6140 | Drapeaux des Sombrelances | Capturer 10 drapeaux sur les îles des Sombrelances. | 64352 | `sum` | 10 |

## 9b.9 Combat > Victimes (16 HF) 🟢 (records 🟡 paliers)

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 7001 | Chasseur | Tuer 1 000 créatures. | 107 | `sum` | 10 |
| 7002 | Traqueur | Tuer 10 000 créatures. | 107 | `sum` | 10 |
| 7003 | Fléau des terres sauvages | Tuer 50 000 créatures. | 107 | `sum` | 25 |
| 7004 | Exterminateur | Tuer 100 000 créatures. | 107 | `sum` | 25 |
| 7011 | Pas les lapins ! | Tuer 10 bestioles. | 108 | `sum` | 10 |
| 7012 | Ennemi des bestioles | Tuer 100 bestioles. | 108 | `sum` | 10 |
| 7013 | Cauchemar des bestioles | Tuer 1 000 bestioles. | 108 | `sum` | 10 |
| 7021 | Naturaliste | Tuer tous les types de créatures (nombre à vérifier). | 1337 | `max` | 10 |
| 7031 | Gros coup | Infliger 1 000 points de dégâts en un coup. | 193 | `max` | 10 |
| 7032 | Coup dévastateur | Infliger 2 500 points de dégâts en un coup. | 193 | `max` | 10 |
| 7033 | Grand soin | Rendre 1 000 points de vie en un soin. | 189 | `max` | 10 |
| 7034 | Soin miraculeux | Rendre 2 500 points de vie en un soin. | 189 | `max` | 10 |
| 7041 | Destructeur | Infliger 1 million de points de dégâts. | 197 | `sum` | 10 |
| 7042 | Anéantisseur | Infliger 10 millions de points de dégâts. | 197 | `sum` | 25 |
| 7043 | Guérisseur | Rendre 1 million de points de vie. | 198 | `sum` | 10 |
| 7044 | Main de la vie | Rendre 10 millions de points de vie. | 198 | `sum` | 25 |

## 9b.10 Combat > Morts (10 HF) 🟢

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 7101 | Ça arrive | Mourir 10 fois. | 60 | `sum` | 10 |
| 7102 | Habitué du cimetière | Mourir 100 fois. | 60 | `sum` | 10 |
| 7103 | Ami des esprits soigneurs | Mourir 500 fois. | 60 | `sum` | 10 |
| 7111 | Respirer, c'est surfait | Mourir noyé. | 112 | `sum` | 10 |
| 7112 | Loi de la gravité | Mourir d'une chute. | 114 | `sum` | 10 |
| 7113 | Ça brûle ! | Mourir dans le feu ou la lave. | 115 | `sum` | 10 |
| 7114 | Trop loin du rivage | Mourir de fatigue. | 113 | `sum` | 10 |
| 7115 | Victime de Lardeur | Être tué par Lardeur. | 594 | `sum` | 10 |
| 7121 | Revenu de loin | Être ressuscité par un prêtre, un druide, un chaman, un paladin et une pierre d'âme (5 critères : 796, 798, 799, 800, 801). | - | `sum` | 10 |
| 7131 | Mort en donjon | Mourir 50 fois en donjon à 5. | 918 | `sum` | 10 |

## 9b.11 Réputation (6 HF) 🟡 paliers

`max` obligatoire : la même faction sur deux personnages compterait deux fois.

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 8001 | Exalté | Être exalté auprès d'une faction. | 377 | `max` | 10 |
| 8002 | Bien vu partout | Être exalté auprès de 5 factions. | 377 | `max` | 10 |
| 8003 | Ambassadeur | Être exalté auprès de 10 factions. | 377 | `max` | 25 |
| 8011 | Respecté | Être honoré auprès de 10 factions. | 529 | `max` | 10 |
| 8012 | Révéré | Être révéré auprès de 5 factions. | 378 | `max` | 10 |
| 8021 | Diplomate | Rencontrer 25 factions. | 931 | `max` | 10 |

## 9b.12 Donjons et raids (12 HF)

### Raids (3) 🟡 boss finaux à confirmer

| id | Nom | Boss (statistique) | Comb. | Pts |
|---|---|---|---|---|
| 5201 | Repaire d'Onyxia | Onyxia (1098) | `max` | 10 |
| 5202 | Sommet d'Hyjal | Le roi sauvage (63580) | `max` | 10 |
| 5203 | Profondeurs des Saisons | Sonya Sanctombre (63581) | `max` | 10 |

### Forever (2) 🟡

| id | Nom | Description | Stat | Pts |
|---|---|---|---|---|
| 5106 | Les gardiens de la terrasse | Vaincre Braise, Fulguro et Serre-neigeuse sur la terrasse du Façonneur. | 63590, 63592, 63593 | 10 |
| 5107 | L'ignoré | Vaincre Lyn l'Ignoré dans la cité de Dalaran. | 63589 | 10 |

### Entrées (7) 🟢 (raids 🟡 tailles existantes sur Forever)

À la racine de Donjons.

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 5301 | Explorateur de donjons | Entrer 10 fois dans un donjon à 5. | 932 | `sum` | 10 |
| 5302 | Habitué des donjons | Entrer 50 fois dans un donjon à 5. | 932 | `sum` | 10 |
| 5303 | Pilier de donjon | Entrer 100 fois dans un donjon à 5. | 932 | `sum` | 10 |
| 5304 | Vétéran des donjons | Entrer 250 fois dans un donjon à 5. | 932 | `sum` | 25 |
| 5311 | Premier raid à 10 | Entrer dans un raid à 10. | 933 | `sum` | 10 |
| 5312 | Premier raid à 20 | Entrer dans un raid à 20. | 934 | `sum` | 10 |
| 5313 | Premier raid à 40 | Entrer dans un raid à 40. | 64184 | `sum` | 10 |

## 9b.13 Métiers (7 HF) 🟢 (recettes 🟡 nombre total)

| id | Nom | Description | Stat | Comb. | Pts |
|---|---|---|---|---|---|
| 4031 | Pêcheur du dimanche | Pêcher 100 poissons. | 1518 | `sum` | 10 |
| 4032 | Pêcheur aguerri | Pêcher 1 000 poissons. | 1518 | `sum` | 10 |
| 4033 | Roi de la pêche | Pêcher 5 000 poissons. | 1518 | `sum` | 25 |
| 4041 | Livre de recettes | Connaître 25 recettes de cuisine. | 1745 | `max` | 10 |
| 4042 | Cordon-bleu | Connaître 50 recettes de cuisine. | 1745 | `max` | 10 |
| 4051 | Désenchanteur | Désenchanter 100 objets. | 181 | `sum` | 10 |
| 4052 | Briseur d'enchantements | Désenchanter 1 000 objets. | 181 | `sum` | 10 |

## 9b : à vérifier en jeu avant de coder

Une seule commande, qui affiche la valeur brute (texte) des statistiques 🟡 sur le personnage connecté :

```
./run for _,id in ipairs({328,333,334,339,338,64222,1042,193,189,1337,377,931,1745,933,934,64184}) do print(id, select(2,GetAchievementInfo(id)), GetStatistic(id)) end
```

Ce que je regarde :
- 328 / 333 / 334 : format de l'or (icônes de pièces ? séparateurs ?) pour le type `money` ;
- 339 / 338 : nombre de montures et mascottes, à comparer avec ton journal ;
- 64222 : à quoi correspondent les « campements » de Forever ;
- 1042 : refais un `/calin` sans cible puis avec une cible, et relance la commande, pour savoir si le compteur bouge dans les deux cas ;
- 193 / 189 : tes records, pour régler les paliers 7031 à 7034 ;
- 1337, 377, 931, 1745 : pour régler les paliers ;
- 933 / 934 / 64184 : quelles tailles de raid existent.

Total 9b : 4 + 11 + 8 + 8 + 16 + 7 + 12 + 20 + 16 + 10 + 6 + 12 + 7 = **137 HF**, soit 233 avec la v1.

---

## Total

6 + 5 + 45 + 15 + 24 = **95 HF** (98 au départ, 3 retirés après les tests en jeu, voir ci-dessous).

## 🔴 Retirés après les tests en jeu

| id | HF | Raison |
|---|---|---|
| 3116 | Explorer Reflet-de-Lune | Sa carte (art 2175) n'a qu'un morceau, que le jeu considère découvert sans y être allé. Retiré aussi du méta Kalimdor. Piste future : `C_MapExplorationInfo.GetExploredAreaIDsAtPosition`. |
| 5001 | Gouffre de Ragefeu | La statistique 15027 (Bazzalan) est passée à 1 en finissant la salle des Thanes, sans jamais faire Ragefeu. Hypothèse : Forever compte le premier donjon de l'Alliance dans le compteur de celui de la Horde. |
| 5101 | Salle des Thanes | Sa statistique 63573 (Durgen) reste à 0 après le donjon terminé. |

Ces id sont réservés et ne doivent pas être réutilisés.

Nouveaux types de critères à créer : `statistic` (quêtes, donjons), `explore`, `profession`, `achievement` (métas).
