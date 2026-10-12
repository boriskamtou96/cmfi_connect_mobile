import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../domain/report_goal.dart';

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
