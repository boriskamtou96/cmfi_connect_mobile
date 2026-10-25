# Journal biblique — spécification design

**Statut** : proposition v1, à valider  
**Date** : 25 octobre 2026  
**Module** : Bible  
**Surface** : application mobile CMFI Connect (Flutter)  
**Références design** : `AppColors`, `AppTones`, `AppSpacing`, `AppRadius`, `AppMotion`, `AppIcons`, `SubPage`, `SegmentedTabs`, `MenuTile`, `AppButton`.

---

## 0. En une page

Le journal biblique permet d'écrire une note privée à partir d'un verset, de la retrouver dans un journal chronologique, de la chercher et de la partager.

**Le parcours tient en deux gestes** : toucher un verset, puis « Note ». L'éditeur s'ouvre avec le passage déjà cité. Tu écris, tu enregistres, la note rejoint le journal et une petite icône apparaît à côté du verset.

**Trois surfaces, une seule promesse : tes notes restent sur ton téléphone.**

1. **Une carte « Journal biblique »** en haut de « Mes versets » : le point d'entrée vers le journal, avec le nombre de notes et la dernière note.
2. **L'écran « Journal biblique »** : la liste chronologique, la recherche, le partage et l'état vide.
3. **L'éditeur de note** : le passage cité, le champ d'écriture, l'enregistrement, la suppression et le partage d'une note.

S'y ajoute **l'action « Note »** dans la barre des versets sélectionnés de la Bible.

**Ce que le journal n'est pas** : un réseau social, un fil communautaire, un espace de points ou de séries, une fonctionnalité premium. Il n'y a ni classement, ni badge, ni rappel culpabilisant, ni envoi vers le collectif. Le partage est toujours manuel et choisi.

**Décision de stockage** : local d'abord, sur le téléphone, par compte, sans backend en v1. Le partage d'un fichier `.txt` est la seule sortie. Voir §9 et §10.

---

## 1. Pourquoi le journal

### 1.1 Le besoin

La Bible de l'app permet déjà de lire, surligner, garder un verset, chercher, comparer, mémoriser et écouter. Il manque le geste le plus personnel : **écrire ce que le passage me dit**.

Aujourd'hui, ce geste se fait ailleurs : carnet papier, notes du téléphone, application tierce. Le contenu spirituel le plus intime est donc séparé de la lecture qui l'a fait naître. Le journal le ramène au bon endroit, sans transformer la Bible en application de productivité.

### 1.2 Les principes

1. **Le verset d'abord.** Une note naît d'un passage, jamais d'un formulaire vide. Le passage reste visible pendant l'écriture.
2. **Un espace à soi.** Pas de compteur de performance, pas de comparaison, pas de fil collectif. Le journal est un lieu de silence.
3. **Deux gestes.** Lire → toucher → « Note ». Pas de menu caché, pas de chemin à trois écrans pour commencer.
4. **Rien ne se perd.** Un brouillon modifié ne disparaît pas par accident : quitter, c'est choisir. Un échec d'écriture ne ferme pas l'éditeur.
5. **La lecture reste la lecture.** Le journal est un espace distinct, calme, sans animation qui récompense. On écrit, on ferme, on retourne au texte.
6. **La confiance se voit.** L'écran dit clairement que les notes restent sur le téléphone, et le partage est explicite.

### 1.3 Les moments d'usage

| Moment | Ce que la personne veut | Ce que le journal fait |
| --- | --- | --- |
| Lecture quotidienne | Retenir ce qui l'a touchée | Écrire une note en deux gestes, sans quitter le chapitre |
| Retour sur un passage | Retrouver ce qu'elle avait écrit | Journal chronologique + recherche par mot ou référence |
| Préparation / étude | Creuser un passage | Citer plusieurs versets, écrire, relire, partager |
| Mémoire personnelle | Garder une trace dans le temps | Dates de création et de modification, export `.txt` |
| Partage choisi | Envoyer une pensée à un proche | Partage manuel d'une note ou du journal |

---

## 2. Décisions structurantes

| Sujet | Décision v1 | Pourquoi |
| --- | --- | --- |
| Nature | Note privée, **une note par passage** (ancre = premier verset) | Le geste reste direct, sans sélecteur de notes. On modifie la note existante ; plusieurs notes sur le même passage viendront en v2 si le besoin est réel. |
| Stockage | `SharedPreferences`, JSON, **par compte**, sans backend | Même modèle que `BibleMarks`, mise en œuvre rapide, lisible hors ligne. Le parcours par compte protège les notes d'un autre utilisateur sur le même téléphone. |
| Entrée principale | Barre des versets → **Note** | C'est le moment où le passage est sous les yeux. |
| Entrée secondaire | Carte **Journal biblique** dans « Mes versets » | Rend le journal visible sans ajouter un troisième onglet tassé. |
| Écran du journal | Écran dédié, pas un troisième onglet de « Mes versets » | La recherche, le partage et les en-têtes de mois ont besoin de place. À trois segments, le contrôle ne tient plus à 200 % de taille de texte sur 320 dp. |
| Éditeur | Plein écran, thème de l'app (pas le thème sépia du lecteur), citation en Lora | Le journal est un espace de l'app, pas une page de lecture. La distinction Lora / Onest sépare la Parole de tes mots. |
| Enregistrement | **Explicite** : bouton « Enregistrer », dialogue de sortie si brouillon | Plus sûr qu'un autosave silencieux, et cohérent avec « Enregistrer la journée » du compte rendu. |
| Export | Fichier `.txt` + copie du texte | Lisible partout, sans dépendance PDF en v1. Le PDF viendra en v2. |
| Gamification | Aucune | Le journal est intime ; le mesurer le transforme en performance. Voir §10. |
| Synchronisation | Aucune en v1 | Pas de backend, pas de compte serveur pour les notes. L'export est la sauvegarde. |
| Notifications | Aucune en v1 | Aucun rappel « tu n'as pas écrit ». Un rappel doux et optionnel pourra être étudié en v2. |
| Prix | Gratuit | Pas de journal premium, pas de fonctionnalité payante. |

### 2.1 Pourquoi pas un troisième onglet « Notes » dans « Mes versets »

L'idée est séduisante, mais elle crée trois problèmes :

- **Accessibilité** : à 200 % de taille de texte, trois libellés (« Favoris », « Surlignés », « Notes ») ne tiennent pas dans un contrôle segmenté de 48 dp sur 320 dp de large.
- **Espace** : le journal a besoin d'une recherche, d'un partage et d'en-têtes de mois. Un onglet partagerait la hauteur avec les favoris et les surlignages.
- **Nature** : un journal n'est pas une liste de marques. Il mérite son écran, son état vide et son propre rythme.

La carte dans « Mes versets » garde le lien visible, sans tasser l'écran existant. Si l'usage montre qu'un accès direct manque, on pourra ajouter un raccourci dans le menu ⋮ de la Bible ou un onglet adaptatif plus tard.

---

## 3. Parcours

### 3.1 Écrire depuis la Bible (parcours principal)

```
Bible, chapitre ouvert
  └─ toucher un ou plusieurs versets
       └─ barre de sélection : « Note »
            └─ éditeur : passage cité + champ vide + clavier
                 ├─ écrire
                 ├─ « Enregistrer »
                 │    ├─ toast « Note enregistrée »
                 │    ├─ retour au chapitre
                 │    └─ icône de note à côté du verset d'ancrage
                 └─ retour avec du texte
                      └─ dialogue : Continuer / Abandonner / Enregistrer
```

**Détail des étapes**

1. **Sélection.** Un tap sur un verset le souligne en pointillés et ouvre la barre d'actions. Un ou plusieurs versets peuvent être sélectionnés.
2. **Action.** La barre affiche le passage (« Jean 3:16-17 »), une pastille **Note**, le menu **⋮** et la croix. Un appui sur **Note** donne un retour haptique léger (`HapticFeedback.selectionClick`) et ouvre l'éditeur. La sélection est refermée derrière.
3. **Éditeur.** Le passage est déjà cité (référence, version, texte). Le champ est vide. Pour une nouvelle note, le clavier s'ouvre après la première frame ; pour une note existante, il reste fermé et l'écran se lit d'abord.
4. **Enregistrement.** Le bouton est actif dès qu'il y a du texte. Il enregistre localement, affiche un toast, revient à l'écran précédent. L'icône de note apparaît à côté du verset d'ancrage.
5. **Abandon.** Si le champ contient du texte non enregistré, le retour ouvre un dialogue à trois choix. Le texte n'est jamais perdu sans confirmation.

**Temps cible** : moins de 10 secondes entre le tap sur le verset et le curseur dans le champ.

### 3.2 Relire depuis « Mes versets »

```
Bible → ⋮ → Mes versets
  └─ carte « Journal biblique » (n notes · dernière référence)
       └─ écran Journal biblique
            ├─ recherche
            ├─ liste chronologique, groupée par mois
            └─ toucher une note → éditeur
```

La carte est visible sur les deux onglets existants (« Favoris » et « Surlignés »). Elle ne remplace rien : elle s'ajoute au-dessus du contrôle segmenté.

### 3.3 Chercher

1. L'écran Journal affiche un champ « Chercher dans le journal » dès qu'il y a au moins une note.
2. La recherche est locale, insensible à la casse et aux accents, avec un délai de 250 ms.
3. Elle porte sur le texte de la note, la référence, le texte du verset et la version.
4. Les résultats sont affichés à plat (sans en-têtes de mois), avec le nombre de résultats.
5. Un appui ouvre la note. Le retour conserve la requête et la position de la liste.
6. « Effacer la recherche » ramène à la chronologie.

### 3.4 Partager

**Tout le journal**

1. Icône de partage dans l'en-tête de l'écran Journal.
2. Feuille « Partager le journal » : fichier `.txt` ou copie du texte.
3. Le fichier est partagé via la feuille système. Rien ne part sans ce geste.

**Une note**

1. Menu ⋮ de l'éditeur → « Partager la note ».
2. Le texte de la note est partagé via la feuille système, avec la référence et la version.

### 3.5 Modifier, supprimer

- **Modifier** : ouvrir la note depuis le journal, ou depuis le verset (la pastille affiche « Modifier »). Le texte existant est pré-rempli. La date de création ne change pas ; la date de modification est mise à jour.
- **Supprimer** : menu ⋮ de l'éditeur → « Supprimer la note » → confirmation rouge. La note disparaît du journal et l'icône du chapitre disparaît. Aucune corbeille en v1 : l'action est confirmée, pas annulée.

### 3.6 Quitter l'éditeur

| État | Retour |
| --- | --- |
| Nouvelle note vide | Ferme sans dialogue. Aucune note n'est créée. |
| Nouvelle note avec du texte | Dialogue à trois choix. |
| Note existante sans changement | Ferme. |
| Note existante modifiée | Dialogue à trois choix. |
| Note existante vidée | Dialogue sans « Enregistrer » (impossible de sauver une note vide) ; « Abandonner » ou « Continuer ». |
| Pendant l'enregistrement | Le retour est bloqué le temps de l'écriture locale (très court). |

---

## 4. Écrans

### 4.1 Carte « Journal biblique » dans « Mes versets »

#### Anatomie

```
┌──────────────────────────────────────────────────────┐
│  ┌────┐  Journal biblique                       ›    │
│  │ ✎  │  12 notes · Jean 3:16                        │
│  └────┘                                              │
└──────────────────────────────────────────────────────┘
```

- **Fond** : `AppTones.bible.soft` (rose très pâle en clair, bordeaux profond en sombre).
- **Rayon** : `AppRadius.lg` (16).
- **Marge** : 16 horizontal, 8 haut, 8 bas.
- **Padding** : 14.
- **Icône** : tuile 44 × 44, rayon 14, fond `AppTones.bible.color` (bordeaux), icône `AppIcons.addNote` 22 blanche.
- **Titre** : « Journal biblique », Onest 16 / 800, `AppTones.bible.onSoft`.
- **Sous-titre** : Onest 13 / 500, `onSoft` à 78 %, 1 à 2 lignes maximum.
- **Chevron** : 20, `onSoft` ; en RTL, chevron gauche (miroir).
- **Hauteur** : libre, environ 72–84 dp ; aucune hauteur fixe.
- **Cible** : toute la carte, largement > 48 dp.

#### États

| État | Sous-titre | Action |
| --- | --- | --- |
| Aucune note | « Touche un verset, puis Note. » | Ouvre le journal vide |
| Une note | « 1 note · Jean 3:16 » | Ouvre le journal |
| Plusieurs notes | « 12 notes · Jean 3:16 » | Ouvre le journal |
| Compte non encore chargé | « Tes notes, sur ton téléphone » | Ouvre le journal (vide tant que le compte charge) |
| Note la plus récente à la référence longue | Tronque le sous-titre avec ellipse | Ouvre le journal |

La référence affichée est celle de la note **la plus récemment créée**, pas la plus récemment modifiée : le journal garde son axe chronologique.

#### Sémantique

Un seul bouton, pas de lecture en double :

> « Journal biblique. 12 notes. Dernière note : Jean 3:16. Bouton. Ouvre ton journal. »

Le chevron et l'icône sont décoratifs (`ExcludeSemantics`).

---

### 4.2 Écran « Journal biblique »

#### Structure

```
┌──────────────────────────────────────────────────────┐
│  ‹   Journal biblique                          ⇧     │  SubPage + partage
│                                                      │
│  ┌────────────────────────────────────────────────┐  │
│  │  ⌕  Chercher dans le journal                   │  │  champ de recherche
│  └────────────────────────────────────────────────┘  │
│                                                      │
│  OCTOBRE 2026                                        │  en-tête de mois
│  ┌────────────────────────────────────────────────┐  │
│  │ ┌──┐ Jean 3:16-17  LSG            25 oct.   › │  │
│  │ │✎ │ Ce que ce passage me dit, en deux…        │  │
│  │ └──┘ « Car Dieu a tant aimé le monde… »        │  │
│  └────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────┐  │
│  │ …                                              │  │
│  └────────────────────────────────────────────────┘  │
│                                                      │
│          🔒 Tes notes restent sur ton téléphone.     │  pied discret
└──────────────────────────────────────────────────────┘
```

#### En-tête

- `SubPage(title: « Journal biblique »)`, titre 22 / 800, chevron de retour standard.
- Action unique : icône `AppIcons.share`, 48 × 48, tooltip « Partager le journal ». Masquée quand il n'y a aucune note.
- Sur iPad, le partage est ancré au bouton (rectangle du bouton transmis à `ShareService`).
- Pas de bouton « + » : une note naît d'un verset. Le seul point de création est la Bible.

#### Recherche

- Champ `TextField` standard, 48 dp de haut minimum, fond `surface`, bord `outlineVariant`, rayon `AppRadius.md`.
- Préfixe : `AppIcons.search` 20, `onSurfaceVariant`.
- Suffixe : croix 48 × 48 quand le champ n'est pas vide, tooltip « Effacer la recherche ».
- Placeholder : « Chercher dans le journal ».
- Pas d'autofocus à l'ouverture de l'écran.
- Délai de 250 ms avant de filtrer.
- Le clavier se ferme au défilement (`ScrollViewKeyboardDismissBehavior.onDrag`).
- Le champ n'apparaît pas quand le journal est vide : l'état vide suffit.

#### Liste chronologique

- Ordre : **date de création décroissante** (la plus récente en haut). Une modification ne déplace pas la note.
- Groupes : mois de création, en-tête `OCTOBRE 2026` (DateFormatter localisé, majuscules).
- En-tête de mois : Onest 12 / 800, letter-spacing 1.2, `onSurfaceVariant`, 20 haut / 8 bas, sémantique `header`.
- Cartes séparées par 8 dp.
- Padding de liste : 16 horizontal, 0 haut, 32 bas.
- Pied de liste : 24 haut, ligne centrée avec `AppIcons.private` 14 et « Tes notes restent sur ton téléphone. Pense à en garder une copie. » en 12,5 / 500, `onSurfaceVariant`. Le texte peut passer sur deux lignes.
- Pas d'animation d'entrée en cascade : le journal reste calme. Seul un fondu très court (180 ms) peut accompagner un changement de recherche, et il est supprimé si `AppMotion.reduced`.

#### Carte de note

```
┌────────────────────────────────────────────────────────┐
│ ┌────┐  Jean 3:16-17   LSG           25 oct. · modifiée│
│ │ ✎  │  Ce que ce passage me dit, sur deux lignes…     │
│ └────┘  « Car Dieu a tant aimé le monde… »         ›   │
└────────────────────────────────────────────────────────┘
```

| Élément | Spécification |
| --- | --- |
| Fond | `surface`, bord 1 `outlineVariant`, rayon `AppRadius.lg` (16) |
| Padding | 14 partout |
| Icône | tuile 40 × 40, rayon 12, fond `bible.soft`, `AppIcons.addNote` 20 `bible.onSoft` |
| Référence | Onest 13,5 / 800, `bible.onSoft` |
| Version | Onest 11 / 800, majuscules, letter-spacing 0,6, `onSurfaceVariant` ; pastille discrète ou simple texte |
| Date | Onest 12 / 500, `onSurfaceVariant` ; « 25 oct. » ou « 25 oct. 2025 » si l'année diffère ; « · modifiée » si `updatedAt - createdAt > 24 h` |
| Corps | Onest 15 / 400, hauteur 1,45, `onSurface`, 2 lignes maximum, espaces multiples aplatis, ellipse |
| Citation | Lora 14 / 400, hauteur 1,45, `onSurfaceVariant`, 1 ligne maximum, ellipse |
| Chevron | 18, `onSurfaceVariant`, aligné au centre ; miroir en RTL |
| Cible | Toute la carte, > 48 dp |

La référence, la version et la date sont dans un `Wrap` (espacement 8, run 2) pour ne jamais déborder à 200 % de texte. Le corps et la citation sont dans la colonne de texte, à côté de l'icône et du chevron.

**Sémantique** :

> « Note sur Jean 3:16-17, version LSG. Créée le 25 octobre 2026. [début du corps]. Bouton. Ouvre la note. »

Le contenu visuel est exclu de la sémantique pour éviter les doublons. Le corps complet n'est pas lu en entier : deux lignes suffisent dans une liste ; l'éditeur donne le texte intégral.

#### Résultats de recherche

- Pas d'en-têtes de mois.
- Ligne de résultat : `3 résultats` (ou `1 résultat`), Onest 12 / 700, `onSurfaceVariant`, 16 horizontal, 4 haut, 8 bas.
- Cartes identiques, avec la date absolue (année si nécessaire).
- Aucun surlignage du terme dans le texte en v1 : le résultat est assez court pour être scanné.
- Requête conservée au retour de l'éditeur.

#### État vide (journal)

```
                 ┌────────────┐
                 │     ✎      │
                 └────────────┘
              Ton journal commence ici
     Touche un verset dans la Bible, puis « Note »,
          pour écrire ce qu'il te dit.

              [ Choisir un verset ]

        🔒 Tes notes restent sur ton téléphone.
```

| Élément | Spécification |
| --- | --- |
| Icône | cercle 72, fond `bible.soft`, `AppIcons.addNote` 32 `bible.onSoft` |
| Titre | `titleMedium` (17 / 700), `onSurface` |
| Corps | 15 / 1,4, `onSurfaceVariant`, centré, largeur max 320 |
| Bouton | `FilledButton.icon`, fond `bible.color`, blanc, `AppIcons.bible`, « Choisir un verset », min 48 haut |
| Ligne privée | 12,5 / 500, `onSurfaceVariant`, `AppIcons.private` 14 |
| Mise en page | `SingleChildScrollView` + centrage vertical, jamais de débordement à 200 % |

Le bouton ferme le journal et « Mes versets », puis ouvre l'onglet Bible (même pattern que l'état vide de `MemoryScreen`).

#### État « aucun résultat »

- Icône `AppIcons.search` 32 dans le cercle `bible.soft`.
- Titre : « Aucune note trouvée ».
- Corps : « Aucune note ne contient « {query} ». »
- Action : bouton texte « Effacer la recherche », 48 dp.
- Le champ de recherche reste visible au-dessus.

#### État d'erreur de lecture

- Bandeau discret sous l'en-tête, fond `errorContainer`, icône `AppIcons.error`, texte 13 / 1,4, `onErrorContainer` :
  > « Impossible de lire tes notes sur cet appareil. Une copie de secours a été gardée. »
- Pas d'action destructive. Le bandeau ne bloque pas la création d'une nouvelle note.
- Voir §9.3 pour la copie de secours.

#### Chargement

- Pas de squelette : `SharedPreferences` est local et synchrone. Le compte est déjà chargé quand la coquille est affichée.
- Si le compte n'est pas encore connu, l'écran affiche l'état vide ; aucune écriture n'est possible avant que le compte soit connu.

---

### 4.3 Éditeur de note

#### Structure

```
┌──────────────────────────────────────────────────────┐
│  ‹   Note                                      ⋮     │
│                                                      │
│  ┌────────────────────────────────────────────────┐  │
│  │ JEAN 3:16-17                          LSG      │  │
│  │ « Car Dieu a tant aimé le monde qu'il a…      │  │
│  │   …                                           │  │
│  │                                      Tout voir │  │
│  └────────────────────────────────────────────────┘  │
│                                                      │
│  TA NOTE                                             │
│  ┌────────────────────────────────────────────────┐  │
│  │ Qu'est-ce que ce passage te dit ?              │  │
│  │                                                │  │
│  │                                                │  │
│  │                                                │  │
│  │                                                │  │
│  │                                                │  │
│  └────────────────────────────────────────────────┘  │
│                                                      │
│  Créée le 12 octobre 2026 · modifiée le 25 oct.      │
│                                                      │
│  ┌────────────────────────────────────────────────┐  │
│  │                  Enregistrer                   │  │
│  └────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────┘
```

#### Barre supérieure

- Fond `scaffoldBackground`, pas d'ombre.
- Padding directionnel : 4 gauche, 4 haut, 16 droite.
- Retour 48 × 48 (`AppBackButton`), titre « Note » 22 / 800, menu ⋮ 48 × 48.
- Menu ⋮ (`AdaptiveMenuButton`), tooltip « Plus d'options » :
  - **Partager la note** (`AppIcons.share`) — seulement pour une note existante.
  - **Supprimer la note** (`AppIcons.delete`, destructif) — seulement pour une note existante.
- Le menu est un popup Material sur Android, une feuille d'actions sur iOS (comportement existant).
- Sur iPad, le partage est ancré au rectangle du bouton ⋮.

#### Carte du passage

- Marge : 24 horizontal, 8 haut.
- Fond `AppTones.bible.soft`, rayon 16, bord 1 `bible.onSoft` à 8 %.
- Padding 16.
- Ligne de référence :
  - Référence : Onest 14 / 800, `bible.onSoft`.
  - Pastille de version : texte 11 / 800, majuscules, letter-spacing 0,6, `bible.onSoft`, fond `bible.onSoft` à 10 %, rayon 6, padding 6 × 3.
  - En RTL de Bible (texte arabe), toute la carte suit la direction du passage (`Directionality.rtl`).
- Citation : Lora 16,5 / 400, hauteur 1,55, `onSurface`.
  - Repliée : 4 lignes maximum, ellipse.
  - Bouton « Tout voir » / « Réduire » aligné à la fin, 13 / 700, `bible.onSoft`, cible 48 dp. Affiché seulement si le texte dépasse 4 lignes (`TextPainter` avec le même style et la même largeur).
- La citation est en lecture seule, non sélectionnable en v1 (on la copie depuis la Bible si besoin).
- Si le passage couvre plusieurs versets, la référence est celle du label (`Jean 3:16-17`) et la citation les concatène dans l'ordre.
- Sémantique : « Passage. Jean 3:16-17, version LSG. [texte]. »

#### Champ « Ta note »

- Libellé visible : `TA NOTE`, Onest 12 / 800, letter-spacing 1,2, `onSurfaceVariant`, 24 haut / 8 bas, sémantique `header`.
- `TextField` :
  - `minLines: 6`, `maxLines: null` : il grandit avec le texte, jamais de hauteur fixe.
  - Padding interne 16.
  - Fond `surface`, bord `outlineVariant`, rayon 16 ; focus : bord `primary` 2 (thème existant).
  - Style : Onest 16,5 / 400, hauteur 1,55, `onSurface`.
  - Placeholder : « Qu'est-ce que ce passage te dit ? », 2 lignes maximum, `onSurfaceVariant` à 70 %.
  - `keyboardType: TextInputType.multiline`, `textInputAction: TextInputAction.newline`, `textCapitalization: sentences`.
  - `scrollPadding` bas de 120 pour que le curseur reste au-dessus de la barre d'enregistrement.
  - Autofocus : **oui** pour une nouvelle note, **non** pour une note existante (on lit d'abord, on touche pour modifier).
  - Pas de compteur de caractères. Pas d'objectif. Le journal n'est pas un exercice.
  - Tous les caractères sont acceptés (emoji, retours à la ligne, langues multiples).
- Le champ n'a pas de hauteur maximale ; la page défile.

#### Métadonnées

- Sous le champ, 12 haut.
- Onest 12,5 / 500, `onSurfaceVariant`, 2 lignes maximum.
- Nouvelle note : aucune métadonnée avant l'enregistrement. Le bouton suffit.
- Note existante : « Créée le 12 octobre 2026 » puis, si différente, « · Modifiée le 25 octobre 2026 ».
- Formats localisés : `d MMMM yyyy` via `context.formatDate`.
- Si les deux dates sont identiques : une seule ligne « Créée le … ».

#### Barre d'enregistrement

- Fond `scaffoldBackground`, bord supérieur 1 `outlineVariant`.
- Padding : 16 horizontal, 12 haut, 12 bas + `SafeArea`.
- `FilledButton` pleine largeur, min 56 (thème), fond `bible.color`, texte blanc, « Enregistrer ».
- Désactivé si :
  - le corps est vide (après `trim`), ou
  - aucune modification par rapport au texte d'origine.
- Pendant l'enregistrement : spinner 20 dans le bouton, bouton désactivé, retour bloqué.
- En cas d'échec : toast « Impossible d'enregistrer ta note. Réessaie. », l'éditeur reste ouvert, le bouton se réactive.
- Après succès : toast « Note enregistrée », retour à l'écran précédent.
- Pas de coche animée, pas de confettis : le toast suffit.

#### Dialogue de sortie

Titre : « Note non enregistrée »  
Texte : « Tu as écrit quelques mots. Que veux-tu faire ? »

| Action | Style | Effet |
| --- | --- | --- |
| Continuer à écrire | bouton texte neutre (annuler) | Ferme le dialogue, garde l'éditeur |
| Abandonner | bouton texte rouge (destructif) | Ferme l'éditeur sans enregistrer |
| Enregistrer | bouton plein `bible.color` | Enregistre puis ferme |

- Sur iOS : alerte Cupertino à trois actions. Sur Android : `AlertDialog` à trois actions.
- Si le corps est vide (note existante vidée), l'action « Enregistrer » est absente ; le dialogue propose « Continuer » et « Abandonner les modifications ».
- Une nouvelle note vide ne déclenche pas le dialogue.
- `PopScope` : le retour système et le bouton retour passent par ce dialogue. Le swipe arrière iOS est désactivé tant qu'il y a des modifications (comportement standard d'un éditeur).

#### Suppression

- Menu ⋮ → « Supprimer la note ».
- `showConfirmDialog(destructive: true)` :
  - Titre : « Supprimer cette note ? »
  - Texte : « Elle sera retirée de ton journal, sur ce téléphone. Cette action ne peut pas être annulée. »
  - Confirmer : « Supprimer » (rouge).
  - Annuler : « Annuler ».
- Après suppression : toast « Note supprimée », retour à l'écran précédent (journal ou Bible).
- La liste et l'icône du chapitre se mettent à jour immédiatement.

#### Partage d'une note

- Menu ⋮ → « Partager la note ».
- Texte partagé :

```text
Jean 3:16-17 (LSG)
« Car Dieu a tant aimé le monde… »

Ma note :
Ce que ce passage me dit…

— Journal biblique, 25 octobre 2026
```

- Sujet : « Note sur Jean 3:16-17 ».
- Feuille système uniquement ; aucun envoi automatique.
- En cas d'échec : toast « Impossible de partager. Réessaie. »

---

### 4.4 Barre d'actions des versets

#### Avant / après

La barre actuelle a deux lignes : référence + références croisées + mémoriser + concordance + fermer, puis les couleurs + garder + copier + partager. L'ajout d'une action « Note » ne doit pas la rendre illisible sur 320 dp.

**Nouvelle ligne 1**

```
Jean 3:16-17        [ ✎ Note ]   ⋮   ✕
```

- Référence : `Expanded`, 15 / 800, 1 ligne, ellipse.
- Pastille **Note** : hauteur 48, padding horizontal 12, rayon `AppRadius.md` (14), icône 20 + libellé 13,5 / 800, espace 6.
  - Sans note : fond `palette.text` à 8 %, bord 10 %, icône `AppIcons.addNote`, libellé « Note ».
  - Avec note : fond `palette.accent` à 12 %, bord 25 %, icône `AppIcons.edit`, libellé « Modifier ».
  - Sémantique : « Écrire une note sur Jean 3:16 » / « Modifier la note sur Jean 3:16 ».
  - Retour haptique `selectionClick`.
- Menu ⋮ : 48 × 48, tooltip « Plus d'options ».
- Fermer : 48 × 48, tooltip « Fermer la sélection ».

**Menu ⋮**

`showActionSheet` (popup Android, feuille iOS) avec le titre du passage :

| Action | Icône | Effet |
| --- | --- | --- |
| Références croisées | `AppIcons.crossReferences` | `CrossReferenceVerses` |
| Mémoriser | `AppIcons.memorize` | `MemorizeVerses` |
| Concordance | `AppIcons.concordance` | `ConcordanceVerses` |

Chaque ligne fait au moins 56 dp. Les actions sont ainsi à un tap, sans sacrifier la lisibilité de la barre. Elles restent aussi dans le menu ⋮ du chapitre.

**Ligne 2** (inchangée)

4 pastilles de couleur + retirer la couleur + garder + copier + partager. Les cibles restent ≥ 48 dp ; la ligne tient sur 320 dp.

#### Comportement

- Un tap sur **Note** ouvre l'éditeur :
  - si une note existe sur le **premier verset sélectionné** (ancre), elle s'ouvre en modification ;
  - sinon, une nouvelle note est préparée pour l'ensemble des versets sélectionnés (même non contigus).
- La sélection est refermée derrière l'éditeur.
- Au retour, le chapitre est inchangé ; l'icône de note apparaît sur le verset d'ancrage si la note a été enregistrée.
- Si plusieurs versets sont sélectionnés et qu'une note existe sur un autre verset que le premier, une nouvelle note est créée. C'est une limite connue de la v1 (voir §9.8).

#### Icône de note dans le chapitre

- À la fin du verset d'ancrage, après l'icône de favori s'il y en a un :
  - `WidgetSpan` avec `AppIcons.addNote`, taille `0.72 × taille du texte`, couleur `palette.accent`, padding directionnel de 4 au début.
  - Sémantique : « Note » (le verset reste un bouton).
- L'icône n'est pas cliquable séparément : toucher le verset le sélectionne, puis la pastille **Modifier** ouvre la note. Une cible de 20 px dans un texte serait trop petite.
- Si le favori et la note coexistent : favori puis note, espacés de 4.
- Micro-animation facultative : apparition en fondu/échelle 180 ms (`AppMotion.fast`, `AppMotion.pop`), supprimée si mouvement réduit. Elle ne doit pas attirer l'attention plus que le texte.

---

### 4.5 Feuille « Partager le journal »

- `showModalBottomSheet`, `showDragHandle: true`, `useSafeArea: true`.
- Titre : « Partager le journal », `titleLarge`.
- Texte d'aide : « Un fichier texte, lisible partout. Il ne quitte ton téléphone que si tu le partages. » 13 / 1,4, `onSurfaceVariant`.
- Deux lignes dans une `SectionCard` :
  1. **Partager le fichier (.txt)** — `AppIcons.share`, sous-titre « 12 notes · 25 octobre 2026 ». Ouvre la feuille système avec un fichier UTF-8.
  2. **Copier le texte** — `AppIcons.copy`, sous-titre « Pour le coller dans une autre application ». Toast « Journal copié ».
- Chaque ligne ≥ 56 dp, séparateur `outlineVariant`.
- Le partage porte toujours sur **tout le journal**, jamais sur les résultats filtrés : le sous-titre le dit. Pour une note, on partage depuis l'éditeur.
- Nom du fichier : `journal-biblique_2026-10-25.txt`, MIME `text/plain`.
- Sujet : « Journal biblique · 25 octobre 2026 ».
- Si le partage échoue : toast « Impossible de partager. Réessaie. »
- Pas de PDF en v1 (v2).

---

## 5. Design system

### 5.1 Couleurs

Aucune nouvelle couleur codée en dur. On utilise les tokens existants.

| Usage | Clair | Sombre |
| --- | --- | --- |
| Fond d'écran | `scheme.surfaceContainerLow` / `scaffoldBackground` (#F3F6FA) | `scaffoldBackground` (#0C121B) |
| Carte de note | `scheme.surface` (#FFFFFF) | `scheme.surface` (#131A24) |
| Bord de carte | `scheme.outlineVariant` (#DFE6EF) | `scheme.outlineVariant` (#283240) |
| Carte Journal | `AppTones.bible.soft` (#F8E6E8) | `AppTones.bible.soft` (#3B1D22) |
| Texte/icône sur carte Journal | `AppTones.bible.onSoft` (#8A2534) | `AppTones.bible.onSoft` (#F2AEB7) |
| Tuile d'icône Journal | `AppTones.bible.color` (#9A2E3D) + blanc | idem |
| Carte du passage | `AppTones.bible.soft` | `AppTones.bible.soft` |
| Citation | `scheme.onSurface` (#0F1A2A) | `scheme.onSurface` (#E3E9F1) |
| Texte secondaire | `scheme.onSurfaceVariant` (#556375) | `scheme.onSurfaceVariant` (#A2AFBF) |
| Action principale | `AppTones.bible.color` (#9A2E3D) + blanc | idem |
| Danger | `scheme.error` (#A0362A) | `scheme.error` (#F0A496) |
| Erreur douce | `scheme.errorContainer` | `scheme.errorContainer` |

**Interdits** : `AppColors.gold` (réservé aux célébrations), les couleurs de module autres que `bible`, le blanc pur sur fond clair, les dégradés. Le journal est calme.

**Contraste** : `bible.onSoft` sur `bible.soft` est prévu pour le texte (ratio > 7:1 dans les deux modes). Le texte de note sur `surface` suit `onSurface`. La version et les dates restent à 4,5:1 minimum. Vérifier avec le thème réel ; ne pas éclaircir `onSoft` en sombre.

### 5.2 Typographie

| Élément | Police | Taille / graisse / interligne |
| --- | --- | --- |
| Titre d'écran | Onest | 22 / 800 (`titleLarge`) |
| Titre de carte Journal | Onest | 16 / 800 |
| Sous-titre de carte Journal | Onest | 13 / 500, 78 % |
| En-tête de mois | Onest | 12 / 800, ls 1,2, majuscules |
| Référence de note | Onest | 13,5 / 800 |
| Version | Onest | 11 / 800, ls 0,6, majuscules |
| Date | Onest | 12 / 500 |
| Corps de note (liste) | Onest | 15 / 400, hauteur 1,45 |
| Citation (liste) | Lora | 14 / 400, hauteur 1,45 |
| Référence (éditeur) | Onest | 14 / 800 |
| Citation (éditeur) | Lora | 16,5 / 400, hauteur 1,55 |
| Champ d'écriture | Onest | 16,5 / 400, hauteur 1,55 |
| Métadonnées | Onest | 12,5 / 500 |
| Bouton | Onest | 16 / 600 (thème) |
| État vide, titre | Onest | 17 / 700 (`titleMedium`) |
| État vide, corps | Onest | 15 / 400, hauteur 1,4 |

**Règle de distinction** : Lora uniquement pour les citations bibliques. Le texte de la personne qui écrit reste en Onest. C'est une distinction de sens, pas seulement de style : la Parole et tes mots ne se confondent pas.

**Aucune hauteur fixe sur un texte.** Les `maxLines` ne servent que dans les listes (extraits), jamais dans l'éditeur ni dans la carte du passage repliée (qui peut s'étendre).

### 5.3 Espacements et rayons

| Usage | Valeur |
| --- | --- |
| Marge d'écran (liste) | 16 (`AppSpacing.lg`) |
| Marge d'écran (éditeur) | 24 (`AppSpacing.xl`) |
| Padding de carte | 14 |
| Gap icône ↔ texte | 12 (`AppSpacing.md`) |
| Gap entre cartes | 8 (`AppSpacing.sm`) |
| Gap titre ↔ sous-titre | 2 |
| Gap référence ↔ corps | 5 |
| Gap corps ↔ citation | 6 |
| Rayon des cartes | 16 (`AppRadius.lg`) |
| Rayon des tuiles d'icône | 14 / 12 |
| Rayon du champ et du bouton | 16 (thème) |
| Hauteur de cible | ≥ 48 |
| Hauteur du bouton principal | 56 (thème) |
| Largeur max du corps de l'éditeur (≥ 700 dp) | 680, centré |
| Largeur max de la liste (≥ 700 dp) | 720, centrée |

Sur iPad, le corps de l'éditeur est centré et limité à 680 dp pour garder des lignes lisibles. L'en-tête reste pleine largeur, comme le reste de l'app.

### 5.4 Icônes

| Usage | Icône |
| --- | --- |
| Journal / note | `AppIcons.addNote` (`notePencil`) |
| Modifier | `AppIcons.edit` (`pencilSimple`) |
| Recherche | `AppIcons.search` |
| Partage | `AppIcons.share` |
| Copier | `AppIcons.copy` |
| Supprimer | `AppIcons.delete` |
| Privé | `AppIcons.private` (`lockSimple`) |
| Retour | `AppIcons.back` |
| Chevron | `AppIcons.chevronRight` / `chevronLeft` selon la direction |
| Erreur | `AppIcons.error` |
| Bible (état vide) | `AppIcons.bible` |

Toutes les icônes passent par `AppIcons`. Aucune icône `Icons.*` directe. Les icônes décoratives sont exclues de la sémantique ; les icônes porteuses de sens ont un label.

### 5.5 Mouvement

| Moment | Mouvement |
| --- | --- |
| Ouverture de l'écran / éditeur | Transition adaptative de route existante |
| Appui sur une carte | Ripple Material standard |
| Apparition de l'icône de note | Fondu/échelle 180 ms, optionnel |
| Changement de résultats de recherche | Fondu 180 ms, optionnel |
| Enregistrement | Aucun ; toast et retour |
| Suppression | Dialogue standard ; pas d'animation de liste |
| Réduction du mouvement | `AppMotion.of` / `AppMotion.reduced` : durées nulles |

Pas d'animation en boucle, pas de confettis, pas de pulsation, pas de compteur animé. Le journal ne récompense pas ; il accompagne.

### 5.6 Composants existants réutilisés

| Besoin | Composant |
| --- | --- |
| En-tête + retour | `SubPage`, `AppBackButton` |
| Carte d'action | `Material` + `InkWell` (comme `_MarkTile`) |
| Bouton principal | `FilledButton` (thème) / `AppButton` si pas de couleur de module |
| Confirmation | `showConfirmDialog` |
| Menu d'actions | `AdaptiveMenuButton`, `showActionSheet` |
| Toast | `toasterProvider` / `ToastMessenger` |
| Partage | `shareServiceProvider` (`shareText`, `shareFile`) |
| Libellé de section | `SectionLabel` |
| État vide | motif `_Empty` existant, extrait en composant partagé si utile |
| Dialogue de saisie | `showAppDialog` / `CupertinoAlertDialog` pour le dialogue à trois choix |

### 5.7 Composants à créer

| Composant | Rôle |
| --- | --- |
| `JournalCard` | Carte d'entrée dans « Mes versets » |
| `NoteTile` | Carte d'une note dans la liste |
| `JournalEmpty` | État vide du journal (icône, titre, corps, action, ligne privée) |
| `JournalSearchEmpty` | État « aucun résultat » |
| `NoteExitDialog` | Dialogue à trois choix (continuer / abandonner / enregistrer) |
| `JournalShareSheet` | Feuille de partage du journal |
| `NoteQuoteCard` | Carte du passage dans l'éditeur (référence, version, citation, tout voir) |

Chaque composant est `StatelessWidget` ou `HookWidget`, sans logique métier, et reçoit ses textes via `context.t`.

---

## 6. Accessibilité

### 6.1 Cibles tactiles

- Toute action ≥ 48 × 48 : retour, ⋮, partage, recherche, croix, pastille Note, bouton Enregistrer, cartes.
- Les pastilles de couleur existantes gardent leur zone de 48 via `InkResponse` (rayon 24) ; ne pas les réduire.
- Le chevron d'une carte ne crée pas une cible séparée : toute la carte est la cible.
- La pastille de version n'est pas cliquable.

### 6.2 Structure et annonces

- Titre d'écran : `Semantics(header: true)` (déjà dans `SubPage`).
- En-têtes de mois : `Semantics(header: true)`.
- Carte Journal : un seul bouton, label complet (titre, nombre, dernière référence), hint « Ouvre ton journal ».
- Carte de note : un seul bouton, label « Note sur {référence}, version {version}. Créée le {date}. {début du corps} », hint « Ouvre la note ».
- Pastille Note : bouton, label « Écrire une note sur {référence} » / « Modifier la note sur {référence} ».
- Champ d'écriture : annoncé « Ta note, zone de texte » ; le placeholder donne l'invitation.
- Carte du passage : annoncée « Passage. {référence}, version {version}. {texte} ».
- Bouton Enregistrer : état désactivé annoncé quand le champ est vide ou inchangé.
- Suppression : action destructive annoncée.
- Après enregistrement/suppression : le toast est déjà annoncé par `ToastMessenger` (`SemanticsService.sendAnnouncement`).
- Les icônes purement décoratives sont `ExcludeSemantics`.

### 6.3 Texte et mise en page

- Tester à 100 %, 130 % et 200 % de taille de texte.
- Aucune hauteur fixe de texte ; les cartes grandissent.
- Les extraits de liste sont limités à 2 lignes (corps) et 1 ligne (citation) ; c'est le seul endroit où du texte est tronqué, et l'éditeur donne le texte complet.
- La référence, la version et la date sont dans un `Wrap`, jamais dans une `Row` rigide.
- Le dialogue de sortie et la feuille de partage défilent si nécessaire.
- L'état vide est dans un `SingleChildScrollView` centré, pour ne jamais déborder sur un petit écran.

### 6.4 Clavier et focus

- Nouvelle note : focus dans le champ après la transition, clavier ouvert.
- Note existante : pas d'autofocus ; l'écran se lit, un tap dans le champ active l'édition.
- `textInputAction: newline` : la touche Entrée écrit un retour à la ligne, elle ne ferme pas l'éditeur.
- Ordre de focus : retour → ⋮ → « Tout voir » (si présent) → champ → Enregistrer.
- Le bouton Enregistrer reste au-dessus du clavier, jamais masqué.
- Le retour système avec le clavier ouvert ferme d'abord le clavier ; un second retour déclenche le dialogue de sortie.
- Le swipe arrière iOS est désactivé quand il y a des modifications (le bouton retour reste disponible).

### 6.5 RTL

- Toutes les marges et positions utilisent `EdgeInsetsDirectional`, `AlignmentDirectional`, `PositionedDirectional`.
- Le chevron de la carte Journal est inversé en RTL (`chevronLeft`).
- La carte du passage suit la direction de la version biblique (`note.rtl`), même si l'interface est en français : une citation arabe reste RTL, alignée à droite.
- Le corps de la note suit la direction de l'interface ; le texte bidi est géré par Flutter.
- Les en-têtes de mois et les dates sont localisés (`DateFormat` avec la locale de l'app).
- Tester avec la locale arabe et avec une citation arabe dans une interface française.
- Les nombres et la ponctuation restent ceux de la locale.

### 6.6 Mouvement réduit

- `AppMotion.of(context, …)` pour toutes les animations.
- Si `MediaQuery.disableAnimations` est vrai : pas de fondu, pas d'échelle, pas de transition personnalisée au-delà de la route standard.
- Le journal reste utilisable sans aucune animation.

### 6.7 Contraste

- Vérifier `bible.onSoft` sur `bible.soft` dans les deux modes (texte normal et petit).
- Vérifier `onSurfaceVariant` sur `surface` pour les dates et légendes.
- Vérifier le bouton `bible.color` + blanc (état normal, désactivé, focus).
- Ne pas utiliser la couleur seule pour distinguer « note existante » : le libellé change (« Note » → « Modifier ») et l'icône change.
- Le focus clavier (iPad avec clavier) doit être visible : utiliser le focus ring Material par défaut, ne pas le supprimer.

### 6.8 Matrice de tests d'accessibilité

| Test | Attendu |
| --- | --- |
| TalkBack / VoiceOver sur la carte Journal | Un bouton, annonce complète, pas de doublon |
| TalkBack / VoiceOver sur une carte de note | Un bouton, référence + date + début du corps |
| TalkBack / VoiceOver sur la pastille Note | « Écrire/Modifier une note sur … » |
| TalkBack / VoiceOver dans l'éditeur | Passage, champ, bouton désactivé/actif, dialogue |
| Texte à 200 % | Aucun débordement ; les cartes grandissent ; le bouton reste lisible |
| RTL | Chevrons, marges, citation arabe, dates |
| Mouvement réduit | Aucune animation, mêmes parcours |
| Contraste | Textes ≥ 4,5:1 ; éléments non textuels ≥ 3:1 |
| Clavier iPad | Focus visible, ordre logique, pas de piège |

---

## 7. Microcopy

### 7.1 Ton

- Tutoiement, chaleureux, direct, jamais pressé.
- On parle de « note », de « passage », de « journal ».
- On ne parle pas de « performance », de « série », d'« objectif », de « score ».
- On ne culpabilise pas : pas de « tu n'as pas encore écrit », pas de « dernière chance ».
- On ne promet pas de synchronisation ni de chiffrement.
- On dit « sur ton téléphone », pas « dans le cloud ».
- Les erreurs disent quoi faire : « Réessaie. », « Choisis un verset. ».

### 7.2 Chaînes françaises

| Clé | Français | Contexte |
| --- | --- | --- |
| `bible.journal.title` | Journal biblique | Titre d'écran et carte |
| `bible.journal.cardEmpty` | Touche un verset, puis Note. | Sous-titre de carte sans note |
| `bible.journal.count(plural, param=n)` | `{n} note` / `{n} notes` | Compteur informatif |
| `bible.journal.note` | Note | Pastille d'action |
| `bible.journal.edit` | Modifier | Pastille quand une note existe |
| `bible.journal.writeNote(reference)` | Écrire une note sur {reference} | Sémantique / tooltip |
| `bible.journal.editNote(reference)` | Modifier la note sur {reference} | Sémantique / tooltip |
| `bible.journal.quoteLabel` | Passage | Sémantique de la carte |
| `bible.journal.bodyLabel` | Ta note | Libellé du champ |
| `bible.journal.placeholder` | Qu'est-ce que ce passage te dit ? | Placeholder |
| `bible.journal.save` | Enregistrer | Bouton |
| `bible.journal.saved` | Note enregistrée | Toast |
| `bible.journal.saveFailed` | Impossible d'enregistrer ta note. Réessaie. | Erreur |
| `bible.journal.createdOn(date)` | Créée le {date} | Métadonnée |
| `bible.journal.modifiedOn(date)` | Modifiée le {date} | Métadonnée |
| `bible.journal.modifiedShort` | modifiée | Liste, après la date |
| `bible.journal.showMore` | Tout voir | Citation repliée |
| `bible.journal.showLess` | Réduire | Citation dépliée |
| `bible.journal.searchHint` | Chercher dans le journal | Champ |
| `bible.journal.search` | Chercher dans le journal | Sémantique |
| `bible.journal.clearSearch` | Effacer la recherche | Bouton |
| `bible.journal.results(plural, param=n)` | `{n} résultat` / `{n} résultats` | Résultats |
| `bible.journal.searchNone(query)` | Aucune note ne contient « {query} ». | Aucun résultat |
| `bible.journal.noResultsTitle` | Aucune note trouvée | Titre |
| `bible.journal.emptyTitle` | Ton journal commence ici | État vide |
| `bible.journal.emptyText` | Touche un verset dans la Bible, puis « Note », pour écrire ce qu'il te dit. | État vide |
| `bible.journal.openBible` | Choisir un verset | Bouton |
| `bible.journal.privacy` | Tes notes restent sur ton téléphone. | Pied de liste / état vide |
| `bible.journal.privacyBackup` | Tes notes restent sur ton téléphone. Pense à en garder une copie. | Pied de liste |
| `bible.journal.readFailed` | Impossible de lire tes notes sur cet appareil. Une copie de secours a été gardée. | Bandeau |
| `bible.journal.shareJournal` | Partager le journal | Titre de feuille |
| `bible.journal.shareHelp` | Un fichier texte, lisible partout. Il ne quitte ton téléphone que si tu le partages. | Aide |
| `bible.journal.shareFile` | Partager le fichier (.txt) | Action |
| `bible.journal.shareFileHelp(n, date)` | {n} notes · {date} | Sous-titre |
| `bible.journal.copy` | Copier le texte | Action |
| `bible.journal.copyHelp` | Pour le coller dans une autre application | Sous-titre |
| `bible.journal.copied` | Journal copié | Toast |
| `bible.journal.shareFailed` | Impossible de partager. Réessaie. | Erreur |
| `bible.journal.shareNote` | Partager la note | Menu |
| `bible.journal.delete` | Supprimer la note | Menu |
| `bible.journal.deleteTitle` | Supprimer cette note ? | Confirmation |
| `bible.journal.deleteText` | Elle sera retirée de ton journal, sur ce téléphone. Cette action ne peut pas être annulée. | Confirmation |
| `bible.journal.deleted` | Note supprimée | Toast |
| `bible.journal.deleteFailed` | Impossible de supprimer la note. Réessaie. | Erreur |
| `bible.journal.exitTitle` | Note non enregistrée | Dialogue |
| `bible.journal.exitText` | Tu as écrit quelques mots. Que veux-tu faire ? | Dialogue |
| `bible.journal.exitKeep` | Continuer à écrire | Dialogue |
| `bible.journal.exitDiscard` | Abandonner | Dialogue |
| `bible.journal.exitSave` | Enregistrer | Dialogue |
| `bible.journal.hasNote` | Note | Sémantique de l'icône |
| `bible.journal.version` | Version {version} | Sémantique / export |
| `bible.journal.subject` | Journal biblique · {date} | Sujet de partage |
| `bible.journal.noteSubject` | Note sur {reference} | Sujet de partage |
| `bible.journal.noteMissing` | Cette note n'existe plus. | Erreur rare |

**Pluriels** : utiliser la syntaxe slang `count(plural, param=n)` ; ne jamais écrire « 1 notes ».

### 7.3 i18n

- Toutes les chaînes passent par `context.t` ; pas de texte en dur.
- Locales : `fr`, `en`, `de`, `es`, `ar`, `zh`, `hi`.
- Le français est la base ; les autres langues sont traduites avant fusion.
- Ton informal selon la langue (de « du », es « tú», ar « أنت ») pour rester cohérent avec le reste de l'app.
- Regénérer `strings*.g.dart` avec `make gen` (slang).
- Les clés de date/passage utilisent `DateFormat` localisé, jamais un format codé en dur.

### 7.4 Ce qu'on n'écrit pas

| À éviter | Pourquoi | À la place |
| --- | --- | --- |
| « Tu n'as pas écrit depuis 7 jours » | Culpabilise | Rien ; le journal est disponible quand tu veux |
| « Série de 3 notes ! » | Transforme en performance | Rien |
| « Objectif : 5 notes cette semaine » | Pression | Rien |
| « Bravo, tu es dans le top 10 » | Classement public | Rien |
| « Synchronise tes notes » | Faux en v1 | « Tes notes restent sur ton téléphone » |
| « Tes notes sont chiffrées » | Faux en v1 | « Tes notes restent sur ton téléphone » |
| « Publie ta note » | Collectif | « Partager la note » (feuille système) |
| « Note secrète » | Mystérieux, anxiogène | « Tes notes restent sur ton téléphone » |

---

## 8. Modèle de données et logique

### 8.1 Modèle

```dart
@freezed
abstract class BibleNote with _$BibleNote {
  const factory BibleNote({
    /// L'ancre : la clé du premier verset ("JHN.3.16").
    required String id,
    required String book,          // "JHN"
    required int chapter,          // 3
    required List<int> verses,     // [16, 17], triés, uniques
    required String version,       // "LSG"
    required String label,         // "Jean 3:16-17", secours hors ligne
    required String text,          // le passage tel qu'il a été lu
    required String body,          // la note, retours à la ligne conservés
    required bool rtl,             // la version biblique est RTL
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BibleNote;

  const BibleNote._();

  factory BibleNote.fromJson(Map<String, dynamic> json) =>
      _$BibleNoteFromJson(json);

  BibleRef get anchor => BibleRef(book, chapter, verses.first);

  bool covers(BibleRef ref) =>
      ref.book == book &&
      ref.chapter == chapter &&
      ref.verse != null &&
      verses.contains(ref.verse);
}
```

**Invariants**

- `id == anchor.key` ; à la lecture, si l'id ne correspond pas, on le recalcule ou on ignore l'entrée corrompue.
- `verses` est non vide, trié, sans doublon.
- `body.trim()` est non vide dans le stockage.
- `createdAt <= updatedAt`.
- `label` est un secours ; l'affichage préfère `bibleLabel` avec les livres chargés.
- `rtl` vient de `BibleVersion.rtl` au moment de la création.
- Le passage est immuable : on ne change pas ses versets après création (on peut supprimer et recréer).

### 8.2 Brouillon d'éditeur

```dart
class BibleNoteDraft {
  const BibleNoteDraft({
    required this.book,
    required this.chapter,
    required this.verses,
    required this.version,
    required this.label,
    required this.text,
    required this.rtl,
  });

  final String book;
  final int chapter;
  final List<int> verses;
  final String version;
  final String label;
  final String text;
  final bool rtl;

  BibleRef get anchor => BibleRef(book, chapter, verses.first);
}
```

L'éditeur reçoit soit un `noteId` (note existante), soit un `BibleNoteDraft` (nouvelle note). Jamais les deux, jamais aucun.

### 8.3 Stockage

**Clé** : `bible_notes_<accountId>` (par compte, pour qu'un autre compte sur le même téléphone ne voie rien).

**Format** : enveloppe versionnée, pour pouvoir migrer vers plusieurs notes par passage ou des tags plus tard.

```json
{
  "version": 1,
  "notes": [
    {
      "id": "JHN.3.16",
      "book": "JHN",
      "chapter": 3,
      "verses": [16, 17],
      "version": "LSG",
      "label": "Jean 3:16-17",
      "text": "Car Dieu a tant aimé le monde…",
      "body": "Ce que ce passage me dit…",
      "rtl": false,
      "createdAt": "2026-10-12T21:14:00.000",
      "updatedAt": "2026-10-25T08:02:00.000"
    }
  ]
}
```

- `SharedPreferences` (même famille que `BibleMarks`), une seule chaîne JSON.
- Écriture : sérialiser la **future** carte, appeler `setString`, vérifier le booléen, puis mettre à jour l'état. En cas d'échec, l'état reste l'ancien et l'éditeur affiche une erreur.
- Lecture : si le JSON est invalide, retourner une carte vide, copier la chaîne brute dans `bible_notes_corrupt_<accountId>` (sauvegarde de secours) et exposer un drapeau `corrupt` pour le bandeau. Ne jamais écraser la copie de secours tant qu'une nouvelle sauvegarde n'a pas réussi.
- Taille : si la chaîne dépasse ~256 Ko, logguer un avertissement en debug. Ne jamais tronquer. Prévoir un stockage fichier en v2 si l'usage dépasse ce seuil.
- Pas de chiffrement applicatif en v1 : les notes sont dans le sandbox de l'OS, comme les favoris. Ne pas promettre davantage dans l'UI.
- Pas de migration d'une clé globale : la fonctionnalité est neuve ; la clé par compte est la seule.

**Suppression des données**

- Suppression d'une note : retirer la note, réécrire le JSON.
- Suppression du compte : `eraseAll()` avant `session.signOut()` dans `MyAccount.deleteAccount`, puis mise à jour du texte de suppression de compte pour lister « tes notes du journal biblique, gardées sur ce téléphone ».
- Déconnexion simple : **on garde** les notes sous la clé du compte. Un autre compte ne les voit pas ; le même compte les retrouve en se reconnectant.
- Désinstallation : les notes sont perdues (pas de backend). L'export `.txt` est la sauvegarde.

### 8.4 Provider

```dart
@Riverpod(keepAlive: true)
class BibleNotes extends _$BibleNotes {
  static const _prefix = 'bible_notes';

  @override
  Map<String, BibleNote> build() { ... }

  /// La note dont l'ancre est [ref], ou null.
  BibleNote? forAnchor(BibleRef ref);

  /// La note qui couvre [ref] (ancre ailleurs), ou null.
  BibleNote? covering(BibleRef ref);

  /// Crée ou met à jour la note du brouillon.
  Future<BibleNote> save({
    required BibleNoteDraft draft,
    required String body,
    BibleNote? existing,
  });

  Future<void> delete(String id);
  Future<void> eraseAll();

  /// Les notes qui contiennent tous les mots de [query].
  List<BibleNote> search(String query, {String Function(BibleNote)? labelOf});

  /// La chronologie, la plus récente d'abord.
  List<BibleNote> get timeline;
}
```

- `save` : `id = draft.anchor.key`. Si `existing` est fourni, on garde `createdAt` et on met `updatedAt = now` ; sinon les deux valent `now`. Le corps est `trim()`é aux extrémités, les retours à la ligne internes sont conservés. Un corps vide lève une erreur (l'UI l'empêche).
- `delete` : si l'écriture échoue, l'état ne change pas.
- `search` : voir §8.5.
- `timeline` : tri `createdAt` décroissant, puis `id` pour un ordre stable.
- Le provider dépend de `signedInAccountProvider` pour la clé. Si le compte est null, la carte est vide et les écritures échouent proprement.

### 8.5 Recherche

- Normalisation avec `normalizeBibleText` (casse, accents latins, voyelles arabes).
- Requête découpée en mots ; **tous** les mots doivent apparaître (ET), comme une recherche utile.
- Haystack : `body + label + text + version + labelOf(note)`.
- Résultats triés par `createdAt` décroissant.
- Recherche vide → toute la chronologie.
- Pas de recherche floue, pas d'historique, pas de surlignage en v1.
- 250 ms de debounce côté UI ; le provider reste synchrone et rapide pour quelques centaines de notes.

### 8.6 Export

- Ordre d'export : **création croissante** (du plus ancien au plus récent), pour lire le journal comme un livre. L'écran, lui, affiche le plus récent en haut.
- En-tête :

```text
Journal biblique
Exporté le 25 octobre 2026 · 12 notes
```

- Mois :

```text
OCTOBRE 2026
```

- Une note :

```text
Jean 3:16-17 (LSG)
« Car Dieu a tant aimé le monde qu'il a donné son Fils unique… »

Ce que ce passage me dit…

  Créée le 12 octobre 2026 · modifiée le 25 octobre 2026
```

- Séparateur entre notes :

```text
────────────────────────────
```

- Texte brut UTF-8, guillemets français autour de la citation, corps tel quel (retours à la ligne conservés).
- Aucune donnée personnelle dans l'en-tête (pas de nom, pas de téléphone, pas d'identifiant).
- Nom : `journal-biblique_2026-10-25.txt`.
- Sujet : `Journal biblique · 25 octobre 2026`.
- Note seule : pas d'en-tête de journal, sujet `Note sur Jean 3:16-17`.
- PDF : v2.

### 8.7 Dates, versions, RTL

- Dates locales (`DateTime.now()`), stockées en ISO 8601 local.
- Affichage : `context.formatDate` (`d MMM`, `d MMMM yyyy`) ; en-têtes de mois `DateFormat.yMMMM(locale)`.
- `updatedAt` n'est affiché comme « modifiée » que s'il dépasse `createdAt` de plus de 24 h (la liste) ; l'éditeur affiche les deux dates si elles diffèrent.
- La version est stockée en abréviation (« LSG »). Le texte est mis en cache : un changement de version ne change pas la note.
- `rtl` est stocké pour rendre la citation correctement sans charger la version.
- Le label est un secours ; l'écran préfère `bibleLabel` avec les livres de la version courante, comme `BibleMarksScreen`. Si les livres ne sont pas chargés, le secours s'affiche.

### 8.8 Cas limites

| Cas | Comportement |
| --- | --- |
| Note vide | Pas de bouton actif, pas de création |
| Note existante vidée | Enregistrer désactivé ; suppression via le menu uniquement |
| Versets non contigus | `verses` contient la liste triée, le label affiche « Jean 3:16, 18 » |
| Note sur le verset 16, sélection 16-17 | Ouvre la note existante (ancre 16) ; la note garde son passage |
| Note sur le verset 17, sélection 16-17 | Une nouvelle note est créée sur l'ancre 16 ; limite connue |
| Deux notes qui se chevauchent (ancres 16 et 17) | Autorisé, rare ; l'icône n'apparaît que sur chaque ancre |
| Version biblique changée | La note garde son texte et sa version ; l'icône reste sur la référence |
| Livres non chargés (hors ligne) | Label de secours stocké |
| JSON corrompu | Copie de secours + bandeau, journal vide, création possible |
| Écriture échouée | Toast, éditeur ouvert, état inchangé |
| Compte changé | Le provider se reconstruit sur la nouvelle clé ; l'autre journal est invisible |
| Compte supprimé | Notes effacées avant la déconnexion |
| App tuée avec un brouillon | Le brouillon est perdu en v1 (pas d'autosave) ; le dialogue protège seulement la navigation |
| Très longue note | La liste tronque à 2 lignes ; l'éditeur et l'export ont tout |
| Texte à 200 % | Cartes et dialogues grandissent, pas de débordement |
| Citation RTL | Direction du passage, alignement cohérent |
| Partage annulé | Rien ne part, aucun message d'erreur |
| Partage échoué | Toast d'erreur |

---

## 9. Vie privée, collectif, gamification

### 9.1 La promesse

> Tes notes restent sur ton téléphone. Personne d'autre ne les voit dans l'application.

C'est vrai en v1 : pas de backend, pas de synchronisation, pas d'envoi automatique, pas de fil collectif. Le partage est un geste explicite vers la feuille système.

Nuance honnête : les notes sont dans le stockage privé de l'app, protégé par le sandbox de l'OS ; elles ne sont pas chiffrées par l'app. Ne pas promettre de chiffrement de bout en bout.

### 9.2 Ce que le journal ne fait pas

| Tentation | Décision | Raison |
| --- | --- | --- |
| Points / XP par note | Non | Le journal n'est pas un jeu |
| Série de jours d'écriture | Non | La fidélité n'est pas une flamme à entretenir |
| Badge « première note », « 10 notes » | Non | Récompense externe, pression |
| Objectif hebdomadaire | Non | Le journal ne se mesure pas |
| Classement public | Non | Comparaison, exposition |
| Partage vers le fil communautaire | Non | Le journal est intime |
| Rappel « tu n'as pas écrit » | Non | Culpabilisation |
| Notification de relance | Non en v1 | Aucun besoin démontré ; un rappel doux et optionnel en v2 au plus |
| Journal premium | Non | Pas de fonctionnalité payante |
| Confettis / célébration | Non | Le calme est la récompense |
| Compteur de notes | Oui, informatif | Il aide à naviguer, pas à se comparer |

Le nombre de notes est une information de navigation, pas un score. Il n'est jamais coloré comme une récompense, jamais comparé, jamais partagé automatiquement.

### 9.3 Collectif

- Aucune agrégation anonyme des notes.
- Aucune note visible dans « Mes disciples », les comptes rendus, les demandes de prière ou le fil de la communauté.
- Le seul partage est manuel, vers une personne ou une application choisie via la feuille système.
- Le journal ne crée aucune notification collective.

### 9.4 Compte et appareil

- Les notes sont liées au compte sur ce téléphone (`bible_notes_<accountId>`).
- Se déconnecter ne les efface pas ; se reconnecter avec le même compte les retrouve.
- Un autre compte sur le même téléphone ne les voit pas.
- Supprimer le compte les efface (voir §8.3) et le texte de suppression de compte le mentionne.
- Changer de téléphone ou réinstaller ne les transfère pas : exporter avant.

### 9.5 Analytics et journaux

- Aucun événement analytics lié au contenu, au nombre de notes ou à l'usage du journal.
- Ne jamais logger le corps d'une note, la référence ou le JSON local.
- Les rapports de crash ne doivent pas inclure le contenu.
- Si un analytics existe déjà dans l'app, ne pas l'étendre au journal sans décision explicite.

### 9.6 Backend

- Aucun endpoint, aucune migration serveur, aucun WebSocket, aucun push.
- Le journal est une fonctionnalité 100 % locale en v1.
- Une synchronisation future devrait être une décision produit distincte (chiffrement, consentement, conflits, suppression).

---

## 10. Plan de livraison

### 10.1 Découpage

| Étape | Contenu | Résultat visible |
| --- | --- | --- |
| 1. Modèle et stockage | `BibleNote`, `BibleNoteDraft`, provider, JSON par compte, tests unitaires | Les notes peuvent être créées/lues en test, sans UI |
| 2. Éditeur | Écran, carte du passage, champ, enregistrement, dialogue de sortie, suppression, partage d'une note | Écrire une note depuis un brouillon |
| 3. Intégration Bible | Pastille Note, menu ⋮, icône du chapitre, navigation | Écrire depuis un verset |
| 4. Journal | Carte dans « Mes versets », écran, chronologie, recherche, états vides | Relire et chercher |
| 5. Partage | Feuille, export `.txt`, copie, tests | Sauvegarder/partager |
| 6. Finition | i18n complet, sombre, RTL, 200 %, mouvement réduit, sémantique, suite complète, `flutter analyze` | Prêt à relire |

**Ordre recommandé** : 1 → 2 → 3 → 4 → 5 → 6. Les étapes 2 et 3 peuvent être relues ensemble ; l'étape 4 est indépendante de l'entrée Bible.

### 10.2 Fichiers

**Nouveaux**

- `lib/src/features/bible/domain/bible_note.dart`
- `lib/src/features/bible/domain/journal_export.dart`
- `lib/src/features/bible/application/bible_notes.dart`
- `lib/src/features/bible/presentation/bible_journal_screen.dart`
- `lib/src/features/bible/presentation/bible_note_screen.dart`
- `lib/src/features/bible/presentation/widgets/journal_card.dart`
- `lib/src/features/bible/presentation/widgets/note_tile.dart`
- `lib/src/features/bible/presentation/widgets/journal_share_sheet.dart`
- `test/features/bible/journal_test.dart`
- `test/features/bible/journal_export_test.dart`

**Modifiés**

- `lib/src/features/bible/presentation/bible_marks_screen.dart` (carte Journal)
- `lib/src/features/bible/presentation/bible_screen.dart` (action Note, navigation)
- `lib/src/features/bible/presentation/widgets/verse_actions.dart` (pastille, menu ⋮)
- `lib/src/features/bible/presentation/widgets/chapter_view.dart` (icône de note)
- `lib/src/routing/app_router.dart` + générés (`/bible/journal`, `/bible/journal/note`)
- `lib/src/core/i18n/*.i18n.json` + `strings*.g.dart`
- `lib/src/features/members/application/my_account.dart` (effacement à la suppression du compte)
- `lib/src/features/members/presentation/delete_account_screen.dart` + i18n (mention du journal)
- `test/features/auth/...` non concerné.

**À ne pas toucher** : `BibleMarks`, les favoris, les surlignages, le plan de lecture, la mémorisation, la concordance. Le journal est additif.

### 10.3 Commandes

```bash
make gen                         # freezed, riverpod, routes, i18n
flutter test test/features/bible
flutter test test/features/members   # suppression de compte
flutter test
flutter analyze
```

`make check` avant de considérer la fonctionnalité terminée.

### 10.4 Commits proposés

1. `feat(bible): keep private journal notes on the phone` — modèle, stockage, provider, tests.
2. `feat(bible): write and edit a note from a verse` — éditeur, action, icône, route.
3. `feat(bible): the journal screen, search and export` — carte, écran, recherche, partage.
4. `test(bible): the journal end to end` — tests d'intégration, accessibilité, RTL.

Aucun push sur `main` sans demande explicite.

### 10.5 Hors périmètre v1 / v2

- Plusieurs notes datées sur le même passage (avec un sélecteur).
- Note libre non attachée à un verset.
- Tags, dossiers, favoris de notes, tri configurable.
- Recherche avec surlignage, filtres par livre/date, historique.
- Export PDF, Word, Markdown.
- Synchronisation multi-appareils, backend, web.
- Rappels/notifications, même doux.
- Chiffrement applicatif, verrou biométrique.
- Texte enrichi, images, audio.
- Historique de versions / annulation de suppression.
- Partage vers le collectif / fil communautaire.
- Journal premium.
- Indicateur de note sur les cartes de favoris/surlignés (peut venir ensuite).
- Autosave de brouillon (v1.1 si le besoin est réel).

### 10.6 Points à valider

1. **Une note par passage** (ancre = premier verset) pour la v1 — recommandé. Sinon, il faut un sélecteur de notes et une liste par passage.
2. **Carte dans « Mes versets » + écran dédié** plutôt qu'un troisième onglet — recommandé pour l'accessibilité et la recherche. 
3. **Stockage par compte** (`bible_notes_<accountId>`) — recommandé pour la confidentialité sur un téléphone partagé.
4. **Export `.txt` + copie** en v1, PDF en v2 — recommandé.
5. **Enregistrement explicite** (pas d'autosave) — recommandé pour la sécurité et la cohérence avec le compte rendu.
6. **Aucun rappel/notification** en v1 — recommandé.

---

## Annexe A — Exemple d'export

```text
Journal biblique
Exporté le 25 octobre 2026 · 3 notes

────────────────────────────

SEPTEMBRE 2026

Jean 3:16-17 (LSG)
« Car Dieu a tant aimé le monde qu'il a donné son Fils unique… »

Ce que ce passage me dit sur l'amour qui donne.

  Créée le 12 septembre 2026.

────────────────────────────

OCTOBRE 2026

Psaumes 23:1 (LSG)
« L'Éternel est mon berger : je ne manquerai de rien. »

Relire ce psaume avant de dormir.

  Créée le 4 octobre 2026 · modifiée le 25 octobre 2026

────────────────────────────

Jean 3:16 (LSG)
« Car Dieu a tant aimé le monde… »

Une note plus courte.

  Créée le 25 octobre 2026.
```

**Règles** :

- Les notes sont triées par création croissante.
- Les mois sont ceux de la création.
- La citation est entre guillemets français, sur une ligne indentée de deux espaces.
- Le corps garde ses retours à la ligne.
- Les métadonnées sont indentées de deux espaces, en petit.
- Aucun nom, aucun numéro, aucun identifiant de compte.

## Annexe B — Résumé des tokens

| Token | Usage |
| --- | --- |
| `AppTones.bible.soft` | Carte Journal, carte du passage |
| `AppTones.bible.onSoft` | Texte/icônes sur les fonds `soft` |
| `AppTones.bible.color` | Tuile d'icône Journal, boutons principaux |
| `scheme.surface` | Cartes de note, champ |
| `scheme.outlineVariant` | Bords, séparateurs |
| `scheme.onSurface` | Corps, citation |
| `scheme.onSurfaceVariant` | Dates, légendes, en-têtes de mois |
| `scheme.error` / `errorContainer` | Suppression, erreurs |
| `AppSpacing.lg` (16) | Marges de liste, padding de carte |
| `AppSpacing.xl` (24) | Marges de l'éditeur, état vide |
| `AppRadius.lg` (16) | Cartes, champ, boutons |
| `AppMotion.fast` (180 ms) | Micro-animations optionnelles |
| `AppMotion.medium` (260 ms) | Transitions de contenu |
| `AppMotion.reduced` | Suppression des animations |
