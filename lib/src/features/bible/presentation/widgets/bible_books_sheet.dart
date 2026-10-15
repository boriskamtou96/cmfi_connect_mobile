import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/segmented_tabs.dart';
import '../../domain/bible.dart';

/// The books (Old or New Testament), then the chapters of the one touched:
/// the chapter chosen, or null.
Future<BibleRef?> showBibleBooks(
  BuildContext context, {
  required List<BibleBook> books,
  required BibleRef current,
}) => showModalBottomSheet<BibleRef>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  showDragHandle: true,
  builder: (context) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.9,
    minChildSize: 0.5,
    builder: (context, scroll) =>
        _BooksSheet(books: books, current: current, scroll: scroll),
  ),
);

class _BooksSheet extends HookWidget {
  const _BooksSheet({
    required this.books,
    required this.current,
    required this.scroll,
  });

  final List<BibleBook> books;
  final BibleRef current;
  final ScrollController scroll;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final theme = Theme.of(context);
    final old = [
      for (final book in books)
        if (book.oldTestament) book,
    ];
    final testaments = [
      old,
      [
        for (final book in books)
          if (!book.oldTestament) book,
      ],
    ];
    final both = testaments.every((list) => list.isNotEmpty);
    final testament = useState(
      old.any((book) => book.id == current.book) || !both ? 0 : 1,
    );
    final open = useState<String?>(current.book);
    final currentKey = useMemoized(GlobalKey.new);

    // the book read now, in view
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (currentKey.currentContext case final target?) {
          Scrollable.ensureVisible(target, alignment: 0.1);
        }
      });
      return null;
    }, const []);

    final list = both
        ? testaments[testament.value]
        : testaments.firstWhere((list) => list.isNotEmpty);

    // the title and the testaments stay; the books scroll under them
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            0,
            AppSpacing.xl,
            AppSpacing.md,
          ),
          child: Text(t.bible.books, style: theme.textTheme.titleLarge),
        ),
        if (both)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: SegmentedTabs(
              labels: [t.bible.oldTestament, t.bible.newTestament],
              selectedIndex: testament.value,
              onChanged: (index) => testament.value = index,
            ),
          ),
        Expanded(
          child: ListView(
            controller: scroll,
            padding: const EdgeInsets.only(bottom: AppSpacing.xl),
            children: [
              for (final book in list)
                _BookRow(
                  key: book.id == current.book ? currentKey : ValueKey(book.id),
                  book: book,
                  current: current,
                  open: open.value == book.id,
                  onTap: () {
                    if (book.chapters == 1) {
                      Navigator.of(context).pop(BibleRef(book.id, 1));
                    } else {
                      open.value = open.value == book.id ? null : book.id;
                    }
                  },
                  onChapter: (number) =>
                      Navigator.of(context).pop(BibleRef(book.id, number)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BookRow extends StatelessWidget {
  const _BookRow({
    required this.book,
    required this.current,
    required this.open,
    required this.onTap,
    required this.onChapter,
    super.key,
  });

  final BibleBook book;
  final BibleRef current;
  final bool open;
  final VoidCallback onTap;
  final ValueChanged<int> onChapter;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    final reading = book.id == current.book;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          expanded: book.chapters > 1 ? open : null,
          child: ListTile(
            contentPadding: const EdgeInsetsDirectional.fromSTEB(24, 0, 16, 0),
            onTap: onTap,
            title: Text(
              book.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: reading ? FontWeight.w800 : FontWeight.w600,
                color: reading ? tone.onSoft : null,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.bible.chapters(n: book.chapters),
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                if (book.chapters > 1) ...[
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: open ? 0.5 : 0,
                    duration: AppMotion.of(context, AppMotion.fast),
                    child: Icon(
                      AppIcons.chevronDown,
                      size: 18,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: AppMotion.of(context, AppMotion.medium),
          curve: AppMotion.emphasized,
          alignment: Alignment.topCenter,
          child: !open || book.chapters == 1
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const gap = 8.0;
                      final perRow = (constraints.maxWidth / 58).floor().clamp(
                        5,
                        8,
                      );
                      final width =
                          (constraints.maxWidth - gap * (perRow - 1)) / perRow;
                      return Wrap(
                        spacing: gap,
                        runSpacing: gap,
                        children: [
                          for (
                            var number = 1;
                            number <= book.chapters;
                            number++
                          )
                            _ChapterCell(
                              number: number,
                              width: width,
                              current: reading && current.chapter == number,
                              onTap: () => onChapter(number),
                            ),
                        ],
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

class _ChapterCell extends StatelessWidget {
  const _ChapterCell({
    required this.number,
    required this.width,
    required this.current,
    required this.onTap,
  });

  final int number;
  final double width;
  final bool current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    return Semantics(
      selected: current,
      child: Material(
        color: current ? tone.color : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          onTap: onTap,
          child: SizedBox(
            width: width,
            height: 44,
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: current ? Colors.white : scheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
