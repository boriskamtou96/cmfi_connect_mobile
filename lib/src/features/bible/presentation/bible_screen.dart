import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/deep_links.dart';
import '../../../core/services/screen_awake.dart';
import '../../../core/services/share_service.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/reader/pinch_to_scale.dart';
import '../../../core/widgets/reader/reader_palette.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/tab_page.dart';
import '../../../routing/app_router.dart';
import '../application/bible_library.dart';
import '../application/bible_listening.dart';
import '../application/bible_marks.dart';
import '../application/bible_position.dart';
import '../application/bible_reading.dart';
import '../application/bible_settings.dart';
import '../application/memory_verses.dart';
import '../domain/bible.dart';
import '../domain/bible_version.dart';
import 'concordance_screen.dart';
import 'widgets/bible_books_sheet.dart';
import 'widgets/bible_settings_sheet.dart';
import 'widgets/bible_versions_sheet.dart';
import 'widgets/chapter_view.dart';
import 'widgets/cross_references_sheet.dart';
import 'widgets/verse_actions.dart';

/// The Bible tab: the chapter read last, in the version of the app's
/// language (or the one chosen). Swipe to the next or previous chapter; the
/// book and the version open their lists; a tap on verses selects them to
/// highlight, keep, copy or share. The chapters read stay on the phone.
@RoutePage()
class BibleScreen extends ConsumerWidget {
  const BibleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final version = ref.watch(bibleVersionProvider);
    final books = ref.watch(bibleBooksProvider(version.id));

    return switch (books) {
      AsyncValue(value: final list?) when list.isNotEmpty => _Reader(
        key: ValueKey(version.id),
        version: version,
        books: list,
      ),
      AsyncError(:final error) => TabPage(
        title: t.bible.title,
        actions: [
          TextButton(
            onPressed: () => showBibleVersions(context),
            child: Text(version.abbreviation),
          ),
        ],
        child: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(bibleBooksProvider(version.id)),
        ),
      ),
      // the book and its chapter, then the verses
      _ => TabPage(title: t.bible.title, child: const LoadingDetail()),
    };
  }
}

class _Reader extends HookConsumerWidget {
  const _Reader({required this.version, required this.books, super.key});

  final BibleVersion version;
  final List<BibleBook> books;

  static const _tapHintKey = 'bible_tap_hint_seen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final settings = ref.watch(bibleSettingsControllerProvider);
    final settingsController = ref.read(
      bibleSettingsControllerProvider.notifier,
    );
    final palette = ReaderPalette.of(
      settings.theme,
      Theme.of(context).brightness,
    ).withAccent(AppTones.light.bible.onSoft, AppTones.dark.bible.onSoft);
    final pages = useMemoized(
      () => [
        for (final book in books)
          for (var number = 1; number <= book.chapters; number++)
            BibleRef(book.id, number),
      ],
      [books],
    );
    final position = ref.watch(biblePositionProvider);
    final index = max(0, pages.indexOf(position));
    final current = pages[index];
    final controller = usePageController(initialPage: index);
    final pinching = useState(false);
    final selected = useState(<int>{});
    final focus = ref.watch(bibleFocusProvider);

    // the chapter changed elsewhere (a verse opened, the list of books):
    // after this frame, as the jump says which page is read now
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted &&
            controller.hasClients &&
            (controller.page?.round() ?? index) != index) {
          controller.jumpToPage(index);
        }
        if (context.mounted) {
          selected.value = {};
        }
      });
      return null;
    }, [index]);

    // the screen stays on while reading, the Bible tab in view
    final tabs = AutoTabsRouter.of(context, watch: true);
    final inView = tabs.current.name == context.routeData.name;
    final awake = ref.read(screenAwakeProvider);
    useEffect(() {
      awake.keepOn(on: settings.keepScreenOn && inView);
      return () => awake.keepOn(on: false);
    }, [settings.keepScreenOn, inView]);

    // once: tell what a tap on a verse does
    useEffect(() {
      final preferences = ref.read(sharedPreferencesProvider);
      if (!(preferences.getBool(_tapHintKey) ?? false)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ref.read(toasterProvider).of(context).info(t.bible.tapHint);
            unawaited(preferences.setBool(_tapHintKey, true));
          }
        });
      }
      return null;
    }, const []);

    void goTo(int page) {
      if (page < 0 || page >= pages.length) {
        return;
      }
      unawaited(
        controller.animateToPage(
          page,
          duration: AppMotion.of(context, AppMotion.medium),
          curve: AppMotion.standard,
        ),
      );
    }

    List<BibleVerse> selectedVerses() {
      final chapter = ref
          .read(bibleChapterProvider(version.id, current.book, current.chapter))
          .value;
      return [
        for (final verse in chapter?.verses ?? const <BibleVerse>[])
          if (selected.value.contains(verse.number)) verse,
      ];
    }

    List<({BibleRef ref, String text})> marked(List<BibleVerse> verses) => [
      for (final verse in verses)
        (
          ref: BibleRef(current.book, current.chapter, verse.number),
          text: verse.text,
        ),
    ];

    String label(List<BibleVerse> verses) =>
        bibleLabel(current, books, [for (final verse in verses) verse.number]);

    // "16 Car Dieu… 17 Dieu, en effet…", then "Jean 3:16-17 (LSG)"
    String asText(List<BibleVerse> verses) {
      final words = verses.length == 1
          ? verses.single.text
          : verses.map((verse) => '${verse.number} ${verse.text}').join(' ');
      return '$words\n${label(verses)} (${version.abbreviation})';
    }

    Future<void> act(VerseAction action, [BuildContext? anchor]) async {
      final verses = selectedVerses();
      if (verses.isEmpty) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final marks = ref.read(bibleMarksProvider.notifier);
      selected.value = {};
      switch (action) {
        case HighlightVerses(:final color):
          HapticFeedback.selectionClick();
          await marks.highlight(
            marked(verses),
            color,
            version: version.abbreviation,
          );
        case BookmarkVerses(:final add):
          HapticFeedback.lightImpact();
          await marks.bookmark(
            marked(verses),
            add,
            version: version.abbreviation,
          );
          toast.success(add ? t.bible.favoriteAdded : t.bible.favoriteRemoved);
        case ConcordanceVerses():
          final words = concordanceWords(
            verses.map((verse) => verse.text).join(' '),
          );
          if (words.isEmpty) {
            await context.router.push(ConcordanceRoute());
          } else if (context.mounted) {
            await showConcordanceWords(context, words);
          }
        case CrossReferenceVerses():
          await showCrossReferences(
            context,
            verses: [for (final (:ref, text: _) in marked(verses)) ref],
            label: label(verses),
          );
        case MemorizeVerses():
          final numbers = [for (final verse in verses) verse.number];
          final added = await ref
              .read(memoryVersesProvider.notifier)
              .add(
                book: current.book,
                chapter: current.chapter,
                first: numbers.reduce(min),
                last: numbers.reduce(max),
                label: label(verses),
                text: verses.map((verse) => verse.text).join(' '),
                version: version.abbreviation,
              );
          HapticFeedback.lightImpact();
          if (added) {
            toast.success(t.memorize.added);
          } else {
            toast.info(t.memorize.already);
          }
        case CopyVerses():
          await Clipboard.setData(ClipboardData(text: asText(verses)));
          toast.success(t.bible.copied);
        case ShareVerses():
          final box = anchor?.findRenderObject() as RenderBox?;
          final first = verses.first.number;
          await ref
              .read(shareServiceProvider)
              .shareText(
                BibleLink(
                  BibleRef(current.book, current.chapter, first).key,
                ).under(asText(verses)),
                subject: label(verses),
                origin: box == null
                    ? null
                    : box.localToGlobal(Offset.zero) & box.size,
              );
      }
    }

    final download = ref.watch(bibleDownloadProvider(version.id)).value;
    final selectedNow = selectedVerses();
    final marks = ref.watch(bibleMarksProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: palette.brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.medium),
        color: palette.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _TopBar(
                  version: version,
                  books: books,
                  current: current,
                  palette: palette,
                  downloaded: download?.downloaded ?? false,
                  onBook: () async {
                    final chosen = await showBibleBooks(
                      context,
                      books: books,
                      current: current,
                    );
                    if (chosen != null) {
                      await ref
                          .read(biblePositionProvider.notifier)
                          .set(chosen);
                    }
                  },
                ),
                if (download?.progress case final progress?)
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 2,
                    color: palette.accent,
                    backgroundColor: palette.accent.withValues(alpha: 0.15),
                  ),
                Expanded(
                  child: Stack(
                    children: [
                      PinchToScale(
                        scale: settings.textScale,
                        onScale: settingsController.preview,
                        onEnd: settingsController.save,
                        onPinching: (value) => pinching.value = value,
                        child: PageView.builder(
                          controller: controller,
                          physics: pinching.value
                              ? const NeverScrollableScrollPhysics()
                              : null,
                          itemCount: pages.length,
                          onPageChanged: (page) => unawaited(
                            ref
                                .read(biblePositionProvider.notifier)
                                .set(pages[page]),
                          ),
                          itemBuilder: (context, page) => _ChapterPage(
                            key: ValueKey(pages[page]),
                            version: version,
                            place: pages[page],
                            books: books,
                            settings: settings,
                            palette: palette,
                            selected: page == index ? selected.value : const {},
                            focus:
                                focus != null &&
                                    focus.chapterRef == pages[page] &&
                                    page == index
                                ? focus.verse
                                : null,
                            onFocused: ref
                                .read(bibleFocusProvider.notifier)
                                .clear,
                            onTapVerse: (verse) {
                              HapticFeedback.selectionClick();
                              final next = {...selected.value};
                              if (!next.remove(verse.number)) {
                                next.add(verse.number);
                              }
                              selected.value = next;
                            },
                            onPrevious: page == 0 ? null : () => goTo(page - 1),
                            onNext: page == pages.length - 1
                                ? null
                                : () => goTo(page + 1),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        start: 0,
                        end: 0,
                        bottom: 0,
                        child: AnimatedSwitcher(
                          duration: AppMotion.of(context, AppMotion.medium),
                          switchInCurve: AppMotion.emphasized,
                          transitionBuilder: (child, animation) =>
                              SlideTransition(
                                position: animation.drive(
                                  Tween(
                                    begin: const Offset(0, 1),
                                    end: Offset.zero,
                                  ),
                                ),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              ),
                          child: selectedNow.isEmpty
                              ? _ListeningBar(books: books, palette: palette)
                              : VerseActions(
                                  label: label(selectedNow),
                                  palette: palette,
                                  colors: {
                                    for (final verse in selectedNow)
                                      marks[BibleRef(
                                            current.book,
                                            current.chapter,
                                            verse.number,
                                          ).key]
                                          ?.color,
                                  },
                                  bookmarked: selectedNow.every(
                                    (verse) =>
                                        marks[BibleRef(
                                              current.book,
                                              current.chapter,
                                              verse.number,
                                            ).key]
                                            ?.bookmarked ??
                                        false,
                                  ),
                                  onAction: act,
                                  onClose: () => selected.value = {},
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

enum _MenuAction { plan, memory, marks, concordance, download, display }

/// While the Bible is read aloud: the place heard ("Jean 3 · verset 5"),
/// pause / resume, and the cross that stops it. Nothing otherwise.
class _ListeningBar extends ConsumerWidget {
  const _ListeningBar({required this.books, required this.palette});

  final List<BibleBook> books;
  final ReaderPalette palette;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listening = ref.watch(bibleListeningProvider);
    if (listening == null) {
      return const SizedBox.shrink();
    }
    final t = context.t;
    final notifier = ref.read(bibleListeningProvider.notifier);
    final place = listening.chapter;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Material(
        color: AppColors.primaryDeep,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 6, 6),
          child: Row(
            children: [
              const Icon(
                AppIcons.listening,
                color: AppColors.goldLight,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  t.bible.listeningAt(
                    place: bibleLabel(place, books),
                    verse: listening.verse,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                tooltip: listening.playing
                    ? t.reports.timer.pause
                    : t.reports.timer.resume,
                color: Colors.white,
                onPressed: listening.playing ? notifier.pause : notifier.resume,
                icon: Icon(listening.playing ? AppIcons.pause : AppIcons.play),
              ),
              IconButton(
                tooltip: t.bible.stopListening,
                color: AppColors.onPrimaryMuted,
                onPressed: notifier.stop,
                icon: const Icon(AppIcons.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "Jean 3 ▾ | LSG ▾", then the search, "Aa" and the menu.
class _TopBar extends ConsumerWidget {
  const _TopBar({
    required this.version,
    required this.books,
    required this.current,
    required this.palette,
    required this.downloaded,
    required this.onBook,
  });

  final BibleVersion version;
  final List<BibleBook> books;
  final BibleRef current;
  final ReaderPalette palette;
  final bool downloaded;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final pill = palette.text.withValues(alpha: 0.07);
    final label = TextStyle(
      fontFamily: AppTheme.fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.2,
      color: palette.text,
    );

    Future<void> download() async {
      final toast = ref.read(toasterProvider).of(context);
      try {
        await ref.read(bibleDownloadProvider(version.id).notifier).download();
        toast.success(t.bible.downloadDone(version: version.name));
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      }
    }

    return IconTheme(
      data: IconThemeData(color: palette.text),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.xs,
          AppSpacing.xs,
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Material(
                  color: pill,
                  shape: const StadiumBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Semantics(
                          button: true,
                          label:
                              '${t.bible.books}: ${bibleLabel(current, books)}',
                          excludeSemantics: true,
                          child: InkWell(
                            onTap: onBook,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                16,
                                10,
                                10,
                                10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      bibleLabel(current, books),
                                      overflow: TextOverflow.ellipsis,
                                      style: label,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    AppIcons.expand,
                                    size: 16,
                                    color: palette.muted,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 22,
                        color: palette.text.withValues(alpha: 0.12),
                      ),
                      Semantics(
                        button: true,
                        label: '${t.bible.version}: ${version.name}',
                        excludeSemantics: true,
                        child: InkWell(
                          onTap: () => showBibleVersions(context),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              10,
                              10,
                              14,
                              10,
                            ),
                            child: Text(
                              version.abbreviation,
                              style: label.copyWith(
                                fontWeight: FontWeight.w700,
                                color: palette.accent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // the chapter read aloud by the phone's voice
            IconButton(
              tooltip: t.bible.listen,
              icon: Icon(
                ref.watch(bibleListeningProvider) == null
                    ? AppIcons.listen
                    : AppIcons.listening,
              ),
              onPressed: () => ref.read(bibleListeningProvider.notifier).start([
                current.chapterRef,
              ]),
            ),
            IconButton(
              tooltip: t.bible.search,
              icon: const Icon(AppIcons.search),
              onPressed: () => context.router.push(const BibleSearchRoute()),
            ),
            IconButton(
              tooltip: t.bible.display,
              icon: const Icon(AppIcons.textSize),
              onPressed: () => showBibleSettings(context),
            ),
            AdaptiveMenuButton<_MenuAction>(
              tooltip: t.bible.more,
              icon: Icon(AppIcons.moreOptions, color: palette.text),
              onSelected: (action) => switch (action) {
                _MenuAction.plan => context.router.push(const BiblePlanRoute()),
                _MenuAction.marks => context.router.push(
                  const BibleMarksRoute(),
                ),
                _MenuAction.memory => context.router.push(const MemoryRoute()),
                _MenuAction.concordance => context.router.push(
                  ConcordanceRoute(),
                ),
                _MenuAction.download => download(),
                _MenuAction.display => showBibleSettings(context),
              },
              actions: [
                AdaptiveAction(
                  value: _MenuAction.plan,
                  icon: AppIcons.readingPlan,
                  label: t.biblePlan.title,
                ),
                AdaptiveAction(
                  value: _MenuAction.memory,
                  icon: AppIcons.memorize,
                  label: t.memorize.menu,
                ),
                AdaptiveAction(
                  value: _MenuAction.marks,
                  icon: AppIcons.bookmark,
                  label: t.bible.marks,
                ),
                AdaptiveAction(
                  value: _MenuAction.concordance,
                  icon: AppIcons.concordance,
                  label: t.bible.concordance,
                ),
                if (!downloaded)
                  AdaptiveAction(
                    value: _MenuAction.download,
                    icon: AppIcons.downloadOffline,
                    label: t.bible.download,
                  ),
                AdaptiveAction(
                  value: _MenuAction.display,
                  icon: AppIcons.textSize,
                  label: t.bible.display,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// One chapter: loaded (from the phone, else the network), then read.
class _ChapterPage extends ConsumerWidget {
  const _ChapterPage({
    required this.version,
    required this.place,
    required this.books,
    required this.settings,
    required this.palette,
    required this.selected,
    required this.focus,
    required this.onFocused,
    required this.onTapVerse,
    required this.onPrevious,
    required this.onNext,
    super.key,
  });

  final BibleVersion version;
  final BibleRef place;
  final List<BibleBook> books;
  final BibleSettings settings;
  final ReaderPalette palette;
  final Set<int> selected;
  final int? focus;
  final VoidCallback onFocused;
  final ValueChanged<BibleVerse> onTapVerse;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final provider = bibleChapterProvider(
      version.id,
      place.book,
      place.chapter,
    );
    final chapter = ref.watch(provider);

    return switch (chapter) {
      AsyncValue(value: final chapter?) => ChapterView(
        version: version,
        chapter: chapter,
        bookName: books.nameOf(place.book),
        settings: settings,
        palette: palette,
        selected: selected,
        onTapVerse: onTapVerse,
        focus: focus,
        onFocused: onFocused,
        footer: _ChapterFooter(
          version: version,
          place: place,
          books: books,
          palette: palette,
          onPrevious: onPrevious,
          onNext: onNext,
        ),
      ),
      AsyncError(:final error) => _ChapterError(
        message: switch (error) {
          NetworkException() => t.bible.offline,
          ApiException(status: 404) => t.bible.notInVersion,
          _ => userMessageFor(error, t),
        },
        version: version,
        palette: palette,
        onRetry: () => ref.invalidate(provider),
      ),
      _ => const LoadingDetail(padding: EdgeInsets.fromLTRB(24, 16, 24, 0)),
    };
  }
}

/// Under the last verse: "J'ai lu ce chapitre", the chapters around, and the
/// version (with the credit its licence asks for).
class _ChapterFooter extends HookConsumerWidget {
  const _ChapterFooter({
    required this.version,
    required this.place,
    required this.books,
    required this.palette,
    required this.onPrevious,
    required this.onNext,
  });

  final BibleVersion version;
  final BibleRef place;
  final List<BibleBook> books;
  final ReaderPalette palette;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final read = ref.watch(bibleReadingProvider).contains(place.key);
    final busy = useState(false);
    final accent = AppModule.bible.tone(context);

    Future<void> toggle() async {
      final toast = ref.read(toasterProvider).of(context);
      final reading = ref.read(bibleReadingProvider.notifier);
      busy.value = true;
      try {
        if (read) {
          await reading.unmark(place);
          toast.info(t.bible.removedFromReport);
        } else {
          HapticFeedback.mediumImpact();
          final total = await reading.markRead(place);
          if (total == null) {
            toast.error(t.bible.noReadingItem);
          } else {
            toast.success(t.bible.addedToReport(n: total));
          }
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    // the chevrons point the way the version reads
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final muted = TextStyle(
      fontFamily: AppTheme.fontFamily,
      fontSize: 12,
      height: 1.4,
      color: palette.muted,
    );

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Semantics(
              hint: read ? null : t.bible.markReadHint,
              child: AnimatedSwitcher(
                duration: AppMotion.of(context, AppMotion.fast),
                child: read
                    ? FilledButton.icon(
                        key: const ValueKey(true),
                        onPressed: busy.value ? null : toggle,
                        style: FilledButton.styleFrom(
                          backgroundColor: accent.color,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 48),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          shape: const StadiumBorder(),
                        ),
                        icon: const Icon(AppIcons.done, size: 20),
                        label: Text(t.bible.markedRead),
                      )
                    : OutlinedButton.icon(
                        key: const ValueKey(false),
                        onPressed: busy.value ? null : toggle,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: palette.accent,
                          side: BorderSide(
                            color: palette.accent.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                          minimumSize: const Size(0, 48),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          shape: const StadiumBorder(),
                        ),
                        icon: busy.value
                            ? AppSpinner(color: palette.accent, size: 18)
                            : const Icon(AppIcons.bible, size: 20),
                        label: Text(t.bible.markRead),
                      ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              IconButton(
                tooltip: t.bible.previous,
                onPressed: onPrevious,
                color: palette.text,
                disabledColor: palette.muted.withValues(alpha: 0.3),
                icon: Icon(rtl ? AppIcons.chevronRight : AppIcons.chevronLeft),
              ),
              Expanded(
                child: Text(
                  '${version.name} (${version.abbreviation})',
                  textAlign: TextAlign.center,
                  style: muted,
                ),
              ),
              IconButton(
                tooltip: t.bible.next,
                onPressed: onNext,
                color: palette.text,
                disabledColor: palette.muted.withValues(alpha: 0.3),
                icon: Icon(rtl ? AppIcons.chevronLeft : AppIcons.chevronRight),
              ),
            ],
          ),
          if (version.attribution case final credit?)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Text(credit, textAlign: TextAlign.center, style: muted),
            ),
        ],
      ),
    );
  }
}

/// A chapter that couldn't load: without network and not yet on the phone,
/// most of the time.
class _ChapterError extends ConsumerWidget {
  const _ChapterError({
    required this.message,
    required this.version,
    required this.palette,
    required this.onRetry,
  });

  final String message;
  final BibleVersion version;
  final ReaderPalette palette;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final downloading =
        ref.watch(bibleDownloadProvider(version.id)).value?.progress != null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(AppIcons.downloadOffline, size: 40, color: palette.muted),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: palette.text, height: 1.4),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(foregroundColor: palette.accent),
              child: Text(t.common.retry),
            ),
            TextButton(
              onPressed: downloading ? null : () => showBibleVersions(context),
              style: TextButton.styleFrom(foregroundColor: palette.accent),
              child: Text(t.bible.download),
            ),
          ],
        ),
      ),
    );
  }
}
