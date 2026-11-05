import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/document_picking.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../../../core/widgets/adaptive_dialogs.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/dashed_outline.dart';
import '../../../../core/widgets/inline_error.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/sub_page.dart';
import '../../application/document_admin.dart';
import '../../domain/document_draft.dart';
import '../../domain/library_document.dart';
import '../documents_screen.dart';

/// Publishes a document ([document] null) or changes one: its PDF or Word
/// file (sent as soon as it is chosen), its title, description and
/// category, published or kept as a draft, the members told or not. The bin
/// of the bar deletes it.
@RoutePage()
class DocumentFormScreen extends HookConsumerWidget {
  const DocumentFormScreen({this.document, super.key});

  final LibraryDocument? document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.documents.admin;
    final document = this.document;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final file = useState(document?.file);
    final uploading = useState(false);
    final missingFile = useState(false);
    final title = useTextEditingController(text: document?.title);
    final description = useTextEditingController(text: document?.description);
    final categoryId = useState(document?.categoryId);
    // a category typed here, made by the server with the document
    final creating = useState(false);
    final newCategory = useTextEditingController();
    final published = useState(document?.published ?? true);
    final notify = useState(true);
    final saving = useState(false);
    final categories =
        ref.watch(adminDocumentCategoriesProvider).value ??
        const <DocumentCategory>[];

    Future<void> pickFile() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final picked = await ref.read(documentPickingProvider).pickOne();
      if (picked == null) {
        return;
      }
      uploading.value = true;
      try {
        file.value = await ref.read(documentAdminProvider).upload(picked);
        missingFile.value = false;
        // the file's name, without its extension, as a first title
        if (title.text.trim().isEmpty) {
          final dot = picked.name.lastIndexOf('.');
          title.text = (dot > 0 ? picked.name.substring(0, dot) : picked.name)
              .replaceAll(RegExp(r'[_]+'), ' ')
              .trim();
        }
      } on DocumentTooLarge {
        toast.error(t.tooLarge);
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      } finally {
        if (context.mounted) {
          uploading.value = false;
        }
      }
    }

    Future<void> save() async {
      final chosen = file.value;
      final toast = ref.read(toasterProvider).of(context);
      missingFile.value = chosen == null;
      if (chosen == null) {
        // the box is at the top: said where the admin is too
        toast.error(t.fileRequired);
      }
      if (!(formKey.currentState?.validate() ?? false) || chosen == null) {
        return;
      }
      final messages = context.t;
      final navigator = Navigator.of(context);
      final admin = ref.read(documentAdminProvider);
      final draft = DocumentDraft(
        title: title.text.trim(),
        description: description.text.trim(),
        categoryId: creating.value ? null : categoryId.value,
        newCategory: creating.value ? newCategory.text.trim() : '',
        fileId: chosen.id,
        fileName: chosen.name,
        published: published.value,
        notify: notify.value,
      );
      saving.value = true;
      try {
        if (document == null) {
          await admin.create(draft);
        } else {
          await admin.save(document.id, draft);
        }
        toast.success(t.saved);
        navigator.pop();
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          saving.value = false;
        }
      }
    }

    Future<void> delete() async {
      if (document == null) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      final confirmed = await showConfirmDialog(
        context,
        title: t.deleteTitle,
        text: t.deleteText,
        confirmLabel: t.delete,
        destructive: true,
      );
      if (!confirmed) {
        return;
      }
      saving.value = true;
      try {
        await ref.read(documentAdminProvider).delete(document.id);
        toast.success(t.deleted);
        navigator.pop();
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          saving.value = false;
        }
      }
    }

    const gap = SizedBox(height: AppSpacing.lg);
    final tone = AppModule.reports.tone(context);

    Widget categoryChip(
      String label, {
      required bool selected,
      required VoidCallback onTap,
    }) => ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: tone.soft,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: selected ? tone.onSoft : null,
      ),
      showCheckmark: false,
    );

    return SubPage(
      title: document == null ? t.create : t.edit,
      actions: [
        if (document != null)
          IconButton(
            tooltip: t.delete,
            onPressed: saving.value ? null : delete,
            icon: const Icon(AppIcons.delete),
          ),
      ],
      bottom: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: AppButton(
          label: context.t.common.save,
          isLoading: saving.value,
          onPressed: uploading.value ? null : save,
        ),
      ),
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            SectionLabel(t.file),
            const SizedBox(height: AppSpacing.md),
            _FilePicker(
              file: file.value,
              uploading: uploading.value,
              onPick: pickFile,
            ),
            if (missingFile.value) ...[
              const SizedBox(height: AppSpacing.sm),
              InlineError(t.fileRequired),
            ],
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(t.general),
            const SizedBox(height: AppSpacing.md),
            LabeledField(
              label: t.titleField,
              child: TextFormField(
                controller: title,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: t.titleHint),
                validator: (value) =>
                    (value ?? '').trim().isEmpty ? t.titleRequired : null,
              ),
            ),
            gap,
            LabeledField(
              label: t.description,
              child: TextFormField(
                controller: description,
                minLines: 2,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            gap,
            LabeledField(
              label: t.category,
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  categoryChip(
                    t.noCategory,
                    selected: !creating.value && categoryId.value == null,
                    onTap: () {
                      creating.value = false;
                      categoryId.value = null;
                    },
                  ),
                  for (final category in categories)
                    categoryChip(
                      category.name,
                      selected:
                          !creating.value && categoryId.value == category.id,
                      onTap: () {
                        creating.value = false;
                        categoryId.value = category.id;
                      },
                    ),
                  ActionChip(
                    avatar: const Icon(AppIcons.add, size: 18),
                    label: Text(t.newCategory),
                    onPressed: () => creating.value = true,
                    side: creating.value
                        ? BorderSide(color: tone.onSoft, width: 1.5)
                        : null,
                  ),
                ],
              ),
            ),
            if (creating.value) ...[
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: newCategory,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: t.newCategoryHint),
                validator: (value) =>
                    creating.value && (value ?? '').trim().isEmpty
                    ? t.newCategoryHint
                    : null,
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(t.visibility),
            const SizedBox(height: AppSpacing.sm),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: published.value,
              onChanged: (value) => published.value = value,
              title: Text(
                t.published,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(t.publishedHint),
            ),
            // the push goes the first time only: not for a document already
            // published
            if (published.value && !(document?.published ?? false))
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                value: notify.value,
                onChanged: (value) => notify.value = value,
                title: Text(
                  t.notify,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(t.notifyHint),
              ),
          ],
        ),
      ),
    );
  }
}

/// The file chosen (its tile, name and size, « Remplacer »), or a dashed
/// box to choose one; a spinner while it is sent.
class _FilePicker extends StatelessWidget {
  const _FilePicker({
    required this.file,
    required this.uploading,
    required this.onPick,
  });

  final LibraryFile? file;
  final bool uploading;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final t = context.t.documents;
    final scheme = Theme.of(context).colorScheme;
    final file = this.file;

    if (uploading) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          children: [
            const AppSpinner(size: 22),
            const SizedBox(width: AppSpacing.md),
            Text(t.admin.uploading),
          ],
        ),
      );
    }

    if (file == null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPick,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: DashedOutline(
            color: scheme.outline,
            radius: AppRadius.lg,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xl,
              ),
              child: Column(
                children: [
                  Icon(AppIcons.pdf, size: 32, color: scheme.primary),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    t.admin.pickFile,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: scheme.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    t.admin.fileHint,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final word = file.kind == DocumentKind.word;
    final tone = (word ? AppModule.reports : AppModule.bible).tone(context);
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 6, 10),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 52,
            decoration: BoxDecoration(
              color: tone.soft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              word ? AppIcons.wordFile : AppIcons.pdf,
              color: tone.onSoft,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name.isEmpty ? (word ? t.word : t.pdf) : file.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                if (file.sizeBytes > 0)
                  Text(
                    documentSize(context, file.sizeBytes),
                    style: TextStyle(
                      fontSize: 12.5,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          TextButton(onPressed: onPick, child: Text(t.admin.replace)),
        ],
      ),
    );
  }
}
