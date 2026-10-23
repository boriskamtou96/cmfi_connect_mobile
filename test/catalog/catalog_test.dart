import 'package:cmfi_connect/catalog/catalog_app.dart';
import 'package:cmfi_connect/catalog/stories.dart';
import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/widgets/dove_mascot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
    // a never-ending animation never settles (as in the app's tests)
    DoveMascot.lively = false;
  });

  // every story opens without an error (an overflow, a missing text…), in
  // each language, light and dark, with the text large
  for (final locale in AppLocale.values) {
    for (final mode in [ThemeMode.light, ThemeMode.dark]) {
      testWidgets('every story, ${locale.languageCode}, ${mode.name}', (
        tester,
      ) async {
        // a phone held upright
        tester.view.physicalSize = const Size(1170, 2532);
        tester.view.devicePixelRatio = 3;
        addTearDown(tester.view.reset);
        await LocaleSettings.setLocale(locale);
        final settings = CatalogSettings()
          ..mode = mode
          ..locale = locale
          ..textScale = 1.3;
        await tester.pumpWidget(CatalogApp(settings: settings));
        await tester.pumpAndSettle();

        for (final story in stories) {
          await tester.scrollUntilVisible(
            find.text(story.name),
            120,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.tap(find.text(story.name));
          await tester.pumpAndSettle();
          expect(
            tester.takeException(),
            isNull,
            reason: '${story.group} › ${story.name}',
          );
          expect(find.byType(StoryPage), findsOneWidget);
          // back to the list (the app's theme draws its own back button)
          tester.state<NavigatorState>(find.byType(Navigator).first).pop();
          await tester.pumpAndSettle();
        }
      });
    }
  }

  testWidgets('a knob changes the story', (tester) async {
    await LocaleSettings.setLocale(AppLocale.fr);
    await tester.pumpWidget(CatalogApp(settings: CatalogSettings()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pastille'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), 'Nouvelle étape');
    await tester.pumpAndSettle();
    expect(find.text('Nouvelle étape'), findsWidgets);
  });
}
