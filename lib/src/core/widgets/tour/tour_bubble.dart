import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_motion.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../dove_mascot.dart';

/// The bubble of a tour step, in « Nuit et or »: a night-blue card that
/// floats over the veiled screen, the name of the space on top, what the lit
/// element does, then where the tour stands (the dots) and its two buttons.
/// The same in light and dark: night blue carries the strong moments.
class TourBubble extends StatelessWidget {
  const TourBubble({
    required this.space,
    required this.icon,
    required this.title,
    required this.text,
    required this.index,
    required this.count,
    required this.onNext,
    required this.onSkip,
    this.withDove = false,
    super.key,
  });

  /// The name of the space, as a small title (« PRIÈRE »).
  final String space;
  final IconData icon;
  final String title;
  final String text;

  /// This step and the number of steps of the tour.
  final int index;
  final int count;

  final VoidCallback onNext;
  final VoidCallback onSkip;

  /// Zoé greets in the first bubble of the very first tour (the home).
  final bool withDove;

  static const _top = Color(0xFF0B3B70);

  /// The widest a bubble gets, a phone's width minus its margins below that.
  static double widthOf(BuildContext context) =>
      math.min(MediaQuery.sizeOf(context).width - 2 * AppSpacing.lg, 340);

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final last = index == count - 1;
    final soft = Colors.white.withValues(alpha: 0.78);

    return Semantics(
      container: true,
      liveRegion: true,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: widthOf(context),
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg + 2,
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_top, AppColors.primaryDeep],
            ),
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A061F40),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
              BoxShadow(
                color: Color(0x29061F40),
                blurRadius: 30,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                child: Row(
                  children: [
                    if (withDove)
                      const Padding(
                        padding: EdgeInsetsDirectional.only(end: AppSpacing.sm),
                        child: DoveMascot(pose: DovePose.cheer, size: 38),
                      )
                    else
                      Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsetsDirectional.only(
                          end: AppSpacing.sm + 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppRadius.sm + 2),
                        ),
                        child: Icon(icon, size: 17, color: Colors.white),
                      ),
                    Expanded(
                      child: Text(
                        space.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.goldLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    if (count > 1)
                      Text(
                        t.tour.stepOf(n: index + 1, total: count),
                        style: TextStyle(
                          color: soft,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Semantics(
                header: true,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                    height: 1.25,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs + 2),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                child: Text(
                  text,
                  style: TextStyle(color: soft, fontSize: 15, height: 1.45),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // the buttons go under one another with big letters
              Row(
                children: [
                  if (count > 1)
                    ExcludeSemantics(
                      child: _Dots(index: index, count: count),
                    ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: AppSpacing.xs,
                      children: [
                        if (!last)
                          TextButton(
                            onPressed: onSkip,
                            style: TextButton.styleFrom(
                              foregroundColor: soft,
                              minimumSize: const Size(48, 48),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                              ),
                              textStyle: const TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: Text(t.tour.skip),
                          ),
                        FilledButton(
                          onPressed: onNext,
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryDeep,
                            minimumSize: const Size(64, 44),
                            tapTargetSize: MaterialTapTargetSize.padded,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg + 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                            ),
                            textStyle: const TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: Text(last ? t.tour.done : t.tour.next),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Where the tour stands: the current step is a longer pill.
class _Dots extends StatelessWidget {
  const _Dots({required this.index, required this.count});

  final int index;
  final int count;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.of(context, AppMotion.medium);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: duration,
            curve: AppMotion.standard,
            width: i == index ? 18 : 6,
            height: 6,
            margin: const EdgeInsetsDirectional.only(end: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: i == index ? 1 : 0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}
