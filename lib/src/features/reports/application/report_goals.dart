import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/activity_type.dart';
import '../domain/report_goal.dart';
import '../infrastructure/activities_api.dart';
import 'day_report_controller.dart';
import 'reports_providers.dart';

part 'report_goals.g.dart';

/// The daily goals, by item id. Kept on the account (sent with
/// `PUT /activities/:id/goal`, read back with the items) and on the phone, so
/// they show at once and can be changed without network: the changes not sent
/// yet wait in [_pendingKey] and go when the items load again.
@Riverpod(keepAlive: true)
class ReportGoals extends _$ReportGoals {
  static const key = 'report_goals';
  static const _pendingKey = 'report_goals_pending';

  /// Before the goals went to the account, they were on the phone only: those
  /// are sent once.
  static const _uploadedKey = 'report_goals_uploaded';

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
    final preferences = ref.read(sharedPreferencesProvider);
    await preferences.remove(key);
    await preferences.remove(_pendingKey);
    await preferences.remove(_uploadedKey);
    state = const {};
  }

  /// An empty or null [goal] removes the item's goal.
  Future<void> set(int activityTypeId, ReportGoal? goal) async {
    final goals = {...state}..remove(activityTypeId);
    if (goal != null && !goal.isEmpty) {
      goals[activityTypeId] = goal;
    }
    await _save(goals, {..._pending(), activityTypeId});
    unawaited(sendPending());
  }

  /// The items as the server gave them, with the account's goals: they win,
  /// except a change of this phone not sent yet. The items not listed
  /// (archived) keep what the phone had.
  Future<void> fromServer(List<ActivityType> activities) async {
    final preferences = ref.read(sharedPreferencesProvider);
    final uploaded = preferences.getBool(_uploadedKey) ?? false;
    final pending = _pending();
    final goals = {...state};
    for (final activity in activities) {
      if (pending.contains(activity.id)) {
        continue;
      }
      if (activity.goal case final goal? when !goal.isEmpty) {
        goals[activity.id] = goal;
      } else if (!uploaded && goals.containsKey(activity.id)) {
        pending.add(activity.id);
      } else {
        goals.remove(activity.id);
      }
    }
    await preferences.setBool(_uploadedKey, true);
    await _save(goals, pending);
    await sendPending();
  }

  /// Sends the goals changed on the phone; stops at the first network error
  /// (they will go next time). An item gone from the account is forgotten.
  Future<void> sendPending() async {
    final api = ref.read(activitiesApiProvider);
    for (final id in _pending()) {
      try {
        await api.setGoal(id, state[id]);
      } on NetworkException {
        return;
      } on ApiException catch (error) {
        if (error.status != 404) {
          return;
        }
      }
      if (!ref.mounted) {
        return;
      }
      await _save(state, _pending()..remove(id));
    }
  }

  Set<int> _pending() => {
    for (final id
        in ref.read(sharedPreferencesProvider).getStringList(_pendingKey) ??
            const <String>[])
      ?int.tryParse(id),
  };

  Future<void> _save(Map<int, ReportGoal> goals, Set<int> pending) async {
    state = goals;
    final preferences = ref.read(sharedPreferencesProvider);
    await preferences.setString(
      key,
      jsonEncode({
        for (final MapEntry(:key, :value) in goals.entries)
          '$key': value.toJson(),
      }),
    );
    await preferences.setStringList(_pendingKey, [
      for (final id in pending) '$id',
    ]);
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
