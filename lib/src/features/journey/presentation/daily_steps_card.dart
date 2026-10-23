import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../routing/app_router.dart';
import '../application/daily_steps.dart';

/// « Tes 3 pas du jour » on Home: the report, a retreat, the Word, each
/// checked once done and opening where it is done; Zoé rejoices when the
/// three are.
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
          for (final row in rows)
            Semantics(
              button: true,
              label: row.done ? '${row.label}, ${t.done}' : row.label,
              excludeSemantics: true,
              child: InkWell(
                onTap: row.onTap,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(18, 9, 14, 9),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: row.done ? AppColors.gold : null,
                          border: row.done
                              ? null
                              : Border.all(
                                  color: scheme.outlineVariant,
                                  width: 2,
                                ),
                        ),
                        child: row.done
                            ? const Icon(
                                AppIcons.check,
                                size: 16,
                                color: AppColors.primaryDeep,
                              )
                            : Icon(
                                row.icon,
                                size: 15,
                                color: scheme.onSurfaceVariant,
                              ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          row.label,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: row.done ? scheme.onSurfaceVariant : null,
                            decoration: row.done
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      if (!row.done)
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
            const SizedBox(height: 8),
        ],
      ),
    );
  }
}
