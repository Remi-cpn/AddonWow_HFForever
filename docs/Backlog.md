# Idées et travaux reportés

Ce qui a été décidé pour « plus tard » pendant le développement de la v1.

## Entre joueurs
Base commune : messages d'addon (`C_ChatInfo.SendAddonMessage`), avec un protocole versionné, un cache, le respect de la limite d'envoi et une option « partager mes hauts faits » (activée par défaut). À vérifier d'abord en jeu : les restrictions de Midnight sur les messages d'addon en combat et en instance.
- v1.1 : points de hauts faits du joueur survolé dans son infobulle (`TooltipDataProcessor`), seulement s'il a l'addon.
- v1.2 : « Voir les hauts faits » dans le menu du clic droit sur un joueur (`Menu.ModifyMenu`), avec un mode consultation de la fenêtre en lecture seule (ou une comparaison à deux colonnes, comme Blizzard).

## Interface
- Logo à retravailler (`docs/HFForever_Logo.png`, `Media/HFForever_Icon.tga`) : acceptable pour la v1, pas parfait.
- Toasts déplaçables (position sauvegardée), en plus de la position par défaut au-dessus des alertes Blizzard.
- Autres langues que le français et l'anglais : un `Locales/xxXX.lua` sur le modèle de `frFR.lua` (interface), et un `Locales/Achievements_xxXX.lua` chargé après `Achievements_enUS.lua`, qui remplace `ns.Data.translation` sur ce client.

## Hauts faits
- Avant tout haut fait « à nous » (détecté par un événement en direct, pas par une statistique) : export / import de la sauvegarde par un texte à copier (`/hff export`, `/hff import`), et un indicateur dans la fenêtre pour ces hauts faits. La sauvegarde (`WTF/Account/<compte>/SavedVariables/HFForever.lua`) serait leur seule trace : elle se perd en supprimant `WTF`, sur un autre PC ou un autre compte WoW. Les hauts faits actuels, eux, se redétectent.
- Donjons Forever sans statistique (Excavation Site, The Drowned City, Krol'dok Stronghold, Blackmaw Hold) : type de critère `encounter` sur l'événement `ENCOUNTER_END`, non rétroactif, à vérifier avec les restrictions Midnight.
- Gouffre de Ragefeu et Salle des Thanes : à remettre si Blizzard corrige les statistiques 15027 / 63573.
- Explorer Reflet-de-Lune : piste `C_MapExplorationInfo.GetExploredAreaIDsAtPosition`.
- Catégorie Raids : statistiques déjà repérées (Onyxia 1098, roi sauvage 63580, Sonya Sanctombre 63581).
- HF bonus (ex. Lyn l'Ignoré, statistique 63589).
- Autres catégories prévues : JcJ, Réputation, Tours de force.
