import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/hymns/application/hymn_reader_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  // the one-time "pinch to zoom" tip is tested on its own
  const tipSeen = {'hymn_pinch_hint_seen': true};

  Future<TestApp> openHymns(WidgetTester tester, {FakeHymnsApi? api}) async {
    final app = await pumpApp(
      tester,
      token: 't',
      hymnsApi: api,
      initialPreferences: tipSeen,
    );
    await tester.tap(find.text('Cantiques').last);
    await tester.pumpAndSettle();
    return app;
  }

  testWidgets('the tab lists the hymns of the book in the app language', (
    tester,
  ) async {
    await openHymns(tester);

    expect(
      find.text('Rendons ministère au Seigneur, volume\u00A01'),
      findsOneWidget,
    );
    expect(find.text('A Toi la gloire'), findsOneWidget);
    expect(find.text('Saint, Saint, Saint'), findsOneWidget);
  });

  testWidgets('search ignores accents and also looks in the other books', (
    tester,
  ) async {
    await openHymns(tester);

    // the search opens in place of the title
    await tester.tap(find.byTooltip('Rechercher'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'eternel');
    await tester.pumpAndSettle();
    expect(find.text('Saint, Saint, Saint'), findsOneWidget);
    expect(find.text('A Toi la gloire'), findsNothing);

    await tester.enterText(find.byType(TextField), 'throne');
    await tester.pumpAndSettle();
    expect(find.text('DANS LES AUTRES RECUEILS'), findsOneWidget);
    expect(find.text("There's a Man on the Throne of God"), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'introuvable');
    await tester.pumpAndSettle();
    expect(find.textContaining('Aucun cantique ne correspond'), findsOneWidget);

    // back: the book again, the search emptied
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNothing);
    expect(find.text('A Toi la gloire'), findsOneWidget);
  });

  testWidgets('swiping the covers changes the book', (tester) async {
    final app = await openHymns(tester);

    await tester.fling(
      find.text('Rendons ministère au Seigneur').first,
      const Offset(-300, 0),
      1000,
    );
    await tester.pumpAndSettle();

    expect(find.text('Christ the Victor'), findsWidgets);
    expect(find.text("There's a Man on the Throne of God"), findsOneWidget);
    expect(app.preferences.getString('hymn_book'), 'christ-the-victor');
  });

  testWidgets('the star of a hymn of the list adds it to the favorites', (
    tester,
  ) async {
    final app = await openHymns(tester);

    await tester.tap(find.byTooltip('Ajouter aux favoris').at(1));
    await tester.pumpAndSettle();
    expect(app.toasts.messages, ['Ajouté aux favoris']);

    await tester.tap(find.text('Favoris'));
    await tester.pumpAndSettle();
    expect(find.text('Saint, Saint, Saint'), findsOneWidget);
    expect(find.text('A Toi la gloire'), findsNothing);
  });

  testWidgets('the menu of a hymn copies its words without opening it', (
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
    final app = await openHymns(tester);

    await tester.tap(find.byTooltip("Plus d'options").first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copier les paroles'));
    await tester.pumpAndSettle();

    expect(copied, startsWith('1. A Toi la gloire\n\n1. À toi la gloire'));
    expect(app.toasts.messages, ['Paroles copiées']);
    expect(find.text('N° 1'), findsNothing);
  });

  testWidgets('read a hymn: verses, chorus, bigger text, screen kept on', (
    tester,
  ) async {
    final app = await openHymns(tester);

    await tester.tap(find.text('A Toi la gloire'));
    await tester.pumpAndSettle();

    expect(find.text('N° 1'), findsOneWidget);
    // one paragraph per line
    expect(find.text('À toi la gloire'), findsOneWidget);
    expect(find.text('Ô Ressuscité'), findsOneWidget);
    expect(find.text('REFRAIN ×2'), findsOneWidget);
    expect(app.screenAwake.on, isTrue);

    await tester.tap(find.byTooltip('Agrandir le texte'));
    await tester.pumpAndSettle();
    expect(
      app.container.read(hymnReaderSettingsControllerProvider).textScale,
      1.15,
    );
    expect(app.preferences.getString('hymn_reader'), contains('1.15'));

    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    expect(app.screenAwake.on, isFalse);
  });

  // on Android, the text selection would otherwise take the drag
  testWidgets(
    'swipe to the next hymn, even starting on the words',
    (tester) async {
      await openHymns(tester);
      await tester.tap(find.text('A Toi la gloire'));
      await tester.pumpAndSettle();

      await tester.fling(
        find.text('Ô Ressuscité'),
        const Offset(-300, 0),
        1000,
      );
      await tester.pumpAndSettle();

      expect(find.text('N° 2'), findsOneWidget);
      expect(find.text('EMPEYTAZ.'), findsOneWidget);
    },
    variant: TargetPlatformVariant.mobile(),
  );

  testWidgets('a long press selects the words, copied line by line', (
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
    await openHymns(tester);
    await tester.tap(find.text('A Toi la gloire'));
    await tester.pumpAndSettle();

    await tester.longPress(find.text('Ô Ressuscité'));
    await tester.pumpAndSettle();
    expect(find.text('Partager'), findsOneWidget);
    // as if the handles were dragged over the whole hymn
    tester
        .state<SelectableRegionState>(
          find.ancestor(
            of: find.text('Ô Ressuscité'),
            matching: find.byType(SelectableRegion),
          ),
        )
        .selectAll(SelectionChangedCause.toolbar);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copier'));
    await tester.pumpAndSettle();

    // without the book, the verse numbers and "Refrain"
    expect(
      copied,
      'A Toi la gloire\n\n'
      'À toi la gloire\nÔ Ressuscité\n\n'
      "À toi la victoire\nPour l'éternité\n\n"
      "Vois-le paraître\nC'est lui, c'est Jésus",
    );
  });

  testWidgets('the chorus can come back after each verse', (tester) async {
    final app = await openHymns(tester);
    await app.container
        .read(hymnReaderSettingsControllerProvider.notifier)
        .update((s) => s.copyWith(repeatChorus: true));
    await tester.tap(find.text('A Toi la gloire'));
    await tester.pumpAndSettle();

    expect(find.text('À toi la victoire'), findsNWidgets(2));
  });

  testWidgets('a starred hymn shows in Favoris, an opened one in Récents', (
    tester,
  ) async {
    final app = await openHymns(tester);
    await tester.tap(find.text('Saint, Saint, Saint'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Ajouter aux favoris'));
    await tester.pumpAndSettle();
    expect(app.toasts.messages, ['Ajouté aux favoris']);

    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Favoris'));
    await tester.pumpAndSettle();
    expect(find.text('Saint, Saint, Saint'), findsOneWidget);
    expect(find.text('A Toi la gloire'), findsNothing);

    await tester.tap(find.text('Récents'));
    await tester.pumpAndSettle();
    expect(find.text('Saint, Saint, Saint'), findsOneWidget);
  });

  testWidgets('the keypad opens a hymn by its number', (tester) async {
    await openHymns(tester);

    await tester.tap(find.byTooltip('Aller à un numéro'));
    await tester.pumpAndSettle();
    // the keys are above the list, which has numbers too
    await tester.tap(find.text('9').last);
    await tester.pump();
    expect(find.text('Pas de cantique n° 9 dans ce recueil'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Effacer'));
    await tester.tap(find.text('3').last);
    await tester.pump();
    // the keypad names the hymn (the list behind it too)
    expect(find.text('Ils ont mis le maître sur la croix'), findsNWidgets(2));

    await tester.tap(find.text('Ouvrir'));
    await tester.pumpAndSettle();
    expect(find.text('N° 3'), findsOneWidget);
  });

  testWidgets('another book can be chosen, and is remembered', (tester) async {
    final app = await openHymns(tester);

    await tester.tap(find.text('Rendons ministère au Seigneur, volume\u00A01'));
    await tester.pumpAndSettle();
    // the cover of the book is behind the list
    await tester.tap(find.text('Christ the Victor').last);
    await tester.pumpAndSettle();

    expect(find.text("There's a Man on the Throne of God"), findsOneWidget);
    expect(app.preferences.getString('hymn_book'), 'christ-the-victor');
  });

  testWidgets('projection mode shows one stanza at a time', (tester) async {
    final app = await openHymns(tester);
    await tester.tap(find.text('A Toi la gloire'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip("Plus d'options"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mode projection'));
    await tester.pumpAndSettle();

    expect(find.text('COUPLET 1'), findsOneWidget);
    // verse, chorus, verse, chorus again: 4 stanzas
    expect(find.text('1 / 4'), findsOneWidget);
    expect(app.screenAwake.on, isTrue);

    await tester.tap(find.bySemanticsLabel('Strophe suivante'));
    await tester.pumpAndSettle();
    expect(find.text('REFRAIN'), findsOneWidget);
    expect(find.text('2 / 4'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Strophe précédente'));
    await tester.pumpAndSettle();
    expect(find.text('1 / 4'), findsOneWidget);

    await tester.tap(find.byTooltip('Quitter le mode projection'));
    await tester.pumpAndSettle();
    expect(find.text('N° 1'), findsOneWidget);
  });

  testWidgets('a newer book on the server replaces the copy on the phone', (
    tester,
  ) async {
    final newer = sampleHymnBook.copyWith(
      version: '20261101T000000.000000Z',
      hymns: [...sampleHymnBook.hymns.take(1)],
    );
    final app = await openHymns(
      tester,
      api: FakeHymnsApi(books: [newer, sampleEnglishBook]),
    );

    expect(app.hymnsApi.downloads, ['rendons-ministere-1']);
    expect(
      app.hymnStorage.saved['rendons-ministere-1']?.version,
      '20261101T000000.000000Z',
    );
    expect(find.text('Saint, Saint, Saint'), findsNothing);
  });

  testWidgets('the first time, a tip says the text can be pinched', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await tester.tap(find.text('Cantiques').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('A Toi la gloire'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    expect(app.toasts.messages.single, contains("Pince l'écran"));
  });

  testWidgets('home offers to go back to the last hymn', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      initialPreferences: {
        ...tipSeen,
        'hymn_recents': ['rendons-ministere-1:2'],
      },
    );

    // under the verse of the day
    await scrollTo(tester, find.textContaining('Reprendre le n° 2'));
    expect(find.textContaining('Reprendre le n° 2'), findsOneWidget);
    await tester.tap(find.textContaining('Reprendre le n° 2'));
    await tester.pumpAndSettle();
    expect(find.text('N° 2'), findsOneWidget);
  });
}
