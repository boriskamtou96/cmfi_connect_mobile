import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../../bible/application/bible_plan.dart';
import '../../bible/application/bible_reading.dart';
import '../../prayer/application/retreats.dart';
import '../../reports/application/reports_providers.dart';
import '../../reports/domain/daily_report.dart';
import '../domain/weekly_cap.dart';

part 'weekly_caps.g.dart';

/// The weekly caps chosen, by Monday of their week, kept on the phone (the
/// last eight weeks). A cap ends with its week: no penalty, no streak to
/// lose. Signing out forgets them.
@Riverpod(keepAlive: true)
class WeeklyCaps extends _$WeeklyCaps {
  static const key = 'weekly_caps';
  static const kept = 8;

  @override
  Map<DateTime, WeeklyCap> build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(key);
    if (raw == null) {
      return const {};
    }
    try {
      final months = jsonDecode(raw) as List<dynamic>;
      return {
        for (final item in months)
          if (item is Map<String, dynamic>)
            if (WeeklyCap.fromJson(item) case final cap) cap.week: cap,
      };
    } on Object {
      return const {};
    }
  }

  /// Chooses (or replaces) the cap of [week].
  Future<void> choose({
    required CapKind kind,
    required int target,
    required DateTime week,
  }) async {
    final cap = WeeklyCap(
      week: week.startOfWeek,
      kind: kind,
      target: target,
      chosenAt: DateTime.now(),
    );
    final sorted = {...state, cap.week: cap}.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    final next = {
      for (final entry in sorted.take(kept)) entry.key: entry.value,
    };
    state = next;
    await ref
        .read(sharedPreferencesProvider)
        .setString(
          key,
          jsonEncode([for (final cap in next.values) cap.toJson()]),
        );
  }

  Future<void> clear() async {
    state = const {};
    await ref.read(sharedPreferencesProvider).remove(key);
  }
}

/// The weeks where the member said « pas cette semaine ». Kept so the app
/// doesn't ask again, without a cap and without a reproach.
@Riverpod(keepAlive: true)
class WeeklyCapSkips extends _$WeeklyCapSkips {
  static const key = 'weekly_cap_skips';
  static const kept = 8;

  @override
  Set<DateTime> build() {
    final raw = ref.watch(sharedPreferencesProvider).getStringList(key);
    return {for (final day in raw ?? const <String>[]) ?DateTime.tryParse(day)};
  }

  Future<void> skip(DateTime week) async {
    final monday = week.startOfWeek;
    final sorted = ({...state, monday}.toList()..sort()).reversed.take(kept);
    final next = sorted.toSet();
    state = next;
    await ref.read(sharedPreferencesProvider).setStringList(key, [
      for (final week in next) week.toIso8601String().substring(0, 10),
    ]);
  }

  Future<void> clear() async {
    state = const {};
    await ref.read(sharedPreferencesProvider).remove(key);
  }
}

/// The cap of [week], if one was chosen.
@riverpod
WeeklyCap? weeklyCap(Ref ref, DateTime week) =>
    ref.watch(weeklyCapsProvider)[week.startOfWeek];

/// Three caps proposed for the week starting today: a few report days, a few
/// retreats, a few chapters. They follow the member's last week a little,
/// without ever asking too much.
@riverpod
Future<List<WeeklyCapSuggestion>> weeklyCapOptions(Ref ref) async {
  final monday = today().startOfWeek;
  final lastMonday = DateTime(monday.year, monday.month, monday.day - 7);
  final lastSunday = DateTime(monday.year, monday.month, monday.day - 1);
  final history = ref.watch(
    reportHistoryProvider(from: lastMonday, to: lastSunday).future,
  );
  final retreats = ref.watch(retreatsOfWeekProvider(lastMonday).future);
  final plan = ref.watch(biblePlanProvider);

  var reports = 3;
  try {
    final days = (await history).where((report) => report.submitted).length;
    reports = (days + 1).clamp(3, 5).toInt();
  } on Object {
    // no history yet: the gentle start
  }

  var made = 3;
  try {
    final retreatList = await retreats;
    made = (retreatList.length ~/ 2 + 1).clamp(3, 5).toInt();
  } on Object {
    // no retreats last week: the gentle start
  }

  final perDay = plan == null || plan.schedule.isEmpty
      ? 1.0
      : plan.plan.total / plan.schedule.length;
  final chapters = (perDay * 5).round().clamp(3, 15).toInt();

  return [
    WeeklyCapSuggestion(kind: CapKind.reports, target: reports),
    WeeklyCapSuggestion(kind: CapKind.retreats, target: made),
    WeeklyCapSuggestion(kind: CapKind.chapters, target: chapters),
  ];
}

/// How far the cap of [week] went. null when no cap was chosen that week.
@riverpod
Future<WeeklyCapProgress?> weeklyCapProgress(Ref ref, DateTime week) async {
  final monday = week.startOfWeek;
  final cap = ref.watch(weeklyCapsProvider)[monday];
  if (cap == null) {
    return null;
  }
  final sunday = DateTime(monday.year, monday.month, monday.day + 6);
  final done = switch (cap.kind) {
    CapKind.reports => (await ref.watch(
      reportedDaysOfWeekProvider(monday).future,
    )).length,
    CapKind.retreats => (await ref.watch(
      retreatsOfWeekProvider(monday).future,
    )).length,
    CapKind.chapters => _chapters(
      await ref.watch(reportHistoryProvider(from: monday, to: sunday).future),
    ),
  };
  return WeeklyCapProgress(cap: cap, done: done);
}

int _chapters(List<DailyReport> reports) => reports.fold(
  0,
  (sum, report) =>
      sum +
      report.entries
          .where((entry) => entry.code == BibleReading.readingCode)
          .fold(0, (count, entry) => count + (entry.quantity ?? 0)),
);
