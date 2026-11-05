import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../core/widgets/sub_page.dart';
import '../../../../routing/app_router.dart';
import '../../../events/presentation/widgets/program_view.dart';
import '../../application/document_admin.dart';
import '../../domain/library_document.dart';
import '../documents_screen.dart';

/// Plus › Administration › Gérer les documents: every document of Nos
/// documents, drafts included, and « Nouveau document ». A tap changes one.
@RoutePage()
class AdminDocumentsScreen extends ConsumerWidget {
  const AdminDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.documents.admin;
    final documents = ref.watch(adminDocumentsProvider);

    return SubPage(
      title: t.title,
      bottom: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: FilledButton.icon(
          onPressed: () => context.router.push(DocumentFormRoute()),
          icon: const Icon(AppIcons.add),
          label: Text(t.create),
        ),
      ),
      child: switch (documents) {
        AsyncValue(value: final list?) => RefreshIndicator.adaptive(
          onRefresh: () => ref
              .refresh(adminDocumentsProvider.future)
              .then((_) {}, onError: (_) {}),
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              if (list.isEmpty)
                TabEmpty(t.empty)
              else
                FadeSlideIn(
                  child: SectionCard(
                    children: [
                      for (final document in list)
                        _AdminDocumentRow(
                          document: document,
                          onTap: () => context.router.push(
                            DocumentFormRoute(document: document),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        AsyncValue(:final error?) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(adminDocumentsProvider),
        ),
        _ => const LoadingList(count: 5, leading: 44, round: false),
      },
    );
  }
}

/// A document: its PDF or Word tile, the title, the category and the size,
/// « Brouillon » when members don't see it yet.
class _AdminDocumentRow extends StatelessWidget {
  const _AdminDocumentRow({required this.document, required this.onTap});

  final LibraryDocument document;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t.documents;
    final scheme = Theme.of(context).colorScheme;
    final file = document.file;
    final word = file.kind == DocumentKind.word;
    final tone = (word ? AppModule.reports : AppModule.bible).tone(context);
    final facts = [
      if (document.category.isNotEmpty) document.category,
      if (file.sizeBytes > 0) documentSize(context, file.sizeBytes),
    ].join(' · ');

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 10, 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 52,
              decoration: BoxDecoration(
                color: tone.soft,
                borderRadius: BorderRadius.circular(10),
              ),
              // the icon says PDF or DOC itself
              child: Icon(
                word ? AppIcons.wordFile : AppIcons.pdf,
                color: tone.onSoft,
                size: 26,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
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
                  if (facts.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        facts,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  if (!document.published)
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text(
                        t.admin.draft,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8A5A0B),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Icon(AppIcons.chevronRight, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
