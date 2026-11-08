# Idées et travaux reportés

Ce qui a été décidé pour « plus tard » pendant le développement de la v1.

## Interface
- Toasts déplaçables (position sauvegardée), en plus de la position par défaut au-dessus des alertes Blizzard.
- Traduction : `Locales/enUS.lua` pour l'interface, et un fichier de traduction par langue pour les noms et descriptions des HF (`[id] = { name = ..., description = ... }`), sans toucher à `Data/Achievements.lua`.

## Hauts faits
- Donjons Forever sans statistique (Excavation Site, The Drowned City, Krol'dok Stronghold, Blackmaw Hold) : type de critère `encounter` sur l'événement `ENCOUNTER_END`, non rétroactif, à vérifier avec les restrictions Midnight.
- Gouffre de Ragefeu et Salle des Thanes : à remettre si Blizzard corrige les statistiques 15027 / 63573.
- Explorer Reflet-de-Lune : piste `C_MapExplorationInfo.GetExploredAreaIDsAtPosition`.
- Catégorie Raids : statistiques déjà repérées (Onyxia 1098, roi sauvage 63580, Sonya Sanctombre 63581).
- HF bonus (ex. Lyn l'Ignoré, statistique 63589).
- Autres catégories prévues : JcJ, Réputation, Tours de force.
