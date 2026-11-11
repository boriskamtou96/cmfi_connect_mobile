import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../routing/app_router.dart';
import '../../application/reading_books.dart';
import '../../domain/reading_book.dart';
import 'book_cover.dart';

/// « Modifier »: the title, the author or the pages of [book] corrected
/// (another title or author finds its cover again).
Future<void> showEditBookSheet(BuildContext context, ReadingBook book) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _EditBook(book: book),
    );

class _EditBook extends HookConsumerWidget {
  const _EditBook({required this.book});

  final ReadingBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.reading;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final title = useTextEditingController(text: book.title);
    final author = useTextEditingController(text: book.author);
    final pages = useTextEditingController(text: '${book.totalPages}');
    final saving = useState(false);

    Future<void> save() async {
      if (!(formKey.currentState?.validate() ?? false) || saving.value) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final texts = context.t;
      saving.value = true;
      try {
        await ref
            .read(readingBooksProvider.notifier)
            .edit(
              book,
              title: title.text,
              author: author.text,
              totalPages: int.parse(pages.text),
            );
        toast.success(t.saved);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      } on AppException catch (error) {
        toast.error(userMessageFor(error, texts));
        if (context.mounted) {
          saving.value = false;
        }
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(t.editTitle, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.lg),
              LabeledField(
                label: t.fieldTitle,
                child: TextFormField(
                  controller: title,
                  maxLength: 300,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(counterText: ''),
                  validator: (value) =>
                      (value ?? '').trim().isEmpty ? t.titleRequired : null,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              LabeledField(
                label: t.fieldAuthor,
                child: TextFormField(
                  controller: author,
                  maxLength: 200,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(counterText: ''),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              LabeledField(
                label: t.fieldPages,
                child: TextFormField(
                  controller: pages,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => save(),
                  validator: (value) {
                    final n = int.tryParse(value ?? '');
                    return n == null || n < 1 || n > 20000
                        ? t.pagesRequired
                        : null;
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: t.save,
                isLoading: saving.value,
                onPressed: save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// « Quel livre lis-tu ? »: the books being read, [selectedId] ticked, and
/// « Ajouter un livre ». The book chosen or added; null when closed.
Future<ReadingBook?> showBookPicker(BuildContext context, {int? selectedId}) =>
    showModalBottomSheet<ReadingBook>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _BookPicker(selectedId: selectedId),
    );

class _BookPicker extends ConsumerWidget {
  const _BookPicker({this.selectedId});

  final int? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.reading;
    final scheme = Theme.of(context).colorScheme;
    final books = [
      for (final book
          in ref.watch(readingBooksProvider).value ?? const <ReadingBook>[])
        if (book.isReading || book.id == selectedId) book,
    ];

    Future<void> add() async {
      final book = await context.router.push<ReadingBook>(const AddBookRoute());
      if (book != null && context.mounted) {
        Navigator.of(context).pop(book);
      }
    }

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.pick, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final book in books)
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    leading: BookCover(
                      title: book.title,
                      coverUrl: book.coverUrl,
                      width: 34,
                    ),
                    title: Text(
                      book.title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      [
                        if (book.author.isNotEmpty) book.author,
                        t.page(page: book.pageReached, total: book.totalPages),
                      ].join(' · '),
                    ),
                    trailing: book.id == selectedId
                        ? Icon(
                            AppIcons.checkCircleFilled,
                            color: scheme.primary,
                          )
                        : null,
                    onTap: () => Navigator.of(context).pop(book),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: add,
            icon: const Icon(AppIcons.add),
            label: Text(t.add),
          ),
        ],
      ),
    );
  }
}

/// « Tu as fini ce livre ? », on the night blue: true when the member says
/// yes. [monthCount]: the books they will have finished this month with it.
Future<bool> showBookFinishedSheet(
  BuildContext context, {
  required ReadingBook book,
  required int pageReached,
  required int monthCount,
  DateTime? month,
}) async {
  final answer = await showModalBottomSheet<bool>(
    context: context,
    useSafeArea: true,
    backgroundColor: AppColors.night,
    builder: (context) {
      final t = context.t.reading;
      final monthName = context.formatDate(month ?? DateTime.now(), 'MMMM');
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.rotate(
              angle: -0.1,
              child: BookCover(
                title: book.title,
                coverUrl: book.coverUrl,
                width: 96,
                showTitle: true,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              t.finishedQuestion,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.goldLight,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              t.finishedText(page: pageReached, total: book.totalPages),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              t.monthCount(n: monthCount, month: monthName),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                backgroundColor: AppColors.goldLight,
                foregroundColor: AppColors.ink,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.finishedYes),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.goldLight,
                minimumSize: const Size.fromHeight(44),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.finishedNo),
            ),
          ],
        ),
      );
    },
  );
  return answer ?? false;
}
