import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../theme/app_tones.dart';

/// Short code of a report item (LB, PS, RQDQA…). Blue for standard items,
/// gold for personal ones, grey while the item is still empty.
class CodeChip extends StatelessWidget {
  const CodeChip({
    required this.code,
    this.personal = false,
    this.filled = true,
    this.minWidth = 54,
    super.key,
  });

  final String code;
  final bool personal;
  final bool filled;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final (background, foreground) = switch ((personal, filled)) {
      (true, _) => (tones.personalSoft, tones.personal),
      (false, true) => (scheme.primaryContainer, scheme.onPrimaryContainer),
      (false, false) => (
        scheme.surfaceContainerHighest,
        scheme.onSurfaceVariant,
      ),
    };

    final duration = AppMotion.of(context, AppMotion.medium);

    // filled / empty changes when an item of the day gets a value
    return AnimatedContainer(
      duration: duration,
      curve: AppMotion.standard,
      constraints: BoxConstraints(minWidth: minWidth),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: AnimatedDefaultTextStyle(
        duration: duration,
        curve: AppMotion.standard,
        style: DefaultTextStyle.of(context).style.merge(
          TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: foreground,
          ),
        ),
        child: Text(
          code,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
