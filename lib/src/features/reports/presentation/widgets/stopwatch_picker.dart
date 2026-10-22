import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../application/day_report_controller.dart';
import '../../application/report_item_texts.dart';
import '../../application/report_timer.dart';
import 'timer_banner.dart';

/// The stopwatch apart (the button of the Compte rendu tab): « Que veux-tu
/// chronométrer ? », every item of today's report counted in time (the
/// standard ones, then the member's own); a touch starts its stopwatch (the
/// banner, the lock screen), and « Terminer » adds the minutes to today's
/// report by itself.
Future<void> showStopwatchPicker(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheet) => const _StopwatchPicker(),
    );

class _StopwatchPicker extends ConsumerWidget {
  const _StopwatchPicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final s = t.reports.timer;
    final scheme = Theme.of(context).colorScheme;
    final report = ref.watch(dayReportControllerProvider(today()));
    final running = ref.watch(reportTimerProvider);

    Future<void> start(DayDraft draft, int activityTypeId) async {
      final entry = draft.entries.firstWhere(
        (entry) => entry.activityTypeId == activityTypeId,
      );
      final navigator = Navigator.of(context);
      if (running?.activityTypeId == activityTypeId &&
          running?.source == null) {
        navigator.pop();
        return;
      }
      if (await startStopwatch(
            context,
            ref,
            activityTypeId: entry.activityTypeId,
            code: entry.code,
            label: entry.label,
          ) &&
          navigator.mounted) {
        navigator.pop();
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(s.pickTitle, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(s.pickHint, style: TextStyle(color: scheme.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.md),
          switch (report) {
            AsyncValue(value: final draft?) => () {
              final timed = [
                for (final entry in [
                  ...draft.standardEntries,
                  ...draft.personalEntries,
                ])
                  if (entry.tracksDuration) entry,
              ];
              if (timed.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: Text(s.pickEmpty, textAlign: TextAlign.center),
                );
              }
              return Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final entry in timed)
                      () {
                        final isRunning =
                            running?.activityTypeId == entry.activityTypeId &&
                            running?.source == null;
                        final minutes = entry.durationMinutes ?? 0;
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            isRunning
                                ? AppIcons.stopwatchActive
                                : AppIcons.stopwatch,
                            color: isRunning ? AppColors.gold : scheme.primary,
                          ),
                          title: Text(
                            t.itemLabel(
                              entry.code,
                              entry.label,
                              standard: draft.standardIds.contains(
                                entry.activityTypeId,
                              ),
                            ),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            isRunning
                                ? s.running
                                : minutes > 0
                                ? s.todayMinutes(
                                    time: minutes.toDurationLabel(),
                                  )
                                : s.notYet,
                          ),
                          trailing: Icon(
                            isRunning ? AppIcons.chevronRight : AppIcons.play,
                            color: scheme.primary,
                          ),
                          onTap: () => start(draft, entry.activityTypeId),
                        );
                      }(),
                  ],
                ),
              );
            }(),
            AsyncValue(:final error?) when report.value == null => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Text(
                userMessageFor(error, t),
                textAlign: TextAlign.center,
              ),
            ),
            _ => const Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Center(child: AppSpinner()),
            ),
          },
        ],
      ),
    );
  }
}
