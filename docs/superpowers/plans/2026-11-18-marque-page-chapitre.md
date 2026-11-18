# Marque-page de lecture : plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal :** un seul marque-page de chapitre, posé depuis le menu ⋮ du lecteur, avec un ruban sur le chapitre marqué et une pastille qui y ramène depuis tout autre chapitre.

**Architecture :** un notifier `BibleBookmark` (shared_preferences, clé `bible_bookmark`, chapitre USFM « MAT.5 ») à côté de `BiblePosition`. Le lecteur (`bible_screen.dart`) lit ce notifier : ligne du menu ⋮, ruban sur la page marquée, pastille de retour au-dessus de la barre d'écoute.

**Tech Stack :** Flutter 3.38, Riverpod 3 (codegen), slang (7 langues), Phosphor via `AppIcons`.

**Spec :** `docs/superpowers/specs/2026-11-18-marque-page-chapitre-design.md`

## Global Constraints

- Un chapitre, jamais un verset : `BibleRef.chapterRef`, clé « JHN.3 ».
- Un seul marque-page ; le poser ailleurs le déplace.
- Gardé à la déconnexion (comme `bible_marks`) : ne pas l'ajouter au nettoyage de `App`.
- Aucun texte en dur : les clés dans les 7 fichiers `.i18n.json` (fr d'abord), tutoiement.
- Icônes par `AppIcons` seulement ; directions `EdgeInsetsDirectional` / `PositionedDirectional`.
- `flutter analyze && flutter test` verts avant la fin ; régénérer avec `make gen` (sinon `dart run slang` pour les textes).
- Ne commiter qu'à la demande de l'utilisateur.

## Review Focus

- Une valeur illisible dans `bible_bookmark` : pas de marque-page, aucune erreur.
- Une version sans le livre marqué : pas de pastille (le chapitre n'est pas dans `pages`).
- Pendant la sélection de versets : la pastille se cache (la barre des versets prend sa place).
- Le retour par la pastille pendant que la Bible est écoutée : la pastille et la barre d'écoute tiennent ensemble.
- Les lecteurs d'écran : le ruban dit « Marque-page », la pastille « Revenir à Jean 3 ».

---

### Task 1 : le marque-page dans le lecteur

**Files :**
- Create : `lib/src/features/bible/application/bible_bookmark.dart`
- Modify : `lib/src/features/bible/presentation/bible_screen.dart` (menu ⋮ `_MenuAction`, `_ChapterPage`, bas du lecteur)
- Modify : `lib/src/core/theme/app_icons.dart`
- Modify : `lib/src/core/i18n/{fr,en,de,es,ar,zh,hi}.i18n.json` (section `bible`)
- Test : `test/features/bible/bible_test.dart`

**Interfaces :**
- Produces : `@Riverpod(keepAlive: true) class BibleBookmark` → `BibleRef? build()` (null sans valeur ou valeur illisible), `Future<void> set(BibleRef chapter)` (garde `chapter.chapterRef`), `Future<void> clear()`. Provider : `bibleBookmarkProvider`.
- Produces : `AppIcons.readingMark` (`PhosphorIconsRegular.bookmark`) et `AppIcons.readingMarkFilled` (`PhosphorIconsFill.bookmark`), distincts du signet des favoris (`bookmarkSimple`).
- Produces : textes `t.bible.markChapter` (« Marquer ce chapitre »), `t.bible.unmarkChapter` (« Retirer le marque-page »), `t.bible.bookmarkSet(place:)` (« Marque-page posé sur $place »), `t.bible.bookmarkRemoved` (« Marque-page retiré »), `t.bible.bookmark` (« Marque-page »), `t.bible.backToBookmark(place:)` (« Revenir à $place »).

- [ ] **Step 1 : écrire les tests qui échouent** (dans `bible_test.dart`, avec `openBible`)

```dart
testWidgets('a chapter marked; elsewhere, a pill brings back to it', (tester) async {
  final app = await openBible(tester, at: 'JHN.3');
  await tester.tap(find.byTooltip("Plus d'options"));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Marquer ce chapitre'));
  await tester.pumpAndSettle();

  expect(app.preferences.getString('bible_bookmark'), 'JHN.3');
  expect(app.toasts.messages, contains('Marque-page posé sur Jean 3'));
  expect(find.bySemanticsLabel('Marque-page'), findsOneWidget);
  expect(find.byTooltip('Revenir à Jean 3'), findsNothing); // on it already

  // browse elsewhere: Psalm 23
  await tester.tap(find.text('Jean 3'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Ancien Testament'));
  await tester.pumpAndSettle();
  await tapInView(tester, find.text('Psaumes'));
  await tapInView(tester, find.text('23'));
  expect(find.bySemanticsLabel('Marque-page'), findsNothing);

  // the pill hides while verses are selected
  await tapVerse(tester, 'L’Éternel est mon berger');
  expect(find.byTooltip('Revenir à Jean 3'), findsNothing);
  await tester.tap(find.byTooltip('Fermer la sélection'));
  await tester.pumpAndSettle();

  await tester.tap(find.byTooltip('Revenir à Jean 3'));
  await tester.pumpAndSettle();
  expect(find.text('Jean 3'), findsOneWidget);
  expect(app.preferences.getString('bible_position'), 'JHN.3');
  expect(find.byTooltip('Revenir à Jean 3'), findsNothing);
});

testWidgets('the bookmark moves to another chapter, then is removed', (tester) async {
  final app = await openBible(tester, at: 'JHN.3', preferences: {'bible_bookmark': 'PSA.23'});
  expect(find.byTooltip('Revenir à Psaumes 23'), findsOneWidget);

  await tester.tap(find.byTooltip("Plus d'options"));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Marquer ce chapitre'));
  await tester.pumpAndSettle();
  expect(app.preferences.getString('bible_bookmark'), 'JHN.3');

  await tester.tap(find.byTooltip("Plus d'options"));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Retirer le marque-page'));
  await tester.pumpAndSettle();
  expect(app.preferences.getString('bible_bookmark'), isNull);
  expect(app.toasts.messages, contains('Marque-page retiré'));
  expect(find.bySemanticsLabel('Marque-page'), findsNothing);
});

testWidgets('an unreadable bookmark is no bookmark', (tester) async {
  await openBible(tester, at: 'JHN.3', preferences: {'bible_bookmark': '???'});
  expect(find.textContaining('Revenir à'), findsNothing);
  await tester.tap(find.byTooltip("Plus d'options"));
  await tester.pumpAndSettle();
  expect(find.text('Marquer ce chapitre'), findsOneWidget);
});
```

- [ ] **Step 2 : lancer les tests, ils échouent**

Run : `flutter test test/features/bible/bible_test.dart --plain-name "bookmark"` puis `--plain-name "a chapter marked"`
Expected : FAIL (« Marquer ce chapitre » introuvable).

- [ ] **Step 3 : écrire `BibleBookmark`, les icônes et les textes**

`BibleBookmark` comme `BiblePosition` : `BibleRef.parse(...)?.chapterRef`, `setString` / `remove`. Les 6 clés dans les 7 langues (fr d'abord), puis `make gen`.

- [ ] **Step 4 : le lecteur**

- Menu ⋮ : `_MenuAction.bookmark` en tête ; `readingMark` + `markChapter` si `bookmark != current`, sinon `readingMarkFilled` + `unmarkChapter`. Toucher : `set(current)` + `toast.success(bookmarkSet(place: bibleLabel(current, books)))`, ou `clear()` + `toast.success(bookmarkRemoved)`.
- Ruban : sur la page dont `place == bookmark`, un ruban doré (`AppColors.gold`, `readingMarkFilled`) en `PositionedDirectional(top: 0, end: 16)` au-dessus du texte, `Semantics(label: t.bible.bookmark)`.
- Pastille `_BookmarkReturn` : quand aucun verset n'est sélectionné, `bookmark != null`, `bookmark != current` et `pages.contains(bookmark)` ; en bas du lecteur, centrée, au-dessus de `_ListeningBar` (une `Column` en `mainAxisSize.min`). Contenu : `readingMarkFilled` + `bibleLabel(bookmark, books)`, couleurs de `ReaderPalette`, 48 dp de haut au moins, `Tooltip`/`Semantics` `backToBookmark(place:)`. Toucher : `biblePositionProvider.notifier.set(bookmark)`.

- [ ] **Step 5 : lancer les tests, ils passent**

Run : `flutter test test/features/bible/bible_test.dart`
Expected : tous PASS.

- [ ] **Step 6 : vérifier et documenter**

Run : `flutter analyze && flutter test`
Expected : aucun problème, tous les tests passent (dont `test/core/i18n_test.dart`).
Ajouter au CLAUDE.md, section Bible, une ligne « Marque-page de lecture (18/11/2026) » : `BibleBookmark`, clé `bible_bookmark`, menu ⋮, ruban, pastille.
Pas de commit sans demande de l'utilisateur.
