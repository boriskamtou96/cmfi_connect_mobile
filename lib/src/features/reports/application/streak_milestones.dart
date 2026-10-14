import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../domain/report_streak.dart';

part 'streak_milestones.g.dart';

/// The streak milestones already celebrated (7, 30, 100, 365 days), kept on
/// the phone for the account: each one is celebrated once. Signing out
/// forgets them.
@Riverpod(keepAlive: true)
class StreakMilestones extends _$StreakMilestones {
  static const key = 'streak_milestones';

  @override
  Set<int> build() => {
    for (final value
        in ref.watch(sharedPreferencesProvider).getStringList(key) ??
            const <String>[])
      ?int.tryParse(value),
  };

  /// After a save that took the streak from [before] to [after] days: the
  /// milestone it just reached ([before] null when it was unknown: then only
  /// the exact milestone counts). Remembered, so the next call doesn't give
  /// it again. null when there is nothing to celebrate.
  Future<int?> reached({required int? before, required int after}) async {
    final milestone = crossedMilestone(
      before: before ?? after - 1,
      after: after,
      celebrated: state,
    );
    if (milestone != null) {
      await _save({...state, milestone});
    }
    return milestone;
  }

  Future<void> clear() => _save(const {});

  Future<void> _save(Set<int> milestones) async {
    state = milestones;
    await ref.read(sharedPreferencesProvider).setStringList(key, [
      for (final milestone in milestones) '$milestone',
    ]);
  }
}
