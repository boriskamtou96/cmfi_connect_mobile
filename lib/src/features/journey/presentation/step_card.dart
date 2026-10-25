import 'package:flutter/material.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/night_sky.dart';
import '../../verses/domain/verse.dart';
import '../domain/journey_step.dart';
import 'step_look.dart';
import 'step_medal.dart';

/// A step as a collectible square card: the night sky, Zoé, the medal, its
/// name, the day it was reached and a verse. Locked cards stay grey until the
/// step is reached. Drawn at 300 × 300 and scaled to its width, so the shared
/// image looks the same everywhere.
class StepCard extends StatelessWidget {
  const StepCard({
    required this.step,
    this.reachedOn,
    this.verse,
    this.showTitle = true,
    super.key,
  });

  final JourneyStep step;

  /// null while the step is not reached: the card is locked.
  final DateTime? reachedOn;
  final Verse? verse;

  /// false for a preview where the title is already written around it.
  final bool showTitle;

  static const _design = 300.0;

  bool get _reached => reachedOn != null;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final texts = stepTexts(t, step);
    final colors = stepColors(step.group);
    final dark = _reached
        ? [
            Color.lerp(colors.last, AppColors.primaryDeep, 0.48)!,
            AppColors.primaryDeep,
          ]
        : const [Color(0xFF3A4555), Color(0xFF111722)];
    final date = reachedOn == null
        ? null
        : t.journey.reachedOn(date: context.formatDate(reachedOn!, 'd MMMM y'));

    return AspectRatio(
      aspectRatio: 1,
      child: FittedBox(
        child: MediaQuery.withNoTextScaling(
          child: SizedBox.square(
            dimension: _design,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: dark,
                ),
              ),
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: CustomPaint(painter: NightSkyPainter()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const ExcludeSemantics(
                              child: CmfiLogo.onDark(size: 18),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              t.app.name,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 96,
                          height: 72,
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              StepMedal(
                                step: step,
                                reached: _reached,
                                size: 64,
                              ),
                              PositionedDirectional(
                                end: 2,
                                top: 0,
                                child: DoveMascot(
                                  pose: _reached
                                      ? DovePose.cheer
                                      : DovePose.rest,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (showTitle)
                          Text(
                            texts.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              height: 1.12,
                            ),
                          ),
                        if (showTitle) const SizedBox(height: 4),
                        Text(
                          date ?? t.gamification.cards.locked,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _reached
                                ? AppColors.goldLight
                                : Colors.white.withValues(alpha: 0.55),
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (_reached && verse != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            verse!.text,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.88),
                              fontFamily: 'Lora',
                              fontStyle: FontStyle.italic,
                              fontSize: 11.5,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            verse!.reference,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.goldLight,
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                        const Spacer(),
                        Text(
                          groupName(t, step.group).toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ],
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
