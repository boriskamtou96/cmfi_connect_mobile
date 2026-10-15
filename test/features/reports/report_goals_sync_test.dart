import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/reports/application/report_goals.dart';
import 'package:cmfi_connect/src/features/reports/application/reports_providers.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_goal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  // the goals went to the account once already
  const uploaded = {'report_goals_uploaded': true};

  Future<void> loadItems(TestApp app, WidgetTester tester) async {
    app.container.invalidate(activitiesProvider);
    await tester.runAsync(() => app.container.read(activitiesProvider.future));
    await tester.pumpAndSettle();
  }

  testWidgets('a goal set on the phone goes to the account', (tester) async {
    final app = await pumpApp(tester, token: 't', initialPreferences: uploaded);

    await app.container
        .read(reportGoalsProvider.notifier)
        .set(1, const ReportGoal(quantity: 3));
    await tester.pumpAndSettle();

    expect(app.activitiesApi.goalsSent, [(1, const ReportGoal(quantity: 3))]);
    expect(app.activitiesApi.activities.first.goal?.quantity, 3);

    // removed: sent as nothing
    await app.container.read(reportGoalsProvider.notifier).set(1, null);
    await tester.pumpAndSettle();
    expect(app.activitiesApi.goalsSent.last, (1, null));
    expect(app.activitiesApi.activities.first.goal, isNull);
  });

  testWidgets('another phone: the goals come back from the account', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      activities: [
        sampleActivities[0].copyWith(goal: const ReportGoal(quantity: 5)),
        sampleActivities[1].copyWith(goal: const ReportGoal(minutes: 60)),
        sampleActivities[2],
      ],
      initialPreferences: uploaded,
    );
    await loadItems(app, tester);

    final goals = app.container.read(reportGoalsProvider);
    expect(goals[1], const ReportGoal(quantity: 5));
    expect(goals[2], const ReportGoal(minutes: 60));
    expect(goals.containsKey(30), isFalse);
    // nothing to send back
    expect(app.activitiesApi.goalsSent, isEmpty);
  });

  testWidgets('the goals set before this version are sent once', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {
        'report_goals': jsonEncode({
          '1': {'quantity': 3},
          // an item archived since: not listed, kept on the phone
          '999': {'quantity': 1},
        }),
      },
    );
    await loadItems(app, tester);

    expect(app.activitiesApi.goalsSent, [(1, const ReportGoal(quantity: 3))]);
    expect(app.preferences.getBool('report_goals_uploaded'), isTrue);

    // next time: the account is the reference, nothing is sent again
    await loadItems(app, tester);
    expect(app.activitiesApi.goalsSent, hasLength(1));
    expect(app.container.read(reportGoalsProvider)[1]?.quantity, 3);
  });

  testWidgets('removed on another phone: removed here too', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {
        ...uploaded,
        'report_goals': jsonEncode({
          '1': {'quantity': 3},
        }),
      },
    );
    await loadItems(app, tester);

    expect(app.container.read(reportGoalsProvider).containsKey(1), isFalse);
  });

  testWidgets('without network the goal waits, then goes', (tester) async {
    final app = await pumpApp(tester, token: 't', initialPreferences: uploaded);
    app.activitiesApi.offline = true;

    await app.container
        .read(reportGoalsProvider.notifier)
        .set(2, const ReportGoal(minutes: 45));
    await tester.pumpAndSettle();
    expect(app.activitiesApi.goalsSent, isEmpty);
    // kept on the phone meanwhile
    expect(app.container.read(reportGoalsProvider)[2]?.minutes, 45);

    // the network is back: the items load again, the goal goes, and the
    // account's (still empty) answer doesn't erase it
    app.activitiesApi.offline = false;
    await loadItems(app, tester);
    expect(app.activitiesApi.goalsSent, [(2, const ReportGoal(minutes: 45))]);
    expect(app.container.read(reportGoalsProvider)[2]?.minutes, 45);
  });
}
