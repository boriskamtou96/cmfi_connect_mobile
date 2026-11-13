# Jeux, lot 4 : le back-office — plan

> **For agentic workers:** REQUIRED SUB-SKILL: superpowers:executing-plans (native, in this session). Steps use checkbox (`- [ ]`) syntax.

**Goal:** the admins write, order, publish and correct the games from the web site, and see which questions are missed the most.

**Architecture:** the back-office edits the content piece by piece, with stable ids (the import replaces a whole course and is refused once it is played). Every write gives back the parent whole: the course for its levels and lessons, the lesson for its questions. A small table counts, per question, the first answers and the wrong ones.

**Tech stack:** Go + gin + sqlc (backend, `feat/games`), React 19 + TanStack Query + Tailwind (web, `feat/games`).

**Spec:** `docs/specs/jeux.md` §8 (and §6 : « Une leçon n'est jouable que publiée, avec au moins 8 questions actives »).

## Global constraints

- Backend: envelope `{status, content}`, tests named as sentences on a disposable database, transactions in package `db` only, `sqlc generate` v1.31.1.
- Web: `api()` of `lib/api.ts` only, texts in `fr.ts` then `en.ts`, tokens for colors, icons from `components/icons.ts`, `useConfirm` for what cannot be undone, `MoveButtons` to order (the site's way; no drag and drop package), `npm run check` before done.
- Texts of the games are kept in the 7 languages of the app (`fr` required, `en`, `de`, `es`, `ar`, `zh`, `hi`).
- A published lesson has at least 8 questions.

## Review focus

1. Two admins order the same list: the second sends ids that no longer match → 409 `ORDER_OUT_OF_DATE`, nothing moves.
2. Deleting a level or a lesson members played → 409 `GAME_CONTENT_PLAYED` (unpublish instead).
3. Publishing a lesson of fewer than 8 questions, or taking a question out of a published lesson of 8 → 409 `LESSON_TOO_SHORT`.
4. A member in the middle of a lesson when a question is deleted: the play still counts (unknown questions are ignored).
5. A question nobody answered yet: no rate shown (never a division by zero).

---

### Task 1 (backend): what was missed, per question

**Files:** `internal/db/migration/000042_game_question_stats.{up,down}.sql`, `internal/db/query/games.sql`, `api/games.go` (the first play of a lesson counts its first answers), test `api/admin_games_stats_test.go`.

- Table `game_question_stats (question_id PK → game_questions ON DELETE CASCADE, asked INT, missed INT)`.
- Only the first play of a lesson by a member counts (kind `lesson`), and only the first answer to each question.
- Query `BumpGameQuestionStats(question_ids bigint[], missed int[])`.

### Task 2 (backend): read and write the content

**Files:** `api/admin_games_content.go`, `internal/db/query/games_admin.sql`, `internal/db/sqlc/games_store.go` (`ReorderGameLevelsTx`, `ReorderGameLessonsTx`, `ReorderGameQuestionsTx`, `ErrGameOrderOutOfDate`), `api/api.go`, tests `api/admin_games_content_test.go`.

| Route (under `/v1/admin/games`) | Body | Answer |
|---|---|---|
| `GET /courses` | | `[{code, position, title, published, levels, lessons, questions}]` (drafts too) |
| `POST /courses` | `{code, title}` | 201 course ; 409 `CONFLICT` |
| `GET /courses/:code` | | course : `{code, position, title, published, levels: [{id, position, title, description, color, published, lessons: [{id, position, title, published, questions, players}]}]}` |
| `PUT /courses/:code` | `{title, published}` | course ; 409 `COURSE_EMPTY` to publish without a published level |
| `POST /courses/:code/levels` | `{title, description, color}` | 201 course (the level is a draft, last) |
| `PUT /courses/:code/levels/order` | `{ids}` | course ; 409 `ORDER_OUT_OF_DATE` |
| `PUT /levels/:id` | `{title, description, color, published}` | course ; 409 `LEVEL_EMPTY` to publish without a published lesson |
| `DELETE /levels/:id` | | course ; 409 `GAME_CONTENT_PLAYED` |
| `POST /levels/:id/lessons` | `{title}` | 201 course (draft, last) |
| `PUT /levels/:id/lessons/order` | `{ids}` | course |
| `GET /lessons/:id` | | lesson : `{id, level_id, level_title, course, position, title, published, players, questions: [{id, position, kind, prompt, choices: [{id, text}], answer, explanation, source, asked, missed}]}` |
| `PUT /lessons/:id` | `{title, published}` | lesson ; 409 `LESSON_TOO_SHORT` |
| `DELETE /lessons/:id` | | course ; 409 `GAME_CONTENT_PLAYED` |
| `POST /lessons/:id/questions` | question | 201 lesson |
| `PUT /lessons/:id/questions/order` | `{ids}` | lesson |
| `PUT /questions/:id` | question | lesson |
| `DELETE /questions/:id` | | lesson ; 409 `LESSON_TOO_SHORT` |

Question: `{kind, prompt, choices: [{id, text}], answer, explanation, source}`, checked like the import. Texts are trimmed, empty languages dropped, unknown languages refused. Limits: title 120, description 300, prompt 500, a choice 200, explanation 1000, 6 choices at most.

### Task 3 (backend): the numbers

`GET /v1/admin/games/stats` → `{players: {total, week, in_leaderboard}, lessons_completed: {total, week}, plays_week, hardest: [{question_id, lesson_id, lesson_title, course, prompt, asked, missed}]}` — the week starts on Monday, Douala time; `hardest`: 10 at most, asked 5 times at least, missed at least once, the highest rate first; titles and prompt in French.

### Task 4 (web): the section « Jeux »

**Files:** `src/features/games/` — `types.ts`, `api.ts`, `gameDraft.ts` (+ test), `GamesPage.tsx`, `CoursePage.tsx`, `LessonPage.tsx`, `QuestionPage.tsx`, `QuestionForm.tsx`, `QuestionPreview.tsx`, `TextsField.tsx`, `ImportCourse.tsx`, tests ; `App.tsx`, `components/AppLayout.tsx`, `components/icons.ts`, `i18n/fr.ts`, `i18n/en.ts`, `lib/errors.ts`, `CLAUDE.md`, `README.md`.

- `/games` : the numbers, the courses (drafts too), « Nouveau parcours », « Importer un fichier », the most missed questions (each opens its question).
- `/games/:code` : the course (title, publish), its levels (color, publish, order, edit, delete) and their lessons (order, open, add).
- `/games/lessons/:id` : the lesson (title, publish, delete), its questions (order, rate of misses, add).
- `/games/lessons/:id/questions/new` and `/:questionId` : the editor — a tab per language (French first, a dot on the languages filled), kind, prompt, choices with the right one, explanation, source (none, a page of « Notre ministère », a Bible reference), and the preview « Dans l'app ».

### Task 5: docs and the whole suites

`go vet`, `go test ./...`, `npm run check`, CLAUDE.md of the three repos, README of the web, the spec's §8 and §10.
