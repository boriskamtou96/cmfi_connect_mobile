import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/report_goal.dart';
import 'day_report_controller.dart';
import 'reports_providers.dart';

part 'report_goals.g.dart';

/// The daily goals, by item id. Kept on the phone.
@Riverpod(keepAlive: true)
class ReportGoals extends _$ReportGoals {
  static const key = 'report_goals';

  @override
  Map<int, ReportGoal> build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(key);
    if (raw == null) {
      return const {};
    }
    return {
      for (final MapEntry(:key, :value)
          in (jsonDecode(raw) as Map<String, dynamic>).entries)
        int.parse(key): ReportGoal.fromJson(value as Map<String, dynamic>),
    };
  }

  /// Signing out (or deleting the account): the next account on this phone
  /// starts without them.
  Future<void> clear() async {
    await ref.read(sharedPreferencesProvider).remove(key);
    state = const {};
  }

  /// An empty or null [goal] removes the item's goal.
  Future<void> set(int activityTypeId, ReportGoal? goal) async {
    final goals = {...state}..remove(activityTypeId);
    if (goal != null && !goal.isEmpty) {
      goals[activityTypeId] = goal;
    }
    state = goals;
    await ref
        .read(sharedPreferencesProvider)
        .setString(
          key,
          jsonEncode({
            for (final MapEntry(:key, :value) in goals.entries)
              '$key': value.toJson(),
          }),
        );
  }
}

/// How far the goals of [day] are reached, as it is being filled in (changes
/// not saved yet included). Null without goals.
@riverpod
DayGoals? goalsOfDay(Ref ref, DateTime day) {
  final draft = ref.watch(dayReportControllerProvider(day)).value;
  return draft == null
      ? null
      : dayGoals(ref.watch(reportGoalsProvider), draft.entries);
}

/// One week of the progress of the goals: its Monday, and the mean of the
/// goals that week (null when no day counted yet).
typedef GoalsWeek = ({DateTime monday, double? progress});

/// The goals of the last [weeks] weeks, the oldest first (Premium).
@riverpod
Future<List<GoalsWeek>> goalsEvolution(Ref ref, {int weeks = 12}) async {
  final now = today();
  final firstMonday = DateTime(
    now.startOfWeek.year,
    now.startOfWeek.month,
    now.startOfWeek.day - 7 * (weeks - 1),
  );
  final goals = ref.watch(reportGoalsProvider);
  // the items in use: an archived item's goal doesn't count
  final items = [
    for (final activity in await ref.watch(activitiesProvider.future))
      activity.id,
  ];
  final history = await ref.watch(
    reportHistoryProvider(from: firstMonday, to: now).future,
  );
  return [
    for (var i = 0; i < weeks; i++)
      () {
        final monday = DateTime(
          firstMonday.year,
          firstMonday.month,
          firstMonday.day + 7 * i,
        );
        final sunday = DateTime(monday.year, monday.month, monday.day + 6);
        return (
          monday: monday,
          progress: periodGoals(
            goals,
            itemIds: items,
            history: history,
            from: monday,
            to: sunday.isAfter(now) ? now : sunday,
            today: now,
          )?.total,
        );
      }(),
  ];
}
