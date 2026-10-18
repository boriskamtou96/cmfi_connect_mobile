import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'day_report_controller.dart';

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
    final draft = await ref.read(provider.future);
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
