import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/storage/preferences.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';

// built once: the previews never change
final _light = AppTheme.light();
final _dark = AppTheme.dark();

String themeModeLabel(Translations t, ThemeMode mode) => switch (mode) {
  ThemeMode.system => t.more.themeSystem,
  ThemeMode.light => t.more.themeLight,
  ThemeMode.dark => t.more.themeDark,
};

/// Automatique / Clair / Sombre, each with a small preview of the app.
/// The choice applies at once and the sheet stays open, to compare.
Future<void> showThemeSheet(BuildContext context) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) => const SingleChildScrollView(child: _ThemeSheet()),
);

class _ThemeSheet extends ConsumerWidget {
  const _ThemeSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final selected = ref.watch(savedThemeModeProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xl,
          0,
          AppSpacing.xl,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.more.appearance,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final mode in const [
                  ThemeMode.system,
                  ThemeMode.light,
                  ThemeMode.dark,
                ]) ...[
                  if (mode != ThemeMode.system)
                    const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _ThemeOption(
                      mode: mode,
                      label: themeModeLabel(t, mode),
                      selected: mode == selected,
                      onTap: () =>
                          ref.read(savedThemeModeProvider.notifier).save(mode),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              t.more.themeSystemHint,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.mode,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final ThemeMode mode;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final duration = AppMotion.of(context, AppMotion.fast);
    const radius = BorderRadius.all(Radius.circular(AppRadius.lg));

    final preview = switch (mode) {
      ThemeMode.light => _MiniApp(theme: _light),
      ThemeMode.dark => _MiniApp(theme: _dark),
      // half and half, cut on the diagonal
      ThemeMode.system => Stack(
        fit: StackFit.expand,
        children: [
          _MiniApp(theme: _light),
          ClipPath(
            clipper: const _DiagonalClipper(),
            child: _MiniApp(theme: _dark),
          ),
        ],
      ),
    };

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        // the tap stays on this node, the label above replaces the texts below
        child: ExcludeSemantics(
          child: Column(
            children: [
              AnimatedContainer(
                duration: duration,
                curve: AppMotion.standard,
                height: 132,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: radius,
                  border: Border.all(
                    color: selected ? scheme.primary : scheme.outlineVariant,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppRadius.lg - 4),
                  ),
                  child: preview,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedSwitcher(
                duration: duration,
                child: Icon(
                  selected ? AppIcons.checkCircleFilled : AppIcons.radioOff,
                  key: ValueKey(selected),
                  size: 22,
                  color: selected ? scheme.primary : scheme.outline,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The home screen in miniature: title, blue report card, two cards, tab bar.
class _MiniApp extends StatelessWidget {
  const _MiniApp({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final scheme = theme.colorScheme;

    Widget bar(double widthFactor, Color color, {double height = 5}) =>
        FractionallySizedBox(
          widthFactor: widthFactor,
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(height),
            ),
          ),
        );

    Widget card() => Container(
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: scheme.outlineVariant, width: 0.8),
      ),
      child: bar(0.6, scheme.onSurfaceVariant.withValues(alpha: 0.45)),
    );

    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  bar(0.5, scheme.onSurface, height: 6),
                  const SizedBox(height: 7),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.all(6),
                    alignment: AlignmentDirectional.topStart,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: bar(0.55, Colors.white.withValues(alpha: 0.85)),
                  ),
                  const SizedBox(height: 5),
                  card(),
                  const SizedBox(height: 4),
                  card(),
                ],
              ),
            ),
          ),
          Container(
            height: 16,
            decoration: BoxDecoration(
              color: scheme.surface,
              border: Border(top: BorderSide(color: scheme.outlineVariant)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < 4; i++)
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: i == 0 ? scheme.primary : scheme.outline,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Keeps the part below the line from the top right corner to the bottom left one.
class _DiagonalClipper extends CustomClipper<Path> {
  const _DiagonalClipper();

  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.width, 0)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();

  @override
  bool shouldReclip(_DiagonalClipper oldClipper) => false;
}
