import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/onboarding/presentation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

/// The first colour of the screen's background, under the pages.
Color backgroundTop(WidgetTester tester) {
  final box = tester.widget<DecoratedBox>(
    find.byKey(const ValueKey('welcome-background')),
  );
  final gradient =
      (box.decoration as BoxDecoration).gradient! as LinearGradient;
  return gradient.colors.first;
}

Future<void> swipe(WidgetTester tester) async {
  await tester.fling(find.byType(PageView), const Offset(-300, 0), 1000);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('each page shows a piece of the app, on the colour of its '
      'space', (tester) async {
    await pumpApp(tester, onboardingSeen: false);

    // the home: the day's ring and the streak
    expect(find.text('Bonjour Grâce'), findsOneWidget);
    expect(find.text('4/5'), findsOneWidget);
    expect(backgroundTop(tester), WelcomeScreen.colors[0].top);

    // the hymns
    await swipe(tester);
    expect(find.text('Donnons-Lui la gloire'), findsOneWidget);
    expect(find.text('12 personnes prient'), findsOneWidget);
    expect(backgroundTop(tester), WelcomeScreen.colors[1].top);

    // the events and the announcements
    await swipe(tester);
    expect(find.text("S'inscrire"), findsOneWidget);
    expect(find.text('Le culte de dimanche commence à 9 h.'), findsOneWidget);
    expect(backgroundTop(tester), WelcomeScreen.colors[2].top);
  });

  testWidgets('the word of the title is in gold italics', (tester) async {
    await pumpApp(tester, onboardingSeen: false);

    final title = tester.widget<RichText>(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText() == "Cherche d'abord Dieu, chaque jour",
      ),
    );
    TextSpan? marked;
    title.text.visitChildren((span) {
      if (span is TextSpan && span.text == 'Dieu') {
        marked = span;
      }
      return marked == null;
    });
    expect(marked!.style!.fontFamily, 'Lora');
    expect(marked!.style!.fontStyle, FontStyle.italic);
    expect(marked!.style!.color, WelcomeScreen.accent);
  });

  for (final locale in [AppLocale.fr, AppLocale.de, AppLocale.ar]) {
    testWidgets('a small phone (iPhone SE), ${locale.languageCode}: the '
        'three pages hold', (tester) async {
      LocaleSettings.setLocale(locale);
      await pumpApp(tester, onboardingSeen: false);
      // after pumpApp, which sets an iPhone of 390 × 844
      tester.view.physicalSize = const Size(375 * 3, 667 * 3);
      await tester.pumpAndSettle();
      await swipe(tester);
      await swipe(tester);
      // the last page, with the Google and Apple buttons: no overflow
      expect(tester.takeException(), isNull);
      expect(find.byType(WelcomeScreen), findsOneWidget);
    });
  }
}
