import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/share_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/widget_image.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/cmfi_logo.dart';
import '../../../../core/widgets/dove_mascot.dart';
import '../../../../core/widgets/motion.dart';
import '../../../../core/widgets/night_sky.dart';

/// 7, 30, 100 or 365 days in a row: Zoé celebrates in a burst of light, and
/// the card of the streak can be shared as an image.
Future<void> showStreakCelebration(BuildContext context, {required int days}) =>
    showAppDialog<void>(
      context: context,
      builder: (context) => StreakCelebration(days: days),
    );

/// The warm word of each milestone.
String streakLine(Translations t, int days) => switch (days) {
  >= 365 => t.streak.lines.year,
  >= 100 => t.streak.lines.hundred,
  >= 30 => t.streak.lines.month,
  _ => t.streak.lines.week,
};

class StreakCelebration extends HookConsumerWidget {
  const StreakCelebration({required this.days, super.key});

  final int days;

  /// Width of the shared image, in pixels (a square).
  static const imageSize = 1080.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final cardKey = useMemoized(GlobalKey.new);
    final sharing = useState(false);
    final reduced = AppMotion.reduced(context);
    final burst = useAnimationController(duration: AppMotion.celebration);
    useEffect(() {
      // once; with "reduce motion", the end state at once (no burst)
      if (reduced) {
        burst.value = 1;
      } else {
        burst.forward();
      }
      return null;
    }, const []);

    Future<void> share(Rect? origin) async {
      final service = ref.read(shareServiceProvider);
      final toast = ref.read(toasterProvider).of(context);
      sharing.value = true;
      try {
        final bytes = await pngOf(cardKey, width: imageSize);
        await service.shareFile(
          bytes,
          name: 'cmfi-connect-$days.png',
          mimeType: 'image/png',
          subject: t.streak.title(n: days),
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
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xl,
      ),
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
            // the card pops in under the burst; the shared image is the card
            // alone, square, without the rounded corners of the dialog
            ScaleTransition(
              scale: CurvedAnimation(
                parent: burst,
                curve: const Interval(0, 0.4, curve: AppMotion.pop),
              ).drive(Tween(begin: 0.85, end: 1)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    child: RepaintBoundary(
                      key: cardKey,
                      child: StreakCard(days: days),
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(painter: _BurstPainter(burst)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              t.streak.title(n: days),
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
              streakLine(t, days),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 15,
                height: 1.45,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Builder(
              builder: (context) => FilledButton.icon(
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
                        // the iPad share sheet points at the button
                        final box = context.findRenderObject() as RenderBox?;
                        share(
                          box == null
                              ? null
                              : box.localToGlobal(Offset.zero) & box.size,
                        );
                      },
                icon: const Icon(AppIcons.share, size: 20),
                label: Text(t.streak.share),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white.withValues(alpha: 0.85),
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.streak.close),
            ),
          ],
        ),
      ),
    );
  }
}

/// The card of a streak, shared as a square image: Zoé in a golden light on
/// the night sky of the app, the number of days, "jours avec Dieu" and the
/// name of the app. Drawn at 300 × 300 and scaled to its width, so the image
/// looks the same on every phone and at every text size.
class StreakCard extends StatelessWidget {
  const StreakCard({required this.days, super.key});

  final int days;

  static const _design = 300.0;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AspectRatio(
      aspectRatio: 1,
      child: FittedBox(
        child: MediaQuery.withNoTextScaling(
          child: SizedBox.square(
            dimension: _design,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0B3B72), AppColors.primaryDeep],
                ),
              ),
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: CustomPaint(painter: NightSkyPainter()),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 18),
                      // Zoé in a round golden light
                      SizedBox(
                        width: 190,
                        height: 118,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: -36,
                              bottom: -36,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      AppColors.gold.withValues(alpha: 0.5),
                                      AppColors.gold.withValues(alpha: 0.14),
                                      AppColors.gold.withValues(alpha: 0),
                                    ],
                                    stops: const [0, 0.5, 1],
                                  ),
                                ),
                              ),
                            ),
                            const DoveMascot(
                              pose: DovePose.celebrate,
                              size: 104,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        context.formatNumber(days),
                        style: const TextStyle(
                          color: AppColors.goldLight,
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 66,
                          fontWeight: FontWeight.w800,
                          height: 1,
                          letterSpacing: -1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.streak.cardDays(n: days),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ExcludeSemantics(
                            child: CmfiLogo.onDark(size: 22),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            t.app.name,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
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

/// A short burst of light around Zoé: golden rays that open and fade, and
/// sparkles flying out. Played once; nothing is drawn once it is over.
class _BurstPainter extends CustomPainter {
  _BurstPainter(this.progress) : super(repaint: progress);

  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress.value;
    if (t <= 0 || t >= 1) {
      return;
    }
    // Zoé's place on the card
    final center = Offset(size.width / 2, size.height * 0.26);
    final reach = size.shortestSide * 0.55;
    final grow = Curves.easeOutCubic.transform(t);
    final fade = t < 0.35 ? 1.0 : 1 - (t - 0.35) / 0.65;

    final ray = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..color = AppColors.goldLight.withValues(alpha: 0.85 * fade);
    for (var i = 0; i < 12; i++) {
      final angle = i * math.pi / 6 + math.pi / 12;
      final direction = Offset(math.cos(angle), math.sin(angle));
      canvas.drawLine(
        center + direction * reach * (0.2 + 0.5 * grow),
        center + direction * reach * (0.3 + 0.7 * grow),
        ray,
      );
    }

    final random = math.Random(3);
    final sparkle = Paint();
    for (var i = 0; i < 16; i++) {
      final angle = random.nextDouble() * 2 * math.pi;
      final distance = reach * (0.3 + 0.8 * random.nextDouble()) * grow;
      final radius = (2 + 3 * random.nextDouble()) * (1 - 0.4 * t);
      sparkle.color = (i.isEven ? Colors.white : AppColors.gold).withValues(
        alpha: fade,
      );
      _star(
        canvas,
        center + Offset(math.cos(angle), math.sin(angle)) * distance,
        radius,
        sparkle,
      );
    }
  }

  /// A four-pointed star with curved sides.
  void _star(Canvas canvas, Offset at, double radius, Paint paint) {
    final r = radius * 2;
    canvas.drawPath(
      Path()
        ..moveTo(at.dx, at.dy - r)
        ..quadraticBezierTo(at.dx, at.dy, at.dx + r, at.dy)
        ..quadraticBezierTo(at.dx, at.dy, at.dx, at.dy + r)
        ..quadraticBezierTo(at.dx, at.dy, at.dx - r, at.dy)
        ..quadraticBezierTo(at.dx, at.dy, at.dx, at.dy - r)
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BurstPainter old) => old.progress != progress;
}
