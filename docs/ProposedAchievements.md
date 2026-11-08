# Liste des hauts faits proposée (v1)

Statut : **proposition à valider**. Annote directement ce fichier (barre, ajoute, commente), je reporterai tes changements dans `Data/*.lua`.

Légende de faisabilité :
- 🟢 API vérifiée dans le code exporté de Forever, détection rétroactive possible
- 🟡 API présente mais à confirmer en jeu (commandes en fin de document)
- 🔴 impossible à détecter (raison donnée)

Règles communes :
- HF communs Horde / Alliance, à l'échelle du compte : obtenu dès qu'**un** personnage remplit les conditions. Les progressions ne s'additionnent pas entre personnages (le meilleur personnage compte).
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
