import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/segmented_tabs.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../routing/app_router.dart';
import '../application/bible_library.dart';
import '../application/bible_position.dart';
import '../application/bible_settings.dart';
import '../domain/bible.dart';
import 'widgets/bible_versions_sheet.dart';

/// The concordance of the version read: every verse where a word is, how
/// many times, spread over the books of the Bible (a bar each, touched to
/// keep only that book), the forms found, then the verses book by book. A
/// verse opens the Bible on it. Needs the version on the phone.
@RoutePage()
class ConcordanceScreen extends HookConsumerWidget {
  const ConcordanceScreen({@QueryParam('word') this.word = '', super.key});

  final String word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final version = ref.watch(bibleVersionProvider);
    final controller = useTextEditingController(text: word);
    final text = useValueListenable(controller).text.trim();
    final debounced = useDebounced(text, const Duration(milliseconds: 300));
    // the word given opens at once
    final query = debounced ?? word.trim();
    final prefix = useState(false);
    final book = useState<String?>(null);
    useEffect(() {
      book.value = null;
      return null;
    }, [query, prefix.value]);
    final books = ref.watch(bibleBooksProvider(version.id)).value ?? const [];
    final result = query.isEmpty || text.isEmpty
        ? null
        : ref.watch(
            bibleConcordanceProvider(version.id, query, prefix: prefix.value),
          );

    Future<void> open(BibleRef place) async {
      FocusScope.of(context).unfocus();
      await ref.read(bibleFocusProvider.notifier).show(place);
      if (context.mounted) {
        context.router.popUntilRouteWithName(AppShellRoute.name);
      }
    }

    void pickForm(String form) {
      controller.text = form;
      prefix.value = false;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xs,
                AppSpacing.xs,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Row(
                children: [
                  const AppBackButton(),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      autofocus: word.isEmpty,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: t.bible.concordanceHint,
                        prefixIcon: const Icon(AppIcons.concordance),
                        suffixIcon: text.isEmpty
                            ? null
                            : IconButton(
                                tooltip: MaterialLocalizations.of(
                                  context,
                                ).deleteButtonTooltip,
                                onPressed: controller.clear,
                                icon: const Icon(AppIcons.close),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: switch (result) {
                null => _Tip(text: t.bible.concordanceTip),
                AsyncValue(hasValue: true, :final value) => switch (value) {
                  null => _Tip(
                    text: t.bible.concordanceNeedsDownload,
                    download: true,
                  ),
                  final found when found.hits.isEmpty => _Tip(
                    text: t.bible.concordanceNone,
                  ),
                  final found => _Results(
                    found: found,
                    books: books,
                    prefix: prefix.value,
                    onPrefix: (value) => prefix.value = value,
                    book: book.value,
                    onBook: (id) => book.value = id,
                    onForm: pickForm,
                    onOpen: open,
                  ),
                },
                AsyncValue(:final error?) => ErrorView(error: error),
                _ => const LoadingList(count: 6, card: false),
              },
            ),
            if (result == null)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  '${version.name} (${version.abbreviation})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Tip extends StatelessWidget {
  const _Tip({required this.text, this.download = false});

  final String text;
  final bool download;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(AppIcons.concordance, size: 44, color: tone.onSoft),
            const SizedBox(height: AppSpacing.md),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
            if (download) ...[
              const SizedBox(height: AppSpacing.lg),
              FilledButton.icon(
                onPressed: () => showBibleVersions(context),
                style: FilledButton.styleFrom(
                  backgroundColor: tone.color,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(AppIcons.downloadOffline),
                label: Text(context.t.bible.download),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// What the list shows, row by row: the summary, a book's title, a verse.
sealed class _Row {
  const _Row();
}

class _SummaryRow extends _Row {
  const _SummaryRow();
}

class _BookRow extends _Row {
  const _BookRow(this.book, this.count);

  final BibleBook book;
  final int count;
}

class _VerseRow extends _Row {
  const _VerseRow(this.hit);

  final ConcordanceHit hit;
}

class _Results extends StatelessWidget {
  const _Results({
    required this.found,
    required this.books,
    required this.prefix,
    required this.onPrefix,
    required this.book,
    required this.onBook,
    required this.onForm,
    required this.onOpen,
  });

  final Concordance found;
  final List<BibleBook> books;
  final bool prefix;
  final ValueChanged<bool> onPrefix;

  /// The book kept, null for all.
  final String? book;
  final ValueChanged<String?> onBook;
  final ValueChanged<String> onForm;
  final ValueChanged<BibleRef> onOpen;

  @override
  Widget build(BuildContext context) {
    final byId = {for (final book in books) book.id: book};
    final counts = found.byBook;
    final rows = <_Row>[const _SummaryRow()];
    String? last;
    for (final hit in found.hits) {
      if (book != null && hit.ref.book != book) {
        continue;
      }
      if (hit.ref.book != last) {
        last = hit.ref.book;
        if (byId[last] case final book?) {
          rows.add(_BookRow(book, counts[last] ?? 0));
        }
      }
      rows.add(_VerseRow(hit));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      itemCount: rows.length,
      itemBuilder: (context, index) => switch (rows[index]) {
        _SummaryRow() => _Summary(
          found: found,
          books: books,
          counts: counts,
          prefix: prefix,
          onPrefix: onPrefix,
          book: book == null ? null : byId[book],
          onBook: onBook,
          onForm: onForm,
        ),
        _BookRow(:final book, :final count) => Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 20, 24, 4),
          child: Semantics(
            header: true,
            child: Text(
              '${book.name.toUpperCase()}  ·  $count',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        _VerseRow(:final hit) => _Verse(
          hit: hit,
          label: bibleLabel(hit.ref.chapterRef, books, [?hit.ref.verse]),
          onTap: () => onOpen(hit.ref),
        ),
      },
    );
  }
}

/// The word in numbers: how many times, in how many verses, the two
/// testaments, a bar for each book, and the forms found.
class _Summary extends StatelessWidget {
  const _Summary({
    required this.found,
    required this.books,
    required this.counts,
    required this.prefix,
    required this.onPrefix,
    required this.book,
    required this.onBook,
    required this.onForm,
  });

  final Concordance found;
  final List<BibleBook> books;
  final Map<String, int> counts;
  final bool prefix;
  final ValueChanged<bool> onPrefix;
  final BibleBook? book;
  final ValueChanged<String?> onBook;
  final ValueChanged<String> onForm;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bible;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    final total = found.occurrences;
    var old = 0;
    for (final book in books) {
      if (book.oldTestament) {
        old += counts[book.id] ?? 0;
      }
    }
    // Chinese: the characters are looked for, no "starts with"
    final words = !RegExp(
      r'\p{Script=Han}',
      unicode: true,
    ).hasMatch(found.word);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (words) ...[
            SegmentedTabs(
              labels: [t.exactWord, t.startsWith],
              selectedIndex: prefix ? 1 : 0,
              onChanged: (index) => onPrefix(index == 1),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: tone.soft,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MergeSemantics(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$total',
                        style: TextStyle(
                          fontSize: 34,
                          height: 1,
                          fontWeight: FontWeight.w800,
                          color: tone.onSoft,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Flexible(
                        child: Text(
                          '${t.occurrences(n: total)} '
                          '${t.inVerses(n: found.hits.length)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: tone.onSoft,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _Testament(
                  label: t.oldTestament,
                  count: old,
                  total: total,
                  color: tone.color.withValues(alpha: 0.55),
                ),
                const SizedBox(height: AppSpacing.sm),
                _Testament(
                  label: t.newTestament,
                  count: total - old,
                  total: total,
                  color: tone.color,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  t.spread,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: tone.onSoft,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                _Spread(
                  books: books,
                  counts: counts,
                  selected: book?.id,
                  onBook: onBook,
                ),
              ],
            ),
          ),
          if (book case final book?) ...[
            const SizedBox(height: AppSpacing.md),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: InputChip(
                label: Text(
                  t.bookCount(book: book.name, n: counts[book.id] ?? 0),
                ),
                onDeleted: () => onBook(null),
                deleteIcon: const Icon(AppIcons.close, size: 18),
                deleteButtonTooltipMessage: t.allBooks,
              ),
            ),
          ],
          if (found.forms.length > 1) ...[
            const SizedBox(height: AppSpacing.lg),
            SectionLabel(t.forms, padded: false),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final (:form, :count) in found.forms.take(24))
                  ActionChip(
                    label: Text('$form · $count'),
                    onPressed: () => onForm(form),
                    side: BorderSide(color: scheme.outlineVariant),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Testament extends StatelessWidget {
  const _Testament({
    required this.label,
    required this.count,
    required this.total,
    required this.color,
  });

  final String label;
  final int count;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.bible.tone(context);

    return MergeSemantics(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: tone.onSoft),
            ),
          ),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: Stack(
                children: [
                  Container(
                    height: 8,
                    color: tone.onSoft.withValues(alpha: 0.12),
                  ),
                  FractionallySizedBox(
                    widthFactor: total == 0 ? 0 : count / total,
                    child: Container(height: 8, color: color),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 52,
            child: Text(
              '$count',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: tone.onSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A thin bar for each book of the Bible, Genesis to Revelation, as tall as
/// the word is frequent there; touching one keeps only that book.
class _Spread extends StatelessWidget {
  const _Spread({
    required this.books,
    required this.counts,
    required this.selected,
    required this.onBook,
  });

  final List<BibleBook> books;
  final Map<String, int> counts;
  final String? selected;
  final ValueChanged<String?> onBook;

  static const _height = 44.0;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bible;
    final tone = AppModule.bible.tone(context);
    final most = counts.values.fold(0, math.max);
    if (books.isEmpty || most == 0) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final book in books)
                Expanded(
                  child: _Bar(
                    book: book,
                    count: counts[book.id] ?? 0,
                    most: most,
                    selected: selected == book.id,
                    dimmed: selected != null && selected != book.id,
                    color: book.oldTestament
                        ? tone.color.withValues(alpha: 0.55)
                        : tone.color,
                    onTap: (counts[book.id] ?? 0) == 0
                        ? null
                        : () => onBook(selected == book.id ? null : book.id),
                    semanticLabel: t.bookCount(
                      book: book.name,
                      n: counts[book.id] ?? 0,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        ExcludeSemantics(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  books.first.name,
                  style: TextStyle(fontSize: 11, color: tone.onSoft),
                ),
              ),
              Text(
                books.last.name,
                style: TextStyle(fontSize: 11, color: tone.onSoft),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.book,
    required this.count,
    required this.most,
    required this.selected,
    required this.dimmed,
    required this.color,
    required this.onTap,
    required this.semanticLabel,
  });

  final BibleBook book;
  final int count;
  final int most;
  final bool selected;
  final bool dimmed;
  final Color color;
  final VoidCallback? onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.bible.tone(context);
    // the square root: a word frequent in one book still shows elsewhere
    final share = count == 0 ? 0.0 : math.sqrt(count / most);
    final height = count == 0
        ? 2.0
        : math.max(4, share * _Spread._height).toDouble();

    return Semantics(
      button: onTap != null,
      selected: selected,
      label: semanticLabel,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            decoration: BoxDecoration(
              color: count == 0
                  ? tone.onSoft.withValues(alpha: 0.15)
                  : selected
                  ? AppColors.gold
                  : color.withValues(alpha: dimmed ? color.a * 0.35 : color.a),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A verse of the concordance, the word in bold.
class _Verse extends StatelessWidget {
  const _Verse({required this.hit, required this.label, required this.onTap});

  final ConcordanceHit hit;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    final text = hit.text;
    final spans = <TextSpan>[];
    var cursor = 0;
    for (final range in hit.ranges) {
      if (range.start > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, range.start)));
      }
      spans.add(
        TextSpan(
          text: text.substring(range.start, range.end),
          style: TextStyle(fontWeight: FontWeight.w800, color: tone.onSoft),
        ),
      );
      cursor = range.end;
    }
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor)));
    }

    return ListTile(
      contentPadding: const EdgeInsetsDirectional.fromSTEB(24, 2, 24, 2),
      onTap: onTap,
      title: Text(
        label,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w800,
          color: tone.onSoft,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              color: scheme.onSurface,
            ),
            children: spans,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

/// The words of the selected verses, to open the concordance of one.
Future<void> showConcordanceWords(BuildContext context, List<String> words) =>
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheet) {
        final t = sheet.t.bible;
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(sheet).height * 0.7,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.pickWord, style: Theme.of(sheet).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    t.pickWordHelp,
                    style: TextStyle(
                      color: Theme.of(sheet).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final word in words)
                        ActionChip(
                          label: Text(word),
                          onPressed: () {
                            Navigator.of(sheet).pop();
                            context.router.push(ConcordanceRoute(word: word));
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
