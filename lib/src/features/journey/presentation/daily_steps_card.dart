import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/current_day.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../routing/app_router.dart';
import '../application/daily_steps.dart';
import '../application/journey_progress.dart';
import '../application/weekly_caps.dart';
import '../domain/journey_progress.dart';
import '../domain/weekly_cap.dart';
import 'progress_texts.dart';
import 'step_look.dart';

/// « Tes 4 pas du jour » on Home: the report, a retreat, the Word and a
/// meditation, two by two in tiles (14/11/2026: the fourth step took no more
/// room than the three rows before), each checked once done and opening
/// where it is done; Zoé rejoices when the four are.
class DailyStepsCard extends ConsumerWidget {
  const DailyStepsCard({required this.onReport, super.key});

  /// Opens today's report.
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.journey.daily;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final dark = theme.brightness == Brightness.dark;
    final steps = ref.watch(dailyStepsProvider);
    final week = ref.watch(currentDayProvider).startOfWeek;
    final next = ref.watch(journeyOverviewProvider).next;
    final cap = ref.watch(weeklyCapProvider(week));
    final capProgress = ref.watch(weeklyCapProgressProvider(week)).value;

    final rows = [
      (
        done: steps.report,
        label: t.report,
        icon: AppIcons.reports,
        onTap: onReport,
      ),
      (
        done: steps.prayer,
        label: t.prayer,
        icon: AppIcons.prayer,
        onTap: () => context.navigateTo(const PrayerRoute()),
      ),
      (
        done: steps.word,
        label: steps.withPlan ? t.wordPlan : t.word,
        icon: AppIcons.bible,
        onTap: () => steps.withPlan
            ? context.router.push(const BiblePlanRoute())
            : context.navigateTo(const BibleRoute()),
      ),
      // « Méditation » is an item of the report: filled there
      (
        done: steps.meditation,
        label: t.meditation,
        icon: AppIcons.meditation,
        onTap: onReport,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl - 4),
        border: dark
            ? Border.all(color: Colors.white.withValues(alpha: 0.06))
            : null,
        boxShadow: dark
            ? null
            : [
                BoxShadow(
                  color: AppColors.ink.withValues(alpha: 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(18, 16, 18, 6),
            child: Row(
              children: [
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      t.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: steps.all
                        ? AppColors.gold
                        : AppColors.gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    t.progress(n: steps.done),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: steps.all
                          ? AppColors.primaryDeep
                          : (dark
                                ? AppColors.goldLight
                                : const Color(0xFF8A6210)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
            child: Column(
              children: [
                for (var i = 0; i < rows.length; i += 2) ...[
                  if (i > 0) const SizedBox(height: AppSpacing.sm),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var j = i; j < i + 2 && j < rows.length; j++) ...[
                          if (j > i) const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: _StepTile(
                              done: rows[j].done,
                              label: rows[j].label,
                              icon: rows[j].icon,
                              doneLabel: t.done,
                              onTap: rows[j].onTap,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (steps.all)
            Container(
              margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: dark ? 0.16 : 0.12),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Row(
                children: [
                  const DoveMascot(pose: DovePose.celebrate, size: 44),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      t.allDone,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(height: 12),
          if (next != null || cap != null)
            _JourneyFooter(
              next: next,
              cap: cap,
              capProgress: capProgress,
              onTap: () => context.router.push(const JourneyRoute()),
            ),
        ],
      ),
    );
  }
}

/// One step of the day: a round check (gold once done) and its words on two
/// lines at most, struck through once done; 48 dp at least to touch.
class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.done,
    required this.label,
    required this.icon,
    required this.doneLabel,
    required this.onTap,
  });

  final bool done;
  final String label;
  final IconData icon;
  final String doneLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: done ? '$label, $doneLabel' : label,
      excludeSemantics: true,
      child: Material(
        color: done
            ? AppColors.gold.withValues(alpha: 0.12)
            : scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 56),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 8, 8),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done ? AppColors.gold : null,
                      border: done
                          ? null
                          : Border.all(color: scheme.outlineVariant, width: 2),
                    ),
                    child: done
                        ? const Icon(
                            AppIcons.check,
                            size: 15,
                            color: AppColors.primaryDeep,
                          )
                        : Icon(icon, size: 14, color: scheme.onSurfaceVariant),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.25,
                        fontWeight: FontWeight.w600,
                        color: done ? scheme.onSurfaceVariant : null,
                        decoration: done ? TextDecoration.lineThrough : null,
                        decorationColor: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The line under « Tes 4 pas du jour »: the next step and, when one was
/// chosen, the cap of the week. Both open « Mes étapes ».
class _JourneyFooter extends StatelessWidget {
  const _JourneyFooter({
    required this.next,
    required this.cap,
    required this.capProgress,
    required this.onTap,
  });

  final JourneyProgress? next;
  final WeeklyCap? cap;
  final WeeklyCapProgress? capProgress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final next = this.next;
    final cap = this.cap;
    final title = next == null
        ? t.gamification.cap.title
        : stepTexts(t, next.step).title;
    final parts = <String>[
      if (next != null) journeyRemainingText(t, next),
      if (cap != null && capProgress != null)
        t.gamification.cap.progress(
          done: capProgress!.done,
          target: cap.target,
        ),
      if (next == null && cap != null) capGoalText(t, cap.kind, cap.target),
    ];
    final detail = parts.join(' · ');
    final ratio = next?.ratio ?? capProgress?.ratio ?? 0;
    final color = next == null
        ? scheme.primary
        : stepColors(next.step.group).last;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 1, color: scheme.outlineVariant),
        Semantics(
          button: true,
          label: detail.isEmpty ? title : '$title. $detail',
          excludeSemantics: true,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(18, 10, 14, 10),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(
                      value: ratio,
                      strokeWidth: 2.5,
                      color: color,
                      backgroundColor: scheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (detail.isNotEmpty)
                          Text(
                            detail,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    AppIcons.chevronRight,
                    size: 18,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
