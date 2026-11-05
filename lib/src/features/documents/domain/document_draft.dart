/// What an admin saves for a document (POST and PUT /v1/admin/documents):
/// its file, sent before (POST /v1/admin/documents/files), its words, its
/// category and whether members see it.
class DocumentDraft {
  const DocumentDraft({
    required this.title,
    required this.fileId,
    this.description = '',
    this.categoryId,
    this.newCategory = '',
    this.fileName = '',
    this.published = true,
    this.notify = true,
  });

  final String title;
  final String description;

  /// A category the admins made before; null for none or a new one.
  final int? categoryId;

  /// A category to make with this name ("Formulaires"), when [categoryId] is
  /// null; '' for none.
  final String newCategory;

  final int fileId;

  /// "Règlement intérieur.pdf": the name members keep it under.
  final String fileName;

  /// false: a draft, seen by the admins only.
  final bool published;

  /// « Prévenir les membres » by a push, the first time it is published.
  final bool notify;

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    if (categoryId != null)
      'category_id': categoryId
    else if (newCategory.isNotEmpty)
      'category': newCategory,
    'file_id': fileId,
    if (fileName.isNotEmpty) 'file_name': fileName,
    'published': published,
    'notify': notify,
  };
}
