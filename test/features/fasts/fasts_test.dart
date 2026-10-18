import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/features/fasts/domain/fast.dart';
import 'package:cmfi_connect/src/features/fasts/presentation/fasts_screen.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  const fastItems = [
    ...sampleActivities,
    ActivityType(
      id: 6,
      code: 'JC',
      label: 'Jeûne complet',
      tracksQuantity: true,
      quantityUnit: 'Nombre de fois',
      isStandard: true,
    ),
    ActivityType(
      id: 7,
      code: 'JP',
      label: 'Jeûne partiel',
      tracksQuantity: true,
      quantityUnit: 'Nombre de fois',
      isStandard: true,
    ),
  ];

  group('a fast, day by day', () {
    test('a full fast: 24 hours a day from its start', () {
      final fast = Fast(
        kind: FastKind.full,
        start: DateTime(2026, 10, 18, 8),
        days: 3,
      );
      expect(fast.endOfDay(0), DateTime(2026, 10, 19, 8));
      expect(fast.end, DateTime(2026, 10, 21, 8));
      final now = DateTime(2026, 10, 20, 9);
      expect(fast.keptAt(now), 2);
      expect(fast.dayAt(now), 2);
      expect(fast.toCountAt(now), [
        DateTime(2026, 10, 19, 8),
        DateTime(2026, 10, 20, 8),
      ]);
      expect(fast.isOverAt(now), isFalse);
      expect(fast.isOverAt(DateTime(2026, 10, 21, 8)), isTrue);
      // the days counted are not counted again
      expect(fast.copyWith(counted: {'2026-10-19'}).toCountAt(now), [
        DateTime(2026, 10, 20, 8),
      ]);
    });

    test('a partial fast: until the set hour, from tomorrow when it starts '
        'later', () {
      final morning = Fast(
        kind: FastKind.partial,
        start: DateTime(2026, 10, 18, 7),
        days: 2,
      );
      expect(morning.endOfDay(0), DateTime(2026, 10, 18, 18));
      expect(morning.end, DateTime(2026, 10, 19, 18));
      final evening = Fast(
        kind: FastKind.partial,
        start: DateTime(2026, 10, 18, 20),
        days: 1,
        endMinutes: 15 * 60,
      );
      expect(evening.end, DateTime(2026, 10, 19, 15));
    });

    test('broken: the day under way does not count', () {
      final fast = Fast(
        kind: FastKind.full,
        start: DateTime(2026, 10, 18, 8),
        days: 3,
        stoppedAt: DateTime(2026, 10, 19, 20),
      );
      expect(fast.keptAt(DateTime(2026, 10, 25)), 1);
      expect(fast.isOverAt(DateTime(2026, 10, 19, 21)), isTrue);
    });
  });

  Future<TestApp> openFasts(
    WidgetTester tester, {
    Map<String, Object> preferences = const {},
  }) async {
    final app = await pumpApp(
      tester,
      token: 't',
      activities: fastItems,
      initialPreferences: preferences,
    );
    await openMore(tester);
    await scrollTo(tester, find.text('Mes jeûnes'));
    await tester.tap(find.text('Mes jeûnes'));
    await tester.pumpAndSettle();
    return app;
  }

  testWidgets('started in a few taps, with what it is for', (tester) async {
    final app = await openFasts(tester);

    expect(find.byType(FastsScreen), findsOneWidget);
    await tester.tap(find.text('Jeûne partiel'));
    await tester.tap(find.text('3 jours'));
    await tester.pumpAndSettle();
    expect(find.text('Fin du jeûne chaque jour'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Le salut de ma famille');
    await tester.pump();
    await tester.tap(find.byTooltip('Ajouter le sujet'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Commencer le jeûne'));
    await tester.pumpAndSettle();

    expect(find.text('Jour 1 sur 3'), findsOneWidget);
    expect(find.text('Le salut de ma famille'), findsOneWidget);
    expect(
      find.text(
        'Chaque jour tenu ajoute 1 à « Jeûne partiel » dans ton compte rendu.',
      ),
      findsOneWidget,
    );
    final saved =
        jsonDecode(app.preferences.getString('fast_current')!)
            as Map<String, dynamic>;
    expect(saved['kind'], 'partial');
    expect(saved['topics'], ['Le salut de ma famille']);
    // the end of each day, and of the fast
    expect(app.notifications.groups[NotificationGroup.fasts], isNotEmpty);
  });

  testWidgets('the days kept go to the report of the day they end', (
    tester,
  ) async {
    final start = DateTime.now().subtract(const Duration(days: 2, hours: 1));
    final app = await openFasts(
      tester,
      preferences: {
        'fast_current': jsonEncode(
          Fast(kind: FastKind.full, start: start, days: 3).toJson(),
        ),
      },
    );

    // counted when the app opened (SignedInTasks), before the screen
    expect(find.text('Jour 3 sur 3'), findsOneWidget);
    for (final end in [
      start.add(const Duration(days: 1)),
      start.add(const Duration(days: 2)),
    ]) {
      final day = DateTime(end.year, end.month, end.day);
      final entry = app.reportsApi.days[day]!.entries.firstWhere(
        (entry) => entry.code == 'JC',
      );
      expect(entry.quantity, 1);
    }
  });

  testWidgets('broken: kept in the history', (tester) async {
    final start = DateTime.now().subtract(const Duration(days: 1, hours: 2));
    final app = await openFasts(
      tester,
      preferences: {
        'fast_current': jsonEncode(
          Fast(kind: FastKind.full, start: start, days: 3).toJson(),
        ),
      },
    );

    await tester.tap(find.byTooltip("Plus d'options"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rompre le jeûne'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rompre le jeûne').last);
    await tester.pumpAndSettle();

    expect(find.text('Commencer le jeûne'), findsOneWidget);
    expect(find.text('MES DERNIERS JEÛNES'), findsOneWidget);
    expect(find.text('1/3 jours'), findsOneWidget);
    expect(app.preferences.getString('fast_current'), isNull);
    expect(
      app.notifications.groups[NotificationGroup.fasts] ?? const [],
      isEmpty,
    );
  });

  testWidgets('a fast under way on the home screen', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      activities: fastItems,
      initialPreferences: {
        'fast_current': jsonEncode(
          Fast(
            kind: FastKind.full,
            start: DateTime.now().subtract(const Duration(hours: 3)),
            days: 3,
          ).toJson(),
        ),
      },
    );

    await scrollTo(tester, find.text('Jeûne · jour 1 sur 3'));
    expect(find.text('Jeûne · jour 1 sur 3'), findsOneWidget);
  });
}
