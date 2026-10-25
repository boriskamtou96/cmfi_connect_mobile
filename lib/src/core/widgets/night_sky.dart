import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Small stars, a few golden ones near the top: the same sky each time. The
/// night behind Zoé and the cards of the journey.
class NightSkyPainter extends CustomPainter {
  const NightSkyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(11);
    final paint = Paint();
    for (var i = 0; i < 60; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final bright = random.nextDouble();
      paint.color = Colors.white.withValues(alpha: 0.1 + 0.4 * bright);
      canvas.drawCircle(Offset(x, y), 0.4 + 0.9 * bright, paint);
    }
    for (var i = 0; i < 8; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height * 0.45;
      paint.color = AppColors.goldLight.withValues(
        alpha: 0.4 + 0.4 * random.nextDouble(),
      );
      canvas.drawCircle(Offset(x, y), 0.8 + random.nextDouble(), paint);
    }
  }

  @override
  bool shouldRepaint(NightSkyPainter old) => false;
}
