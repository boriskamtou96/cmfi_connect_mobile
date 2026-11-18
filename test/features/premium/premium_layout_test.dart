import 'dart:io';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/premium/presentation/premium_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

/// The fonts of the app, so the text is as tall as on a phone (the font of
/// the tests draws every letter as a square, wider than Onest).
Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(file).readAsBytesSync())),
    );
  }
  await loader.load();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
    await _loadFont('Onest', [
      for (final weight in [
        'Regular',
        'Medium',
        'SemiBold',
        'Bold',
        'ExtraBold',
      ])
        'assets/fonts/Onest-$weight.ttf',
    ]);
    await _loadFont('Lora', [
      'assets/fonts/Lora-Regular.ttf',
      'assets/fonts/Lora-SemiBold.ttf',
    ]);
  });
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  /// How far the Premium page scrolls on an iPhone of 390 × 844 points,
  /// under the status bar and above the home indicator.
  Future<double> scrollOf(WidgetTester tester, FakePremiumStore store) async {
    tester.view.padding = const FakeViewPadding(top: 47 * 3, bottom: 34 * 3);
    tester.view.viewPadding = const FakeViewPadding(
      top: 47 * 3,
      bottom: 34 * 3,
    );
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetViewPadding);
    await pumpApp(tester, token: 't', premium: store);
    await openMenu(tester);
    await tester.tap(
      find.text(store.active ? 'CMFI Connect Premium' : 'Devenir Premium'),
    );
    await tester.pumpAndSettle();
    final scrollable = find.descendant(
      of: find.byType(PremiumScreen),
      matching: find.byType(Scrollable),
    );
    return tester
        .state<ScrollableState>(scrollable.first)
        .position
        .maxScrollExtent;
  }

  testWidgets('the paywall holds on one screen, without scrolling', (
    tester,
  ) async {
    expect(await scrollOf(tester, FakePremiumStore()), 0);
    expect(find.text('Commencer l\'essai gratuit'), findsOneWidget);
  });

  testWidgets('Premium on: one screen, and no « Fermer » button', (
    tester,
  ) async {
    expect(await scrollOf(tester, FakePremiumStore(active: true)), 0);
    expect(find.text('Tu as Premium'), findsOneWidget);
    // the cross at the top closes it
    expect(find.text('Fermer'), findsNothing);
    expect(find.byTooltip('Fermer'), findsOneWidget);
  });
}
