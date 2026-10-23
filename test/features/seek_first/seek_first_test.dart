import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/app_shield.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/entry_sheet.dart';
import 'package:cmfi_connect/src/features/seek_first/presentation/seek_first_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<void> openSeekFirst(WidgetTester tester) async {
    await openSettings(tester);
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text("Cherche d'abord Dieu"));
    await tester.tap(find.text("Cherche d'abord Dieu"));
    await tester.pumpAndSettle();
  }

  testWidgets('turned on: Screen Time, the apps, closed from 5 h', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await openSeekFirst(tester);

    expect(find.byType(SeekFirstScreen), findsOneWidget);
    expect(find.text('Matthieu 6:33'), findsOneWidget);
    expect(find.text('Aucune app choisie'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // access asked, then the system's list
    expect(app.appShield.allowed, isTrue);
    expect(find.text('3 apps · 1 catégorie'), findsOneWidget);
    expect(find.text('05:00'), findsOneWidget);
    final configured = app.appShield.configured!;
    expect(configured['enabled'], isTrue);
    expect(configured['startMinutes'], 5 * 60);
    expect(configured['pausesPerDay'], 3);
    final texts = configured['texts']! as Map<String, String>;
    expect(texts['title'], "Cherche d'abord Dieu");
    expect(
      texts['subtitle'],
      "{app} reste fermée jusqu'à ton compte rendu d'aujourd'hui.",
    );
    expect(texts['pause'], 'Pause de 5 min ({n}/3)');
    expect(find.text('Encore 3 pauses aujourd\'hui'), findsOneWidget);
  });

  testWidgets(
    'without the access (Screen Time, or the permissions of Android), nothing closes',
    (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        appShield: FakeAppShield(granted: false),
      );
      await openSeekFirst(tester);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      // the tests run as an Android phone: its two permissions
      expect(
        app.toasts.messages.single,
        startsWith('Sans ces deux autorisations'),
      );
      expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
      expect(app.appShield.configured?['enabled'], isFalse);
    },
  );

  testWidgets('no app chosen: it stays off', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      appShield: FakeAppShield(chosen: null),
    );
    await openSeekFirst(tester);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(app.toasts.messages, ['Choisis au moins une app à garder fermée.']);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
  });

  testWidgets('the day saved opens the apps', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'seek_first_enabled': true},
    );
    expect(app.appShield.unlocked, isEmpty);

    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lecture biblique'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byType(EntrySheet),
        matching: find.byType(TextField),
      ),
      '2',
    );
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enregistrer la journée'));
    await tester.pumpAndSettle();

    expect(app.appShield.unlocked, [today()]);
  });

  testWidgets('signing out opens every app and forgets the settings', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'seek_first_enabled': true, 'seek_first_start': 360},
    );
    app.appShield.current = const ShieldSelection(apps: 2);
    await openSettings(tester);
    await tester.pumpAndSettle();
    await scrollToEnd(tester);
    await tester.tap(find.text('Se déconnecter'));
    await tester.pumpAndSettle();

    expect(app.appShield.configured?['enabled'], isFalse);
    expect(app.preferences.getBool('seek_first_enabled'), isNull);
    expect(app.preferences.getInt('seek_first_start'), isNull);
  });

  testWidgets('a phone that can\'t: no row in Plus', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      appShield: FakeAppShield(supported: false),
    );
    await openSettings(tester);
    await tester.pumpAndSettle();
    await scrollToEnd(tester);

    expect(find.text("Cherche d'abord Dieu"), findsNothing);
  });
}
