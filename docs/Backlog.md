# Idées et travaux reportés

Ce qui a été décidé pour « plus tard ». Mis à jour le 2026-11-17, après la
publication de la 1.1.0.

## Entre joueurs
Base commune : messages d'addon (`C_ChatInfo.SendAddonMessage`), avec un protocole versionné, un cache, le respect de la limite d'envoi et une option « partager mes hauts faits » (activée par défaut). À vérifier d'abord en jeu : les restrictions de Midnight sur les messages d'addon en combat et en instance.
- Points de hauts faits du joueur survolé dans son infobulle (`TooltipDataProcessor`), seulement s'il a l'addon.
- « Voir les hauts faits » dans le menu du clic droit sur un joueur (`Menu.ModifyMenu`), avec un mode consultation de la fenêtre en lecture seule (ou une comparaison à deux colonnes, comme Blizzard).

## Interface
- Nom affiché de l'addon : « HF » ne parle qu'aux francophones. Piste : « Hall of Fame Forever » (garde les initiales HF). Le nom « Achievements Forever » est déjà pris par un autre addon.
- Logo à retravailler (`docs/HFForever_Logo.png`, `Media/HFForever_Icon.tga`) : acceptable, pas parfait.
- Toasts déplaçables (position sauvegardée), en plus de la position par défaut au-dessus des alertes Blizzard.
- Autres langues que le français et l'anglais : un `Locales/xxXX.lua` sur le modèle de `frFR.lua`, avec l'interface et les dictionnaires par id (`L.ACHIEVEMENT_NAMES`, etc.) passés à `Override`, et le texte de chaque version dans `Data/Changelog.lua`.

## Hauts faits
- Export / import de la sauvegarde par un texte à copier (`/hff export`, `/hff import`). Les boss vus mourir en direct (`bossKills`, depuis la 1.1.0), les tabards vus équipés (`tabards`, depuis la 1.2.0), les jets de 100 (`perfectRolls`, depuis la 1.2.0), les coupes chez le coiffeur (`haircuts`, depuis la 1.2.1) et les hauts faits d'équipement n'ont pas d'autre trace que la sauvegarde (`WTF/Account/<compte>/SavedVariables/HFForever.lua`) : elle se perd en supprimant `WTF`, sur un autre PC ou un autre compte WoW. Les donjons, eux, se redétectent par les hauts faits Spéléologue.
- Scholomance : le haut fait d'origine demande Gandling **et** Ras Murmegivre ; le nôtre (91) ne demande que Gandling. À décider.
- Raids : la catégorie existe (Onyxia 173, Sommet d'Hyjal 174, Profondeurs des Saisons 175, par statistique). À reprendre quand les raids seront ouverts sur Forever ; les hauts faits natifs 684, 62034 et 62035 listent leurs boss, comme les Spéléologue pour les donjons.
- Explorer Reflet-de-Lune : piste `C_MapExplorationInfo.GetExploredAreaIDsAtPosition`.
- Autres séries de quêtes de Forever : le critère `questCount` (1.2.0) compte les quêtes terminées d'une liste de `Data/Books.lua` ; une nouvelle liste suffit (pistes : onglets « Accès », « Carnet de terrain » et « Rares » de NaowhForever_Discovery).
- Livre « The Liminal and the Arcane » (quête 81951) : emplacement encore inconnu ; il est déjà dans la liste des livres et comptera dès qu'il sera rendu.
- Autres catégories prévues : Tours de force, Combat (victimes, morts).

## Fait depuis la v1
- Donjons sans statistique (Excavations, Cité Submergée, Krol'dok, Noiregueules) : 1.2.0, par les critères natifs Spéléologue et `ENCOUNTER_END`.
- Gouffre de Ragefeu et salle des Thanes : un haut fait commun (207) en 1.1.0, par le critère natif commun aux deux.
- Boss facultatifs (Lyn l'Ignoré, gardiens de la terrasse) : abandonnés en 1.1.0, pas assez fiables.
