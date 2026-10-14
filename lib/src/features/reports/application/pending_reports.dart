import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/services/network_status.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/daily_report.dart';
import '../domain/report_goal.dart';
import '../infrastructure/reports_api.dart';
import '../infrastructure/reports_local_store.dart';
import 'day_report_controller.dart';
import 'report_goals.dart';
import 'reports_providers.dart';

part 'pending_reports.g.dart';

/// The days saved without network, by date. They are sent again when the
/// network comes back, when the app comes to the front, and after a save.
@Riverpod(keepAlive: true)
class PendingReports extends _$PendingReports {
  var _sending = false;

  @override
  Set<DateTime> build() {
    final changes = ref.watch(networkStatusProvider).changes.listen((online) {
      if (online) {
        unawaited(send());
      }
    });
    ref.onDispose(changes.cancel);
    return ref.watch(reportsLocalStoreProvider).pending().keys.toSet();
  }

  /// Keeps [day] until it can be sent.
  Future<void> keep(DailyReport day) async {
    await ref.read(reportsLocalStoreProvider).addPending(day);
    state = {...state, day.date.dateOnly};
  }

  /// [date] was saved on the server: nothing left to send for it.
  Future<void> forget(DateTime date) async {
    if (!state.contains(date.dateOnly)) {
      return;
    }
    await ref.read(reportsLocalStoreProvider).removePending(date);
    state = {...state}..remove(date.dateOnly);
  }

  /// Sends the waiting days, the oldest first. Stops at the first network
  /// error: the rest waits for the next try.
  Future<void> send() async {
    if (_sending || state.isEmpty) {
      return;
    }
    _sending = true;
    final store = ref.read(reportsLocalStoreProvider);
    var sent = false;
    try {
      final waiting = store.pending().values.toList()
        ..sort((a, b) => a.date.compareTo(b.date));
      for (final day in waiting) {
        try {
          final saved = await ref
              .read(reportsApiProvider)
              .saveDay(
                day.date,
                note: day.note ?? '',
                entries: day.entries,
                goalPercent: dayGoalPercent(
                  ref.read(reportGoalsProvider),
                  day.entries,
                ),
              );
          await store.saveDay(saved);
        } on NetworkException {
          break;
        } on UnauthorizedException {
          break;
        } on ApiException {
          // refused for good (an item removed meanwhile…): retrying won't help
        }
        await store.removePending(day.date);
        sent = true;
      }
    } finally {
      _sending = false;
    }
    if (!ref.mounted) {
      return;
    }
    state = store.pending().keys.toSet();
    if (sent) {
      ref
        ..invalidate(dayReportControllerProvider)
        ..invalidate(reportHistoryProvider)
        ..invalidate(reportSummaryProvider);
    }
  }
}
