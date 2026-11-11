import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/adaptive_dialogs.dart';
import '../../../../core/widgets/animated_progress_bar.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../core/widgets/sub_page.dart';
import '../../../../routing/app_router.dart';
import '../../application/reading_books.dart';
import '../../domain/reading_book.dart';
import 'book_cover.dart';
import 'book_sheets.dart';

/// Profil › Mon cheminement › Mes lectures: the books finished this month,
/// this year and the pages read, a bar per month; the books being read with
/// their progress, those set aside, then the finished ones in covers.
@RoutePage()
class ReadingScreen extends ConsumerWidget {
  const ReadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.reading;
    final books = ref.watch(readingBooksProvider);

    return SubPage(
      title: t.title,
      actions: [
        IconButton.filledTonal(
          tooltip: t.add,
          onPressed: () => context.router.push(const AddBookRoute()),
          icon: const Icon(AppIcons.add),
        ),
      ],
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref
            ..invalidate(readingBooksProvider)
            ..invalidate(readingStatsProvider);
          await ref
              .read(readingBooksProvider.future)
              .then((_) {}, onError: (_) {});
        },
        child: switch (books) {
          AsyncValue(value: final list?) => _Shelf(books: list),
          AsyncError(:final error) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(readingBooksProvider),
          ),
          _ => const LoadingCards(count: 3, height: 120),
        },
      ),
    );
  }
}

class _Shelf extends StatelessWidget {
  const _Shelf({required this.books});

  final List<ReadingBook> books;

  @override
  Widget build(BuildContext context) {
    final t = context.t.reading;
    final scheme = Theme.of(context).colorScheme;
    final reading = books.where((book) => book.isReading).toList();
    final aside = books
        .where((book) => book.status == ReadingStatus.abandoned)
        .toList();
    final finished = books
        .where((book) => book.status == ReadingStatus.finished)
        .toList();

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        const _Stats(),
        const SizedBox(height: 22),
        if (books.isEmpty) ...[
          Text(
            t.empty,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.emptyText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: scheme.onSurfaceVariant),
          ),
        ],
        if (reading.isNotEmpty) ...[
          SectionLabel(t.reading),
          const SizedBox(height: 10),
          for (final book in reading) ...[
            _BookCard(book: book),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
        ],
        if (aside.isNotEmpty) ...[
          SectionLabel(t.setAside),
          const SizedBox(height: 10),
          for (final book in aside) ...[
            _BookCard(book: book),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
        ],
        if (finished.isNotEmpty) ...[
          SectionLabel(t.finished),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 14,
            crossAxisSpacing: 12,
            childAspectRatio: 0.56,
            children: [for (final book in finished) _FinishedBook(book: book)],
          ),
        ],
      ],
    );
  }
}

/// The night card: this month, this year, the pages, and a bar per month.
class _Stats extends ConsumerWidget {
  const _Stats();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.reading;
    final now = today();
    final stats = ref.watch(readingStatsProvider(now.year)).value;
    final most = stats == null
        ? 1
        : math.max(
            1,
            stats.months.fold<int>(0, (top, m) => math.max(top, m.books)),
          );
    final muted = Colors.white.withValues(alpha: 0.72);

    Widget number(String value, String label, Color color) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          Text(label, style: TextStyle(color: muted, fontSize: 12.5)),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xxl - 4),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B3B70), Color(0xFF072D5A), AppColors.night],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              number(
                '${stats?.booksIn(now.month) ?? '—'}',
                t.monthBooks(
                  n: stats?.booksIn(now.month) ?? 0,
                  month: context.formatDate(now, 'MMMM'),
                ),
                AppColors.goldLight,
              ),
              number(
                '${stats?.booksFinished ?? '—'}',
                t.inYear(year: '${now.year}'),
                Colors.white,
              ),
              number(
                '${stats?.pages ?? '—'}',
                t.pagesRead,
                const Color(0xFFD9BCEB),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Semantics(
            label: [
              t.chart(year: '${now.year}'),
              for (var month = 1; month <= now.month; month++)
                t.chartMonth(
                  n: stats?.booksIn(month) ?? 0,
                  month: context.formatDate(DateTime(now.year, month), 'MMMM'),
                ),
            ].join(', '),
            excludeSemantics: true,
            child: Column(
              children: [
                SizedBox(
                  height: 72,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (var month = 1; month <= 12; month++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOutCubic,
                              height: month > now.month
                                  ? 4
                                  : math.max(
                                      4,
                                      72 * (stats?.booksIn(month) ?? 0) / most,
                                    ),
                              decoration: BoxDecoration(
                                color: month == now.month
                                    ? AppColors.goldLight
                                    : month > now.month
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : const Color(0xFF4E8BC9),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(5),
                                  bottom: Radius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    for (var month = 1; month <= 12; month++)
                      Expanded(
                        child: Text(
                          context
                              .formatDate(DateTime(now.year, month), 'MMMMM')
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: month == now.month
                                ? AppColors.goldLight
                                : muted,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookCard extends ConsumerWidget {
  const _BookCard({required this.book});

  final ReadingBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.reading;
    final scheme = Theme.of(context).colorScheme;

    return SectionCard(
      children: [
        InkWell(
          onTap: () => showBookActions(context, ref, book),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                BookCover(
                  title: book.title,
                  coverUrl: book.coverUrl,
                  width: 50,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (book.author.isNotEmpty)
                        Text(
                          book.author,
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      const SizedBox(height: 8),
                      AnimatedProgressBar(
                        value: book.progress,
                        minHeight: 7,
                        color: scheme.primary,
                        backgroundColor: scheme.outlineVariant,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        t.page(page: book.pageReached, total: book.totalPages),
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(AppIcons.moreOptions, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FinishedBook extends ConsumerWidget {
  const _FinishedBook({required this.book});

  final ReadingBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.reading;
    final finishedOn = book.finishedOn;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => showBookActions(context, ref, book),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => BookCover(
              title: book.title,
              coverUrl: book.coverUrl,
              width: constraints.maxWidth,
              showTitle: true,
            ),
          ),
          const SizedBox(height: 6),
          if (finishedOn != null)
            Text(
              t.finishedOn(date: context.formatDate(finishedOn, 'd MMM')),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

/// What can be done with a book: finish it, set it aside, read it again,
/// remove it.
Future<void> showBookActions(
  BuildContext context,
  WidgetRef ref,
  ReadingBook book,
) async {
  final t = context.t.reading;
  final toast = ref.read(toasterProvider).of(context);
  final texts = context.t;
  final notifier = ref.read(readingBooksProvider.notifier);

  final action = await showModalBottomSheet<String>(
    context: context,
    useSafeArea: true,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              book.title,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              t.page(page: book.pageReached, total: book.totalPages),
            ),
          ),
          ListTile(
            leading: const Icon(AppIcons.edit),
            title: Text(t.edit),
            onTap: () => Navigator.of(context).pop('edit'),
          ),
          if (book.isReading) ...[
            ListTile(
              leading: const Icon(AppIcons.checkCircle),
              title: Text(t.markFinished),
              onTap: () => Navigator.of(context).pop('finish'),
            ),
            ListTile(
              leading: const Icon(AppIcons.book),
              title: Text(t.putAside),
              onTap: () => Navigator.of(context).pop('aside'),
            ),
          ] else
            ListTile(
              leading: const Icon(AppIcons.book),
              title: Text(t.readAgain),
              onTap: () => Navigator.of(context).pop('again'),
            ),
          ListTile(
            leading: Icon(
              AppIcons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              t.remove,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () => Navigator.of(context).pop('remove'),
          ),
        ],
      ),
    ),
  );
  if (action == null || !context.mounted) {
    return;
  }

  try {
    switch (action) {
      case 'edit':
        await showEditBookSheet(context, book);
      case 'finish':
        await notifier.setStatus(book.id, ReadingStatus.finished);
        toast.success(t.finishedToast);
      case 'aside':
        await notifier.setStatus(book.id, ReadingStatus.abandoned);
      case 'again':
        await notifier.setStatus(book.id, ReadingStatus.reading);
      case 'remove':
        final sure = await showConfirmDialog(
          context,
          title: t.removeTitle,
          text: t.removeText(title: book.title),
          confirmLabel: t.remove,
          destructive: true,
        );
        if (sure) {
          await notifier.delete(book.id);
        }
    }
  } on AppException catch (error) {
    toast.error(userMessageFor(error, texts));
  }
}
