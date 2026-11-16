-- Recettes de métier, par ligne de compétence : les sorts que le joueur
-- apprend. Données uniquement, aucune logique.
-- Source : table SkillLineAbility du build Forever 1.60.1.70862 (wago.tools),
-- sans les sorts qui sont les rangs du métier lui-même (« Cuisine »).
-- Sert au type de critère « recipes » : la statistique 1745 « Recettes de
-- cuisine connues » compte chaque recette deux fois sur Forever.
local _, ns = ...

ns.Data.recipes = {
	-- Cuisine (133 recettes)
	[185] = {
		818, -- Feu de camp basique
		2538, -- Viande de loup grillée
		2539, -- Viande de loup épicée
		2540, -- Viande de sanglier rôtie
		2541, -- Steak de coyote
		2542, -- Tourte au foie de Broche-tripes
		2543, -- Ragoût de la marche de l'Ouest
		2544, -- Beignet de crabe
		2545, -- Pince de crabe farcie
		2546, -- Côtes de porc séchées
		2547, -- Goulash des Carmines
		2548, -- Côtes de porc aux herbes
		2549, -- Kébab de loup assaisonné
		2795, -- Côtes de sanglier à la bière
		3370, -- Steak de crocilisque
		3371, -- Boudin
		3372, -- Soupe aux ailerons de murloc
		3373, -- Gombo de crocilisque
		3376, -- Omelette au goût étrange
		3377, -- Tourte d'araignée fondante
		3397, -- Steak de grand ours
		3398, -- Côtelettes de lion épicées
		3399, -- Délicieux steak de lion
		3400, -- Bisque de tortue apaisante
		4094, -- Aile de busard grillée
		6412, -- Kébab d'araignée kaldorei
		6413, -- Surprise du scorpide
		6414, -- Viande de kodo rôtie
		6415, -- Filet de furie
		6416, -- Brouet de trotteur
		6417, -- Brouet de rat
		6418, -- Queue de lézard croquante
		6419, -- Venaison dégraissée
		6499, -- Palourdes bouillies
		6500, -- Palourdes gobelines
		6501, -- Soupe de palourdes
		7213, -- Ardeur de palourde géante
		7751, -- Goujon brillant
		7752, -- Maquereau ombré
		7753, -- Lutjan à longue mâchoire
		7754, -- Délice de furie du loch
		7755, -- Poisson-chat moustachu
		7827, -- Thon arc-en-ciel
		7828, -- Morue rochécaille
		8238, -- Délice de déviant
		8604, -- Oeufs aux herbes
		8607, -- Viande d'ours fumée
		9513, -- Thé de chardon
		13028, -- Thé de dorépine
		15853, -- Steak de loup
		15855, -- Rôti de raptor
		15856, -- Côtes de loup épicées
		15861, -- Ragoût de la jungle
		15863, -- Tourte surprise
		15865, -- Ragoût mystère
		15906, -- Chili de souffle de dragon
		15910, -- Ragoût épais de kodo
		15915, -- Chili de crabe épicé
		15933, -- Omelette monstrueuse
		15935, -- Aile de chauve-souris croustillante
		18238, -- Jaune-queue tacheté
		18239, -- Barracuda luisant cuit
		18240, -- Calmar grillé
		18241, -- Filet de rouget
		18242, -- Perche fumée
		18243, -- Soupe de lutjan nagenuit
		18244, -- Saumon solécaille poché
		18245, -- Ragoût de homard
		18246, -- Steak de barracuda
		18247, -- Pain de saumon
		20626, -- Soupe de palourdes d'Undermine
		20916, -- Truite tête-mithril
		21143, -- Biscuit au pain d'épices
		21144, -- Lait de poule
		21175, -- Saucisse d'araignée
		22480, -- Steak de loup tendre
		22761, -- Courante-surprise
		24418, -- Ragoût épais de crocilisque
		24801, -- Boulettes fumées du désert
		25659, -- Pyro-côtelettes de chimaerok à la Dirge
		25704, -- Sagerelle fumée
		25954, -- Délice de sagerelle
		470359, -- Bisque de Pince-noire
		470370, -- Rouget fumé
		1225758, -- Steak de rôdeur
		1225759, -- Filet de flanc
		1225760, -- Omelette du Lever de soleil
		1225762, -- Festin de loche à taches claires
		1225763, -- Grand banquet de homard
		1229737, -- Feu de camp basique
		1247741, -- Flétan épineux
		1249957, -- Thé de sérénité
		1249958, -- Thé royal
		1249959, -- Thé aux racines
		1249960, -- Thé de triage
		1249961, -- Thé du soleil
		1249962, -- Thé des sages
		1249963, -- Frappé venimeux
		1249964, -- Frappé gélatineux
		1249965, -- Frppl mrrggl
		1249966, -- Frappé calcifié
		1249967, -- Frappé épicé
		1249968, -- Frappé pernicieux
		1250142, -- Mini-burgers de cerf savoureux
		1250143, -- Pamplona d'envergure
		1250144, -- Hachis de chauve-souris
		1250145, -- Ragoût de tortue savoureux
		1250146, -- Flanchet au poivre
		1250147, -- Bruscitt d'ours
		1250148, -- Steak de cerf fumant
		1250149, -- Steak de frappe rapide
		1250150, -- Côtelettes de raptor bouillantes
		1250151, -- Poitrine d'ours
		1250152, -- Effiloché de raptor préhistorique
		1250153, -- Paupiette de raptor
		1250154, -- Émincé de raptor aux deux épices
		1250155, -- Œufs brouillés géants
		1250156, -- Délicieuses bouchées au raptor
		1250157, -- Omelette de petit déjeuner
		1250158, -- Linguines aux palourdes
		1252566, -- Délice de fantaileron
		1255241, -- Ragoût purificateur
		1262978, -- Festin de Macaron
		1263067, -- Four en fer
		1270632, -- Biscuit en forme de bestiole
		1270633, -- Soufflé de Mur-Céleste
		1270635, -- Bouchées à la chair de pinces
		1283400, -- Feu de camp de compagnon
		1291341, -- Feu de camp de spécialiste
		1294014, -- Confiture patte-douce
		1295805, -- Ragoût de fruits de mer saumâtre
		1295834, -- Bonne vieille viande de brochepâle
		1319313, -- Poisson cuirassé
	},
}
