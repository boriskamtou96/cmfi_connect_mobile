import 'dart:convert';
import 'dart:io';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/current_day.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:cmfi_connect/src/features/home/presentation/home_screen.dart';
import 'package:cmfi_connect/src/features/verses/application/verse_of_the_day.dart';
import 'package:cmfi_connect/src/features/verses/application/verse_share_background.dart';
import 'package:cmfi_connect/src/features/verses/domain/verse.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

/// A 1 × 1 PNG, as a photo of the member.
final _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  test('every language has a verse for every day, 29 February included', () {
    for (final language in ['fr', 'en', 'es', 'de', 'zh', 'ar', 'hi']) {
      final calendar = VerseCalendar.fromJson(
        File('assets/verses/verses_$language.json').readAsStringSync(),
      );
      expect(calendar.days, hasLength(366), reason: language);
      expect(calendar.source, isNotEmpty);
      for (
        var day = DateTime(2024);
        day.year == 2024;
        day = day.add(const Duration(days: 1))
      ) {
        expect(calendar.of(day)?.text, isNotEmpty, reason: '$language $day');
      }
    }
    // the same verse for everyone on Christmas, numbered in each Bible
    final fr = VerseCalendar.fromJson(
      File('assets/verses/verses_fr.json').readAsStringSync(),
    );
    final en = VerseCalendar.fromJson(
      File('assets/verses/verses_en.json').readAsStringSync(),
    );
    expect(fr.of(DateTime(2026, 12, 25))?.reference, 'Luc 2.11');
    expect(en.of(DateTime(2026, 12, 25))?.reference, 'Luke 2:11');
  });

  testWidgets("today's verse on the home screen, shared as text", (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    final now = DateTime.now();
    final key =
        '${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final today =
        (jsonDecode(File('assets/verses/verses_fr.json').readAsStringSync())
                as Map<String, dynamic>)['days'][key]
            as Map<String, dynamic>;

    await scrollTo(tester, find.byTooltip('Partager le verset'));
    expect(find.text(today['text'] as String), findsOneWidget);
    expect(find.text(today['ref'] as String), findsOneWidget);

    await tester.tap(find.byTooltip('Partager le verset'));
    await tester.pumpAndSettle();
    // the card to share: its name, the verse, where it comes from, the app
    expect(find.text('VERSET DU JOUR'), findsOneWidget);
    expect(find.text(today['text'] as String), findsNWidgets(2));
    expect(find.text(today['ref'] as String), findsNWidgets(2));
    expect(find.text('CMFI Connect'), findsOneWidget);
    // the link goes with the image, never on it
    expect(find.text('cmfi-connect.com'), findsNothing);

    // a photo by default; a color chosen is kept for the next time
    expect(app.container.read(verseShareBackgroundProvider), isNull);
    await tester.tap(find.bySemanticsLabel('Couleur 2'));
    await tester.pumpAndSettle();
    expect(app.container.read(verseShareBackgroundProvider), 'wine');
    await tester.tap(find.bySemanticsLabel('Image 3'));
    await tester.pumpAndSettle();
    expect(app.container.read(verseShareBackgroundProvider), 'valley');

    // « Ta photo », at the end of the photos: from the gallery, for this
    // share only
    app.picker.next.add((bytes: _png, name: 'moi.png'));
    // the row of the photos, to its end
    final row = tester.state<ScrollableState>(
      find
          .ancestor(
            of: find.byWidgetPredicate(
              (widget) =>
                  widget is Semantics && widget.properties.label == 'Image 1',
            ),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    row.position.jumpTo(row.position.maxScrollExtent);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(AppIcons.addImage));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Choisir dans la galerie'));
    await tester.pumpAndSettle();
    expect(app.picker.cameraCalls, [false]);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Ta photo')),
      matchesSemantics(
        label: 'Ta photo',
        isButton: true,
        hasSelectedState: true,
        isSelected: true,
      ),
    );
    expect(app.container.read(verseShareBackgroundProvider), 'valley');

    await tester.tap(find.text('Partager le texte'));
    await tester.pumpAndSettle();
    expect(app.share.texts.single, contains(today['text'] as String));
    expect(app.share.texts.single, contains(today['ref'] as String));
    // the last line invites to get the app
    expect(
      app.share.texts.single,
      endsWith("Télécharge l'app CMFI Connect : https://cmfi-connect.com"),
    );
  });

  testWidgets('the image goes with its link, as a caption', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await scrollTo(tester, find.byTooltip('Partager le verset'));
    await tester.tap(find.byTooltip('Partager le verset'));
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      await tester.tap(find.text("Partager l'image"));
      await Future<void>.delayed(const Duration(seconds: 1));
    });
    await tester.pumpAndSettle();

    final caption = app.share.captions.single!;
    // the verse opens in the Bible of the app (or the site offers the stores)
    expect(caption, contains('https://cmfi-connect.com/open?to=bible/'));
    expect(caption, endsWith('https://cmfi-connect.com'));
  });

  testWidgets('the next day, the verse changes without restarting the app', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    final notifier = app.container.read(currentDayProvider.notifier);

    notifier.state = DateTime(2026, 12, 24);
    await tester.pumpAndSettle();
    final christmasEve = await app.container.read(verseOfTheDayProvider.future);

    notifier.state = DateTime(2026, 12, 25);
    await tester.pumpAndSettle();
    final christmas = await app.container.read(verseOfTheDayProvider.future);
    expect(christmas?.reference, 'Luc 2.11');
    expect(christmas?.reference, isNot(christmasEve?.reference));
  });

  test('the greeting takes the first given name only', () {
    expect(givenName('Jean Paul'), 'Jean');
    expect(givenName('  Grâce '), 'Grâce');
    expect(givenName(''), isNull);
    expect(givenName(null), isNull);
  });
}
