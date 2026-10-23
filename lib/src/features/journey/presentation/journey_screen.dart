import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/journey_steps.dart';
import '../domain/journey_step.dart';
import 'step_look.dart';
import 'step_medal.dart';

/// « Mes étapes »: the steps of the journey by what they reward, the ones
/// reached in color with their date, the others grey with how to reach
/// them. For the member only: nobody else sees them.
@RoutePage()
class JourneyScreen extends ConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final reached =
        ref.watch(journeyStepsProvider).value ??
        const <JourneyStep, DateTime>{};

    return SubPage(
      title: t.journey.title,
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          Text(
            t.journey.subtitle,
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.journey.count(
              n: reached.length,
              total: JourneyStep.values.length,
            ),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: reached.length / JourneyStep.values.length,
              minHeight: 8,
            ),
          ),
          for (final group in JourneyGroup.values) ...[
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(groupName(t, group), padded: false),
            const SizedBox(height: AppSpacing.sm),
            SectionCard(
              children: [
                for (final step in JourneyStep.values)
                  if (step.group == group)
                    _StepRow(step: step, reachedOn: reached[step]),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.reachedOn});

  final JourneyStep step;
  final DateTime? reachedOn;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final texts = stepTexts(t, step);
    final reached = reachedOn != null;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          StepMedal(step: step, reached: reached, size: 56),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  texts.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: reached ? null : scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  texts.text,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reached
                      ? t.journey.reachedOn(
                          date: context.formatDate(reachedOn!, 'd MMMM y'),
                        )
                      : t.journey.toReach,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    // darker than the medal: readable on the card
                    color: reached
                        ? Color.lerp(
                            stepColors(step.group).last,
                            scheme.onSurface,
                            0.3,
                          )
                        : scheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
