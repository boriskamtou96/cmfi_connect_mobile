import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/services/media_images.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../application/documents.dart';
import '../domain/library_document.dart';
import '../infrastructure/documents_api.dart';

/// "180 Ko", "2,4 Mo", in the app language.
String documentSize(BuildContext context, int bytes) {
  final t = context.t.documents;
  if (bytes < 1024 * 1024) {
    return t.sizeKb(n: (bytes / 1024).ceil());
  }
  final language = TranslationProvider.of(context).locale.languageCode;
  final mb = NumberFormat('0.#', language).format(bytes / (1024 * 1024));
  return t.sizeMb(n: mb);
}

/// Plus › Communauté › Nos documents: the library of the community, the
/// newest first; a search on their words, a chip per category, the next
/// page at the end of the list. A tap opens a document (the phone's reader
/// or the browser), the arrow keeps it on the phone.
@RoutePage()
class DocumentsScreen extends HookConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.documents;
    final controller = useTextEditingController();
    final typed = useValueListenable(controller).text.trim();
    final search = useDebounced(typed, const Duration(milliseconds: 300)) ?? '';
    final category = useState('');
    final provider = documentsProvider(search, category.value);
    final documents = ref.watch(provider);
    final categories = ref.watch(documentCategoriesProvider).value ?? const [];

    final Widget body = switch (documents) {
      AsyncValue(value: final state?) when state.items.isEmpty => _Message(
        text: search.isEmpty && category.value.isEmpty ? t.empty : t.none,
      ),
      AsyncValue(value: final state?) => _List(
        state: state,
        onEnd: () => ref.read(provider.notifier).loadMore(),
      ),
      AsyncValue(:final error?) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(provider),
      ),
      _ => const LoadingList(count: 6, card: false),
    };

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
          // near the end: the next page
          onNotification: (notification) {
            final metrics = notification.metrics;
            if (metrics.axis == Axis.vertical &&
                metrics.pixels > metrics.maxScrollExtent - 400) {
              ref.read(provider.notifier).loadMore();
            }
            return false;
          },
          child: RefreshIndicator.adaptive(
            onRefresh: () async {
              ref.invalidate(documentCategoriesProvider);
              await ref.read(provider.notifier).refresh();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _Header(controller: controller)),
                if (categories.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _Chips(
                      categories: categories,
                      selected: category.value,
                      onSelect: (name) => category.value = name,
                    ),
                  ),
                if (documents.value case final state? when state.total > 0)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.xl,
                        AppSpacing.md,
                        AppSpacing.xl,
                        AppSpacing.xs,
                      ),
                      child: Text(
                        t.count(n: state.total),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.xxl,
                  ),
                  sliver: SliverToBoxAdapter(child: body),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Night blue, like Notre ministère: the title and the search.
class _Header extends StatelessWidget {
  const _Header({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final t = context.t.documents;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryDeep,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xs,
            AppSpacing.xs,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconTheme(
                data: IconThemeData(color: Colors.white),
                child: AppBackButton(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        t.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      t.subtitle,
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: AppColors.goldLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TextField(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(color: AppColors.ink),
                      decoration: InputDecoration(
                        hintText: t.search,
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          AppIcons.search,
                          color: AppColors.muted,
                        ),
                        suffixIcon: ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, value, _) => value.text.isEmpty
                              ? const SizedBox.shrink()
                              : IconButton(
                                  tooltip: MaterialLocalizations.of(
                                    context,
                                  ).deleteButtonTooltip,
                                  onPressed: controller.clear,
                                  icon: const Icon(
                                    AppIcons.close,
                                    color: AppColors.muted,
                                  ),
                                ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          borderSide: BorderSide.none,
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
    );
  }
}

/// « Tous », then a chip per category.
class _Chips extends StatelessWidget {
  const _Chips({
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  final List<DocumentCategory> categories;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final t = context.t.documents;
    final tone = AppModule.reports.tone(context);

    Widget chip(String label, String value) => Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: ChoiceChip(
        label: Text(label),
        selected: selected == value,
        onSelected: (_) => onSelect(value),
        selectedColor: tone.soft,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: selected == value ? tone.onSoft : null,
        ),
        showCheckmark: false,
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          chip(t.all, ''),
          for (final category in categories) chip(category.name, category.name),
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.state, required this.onEnd});

  final DocumentsState state;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SectionCard(
        children: [
          for (final document in state.items) DocumentRow(document: document),
        ],
      ),
      if (state.hasMore)
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: state.loadingMore
                ? const AppSpinner()
                : TextButton(
                    onPressed: onEnd,
                    child: Text(context.t.documents.more),
                  ),
          ),
        ),
    ],
  );
}

class _Message extends StatelessWidget {
  const _Message({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.reports.tone(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: tone.soft, shape: BoxShape.circle),
            child: Icon(AppIcons.documentsTile, color: tone.onSoft, size: 34),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

/// A document: a PDF (burgundy) or Word (blue) tile, the title, the
/// category, the size and the date. A tap opens it, the arrow keeps it on
/// the phone (on iPhone, "Enregistrer dans Fichiers").
class DocumentRow extends HookConsumerWidget {
  const DocumentRow({required this.document, super.key});

  final LibraryDocument document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.documents;
    final scheme = Theme.of(context).colorScheme;
    final word = document.file.kind == DocumentKind.word;
    final tone = (word ? AppModule.reports : AppModule.bible).tone(context);
    final busy = useState(false);
    final file = document.file;

    Future<void> open() async {
      final toast = ref.read(toasterProvider).of(context);
      final unknown = context.t.errors.unknown;
      final url = ref.read(mediaImagesProvider).resolve(file.url);
      if (!await ref.read(linkLauncherProvider).open(Uri.parse(url))) {
        toast.error(unknown);
      }
    }

    Future<void> download(BuildContext anchor) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final box = anchor.findRenderObject() as RenderBox?;
      busy.value = true;
      try {
        final bytes = await ref
            .read(documentsApiProvider)
            .file(ref.read(mediaImagesProvider).resolve(file.url));
        await ref
            .read(shareServiceProvider)
            .shareFile(
              bytes,
              name: _fileName(document),
              mimeType: _mimeType(file),
              subject: document.title,
              origin: box == null
                  ? null
                  : box.localToGlobal(Offset.zero) & box.size,
            );
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    final facts = [
      if (document.category.isNotEmpty) document.category,
      if (file.sizeBytes > 0) documentSize(context, file.sizeBytes),
      if (document.publishedAt case final at?)
        context.formatDate(at.toLocal(), 'd MMM yyyy'),
    ].join(' · ');

    return InkWell(
      onTap: open,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 6, 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 52,
              decoration: BoxDecoration(
                color: tone.soft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    word ? AppIcons.wordFile : AppIcons.pdf,
                    color: tone.onSoft,
                    size: 22,
                  ),
                  Text(
                    word ? t.word : t.pdf,
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: tone.onSoft,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Semantics(
                hint: t.open,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15.5,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (document.description.isNotEmpty)
                      Text(
                        document.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: scheme.onSurface),
                      ),
                    const SizedBox(height: 2),
                    Text(
                      facts,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (anchor) => IconButton(
                tooltip: t.download,
                onPressed: busy.value ? null : () => download(anchor),
                icon: busy.value
                    ? AppSpinner(size: 20, color: tone.onSoft)
                    : Icon(AppIcons.download, color: tone.onSoft),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The name sent by the admins, else the title with the file's extension.
  static String _fileName(LibraryDocument document) {
    final name = document.file.name.trim();
    if (name.isNotEmpty) {
      return name;
    }
    final extension = document.file.url.split('.').last;
    return '${document.title}.$extension';
  }

  static String _mimeType(LibraryFile file) => switch (file.kind) {
    DocumentKind.pdf => 'application/pdf',
    DocumentKind.word when file.url.endsWith('.doc') => 'application/msword',
    DocumentKind.word =>
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  };
}
