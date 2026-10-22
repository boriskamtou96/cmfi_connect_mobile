import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/stopwatch_clock.dart';
import '../../../reports/application/report_timer.dart';
import '../../../reports/application/reports_providers.dart';
import '../../../reports/presentation/widgets/timer_banner.dart';

/// « Prier librement », under the retreats: to pray without a retreat, the
/// stopwatch of « Prière seule » (PS); « Terminer » adds its minutes to
/// today's report. While it runs: the time, pause / resume, « Terminer ».
/// Nothing when the report has no « Prière seule » counted in time.
class FreePrayerCard extends HookConsumerWidget {
  const FreePrayerCard({super.key});

  static const _prayerCode = 'PS';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final tone = AppModule.prayer.tone(context);
    final scheme = Theme.of(context).colorScheme;
    final prayer = ref
        .watch(activitiesProvider)
        .value
        ?.where((item) => item.code == _prayerCode && item.tracksDuration)
        .firstOrNull;
    final timer = ref.watch(reportTimerProvider);
    // the free prayer: PS, started from here (no topic)
    final mine =
        timer != null && timer.code == _prayerCode && timer.source == null
        ? timer
        : null;
    final running = mine != null && !mine.paused;
    final now = useState(DateTime.now());
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
    }, [running, mine?.startedAt]);

    if (prayer == null) {
      return const SizedBox.shrink();
    }
    final notifier = ref.read(reportTimerProvider.notifier);

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 12, 14),
      decoration: BoxDecoration(
        color: tone.soft,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        children: [
          Icon(
            mine == null || mine.paused
                ? AppIcons.stopwatch
                : AppIcons.stopwatchActive,
            color: tone.onSoft,
            size: 26,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mine == null
                      ? t.prayer.free.title
                      : mine.paused
                      ? '${t.prayer.free.running} · ${t.reports.timer.paused}'
                      : t.prayer.free.running,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: tone.onSoft,
                  ),
                ),
                if (mine == null)
                  Text(
                    t.prayer.free.text,
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  )
                else
                  Text(
                    stopwatchClock(
                      mine.elapsedAt(mine.paused ? mine.pausedAt! : now.value),
                    ),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: tone.onSoft,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
              ],
            ),
          ),
          if (mine == null)
            FilledButton(
              onPressed: () => startStopwatch(
                context,
                ref,
                activityTypeId: prayer.id,
                code: prayer.code,
                label: prayer.label,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: tone.color,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 44),
              ),
              child: Text(t.prayer.free.start),
            )
          else ...[
            IconButton(
              tooltip: mine.paused
                  ? t.reports.timer.resume
                  : t.reports.timer.pause,
              color: tone.onSoft,
              onPressed: mine.paused ? notifier.resume : notifier.pause,
              icon: Icon(mine.paused ? AppIcons.play : AppIcons.pause),
            ),
            FilledButton(
              onPressed: () => finishStopwatch(context, ref),
              style: FilledButton.styleFrom(
                backgroundColor: tone.color,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 44),
              ),
              child: Text(t.reports.timer.finish),
            ),
          ],
        ],
      ),
    );
  }
}
