import 'package:flutter/material.dart';

import '../theme/app_motion.dart';

/// Rounded progress bar: grows from 0 when it appears, then glides from its
/// previous value to the new one.
class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    required this.value,
    this.minHeight = 6,
    this.color,
    this.backgroundColor,
    super.key,
  });

  /// Between 0 and 1.
  final double value;
  final double minHeight;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value.clamp(0, 1)),
        duration: AppMotion.of(context, AppMotion.slow),
        curve: AppMotion.emphasized,
        builder: (context, value, _) => LinearProgressIndicator(
          value: value,
          minHeight: minHeight,
          color: color,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
