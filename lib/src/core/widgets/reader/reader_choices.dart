import 'package:flutter/material.dart';

import '../../theme/app_motion.dart';
import '../../theme/app_spacing.dart';
import 'reader_palette.dart';

/// One option of a reading setting (a font): outlined, filled when chosen.
class ReaderChoice extends StatelessWidget {
  const ReaderChoice({
    required this.selected,
    required this.onTap,
    required this.child,
    super.key,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.fast),
        decoration: BoxDecoration(
          color: selected ? scheme.primaryContainer : scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: selected ? scheme.primary : scheme.outline,
            width: selected ? 2 : 1.5,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.md),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}

/// A background to read on, as a round sample; auto is half light, half
/// dark.
class ReaderThemeSwatch extends StatelessWidget {
  const ReaderThemeSwatch({
    required this.theme,
    required this.name,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final ReaderTheme theme;
  final String name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final palette = ReaderPalette.of(theme, Brightness.light);
    return Semantics(
      selected: selected,
      button: true,
      label: name,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 32,
        child: Column(
          children: [
            AnimatedContainer(
              duration: AppMotion.of(context, AppMotion.fast),
              width: 52,
              height: 52,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? scheme.primary : Colors.transparent,
                  width: 2.5,
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: scheme.outlineVariant),
                  color: theme == ReaderTheme.auto ? null : palette.background,
                  // auto: half light, half dark
                  gradient: theme == ReaderTheme.auto
                      ? const LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white,
                            Color(0xFF14130F),
                            Color(0xFF14130F),
                          ],
                          stops: [0, 0.5, 0.5, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                ),
                child: Center(
                  child: theme == ReaderTheme.auto
                      ? null
                      : Text(
                          'Aa',
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 15,
                            color: palette.text,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: TextStyle(fontSize: 12.5, color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
