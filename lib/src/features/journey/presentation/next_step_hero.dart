import 'package:flutter/material.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/goal_ring.dart';
import '../domain/journey_progress.dart';
import 'progress_texts.dart';
import 'step_look.dart';
import 'step_medal.dart';

/// The next step of the journey, on « Mes étapes »: its medal, its name,
/// how much is left, and a ring that fills up.
class NextStepHero extends StatelessWidget {
  const NextStepHero({required this.progress, super.key});

  final JourneyProgress progress;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final texts = stepTexts(t, progress.step);
    final scheme = Theme.of(context).colorScheme;
    final colors = stepColors(progress.step.group);
    final accent = colors.last;

    return Semantics(
      container: true,
      label:
          '${t.gamification.next.title}. ${texts.title}. '
          '${journeyRemainingText(t, progress)}',
      child: ExcludeSemantics(
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.xxl - 4),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(AppIcons.goal, size: 16, color: accent),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      t.gamification.next.eyebrow.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: accent,
                      ),
                    ),
                  ),
                  Text(
                    t.gamification.next.family(
                      done: progress.done,
                      total: progress.target,
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  StepMedal(step: progress.step, reached: false, size: 62),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          texts.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          journeyRemainingText(t, progress),
                          style: TextStyle(
                            fontSize: 13.5,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  GoalRing(
                    value: progress.ratio,
                    label: texts.title,
                    size: 46,
                    color: accent,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress.ratio,
                  minHeight: 6,
                  color: accent,
                  backgroundColor: scheme.surfaceContainerHighest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
