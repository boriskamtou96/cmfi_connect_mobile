import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// A choice among a few at the top of a screen of the games (a course, a
/// period of the leaderboard): a chip in relief, gold when it is the one
/// chosen.
class GameChip extends StatelessWidget {
  const GameChip({
    required this.title,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final edge = selected ? AppColors.gold : scheme.outlineVariant;
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 3),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // an opaque tint: the edge under the chip must not show through
            color: selected
                ? Color.alphaBlend(
                    AppColors.gold.withValues(alpha: 0.16),
                    scheme.surface,
                  )
                : scheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: edge, width: 2),
            boxShadow: [BoxShadow(color: edge, offset: const Offset(0, 3))],
          ),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
