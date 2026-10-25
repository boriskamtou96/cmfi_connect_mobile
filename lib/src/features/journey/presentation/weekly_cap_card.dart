import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../application/weekly_caps.dart';
import 'progress_texts.dart';
import 'weekly_cap_sheet.dart';

/// « Le cap de la semaine » on the path: the commitment chosen, how far it
/// went, or the gentle invitation to choose one.
class WeeklyCapCard extends ConsumerWidget {
  const WeeklyCapCard({required this.week, super.key});

  final DateTime week;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.gamification.cap;
    final scheme = Theme.of(context).colorScheme;
    final monday = week.startOfWeek;
    final cap = ref.watch(weeklyCapProvider(monday));
    final progress = ref.watch(weeklyCapProgressProvider(monday)).value;
    final skipped = ref.watch(weeklyCapSkipsProvider).contains(monday);
    final accent = scheme.primary;

    if (cap == null) {
      return _Shell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Title(text: t.title),
            const SizedBox(height: AppSpacing.sm),
            Text(
              skipped ? t.none : t.intro,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
            if (skipped) ...[
              const SizedBox(height: 4),
              Text(
                t.noneText,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => showWeeklyCapSheet(context, week: monday),
              child: Text(t.choose),
            ),
          ],
        ),
      );
    }

    final done = progress?.done ?? 0;
    final ratio = progress?.ratio ?? 0;
    final reached = progress?.reached ?? false;
    return _Shell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: _Title(text: t.title)),
              Text(
                t.progress(done: done, target: cap.target),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: reached ? AppColors.gold : scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            capGoalText(context.t, cap.kind, cap.target),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress == null ? null : ratio,
              minHeight: 7,
              color: accent,
              backgroundColor: scheme.surfaceContainerHighest,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              if (reached) ...[
                const Icon(
                  AppIcons.checkCircleFilled,
                  size: 18,
                  color: AppColors.gold,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    t.kept,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ] else
                Expanded(
                  child: Text(
                    progress == null
                        ? '…'
                        : capRemainingText(
                            context.t,
                            cap.kind,
                            progress.remaining,
                          ),
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(48, 48),
                  foregroundColor: scheme.primary,
                ),
                onPressed: () => showWeeklyCapSheet(context, week: monday),
                child: Text(t.change),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(AppIcons.goal, size: 18, color: scheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl - 4),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: child,
    );
  }
}
