import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';

part 'premium_nudge.g.dart';

/// The days a hidden Premium card on the home screen stays away.
const premiumNudgeRest = Duration(days: 30);

/// The streak that shows the card: a member who keeps their report.
const premiumNudgeStreak = 7;

/// When the member last hid the Premium card of the home screen (kept on the
/// phone); null when never.
@Riverpod(keepAlive: true)
class PremiumNudgeHidden extends _$PremiumNudgeHidden {
  static const key = 'premium_nudge_hidden';

  @override
  DateTime? build() => DateTime.tryParse(
    ref.watch(sharedPreferencesProvider).getString(key) ?? '',
  );

  Future<void> hide(DateTime now) async {
    state = now;
    await ref
        .read(sharedPreferencesProvider)
        .setString(key, now.toIso8601String());
  }
}

/// The Premium card shows on the home screen: no Premium, a streak of a
/// week at least, and not hidden in the last 30 days.
bool showPremiumNudge({
  required bool premium,
  required int streak,
  required DateTime? hidden,
  required DateTime now,
}) =>
    !premium &&
    streak >= premiumNudgeStreak &&
    (hidden == null || now.difference(hidden) >= premiumNudgeRest);
