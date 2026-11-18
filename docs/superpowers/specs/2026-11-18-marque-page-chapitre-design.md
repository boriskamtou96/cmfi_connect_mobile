# Marque-page de lecture (design court, 18/11/2026)

## Pourquoi

Le membre lit la Bible jusqu'à un chapitre (Matthieu 5), puis va feuilleter ailleurs (un Psaume, un
verset cherché). Aujourd'hui la Bible se rouvre sur le dernier chapitre affiché (`BiblePosition`) :
l'endroit où il s'était arrêté est perdu. Il veut un marque-page pour y revenir d'un geste.

## Décisions de l'utilisateur

- Le marque-page se met sur un **chapitre**, pas sur un verset.
- Design validé tel que proposé (ci-dessous).

## Approches

- **Retenue : un seul marque-page posé à la main**, comme le ruban d'une Bible papier.
- Écartée : un marque-page qui se place tout seul. L'app devrait deviner si le membre lit ou
  feuillette ; elle se tromperait souvent.
- Écartée : plusieurs marque-pages. Les favoris (« Mes versets ») servent déjà à garder plusieurs
  endroits.

## Comportement

- Un seul marque-page, gardé sur le téléphone (shared_preferences, clé `bible_bookmark`, un
  chapitre USFM « MAT.5 »). Le même dans toutes les versions. Gardé à la déconnexion, comme les
  marques de la Bible.
- **Le poser :** menu ⋮ du lecteur, « Marquer ce chapitre » (en tête du menu). Posé ailleurs, il se
  déplace. Sur le chapitre marqué, la ligne devient « Retirer le marque-page ». Un message de
  confirmation (`toast.success`) dans les deux cas.
- **Le voir :** sur le chapitre marqué, un petit ruban doré pend en haut de la page
  (décoratif ; lu par les lecteurs d'écran : « Marque-page »).
- **Y revenir :** sur tout autre chapitre, une pastille « Matthieu 5 » avec une flèche de retour, en
  bas du lecteur (au-dessus de la barre d'écoute, cachée pendant la sélection de versets). Un
  toucher ouvre le chapitre marqué (`BiblePosition.set`), à son début, et arrête l'écoute si la Bible
  était lue à voix haute (la voix ramènerait sinon au chapitre écouté). *(Choix de Claude, après la
  relecture : la pastille a le bleu nuit de la barre d'écoute plutôt que les couleurs du lecteur,
  lisible sur les quatre fonds.)*
- Textes dans les 7 langues : « Marquer ce chapitre », « Retirer le marque-page », « Marque-page
  posé sur Matthieu 5 », « Marque-page retiré », la pastille (« Revenir à Matthieu 5 » pour les
  lecteurs d'écran).

## Hors périmètre

- Le marque-page sur l'accueil (« À reprendre »).
- Le lien avec le plan de lecture ou « J'ai lu ce chapitre ».

## Laissé au constructeur

- L'icône du ruban (une à ajouter dans `AppIcons`, distincte du signet des favoris).
- Le dessin exact du ruban et de la pastille, dans les couleurs du lecteur (`ReaderPalette`).
