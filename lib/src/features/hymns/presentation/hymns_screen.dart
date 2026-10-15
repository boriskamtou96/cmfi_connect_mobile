import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/deep_links.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/tab_page.dart';
import '../../../routing/app_router.dart';
import '../application/hymn_collections.dart';
import '../application/hymn_library.dart';
import '../domain/hymn.dart';
import '../domain/hymn_search.dart';
import '../domain/hymn_text.dart';
import 'widgets/book_cover.dart';
import 'widgets/book_picker_sheet.dart';
import 'widgets/hymn_tile.dart';
import 'widgets/number_pad_sheet.dart';

enum _HymnsView { all, favorites, recent }

/// Hymns tab, like an album: the books as covers side by side (swipe to change),
/// the chosen one's name and the number pad, then its hymns, the favorites or
/// the recent ones. The search opens in place of the title. Works offline: the
/// books are on the phone.
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
    final searching = useState(false);
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

    void closeSearch() {
      searchController.clear();
      searching.value = false;
    }

    return switch (library) {
      AsyncValue(value: final books?) when book != null => PopScope(
        canPop: !searching.value,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) {
            closeSearch();
          }
        },
        child: Scaffold(
          // the search comes in place of the album, without a spatial link
          body: FadeThroughSwitcher(
            id: searching.value,
            child: searching.value
                ? _SearchPage(
                    controller: searchController,
                    query: query,
                    book: book,
                    books: books,
                    onClose: closeSearch,
                    onOpen: open,
                  )
                : RefreshIndicator.adaptive(
                    onRefresh: refresh,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: _Album(
                            book: book,
                            books: books,
                            view: view.value,
                            onSearch: () => searching.value = true,
                            onNumberPad: openNumberPad,
                            onView: (value) => view.value = value,
                          ),
                        ),
                        _ViewList(
                          view: view.value,
                          book: book,
                          books: books,
                          onOpen: open,
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.only(bottom: AppSpacing.xl),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
      AsyncError(:final error) => TabPage(
        title: t.nav.hymns,
        child: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(hymnLibraryProvider),
        ),
      ),
      // the hymns: their number, then the title
      _ => TabPage(
        title: t.nav.hymns,
        child: const LoadingList(
          count: 8,
          leading: 46,
          round: false,
          card: false,
          padding: EdgeInsets.only(top: AppSpacing.sm),
        ),
      ),
    };
  }
}

/// The top of the tab: the title and the search, the covers, the chosen book
/// and its number pad, then the views. Tinted with the color of the book.
class _Album extends ConsumerWidget {
  const _Album({
    required this.book,
    required this.books,
    required this.view,
    required this.onSearch,
    required this.onNumberPad,
    required this.onView,
  });

  final HymnBook book;
  final List<HymnBook> books;
  final _HymnsView view;
  final VoidCallback onSearch;
  final VoidCallback onNumberPad;
  final ValueChanged<_HymnsView> onView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final module = AppModule.hymns.tone(context);
    final background = theme.scaffoldBackgroundColor;
    final colors = bookCoverColors(
      books.indexWhere((other) => other.code == book.code),
    );
    final tint = theme.brightness == Brightness.dark
        ? Color.lerp(colors.last, background, 0.2)!
        : Color.lerp(colors.first, background, 0.72)!;

    Future<void> pickBook() async {
      final code = await showBookPicker(
        context,
        books: books,
        selected: book.code,
      );
      if (code != null) {
        await ref.read(selectedHymnBookCodeProvider.notifier).select(code);
      }
    }

    return AnimatedContainer(
      duration: AppMotion.of(context, AppMotion.medium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [tint, background],
        ),
      ),
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              20,
              18,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      t.nav.hymns,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).searchFieldLabel,
                  onPressed: onSearch,
                  icon: const Icon(AppIcons.search, size: 26),
                ),
              ],
            ),
          ),
          _BookCarousel(book: book, books: books),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Semantics(
                    button: books.length > 1,
                    label: '${t.hymns.chooseBook}: ${book.title}',
                    excludeSemantics: true,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      onTap: books.length < 2 ? null : pickBook,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  // "volume 1" stays on one line
                                  book.title.replaceFirstMapped(
                                    RegExp(r' (\d+)$'),
                                    (match) => '\u00A0${match[1]}',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.3,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              if (books.length > 1) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  AppIcons.expand,
                                  size: 18,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            t.hymns.count(n: book.hymns.length),
                            style: TextStyle(
                              fontSize: 13.5,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                // the number pad, like the play button of an album
                IconButton.filled(
                  tooltip: t.hymns.openNumber,
                  style: IconButton.styleFrom(
                    fixedSize: const Size.square(56),
                    backgroundColor: module.color,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: onNumberPad,
                  icon: const Icon(AppIcons.numberPad, size: 26),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xs,
            ),
            // a long translation goes on two lines
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final (index, label) in [
                  t.hymns.tabs.all,
                  t.hymns.tabs.favorites,
                  t.hymns.tabs.recent,
                ].indexed)
                  _ViewChip(
                    label: label,
                    selected: view.index == index,
                    onTap: () => onView(_HymnsView.values[index]),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The books side by side: the chosen one in the middle, its neighbors peeking.
/// Swiping chooses the book; tapping a neighbor brings it in.
class _BookCarousel extends HookConsumerWidget {
  const _BookCarousel({required this.book, required this.books});

  final HymnBook book;
  final List<HymnBook> books;

  static const _size = 210.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = books.indexWhere((other) => other.code == book.code);
    final controller = usePageController(
      initialPage: index,
      viewportFraction: 0.56,
    );
    final duration = AppMotion.of(context, AppMotion.medium);

    // chosen elsewhere (the list of books): the covers follow
    useEffect(() {
      if (controller.hasClients && controller.page?.round() != index) {
        controller.animateToPage(
          index,
          duration: duration,
          curve: AppMotion.standard,
        );
      }
      return null;
    }, [index]);

    if (books.length < 2) {
      return Center(
        child: BookCover(book: book, colors: bookCoverColors(0), size: _size),
      );
    }
    return SizedBox(
      height: _size,
      child: PageView.builder(
        controller: controller,
        itemCount: books.length,
        onPageChanged: (page) => ref
            .read(selectedHymnBookCodeProvider.notifier)
            .select(books[page].code),
        itemBuilder: (context, page) => AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final position = controller.position.haveDimensions
                ? controller.page ?? index.toDouble()
                : index.toDouble();
            final distance = (position - page).abs().clamp(0.0, 1.0);
            return Opacity(
              opacity: 1 - distance * 0.45,
              child: Transform.scale(scale: 1 - distance * 0.14, child: child),
            );
          },
          child: Semantics(
            button: page != index,
            selected: page == index,
            label: books[page].title,
            excludeSemantics: true,
            child: GestureDetector(
              onTap: page == index
                  ? null
                  : () => controller.animateToPage(
                      page,
                      duration: duration,
                      curve: AppMotion.standard,
                    ),
              child: Center(
                child: BookCover(
                  book: books[page],
                  colors: bookCoverColors(page),
                  size: _size,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewChip extends StatelessWidget {
  const _ViewChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final module = AppModule.hymns.tone(context);
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? module.color : module.soft,
        shape: const StadiumBorder(),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: AnimatedDefaultTextStyle(
            duration: AppMotion.of(context, AppMotion.fast),
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : module.onSoft,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}

/// The hymns of the chosen view, faded in when the view changes.
class _ViewList extends HookConsumerWidget {
  const _ViewList({
    required this.view,
    required this.book,
    required this.books,
    required this.onOpen,
  });

  final _HymnsView view;
  final HymnBook book;
  final List<HymnBook> books;
  final void Function(String bookCode, int number) onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final fade = useAnimationController(
      duration: AppMotion.of(context, AppMotion.medium),
      initialValue: 1,
    );
    useEffect(() {
      fade.forward(from: 0);
      return null;
    }, [view, book.code]);

    final recents = ref.watch(recentHymnsProvider);
    // the last one opened in this book stands out, like the track playing
    final current = recents
        .where((hymnRef) => hymnRef.bookCode == book.code)
        .firstOrNull
        ?.number;

    final items = switch (view) {
      _HymnsView.all => [
        for (final hymn in book.hymns) (book: book, hymn: hymn),
      ],
      _HymnsView.favorites => _resolve(ref.watch(favoriteHymnsProvider)),
      _HymnsView.recent => _resolve(recents),
    };

    if (items.isEmpty) {
      return SliverFadeTransition(
        opacity: fade,
        sliver: SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xxl,
              40,
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
                  view == _HymnsView.favorites
                      ? t.hymns.emptyFavorites
                      : t.hymns.emptyRecent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return SliverFadeTransition(
      opacity: fade,
      sliver: SliverList.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final (:book, :hymn) = items[index];
          return _HymnRow(
            book: book,
            hymn: hymn,
            // favorites and recent ones from another book say which
            subtitle: book.code == this.book.code ? null : book.title,
            current: view == _HymnsView.all && hymn.number == current,
            onOpen: onOpen,
          );
        },
      ),
    );
  }

  List<({HymnBook book, Hymn hymn})> _resolve(List<HymnRef> refs) => [
    for (final hymnRef in refs)
      if (books.where((book) => book.code == hymnRef.bookCode).firstOrNull
          case final book?)
        if (book.hymn(hymnRef.number) case final hymn?)
          (book: book, hymn: hymn),
  ];
}

enum _RowAction { project, share, copy }

/// A hymn of the list: the star adds it to the favorites, the menu projects,
/// shares or copies its words without opening it.
class _HymnRow extends ConsumerWidget {
  const _HymnRow({
    required this.book,
    required this.hymn,
    required this.onOpen,
    this.subtitle,
    this.current = false,
  });

  final HymnBook book;
  final Hymn hymn;
  final String? subtitle;
  final bool current;
  final void Function(String bookCode, int number) onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final hymnRef = HymnRef(bookCode: book.code, number: hymn.number);
    final favorite = ref.watch(
      favoriteHymnsProvider.select((refs) => refs.contains(hymnRef)),
    );

    Future<void> toggleFavorite() async {
      HapticFeedback.lightImpact();
      final toast = ref.read(toasterProvider).of(context);
      final added = await ref
          .read(favoriteHymnsProvider.notifier)
          .toggle(hymnRef);
      toast.success(
        added ? t.hymns.reader.favoriteAdded : t.hymns.reader.favoriteRemoved,
      );
    }

    String words() =>
        hymnAsText(hymn, chorusLabel: t.hymns.chorus, bookTitle: book.title);

    Future<void> act(_RowAction action, BuildContext anchor) async {
      switch (action) {
        case _RowAction.project:
          await context.router.push(
            HymnProjectionRoute(bookCode: book.code, number: hymn.number),
          );
        case _RowAction.share:
          final box = anchor.findRenderObject() as RenderBox?;
          await ref
              .read(shareServiceProvider)
              .shareText(
                // a blank line between the last verse and the link
                HymnLink(book.code, hymn.number).under('${words()}\n'),
                subject: hymn.title,
                origin: box == null
                    ? null
                    : box.localToGlobal(Offset.zero) & box.size,
              );
        case _RowAction.copy:
          final toast = ref.read(toasterProvider).of(context);
          await Clipboard.setData(ClipboardData(text: words()));
          toast.success(t.hymns.reader.copied);
      }
    }

    return HymnTile(
      hymn: hymn,
      subtitle: subtitle,
      favorite: favorite,
      current: current,
      onTap: () => onOpen(book.code, hymn.number),
      onToggleFavorite: toggleFavorite,
      menu: Builder(
        builder: (anchor) => AdaptiveMenuButton<_RowAction>(
          tooltip: t.hymns.reader.more,
          title: hymn.title,
          icon: Icon(
            AppIcons.moreOptions,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          onSelected: (action) => act(action, anchor),
          actions: [
            for (final (action, icon, label) in [
              (_RowAction.project, AppIcons.projection, t.hymns.reader.project),
              (_RowAction.share, AppIcons.share, t.hymns.reader.share),
              (_RowAction.copy, AppIcons.copy, t.hymns.reader.copy),
            ])
              AdaptiveAction(value: action, icon: icon, label: label),
          ],
        ),
      ),
    );
  }
}

/// The search, in place of the album: the field at the top, the results under
/// it (the whole book while nothing is typed).
class _SearchPage extends StatelessWidget {
  const _SearchPage({
    required this.controller,
    required this.query,
    required this.book,
    required this.books,
    required this.onClose,
    required this.onOpen,
  });

  final TextEditingController controller;
  final String query;
  final HymnBook book;
  final List<HymnBook> books;
  final VoidCallback onClose;
  final void Function(String bookCode, int number) onOpen;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final localizations = MaterialLocalizations.of(context);
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                IconButton(
                  tooltip: localizations.backButtonTooltip,
                  onPressed: onClose,
                  icon: const Icon(AppIcons.back),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: t.hymns.searchHint,
                      prefixIcon: const Icon(AppIcons.search),
                      suffixIcon: query.isEmpty
                          ? null
                          : IconButton(
                              tooltip: localizations.deleteButtonTooltip,
                              icon: const Icon(AppIcons.close),
                              onPressed: controller.clear,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FadeThroughSwitcher(
              id: query.trim().isEmpty,
              child: query.trim().isEmpty
                  ? CustomScrollView(
                      slivers: [
                        _ViewList(
                          view: _HymnsView.all,
                          book: book,
                          books: books,
                          onOpen: onOpen,
                        ),
                      ],
                    )
                  : _SearchResults(
                      book: book,
                      books: books,
                      query: query,
                      onOpen: onOpen,
                    ),
            ),
          ),
        ],
      ),
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
