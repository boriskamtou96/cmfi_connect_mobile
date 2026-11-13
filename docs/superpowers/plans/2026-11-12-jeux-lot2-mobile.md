# Jeux, lot 2 (mobile) : plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** L'onglet Jeux devient jouable : le chemin d'un parcours, une leçon de questions, l'écran de fin, au look de la maquette (`jeux_maquette_v1.png`).

**Architecture:** Une feature `games` (domain freezed, `GamesApi`, notifiers Riverpod, écrans). Le serveur compte les points ; l'app joue la leçon sans réseau puis envoie les réponses avec un `client_id`.

**Tech Stack:** Flutter 3.38, Riverpod 3 (codegen), freezed, auto_route, slang.

**Spec:** `docs/specs/jeux.md` (§0 bis d'abord). API : plan du lot 1 et `cmfi-connect-backend/api/games.go`.

## Global Constraints

- Les règles de `CLAUDE.md` du dépôt : `AppIcons`, `AppSpacing`, `AppModule`/`AppTones`, textes dans les 7 fichiers `.i18n.json` (tutoiement), `apiCall`, `AsyncValue`, toasts, pas de `Colors.white` en fond d'écran, RTL.
- `flutter analyze` propre et `flutter test` vert avant de dire fini. Pas de commit sans demande.
- Look : pastilles rondes en relief (bord plus sombre dessous), boutons épais en capitales, or pour le fait, bleu CMCI pour l'en cours, gris pour le fermé ; Zoé (`DoveMascot`) pose la question et fête la fin. Ni vies ni chrono.
- Tant qu'aucun parcours n'est publié (404 `NOT_FOUND`), l'onglet garde « Bientôt disponible ».

## Review Focus

1. L'envoi du résultat échoue (pas de réseau) : la leçon n'est pas perdue, « Réessayer » renvoie le même `client_id`.
2. Quitter une leçon en cours : une confirmation, rien n'est envoyé.
3. Une question ratée revient une fois à la fin, avec `attempt: 2`.
4. Aucun parcours publié : « Bientôt disponible », pas d'erreur.
5. Arabe (droite à gauche) et grands textes : le chemin et la leçon tiennent sans débordement.

---

### Task 1: Modèles et API

**Files:** Create `lib/src/features/games/domain/game.dart`, `lib/src/features/games/infrastructure/games_api.dart` ; Modify `test/helpers/pump_app.dart`, `test/helpers/fakes.dart` (`FakeGamesApi`, `sampleGamePath`, `sampleGameLesson`).

**Interfaces (Produces):** `GamePath{courses, course, player, levels}`, `GameCourse{code,title}`, `GamePlayer{totalPoints, level, levelFloor, nextLevelAt, streakDays, playedToday, dailyGoal, pointsToday, inLeaderboard, weekRank, dailyDone}`, `GameLevel{id, position, title, description, color, lessons}`, `GameLessonSummary{id, position, title, state, stars}` avec `enum LessonState {done, open, locked}`, `GameLesson{id, title, levelTitle, course, questions}`, `GameQuestion{id, kind, prompt, choices, answer, explanation, source}`, `GameChoice{id, text}`, `GameAnswer{questionId, choice, attempt}`, `GameResult{points, firstTry, total, stars, bestStars, perfect, comboBonus, replay, levelUp, nextLessonId, levelCompleted, player}`. `GamesApi.path({String? course})`, `.lesson(int id)`, `.submitLesson(int id, {required String clientId, required List<GameAnswer> answers})` ; `gamesApiProvider`. `FakeGamesApi` : `path` (nul : 404), `lessons`, `submitted`, `failSubmit`.

- [ ] Test `test/features/games/games_api_test.dart` : les trois appels lisent l'enveloppe et envoient `lang`, `client_id`, `answers` en snake_case. Rouge, puis le code, puis vert.

### Task 2: Une leçon jouée (l'état)

**Files:** Create `lib/src/features/games/application/lesson_play.dart` (pur), `lesson_controller.dart` ; Test `test/features/games/lesson_play_test.dart`.

**Interfaces (Produces):** `LessonPlay` immuable : `LessonPlay.start(GameLesson, {Random? random})`, `current`, `step`/`steps` (progression), `selected`, `checked`, `isRight`, `run` (bonnes réponses de suite), `answers`, `finished` ; `choose(String)`, `check()`, `next()`. `lessonControllerProvider(lessonId)` : charge la leçon, joue, envoie (`send()`), garde `result` ou `sendError`.

- [ ] Tests : une bonne réponse avance ; une mauvaise revient à la fin avec `attempt: 2` ; `run` repart de zéro sur une erreur ; fin quand tout est juste ; `check` sans choix ne fait rien. Rouge, code, vert.

### Task 3: Les écrans

**Files:** Create `lib/src/features/games/application/game_path.dart`, `presentation/games_screen.dart` (remplace le provisoire), `presentation/lesson_screen.dart`, `presentation/widgets/game_widgets.dart` ; Modify `routing/app_router.dart` (`LessonRoute`, `/games/lessons/:lessonId`, plein écran), les 7 `.i18n.json` (`games.*`), `app_icons.dart` ; Test `test/features/games/games_test.dart`, `test/features/shell/menu_test.dart`.

- [ ] Tests : sans parcours, « Bientôt disponible » ; le chemin montre les niveaux, la leçon ouverte et « Commencer », la série et les points ; une leçon fermée ne s'ouvre pas ; une leçon jouée de bout en bout (une erreur qui revient) envoie les réponses et montre les points, puis le chemin se recharge ; l'envoi qui échoue propose « Réessayer » avec le même `client_id` ; quitter demande confirmation ; l'arabe ne déborde pas. Rouge, code, vert.

### Fin du lot

- [ ] `flutter analyze` et tous les tests ; captures des écrans réels envoyées à Boris.
