import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/widgets/adaptive_dialogs.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../application/report_item_texts.dart';
import '../../application/report_timer.dart';

/// "12:34", "1:02:05": the time of a stopwatch.
String stopwatchClock(Duration elapsed) {
  final seconds = elapsed.inSeconds;
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  final s = (seconds % 60).toString().padLeft(2, '0');
  return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:$s' : '$m:$s';
}

/// Starts the stopwatch of an item ([source]: what else it counts for);
/// when another one runs, it is replaced (uncounted) once the member agrees.
/// false when they didn't.
Future<bool> startStopwatch(
  BuildContext context,
  WidgetRef ref, {
  required int activityTypeId,
  required String code,
  required String label,
  String? source,
}) async {
  final t = context.t;
  final running = ref.read(reportTimerProvider);
  if (running != null &&
      (running.activityTypeId != activityTypeId || running.source != source)) {
    final yes = await showConfirmDialog(
      context,
      title: t.reports.timer.replaceTitle,
      text: t.reports.timer.replaceText(
        item: t.itemLabel(running.code, running.label),
      ),
      confirmLabel: t.reports.timer.replace,
    );
    if (!yes) {
      return false;
    }
  }
  HapticFeedback.mediumImpact();
  await ref
      .read(reportTimerProvider.notifier)
      .start(
        activityTypeId: activityTypeId,
        code: code,
        label: label,
        source: source,
      );
  return true;
}

/// Stops the stopwatch, adds its minutes to the report and says so.
Future<void> finishStopwatch(BuildContext context, WidgetRef ref) async {
  final timer = ref.read(reportTimerProvider);
  if (timer == null) {
    return;
  }
  final t = context.t;
  final toast = ref.read(toasterProvider).of(context);
  final label = t.itemLabel(timer.code, timer.label);
  HapticFeedback.mediumImpact();
  final minutes = await ref.read(reportTimerProvider.notifier).finish();
  if (minutes == null) {
    toast.info(t.reports.timer.noItem);
  } else {
    toast.success(
      t.reports.timer.added(time: minutes.toDurationLabel(), item: label),
    );
  }
}

/// Above the tabs while a stopwatch runs, on every tab: the item, the time
/// going by, pause / resume, « Terminer » (its minutes go to the report); a
/// long press cancels it. Nothing without a stopwatch.
class TimerBanner extends HookConsumerWidget {
  const TimerBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(reportTimerProvider);
    final now = useState(DateTime.now());
    final running = timer != null && !timer.paused;
    // the seconds go by while it runs
    useEffect(() {
      if (!running) {
        return null;
      }
      now.value = DateTime.now();
      final tick = Timer.periodic(
        const Duration(seconds: 1),
        (_) => now.value = DateTime.now(),
      );
      return tick.cancel;
    }, [running, timer?.startedAt]);

    if (timer == null) {
      return const SizedBox.shrink();
    }
    final t = context.t;
    final label = t.itemLabel(timer.code, timer.label);
    final elapsed = timer.elapsedAt(timer.paused ? timer.pausedAt! : now.value);
    final notifier = ref.read(reportTimerProvider.notifier);

    Future<void> finish() => finishStopwatch(context, ref);

    // a long press: stopped without counting anything
    Future<void> discard() async {
      final yes = await showConfirmDialog(
        context,
        title: t.reports.timer.discard,
        confirmLabel: t.reports.timer.discard,
        destructive: true,
      );
      if (yes) {
        await notifier.discard();
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      child: GestureDetector(
        onLongPress: discard,
        child: Material(
          color: AppColors.primaryDeep,
          borderRadius: BorderRadius.circular(22),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 6, 6, 6),
            child: Row(
              children: [
                Icon(
                  timer.paused ? AppIcons.stopwatch : AppIcons.stopwatchActive,
                  color: AppColors.goldLight,
                  size: 22,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                        ),
                      ),
                      Text(
                        timer.paused
                            ? '${stopwatchClock(elapsed)} · ${t.reports.timer.paused}'
                            : stopwatchClock(elapsed),
                        style: const TextStyle(
                          color: AppColors.goldLight,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: timer.paused
                      ? t.reports.timer.resume
                      : t.reports.timer.pause,
                  onPressed: timer.paused ? notifier.resume : notifier.pause,
                  color: Colors.white,
                  icon: Icon(timer.paused ? AppIcons.play : AppIcons.pause),
                ),
                FilledButton(
                  onPressed: finish,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.ink,
                    minimumSize: const Size(0, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                  child: Text(t.reports.timer.finish),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
