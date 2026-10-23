import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../../bible/application/bible_plan.dart';
import '../../prayer/application/retreats.dart';
import '../../reports/application/reports_providers.dart';
import '../../souls/application/souls.dart';
import '../../souls/domain/soul.dart';
import '../application/daily_steps.dart';
import '../application/journey_steps.dart';
import '../domain/journey_step.dart';
import 'grace_notice.dart';
import 'step_celebration.dart';

/// Follows what the member does to reach the steps of the journey: the
/// streak, the four retreats, the souls, the plan, the three steps of the
/// day. What was already there when the app opens is reached quietly; what
/// happens while it is open is celebrated by Zoé, one at a time, once back
/// on the tabs (never over a form or a sheet, which would close it). A day
/// of grace that kept the streak is told once.
class JourneyWatcher extends HookConsumerWidget {
  const JourneyWatcher({required this.child, super.key});

  final Widget child;

  /// The days of grace already told (`grace_noticed`).
  static const graceKey = 'grace_noticed';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // the tabs are on top: no page, sheet or dialog over them
    final onTabs = ModalRoute.of(context)?.isCurrent ?? true;
    final onTabsNow = useRef(onTabs)..value = onTabs;
    // the dialogs waiting, shown one after the other
    final waiting = useRef(<Future<void> Function()>[]);
    final showing = useRef(false);

    Future<void> showNext() async {
      if (showing.value || waiting.value.isEmpty || !onTabsNow.value) {
        return;
      }
      showing.value = true;
      try {
        final dialog = waiting.value.removeAt(0);
        if (context.mounted) {
          await dialog();
        }
      } finally {
        showing.value = false;
      }
      if (context.mounted) {
        await showNext();
      }
    }

    // back on the tabs: what waited
    useEffect(() {
      if (onTabs) {
        scheduleMicrotask(() => unawaited(showNext()));
      }
      return null;
    }, [onTabs]);

    useEffect(() {
      final steps = ref.read(journeyStepsProvider.notifier);
      void reach(JourneyStep step, {required bool celebrate}) =>
          unawaited(steps.reach(step, celebrate: celebrate));

      // after the build that may have asked for it
      void show(Future<void> Function() dialog) {
        waiting.value.add(dialog);
        scheduleMicrotask(() => unawaited(showNext()));
      }

      final celebrations = ref
          .read(journeyCelebrationsProvider)
          .stream
          .listen((step) => show(() => showStepCelebration(context, step)));

      final subscriptions = [
        // the streak: Zoé already celebrates it after a save
        ref.listenManual(reportStreakProvider, (_, next) {
          final days = next.value ?? 0;
          if (days > 0) {
            reach(JourneyStep.firstReport, celebrate: false);
          }
          for (final step in JourneyStep.ofStreak(days)) {
            reach(step, celebrate: false);
          }
        }, fireImmediately: true),
        ref.listenManual(retreatsTodayProvider, (previous, next) {
          if (next.length >= 4) {
            reach(JourneyStep.fourRetreats, celebrate: previous != null);
          }
        }, fireImmediately: true),
        ref.listenManual(soulsProvider, (previous, next) {
          final souls = next.value;
          if (souls == null) {
            return;
          }
          final celebrate = previous?.hasValue ?? false;
          if (souls.isNotEmpty) {
            reach(JourneyStep.firstSoul, celebrate: celebrate);
          }
          if (souls.length >= 10) {
            reach(JourneyStep.tenSouls, celebrate: celebrate);
          }
          if (souls.any((soul) => soul.stage == SoulStage.baptized)) {
            reach(JourneyStep.soulBaptized, celebrate: celebrate);
          }
        }, fireImmediately: true),
        ref.listenManual(biblePlanProvider, (previous, next) {
          if (next?.finished ?? false) {
            reach(JourneyStep.planDone, celebrate: previous != null);
          }
        }, fireImmediately: true),
        // the three steps: celebrated the first time a day is full
        ref.listenManual(dailyStepsProvider, (_, next) async {
          if (!next.all) {
            return;
          }
          final days = ref.read(fullDaysProvider.notifier);
          final day = today();
          final fresh = !ref.read(fullDaysProvider).contains(day);
          final count = await days.add(day);
          reach(JourneyStep.fullDay, celebrate: fresh);
          if (count >= 7) {
            reach(JourneyStep.sevenFullDays, celebrate: fresh);
          }
        }, fireImmediately: true),
        // a day of grace of the last week, told once
        ref.listenManual(reportStreakDetailProvider, (_, next) {
          final graced = next.value?.graced ?? const <DateTime>{};
          final preferences = ref.read(sharedPreferencesProvider);
          final told = {...?preferences.getStringList(graceKey)};
          final week = DateTime(today().year, today().month, today().day - 7);
          for (final day in graced) {
            final key = day.toIso8601String().substring(0, 10);
            if (day.isAfter(week) && !told.contains(key)) {
              told.add(key);
              unawaited(preferences.setStringList(graceKey, told.toList()));
              show(() => showGraceNotice(context, day));
            }
          }
        }, fireImmediately: true),
      ];
      return () {
        unawaited(celebrations.cancel());
        for (final subscription in subscriptions) {
          subscription.close();
        }
      };
    }, const []);

    return child;
  }
}
