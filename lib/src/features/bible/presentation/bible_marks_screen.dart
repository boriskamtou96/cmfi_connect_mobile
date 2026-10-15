import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/segmented_tabs.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/bible_library.dart';
import '../application/bible_marks.dart';
import '../application/bible_position.dart';
import '../application/bible_settings.dart';
import '../domain/bible.dart';
import 'widgets/chapter_view.dart';

/// "Mes versets": the verses kept, and those highlighted, the latest first.
/// One opens the Bible on it; the cross takes it out of the list.
@RoutePage()
class BibleMarksScreen extends HookConsumerWidget {
  const BibleMarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final tab = useState(0);
    final marks = ref.watch(bibleMarksProvider).values.toList()
      ..sort((a, b) => b.at.compareTo(a.at));
    final version = ref.watch(bibleVersionProvider);
    final books = ref.watch(bibleBooksProvider(version.id)).value ?? const [];
    final shown = [
      for (final mark in marks)
        if (tab.value == 0 ? mark.bookmarked : mark.color != null) mark,
    ];

    Future<void> open(BibleMark mark) async {
      await ref.read(bibleFocusProvider.notifier).show(mark.ref);
      if (context.mounted) {
        await context.router.maybePop();
      }
    }

    Future<void> remove(BibleMark mark) {
      final notifier = ref.read(bibleMarksProvider.notifier);
      final verse = [(ref: mark.ref, text: mark.text)];
      return tab.value == 0
          ? notifier.bookmark(verse, false, version: mark.version)
          : notifier.highlight(verse, null, version: mark.version);
    }

    return SubPage(
      title: t.bible.marks,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: SegmentedTabs(
              labels: [t.bible.favorites, t.bible.highlights],
              selectedIndex: tab.value,
              onChanged: (index) => tab.value = index,
            ),
          ),
          Expanded(
            child: shown.isEmpty
                ? _Empty(
                    icon: tab.value == 0
                        ? AppIcons.bookmark
                        : AppIcons.highlight,
                    text: tab.value == 0
                        ? t.bible.noFavorites
                        : t.bible.noHighlights,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.xs,
                      AppSpacing.lg,
                      AppSpacing.xl,
                    ),
                    itemCount: shown.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) => _MarkTile(
                      key: ValueKey(shown[index].key),
                      mark: shown[index],
                      label: bibleLabel(shown[index].ref.chapterRef, books, [
                        ?shown[index].ref.verse,
                      ]),
                      onOpen: () => open(shown[index]),
                      onRemove: () => remove(shown[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _MarkTile extends StatelessWidget {
  const _MarkTile({
    required this.mark,
    required this.label,
    required this.onOpen,
    required this.onRemove,
    super.key,
  });

  final BibleMark mark;
  final String label;
  final VoidCallback onOpen;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final tone = AppModule.bible.tone(context);
    final colors = highlightColors(theme.brightness);
    final color = mark.color == null || mark.color! >= colors.length
        ? null
        : colors[mark.color!];

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // the color of the highlight, as a band
              Container(width: 6, color: color ?? tone.soft),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 0, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$label · ${mark.version}',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: tone.onSoft,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        mark.text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Lora',
                          fontSize: 15.5,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: IconButton(
                  tooltip: t.bible.remove,
                  onPressed: onRemove,
                  color: scheme.onSurfaceVariant,
                  icon: const Icon(AppIcons.close, size: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppModule.bible.tone(context).soft,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: AppModule.bible.tone(context).onSoft,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
