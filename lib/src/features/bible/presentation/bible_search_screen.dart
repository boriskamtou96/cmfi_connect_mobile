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
import '../../../core/widgets/skeleton.dart';
import '../../../routing/app_router.dart';
import '../application/bible_library.dart';
import '../application/bible_position.dart';
import '../application/bible_settings.dart';
import '../domain/bible.dart';
import 'widgets/bible_versions_sheet.dart';

/// Searches the version read: a passage ("Jean 3:16", "Psaume 23") opens
/// it; words find the verses that hold them all (once the version is on the
/// phone). A result opens the Bible on its verse.
@RoutePage()
class BibleSearchScreen extends HookConsumerWidget {
  const BibleSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final version = ref.watch(bibleVersionProvider);
    final controller = useTextEditingController();
    final text = useValueListenable(controller).text.trim();
    final query = useDebounced(text, const Duration(milliseconds: 300)) ?? '';
    final books = ref.watch(bibleBooksProvider(version.id)).value ?? const [];
    final results = query.isEmpty || text.isEmpty
        ? null
        : ref.watch(bibleSearchProvider(version.id, query));

    Future<void> open(BibleRef place) async {
      FocusScope.of(context).unfocus();
      await ref.read(bibleFocusProvider.notifier).show(place);
      if (context.mounted) {
        await context.router.maybePop();
      }
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
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: t.bible.searchHint,
                        prefixIcon: const Icon(AppIcons.search),
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
              child: switch (results) {
                null => _Tip(text: t.bible.searchTip),
                AsyncValue(value: final found?) => _Results(
                  found: found,
                  query: query,
                  books: books,
                  onOpen: open,
                ),
                AsyncError(:final error) => ErrorView(error: error),
                _ => const LoadingList(count: 6, card: false),
              },
            ),
            if (results == null)
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
  const _Tip({required this.text, this.action});

  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              AppIcons.bibleTile,
              size: 44,
              color: AppModule.bible.tone(context).onSoft,
            ),
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
            if (action != null) ...[
              const SizedBox(height: AppSpacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({
    required this.found,
    required this.query,
    required this.books,
    required this.onOpen,
  });

  final BibleSearch found;
  final String query;
  final List<BibleBook> books;
  final ValueChanged<BibleRef> onOpen;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    final reference = found.reference;
    final verses = found.verses;

    if (reference == null && verses.isEmpty) {
      return found.downloaded
          ? _Tip(text: t.bible.searchNone)
          : _Tip(
              text: t.bible.searchNeedsDownload,
              action: FilledButton.icon(
                onPressed: () => showBibleVersions(context),
                style: FilledButton.styleFrom(
                  backgroundColor: tone.color,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(AppIcons.downloadOffline),
                label: Text(t.bible.download),
              ),
            );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      itemCount: verses.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          if (reference != null) {
            final label = bibleLabel(reference.chapterRef, books, [
              ?reference.verse,
            ]);
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Material(
                color: tone.soft,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  onTap: () => onOpen(reference),
                  leading: Icon(AppIcons.bibleTile, color: tone.onSoft),
                  title: Text(
                    t.bible.open(reference: label),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: tone.onSoft,
                    ),
                  ),
                  trailing: Icon(AppIcons.chevronRight, color: tone.onSoft),
                ),
              ),
            );
          }
          final count = Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 4),
            child: Text(
              verses.length >= 200
                  ? t.bible.searchLimit(n: verses.length)
                  : t.bible.searchCount(n: verses.length),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: scheme.onSurfaceVariant,
              ),
            ),
          );
          final word = query.trim();
          if (word.contains(' ')) {
            return count;
          }
          // one word: all its verses, book by book
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xs,
                ),
                child: Material(
                  color: tone.soft,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    onTap: () =>
                        context.router.push(ConcordanceRoute(word: word)),
                    leading: Icon(AppIcons.concordance, color: tone.onSoft),
                    title: Text(
                      t.bible.concordanceOf(word: word),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: tone.onSoft,
                      ),
                    ),
                    trailing: Icon(AppIcons.chevronRight, color: tone.onSoft),
                  ),
                ),
              ),
              count,
            ],
          );
        }
        final verse = verses[index - 1];
        return ListTile(
          contentPadding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 4),
          onTap: () => onOpen(verse.ref),
          title: Text(
            bibleLabel(verse.ref.chapterRef, books, [?verse.ref.verse]),
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              color: tone.onSoft,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: _Emphasized(
              verse.text,
              query: query,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: scheme.onSurface,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// [text] with the words searched in bold.
class _Emphasized extends StatelessWidget {
  const _Emphasized(this.text, {required this.query, required this.style});

  final String text;
  final String query;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    var cursor = 0;
    for (final range in bibleMatches(text, query)) {
      if (range.start > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, range.start)));
      }
      spans.add(
        TextSpan(
          text: text.substring(range.start, range.end),
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      );
      cursor = range.end;
    }
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor)));
    }
    return Text.rich(
      TextSpan(style: style, children: spans),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }
}
