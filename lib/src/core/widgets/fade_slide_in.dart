import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_motion.dart';

/// Fades [child] in while it rises a few pixels, once, when it first appears.
///
/// [index] staggers a list: each item waits [AppMotion.stagger] more (8 steps at most).
/// Rebuilds don't replay it, and in a lazy list the item is kept alive so
/// scrolling back doesn't either. With reduced motion the child shows directly.
class FadeSlideIn extends HookWidget {
  const FadeSlideIn({
    required this.child,
    this.index = 0,
    this.delay = Duration.zero,
    super.key,
  });

  final Widget child;

  /// Position in a staggered list.
  final int index;

  /// Extra wait before the animation starts.
  final Duration delay;

  static const _maxSteps = 8;
  static const _distance = 14.0;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    if (AppMotion.reduced(context)) {
      return child;
    }
    // the stagger is an effect delay: part of the animation, no timer to wait
    return child
        .animate()
        .fadeIn(
          delay: delay + AppMotion.stagger * math.min(index, _maxSteps),
          duration: AppMotion.slow,
          curve: AppMotion.emphasized,
        )
        .moveY(begin: _distance, end: 0);
  }
}
