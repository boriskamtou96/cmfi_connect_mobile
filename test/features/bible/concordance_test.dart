import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible.dart';
import 'package:cmfi_connect/src/features/bible/presentation/bible_screen.dart';
import 'package:cmfi_connect/src/features/bible/presentation/concordance_screen.dart';
import 'package:cmfi_connect/src/features/shell/presentation/widgets/floating_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/bible_fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('the concordance of a Bible', () {
    final bible = BibleText.fromJson(sampleCompleteBible());

    test('a word: every verse, every time, book by book', () {
      final found = bible.concordance('monde');
      expect(
        [for (final hit in found.hits) hit.ref.key],
        ['JHN.3.16', 'JHN.3.17'],
      );
      // three times in John 3:17
      expect(found.occurrences, 4);
      expect(found.byBook, {'JHN': 4});
      final hit = found.hits.first;
      expect(
        hit.text.substring(hit.ranges.single.start, hit.ranges.single.end),
        'monde',
      );
      // a word inside another is not the word
      expect(bible.concordance('mon').hits.map((hit) => hit.ref.key), [
        'PSA.23.1',
      ]);
    });

    test('accents: ignored when not typed, kept when typed', () {
      expect(bible.concordance('aime').forms, [(form: 'aimé', count: 1)]);
      expect(bible.concordance('AIMÉ').occurrences, 1);
      expect(bible.concordance('aimè').hits, isEmpty);
    });

    test('starts with: every form, the most frequent first', () {
      final found = bible.concordance('eter', prefix: true);
      expect(found.hits.map((hit) => hit.ref.key), ['PSA.23.1', 'JHN.3.16']);
      expect(found.forms.map((form) => form.form), {'Éternel', 'éternelle'});
      // "L’Éternel": the apostrophe parts the words
      expect(bible.concordance('éternel').occurrences, 1);
    });

    test('too short, or not a word: nothing', () {
      expect(bible.concordance('a').hits, isEmpty);
      expect(bible.concordance('  ').hits, isEmpty);
    });

    test('Chinese: the characters are looked for', () {
      final chinese = BibleText(
        books: const [
          BibleBook(id: 'JHN', name: '约翰福音', order: 43, chapters: 3),
        ],
        chapters: {
          'JHN': [
            BibleChapter.fromJson('JHN', const {
              'number': 3,
              'content': [
                {
                  'type': 'verse',
                  'number': 16,
                  'content': ['神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。'],
                },
              ],
            }),
          ],
        },
      );
      final found = chinese.concordance('世人');
      expect(found.occurrences, 1);
      expect(found.hits.single.ranges.single, (start: 2, end: 4));
      expect(concordanceWords('神爱世人'), isEmpty);
    });

    test('the words a verse offers: each once, long enough', () {
      expect(
        concordanceWords(
          'Car Dieu a tant aimé le monde qu’il a donné son Fils, '
          'que Dieu aime le monde 3 fois.',
        ),
        // "aime" is "aimé" without its accent: once
        [
          'Car',
          'Dieu',
          'tant',
          'aimé',
          'monde',
          'donné',
          'son',
          'Fils',
          'que',
          'fois',
        ],
      );
    });
  });

  /// The app on the Bible tab, at [at], the Bible downloaded or not.
  Future<TestApp> openBible(
    WidgetTester tester, {
    String at = 'JHN.3',
    bool downloaded = true,
  }) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'bible_tap_hint_seen': true, 'bible_position': at},
    );
    await tester.tap(
      find.descendant(
        of: find.byType(FloatingNavBar),
        matching: find.text('Bible'),
      ),
    );
    await tester.pumpAndSettle();
    if (downloaded) {
      await tester.tap(find.byTooltip("Plus d'options"));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Télécharger cette Bible'));
      await tester.pumpAndSettle();
    }
    return app;
  }

  Future<void> type(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(TextField), text);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
  }

  Finder verse(String words) => find.textContaining(words, findRichText: true);

  /// Scrolls the results until [finder] shows.
  Future<void> reveal(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
  }

  testWidgets('from the search: a word, all its verses, one opens', (
    tester,
  ) async {
    final app = await openBible(tester);
    app.bibleApi.offline = true;

    await tester.tap(find.byTooltip('Rechercher dans la Bible'));
    await tester.pumpAndSettle();
    await type(tester, 'monde');
    await tester.tap(find.text('Concordance de « monde »'));
    await tester.pumpAndSettle();

    expect(find.byType(ConcordanceScreen), findsOneWidget);
    expect(find.text('4'), findsWidgets);
    expect(find.text('occurrences dans 2 versets'), findsOneWidget);
    expect(find.text('JEAN  ·  4'), findsOneWidget);
    expect(find.bySemanticsLabel('Jean : 4'), findsOneWidget);

    // the word in every form
    await tester.tap(find.text('Commence par…'));
    await tester.pumpAndSettle();
    await reveal(tester, find.text('Jean 3:17'));

    await tester.tap(find.text('Jean 3:17'));
    await tester.pumpAndSettle();
    expect(find.byType(BibleScreen), findsOneWidget);
    expect(find.text('Jean 3'), findsOneWidget);
    expect(verse('Dieu, en effet'), findsOneWidget);
  });

  testWidgets('from a verse: a word of it, then its concordance', (
    tester,
  ) async {
    await openBible(tester);

    await tester.ensureVisible(verse('Car Dieu a tant aimé'));
    await tester.pumpAndSettle();
    await tester.tap(verse('Car Dieu a tant aimé'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Concordance'));
    await tester.pumpAndSettle();

    expect(find.text('Choisis un mot'), findsOneWidget);
    // short words are left out
    expect(find.widgetWithText(ActionChip, 'tant'), findsOneWidget);
    expect(find.widgetWithText(ActionChip, 'le'), findsNothing);
    await tester.tap(find.widgetWithText(ActionChip, 'Dieu'));
    await tester.pumpAndSettle();

    expect(find.byType(ConcordanceScreen), findsOneWidget);
    expect(find.text('occurrences dans 4 versets'), findsOneWidget);

    // a book of the bars keeps only its verses
    await tester.tap(find.bySemanticsLabel('Jean : 4'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(InputChip, 'Jean : 4'), findsOneWidget);
    await tester.tap(find.byTooltip('Tous les livres'));
    await tester.pumpAndSettle();
    expect(find.byType(InputChip), findsNothing);
  });

  testWidgets('not downloaded: the concordance asks for the download', (
    tester,
  ) async {
    await openBible(tester, downloaded: false);

    await tester.tap(find.byTooltip("Plus d'options"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Concordance'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('tous les versets où il apparaît'),
      findsOneWidget,
    );

    await type(tester, 'monde');
    expect(find.textContaining('télécharge-la d'), findsOneWidget);
    expect(find.text('Télécharger cette Bible'), findsOneWidget);
  });
}
