-- Notes de version affichées dans l'onglet « Notes de version »
-- (UI/Changelog.lua). La plus récente en tête : c'est la « Dernière
-- version », et celle qui allume la pastille de l'onglet.
--
--   version : "majeure.mineure.correctif", sert aussi au regroupement 1.x, 2.x
--   enUS    : texte anglais, recopié du bloc de CHANGELOG.md (sans le titre
--             « ## version »)
--   frFR    : le même texte en français
--
-- Format du texte, le même que CHANGELOG.md :
--   ### Titre        rubrique
--   **Titre**        sous-rubrique (ligne entière en gras)
--   - texte          puce
--   **mot**          gras dans CHANGELOG.md, texte normal en jeu
--   autre ligne      paragraphe ; une ligne vide sépare les blocs
local _, ns = ...

ns.Data.changelog = {
	{
		version = "1.2.1",
		enUS = [[
### Fixes

- **Safe Deposit** now reads the bank slots you have bought, so slots bought before count right away. WoW: Forever has 8 bank bag slots to buy, so the achievement now asks for all 8 instead of 7. The game statistic it used before is not kept up to date on WoW: Forever.
- **Shave and a Haircut** now sees you change your hair at a Barber Shop. The game statistic it used is not kept up to date on WoW: Forever: go back to a Barber Shop with HF Forever installed and accept a new haircut.
]],
		frFR = [[
### Corrections

- **Chambre forte** lit maintenant les emplacements de banque que vous avez achetés : ceux achetés avant comptent tout de suite. WoW: Forever propose 8 emplacements de sac de banque à acheter, le haut fait demande donc les 8 au lieu de 7. La statistique du jeu utilisée avant n'est pas tenue à jour sur WoW: Forever.
- **Coupe et brushing** voit maintenant quand vous changez de coupe chez le coiffeur. La statistique du jeu utilisée n'est pas tenue à jour sur WoW: Forever : retournez chez un coiffeur avec HF Forever installé et validez une nouvelle coupe.
]],
	},
	{
		version = "1.2.0",
		enUS = [[
### New achievements (20)

**Exploration**
- **Friend of the Library**, **Greater Friend of the Library**, **Bookworm** and **Master Librarian**: turn in 10, 20, 25 and 30 library books. Books already turned in count right away; your best character counts.
- **Good Night, Sleep Tight**: follow the trail of hidden notes to the Cozy Sleeping Bag.

**General**
- **Shave and a Haircut**: get your hair cut at a Barber Shop.
- **Ten Tabards** and **Twenty-Five Tabards**: equip 10 and 25 unique tabards. A tabard counts once you have worn it with HF Forever installed: put your old tabards back on to add them.
- **Greedy** and **Needy**: roll 100 on a greed or need roll for a superior or better item. Only rolls made with HF Forever installed count.

**Darkspear Islands** (new Player vs. Player category)
- **Darkspear Islands Victory** and **Darkspear Islands Veteran**: win the Darkspear Islands 1 and 100 times.
- **Flags Captured**: capture 50 flags in the Darkspear Islands.
- **Bases Assaulted**: assault 50 bases in the Darkspear Islands.
- **Darkspear Raider** (Horde) and **Theramore Expeditionary Force** (Alliance): reach exalted with your faction of the battleground.

These read the game's statistics and reputations, so what you have already done counts right away.

**WoW: Forever dungeons**
- **Excavation Site: Wetlands**: defeat the Relic Guardian.
- **Drowned City**: defeat Min'loth the Serpent.
- **Krol'dok Stronghold**: defeat Overlord Mugg.
- **Blackmaw Hold**: defeat Varrox Bleakhoof.

They are detected from WoW: Forever's Spelunker achievements, so dungeons you have already finished count right away. **Forever Raider** now also asks for these four dungeons.
]],
		frFR = [[
### Nouveaux hauts faits (20)

**Exploration**
- **Ami de la bibliothèque**, **Mécène de la bibliothèque**, **Rat de bibliothèque** et **Bibliothécaire émérite** : rendre 10, 20, 25 et 30 livres de bibliothèque. Les livres déjà rendus comptent tout de suite ; le meilleur personnage compte.
- **Bonne nuit les petits** : suivre la piste des notes cachées jusqu'au sac de couchage douillet.

**Général**
- **Coupe et brushing** : changer de coupe dans un salon de coiffure.
- **Dix tabards** et **Timbré de tabards** : équiper 10 et 25 tabards différents. Un tabard compte dès que vous l'avez porté avec HF Forever installé : remettez vos anciens tabards pour les ajouter.
- **Cupide** et **Nécessiteux** : obtenir 100 sur un jet de cupidité ou de besoin pour un objet de qualité supérieure ou mieux. Seuls les jets faits avec HF Forever installé comptent.

**Îles des Sombrelances** (nouvelle catégorie de Joueur contre Joueur)
- **Victoire sur les îles des Sombrelances** et **Vétéran des îles des Sombrelances** : gagner 1 et 100 fois sur les îles des Sombrelances.
- **Drapeaux capturés** : capturer 50 drapeaux sur les îles des Sombrelances.
- **Bases attaquées** : attaquer 50 bases sur les îles des Sombrelances.
- **Chevaucheur sombrelance** (Horde) et **Troupe d'intervention de Theramore** (Alliance) : être exalté auprès de sa faction du champ de bataille.

Ils lisent les statistiques et les réputations du jeu : ce que vous avez déjà fait compte tout de suite.

**Donjons de WoW: Forever**
- **Excavations : les Paluns** : vaincre le Gardien des reliques.
- **Cité Submergée** : vaincre Min'loth le Serpent.
- **Bastion Krol'dok** : vaincre le suzerain Mugg.
- **Repaire des Noiregueules** : vaincre Varrox Mornesabot.

Ils sont repris des hauts faits Spéléologue de WoW: Forever : les donjons déjà terminés comptent tout de suite. **L'écumeur pour toujours** demande aussi ces quatre donjons.
]],
	},
	{
		version = "1.1.0",
		enUS = [[
### New achievements (31)

**General**
- **Can I Keep Him?**, **Plenty of Pets**, **Plethora of Pets**, **Shop Smart, Shop Pet...Smart** and **Lil' Game Hunter**: collect 1, 15, 25, 50 and 75 companion pets.
- **Giddy Up!**: learn the Apprentice riding skill.
- **Fast and Furious**: learn the Journeyman riding skill.
- **Did Somebody Order a Knuckle Sandwich?**: raise your unarmed skill to 300.
- **Master of Arms**: raise four weapon skills to 300.
- **Represent**: equip a tabard.
- **Superior**: equip a superior item in every slot.
- **Epic**: equip an epic item in every slot.

**Quests**
- **1500**, **2000** and **3000 Quests Completed**, added up across your characters.
- **The Green Hills of Stranglethorn**: complete Hemet Nesingwary's quests in Stranglethorn Vale.

**Professions**
- **Lunch Lady**, **Short Order Cook**, **Chef de Partie** and **Sous Chef**: learn 25, 50, 75 and 100 cooking recipes.

**Dungeons**
- One achievement per wing for **Scarlet Monastery** (Graveyard, Library, Armory, Cathedral), **Dire Maul** (East, West, North) and **Stratholme** (Main Gate, Service Entrance), plus the classic **Scarlet Monastery**, **King of Dire Maul** and **Stratholme** meta achievements.
- **Ragefire Chasm or Hall of Thanes**: finish either of the two dungeons.
- **Forever Raider**: complete every dungeon achievement, classic and WoW: Forever.

Pets, riding, unarmed and weapon skills, recipes, quests and dungeons are detected from what your characters have already done. Tabard and gear achievements unlock as soon as you wear the items, even once.

### New in the window

- **Patch notes** tab: what changed in each version of HF Forever, right in the game. A red dot on the tab tells you when a new version brings news.
- Larger minimap button, showing the HF Forever crest without the round frame.

### Removed

- **Scarlet Halls**: it was a duplicate of the Scarlet Monastery Cathedral.
- **Guardians of the Terrace** and **The Ignored**: optional bosses, not reliable enough to track.
- **Stormwind Stockade**: the Horde cannot enter it, so it has no place in account-wide achievements.

### Fixes

- Dungeon achievements no longer rely on the game's kill statistics, which WoW: Forever does not always update. They now read WoW: Forever's own Spelunker achievements, which record every dungeon you have finished, and HF Forever also sees the boss die during your run.
- An expanded achievement no longer loses its criteria when you close and reopen the achievement window.
- Mount achievements now count the mounts shown in your Mount Journal. The game statistic they used before is not kept up to date on WoW: Forever.
- Achievements that track the same thing (for example your completed quests) now share the progress already recorded for all your characters, so a new milestone shows your full account total right away.
]],
		frFR = [[
### Nouveaux hauts faits (31)

**Général**
- **Je peux le garder ?**, **De nombreux familiers**, **Pléthore de familiers**, **Les aimer comme ils vous aiment** et **La chasse au p'tit gibier** : collecter 1, 15, 25, 50 et 75 mascottes.
- **En selle !** : apprendre la compétence Apprenti cavalier.
- **L'équipée sauvage** : apprendre la compétence Compagnon cavalier.
- **Qui a commandé une salade de phalanges ?** : monter la compétence Mains nues à 300.
- **Maître d'armes** : monter quatre compétences d'armes à 300.
- **Représentant** : équiper un tabard.
- **Qualité supérieure** : équiper un objet de qualité supérieure dans chaque emplacement.
- **Qualité épique** : équiper un objet de qualité épique dans chaque emplacement.

**Quêtes**
- **1 500**, **2 000** et **3 000 quêtes achevées**, additionnées sur tous vos personnages.
- **Les vertes collines de Strangleronce** : achever les quêtes d'Hemet Nesingwary dans la vallée de Strangleronce.

**Métiers**
- **Commis**, **Cuistot**, **Chef de partie** et **Sous chef** : apprendre 25, 50, 75 et 100 recettes de cuisine.

**Donjons**
- Un haut fait par aile pour le **Monastère écarlate** (cimetière, bibliothèque, armurerie, cathédrale), **Hache-Tripes** (Est, Ouest, Nord) et **Stratholme** (Grande porte, Entrée de service), avec les métas d'origine **Monastère écarlate**, **Roi de Haches-Tripes** et **Stratholme**.
- **Gouffre de Ragefeu ou salle des Thanes** : terminer l'un des deux donjons.
- **L'écumeur pour toujours** : accomplir tous les hauts faits de donjon, classiques et de WoW: Forever.

Les mascottes, la monte, les compétences d'armes et de mains nues, les recettes, les quêtes et les donjons sont repris de ce que vos personnages ont déjà fait. Les hauts faits de tabard et d'équipement se débloquent dès que vous portez les objets, même une seule fois.

### Nouveau dans la fenêtre

- Onglet **Notes de version** : ce qui change à chaque version de HF Forever, directement en jeu. Une pastille rouge sur l'onglet vous prévient quand une nouvelle version apporte du nouveau.
- Bouton de la minimap plus grand, avec le blason de HF Forever sans le cercle autour.

### Retirés

- **Salles Écarlates** : doublon de la cathédrale du Monastère écarlate.
- **Les gardiens de la terrasse** et **L'ignoré** : boss facultatifs, impossibles à suivre de façon fiable.
- **Prison de Hurlevent** : la Horde ne peut pas y entrer, elle n'a donc pas sa place dans des hauts faits de compte.

### Corrections

- Les hauts faits de donjon ne dépendent plus des statistiques de victoires du jeu, que WoW: Forever ne tient pas toujours à jour. Ils lisent maintenant les hauts faits Spéléologue de WoW: Forever, qui retiennent chaque donjon terminé, et HF Forever voit aussi le boss mourir pendant votre partie.
- Un haut fait déplié ne perd plus ses conditions quand on ferme puis rouvre la fenêtre des hauts faits.
- Les hauts faits de montures comptent maintenant les montures de votre journal des montures. La statistique du jeu utilisée avant n'est pas tenue à jour sur WoW: Forever.
- Les hauts faits qui mesurent la même chose (par exemple vos quêtes achevées) partagent maintenant la progression déjà enregistrée pour tous vos personnages : un nouveau palier affiche tout de suite le total du compte.
]],
	},
	{
		version = "1.0.0",
		enUS = [[
### First release

- 177 account-wide achievements: General, Quests, Exploration, Player vs. Player, Professions, Reputation, Dungeons and Raids.
- Progress adds up across all your characters.
- Most achievements read the game's own statistics, so what you have already done is picked up when you log in.
- Achievement window with summary, categories, search, progress bars, series and meta achievements.
- Toasts and sound when you earn an achievement.
- Faction achievements only show to the matching faction.
- English and French.
]],
		frFR = [[
### Première version

- 177 hauts faits à l'échelle du compte : Général, Quêtes, Exploration, Joueur contre Joueur, Métiers, Réputation, Donjons et Raids.
- La progression s'additionne sur tous vos personnages.
- La plupart des hauts faits lisent les statistiques du jeu : ce que vous avez déjà fait est repris dès la connexion.
- Fenêtre des hauts faits avec résumé, catégories, recherche, barres de progression, séries et métas.
- Toasts et son à l'obtention d'un haut fait.
- Les hauts faits de faction ne s'affichent que pour le bon camp.
- Anglais et français.
]],
	},
}
