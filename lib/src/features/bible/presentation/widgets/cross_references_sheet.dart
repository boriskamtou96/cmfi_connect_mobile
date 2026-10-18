import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../application/bible_library.dart';
import '../../application/bible_position.dart';
import '../../application/bible_settings.dart';
import '../../application/cross_references.dart';
import '../../domain/bible.dart';

/// The passages linked to [verses] (« Références croisées » of the verse
/// bar), each with its words in the Bible read; a tap opens it.
Future<void> showCrossReferences(
  BuildContext context, {
  required List<BibleRef> verses,
  required String label,
}) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (sheet) => SafeArea(
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(sheet).height * 0.75,
      ),
      child: _CrossReferences(verses: verses, label: label),
    ),
  ),
);

class _CrossReferences extends ConsumerWidget {
  const _CrossReferences({required this.verses, required this.label});

  final List<BibleRef> verses;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bible;
    final scheme = Theme.of(context).colorScheme;
    final all = ref.watch(crossReferencesProvider);
    final references = all.value?.ofAll(verses);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            0,
            AppSpacing.xl,
            AppSpacing.sm,
          ),
          child: Text(
            t.crossReferencesOf(passage: label),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Flexible(
          child: switch (references) {
            null => const Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Center(child: AppSpinner()),
            ),
            [] => Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Text(
                t.noCrossReferences,
                textAlign: TextAlign.center,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
            final list => ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: list.length,
              separatorBuilder: (_, _) =>
                  Divider(height: 1, color: scheme.outlineVariant),
              itemBuilder: (_, index) => _Row(reference: list[index]),
            ),
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.md,
          ),
          child: Text(
            t.crossReferencesSource,
            style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class _Row extends ConsumerWidget {
  const _Row({required this.reference});

  final CrossReference reference;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    final version = ref.watch(bibleVersionProvider);
    final books = ref.watch(bibleBooksProvider(version.id)).value ?? const [];
    final start = reference.start;
    final chapter = ref
        .watch(bibleChapterProvider(version.id, start.book, start.chapter))
        .value;
    final wanted = reference.verses.toSet();
    final words = chapter?.items
        .whereType<BibleVerse>()
        .where((verse) => wanted.contains(verse.number))
        .map((verse) => verse.text)
        .join(' ');

    return InkWell(
      onTap: () async {
        Navigator.of(context).pop();
        await ref.read(bibleFocusProvider.notifier).show(start);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bibleLabel(start.chapterRef, books, reference.verses),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: tone.onSoft,
                    ),
                  ),
                  if (words != null && words.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      words,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'Lora', height: 1.45),
                    ),
                  ],
                ],
              ),
            ),
            Icon(AppIcons.chevronRight, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
