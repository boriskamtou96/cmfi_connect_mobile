import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../../bible/application/bible_plan.dart';
import '../../bible/application/bible_reading.dart';
import '../../prayer/application/retreats.dart';
import '../../reports/application/reports_providers.dart';

part 'daily_steps.g.dart';

/// « Les 3 pas du jour »: the report of the day saved, a retreat made, and
/// the Word read (the chapters of the plan, or a chapter marked « J'ai lu ce
/// chapitre » without a plan).
class DailySteps {
  const DailySteps({
    required this.report,
    required this.prayer,
    required this.word,
    required this.withPlan,
  });

  final bool report;
  final bool prayer;
  final bool word;

  /// A reading plan has chapters today: the third step is to read them.
  final bool withPlan;

  int get done => [report, prayer, word].where((step) => step).length;

  bool get all => done == 3;
}

@riverpod
DailySteps dailySteps(Ref ref) {
  final now = today();
  final plan = ref.watch(biblePlanProvider);
  final withPlan = plan != null && plan.chaptersOf(now).isNotEmpty;
  return DailySteps(
    report:
        ref.watch(reportedDaysOfWeekProvider(now)).value?.contains(now) ??
        false,
    prayer: ref.watch(retreatsTodayProvider).isNotEmpty,
    word: withPlan
        ? plan.doneOn(now)
        : ref.watch(bibleReadingProvider).isNotEmpty,
    withPlan: withPlan,
  );
}

/// The days the three steps were all done (`full_days`, the last 60), for
/// « Sept journées complètes ».
@Riverpod(keepAlive: true)
class FullDays extends _$FullDays {
  static const key = 'full_days';

  @override
  Set<DateTime> build() => {
    for (final day
        in ref.watch(sharedPreferencesProvider).getStringList(key) ??
            const <String>[])
      ?DateTime.tryParse(day),
  };

  /// Today counted; the number of full days.
  Future<int> add(DateTime day) async {
    if (state.contains(day.dateOnly)) {
      return state.length;
    }
    final days = ([...state, day.dateOnly]..sort()).reversed.take(60).toSet();
    state = days;
    await ref.read(sharedPreferencesProvider).setStringList(key, [
      for (final day in days) day.toIso8601String().substring(0, 10),
    ]);
    return days.length;
  }
}
