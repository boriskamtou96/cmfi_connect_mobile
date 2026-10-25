import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../authorities/application/authorities_controller.dart';
import '../../bible/application/bible_plan.dart';
import '../../disciples/application/disciples.dart';
import '../../prayer/application/retreats.dart';
import '../../reports/application/reports_providers.dart';
import '../../souls/application/souls.dart';
import '../../souls/domain/soul.dart';
import '../domain/journey_progress.dart';
import '../domain/journey_step.dart';
import 'daily_steps.dart';
import 'journey_steps.dart';

part 'journey_progress.g.dart';

/// Where the member stands on every step, and the next one to aim at. The
/// next step is the first one not reached in [journeyProgressionOrder] that
/// can be reached now: a step that needs a reading plan, an authority or a
/// disciple is skipped until it is possible.
@riverpod
JourneyOverview journeyOverview(Ref ref) {
  final reached =
      ref.watch(journeyStepsProvider).value ?? const <JourneyStep, DateTime>{};
  final streak = ref.watch(reportStreakProvider).value ?? 0;
  final daily = ref.watch(dailyStepsProvider);
  final fullDays = ref.watch(fullDaysProvider).length;
  final retreats = ref.watch(retreatsTodayProvider).length;
  final souls = ref.watch(soulsProvider).value ?? const <Soul>[];
  final baptized = souls
      .where((soul) => soul.stage == SoulStage.baptized)
      .length;
  final hasAuthority =
      ref.watch(authoritiesControllerProvider).value?.isNotEmpty ?? false;
  final disciples = ref.watch(disciplesListProvider()).value?.total ?? 0;
  final plan = ref.watch(biblePlanProvider);

  JourneyProgress progressOf(JourneyStep step) {
    final done = reached.containsKey(step);
    return switch (step) {
      JourneyStep.firstReport => JourneyProgress(
        step: step,
        done: done ? 1 : (streak > 0 ? 1 : 0),
        target: 1,
        unit: JourneyUnit.reports,
      ),
      JourneyStep.streak7 ||
      JourneyStep.streak30 ||
      JourneyStep.streak100 ||
      JourneyStep.streak365 => JourneyProgress(
        step: step,
        done: done ? step.streak! : streak.clamp(0, step.streak!).toInt(),
        target: step.streak!,
        unit: JourneyUnit.days,
      ),
      JourneyStep.fullDay => JourneyProgress(
        step: step,
        done: done ? 3 : daily.done,
        target: 3,
        unit: JourneyUnit.actions,
      ),
      JourneyStep.sevenFullDays => JourneyProgress(
        step: step,
        done: done ? 7 : fullDays.clamp(0, 7).toInt(),
        target: 7,
        unit: JourneyUnit.fullDays,
      ),
      JourneyStep.fourRetreats => JourneyProgress(
        step: step,
        done: done ? 4 : retreats.clamp(0, 4).toInt(),
        target: 4,
        unit: JourneyUnit.retreats,
      ),
      JourneyStep.planDone => JourneyProgress(
        step: step,
        done: done
            ? (plan?.plan.total ?? 1)
            : (plan?.readCount ?? 0).clamp(0, plan?.plan.total ?? 1).toInt(),
        target: plan?.plan.total ?? 1,
        unit: JourneyUnit.chapters,
        reachable: done || plan != null,
      ),
      JourneyStep.lyricsShared => JourneyProgress(
        step: step,
        done: done ? 1 : 0,
        target: 1,
        unit: JourneyUnit.actions,
      ),
      JourneyStep.firstSoul => JourneyProgress(
        step: step,
        done: done ? 1 : souls.length.clamp(0, 1).toInt(),
        target: 1,
        unit: JourneyUnit.souls,
      ),
      JourneyStep.tenSouls => JourneyProgress(
        step: step,
        done: done ? 10 : souls.length.clamp(0, 10).toInt(),
        target: 10,
        unit: JourneyUnit.souls,
      ),
      JourneyStep.soulBaptized => JourneyProgress(
        step: step,
        done: done ? 1 : baptized.clamp(0, 1).toInt(),
        target: 1,
        unit: JourneyUnit.souls,
      ),
      JourneyStep.firstSending => JourneyProgress(
        step: step,
        done: done ? 1 : 0,
        target: 1,
        unit: JourneyUnit.actions,
        reachable: done || hasAuthority,
      ),
      JourneyStep.firstEncouragement => JourneyProgress(
        step: step,
        done: done ? 1 : 0,
        target: 1,
        unit: JourneyUnit.actions,
        reachable: done || disciples > 0,
      ),
    };
  }

  final byStep = {
    for (final step in JourneyStep.values) step: progressOf(step),
  };
  final next = [
    for (final step in journeyProgressionOrder)
      if (!reached.containsKey(step))
        if (byStep[step]! case final progress
            when progress.reachable && !progress.reached)
          progress,
  ].firstOrNull;

  return JourneyOverview(byStep: byStep, next: next);
}

/// The next step only, for the home line and the profile.
@riverpod
JourneyProgress? nextJourneyStep(Ref ref) =>
    ref.watch(journeyOverviewProvider).next;
