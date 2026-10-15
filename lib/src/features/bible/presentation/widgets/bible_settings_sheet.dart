import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/reader/reader_choices.dart';
import '../../../../core/widgets/reader/reader_palette.dart';
import '../../application/bible_settings.dart';

/// "Aa": text size, font, background, the words of Jesus in red. Changes
/// show live behind the sheet.
Future<void> showBibleSettings(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => const _BibleSettingsSheet(),
    );

class _BibleSettingsSheet extends ConsumerWidget {
  const _BibleSettingsSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final reader = t.hymns.reader;
    final scheme = Theme.of(context).colorScheme;
    final settings = ref.watch(bibleSettingsControllerProvider);
    final controller = ref.read(bibleSettingsControllerProvider.notifier);
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
          Text(t.bible.display, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          Text(reader.textSize.toUpperCase(), style: label),
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
                  min: BibleSettings.minScale,
                  max: BibleSettings.maxScale,
                  divisions:
                      ((BibleSettings.maxScale - BibleSettings.minScale) / 0.1)
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
          Text(reader.typeface.toUpperCase(), style: label),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (final (serif, name, family) in [
                (false, reader.typefaceSans, AppTheme.fontFamily),
                (true, reader.typefaceSerif, 'Lora'),
              ]) ...[
                if (serif) const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: ReaderChoice(
                    selected: settings.serif == serif,
                    onTap: () =>
                        controller.update((s) => s.copyWith(serif: serif)),
                    child: Column(
                      children: [
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
          const SizedBox(height: AppSpacing.lg),
          Text(reader.background.toUpperCase(), style: label),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final (theme, name) in [
                (ReaderTheme.auto, reader.themeAuto),
                (ReaderTheme.light, reader.themeLight),
                (ReaderTheme.sepia, reader.themeSepia),
                (ReaderTheme.dark, reader.themeDark),
              ])
                ReaderThemeSwatch(
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
              t.bible.jesusInRed,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(t.bible.jesusInRedHelp),
            value: settings.jesusInRed,
            onChanged: (value) =>
                controller.update((s) => s.copyWith(jesusInRed: value)),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(
              reader.keepScreenOn,
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
