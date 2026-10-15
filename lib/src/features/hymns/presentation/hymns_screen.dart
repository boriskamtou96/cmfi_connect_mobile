import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/segmented_tabs.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/tab_page.dart';
import '../../../routing/app_router.dart';
import '../application/hymn_collections.dart';
import '../application/hymn_library.dart';
import '../domain/hymn.dart';
import '../domain/hymn_search.dart';
import 'widgets/book_picker_sheet.dart';
import 'widgets/hymn_tile.dart';
import 'widgets/number_pad_sheet.dart';

enum _HymnsView { all, favorites, recent }

/// Hymns tab: the chosen book, searchable by number, title or words, with favorites and
/// recently opened hymns. Works offline: the books are on the phone.
@RoutePage()
class HymnsScreen extends HookConsumerWidget {
  const HymnsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final library = ref.watch(hymnLibraryProvider);
    final book = ref.watch(selectedHymnBookProvider);
    final searchController = useTextEditingController();
    final query = useValueListenable(searchController).text;
    final view = useState(_HymnsView.all);

    void open(String bookCode, int number) {
      FocusScope.of(context).unfocus();
      context.router.push(HymnReaderRoute(bookCode: bookCode, number: number));
    }

    Future<void> openNumberPad() async {
      if (book == null) {
        return;
      }
      final number = await showNumberPad(context, book: book);
      if (number != null && context.mounted) {
        open(book.code, number);
      }
    }

    Future<void> refresh() async {
      final toast = ref.read(toasterProvider).of(context);
      try {
        final updated = await ref.read(hymnLibraryProvider.notifier).refresh();
        toast.info(updated ? t.hymns.updated : t.hymns.upToDate);
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      }
    }

    final scheme = Theme.of(context).colorScheme;

    return TabPage(
      title: t.nav.hymns,
      actions: [
        IconButton.outlined(
          tooltip: t.hymns.openNumber,
          style: IconButton.styleFrom(
            fixedSize: const Size.square(44),
            backgroundColor: scheme.surface,
            side: BorderSide(color: scheme.outlineVariant),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.md),
            ),
          ),
          onPressed: book == null ? null : openNumberPad,
          icon: const Icon(AppIcons.numberPad, size: 22),
        ),
      ],
      child: switch (library) {
        AsyncValue(value: final books?) when book != null => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: _BookButton(
                book: book,
                onTap: books.length < 2
                    ? null
                    : () async {
                        final code = await showBookPicker(
                          context,
                          books: books,
                          selected: book.code,
                        );
                        if (code != null) {
                          await ref
                              .read(selectedHymnBookCodeProvider.notifier)
                              .select(code);
                        }
                      },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: TextField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: t.hymns.searchHint,
                  prefixIcon: const Icon(AppIcons.search),
                  suffixIcon: query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).deleteButtonTooltip,
                          icon: const Icon(AppIcons.close),
                          onPressed: searchController.clear,
                        ),
                ),
              ),
            ),
            if (query.trim().isEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  0,
                ),
                child: SegmentedTabs(
                  labels: [
                    t.hymns.tabs.all,
                    t.hymns.tabs.favorites,
                    t.hymns.tabs.recent,
                  ],
                  selectedIndex: view.value.index,
                  onChanged: (index) => view.value = _HymnsView.values[index],
                ),
              ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                // typing turns the list into results (no spatial link: fade
                // through); the tabs sit side by side (shared axis)
                child: FadeThroughSwitcher(
                  id: query.trim().isEmpty,
                  child: query.trim().isNotEmpty
                      ? _SearchResults(
                          book: book,
                          books: books,
                          query: query,
                          onOpen: open,
                        )
                      : SharedAxisSwitcher(
                          index: view.value.index,
                          child: switch (view.value) {
                            _HymnsView.all => _AllHymns(
                              book: book,
                              onOpen: open,
                            ),
                            _HymnsView.favorites => _HymnRefs(
                              refs: ref.watch(favoriteHymnsProvider),
                              books: books,
                              selected: book,
                              empty: t.hymns.emptyFavorites,
                              onOpen: open,
                            ),
                            _HymnsView.recent => _HymnRefs(
                              refs: ref.watch(recentHymnsProvider),
                              books: books,
                              selected: book,
                              empty: t.hymns.emptyRecent,
                              onOpen: open,
                            ),
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(hymnLibraryProvider),
        ),
        // the hymns: their number on a tile, then the title
        _ => const LoadingList(
          count: 8,
          leading: 46,
          round: false,
          card: false,
          padding: EdgeInsets.only(top: AppSpacing.sm),
        ),
      },
    );
  }
}

/// The chosen book; opens the list of books.
class _BookButton extends StatelessWidget {
  const _BookButton({required this.book, required this.onTap});

  final HymnBook book;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final module = AppModule.hymns.tone(context);

    return Semantics(
      button: onTap != null,
      label: '${context.t.hymns.chooseBook}: ${book.title}',
      excludeSemantics: true,
      child: Material(
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: scheme.outlineVariant),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: module.soft,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: PhosphorIcon(
                    AppIcons.hymnBookTile,
                    size: 20,
                    color: module.onSoft,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        context.t.hymns.count(n: book.hymns.length),
                        style: TextStyle(
                          fontSize: 12.5,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(AppIcons.expand, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AllHymns extends ConsumerWidget {
  const _AllHymns({required this.book, required this.onOpen});

  final HymnBook book;
  final void Function(String bookCode, int number) onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteHymnsProvider).toSet();
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      itemCount: book.hymns.length,
      itemBuilder: (context, index) {
        final hymn = book.hymns[index];
        return HymnTile(
          hymn: hymn,
          favorite: favorites.contains(
            HymnRef(bookCode: book.code, number: hymn.number),
          ),
          onTap: () => onOpen(book.code, hymn.number),
        );
      },
    );
  }
}

/// Favorites or recent hymns, from any book: the others show their book's name.
class _HymnRefs extends ConsumerWidget {
  const _HymnRefs({
    required this.refs,
    required this.books,
    required this.selected,
    required this.empty,
    required this.onOpen,
  });

  final List<HymnRef> refs;
  final List<HymnBook> books;
  final HymnBook selected;
  final String empty;
  final void Function(String bookCode, int number) onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteHymnsProvider).toSet();
    final items = [
      for (final hymnRef in refs)
        if (books.where((book) => book.code == hymnRef.bookCode).firstOrNull
            case final book?)
          if (book.hymn(hymnRef.number) case final hymn?)
            (book: book, hymn: hymn),
    ];
    if (items.isEmpty) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xxl,
              48,
              AppSpacing.xxl,
              0,
            ),
            child: Column(
              children: [
                PhosphorIcon(
                  AppIcons.hymnsTile,
                  size: 40,
                  color: AppModule.hymns
                      .tone(context)
                      .onSoft
                      .withValues(alpha: 0.5),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  empty,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final (:book, :hymn) = items[index];
        return HymnTile(
          hymn: hymn,
          subtitle: book.code == selected.code ? null : book.title,
          favorite: favorites.contains(
            HymnRef(bookCode: book.code, number: hymn.number),
          ),
          onTap: () => onOpen(book.code, hymn.number),
        );
      },
    );
  }
}

class _SearchResults extends ConsumerWidget {
  const _SearchResults({
    required this.book,
    required this.books,
    required this.query,
    required this.onOpen,
  });

  final HymnBook book;
  final List<HymnBook> books;
  final String query;
  final void Function(String bookCode, int number) onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final favorites = ref.watch(favoriteHymnsProvider).toSet();
    final results = ref.watch(hymnSearchIndexProvider(book.code)).search(query);
    // words (not a number) are also looked for in the other books
    final isNumber = RegExp(
      r'^\s*(n\s*[°o.]?\s*)?\d+\s*$',
      caseSensitive: false,
    ).hasMatch(query);
    final others = isNumber
        ? const <HymnSearchResult>[]
        : [
            for (final other in books)
              if (other.code != book.code)
                ...ref
                    .watch(hymnSearchIndexProvider(other.code))
                    .search(query, limit: 15),
          ];

    if (results.isEmpty && others.isEmpty) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xxl,
              48,
              AppSpacing.xxl,
              0,
            ),
            child: Text(
              t.hymns.noResult(query: query.trim()),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      );
    }

    Widget tile(HymnSearchResult result, {bool showBook = false}) => HymnTile(
      hymn: result.hymn,
      query: query,
      subtitle: [
        if (showBook) result.book.title,
        result.snippet ?? result.hymn.firstLine,
      ].nonNulls.join(' · '),
      favorite: favorites.contains(
        HymnRef(bookCode: result.book.code, number: result.hymn.number),
      ),
      onTap: () => onOpen(result.book.code, result.hymn.number),
    );

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      children: [
        for (final result in results) tile(result),
        if (others.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.xs,
            ),
            child: SectionLabel(t.hymns.otherBooks, padded: false),
          ),
          for (final result in others) tile(result, showBook: true),
        ],
      ],
    );
  }
}
