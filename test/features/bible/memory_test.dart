import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/bible/domain/memory_verse.dart';
import 'package:cmfi_connect/src/features/bible/presentation/memory_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  final day = DateTime(2026, 10, 17);

  MemoryVerse verse({DateTime? due, int reps = 0, int interval = 0}) =>
      MemoryVerse(
        book: 'JHN',
        chapter: 3,
        first: 16,
        last: 16,
        label: 'Jean 3:16',
        text: 'Car Dieu a tant aimé le monde',
        version: 'LSG',
        added: day,
        due: due ?? day,
        reps: reps,
        interval: interval,
      );

  group('a verse learnt by heart', () {
    test('comes back further and further apart while it is known', () {
      var v = verse();
      expect(v.stage, MemoryStage.fresh);
      v = v.reviewed(MemoryGrade.good, day);
      expect(v.due, DateTime(2026, 10, 18));
      v = v.reviewed(MemoryGrade.good, day);
      expect(v.interval, 3);
      v = v.reviewed(MemoryGrade.good, day);
      expect(v.interval, 8);
      expect(v.stage, MemoryStage.learning);
      v = v.reviewed(MemoryGrade.easy, day);
      expect(v.interval, greaterThanOrEqualTo(MemoryVerse.knownAfter));
      expect(v.stage, MemoryStage.known);
      expect(v.knownOn, day);
    });

    test('« Encore » starts it again, today', () {
      final v = verse(reps: 4, interval: 30).reviewed(MemoryGrade.again, day);
      expect(v.reps, 0);
      expect(v.lapses, 1);
      expect(v.isDue(day), isTrue);
      expect(v.ease, lessThan(2.5));
    });

    test('the helps: gaps, first letters', () {
      const text = 'Car Dieu a tant aimé le monde, qu’il a donné son Fils';
      final gaps = withGaps(text, 0);
      expect(gaps, contains('___'));
      expect(gaps, startsWith('Car'));
      expect(initialsOf(text), 'C D a t a l m, q a d s F');
    });

    test('kept as JSON', () {
      final v = verse().reviewed(MemoryGrade.good, day);
      final back = MemoryVerse.fromJson(
        jsonDecode(jsonEncode(v.toJson())) as Map<String, dynamic>,
      );
      expect(back.id, 'JHN.3.16');
      expect(back.due, v.due);
      expect(back.reps, 1);
    });
  });

  Map<String, Object> learning(List<MemoryVerse> verses) => {
    'bible_tap_hint_seen': true,
    'memory_verses': jsonEncode([for (final v in verses) v.toJson()]),
  };

  testWidgets('a verse of the Bible, added to memorize', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {
        'bible_tap_hint_seen': true,
        'bible_position': 'JHN.3',
      },
    );
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Bible'),
      ),
    );
    await tester.pumpAndSettle();
    final car = find.textContaining('Car Dieu a tant aimé', findRichText: true);
    await tester.ensureVisible(car);
    await tester.pumpAndSettle();
    await tester.tap(car);
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Mémoriser'));
    await tester.pumpAndSettle();

    expect(app.toasts.messages, contains('Ajouté à tes versets à mémoriser'));
    final saved =
        jsonDecode(app.preferences.getString('memory_verses')!) as List;
    expect(saved.single['label'], 'Jean 3:16');
    expect(saved.single['version'], 'LSG');
  });

  testWidgets('the reviews of the day, one verse at a time', (tester) async {
    final now = today();
    await pumpApp(
      tester,
      token: 't',
      initialPreferences: learning([
        verse(due: now.subtract(const Duration(days: 1)), reps: 1, interval: 1),
        verse(due: now.add(const Duration(days: 5))).copyForTest(first: 17),
      ]),
    );

    // the home screen says it, and opens them
    expect(find.text('Versets à réviser'), findsOneWidget);
    await scrollTo(tester, find.text('Versets à réviser'));
    await tester.tap(find.text('Versets à réviser'));
    await tester.pumpAndSettle();
    expect(find.byType(MemoryReviewScreen), findsOneWidget);
    expect(find.text('0 / 1'), findsOneWidget);
    expect(find.text('Jean 3:16'), findsOneWidget);
    // learnt once: the first letters
    expect(find.text('C D a t a l m'), findsOneWidget);

    await tester.tap(find.text('Voir le verset'));
    await tester.pumpAndSettle();
    expect(find.text('Car Dieu a tant aimé le monde'), findsOneWidget);
    await tester.tap(find.text('Bien'));
    await tester.pumpAndSettle();

    expect(find.text('Révisions terminées !'), findsOneWidget);
    expect(find.text('1 / 1'), findsOneWidget);
  });

  testWidgets('the list, and the reviews reminder', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: learning([verse(due: today())]),
    );
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Bible'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip("Plus d'options"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mémoriser des versets'));
    await tester.pumpAndSettle();

    expect(find.text('Réviser 1 verset'), findsOneWidget);
    expect(find.text('Jean 3:16 · LSG'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    final planned = app.notifications.groups[NotificationGroup.memory] ?? [];
    // tomorrow at 8 at least (today's 8 o'clock may be past)
    expect(planned, isNotEmpty);
    expect(planned.first.body, contains('1 verset'));
  });
}

extension on MemoryVerse {
  MemoryVerse copyForTest({required int first}) => MemoryVerse(
    book: book,
    chapter: chapter,
    first: first,
    last: first,
    label: 'Jean 3:$first',
    text: text,
    version: version,
    added: added,
    due: due,
  );
}
