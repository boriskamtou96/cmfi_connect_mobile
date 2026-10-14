import 'dart:typed_data';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/store_review.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/reports/application/streak_milestones.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_streak.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/entry_sheet.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/streak_celebration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

/// The [count] days before today, all reported.
Map<DateTime, DailyReport> daysBefore(int count) {
  final now = today();
  return {
    for (var i = 1; i <= count; i++)
      DateTime(now.year, now.month, now.day - i): DailyReport(
        date: DateTime(now.year, now.month, now.day - i),
        submitted: true,
      ),
  };
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('the milestones of a streak', () {
    test('a save that reaches 7, 30, 100 or 365 days', () {
      expect(crossedMilestone(before: 6, after: 7, celebrated: {}), 7);
      expect(crossedMilestone(before: 29, after: 30, celebrated: {7}), 30);
      expect(crossedMilestone(before: 99, after: 100, celebrated: {}), 100);
      expect(crossedMilestone(before: 364, after: 365, celebrated: {}), 365);
    });

    test('nothing between milestones, nor twice', () {
      expect(crossedMilestone(before: 7, after: 8, celebrated: {7}), isNull);
      // saved again: the streak didn't move
      expect(crossedMilestone(before: 7, after: 7, celebrated: {}), isNull);
      expect(crossedMilestone(before: 6, after: 7, celebrated: {7}), isNull);
    });

    test('a day filled in late joins two series: the highest one', () {
      expect(crossedMilestone(before: 3, after: 31, celebrated: {}), 30);
    });
  });

  group('the store rating', () {
    Future<(RatingPrompt, FakeStoreReview, SharedPreferences)> prompt(
      Map<String, Object> saved, {
      String version = '1.0.21',
    }) async {
      SharedPreferences.setMockInitialValues(saved);
      final preferences = await SharedPreferences.getInstance();
      final review = FakeStoreReview(version: version);
      return (RatingPrompt(review, preferences), review, preferences);
    }

    final now = DateTime(2026, 10, 14, 20);

    test('asked once per version, and the day is kept', () async {
      final (rating, review, preferences) = await prompt({});

      expect(await rating.maybeAsk(now: now), isTrue);
      expect(await rating.maybeAsk(now: now), isFalse);
      expect(review.requests, 1);
      expect(preferences.getString(RatingPrompt.versionKey), '1.0.21');
      expect(DateTime.parse(preferences.getString(RatingPrompt.dateKey)!), now);
    });

    test('a new version waits 120 days after the last time', () async {
      final (rating, review, _) = await prompt({
        RatingPrompt.versionKey: '1.0.20',
        RatingPrompt.dateKey: now
            .subtract(const Duration(days: 119))
            .toIso8601String(),
      });
      expect(await rating.maybeAsk(now: now), isFalse);
      expect(
        await rating.maybeAsk(now: now.add(const Duration(days: 1))),
        isTrue,
      );
      expect(review.requests, 1);
    });

    test('never without a version (debug builds)', () async {
      final (rating, review, _) = await prompt({}, version: '');
      expect(await rating.maybeAsk(now: now), isFalse);
      expect(review.requests, 0);
      expect(const NoStoreReview().appVersion(), completion(isEmpty));
    });
  });

  group('Zoé celebrates', () {
    Future<void> fillAndSave(WidgetTester tester, String quantity) async {
      await tester.tap(find.text('Lecture biblique'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.descendant(
          of: find.byType(EntrySheet),
          matching: find.byType(TextField),
        ),
        quantity,
      );
      await tester.tap(find.text('Valider'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enregistrer la journée'));
      await tester.pumpAndSettle();
    }

    testWidgets('the 7th day in a row: the card is shared as an image, then '
        'the store rating is asked', (tester) async {
      final app = await pumpApp(tester, token: 't', reportDays: daysBefore(6));
      await tester.tap(find.text('Compte rendu').last);
      await tester.pumpAndSettle();

      await fillAndSave(tester, '3');

      expect(find.byType(StreakCelebration), findsOneWidget);
      expect(find.text('7 jours d\'affilée !'), findsOneWidget);
      expect(
        find.text(
          'Une semaine entière avec le Seigneur, jour après jour. '
          'Bravo, continue !',
        ),
        findsOneWidget,
      );
      // the card: the number, "jours avec Dieu" and the name of the app
      Finder onCard(String text) => find.descendant(
        of: find.byType(StreakCard),
        matching: find.text(text),
      );
      expect(onCard('7'), findsOneWidget);
      expect(onCard('jours avec Dieu'), findsOneWidget);
      expect(onCard('CMFI Connect'), findsOneWidget);
      expect(app.preferences.getStringList(StreakMilestones.key), ['7']);

      // the picture is drawn by the engine: real time for it
      await tester.runAsync(() async {
        await tester.tap(find.text('Partager'));
        for (var i = 0; i < 50 && app.share.files.isEmpty; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
      });
      await tester.pumpAndSettle();
      final file = app.share.files.single;
      expect(file.name, 'cmfi-connect-7.png');
      expect(file.mimeType, 'image/png');
      // a PNG, square, 1080 pixels wide
      expect(file.bytes.sublist(1, 4), 'PNG'.codeUnits);
      final width = ByteData.sublistView(file.bytes, 16, 20).getUint32(0);
      final height = ByteData.sublistView(file.bytes, 20, 24).getUint32(0);
      expect((width, height), (1080, 1080));
      expect(app.storeReview.requests, 0);

      // the rating comes once the celebration is closed
      await tester.tap(find.text('Continuer'));
      await tester.pumpAndSettle();
      expect(find.byType(StreakCelebration), findsNothing);
      expect(app.storeReview.requests, 1);

      // saved again the same day: celebrated once
      await fillAndSave(tester, '4');
      expect(find.byType(StreakCelebration), findsNothing);
      expect(app.storeReview.requests, 1);
    });

    testWidgets('30 days: a warm word, and no store rating', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        reportDays: daysBefore(29),
        // the week was celebrated long ago
        initialPreferences: {
          StreakMilestones.key: ['7'],
        },
      );
      await tester.tap(find.text('Compte rendu').last);
      await tester.pumpAndSettle();

      await fillAndSave(tester, '2');

      expect(find.text('30 jours d\'affilée !'), findsOneWidget);
      expect(
        find.text(
          'Un mois de fidélité ! Ce que tu sèmes chaque jour porte du fruit.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Continuer'));
      await tester.pumpAndSettle();
      expect(app.storeReview.requests, 0);
      expect(app.preferences.getStringList(StreakMilestones.key)!.toSet(), {
        '7',
        '30',
      });
    });

    testWidgets('a streak between milestones stays quiet', (tester) async {
      await pumpApp(tester, token: 't', reportDays: daysBefore(9));
      await tester.tap(find.text('Compte rendu').last);
      await tester.pumpAndSettle();

      await fillAndSave(tester, '1');

      expect(find.byType(StreakCelebration), findsNothing);
    });

    testWidgets('with reduced motion, the card shows at once', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () => showStreakCelebration(context, days: 100),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      // no burst to wait for: one frame for the dialog's own fade
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(tester.hasRunningAnimations, isFalse);
      expect(find.text('100 jours d\'affilée !'), findsOneWidget);
      expect(
        find.text(
          'Cent jours avec Dieu ! Ta persévérance est un beau témoignage.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('signing out forgets the milestones', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        initialPreferences: {
          StreakMilestones.key: ['7', '30'],
        },
      );
      await tester.tap(find.text('Plus'));
      await tester.pumpAndSettle();
      await scrollToEnd(tester);
      await tester.tap(find.text('Se déconnecter'));
      await tester.pumpAndSettle();

      expect(app.preferences.getStringList(StreakMilestones.key), isEmpty);
    });
  });
}
