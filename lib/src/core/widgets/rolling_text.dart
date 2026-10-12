import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_motion.dart';

/// Text that rolls to its new value, for counters ("3 sur 10", "45 min"):
/// the new text comes from below while the old one leaves upwards, or the
/// reverse when [value] goes down. Keyed by the text: a rebuild showing the
/// same text does nothing.
class RollingText extends HookWidget {
  const RollingText(
    this.text, {
    this.value,
    this.style,
    this.alignment = AlignmentDirectional.centerStart,
    super.key,
  });

  final String text;

  /// The number behind [text], to roll downwards when it decreases.
  final num? value;
  final TextStyle? style;

  /// Where the text sits while two values overlap.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final previous = usePrevious(value);
    // 1: the text rolls up, -1: down. Kept until the value changes again.
    final direction = useRef(1);
    if (value != null && previous != null && value != previous) {
      direction.value = value! < previous ? -1 : 1;
    }
    final key = ValueKey(text);

    return AnimatedSwitcher(
      duration: AppMotion.of(context, AppMotion.medium),
      switchInCurve: AppMotion.standard,
      switchOutCurve: Curves.easeInCubic,
      layoutBuilder: (current, previous) =>
          Stack(alignment: alignment, children: [...previous, ?current]),
      transitionBuilder: (child, animation) {
        final shift = 0.35 * direction.value;
        final begin = Offset(0, child.key == key ? shift : -shift);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(Tween(begin: begin, end: Offset.zero)),
            child: child,
          ),
        );
      },
      child: Text(text, key: key, style: style),
    );
  }
}
