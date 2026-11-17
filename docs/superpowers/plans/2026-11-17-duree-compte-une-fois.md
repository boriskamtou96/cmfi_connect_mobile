# Une durée compte aussi une fois : plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Pour un élément qui compte des « fois » et une durée, chaque chrono terminé ajoute 1, et une durée saisie dans la feuille sur un nombre vide le met à 1.

**Architecture:** Une propriété pure `ReportEntry.countsTimes`. Elle est lue à deux endroits : `addMinutesToDayReport` (chrono) et `EntrySheet` (saisie). Rien côté serveur.

**Tech Stack:** Flutter 3.38, Riverpod 3, freezed, flutter_test (`pumpApp`, fakes de `test/helpers`).

**Spec:** `docs/superpowers/specs/2026-11-17-duree-compte-une-fois-design.md`

## Global Constraints

- Ne rien commiter sans demande de l'utilisateur (CLAUDE.md) : les étapes « commit » sont remplacées par `flutter analyze` propre.
- Pas de génération à relancer : `countsTimes` est un getter dans la partie `const ReportEntry._()` déjà présente (freezed n'a pas à être régénéré).
- Le nombre reste borné à 9999 (comme `addToDayReport`).

## Review Focus

- Un élément personnel avec nombre + durée et l'unité `''` ou `'  '` (espaces) : compte comme « fois ».
- Un chrono sur Lecture biblique (LB, chapitres + minutes) : le nombre de chapitres ne bouge pas.
- La feuille ouverte sur un RDQAD qui a déjà 30 min et 0 fois (ancienne donnée) : le nombre passe à 1 à l'ouverture. C'est accepté, car la durée est > 0 et le nombre est à 0.
- Le chrono d'importunité / les retraites (PS) : inchangés (PS n'a pas de nombre).
- Le nombre remis à 0 à la main après une durée : il reste à 0 (l'effet ne dépend que de la durée).

---

### Task 1: `ReportEntry.countsTimes`

**Files:**
- Modify: `lib/src/features/reports/domain/daily_report.dart` (partie `const ReportEntry._()`)
- Test: `test/features/reports/domain/counts_times_test.dart` (nouveau)

**Interfaces:**
- Produces: `bool get countsTimes` sur `ReportEntry` : `tracksQuantity && tracksDuration` et, si `StandardItem.of(code)` existe, son `unit == StandardUnit.times`, sinon `quantityUnit` nul ou vide après `trim()`.

- [ ] **Step 1: Test** `countsTimes: standard « times » items and personal ones without a unit`. Avec `ReportEntry(activityTypeId:, code:, label:, tracksQuantity:, quantityUnit:, tracksDuration:)` :
  - `RDQAD` (q + d, `'Nombre de fois'`) → true ;
  - `PG` (q + d) → true ;
  - `LB` (q + d, `'chapitres'`) → false ;
  - `LLC` (q + d, `'Nombre de pages'`) → false ;
  - `PS` (d) → false ;
  - `JC` (q seul) → false ;
  - `CHANT` (q + d, `null`) → true ;
  - `CHANT` (q + d, `'  '`) → true ;
  - `CHANT` (q + d, `'personnes'`) → false.
- [ ] **Step 2:** `flutter test test/features/reports/domain/counts_times_test.dart` : échoue (getter absent).
- [ ] **Step 3:** Écrire le getter (import `standard_item.dart`).
- [ ] **Step 4:** Relancer : PASS.

### Task 2: le chrono ajoute 1

**Files:**
- Modify: `lib/src/features/reports/application/report_counts.dart` (`addMinutesToDayReport`)
- Test: `test/features/reports/presentation/report_timer_test.dart`

**Interfaces:**
- Consumes: `ReportEntry.countsTimes` (Task 1).
- `addMinutesToDayReport` garde sa signature. Dans `updateEntry`, `quantity:` devient `entry.countsTimes ? ((entry.quantity ?? 0) + 1).clamp(0, 9999) : entry.quantity`. Mettre à jour son commentaire de doc.

- [ ] **Step 1: Test** `« Terminer » on an item counted in times: its minutes and one more time`.
  - Mise en place : `pumpApp(tester, token: 't', activities: [...sampleActivities, ActivityType(id: 3, code: 'RDQAD', label: 'Méditation', tracksQuantity: true, quantityUnit: 'Nombre de fois', tracksDuration: true, isStandard: true)])`.
  - Un `RunningTimer` RDQAD (id 3) démarré il y a 20 min et en pause, posé dans `initialPreferences[ReportTimer.key]` comme le test « Terminer » existant.
  - Taper « Terminer » : l'entrée RDQAD de `app.reportsApi.days[today()]` a `quantity == 1` et `durationMinutes == 20`.
  - Puis, sans passer par l'interface : `start()` sur `reportTimerProvider.notifier` pour RDQAD, puis `finish()` directement. Le nombre attendu est `2`. Si `start` demande d'autres paramètres, reprendre ceux du premier test.
- [ ] **Step 2: Test** `« Terminer » on Lecture biblique leaves its chapters alone`.
  - Activités : `LB` avec `tracksDuration: true` et une journée existante `quantity: 3`. Pour la journée, suivre comment `FakeReportsApi.days` est pré-rempli ailleurs dans les tests.
  - Chrono LB de 10 min terminé : `quantity == 3`, `durationMinutes == 10`.
- [ ] **Step 3:** `flutter test test/features/reports/presentation/report_timer_test.dart` : les deux nouveaux échouent (quantité nulle / inchangée), les anciens passent.
- [ ] **Step 4:** Modifier `addMinutesToDayReport`.
- [ ] **Step 5:** Relancer : tout PASS.

### Task 3: la feuille met le nombre à 1

**Files:**
- Modify: `lib/src/features/reports/presentation/widgets/entry_sheet.dart` (`EntrySheet.build`, près de `final minutes = useState(...)`)
- Test: `test/features/reports/presentation/today_view_test.dart`

**Interfaces:**
- Consumes: `ReportEntry.countsTimes`.
- Un `useEffect` qui dépend de `[minutes.value]` : si `entry.countsTimes`, `(minutes.value ?? 0) > 0` et `(quantity() ?? 0) == 0`, alors `quantityController.text = '1'`.

- [ ] **Step 1: Test** `a duration on an item counted in times counts it once`.
  - Activités avec RDQAD (comme Task 2).
  - Onglet « Compte rendu », toucher « Méditation », toucher la puce `15 min` (libellé de `15.toDurationLabel()`), puis « Valider » et « Enregistrer la journée » (suivre le parcours des tests existants de `today_view_test.dart`).
  - Résultat : l'entrée RDQAD enregistrée a `quantity == 1` et `durationMinutes == 15`.
- [ ] **Step 2: Test** `… but leaves a count already given, and items in pages`.
  - RDQAD : taper `3` dans le champ du nombre, puis la puce `30 min`. Résultat : `quantity == 3`.
  - Puis LLC (q + d, `'Nombre de pages'`) avec la puce `15 min`. Résultat : `quantity` nulle.
- [ ] **Step 3:** Lancer ces tests : échec attendu.
- [ ] **Step 4:** Ajouter l'effet.
- [ ] **Step 5:** Relancer : PASS.

### Task 4: vérification et doc

- [ ] `flutter analyze` : aucun problème.
- [ ] `flutter test test/features/reports` : tout passe.
- [ ] CLAUDE.md, § « Compte rendu : hors ligne… », paragraphe « Chrono et Début – fin » : ajouter une phrase qui renvoie à `countsTimes`. Elle dit qu'un élément compté en fois et en temps (RDQAD, PG, personnel sans unité) gagne 1 fois par chrono terminé, et passe à 1 quand une durée est saisie sur un nombre vide (17/11/2026).
