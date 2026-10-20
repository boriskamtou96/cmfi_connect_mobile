import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// A few still stars, gold and white, always at the same places of the box
/// ("Ton année avec Dieu": its pages and the card of the home screen).
class StoryStars extends StatelessWidget {
  const StoryStars({super.key});

  @override
  Widget build(BuildContext context) =>
      const ExcludeSemantics(child: CustomPaint(painter: _StarsPainter()));
}

class _StarsPainter extends CustomPainter {
  const _StarsPainter();

  // (x, y) in fractions of the box, the radius, gold or not: in the margins
  // and above the content, never on the words
  static const _stars = <(double, double, double, bool)>[
    (0.12, 0.07, 1.6, false),
    (0.33, 0.035, 1, false),
    (0.64, 0.05, 1.2, false),
    (0.88, 0.16, 2.2, true),
    (0.03, 0.3, 1.8, true),
    (0.96, 0.36, 1.4, false),
    (0.965, 0.55, 1.1, false),
    (0.025, 0.6, 1.3, false),
    (0.95, 0.72, 2, true),
    (0.04, 0.8, 1.2, false),
    (0.03, 0.95, 1.5, false),
    (0.85, 0.965, 1.8, true),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final (x, y, radius, gold) in _stars) {
      final center = Offset(x * size.width, y * size.height);
      final paint = Paint()
        ..color = gold
            ? AppColors.goldLight.withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.35);
      canvas.drawCircle(center, radius, paint);
      if (gold) {
        // a small sparkle around the gold ones
        final ray = Paint()
          ..color = AppColors.goldLight.withValues(alpha: 0.35)
          ..strokeWidth = 1;
        for (var i = 0; i < 4; i++) {
          final angle = i * math.pi / 2;
          canvas.drawLine(
            center + Offset.fromDirection(angle, radius + 1.5),
            center + Offset.fromDirection(angle, radius * 4),
            ray,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_StarsPainter oldDelegate) => false;
}
