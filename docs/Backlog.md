# Idées et travaux reportés

Ce qui a été décidé pour « plus tard ». Mis à jour le 2026-11-22, pour la
publication de la 1.3.0.

## Entre joueurs
- Inspection en comparaison sur deux colonnes (lui et moi), comme Blizzard. La 1.3.0 n'a que la consultation en lecture seule.
- Progression du joueur inspecté (conditions, barres) : la 1.3.0 ne partage que les hauts faits obtenus et leur date (`Core/Comm.lua`, message `DAT`).
- Nombre de hauts faits dans l'infobulle : il est déjà envoyé (`SUM`), seuls les points sont affichés.

## Rares
- Prêtresse d'Elune (12116, Berceau-de-l'Hiver) : exclue en 1.3.0 car Questie la marque « AH », mais son modèle de faction (32) est neutre, donc attaquable. Question en attente : la remettre dans le 268.
- À vérifier en jeu : les deux Grand général Abbendis (10828 et 243893, Maleterres de l'Est), les trois champions de l'arène de Hache-Tripes (un seul à la fois), Jade, Bruissangoisse et le Duc Ravarage (connus de RareScanner seul), le camp des rares propres à Forever (Hyjal, Rives Claires, donjons).
- Détection en instance : la mort en cible peut être illisible (valeurs secrètes) ; la fouille du cadavre sert de secours.

## Interface
- Nom affiché de l'addon : « HF » ne parle qu'aux francophones. Piste : « Hall of Fame Forever » (garde les initiales HF). Le nom « Achievements Forever » est déjà pris par un autre addon.
- Logo à retravailler (`docs/HFForever_Logo.png`, `Media/HFForever_Icon.tga`) : acceptable, pas parfait.
- Toasts déplaçables (position sauvegardée), en plus de la position par défaut au-dessus des alertes Blizzard.
- Autres langues que le français et l'anglais : un `Locales/xxXX.lua` sur le modèle de `frFR.lua`, avec l'interface et les dictionnaires par id (`L.ACHIEVEMENT_NAMES`, etc.) passés à `Override`, et le texte de chaque version dans `Data/Changelog.lua`.

## Hauts faits
- Export / import de la sauvegarde par un texte à copier (`/hff export`, `/hff import`). Les boss vus mourir en direct (`bossKills`, depuis la 1.1.0), les tabards vus équipés (`tabards`, depuis la 1.2.0), les jets de 100 (`perfectRolls`, depuis la 1.2.0), les coupes chez le coiffeur (`haircuts`, depuis la 1.2.1), les rares tués (`rareKills`, depuis la 1.3.0) et les hauts faits d'équipement n'ont pas d'autre trace que la sauvegarde (`WTF/Account/<compte>/SavedVariables/HFForever.lua`) : elle se perd en supprimant `WTF`, sur un autre PC ou un autre compte WoW. Les donjons, eux, se redétectent par les hauts faits Spéléologue.
- Scholomance : le haut fait d'origine demande Gandling **et** Ras Murmegivre ; le nôtre (91) ne demande que Gandling. À décider.
- Raids : la catégorie existe (Onyxia 173, Sommet d'Hyjal 174, Profondeurs des Saisons 175, par statistique). À reprendre quand les raids seront ouverts sur Forever ; les hauts faits natifs 684, 62034 et 62035 listent leurs boss, comme les Spéléologue pour les donjons.
- Explorer Reflet-de-Lune : piste `C_MapExplorationInfo.GetExploredAreaIDsAtPosition`.
- Autres séries de quêtes de Forever : le critère `questCount` (1.2.0) compte les quêtes terminées d'une liste de `Data/Books.lua` ; une nouvelle liste suffit (pistes : onglets « Accès », « Carnet de terrain » et « Rares » de NaowhForever_Discovery).
- Livre « The Liminal and the Arcane » (quête 81951) : emplacement encore inconnu ; il est déjà dans la liste des livres et comptera dès qu'il sera rendu.
- Autres catégories prévues : Tours de force, Combat (victimes, morts).

## Fait depuis la v1
- Donjons sans statistique (Excavations, Cité Submergée, Krol'dok, Noiregueules) : 1.2.0, par les critères natifs Spéléologue et `ENCOUNTER_END`.
- Gouffre de Ragefeu et salle des Thanes : un haut fait commun (207) en 1.1.0, par le critère natif commun aux deux.
- Boss facultatifs (Lyn l'Ignoré, gardiens de la terrasse) : abandonnés en 1.1.0, pas assez fiables. Lyn revient en 1.3.0 comme rare (292), détecté par la mort en cible ou la fouille.
- Entre joueurs : 1.3.0. Points dans l'infobulle (`UI/PlayerTooltip.lua`), « Inspecter les hauts faits » au clic droit (`UI/Inspect.lua`), messages d'addon chuchotés (`Core/Comm.lua`). Partage toujours actif, sans réglage (choix du 2026-11-21).
- Suivi des hauts faits dans le suivi des objectifs de Blizzard : 1.3.0 (`UI/Tracker.lua`), 10 par personnage, 5 conditions affichées.
- Rares : 1.3.0, catégorie Rares (229 à 293), liste de RareScanner recoupée avec NaowhForever.
