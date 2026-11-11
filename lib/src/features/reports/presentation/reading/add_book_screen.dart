import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/sub_page.dart';
import '../../application/reading_books.dart';
import '../../domain/reading_book.dart';
import '../../infrastructure/reading_api.dart';
import 'book_cover.dart';

/// « Ajouter un livre »: searched by title or author (Open Library fills the
/// author, the pages and the cover), or typed by hand. Pops with the book
/// added.
@RoutePage()
class AddBookScreen extends HookConsumerWidget {
  const AddBookScreen({super.key});

  static const _maxPages = 20000;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.reading;
    final scheme = Theme.of(context).colorScheme;
    final query = useTextEditingController();
    final title = useTextEditingController();
    final author = useTextEditingController();
    final pages = useTextEditingController();
    final cover = useRef('');
    final manual = useState(false);
    final saving = useState(false);
    final searched = useState<String>('');
    final results = useState<AsyncValue<List<BookFound>>?>(null);
    final titleError = useState<String?>(null);
    final pagesError = useState<String?>(null);

    // searched 400 ms after the last letter
    useEffect(() {
      Timer? timer;
      void listen() {
        timer?.cancel();
        final text = query.text.trim();
        if (text.length < 2) {
          searched.value = '';
          results.value = null;
          return;
        }
        timer = Timer(const Duration(milliseconds: 400), () async {
          searched.value = text;
          results.value = const AsyncLoading();
          try {
            final found = await ref.read(readingApiProvider).search(text);
            if (context.mounted && searched.value == text) {
              results.value = AsyncData(found);
            }
          } on Object catch (error, stack) {
            if (context.mounted && searched.value == text) {
              results.value = AsyncError(error, stack);
            }
          }
        });
      }

      query.addListener(listen);
      return () {
        timer?.cancel();
        query.removeListener(listen);
      };
    }, [query]);

    // a book found fills the form: added at once when its pages are known
    Future<void> save() async {
      final typedPages = int.tryParse(pages.text);
      titleError.value = title.text.trim().isEmpty ? t.titleRequired : null;
      pagesError.value =
          typedPages == null || typedPages < 1 || typedPages > _maxPages
          ? t.pagesRequired
          : null;
      if (titleError.value != null || pagesError.value != null) {
        manual.value = true;
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final texts = context.t;
      saving.value = true;
      try {
        final book = await ref
            .read(readingBooksProvider.notifier)
            .add(
              title: title.text,
              author: author.text,
              totalPages: typedPages!,
              coverUrl: cover.value,
            );
        toast.success(t.added(title: book.title));
        if (context.mounted) {
          await context.router.maybePop(book);
        }
      } on AppException catch (error) {
        toast.error(userMessageFor(error, texts));
      } finally {
        if (context.mounted) {
          saving.value = false;
        }
      }
    }

    Future<void> choose(BookFound found) async {
      title.text = found.title;
      author.text = found.author;
      pages.text = found.totalPages > 0 ? '${found.totalPages}' : '';
      cover.value = found.coverUrl;
      if (found.totalPages > 0) {
        await save();
      } else {
        // the pages to type
        manual.value = true;
        pagesError.value = null;
      }
    }

    final found = results.value;

    return SubPage(
      title: t.add,
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          TextField(
            controller: query,
            autofocus: true,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: t.searchHint,
              prefixIcon: const Icon(AppIcons.search),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          switch (found) {
            null => const SizedBox.shrink(),
            AsyncLoading() => const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
            AsyncError() => _Note(t.searchUnavailable),
            AsyncData(value: final books) when books.isEmpty => _Note(
              t.noResult,
            ),
            AsyncData(value: final books) => SectionCard(
              children: [
                for (final book in books)
                  ListTile(
                    leading: BookCover(
                      title: book.title,
                      coverUrl: book.coverUrl,
                      width: 36,
                    ),
                    title: Text(
                      book.title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      [
                        if (book.author.isNotEmpty) book.author,
                        if (book.totalPages > 0)
                          t.pages(n: book.totalPages)
                        else
                          t.pagesUnknown,
                      ].join(' · '),
                    ),
                    trailing: Icon(AppIcons.add, color: scheme.primary),
                    onTap: saving.value ? null : () => choose(book),
                  ),
              ],
            ),
          },
          const SizedBox(height: AppSpacing.lg),
          if (!manual.value)
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                manual.value = true;
                if (title.text.isEmpty) {
                  title.text = query.text.trim();
                }
              },
              icon: const Icon(AppIcons.edit),
              label: Text(t.manual),
            )
          else ...[
            LabeledField(
              label: t.fieldTitle,
              child: TextField(
                controller: title,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 300,
                decoration: InputDecoration(
                  errorText: titleError.value,
                  counterText: '',
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            LabeledField(
              label: t.fieldAuthor,
              child: TextField(
                controller: author,
                textCapitalization: TextCapitalization.words,
                maxLength: 200,
                decoration: const InputDecoration(counterText: ''),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            LabeledField(
              label: t.fieldPages,
              child: TextField(
                controller: pages,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
                decoration: InputDecoration(errorText: pagesError.value),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
              ),
              onPressed: saving.value ? null : save,
              child: Text(t.add),
            ),
          ],
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.md,
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    ),
  );
}
