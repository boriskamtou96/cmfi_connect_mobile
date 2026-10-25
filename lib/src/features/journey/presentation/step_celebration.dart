import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/motion.dart';
import '../../../routing/app_router.dart';
import '../../verses/application/verse_of_the_day.dart';
import '../application/journey_steps.dart';
import '../domain/journey_step.dart';
import 'step_card.dart';
import 'step_look.dart';

/// A step just reached: Zoé, the medal, its name and how it was reached;
/// "Voir mes étapes" or "Continuer".
Future<void> showStepCelebration(BuildContext context, JourneyStep step) =>
    showAppDialog<void>(
      context: context,
      builder: (dialogContext) => _StepCelebration(
        step: step,
        onSee: () {
          Navigator.of(dialogContext).pop();
          context.router.push(const JourneyRoute());
        },
      ),
    );

class _StepCelebration extends ConsumerWidget {
  const _StepCelebration({required this.step, required this.onSee});

  final JourneyStep step;
  final VoidCallback onSee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final texts = stepTexts(t, step);
    final reachedOn = ref.watch(journeyStepsProvider).value?[step] ?? today();
    ref.watch(savedLanguageProvider);
    final calendar = ref
        .watch(verseCalendarProvider(LocaleSettings.currentLocale.languageCode))
        .value;
    final verse = calendar?.of(reachedOn);
    return Dialog(
      backgroundColor: AppColors.primaryDeep,
      insetPadding: const EdgeInsets.all(AppSpacing.xl),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SizedBox(
                width: 220,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  child: StepCard(
                    step: step,
                    reachedOn: reachedOn,
                    verse: verse,
                    showTitle: false,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              t.journey.newStep.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.goldLight,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              texts.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              texts.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 15,
                height: 1.45,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.primaryDeep,
                minimumSize: const Size.fromHeight(52),
                textStyle: const TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: onSee,
              child: Text(t.journey.see),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white.withValues(alpha: 0.85),
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.journey.go),
            ),
          ],
        ),
      ),
    );
  }
}
