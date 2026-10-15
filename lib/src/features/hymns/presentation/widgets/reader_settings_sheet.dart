import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../application/hymn_reader_settings.dart';
import 'reader_palette.dart';

/// "Aa": text size, font, background and reading options. Changes show live behind the sheet.
Future<void> showReaderSettings(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => const _ReaderSettingsSheet(),
    );

class _ReaderSettingsSheet extends ConsumerWidget {
  const _ReaderSettingsSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final settings = ref.watch(hymnReaderSettingsControllerProvider);
    final controller = ref.read(hymnReaderSettingsControllerProvider.notifier);
    final label = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
      color: scheme.onSurfaceVariant,
    );

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.hymns.reader.display,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(t.hymns.reader.textSize.toUpperCase(), style: label),
          Row(
            children: [
              ExcludeSemantics(
                child: Text(
                  'A',
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Slider.adaptive(
                  value: settings.textScale,
                  min: HymnReaderSettings.minScale,
                  max: HymnReaderSettings.maxScale,
                  divisions:
                      ((HymnReaderSettings.maxScale -
                                  HymnReaderSettings.minScale) /
                              0.1)
                          .round(),
                  label: '${(settings.textScale * 100).round()} %',
                  semanticFormatterCallback: (value) =>
                      '${(value * 100).round()} %',
                  onChanged: controller.preview,
                  onChangeEnd: (_) => controller.save(),
                ),
              ),
              ExcludeSemantics(
                child: Text(
                  'A',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(t.hymns.reader.typeface.toUpperCase(), style: label),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (final (typeface, name, family) in [
                (HymnTypeface.auto, t.hymns.reader.typefaceAuto, null),
                (
                  HymnTypeface.sans,
                  t.hymns.reader.typefaceSans,
                  AppTheme.fontFamily,
                ),
                (HymnTypeface.serif, t.hymns.reader.typefaceSerif, 'Lora'),
              ]) ...[
                if (typeface != HymnTypeface.auto)
                  const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _Choice(
                    selected: settings.typeface == typeface,
                    onTap: () => controller.update(
                      (s) => s.copyWith(typeface: typeface),
                    ),
                    child: Column(
                      children: [
                        if (family == null)
                          Text.rich(
                            const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'A',
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                  ),
                                ),
                                TextSpan(
                                  text: 'a',
                                  style: TextStyle(fontFamily: 'Lora'),
                                ),
                              ],
                            ),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),
                          )
                        else
                          Text(
                            'Aa',
                            style: TextStyle(
                              fontFamily: family,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),
                          ),
                        const SizedBox(height: 2),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (settings.typeface == HymnTypeface.auto)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                t.hymns.reader.typefaceAutoHelp,
                style: TextStyle(
                  fontSize: 12.5,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          Text(t.hymns.reader.background.toUpperCase(), style: label),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final (theme, name) in [
                (HymnReaderTheme.auto, t.hymns.reader.themeAuto),
                (HymnReaderTheme.light, t.hymns.reader.themeLight),
                (HymnReaderTheme.sepia, t.hymns.reader.themeSepia),
                (HymnReaderTheme.dark, t.hymns.reader.themeDark),
              ])
                _Swatch(
                  theme: theme,
                  name: name,
                  selected: settings.theme == theme,
                  onTap: () =>
                      controller.update((s) => s.copyWith(theme: theme)),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(
              t.hymns.reader.repeatChorus,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            value: settings.repeatChorus,
            onChanged: (value) =>
                controller.update((s) => s.copyWith(repeatChorus: value)),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(
              t.hymns.reader.keepScreenOn,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            value: settings.keepScreenOn,
            onChanged: (value) =>
                controller.update((s) => s.copyWith(keepScreenOn: value)),
          ),
        ],
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.selected,
    required this.onTap,
    required this.child,
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

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.theme,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final HymnReaderTheme theme;
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
                  color: theme == HymnReaderTheme.auto
                      ? null
                      : palette.background,
                  // auto: half light, half dark
                  gradient: theme == HymnReaderTheme.auto
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
                  child: theme == HymnReaderTheme.auto
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
