import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/theme/app_tones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Brightness brightness(WidgetTester tester) =>
      Theme.of(tester.element(find.text('Plus').last)).brightness;

  testWidgets('the app follows the phone until a mode is chosen', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    final app = await pumpApp(tester, token: 't');

    expect(brightness(tester), Brightness.dark);

    await tester.tap(find.text('Plus'));
    await tester.pumpAndSettle();
    // the last row: the settings above it are then fully in view
    await scrollToEnd(tester);
    expect(find.text('Automatique'), findsOneWidget);

    await tester.tap(find.text('Apparence'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Clair'));
    await tester.pumpAndSettle();

    expect(brightness(tester), Brightness.light);
    expect(app.preferences.getString('theme_mode'), 'light');
    // the brand colors switch with the theme
    final context = tester.element(find.text('Plus').last);
    expect(AppTones.of(context), AppTones.light);
  });

  testWidgets('the chosen mode is kept from one launch to the next', (
    tester,
  ) async {
    await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'theme_mode': 'dark'},
    );
    expect(brightness(tester), Brightness.dark);

    await tester.tap(find.text('Plus'));
    await tester.pumpAndSettle();
    await scrollToEnd(tester);
    expect(find.text('Sombre'), findsOneWidget);

    await tester.tap(find.text('Apparence'));
    await tester.pumpAndSettle();
    expect(
      tester.getSemantics(find.bySemanticsLabel('Sombre')),
      matchesSemantics(
        label: 'Sombre',
        isButton: true,
        isSelected: true,
        hasSelectedState: true,
        hasTapAction: true,
      ),
    );
  });
}
