import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../domain/journey_step.dart';
import 'step_look.dart';

/// A step as a round medal: its colors and icon once reached, grey with a
/// small lock before.
class StepMedal extends StatelessWidget {
  const StepMedal({
    required this.step,
    required this.reached,
    this.size = 64,
    super.key,
  });

  final JourneyStep step;
  final bool reached;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = stepColors(step.group);
    return SizedBox.square(
      dimension: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: reached
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: colors,
                    )
                  : null,
              color: reached ? null : scheme.surfaceContainerHighest,
              border: Border.all(
                color: reached
                    ? Colors.white.withValues(alpha: 0.6)
                    : scheme.outlineVariant,
                width: size * 0.04,
              ),
              boxShadow: reached
                  ? [
                      BoxShadow(
                        color: colors.last.withValues(alpha: 0.35),
                        blurRadius: size * 0.2,
                        offset: Offset(0, size * 0.08),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Icon(
                stepIcon(step),
                size: size * 0.46,
                color: reached
                    ? Colors.white
                    : scheme.onSurfaceVariant.withValues(alpha: 0.45),
              ),
            ),
          ),
          if (step.streak case final days? when size >= 56)
            PositionedDirectional(
              end: -size * 0.06,
              bottom: -size * 0.04,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: reached ? colors.last : scheme.outline,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: scheme.surface, width: 2),
                ),
                child: Text(
                  '$days',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (!reached)
            PositionedDirectional(
              end: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIconsFill.lockSimple,
                  size: size * 0.2,
                  color: scheme.outline,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
