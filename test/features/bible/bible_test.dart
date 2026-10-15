import 'dart:convert';
import 'dart:io';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/core/widgets/reader/reader_palette.dart';
import 'package:cmfi_connect/src/features/bible/application/bible_marks.dart';
import 'package:cmfi_connect/src/features/bible/application/bible_position.dart';
import 'package:cmfi_connect/src/features/bible/application/bible_settings.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible.dart';
import 'package:cmfi_connect/src/features/bible/presentation/bible_screen.dart';
import 'package:cmfi_connect/src/features/bible/presentation/widgets/chapter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  /// The app on the Bible tab, at [at] ("JHN.3"; John 1 without it).
  Future<TestApp> openBible(
    WidgetTester tester, {
    String? at,
    Map<String, Object> preferences = const {},
  }) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {
        'bible_tap_hint_seen': true,
        'bible_position': ?at,
        ...preferences,
      },
    );
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Bible'),
      ),
    );
    await tester.pumpAndSettle();
    return app;
  }

  Finder verse(String words) => find.textContaining(words, findRichText: true);

  /// A tap on the verse holding [words], brought to the top first (the
  /// letters of the tests are big).
  Future<void> tapVerse(WidgetTester tester, String words) async {
    await tester.ensureVisible(verse(words));
    await tester.pumpAndSettle();
    await tester.tap(verse(words));
    await tester.pumpAndSettle();
  }

  /// Types [query] in the search, and waits for what it finds.
  Future<void> search(WidgetTester tester, String query) async {
    await tester.enterText(find.byType(TextField), query);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
  }

  Future<void> tapInView(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('the Bible opens on John 1; a swipe reads the next chapter', (
    tester,
  ) async {
    final app = await openBible(tester);

    expect(find.byType(BibleScreen), findsOneWidget);
    expect(find.text('Jean 1'), findsOneWidget);
    expect(find.text('LSG'), findsOneWidget);
    expect(verse('Texte de Jean 1:1.'), findsOneWidget);

    await tester.fling(find.byType(PageView), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle();

    expect(find.text('Jean 2'), findsOneWidget);
    expect(verse('Texte de Jean 2:1.'), findsOneWidget);
    // remembered, and kept to read again without network
    expect(app.preferences.getString('bible_position'), 'JHN.2');
    expect(app.bibleStorage.files.keys, contains('fra_lsg/JHN.1.json'));
    expect(app.bibleStorage.files.keys, contains('fra_lsg/books.json'));
  });

  testWidgets('a book, then a chapter, from the list', (tester) async {
    await openBible(tester);

    await tester.tap(find.text('Jean 1'));
    await tester.pumpAndSettle();
    // John is in the New Testament: the Old one is a tap away
    await tester.tap(find.text('Ancien Testament'));
    await tester.pumpAndSettle();
    await tapInView(tester, find.text('Psaumes'));
    await tapInView(tester, find.text('23'));

    expect(find.text('Psaumes 23'), findsOneWidget);
    expect(verse('L’Éternel est mon berger'), findsOneWidget);
  });

  testWidgets('verses selected: highlighted, kept, copied, shared', (
    tester,
  ) async {
    String? copied;
    final messenger = tester.binding.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        copied = (call.arguments as Map)['text'] as String;
      }
      return null;
    });
    addTearDown(
      () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
    );
    final app = await openBible(tester, at: 'JHN.3');

    await tapVerse(tester, 'Car Dieu a tant aimé');
    await tapVerse(tester, 'Dieu, en effet');
    expect(find.text('Jean 3:16-17'), findsOneWidget);

    await tester.tap(find.byTooltip('Surligner en jaune'));
    await tester.pumpAndSettle();
    final marks = app.container.read(bibleMarksProvider);
    expect(marks['JHN.3.16']?.color, 0);
    expect(marks['JHN.3.17']?.color, 0);
    expect(marks['JHN.3.16']?.version, 'LSG');
    // the bar goes once used
    expect(find.text('Jean 3:16-17'), findsNothing);

    await tapVerse(tester, 'Car Dieu a tant aimé');
    await tester.tap(find.byTooltip('Ajouter à Mes versets'));
    await tester.pumpAndSettle();
    expect(
      app.container.read(bibleMarksProvider)['JHN.3.16']?.bookmarked,
      true,
    );
    expect(app.toasts.messages, contains('Ajouté à Mes versets'));

    await tapVerse(tester, 'Car Dieu a tant aimé');
    await tapVerse(tester, 'Dieu, en effet');
    await tester.tap(find.byTooltip('Copier'));
    await tester.pumpAndSettle();
    expect(copied, startsWith('16 Car Dieu a tant aimé le monde'));
    expect(copied, contains(' 17 Dieu, en effet'));
    expect(copied, endsWith('\nJean 3:16-17 (LSG)'));

    await tapVerse(tester, 'Car Dieu a tant aimé');
    await tester.tap(find.byTooltip('Partager'));
    await tester.pumpAndSettle();
    final shared = app.share.texts.single;
    expect(shared, startsWith('Car Dieu a tant aimé le monde'));
    expect(shared, contains('\nJean 3:16 (LSG)\n'));
    expect(shared, endsWith('/open?to=bible/JHN.3.16'));
  });

  testWidgets('the words of Jesus in red, unless turned off', (tester) async {
    final app = await openBible(tester, at: 'JHN.3');

    Color? colorOf(String words) {
      final text = tester.widget<RichText>(verse(words));
      Color? found;
      text.text.visitChildren((span) {
        if (span is TextSpan &&
            (span.text ?? '').contains(words) &&
            span.style?.color != null) {
          found = span.style!.color;
        }
        return true;
      });
      return found;
    }

    expect(colorOf('En vérité, en vérité'), jesusColor(ReaderPalette.light));
    expect(colorOf('Jésus lui répondit'), isNull);

    await app.container
        .read(bibleSettingsControllerProvider.notifier)
        .update((settings) => settings.copyWith(jesusInRed: false));
    await tester.pumpAndSettle();
    expect(colorOf('En vérité, en vérité'), isNull);
  });

  testWidgets("\"J'ai lu ce chapitre\" counts it in today's report", (
    tester,
  ) async {
    final app = await openBible(tester, at: 'JHN.3');

    await tester.scrollUntilVisible(
      find.text("J'ai lu ce chapitre"),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text("J'ai lu ce chapitre"));
    await tester.pumpAndSettle();

    int? chapters() => app.reportsApi.days[today()]?.entries
        .where((entry) => entry.code == 'LB')
        .firstOrNull
        ?.quantity;
    expect(chapters(), 1);
    expect(
      app.toasts.messages,
      contains("Compte rendu : 1 chapitre lu aujourd'hui"),
    );
    expect(find.text("Lu aujourd'hui"), findsOneWidget);

    // touched again: taken back
    await tester.tap(find.text("Lu aujourd'hui"));
    await tester.pumpAndSettle();
    expect(chapters(), isNull);
    expect(app.toasts.messages.last, 'Retiré de ton compte rendu');
    expect(find.text("J'ai lu ce chapitre"), findsOneWidget);
  });

  testWidgets('without network: the chapters read before, and only them', (
    tester,
  ) async {
    final app = await openBible(tester);
    // John 1 is read once, with network
    expect(verse('Texte de Jean 1:1.'), findsOneWidget);
    app.bibleApi.offline = true;

    await tester.fling(find.byType(PageView), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.textContaining("n'est pas encore sur ton téléphone"), findsOne);

    await tester.fling(find.byType(PageView), const Offset(300, 0), 1000);
    await tester.pumpAndSettle();
    expect(verse('Texte de Jean 1:1.'), findsOneWidget);
  });

  testWidgets('downloaded: read and searched without network', (tester) async {
    final app = await openBible(tester);

    await tester.tap(find.byTooltip("Plus d'options"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Télécharger cette Bible'));
    await tester.pumpAndSettle();

    expect(app.bibleApi.downloads, ['fra_lsg']);
    expect(app.bibleStorage.files.keys, contains('fra_lsg/complete.json'));
    expect(
      app.toasts.messages,
      contains('Louis Segond 1910 est sur ton téléphone'),
    );

    app.bibleApi.offline = true;
    await tester.tap(find.byTooltip('Rechercher dans la Bible'));
    await tester.pumpAndSettle();
    await search(tester, 'monde éternelle');

    expect(find.text('1 verset'), findsOneWidget);
    await tester.tap(find.text('Jean 3:16'));
    await tester.pumpAndSettle();

    // back in the Bible, on the verse
    expect(find.byType(BibleScreen), findsOneWidget);
    expect(find.text('Jean 3'), findsOneWidget);
    expect(verse('Car Dieu a tant aimé'), findsOneWidget);
    expect(app.container.read(bibleFocusProvider), isNull);
  });

  testWidgets('a passage opens without downloading; words need the download', (
    tester,
  ) async {
    final app = await openBible(tester);

    await tester.tap(find.byTooltip('Rechercher dans la Bible'));
    await tester.pumpAndSettle();
    await search(tester, 'amour');
    expect(find.textContaining('télécharge-la'), findsOneWidget);

    await search(tester, 'jean 3:16');
    await tester.tap(find.text('Ouvrir Jean 3:16'));
    await tester.pumpAndSettle();

    expect(app.container.read(biblePositionProvider), const BibleRef('JHN', 3));
    expect(verse('Car Dieu a tant aimé'), findsOneWidget);
  });

  testWidgets('another version, from the list of versions', (tester) async {
    final app = await openBible(tester);

    await tester.tap(find.text('LSG'));
    await tester.pumpAndSettle();
    // the French ones first, then the other languages
    expect(find.text('FRANÇAIS'), findsOneWidget);
    await tester.tap(find.text('Darby'));
    await tester.pumpAndSettle();

    expect(find.text('JND'), findsOneWidget);
    expect(app.bibleApi.chaptersAsked, contains('fra_jnd/JHN.1'));
    expect(
      app.container.read(bibleSettingsControllerProvider).version,
      'fra_jnd',
    );
  });

  testWidgets('Mes versets: the verses kept, one opens, one goes', (
    tester,
  ) async {
    final app = await openBible(
      tester,
      preferences: {
        'bible_marks': jsonEncode([
          {
            'key': 'JHN.3.16',
            'text': 'Car Dieu a tant aimé le monde…',
            'version': 'LSG',
            'at': '2026-10-01T08:00:00.000',
            'bookmarked': true,
          },
          {
            'key': 'PSA.23.1',
            'text': 'L’Éternel est mon berger…',
            'version': 'LSG',
            'at': '2026-10-02T08:00:00.000',
            'color': 1,
          },
        ]),
      },
    );

    await tester.tap(find.byTooltip("Plus d'options"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mes versets'));
    await tester.pumpAndSettle();

    expect(find.text('Jean 3:16 · LSG'), findsOneWidget);
    // the highlighted one is on the other tab
    expect(find.text('Psaumes 23:1 · LSG'), findsNothing);
    await tester.tap(find.text('Surlignés'));
    await tester.pumpAndSettle();
    expect(find.text('Psaumes 23:1 · LSG'), findsOneWidget);

    await tester.tap(find.byTooltip('Retirer'));
    await tester.pumpAndSettle();
    expect(find.textContaining('puis une couleur'), findsOneWidget);
    expect(app.container.read(bibleMarksProvider).keys, ['JHN.3.16']);

    await tester.tap(find.text('Favoris'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Jean 3:16 · LSG'));
    await tester.pumpAndSettle();
    expect(find.text('Jean 3'), findsOneWidget);
  });

  testWidgets('the verse of the day opens in its chapter', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'bible_tap_hint_seen': true},
    );
    final days =
        (jsonDecode(File('assets/verses/verses_fr.json').readAsStringSync())
                as Map<String, dynamic>)['days']
            as Map<String, dynamic>;
    final key =
        '${today().month.toString().padLeft(2, '0')}-'
        '${today().day.toString().padLeft(2, '0')}';
    final osis = (days[key] as Map<String, dynamic>)['osis'] as String;

    await tester.scrollUntilVisible(find.byTooltip('Lire dans la Bible'), 200);
    await tester.tap(find.byTooltip('Lire dans la Bible'));
    await tester.pumpAndSettle();

    expect(find.byType(BibleScreen), findsOneWidget);
    expect(
      app.container.read(biblePositionProvider),
      BibleRef.parse(osis)!.chapterRef,
    );
  });

  testWidgets('a shared verse opens the Bible on it', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'bible_tap_hint_seen': true},
    );

    app.incomingLinks.add('https://cmfi-connect.com/open?to=bible/PSA.23.1');
    await tester.pumpAndSettle();

    expect(find.byType(BibleScreen), findsOneWidget);
    expect(find.text('Psaumes 23'), findsOneWidget);
  });
}
