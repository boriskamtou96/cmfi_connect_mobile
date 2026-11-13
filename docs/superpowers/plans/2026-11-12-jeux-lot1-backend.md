# Jeux, lot 1 (backend) : plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** L'API des jeux dans `cmfi-connect-backend` : les parcours et leurs leçons, l'envoi d'une leçon jouée avec les points calculés par le serveur, la série, l'objectif du jour, le classement, le défi du jour, et l'import du contenu.

**Architecture:** Une migration `000041_games`, des requêtes sqlc dans `internal/db/query/games.sql`, les règles du jeu en fonctions pures (`internal/games`), les handlers gin dans `api/games*.go`. Le contenu entre par un import JSON réservé aux admins ; l'édition question par question viendra avec le back-office (lot 4).

**Tech Stack:** Go, gin, PostgreSQL, sqlc, golang-migrate, testify.

**Spec:** `cmfi_connect_mobile/docs/specs/jeux.md` (le §0 bis l'emporte sur le reste).

**Dépôt et branche:** `cmfi-connect-backend`, branche `feat/games`. Les chemins ci-dessous partent de la racine de ce dépôt.

## Global Constraints

- Règle du dépôt (`CLAUDE.md`) : aucun fichier créé ou modifié sans l'accord de Boris. Ce plan liste tous les fichiers ; son accord sur le plan vaut pour eux, rien de plus. `sqlc generate` fait partie de la tâche 1.
- Les tests tournent sur une base jetable (`TEST_DATABASE_URL`), jamais sur `cmfi_connect`.
- Pas de commit sans demande de Boris.
- Routes sous `/v1`, avec `authMiddleware` ; réponses par `apiResponse` (enveloppe `{"status","content"}`), erreurs par les fonctions de `api/api_responses.go`. Code d'erreur propre au jeu : `LESSON_LOCKED` (409).
- Commentaires du code en anglais, tests nommés comme des phrases (`TestABookFollowsThePagesOfTheReports`), avec les outils de test existants (`newTestRouter`, `registerMember`, `send`, `decode`).
- Les textes traduits sont en JSONB `{"fr": "…", "en": "…"}` ; `fr` obligatoire ; une langue absente retombe sur `fr`.
- Le jour et la semaine du jeu sont ceux de Douala : `time.FixedZone("WAT", 3600)`, semaine du lundi 00 h.
- Valeurs de la spec : 10 points la bonne réponse du premier coup, 5 au second passage, + 20 sans faute, + 5 par série de 5 bonnes réponses de suite, leçon rejouée 2 par bonne réponse du premier coup et 20 par jour au plus, défi du jour 15 ; étoiles 3 (tout juste), 2 (au moins 75 %), 1 sinon ; objectif du jour 30, 50 ou 100 (50 par défaut) ; niveau du joueur `n` à partir de `100 × n × (n − 1)` points ; classement : 50 lignes.

## Review Focus

1. Le même résultat envoyé deux fois (réseau faible, renvoi) : compté une seule fois, même réponse. Tâche 5.
2. Une leçon modifiée entre le téléchargement et l'envoi (question retirée ou ajoutée) : on note les questions encore actives qui ont une réponse, les autres sont ignorées ; aucune en commun : 400. Tâche 5.
3. Une partie jouée à 23 h 30 UTC : elle compte pour le lendemain à Douala (série, objectif du jour, semaine du classement). Tâches 2 et 5.
4. Égalité de points au classement : le premier arrivé au total passe devant ; un membre qui a dit non, ou n'a pas encore choisi, n'apparaît jamais ; un membre bloqué (dans un sens ou l'autre) non plus. Tâche 6.
5. Un membre qui n'a jamais joué : le chemin s'ouvre sur la première leçon, tout à zéro, rang absent ; pas de défi du jour (404). Tâches 4 et 7.

---

### Task 1: Le schéma et les requêtes

**Files:**
- Create: `internal/db/migration/000041_games.up.sql`, `internal/db/migration/000041_games.down.sql`
- Create: `internal/db/query/games.sql`
- Generated: `internal/db/sqlc/*` (`sqlc generate`)
- Test: `internal/db/migrate_test.go` (le test existant couvre la montée et la descente)

**Interfaces:**
- Produces, tables :
  - `game_courses(id, code UNIQUE, position, title JSONB, published_at, created_at)`
  - `game_levels(id, course_id → game_courses CASCADE, position, title JSONB, description JSONB DEFAULT '{}', color VARCHAR(7) DEFAULT '#0B3B70', published_at, UNIQUE(course_id, position))`
  - `game_lessons(id, level_id → game_levels CASCADE, position, title JSONB, published_at, UNIQUE(level_id, position))`
  - `game_questions(id, lesson_id → game_lessons CASCADE, position, kind CHECK IN ('choice','true_false','fill_verse'), prompt JSONB, choices JSONB, answer VARCHAR(20), explanation JSONB DEFAULT '{}', source VARCHAR(120) DEFAULT '', is_active BOOLEAN DEFAULT TRUE)` ; `choices` est `[{"id":"a","text":{"fr":"…"}}]`, `answer` l'`id` du bon choix
  - `game_lesson_results(user_id → users CASCADE, lesson_id → game_lessons CASCADE, best_stars SMALLINT CHECK 1..3, best_first_try SMALLINT, plays INT, first_completed_at, last_played_at, PRIMARY KEY(user_id, lesson_id))`
  - `game_plays(id, user_id → users CASCADE, lesson_id → game_lessons SET NULL, kind CHECK IN ('lesson','replay','daily'), client_id VARCHAR(64), first_try SMALLINT, total SMALLINT, stars SMALLINT, points INT CHECK >= 0, played_at TIMESTAMPTZ DEFAULT NOW(), UNIQUE(user_id, client_id))`, index `(played_at, user_id)`. Elle remplace `game_points` de la spec : une ligne par partie, le classement en est la somme.
  - `game_players(user_id PRIMARY KEY → users CASCADE, total_points INT DEFAULT 0, total_reached_at TIMESTAMPTZ, in_leaderboard BOOLEAN NULL, streak_days INT DEFAULT 0, last_played_on DATE, grace_used_on DATE, daily_goal INT DEFAULT 50 CHECK IN (30,50,100), daily_done_on DATE)`
- Produces, requêtes sqlc (noms exacts) : `ListGameCourses`, `GetGameCourseByCode`, `ListGameLevelsOfCourse`, `ListGameLessonsOfCourse` (avec `stars` et `done` du membre), `GetGameLesson` (avec `course_id`, titre du niveau), `ListGameQuestionsOfLesson` (actives, par position), `GetGamePlayByClientID`, `CreateGamePlay`, `UpsertGameLessonResult`, `GetGamePlayer`, `UpsertGamePlayer`, `SumGamePointsSince` (un membre, depuis une date), `SumGameReplayPointsSince`, `ListGameLeaderboard` (période par `since` nullable, portée par liste d'ids nullable, sans les bloqués, 50 lignes), `GetGameRank`, `ListCompletedGameQuestions` (pour le défi du jour), `UpsertGameCourse`, `DeleteGameLevelsOfCourse`, `CreateGameLevel`, `CreateGameLesson`, `CreateGameQuestion`.

- [ ] **Step 1:** Écrire les deux fichiers de migration (la descente supprime les 7 tables dans l'ordre inverse).
- [ ] **Step 2:** Écrire `games.sql`.
- [ ] **Step 3:** `sqlc generate`. Attendu : aucun message, `internal/db/sqlc/games.sql.go` créé.
- [ ] **Step 4:** `go build ./... && go test ./internal/db/ -run Migrat -v` sur la base jetable. Attendu : PASS.

### Task 2: Les règles du jeu, en fonctions pures

**Files:**
- Create: `internal/games/rules.go`
- Test: `internal/games/rules_test.go`

**Interfaces:**
- Produces :
  - `type Answer struct { QuestionID int64; Choice string; Attempt int }`
  - `type Score struct { FirstTry, Total, Stars, Points, ComboBonus int; Perfect bool }`
  - `func ScoreLesson(answers []Answer, key map[int64]string) (Score, bool)` : `key` donne le bon choix de chaque question active ; `false` si aucune question de `key` n'a de réponse. Une question compte « premier coup » si sa première réponse (`Attempt == 1`) est juste, « second passage » si une réponse suivante l'est.
  - `func ScoreReplay(answers []Answer, key map[int64]string, alreadyToday int) (Score, bool)` : 2 par premier coup, sans bonus, `Points` plafonné à `20 − alreadyToday` (0 au moins).
  - `func Stars(firstTry, total int) int`
  - `func PlayerLevel(total int) (level, floor, next int)`
  - `func GameDay(t time.Time) time.Time` (minuit de Douala), `func WeekStart(t time.Time) time.Time` (lundi)
  - `type Streak struct { Days int; LastPlayedOn, GraceUsedOn *time.Time }`
  - `func (s Streak) After(day time.Time) Streak` (une partie finie ce jour-là), `func (s Streak) ShownOn(day time.Time) int` (ce qu'on affiche : 0 si la série est rompue)

- [ ] **Step 1:** Écrire les tests, avec ces cas :
  - 8 sur 8 du premier coup : `Points == 105` (80 + 20 + 5), `Stars == 3`, `Perfect`, `ComboBonus == 5`.
  - 6 du premier coup dans l'ordre J J F J J J J F puis les 2 erreurs justes au second passage : `Points == 70`, `Stars == 2`, `ComboBonus == 0`.
  - 5 justes de suite puis 3 erreurs rattrapées : `Points == 70` (50 + 15 + 5), `Stars == 1`.
  - Réponse à une question absente de `key` : ignorée ; aucune question commune : `false`.
  - `ScoreReplay` : 8 justes avec `alreadyToday == 10` donne `Points == 10` ; avec 20 donne 0.
  - `Stars(6, 8) == 2`, `Stars(5, 8) == 1`, `Stars(3, 4) == 2`.
  - `PlayerLevel(0) == (1, 0, 200)`, `PlayerLevel(200) == (2, 200, 600)`, `PlayerLevel(1199) == (3, 600, 1200)`.
  - `GameDay` de `2026-11-12T23:30:00Z` est le 13 novembre ; `WeekStart` du dimanche 15 novembre 2026 à 23 h 30 UTC est le lundi 16.
  - Série : joué hier puis aujourd'hui, 1 devient 2 ; deux fois le même jour, inchangé ; un jour manqué, grâce libre : la série continue et `GraceUsedOn` est le jour manqué ; un second jour manqué la même semaine : retour à 1 ; `ShownOn` trois jours après la dernière partie : 0.
- [ ] **Step 2:** `go test ./internal/games/ -v`. Attendu : échec de compilation.
- [ ] **Step 3:** Implémenter `rules.go`.
- [ ] **Step 4:** `go test ./internal/games/ -v`. Attendu : PASS.

### Task 3: L'import du contenu

**Files:**
- Create: `api/admin_games.go`
- Modify: `api/api.go` (dans le groupe `admin`) : `admin.POST("/games/import", s.importGameCourse)`
- Test: `api/admin_games_test.go`

**Interfaces:**
- Consumes: `UpsertGameCourse`, `DeleteGameLevelsOfCourse`, `CreateGameLevel`, `CreateGameLesson`, `CreateGameQuestion`.
- Produces: `POST /v1/admin/games/import`, corps :
  `{"code":"ministry","position":1,"title":{"fr":"Notre ministère"},"published":true,"levels":[{"title":{…},"description":{…},"color":"#0B3B70","lessons":[{"title":{…},"questions":[{"kind":"choice","prompt":{…},"choices":[{"id":"a","text":{…}}],"answer":"b","explanation":{…},"source":"ministry:founder"}]}]}]}`.
  Réponse 200 : `{"code","levels","lessons","questions"}` (les nombres créés). L'import remplace les niveaux du parcours dans une transaction ; les positions suivent l'ordre du fichier. **Il est refusé (409 `CONFLICT`) si un membre a déjà un résultat dans ce parcours**, pour ne pas effacer de progression : le contenu d'un parcours déjà joué se modifiera depuis le back-office (lot 4).
- Produces (tests) : `func importSampleCourse(t *testing.T, router http.Handler, code string, lessons int) (lessonIDs []int64)` dans `admin_games_test.go` : un parcours publié d'un niveau, `lessons` leçons de 8 questions `choice` dont le bon choix est toujours `"a"`.

- [ ] **Step 1:** Tests : `TestACourseIsImportedByAnAdminOnly` (membre simple : 403 ; admin : 200 et les nombres) ; `TestAnImportIsRefusedWithoutFrenchOrWithAWrongAnswer` (titre sans `fr`, `answer` absent des choix, moins de 2 choix, `kind` inconnu : 400, rien n'est créé) ; `TestAnImportReplacesTheCourseUntilSomeonePlayed`.
- [ ] **Step 2:** `go test ./api/ -run Import -v`. Attendu : FAIL.
- [ ] **Step 3:** Implémenter `importGameCourse` et sa validation.
- [ ] **Step 4:** Relancer. Attendu : PASS.

### Task 4: Le chemin et une leçon

**Files:**
- Create: `api/games.go`
- Modify: `api/api.go` : groupe `games := r.Group("/games", authMiddleware(s.jwtAuthenticator))` avec `GET /path` et `GET /lessons/:id`
- Test: `api/games_test.go`

**Interfaces:**
- Consumes: tâche 1, `games.PlayerLevel`, `games.Streak`, `importSampleCourse`.
- Produces:
  - `func textIn(raw json.RawMessage, lang string) string` (retombe sur `fr`).
  - `type gamePlayerResponse struct` : `total_points`, `level`, `level_floor`, `next_level_at`, `streak_days`, `played_today`, `daily_goal`, `points_today`, `in_leaderboard` (`*bool`), `week_rank` (`*int`), `daily_done`.
  - `func (s *Server) gamePlayer(c *gin.Context, userID int64, now time.Time) (gamePlayerResponse, error)`.
  - `GET /v1/games/path?course=&lang=` : `{"courses":[{"code","title"}],"course":"ministry","player":{…},"levels":[{"id","position","title","description","color","lessons":[{"id","position","title","state","stars"}]}]}`. `state` : `done`, `open` ou `locked` ; une leçon est ouverte si c'est la première publiée du parcours ou si la précédente est faite. Sans `course` : le premier parcours publié. Parcours inconnu ou non publié : 404.
  - `GET /v1/games/lessons/:id?lang=` : `{"id","title","level_title","course","questions":[{"id","kind","prompt","choices":[{"id","text"}],"answer","explanation","source"}]}`. Leçon fermée : 409 `LESSON_LOCKED` ; inconnue ou non publiée : 404.
  - `func (s *Server) lessonState(c *gin.Context, userID, lessonID int64) (state string, err error)`.

- [ ] **Step 1:** Tests : `TestThePathOpensOnItsFirstLesson` (membre neuf : première `open`, les autres `locked`, joueur à zéro, `week_rank` nul) ; `TestALessonComesInTheLanguageAskedOrInFrench` (`lang=en` sans anglais : le français) ; `TestALockedLessonIsRefused` (409 `LESSON_LOCKED`) ; `TestAnUnpublishedCourseIsNotFound`.
- [ ] **Step 2:** `go test ./api/ -run "Path|Lesson" -v`. Attendu : FAIL.
- [ ] **Step 3:** Implémenter.
- [ ] **Step 4:** Relancer. Attendu : PASS.

### Task 5: Envoyer une leçon jouée

**Files:**
- Modify: `api/games.go`, `api/api.go` : `POST /lessons/:id/results`
- Test: `api/games_results_test.go`

**Interfaces:**
- Consumes: `games.ScoreLesson`, `games.ScoreReplay`, `games.Streak`, `lessonState`, `gamePlayer`.
- Produces: `POST /v1/games/lessons/:id/results`, corps `{"client_id":"…","answers":[{"question_id":1,"choice":"a","attempt":1}]}` ; réponse 200 `{"points","first_try","total","stars","best_stars","perfect","combo_bonus","replay","level_up","next_lesson_id","level_completed","player":{…}}`. Dans une transaction : la partie (`game_plays`), le résultat de la leçon (meilleures étoiles gardées), le joueur (total, `total_reached_at` quand le total change, série). L'heure vient de `s.now()` si le serveur en a une, sinon ajouter `now func() time.Time` au `Server` (`time.Now` par défaut) pour que les tests fixent le jour.
- Erreurs : `client_id` vide ou de plus de 64 caractères, `answers` vide, aucune question commune : 400 ; leçon fermée : 409 `LESSON_LOCKED`.

- [ ] **Step 1:** Tests : `TestALessonPlayedGivesPointsStarsAndOpensTheNext` (8 justes : 105 points, 3 étoiles, la leçon suivante passe `open`, `streak_days == 1`, `points_today == 105`) ; `TestTheSameResultSentTwiceCountsOnce` (même `client_id` : même réponse, total inchangé) ; `TestALessonReplayedGivesFewPointsCappedByDay` (16 puis 4 puis 0) ; `TestAReplayKeepsTheBestStars` ; `TestAnswersToQuestionsGoneAreIgnored` ; `TestAPlayLateInTheEveningCountsForTheNextDayInDouala` (23 h 30 UTC) ; `TestTheStreakGrowsDayAfterDayAndForgivesOneMissedDay` ; `TestPassingAThresholdIsALevelUp` (le total passe 200 : `level_up`).
- [ ] **Step 2:** `go test ./api/ -run "Played|Twice|Replay|Gone|Evening|Streak|Threshold" -v`. Attendu : FAIL.
- [ ] **Step 3:** Implémenter `submitGameLesson`.
- [ ] **Step 4:** Relancer. Attendu : PASS.

### Task 6: Le classement et les réglages du joueur

**Files:**
- Create: `api/games_leaderboard.go`
- Modify: `api/api.go` : `GET /leaderboard`, `PUT /me`
- Test: `api/games_leaderboard_test.go`

**Interfaces:**
- Consumes: `ListGameLeaderboard`, `GetGameRank`, `UpsertGamePlayer`, les liens autorité-disciple acceptés (`ListAcceptedDiscipleLinks` et la requête des autorités du membre dans `authority.sql`), `member_blocks`.
- Produces:
  - `GET /v1/games/leaderboard?period=week|all&scope=all|circle` : `{"period","scope","entries":[{"rank","username","avatar","points","me"}],"me":{"rank","points"}}` ; `me` est nul si le membre n'y figure pas. `avatar` a la forme déjà utilisée pour un membre dans les réponses des disciples. Valeur de `period` ou `scope` inconnue : 400.
  - `PUT /v1/games/me`, corps `{"in_leaderboard":true,"daily_goal":50}` (les deux facultatifs) ; réponse : le `gamePlayerResponse`. `daily_goal` hors de 30, 50, 100 : 400.

- [ ] **Step 1:** Tests : `TestTheLeaderboardListsThoseWhoChoseToAppear` (oui : listé ; non et pas encore choisi : absents, et `me` nul pour eux) ; `TestATieGoesToWhoeverGotThereFirst` ; `TestTheWeekStartsOnMondayInDouala` (une partie de la semaine passée compte dans `all`, pas dans `week`) ; `TestBlockedMembersDoNotSeeEachOther` ; `TestMyCircleIsMyAuthoritiesAndMyDisciples` ; `TestTheDailyGoalIsOneOfThree`.
- [ ] **Step 2:** `go test ./api/ -run "Leaderboard|Tie|Monday|Blocked|Circle|DailyGoal" -v`. Attendu : FAIL.
- [ ] **Step 3:** Implémenter.
- [ ] **Step 4:** Relancer. Attendu : PASS.

### Task 7: Le défi du jour

**Files:**
- Create: `api/games_daily.go`
- Modify: `api/api.go` : `GET /daily`, `POST /daily/results`
- Test: `api/games_daily_test.go`

**Interfaces:**
- Consumes: `ListCompletedGameQuestions`, `CreateGamePlay` (`kind = 'daily'`), `gamePlayer`.
- Produces:
  - `GET /v1/games/daily?lang=` : `{"done":false,"questions":[…]}` (même forme de question que la leçon) : 5 questions des leçons que le membre a terminées, tirées avec une graine faite du membre et du jour de Douala (le même tirage toute la journée) ; moins de 5 questions disponibles : toutes. Aucune leçon terminée : 404.
  - `POST /v1/games/daily/results`, corps comme une leçon ; réponse `{"points":15,"player":{…}}`. Une fois par jour : le second envoi du jour (autre `client_id`) rend `points: 0`. Le défi compte pour la série et l'objectif du jour.

- [ ] **Step 1:** Tests : `TestTheDailyChallengeNeedsALessonDone` (404) ; `TestTheDailyChallengeIsTheSameAllDayAndChangesTheNextDay` ; `TestTheDailyChallengeGivesFifteenPointsOnceADay`.
- [ ] **Step 2:** `go test ./api/ -run Daily -v`. Attendu : FAIL.
- [ ] **Step 3:** Implémenter.
- [ ] **Step 4:** Relancer. Attendu : PASS.

### Task 8: Le premier contenu, « Notre fondateur »

**Files:**
- Create: `data/games/ministry.fr.json`
- Test: `api/admin_games_test.go` (`TestTheShippedCoursesAreValid` : chaque fichier de `data/games/*.json` passe la validation de l'import, et chaque leçon a 8 questions)

**Interfaces:**
- Consumes: le format de la tâche 3.

- [ ] **Step 1:** Écrire le test.
- [ ] **Step 2:** Rédiger le niveau 1 « Notre fondateur » (4 leçons de 8 questions) **uniquement à partir des textes de l'app** : `cmfi_connect_mobile/lib/src/features/ministry/domain/ministry_lives.dart` et les clés `ministry.lives.founder.*` de `fr.i18n.json`. `published: false` : rien n'est visible avant la relecture d'un responsable. Les niveaux 2 à 5 suivront, un fichier relu à la fois.
- [ ] **Step 3:** `go test ./api/ -run Shipped -v`. Attendu : PASS.

### Fin du lot

- [ ] `go vet ./... && go test ./...` sur la base jetable. Attendu : tout passe.
- [ ] Montrer à Boris le résumé des fichiers créés et modifiés, et lui demander s'il veut le commit.
