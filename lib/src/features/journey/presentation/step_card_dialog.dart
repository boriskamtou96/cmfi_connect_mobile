import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/widget_image.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/motion.dart';
import '../../verses/domain/verse.dart';
import '../domain/journey_step.dart';
import 'step_card.dart';
import 'step_look.dart';
import 'step_medal.dart';

/// The card of a reached step, big, with "Partager la carte".
Future<void> showStepCardDialog(
  BuildContext context, {
  required JourneyStep step,
  required DateTime reachedOn,
  Verse? verse,
}) => showAppDialog<void>(
  context: context,
  builder: (context) =>
      _StepCardDialog(step: step, reachedOn: reachedOn, verse: verse),
);

class _StepCardDialog extends HookConsumerWidget {
  const _StepCardDialog({
    required this.step,
    required this.reachedOn,
    required this.verse,
  });

  final JourneyStep step;
  final DateTime reachedOn;
  final Verse? verse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final texts = stepTexts(t, step);
    final cardKey = useMemoized(GlobalKey.new);
    final sharing = useState(false);

    Future<void> share(Rect? origin) async {
      final service = ref.read(shareServiceProvider);
      final toast = ref.read(toasterProvider).of(context);
      sharing.value = true;
      try {
        final bytes = await pngOf(cardKey, width: 1080);
        await service.shareFile(
          bytes,
          name: 'etape-${step.name}.png',
          mimeType: 'image/png',
          subject: t.gamification.cards.shareSubject(name: texts.title),
          origin: origin,
        );
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          sharing.value = false;
        }
      }
    }

    return Dialog(
      backgroundColor: AppColors.primaryDeep,
      insetPadding: const EdgeInsets.all(AppSpacing.xl),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.gamification.cards.pageTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            RepaintBoundary(
              key: cardKey,
              child: StepCard(step: step, reachedOn: reachedOn, verse: verse),
            ),
            const SizedBox(height: AppSpacing.lg),
            Builder(
              builder: (buttonContext) => FilledButton.icon(
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
                onPressed: sharing.value
                    ? null
                    : () {
                        final box =
                            buttonContext.findRenderObject() as RenderBox?;
                        share(
                          box == null
                              ? null
                              : box.localToGlobal(Offset.zero) & box.size,
                        );
                      },
                icon: const Icon(AppIcons.share, size: 20),
                label: Text(t.gamification.cards.share),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white.withValues(alpha: 0.85),
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.common.close),
            ),
          ],
        ),
      ),
    );
  }
}

/// A card not reached yet: what to do to receive it.
Future<void> showLockedStepDialog(BuildContext context, JourneyStep step) =>
    showAppDialog<void>(
      context: context,
      builder: (context) {
        final t = context.t;
        final texts = stepTexts(t, step);
        return Dialog(
          insetPadding: const EdgeInsets.all(AppSpacing.xl),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xxl),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StepMedal(step: step, reached: false, size: 76),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  t.gamification.cards.lockedTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  t.gamification.cards.lockedText(name: texts.title),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.45,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(t.common.close),
                ),
              ],
            ),
          ),
        );
      },
    );
