import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'day_report_controller.dart';

/// [day]'s report once it can take a change: a change made while it is
/// being sent would be lost (the controller ignores it), so a save under
/// way is waited for (10 seconds at most).
Future<DayDraft> readyDayDraft(Ref ref, DateTime day) async {
  final provider = dayReportControllerProvider(day);
  var draft = await ref.read(provider.future);
  for (var i = 0; draft.saving && i < 100; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    draft = await ref.read(provider.future);
  }
  return draft;
}

/// Adds [by] to the item [code] (counted in quantity) of [day]'s report and
/// saves it, as the member would (offline, it waits like any day). false
/// when the report has no such item. Used by what counts by itself: the
/// days of fasting (JC, JP).
Future<bool> addToDayReport(
  Ref ref, {
  required DateTime day,
  required String code,
  int by = 1,
}) async {
  final provider = dayReportControllerProvider(day);
  // keeps the day alive while it is read and saved
  final subscription = ref.listen(provider, (_, _) {});
  try {
    final draft = await readyDayDraft(ref, day);
    final entry = draft.entries
        .where((entry) => entry.code == code && entry.tracksQuantity)
        .firstOrNull;
    if (entry == null) {
      return false;
    }
    ref
        .read(provider.notifier)
        .updateEntry(
          entry.activityTypeId,
          quantity: ((entry.quantity ?? 0) + by).clamp(0, 9999),
          durationMinutes: entry.durationMinutes,
        );
    await ref.read(provider.notifier).save();
    return true;
  } finally {
    subscription.close();
  }
}

/// Adds [minutes] to the duration of the item [activityTypeId] of [day]'s
/// report and saves it (1440 minutes at most). false when the report has no
/// such item counted in time. Used by the stopwatch.
Future<bool> addMinutesToDayReport(
  Ref ref, {
  required DateTime day,
  required int activityTypeId,
  required int minutes,
}) async {
  final provider = dayReportControllerProvider(day);
  final subscription = ref.listen(provider, (_, _) {});
  try {
    final draft = await readyDayDraft(ref, day);
    final entry = draft.entries
        .where(
          (entry) =>
              entry.activityTypeId == activityTypeId && entry.tracksDuration,
        )
        .firstOrNull;
    if (entry == null) {
      return false;
    }
    ref
        .read(provider.notifier)
        .updateEntry(
          entry.activityTypeId,
          quantity: entry.quantity,
          durationMinutes: ((entry.durationMinutes ?? 0) + minutes).clamp(
            0,
            1440,
          ),
        );
    await ref.read(provider.notifier).save();
    return true;
  } finally {
    subscription.close();
  }
}

/// Adds [minutes] (or takes them back, when negative) to the item [code]
/// counted in time in [day]'s report and saves it: its new total, or null
/// when the report has no such item. Used by the retreats (PS).
Future<int?> addMinutesToDayReportItem(
  Ref ref, {
  required DateTime day,
  required String code,
  required int minutes,
}) async {
  final provider = dayReportControllerProvider(day);
  final subscription = ref.listen(provider, (_, _) {});
  try {
    final draft = await readyDayDraft(ref, day);
    final entry = draft.entries
        .where((entry) => entry.code == code && entry.tracksDuration)
        .firstOrNull;
    if (entry == null) {
      return null;
    }
    final total = ((entry.durationMinutes ?? 0) + minutes).clamp(0, 1440);
    ref
        .read(provider.notifier)
        .updateEntry(
          entry.activityTypeId,
          quantity: entry.quantity,
          durationMinutes: total == 0 ? null : total,
        );
    await ref.read(provider.notifier).save();
    return total;
  } finally {
    subscription.close();
  }
}
