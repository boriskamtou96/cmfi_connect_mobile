import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/widgets/app_back_button.dart';
import 'package:cmfi_connect/src/features/ministry/domain/globe_math.dart';
import 'package:cmfi_connect/src/features/ministry/presentation/ministry_screen.dart';
import 'package:cmfi_connect/src/features/ministry/presentation/nations_screen.dart';
import 'package:cmfi_connect/src/features/ministry/presentation/purpose_screen.dart';
import 'package:cmfi_connect/src/features/ministry/presentation/widgets/nation_globe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('globe', () {
    test('the point looked at comes to the middle of the disc', () {
      final yaounde = spherePoint(3.87, 11.52);
      final p = turned(yaounde, (latitude: 3.87, longitude: 11.52));
      expect(p.x, closeTo(0, 1e-9));
      expect(p.y, closeTo(0, 1e-9));
      expect(p.z, closeTo(1, 1e-9));
      // the other side of the earth is hidden
      expect(
        turned(spherePoint(-3.87, -168.48), (
          latitude: 3.87,
          longitude: 11.52,
        )).z,
        lessThan(0),
      );
    });

    test('an arc leaves from one nation and lands on the other', () {
      final a = spherePoint(4.59, 12.47);
      final b = spherePoint(56.82, -4.18);
      final start = arcPoint(a, b, 0, 0.35);
      final end = arcPoint(a, b, 1, 0.35);
      expect(start.x, closeTo(a.x, 1e-9));
      expect(end.z, closeTo(b.z, 1e-9));
      // lifted in the middle
      final middle = arcPoint(a, b, 0.5, 0.35);
      final length =
          middle.x * middle.x + middle.y * middle.y + middle.z * middle.z;
      expect(length, greaterThan(1));
    });

    test('the globe turns the short way round', () {
      final target = shortestTarget(
        (latitude: 0, longitude: 350),
        (latitude: 10, longitude: 10),
      );
      expect(target.longitude, 370);
      expect(target.latitude, 10);
    });
  });

  Future<void> openMinistry(WidgetTester tester) async {
    await openMore(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Notre ministère'));
    await tester.pumpAndSettle();
  }

  Future<void> openNations(WidgetTester tester) async {
    await openMinistry(tester);
    await tester.ensureVisible(find.text('Les nations'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Les nations'));
    await tester.pumpAndSettle();
  }

  testWidgets('our ministry: a page of sub-menus, two of them to come', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await openMinistry(tester);

    expect(find.byType(MinistryScreen), findsOneWidget);
    expect(find.text('3 nations'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Globe : 3 nations')), findsOneWidget);
    expect(find.text('Nos missionnaires'), findsOneWidget);
    expect(find.text('Nos héros'), findsOneWidget);
    expect(find.text('Bientôt'), findsNWidgets(2));

    // to come: nothing opens
    await tester.ensureVisible(find.text('Nos héros'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nos héros'));
    await tester.pumpAndSettle();
    expect(find.byType(MinistryScreen), findsOneWidget);

    await tester.ensureVisible(find.text('Notre but'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Notre but'));
    await tester.pumpAndSettle();
    expect(find.byType(PurposeScreen), findsOneWidget);
    // the three goals, one screen each
    expect(find.text('NOTRE BUT · 1/3'), findsOneWidget);
    expect(find.text('La toute-créature gospel crusade'), findsOneWidget);
    await tester.ensureVisible(find.text('Radio').last);
    await tester.tap(find.text('Radio').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('But suivant'));
    await tester.pumpAndSettle();
    expect(find.text('NOTRE BUT · 2/3'), findsOneWidget);
    expect(find.text('La formation des disciples'), findsOneWidget);
    expect(find.text('25 millions'), findsOneWidget);
    await tester.tap(find.byTooltip('But suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Précipiter le réveil global'), findsOneWidget);
    expect(find.text('Prier maintenant'), findsOneWidget);

    await tester.tap(find.byType(AppBackButton));
    await tester.pumpAndSettle();
    // the small globe opens the nations
    await tester.ensureVisible(find.byType(NationGlobe));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(NationGlobe));
    await tester.pumpAndSettle();
    expect(find.byType(NationsScreen), findsOneWidget);
  });

  testWidgets('the nations of the server on the globe and in the list', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await openNations(tester);

    expect(find.byType(NationsScreen), findsOneWidget);
    expect(find.text('3 nations'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Globe : 3 nations')), findsOneWidget);

    // the list, a country translated, a region as written
    await tester.scrollUntilVisible(
      find.text('Bénin'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Cameroun'), findsOneWidget);
    expect(find.text('L’Écosse'), findsOneWidget);
    expect(find.text('Depuis 1975'), findsOneWidget);

    // a nation of the list shows on the globe, with its card
    await tester.tap(find.text('Bénin'));
    await tester.pumpAndSettle();
    expect(find.text('Nation n° 2'), findsOneWidget);

    await tester.tap(find.text('Prier'));
    await tester.pumpAndSettle();
    expect(find.text('Prier pour Bénin'), findsOneWidget);
    expect(
      find.text('Rends grâce pour l\'œuvre de Dieu en Bénin.'),
      findsOneWidget,
    );
  });

  testWidgets('the journey goes from nation to nation, until paused', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await openNations(tester);

    await tester.tap(find.text('Voyage'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Nation n° 1 · Depuis 1975'), findsOneWidget);
    await tester.pump(journeyStep);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Nation n° 2'), findsOneWidget);

    await tester.tap(find.text('Pause'));
    // the frame first: the time of the journey stops with it
    await tester.pump();
    await tester.pump(journeyStep * 2);
    await tester.pumpAndSettle();
    expect(find.text('Nation n° 2'), findsOneWidget);

    await tester.tap(find.byTooltip('Nation suivante'));
    await tester.pumpAndSettle();
    expect(find.text('Nation n° 3'), findsOneWidget);
  });

  testWidgets('without network, the list shipped with the app (154 nations)', (
    tester,
  ) async {
    await pumpApp(
      tester,
      token: 't',
      ministryApi: FakeMinistryApi(offline: true),
    );
    await openMinistry(tester);

    expect(find.text('154 nations'), findsOneWidget);
  });
}
