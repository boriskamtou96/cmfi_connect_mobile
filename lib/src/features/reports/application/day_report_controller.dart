import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/activity_type.dart';
import '../domain/daily_report.dart';
import '../infrastructure/reports_api.dart';
import '../infrastructure/reports_local_store.dart';
import 'pending_reports.dart';
import 'report_reminder.dart';
import 'reports_providers.dart';

part 'day_report_controller.freezed.dart';
part 'day_report_controller.g.dart';

/// The day being filled in, with the changes not saved yet.
@freezed
abstract class DayDraft with _$DayDraft {
  const factory DayDraft({
    required DateTime date,
    required List<ReportEntry> entries,

    /// Items shared by everyone; the others are the user's own.
    required Set<int> standardIds,
    @Default('') String note,

    /// The day exists on the server (saved at least once).
    @Default(false) bool submitted,

    /// Changed since the last save.
    @Default(false) bool dirty,
    @Default(false) bool saving,

    /// Saved on the phone without network, not sent to the server yet.
    @Default(false) bool pending,
  }) = _DayDraft;

  const DayDraft._();

  int get filledCount => entries.where((entry) => entry.isFilled).length;

  List<ReportEntry> get standardEntries => entries
      .where((entry) => standardIds.contains(entry.activityTypeId))
      .toList();

  List<ReportEntry> get personalEntries => entries
      .where((entry) => !standardIds.contains(entry.activityTypeId))
      .toList();
}

/// What a save did.
enum SaveOutcome {
  /// The server has the day.
  sent,

  /// No network: the day waits on the phone and is sent later.
  keptOffline,
}

/// One day of report. A day with unsaved changes stays in memory (switching
/// day or tab doesn't lose it) until it is saved. Without network, the day
/// shown is the one kept on the phone, and a save waits there to be sent.
@riverpod
class DayReportController extends _$DayReportController {
  /// Lets the provider be disposed again once the changes are saved.
  void Function()? _releaseDraft;

  @override
  Future<DayDraft> build(DateTime date) async {
    // rebuilt when the items change (one created or archived): keep what was typed
    final unsaved = switch (state.value) {
      final draft? when draft.dirty => draft,
      _ => null,
    };

    final store = ref.watch(reportsLocalStoreProvider);
    final activities = ref.watch(activitiesProvider.future);
    // a day kept offline shows as saved, until it is sent
    final waiting = store.pending()[date.dateOnly];
    final (report, items) = await (
      waiting == null ? _loadDay(store, activities) : Future.value(waiting),
      activities,
    ).wait;

    final draft = _toDraft(report, {
      for (final activity in items)
        if (activity.isStandard) activity.id,
    }).copyWith(pending: waiting != null);
    if (unsaved == null) {
      return draft;
    }

    final typed = {
      for (final entry in unsaved.entries) entry.activityTypeId: entry,
    };
    return draft.copyWith(
      note: unsaved.note,
      dirty: true,
      entries: [
        for (final entry in draft.entries)
          if (typed[entry.activityTypeId] case final old?)
            entry.copyWith(
              quantity: old.quantity,
              durationMinutes: old.durationMinutes,
            )
          else
            entry,
      ],
    );
  }

  void updateEntry(int activityTypeId, {int? quantity, int? durationMinutes}) {
    _change(
      (draft) => draft.copyWith(
        entries: [
          for (final entry in draft.entries)
            if (entry.activityTypeId == activityTypeId)
              entry.copyWith(
                quantity: quantity,
                durationMinutes: durationMinutes,
              )
            else
              entry,
        ],
      ),
    );
  }

  void clearEntry(int activityTypeId) => updateEntry(activityTypeId);

  void updateNote(String note) =>
      _change((draft) => draft.copyWith(note: note));

  /// Sends the whole day, or keeps it on the phone when there is no network.
  /// Throws an AppException on other failures (the draft is kept).
  Future<SaveOutcome> save() async {
    final draft = state.value;
    if (draft == null || draft.saving) {
      return SaveOutcome.sent;
    }
    state = AsyncData(draft.copyWith(saving: true));
    final pending = ref.read(pendingReportsProvider.notifier);

    try {
      final saved = await ref
          .read(reportsApiProvider)
          .saveDay(date, note: draft.note, entries: draft.entries);
      await ref.read(reportsLocalStoreProvider).saveDay(saved);
      await pending.forget(date);
      if (!ref.mounted) {
        return SaveOutcome.sent;
      }
      state = AsyncData(_toDraft(saved, draft.standardIds));
      _saved();
      // history, week and summary now include this day
      ref
        ..invalidate(reportHistoryProvider)
        ..invalidate(reportSummaryProvider);
      // the network is back: the days kept offline can go too
      await pending.send();
      return SaveOutcome.sent;
    } on NetworkException {
      await pending.keep(
        DailyReport(
          date: date.dateOnly,
          note: draft.note.trim(),
          submitted: true,
          entries: draft.entries,
        ),
      );
      if (ref.mounted) {
        state = AsyncData(
          draft.copyWith(
            saving: false,
            dirty: false,
            submitted: true,
            pending: true,
          ),
        );
        _saved();
      }
      return SaveOutcome.keptOffline;
    } catch (_) {
      if (ref.mounted) {
        state = AsyncData(draft);
      }
      rethrow;
    }
  }

  void _saved() {
    _releaseDraft?.call();
    _releaseDraft = null;
    // a filled day doesn't need its evening reminder any more
    if (date.isSameDay(today())) {
      unawaited(
        ref.read(reportReminderProvider.notifier).reschedule(todayDone: true),
      );
    }
  }

  /// The day from the server, or the copy kept on the phone without network
  /// (an empty form when the day was never opened).
  Future<DailyReport> _loadDay(
    ReportsLocalStore store,
    Future<List<ActivityType>> activities,
  ) async {
    try {
      final day = await ref.watch(reportsApiProvider).getDay(date);
      await store.saveDay(day);
      return day;
    } on NetworkException {
      return store.day(date) ??
          DailyReport(
            date: date.dateOnly,
            entries: [
              for (final activity in await activities)
                ReportEntry(
                  activityTypeId: activity.id,
                  code: activity.code,
                  label: activity.label,
                  tracksQuantity: activity.tracksQuantity,
                  quantityUnit: activity.quantityUnit,
                  tracksDuration: activity.tracksDuration,
                ),
            ],
          );
    }
  }

  void _change(DayDraft Function(DayDraft draft) update) {
    final draft = state.value;
    if (draft == null || draft.saving) {
      return;
    }
    _releaseDraft ??= ref.keepAlive().close;
    state = AsyncData(update(draft).copyWith(dirty: true));
  }

  static DayDraft _toDraft(DailyReport report, Set<int> standardIds) =>
      DayDraft(
        date: report.date,
        entries: report.entries,
        standardIds: standardIds,
        note: report.note ?? '',
        submitted: report.submitted,
      );
}
