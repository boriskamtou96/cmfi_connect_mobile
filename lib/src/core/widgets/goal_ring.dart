import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../utils/date_format.dart';

/// How far the goals are reached: a ring that fills up, the percentage in
/// the middle. It turns gold at 100 %. [label] is read by screen readers
/// ("Objectifs du jour").
class GoalRing extends StatelessWidget {
  const GoalRing({
    required this.value,
    required this.label,
    this.size = 56,
    this.color,
    this.trackColor,
    this.textColor,
    super.key,
  });

  /// From 0 to 1.
  final double value;
  final String label;
  final double size;
  final Color? color;
  final Color? trackColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final target = value.clamp(0.0, 1.0);
    final done = target >= 1;
    final stroke = size * 0.11;

    return Semantics(
      label: label,
      value: context.formatPercent(target),
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: target),
        duration: AppMotion.of(context, AppMotion.slow),
        curve: AppMotion.emphasized,
        builder: (context, shown, _) => SizedBox.square(
          dimension: size,
          child: CustomPaint(
            painter: _RingPainter(
              value: shown,
              stroke: stroke,
              color: done ? AppColors.gold : color ?? scheme.primary,
              track: trackColor ?? scheme.outlineVariant,
            ),
            child: Padding(
              padding: EdgeInsets.all(stroke * 1.6),
              // a large font setting shrinks the text rather than cutting it
              child: FittedBox(
                child: Text(
                  context.formatPercent(shown),
                  style: TextStyle(
                    fontSize: size * 0.26,
                    fontWeight: FontWeight.w800,
                    color: textColor ?? scheme.onSurface,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.value,
    required this.stroke,
    required this.color,
    required this.track,
  });

  final double value;
  final double stroke;
  final Color color;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, math.pi * 2, false, paint..color = track);
    if (value > 0) {
      // from the top, clockwise
      canvas.drawArc(
        rect,
        -math.pi / 2,
        math.pi * 2 * value,
        false,
        paint..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value ||
      old.stroke != stroke ||
      old.color != color ||
      old.track != track;
}
