import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/deep_links.dart';
import '../../../core/services/screen_awake.dart';
import '../../../core/services/share_service.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/reader/page_swipe.dart';
import '../../../core/widgets/reader/pinch_to_scale.dart';
import '../../../core/widgets/reader/reader_palette.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../routing/app_router.dart';
import '../application/hymn_collections.dart';
import '../application/hymn_library.dart';
import '../application/hymn_reader_settings.dart';
import '../domain/hymn.dart';
import '../domain/hymn_text.dart';
import 'widgets/book_cover.dart';
import 'widgets/hymn_view.dart';
import 'widgets/lyrics_share_sheet.dart';
import 'widgets/reader_settings_sheet.dart';

/// Reads a hymn. Swipe to the previous or next one, pinch or A−/A+ to resize the text,
/// "Aa" for the display options, the star for favorites. A tap on a line chooses
/// it (then others) to share as an image or as text.
@RoutePage()
class HymnReaderScreen extends HookConsumerWidget {
  const HymnReaderScreen({
    @PathParam('bookCode') required this.bookCode,
    @PathParam('number') required this.number,
    super.key,
  });

  final String bookCode;
  final int number;

  static const _pinchHintKey = 'hymn_pinch_hint_seen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final book = ref.watch(hymnBookProvider(bookCode));
    final settings = ref.watch(hymnReaderSettingsControllerProvider);
    // the color of the book (its cover's), or a page to read on
    final books = ref.watch(hymnLibraryProvider).value ?? const <HymnBook>[];
    final colors = bookCoverColors(
      books.indexWhere((other) => other.code == bookCode).clamp(0, 99),
    );
    final onBook = settings.theme == ReaderTheme.book;
    final palette = onBook
        ? ReaderPalette.onColor(colors.last)
        : ReaderPalette.of(settings.theme, Theme.of(context).brightness);
    final settingsController = ref.read(
      hymnReaderSettingsControllerProvider.notifier,
    );
    final initialIndex = book == null
        ? 0
        : book.indexOf(number).clamp(0, book.hymns.length - 1);
    final pageController = usePageController(initialPage: initialIndex);
    final current = useState(initialIndex);
    final pinching = useState(false);
    // the lines chosen to share (their places among the lines sung), while
    // choosing
    final choosing = useState(false);
    final chosen = useState(<int>{});
    final hymn = book == null || book.hymns.isEmpty
        ? null
        : book.hymns[current.value.clamp(0, book.hymns.length - 1)];

    // remembered as recently opened
    useEffect(() {
      if (hymn != null) {
        Future.microtask(
          () => ref
              .read(recentHymnsProvider.notifier)
              .opened(HymnRef(bookCode: bookCode, number: hymn.number)),
        );
      }
      return null;
    }, [hymn?.number]);

    // the screen stays on while singing
    final awake = ref.read(screenAwakeProvider);
    useEffect(() {
      awake.keepOn(on: settings.keepScreenOn);
      return () => awake.keepOn(on: false);
    }, [settings.keepScreenOn]);

    // once: tell that pinching resizes the text
    useEffect(() {
      final preferences = ref.read(sharedPreferencesProvider);
      if (!(preferences.getBool(_pinchHintKey) ?? false)) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (context.mounted) {
            ref
                .read(toasterProvider)
                .of(context)
                .info(t.hymns.reader.pinchHint);
            preferences.setBool(_pinchHintKey, true);
          }
        });
      }
      return null;
    }, const []);

    if (book == null || hymn == null) {
      return Scaffold(
        appBar: AppBar(leading: const AppBackButton()),
        // the title, then the stanzas
        body: ref.watch(hymnLibraryProvider).isLoading
            ? const LoadingDetail()
            : Center(child: Text(t.hymns.reader.notFound)),
      );
    }

    final ref0 = HymnRef(bookCode: bookCode, number: hymn.number);

    void stopChoosing() {
      choosing.value = false;
      chosen.value = {};
    }

    void toggleLine(int line) {
      HapticFeedback.selectionClick();
      choosing.value = true;
      chosen.value = chosen.value.contains(line)
          ? ({...chosen.value}..remove(line))
          : {...chosen.value, line};
    }

    Future<void> shareChosen() async {
      final all = sungLines(hymn, repeatChorus: settings.repeatChorus);
      final books = ref.read(hymnLibraryProvider).value ?? const <HymnBook>[];
      await showLyricsShare(
        context,
        book: book,
        bookColors: bookCoverColors(
          books.indexWhere((other) => other.code == book.code).clamp(0, 99),
        ),
        hymn: hymn,
        lines: [
          for (final line in chosen.value.toList()..sort())
            if (line < all.length) all[line],
        ],
      );
    }

    final favorite = ref.watch(favoriteHymnsProvider).contains(ref0);

    Future<void> toggleFavorite() async {
      HapticFeedback.lightImpact();
      final toast = ref.read(toasterProvider).of(context);
      final added = await ref.read(favoriteHymnsProvider.notifier).toggle(ref0);
      toast.success(
        added ? t.hymns.reader.favoriteAdded : t.hymns.reader.favoriteRemoved,
      );
    }

    Future<void> copy() async {
      final toast = ref.read(toasterProvider).of(context);
      await Clipboard.setData(
        ClipboardData(
          text: hymnAsText(
            hymn,
            chorusLabel: t.hymns.chorus,
            bookTitle: book.title,
          ),
        ),
      );
      toast.success(t.hymns.reader.copied);
    }

    // [anchor]: the menu button, where the iPad share sheet points from
    Future<void> share(BuildContext anchor) {
      final box = anchor.findRenderObject() as RenderBox?;
      return ref
          .read(shareServiceProvider)
          .shareText(
            // a blank line between the last verse and the link
            HymnLink(bookCode, hymn.number).under(
              '${hymnAsText(hymn, chorusLabel: t.hymns.chorus, bookTitle: book.title)}\n',
            ),
            subject: hymn.title,
            origin: box == null
                ? null
                : box.localToGlobal(Offset.zero) & box.size,
          );
    }

    final barColor = palette.text;
    // the bottom of the page, under the bar of actions
    final bottomColor = onBook
        ? Color.lerp(colors.last, Colors.black, 0.25)!
        : palette.background;

    void go(int delta) => pageController.animateToPage(
      current.value + delta,
      duration: AppMotion.of(context, AppMotion.medium),
      curve: AppMotion.standard,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: palette.brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.medium),
        // on the book: its color, lighter at the top, like a song's lyrics
        decoration: BoxDecoration(
          color: onBook ? null : palette.background,
          gradient: onBook
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.lerp(colors.first, colors.last, 0.3)!,
                    colors.last,
                    bottomColor,
                  ],
                  stops: const [0, 0.45, 1],
                )
              : null,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                IconTheme(
                  data: IconThemeData(color: barColor),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.xs,
                      AppSpacing.xs,
                      AppSpacing.xs,
                      0,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).backButtonTooltip,
                          icon: const Icon(AppIcons.chevronDown, size: 26),
                          onPressed: () => context.router.maybePop(),
                        ),
                        // the book above the number
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                book.title.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.4,
                                  color: palette.muted,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                t.hymns.number(number: hymn.number),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: palette.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Builder(
                          builder: (menuContext) =>
                              AdaptiveMenuButton<_MenuAction>(
                                tooltip: t.hymns.reader.more,
                                icon: Icon(
                                  AppIcons.moreOptions,
                                  color: barColor,
                                ),
                                onSelected: (action) => switch (action) {
                                  _MenuAction.project => context.router.push(
                                    HymnProjectionRoute(
                                      bookCode: bookCode,
                                      number: hymn.number,
                                    ),
                                  ),
                                  _MenuAction.copy => copy(),
                                  _MenuAction.share => share(menuContext),
                                  _MenuAction.shareLines =>
                                    choosing.value = true,
                                },
                                actions: [
                                  AdaptiveAction(
                                    value: _MenuAction.project,
                                    icon: AppIcons.projection,
                                    label: t.hymns.reader.project,
                                  ),
                                  AdaptiveAction(
                                    value: _MenuAction.share,
                                    icon: AppIcons.share,
                                    label: t.hymns.reader.share,
                                  ),
                                  AdaptiveAction(
                                    value: _MenuAction.shareLines,
                                    icon: AppIcons.quote,
                                    label: t.hymns.reader.shareLines,
                                  ),
                                  AdaptiveAction(
                                    value: _MenuAction.copy,
                                    icon: AppIcons.copy,
                                    label: t.hymns.reader.copy,
                                  ),
                                ],
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: PinchToScale(
                          scale: settings.textScale,
                          onScale: settingsController.preview,
                          onEnd: settingsController.save,
                          onPinching: (value) => pinching.value = value,
                          child: PageView.builder(
                            controller: pageController,
                            physics: pinching.value
                                ? const NeverScrollableScrollPhysics()
                                : null,
                            itemCount: book.hymns.length,
                            onPageChanged: (index) {
                              current.value = index;
                              stopChoosing();
                            },
                            // long press on the words to select and copy them
                            itemBuilder: (context, index) => SelectionArea(
                              key: ValueKey(
                                '${book.code}-${book.hymns[index].number}',
                              ),
                              child: PageSwipe(
                                controller: pageController,
                                enabled: !pinching.value,
                                child: HymnView(
                                  hymn: book.hymns[index],
                                  settings: settings,
                                  palette: palette,
                                  strong: onBook,
                                  chosen: index == current.value
                                      ? chosen.value
                                      : const {},
                                  onLineTap: toggleLine,
                                  padding: const EdgeInsets.fromLTRB(
                                    AppSpacing.xl,
                                    AppSpacing.md,
                                    AppSpacing.xl,
                                    140,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // the words fade under the bar
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        height: 120,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  bottomColor.withValues(alpha: 0),
                                  bottomColor,
                                ],
                                stops: const [0, 0.6],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // the actions, or the lines chosen to share
                      PositionedDirectional(
                        start: AppSpacing.md,
                        end: AppSpacing.md,
                        bottom: AppSpacing.md,
                        child: AnimatedSwitcher(
                          duration: AppMotion.of(context, AppMotion.fast),
                          child: choosing.value
                              ? _ChosenBar(
                                  count: chosen.value.length,
                                  onShare: shareChosen,
                                  onClear: stopChoosing,
                                )
                              : _ActionBar(
                                  palette: palette,
                                  onBook: onBook,
                                  favorite: favorite,
                                  onPrevious: current.value > 0
                                      ? () => go(-1)
                                      : null,
                                  onNext: current.value < book.hymns.length - 1
                                      ? () => go(1)
                                      : null,
                                  onFavorite: toggleFavorite,
                                  onDisplay: () => showReaderSettings(context),
                                  onShare: () => choosing.value = true,
                                  onProject: () => context.router.push(
                                    HymnProjectionRoute(
                                      bookCode: bookCode,
                                      number: hymn.number,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Under the words, floating: the hymn before, the star, the display, the
/// lines to share, the projection, the hymn after.
class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.palette,
    required this.onBook,
    required this.favorite,
    required this.onPrevious,
    required this.onNext,
    required this.onFavorite,
    required this.onDisplay,
    required this.onShare,
    required this.onProject,
  });

  final ReaderPalette palette;
  final bool onBook;
  final bool favorite;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final VoidCallback onFavorite;
  final VoidCallback onDisplay;
  final VoidCallback onShare;
  final VoidCallback onProject;

  @override
  Widget build(BuildContext context) {
    final t = context.t.hymns.reader;
    final color = palette.text;
    return Material(
      // a darker glass on the book, a soft card on a page
      color: onBook
          ? Colors.black.withValues(alpha: 0.26)
          : Color.alphaBlend(
              palette.text.withValues(alpha: 0.06),
              palette.background,
            ),
      elevation: onBook ? 0 : 6,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: IconTheme(
        data: IconThemeData(color: color, size: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                tooltip: t.previous,
                onPressed: onPrevious,
                disabledColor: color.withValues(alpha: 0.3),
                icon: const Icon(AppIcons.previousHymn),
              ),
              IconButton(
                tooltip: favorite ? t.removeFavorite : t.addFavorite,
                onPressed: onFavorite,
                icon: AnimatedSwitcher(
                  duration: AppMotion.of(context, AppMotion.fast),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: AppMotion.pop,
                    ),
                    child: child,
                  ),
                  child: Icon(
                    favorite ? AppIcons.starFilled : AppIcons.star,
                    key: ValueKey(favorite),
                    color: favorite ? AppColors.gold : color,
                  ),
                ),
              ),
              IconButton(
                tooltip: t.display,
                onPressed: onDisplay,
                icon: const Icon(AppIcons.textSize),
              ),
              IconButton(
                tooltip: t.shareLines,
                onPressed: onShare,
                icon: const Icon(AppIcons.share),
              ),
              IconButton(
                tooltip: t.project,
                onPressed: onProject,
                icon: const Icon(AppIcons.projection),
              ),
              IconButton(
                tooltip: t.next,
                onPressed: onNext,
                disabledColor: color.withValues(alpha: 0.3),
                icon: const Icon(AppIcons.nextHymn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _MenuAction { project, share, shareLines, copy }

/// Under the words while choosing lines: how many, "Partager", and the
/// cross that stops.
class _ChosenBar extends StatelessWidget {
  const _ChosenBar({
    required this.count,
    required this.onShare,
    required this.onClear,
  });

  final int count;
  final VoidCallback onShare;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final s = context.t.hymns.lyrics;
    final scheme = Theme.of(context).colorScheme;
    final module = AppModule.hymns.tone(context);
    return Material(
      color: scheme.surface,
      elevation: 8,
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xs,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
        ),
        child: Row(
          children: [
            IconButton(
              tooltip: s.clear,
              onPressed: onClear,
              icon: const Icon(AppIcons.close),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (count > 0)
                    Text(
                      s.chosen(n: count),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  Text(
                    s.hint,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton.icon(
              // the theme's buttons take the whole width: not in this row
              style: FilledButton.styleFrom(
                backgroundColor: module.color,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 44),
              ),
              onPressed: count == 0 ? null : onShare,
              icon: const Icon(AppIcons.share, size: 18),
              label: Text(s.share),
            ),
          ],
        ),
      ),
    );
  }
}
