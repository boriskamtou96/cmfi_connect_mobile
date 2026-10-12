import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';

/// Pill-shaped segmented control (Aujourd'hui | Historique | Bilan).
/// The white pill slides to the selected segment.
class SegmentedTabs extends StatelessWidget {
  const SegmentedTabs({
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final duration = AppMotion.of(context, AppMotion.medium);
    final baseStyle = DefaultTextStyle.of(context).style;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / labels.length;

          return Stack(
            children: [
              AnimatedPositionedDirectional(
                duration: duration,
                curve: AppMotion.emphasized,
                start: segmentWidth * selectedIndex,
                width: segmentWidth,
                top: 0,
                bottom: 0,
                child: Material(
                  color: scheme.surface,
                  elevation: 1,
                  shadowColor: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: Row(
                  children: [
                    for (var i = 0; i < labels.length; i++)
                      Expanded(
                        child: Semantics(
                          selected: i == selectedIndex,
                          button: true,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () => onChanged(i),
                            child: SizedBox(
                              height: 42,
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: duration,
                                  curve: AppMotion.standard,
                                  style: baseStyle.merge(
                                    TextStyle(
                                      fontSize: 14,
                                      fontWeight: i == selectedIndex
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      color: i == selectedIndex
                                          ? scheme.onSurface
                                          : scheme.onSurfaceVariant,
                                    ),
                                  ),
                                  child: Text(labels[i]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
