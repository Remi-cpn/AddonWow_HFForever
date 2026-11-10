# Hauts faits retail et Forever (wago.tools)

Relevé du 2026-11-09. Version en ligne : https://claude.ai/artifact/Dmmq7pxdpYRgcgvuceCXYz

wago.tools publie les tables de données du jeu (DB2) de chaque build, y compris
celui de notre client Forever (`wowf` 1.60.1.70862). Rien n'est lu dans les
fichiers du jeu : tout vient du site.

## Source

| Table | Contenu | Lien (CSV, français) |
| --- | --- | --- |
| Achievement | un haut fait par ligne : id, nom, description, catégorie, points, icône (FileDataID), faction, arbre de critères | [retail 12.1.5](https://wago.tools/db2/Achievement/csv?locale=frFR) · [Forever](https://wago.tools/db2/Achievement/csv?build=1.60.1.70862&locale=frFR) |
| Achievement_Category | catégories : id, nom, catégorie mère | [retail](https://wago.tools/db2/Achievement_Category/csv?locale=frFR) · [Forever](https://wago.tools/db2/Achievement_Category/csv?build=1.60.1.70862&locale=frFR) |
| CriteriaTree | arbre des critères de chaque haut fait (texte, quantité demandée) | [Forever](https://wago.tools/db2/CriteriaTree/csv?build=1.60.1.70862&locale=frFR) |
| Criteria | ce que mesure chaque critère : un type et une cible (asset) | [Forever](https://wago.tools/db2/Criteria/csv?build=1.60.1.70862) |

Types de critères rencontrés :
- 0 : tuer une créature (asset = id du PNJ) ;
- 5 : atteindre un niveau ;
- 7 : rang de métier ;
- 8 : obtenir un autre haut fait ;
- 27 : terminer une quête ;
- 43 : explorer une zone ;
- 243 : réputation.

Les lignes dont le champ `Flags` contient le bit 1 sont des statistiques.

Les builds sont listés sur https://wago.tools/api/builds/latest : `wow`
12.1.5.70783 (retail, 4 novembre 2026) et `wowf` 1.60.1.70862 (Forever,
7 novembre 2026).

## Chiffres

- **Retail** : 14 281 lignes, dont 2 115 statistiques, soit 12 166 hauts faits.
- **Forever** : 495 lignes, dont 207 statistiques, 112 cachés (tests,
  « DNT », « Masqué ») et 65 en double copie. Il reste 111 hauts faits
  visibles, ce qui correspond au total de 111 relevé en jeu à l'étape 0.

| Catégorie Forever | Hauts faits visibles |
| --- | --- |
| Exploration et Aventure | 48 |
| Classes | 27 |
| Artisanat | 18 |
| JcJ | 12 |
| Donjons | 3 |
| Raids | 3 |

## Hauts faits natifs de Forever et équivalents retail

Tous valent 0 point sauf Onyxia (1 point). Chacun existe en deux copies aux
`Flags` différents (ids 61xxx-62xxx et 63969-64033), et une seule apparaît en
jeu.

| Catégorie Forever | Hauts faits (id de la 1re copie) | Nombre | Équivalent retail |
| --- | --- | --- | --- |
| Exploration, Royaumes de l'Est | une zone par HF : 627 Dun Morogh, 760 à 782, 802, 841, 62354 Rives Claires ; méta 62353 | 24 | mêmes ids de zone, méta 42 (25 pts) |
| Exploration, Kalimdor | 728 Durotar à 857, dont 855 Reflet-de-Lune, plus 62356 Mont Hyjal et 63684 Shen'dralas ; méta 62355 | 21 | mêmes ids, méta 43 (25 pts) |
| Aventure | 62053 Exploration d'Azeroth (les 2 métas), 62382 Exploration, 62054 Seigneur Valthalak tué (quête) | 3 | 46 Exploration de l'univers |
| Classes | Novice / Expérimenté / Expert = niveau 25 / 45 / 60 pour chacune des 9 classes (61499 à 62011) | 27 | Niveau 10 à 60 : 6, 7, 8, 9, 14782, 14783 (toutes classes) |
| Artisanat | 150 / 225 / 300 en alchimie, forge, enchantement, ingénierie, travail du cuir, couture (62012 à 62030) | 18 | 116, 731, 732 (n'importe quel métier à 150 / 225 / 300) |
| Donjons | 62031 Spéléologue novice (6 donjons), 62032 expérimenté (10), 62033 expert (17) | 3 | un HF par donjon, 628 à 646 |
| Raids | 684 Conquête du repaire (Onyxia), 62034 Conquête de la nature sauvage (13 boss du sommet d'Hyjal), 62035 Conquête des profondeurs (8 boss des profondeurs des Saisons) | 3 | 684, 686 Cœur du Magma, 685 Aile noire, 689 et 687 Ahn'Qiraj |
| JcJ | Rang 3, 7, 10, 13, 14 (62041 à 62045) ; maîtrise des 4 champs de bataille, exalté (62046 à 62049) ; Champ d'honneur semaines 4, 7, 10 (63340 à 63342) | 12 | catégories Vallée d'Alterac, Bassin Arathi, Goulet |

Donjons demandés par les trois Spéléologues, y compris ceux propres à Forever :

- **Novice** : Ragefeu ou salle des Thanes, Ruines de Lordaeron, Cavernes des
  Lamentations, Mortemines, Donjon d'Ombrecroc, Excavations : les Paluns.
- **Expérimenté** : Cité de Dalaran, Brassenoire, Gnomeregan, La cité
  Submergée, les 4 ailes du Monastère Écarlate, Kraal de Tranchebauge, Bastion
  Krol'dok.
- **Expert** : Souilles, Uldaman, Zul'Farrak, Maraudon, Prison d'Alcaz,
  Atal'Hakkar, Profondeurs de Rochenoire, Repaire des Noiregueules, Bas et
  Sommet du pic Rochenoire, Scholomance, Stratholme (2 côtés), Hache-Tripes
  (3 ailes), La terrasse du Façonneur.

Retail a d'autres hauts faits vanilla, sans équivalent sur Forever :
- quêtes achevées, de 503 à 507 (50 à 1 000) ;
- réputations exaltées, à partir de 522, plus l'Aube d'argent 946 et les Hydraxiens 955 ;
- métas des évènements mondiaux : 913, 1693, 1683, 1656, 1691.

## Comparaison avec HF Forever

Notre exploration (45 HF) fait doublon avec celle de Blizzard sur Forever. Nos
niveaux, nos quêtes et nos boss par donjon n'existent pas dans le jeu.

| Catégorie HF Forever | Ce que Forever a déjà | Différence |
| --- | --- | --- |
| Général (niveaux 10 à 60) | niveaux 25 / 45 / 60 par classe | nos paliers ne dépendent pas de la classe : pas de doublon |
| Quêtes (50 à 1 000) | rien | n'existe que chez nous |
| Exploration | les mêmes 43 zones, plus 2 métas et Exploration d'Azeroth | doublon. Forever inclut Reflet-de-Lune, que nous avons retiré (il détecte les sous-zones, type 43, pas les morceaux de carte). Forever n'a pas l'île de Zéphras |
| Métiers | 6 métiers d'artisanat à 150 / 225 / 300 | doublon partiel. Nous avons en plus « n'importe quel métier », la récolte et les métiers secondaires |
| Donjons | 3 HF par palier de donjons | nous faisons un HF par donjon (dernier boss) : pas de doublon |
| Raids, JcJ | 3 raids, 12 JcJ | pas encore chez nous (Backlog) |

Ce que la table Forever peut nous apporter, sans rien importer :

- **Icônes sûres** : les `IconFileID` de la table Forever sont forcément dans
  le client. Par exemple 4504543 Spéléologue novice, 254650 Onyxia, 237388
  Exploration d'Azeroth, 236755 Dun Morogh. Cela règle nos icônes manquantes.
- **Noms officiels** des donjons et boss propres à Forever, avec l'id du PNJ à
  vaincre : utile pour le type `encounter` du Backlog.
- **Id des sous-zones** de chaque exploration (critère de type 43) : une autre
  façon de détecter, qui réglerait Reflet-de-Lune.

## Décision (2026-11-10)

On garde nos hauts faits, exploration comprise, et on ne tient pas compte de
ceux de Forever : pas de lien entre les deux, pas de métas appuyés sur les
hauts faits Blizzard. Les questions sur `GetAchievementInfo(62031)` et sur
les deux copies sont donc sans objet.

Ce document reste une source de noms, d'icônes (`IconFileID`) et d'id de
PNJ pour nos propres hauts faits.
