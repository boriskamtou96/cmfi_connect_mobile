# Jeux — spécification (mobile, backend, back-office)

**Statut** : proposition v1, à valider  
**Date** : 12 novembre 2026  
**Module** : Jeux (onglet du milieu)  
**Surfaces** : application mobile (Flutter), API Go (`cmfi-connect-backend`), back-office (`cmfi-connect-web`)  
**Branches** : `feat/games` (mobile et backend, tirées de `dev`)

---

## 0. En une page

L'onglet **Jeux** fait apprendre la Parole en jouant, à la manière de Duolingo : un **chemin** de **niveaux**, chaque niveau fait de courtes **leçons** de 8 questions, des **points** gagnés en répondant, et un **classement** entre membres.

**Une partie tient en 2 à 3 minutes.** Le membre ouvre l'onglet, touche la leçon du moment, répond à 8 questions (chaque réponse est expliquée, avec sa référence biblique), voit ses points et ses étoiles, et la leçon suivante s'ouvre.

**Quatre règles qui tiennent le module :**

1. **Le jeu sert la Parole.** On joue pour connaître la Bible, pas pour collectionner.
2. **On ne note pas la vie spirituelle.** Les points viennent du jeu seulement : jamais du compte rendu, de la prière, des retraites, du jeûne ou des dons. « Mes étapes » reste « pour toi seul », sans lien avec le classement.
3. **Un classement choisi et bienveillant.** On y entre si on le veut, on en sort quand on veut, il repart de zéro chaque lundi.
4. **Personne n'est bloqué.** Ni vies, ni chrono, ni achat : une erreur revient en fin de leçon, c'est tout.

**Ce que le module n'est pas** : une fonctionnalité Premium, un moyen de comparer la piété des membres, un jeu d'argent ou de hasard.

Les décisions qui te reviennent sont regroupées au §11.

---

## 0 bis. Amendement du 12 novembre au soir

La v1 ci-dessous est validée. Tu as ajouté trois demandes ; elles **remplacent** ce qui les contredit plus bas (surtout le §3.5 et le §5.6). **À valider avant de coder.**

### A. Le look : Duolingo, avec notre touche

- **De Duolingo** : le chemin sinueux de pastilles rondes « en relief » (un bord plus sombre dessous, qui s'enfonce au toucher), les boutons épais en capitales, la barre de progression dorée, une question par écran, le bandeau vert ou ambre qui monte du bas, l'écran de fin qui fête.
- **Notre touche** : **Zoé**, la colombe de l'app (`DoveMascot`), guide le jeu comme Duo le fait : elle pose la question, encourage (`cheer`), fête la fin d'une leçon (`celebrate`), se repose quand l'objectif du jour est atteint (`rest`). Le bleu nuit et l'or de la CMCI à la place du vert de Duolingo ; chaque niveau a sa couleur de bandeau. Le ton reste celui de l'app : on encourage, on ne culpabilise jamais.
- Le vert feuille du §5.6 est abandonné : le module prend le **bleu CMCI et l'or**, les pastilles terminées sont dorées.
- Maquette : `jeux_maquette_v1.png` (envoyée dans la conversation).

### B. Un jeu qui donne envie de revenir

| Mécanique | Règle |
| --- | --- |
| Série de jeu (flamme) | Les jours de suite avec au moins une leçon. Un jour de grâce par semaine la protège, comme pour le compte rendu. |
| Objectif du jour | 50 points par jour (30 ou 100 au choix dans les réglages) ; un anneau en haut du chemin. |
| Niveau du joueur | Selon le total de points : niveau 2 à 200, puis un palier de plus en plus haut. Zoé fête chaque passage. |
| Série dans la leçon | 5 bonnes réponses de suite : + 5 points, la flamme de la leçon s'allume. |
| Défi du jour | 5 questions tirées des leçons terminées, + 15 points, une fois par jour. |
| Podium | Les 3 premiers de la semaine en tête du classement. |
| Rappel du soir | Une notification si l'objectif du jour n'est pas atteint. Coupée par défaut : le membre l'active. |

Toujours **pas de vies** : une erreur ne bloque personne. Les points ne viennent toujours que du jeu.

### C. Un parcours dédié : « Notre ministère »

Le jeu a **deux parcours**, choisis en haut de l'onglet : « Notre ministère » (la Communauté Missionnaire Chrétienne Internationale) et « La Bible » (§2.1). « Notre ministère » vient en premier.

| # | Niveau | Ce qu'on y apprend |
| --- | --- | --- |
| 1 | Notre fondateur | La vie du Pr Zacharias Tanee Fomum, les grandes dates |
| 2 | Notre but | Les trois buts : la croisade « toute-créature », la formation des disciples, le réveil global |
| 3 | Les nations | Depuis Yaoundé : où l'œuvre est présente, depuis quand |
| 4 | Notre leader | Théodore Andoseh |
| 5 | Nos missionnaires et nos héros | Ceux que le Seigneur envoie, ceux dont la foi nous inspire |

- 5 niveaux de 4 leçons, 8 questions par leçon : **160 questions**.
- **Les questions ne s'appuient que sur ce que l'app dit déjà** dans « Notre ministère » (vies, grandes dates, buts, nations), pour ne rien inventer sur la CMCI. Ce qui manque (missionnaires, héros : les portraits ne sont pas encore tous en ligne) attend des textes fournis par un responsable.
- Après chaque réponse, « Lire dans Notre ministère » ouvre la page correspondante, comme « Lire le passage » pour la Bible.
- Relecture par un responsable avant publication, comme pour la Bible.

### D. Ce que ça change dans le modèle

- Une table `game_courses` (`code` : `ministry`, `bible` ; `position`, `title` JSONB) ; `game_levels.course_id`, avec une couleur de bandeau par niveau.
- `game_questions.source` : une référence biblique ou une page de « Notre ministère ».
- `game_players` : `streak_days`, `last_played_on`, `grace_used_on`, `daily_goal`.
- `game_points.reason` gagne `combo` et `daily_challenge`.
- `GET /games/path?course=` ; `GET /games/daily` et `POST /games/daily/results` pour le défi du jour.

---

## 1. Vocabulaire

| Mot | Ce que c'est | Exemple |
| --- | --- | --- |
| Chemin | La suite des niveaux, de haut en bas dans l'onglet | « Connaître la Bible » |
| Niveau | Un thème, fait de 4 à 6 leçons | « Les commencements » (Genèse 1 à 11) |
| Leçon | 8 questions, 2 à 3 minutes | « La création » |
| Question | Une question, ses choix, sa réponse, son explication, sa référence | « Quel jour Dieu créa-t-il la lumière ? » |
| Points | Ce qu'on gagne en répondant juste | 10 par bonne réponse |
| Étoiles | La qualité d'une leçon, de 1 à 3 | 3 étoiles : sans faute |
| Classement | Les points des membres, cette semaine ou depuis toujours | « 4e cette semaine » |

**« Leçon » plutôt qu'« étape ».** Tu as parlé d'étapes ; l'app a déjà « Mes étapes » (les jalons du chemin personnel). Deux « étapes » différentes dans la même app prêteraient à confusion : je propose « leçon » pour le jeu. À valider (§11).

---

## 2. Le contenu

### 2.1 Le chemin de la v1

Un seul chemin, « Connaître la Bible », 6 niveaux, 5 leçons chacun, 8 questions par leçon : **240 questions**.

| # | Niveau | Passages |
| --- | --- | --- |
| 1 | Les commencements | Genèse 1 à 11 |
| 2 | Les patriarches | Genèse 12 à 50 |
| 3 | La sortie d'Égypte | Exode, Josué |
| 4 | La vie de Jésus | Les quatre Évangiles |
| 5 | L'Église naissante | Actes |
| 6 | Versets à connaître | Versets clés, à compléter |

D'autres chemins pourront suivre sans changer le code : « Notre ministère » (histoire de la CMCI, nations), « Les Psaumes », « Les épîtres ».

### 2.2 Les types de questions

| Type | v1 | Forme |
| --- | --- | --- |
| `choice` | oui | 4 choix, 1 juste (« Qui a construit l'arche ? ») |
| `true_false` | oui | Vrai ou faux |
| `fill_verse` | oui | Un verset avec un blanc, 4 choix |
| `order` | v1.1 | Remettre 4 évènements ou livres dans l'ordre |
| `match` | v1.1 | Relier 4 paires (personnage et fait) |

Chaque question porte une **explication** d'une ou deux phrases et une **référence** (`GEN.1.3`). Après la réponse, « Lire le passage » ouvre la Bible à cet endroit.

### 2.3 Qui écrit les questions

- Les admins écrivent et publient depuis le back-office (§8).
- Je peux préparer le premier lot de 240 questions en français ; **un responsable les relit avant publication** (exactitude et doctrine). Rien n'est publié sans cette relecture.
- Versets cités : une traduction du domaine public (Louis Segond 1910 en français, King James en anglais), tant que la licence de la Bible du Semeur n'est pas signée.

### 2.4 Les langues

Le contenu est traduit question par question (`fr` obligatoire, les autres facultatives). Un membre voit sa langue si elle existe, sinon le français. **La progression ne dépend pas de la langue.** Lancement proposé : français et anglais.

---

## 3. Les règles du jeu

### 3.1 Une leçon

- 8 questions, dans un ordre mélangé ; les choix aussi.
- Une réponse fausse : la bonne réponse et l'explication s'affichent, et la question revient une fois à la fin.
- La leçon se termine quand toutes les questions ont reçu une bonne réponse.
- Pas de chrono, pas de vies. Quitter en cours demande une confirmation ; rien n'est compté.

### 3.2 Les points

| Fait | Points |
| --- | --- |
| Bonne réponse du premier coup | 10 |
| Bonne réponse au second passage | 5 |
| Leçon sans faute | + 20 |
| Leçon déjà terminée, rejouée | 2 par bonne réponse, 20 par jour au plus |

Une leçon rapporte donc entre 40 et 100 points la première fois. Le plafond des leçons rejouées empêche de monter au classement en répétant la plus facile.

### 3.3 Les étoiles

Selon les bonnes réponses du premier coup : 3 étoiles pour 8 sur 8, 2 étoiles pour 6 ou 7, 1 étoile sinon. On garde le meilleur score ; rejouer sert à gagner des étoiles.

### 3.4 Avancer

- Les leçons s'ouvrent dans l'ordre ; terminer une leçon ouvre la suivante.
- Terminer les leçons d'un niveau ouvre le niveau suivant.
- Un niveau terminé montre son total d'étoiles (« 13 sur 15 »).

### 3.5 Ce qu'il n'y a pas en v1

Pas de vies, pas de chrono, pas de duel entre membres. (La série de jeu, le défi du jour et le rappel du soir sont entrés dans la v1 : voir §0 bis.)

---

## 4. Le classement

- **Deux périodes** : « Cette semaine » (du lundi 00 h au dimanche, heure de Douala) et « Depuis toujours ».
- **Deux portées** : « Tous les membres » et « Mon cercle » (mes autorités et mes disciples, déjà connus de l'app). Par église : plus tard, le champ église du profil est un texte libre.
- **Ce qu'on voit d'un membre** : son rang, sa photo, son pseudo, ses points. Jamais son nom complet, son numéro ni son église.
- **Les 50 premiers**, et ma ligne épinglée en bas si je n'y suis pas (« 127e · 340 points »).
- **Égalité** : celui qui a atteint le total le premier passe devant.
- **Y entrer est un choix.** À la première ouverture du classement : « Veux-tu apparaître dans le classement ? Les autres verront ton pseudo, ta photo et tes points de jeu. » Oui ou Non, modifiable dans les réglages du jeu. Qui dit non joue normalement et voit le classement, sans y figurer.
- **Membres bloqués** : ni eux ni moi ne nous voyons dans le classement.
- **Ton** : pas de dernière place montrée, pas de message qui compare (« Paul t'a dépassé »).

---

## 5. Les écrans (mobile)

### 5.1 L'onglet Jeux (`GamesScreen`)

- En haut : mes points, mes étoiles, et un bouton « Classement » avec mon rang de la semaine si j'y figure.
- Dessous, le chemin : chaque niveau a son titre et ses leçons en pastilles rondes le long d'une ligne sinueuse. Une leçon est terminée (ses étoiles), en cours (plus grande, bouton « Commencer »), ou fermée (grisée, cadenas).
- Toucher une leçon terminée propose « Rejouer ».
- États : chargement (squelette), erreur (`ErrorView`), hors connexion (le dernier chemin connu, et « Connecte-toi pour jouer » sur la leçon).

### 5.2 La leçon (`LessonScreen`, plein écran)

- Barre de progression, croix pour quitter.
- La question, ses choix en grandes cartes ; « Vérifier » s'active quand un choix est pris.
- Après vérification, un bandeau en bas : juste (vert, coche) ou à revoir (ambre, la bonne réponse), l'explication, « Lire le passage », puis « Continuer ».
- Le retour ne passe jamais par la couleur seule : icône et texte à chaque fois. Vibration légère ; pas de son en v1.

### 5.3 Le résultat (`LessonResultScreen`)

Les points gagnés (qui montent), les étoiles, « 7 sur 8 du premier coup », le niveau terminé s'il l'est. « Continuer » revient au chemin, où la leçon suivante s'ouvre.

### 5.4 Le classement (`LeaderboardScreen`)

`SegmentedTabs` « Cette semaine » / « Depuis toujours », deux puces « Tous » / « Mon cercle », la liste, ma ligne épinglée. État vide : « Personne n'a encore joué cette semaine. À toi d'ouvrir la marche. »

### 5.5 Les réglages du jeu

Depuis l'onglet (roue) : « Apparaître dans le classement », « Vibrations ».

### 5.6 La couleur du module

Un nouveau `AppModule.games`, d'une teinte absente des autres modules (bleu, sarcelle, violet, ocre, bordeaux) : je propose un **vert feuille** (`#3D7A35`, fond `#E6F2E3` ; en sombre, fond `#1F3320`, encre `#A9DCA0`). À valider.

### 5.7 Ailleurs dans l'app

Rien sur l'accueil ni dans « Tes 3 pas du jour » : le jeu reste à part de la vie spirituelle quotidienne. L'onglet suffit.

---

## 6. Le modèle de données (backend)

Une migration `000041_games`. Les textes traduits sont en JSONB (`{"fr": "…", "en": "…"}`).

| Table | Colonnes principales | Rôle |
| --- | --- | --- |
| `game_levels` | `id`, `position`, `title` JSONB, `description` JSONB, `published_at` | Les niveaux, dans l'ordre |
| `game_lessons` | `id`, `level_id`, `position`, `title` JSONB, `published_at` | Les leçons d'un niveau |
| `game_questions` | `id`, `lesson_id`, `position`, `kind`, `prompt` JSONB, `choices` JSONB, `answer`, `explanation` JSONB, `bible_ref`, `is_active` | Les questions |
| `game_lesson_results` | `user_id`, `lesson_id`, `best_stars`, `best_first_try`, `plays`, `first_completed_at`, `last_played_at` ; unique (`user_id`, `lesson_id`) | La progression d'un membre |
| `game_points` | `id`, `user_id`, `lesson_id`, `points`, `reason`, `client_id`, `earned_at` ; unique (`user_id`, `client_id`) | Le journal des points : le classement en est la somme |
| `game_players` | `user_id`, `total_points`, `total_reached_at`, `in_leaderboard` (null tant que le membre n'a pas choisi) | Le total et le choix du classement |

- Le classement de la semaine est `SUM(points)` de `game_points` depuis lundi, par membre ; un index sur (`earned_at`, `user_id`). À notre taille (quelques milliers de membres), une requête directe suffit, sans table de cumul.
- Tout part avec le compte (`ON DELETE CASCADE`), comme le reste.
- Une leçon n'est jouable que publiée, avec au moins 8 questions actives.

---

## 7. L'API

Toutes sous `/v1`, avec le jeton, dans l'enveloppe habituelle `{"status", "content"}`.

| Méthode et chemin | Rôle |
| --- | --- |
| `GET /games/path` | Les niveaux et leurs leçons, avec mon état (fermée, ouverte, terminée, étoiles), mes points, mon rang de la semaine |
| `GET /games/lessons/:id` | Les 8 questions d'une leçon, dans ma langue (`?lang=`) |
| `POST /games/lessons/:id/results` | Mes réponses ; le serveur calcule et renvoie points, étoiles, total, leçon ouverte |
| `GET /games/leaderboard?period=week\|all&scope=all\|circle` | Les 50 premiers et ma ligne |
| `PUT /games/me` | Mon choix d'apparaître au classement |

Admin (`/v1/admin/games`, rôles admin et superadmin) : créer, modifier, ordonner, publier et retirer niveaux, leçons et questions ; importer un lot (JSON) ; statistiques.

**Le serveur compte les points, pas le téléphone.** L'app envoie les réponses (`question_id`, choix, premier ou second passage) et un `client_id` : renvoyer deux fois le même résultat ne compte qu'une fois. Le serveur vérifie que la leçon est ouverte au membre.

**Une limite assumée** : pour expliquer chaque réponse sans attendre le réseau, les bonnes réponses voyagent avec la leçon. Un membre très motivé pourrait les lire. Pour un jeu communautaire sans enjeu, c'est acceptable ; les points plafonnés par leçon (§3.2) bornent l'abus. L'alternative (une requête par question) rendrait le jeu pénible avec une connexion faible.

Codes d'erreur : `NOT_FOUND`, `FORBIDDEN`, et `LESSON_LOCKED` (409) pour une leçon pas encore ouverte.

---

## 8. Le back-office (web)

Une section « Jeux » :

- Les niveaux et leurs leçons, à ordonner avec les flèches ↑ ↓ (comme les autres listes du site) ; brouillon ou publié.
- L'éditeur d'une question : type, énoncé, choix, bonne réponse, explication, référence ; un onglet par langue ; un aperçu « comme sur le téléphone ».
- L'import d'un lot de questions (JSON), pour charger le premier contenu.
- Des chiffres : joueurs de la semaine, leçons terminées, et **les questions les plus ratées** (souvent mal posées : à revoir).

**Fait le 12/11/2026 (lot 4).** Le site écrit le contenu pièce par pièce, avec des identifiants qui restent (l'import remplace un parcours entier et n'est plus possible une fois qu'il est joué) : routes `/v1/admin/games/…` (parcours, niveaux, leçons, questions, ordre, chiffres), table `game_question_stats` (migration 42 : par question, les premières réponses d'une première partie et celles qui étaient fausses). Règles : une leçon se publie avec 8 questions au moins, un niveau avec une leçon publiée, un parcours avec un niveau publié ; ce que des membres ont joué ne se supprime pas (on le repasse en brouillon) ; une leçon publiée garde 8 questions. Plan : `docs/superpowers/plans/2026-11-12-jeux-lot4-backoffice.md`.

---

## 9. L'architecture mobile

```
features/games/
├── domain/          GameLevel, GameLesson, GameQuestion, LessonResult, LeaderboardEntry (freezed)
├── infrastructure/  games_api.dart, le dernier chemin connu (stockage local)
├── application/     gamePathProvider, LessonController, leaderboardProvider, gameSettings
└── presentation/    games_screen, lesson_screen, lesson_result_screen, leaderboard_screen, widgets/
```

- Les règles habituelles : `@riverpod`, `AsyncValue`, `apiCall`, textes dans les 7 fichiers `.i18n.json` (`games.*`), `AppIcons`, `AppModule.games`.
- **Connexion faible** : la leçon se télécharge d'un coup au départ et se joue sans réseau. Si l'envoi du résultat échoue, il est gardé sur le téléphone et renvoyé plus tard (comme les comptes rendus en attente), grâce au `client_id`.
- Routes : `GamesRoute` (onglet, déjà en place), `LessonRoute` (`/games/lessons/:id`, plein écran), `LeaderboardRoute` (`/games/leaderboard`).
- Tests : `FakeGamesApi`, une leçon jouée de bout en bout, une erreur qui revient, le résultat gardé hors connexion, le choix du classement.

---

## 10. Les lots

| Lot | Contenu | Dépôt |
| --- | --- | --- |
| 1 | Migration, requêtes, API joueur et admin, tests, import du premier contenu | backend |
| 2 | Le chemin, la leçon, le résultat, le hors connexion | mobile |
| 3 | Le classement et son choix | mobile et backend |
| 4 | La section « Jeux » du back-office (fait le 12/11/2026, avec ses routes d'administration) | web et backend |
| 5 | L'anglais, puis les questions `order` et `match`, un défi du jour, une notification du lundi (« Le classement repart ») | tous |

Les lots 1 et 2 donnent un jeu jouable. L'onglet affiche « Bientôt disponible » jusque-là.

---

## 11. Ce que tu dois décider

| # | Question | Ma proposition |
| --- | --- | --- |
| 1 | « Leçons » ou « étapes » pour les parties d'un niveau ? | « Leçons », pour ne pas doublonner « Mes étapes » |
| 2 | Le chemin de la v1 et ses 6 niveaux (§2.1) te conviennent-ils ? | Oui, tel quel |
| 3 | Qui relit les questions avant publication ? | Un responsable que tu désignes |
| 4 | Entrer au classement : un choix à la première ouverture, ou tout le monde d'office ? | Un choix, par pseudo |
| 5 | Les portées « Tous » et « Mon cercle » suffisent-elles en v1 ? | Oui ; par église plus tard |
| 6 | Ni vies, ni chrono, ni série de jeu en v1 ? | Oui |
| 7 | Les points ne viennent que du jeu, jamais du compte rendu ni de la prière ? | Oui |
| 8 | Gratuit pour tous, sans Premium ? | Oui |
| 9 | Versets cités : Segond 1910 et King James en attendant la licence du Semeur ? | Oui |
| 10 | Langues au lancement ? | Français et anglais |
| 11 | La couleur du module : vert feuille ? | Oui |
| 12 | Par quoi commencer ? | Lot 1 (backend), puis lot 2 |
