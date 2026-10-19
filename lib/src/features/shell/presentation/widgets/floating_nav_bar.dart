import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_theme.dart';

/// A tab of [FloatingNavBar].
typedef FloatingNavItem = ({IconData icon, IconData activeIcon, String label});

/// The tabs as a capsule floating above the bottom of the screen: frosted
/// glass (white by day, night grey in dark mode), the tab shown in a pill of
/// its module's colour, the icon over its name. Each tab is a button read
/// with its name and « selected ».
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    required this.accent,
    required this.indicator,
    super.key,
  });

  final List<FloatingNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// The icon and name of the tab shown, and its pill.
  final Color accent;
  final Color indicator;

  static const height = 64.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(height / 2);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: dark ? 0.4 : 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: height,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: radius,
                color: dark
                    ? const Color(0xFF1C2029).withValues(alpha: 0.92)
                    : Colors.white.withValues(alpha: 0.94),
                border: Border.all(
                  color: dark
                      ? Colors.white.withValues(alpha: 0.08)
                      : scheme.outlineVariant.withValues(alpha: 0.7),
                ),
              ),
              child: Row(
                children: [
                  for (final (index, item) in items.indexed)
                    Expanded(
                      child: _Tab(
                        item: item,
                        selected: index == selectedIndex,
                        accent: accent,
                        indicator: dark
                            ? Colors.white.withValues(alpha: 0.12)
                            : indicator,
                        muted: scheme.onSurfaceVariant,
                        onTap: () {
                          if (index != selectedIndex) {
                            HapticFeedback.selectionClick();
                          }
                          onSelected(index);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.item,
    required this.selected,
    required this.accent,
    required this.indicator,
    required this.muted,
    required this.onTap,
  });

  final FloatingNavItem item;
  final bool selected;
  final Color accent;
  final Color indicator;
  final Color muted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? accent : muted;
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppMotion.of(context, AppMotion.medium),
          curve: AppMotion.emphasized,
          decoration: BoxDecoration(
            color: selected ? indicator : Colors.transparent,
            borderRadius: BorderRadius.circular(FloatingNavBar.height / 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? item.activeIcon : item.icon,
                size: 22,
                color: color,
              ),
              const SizedBox(height: 2),
              // a long name (« Compte rendu ») shrinks a little rather
              // than being cut
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  item.label,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 11,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    letterSpacing: -0.1,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
