import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/document_picking.dart';
import '../domain/document_draft.dart';
import '../domain/library_document.dart';
import '../infrastructure/documents_api.dart';
import 'documents.dart';

part 'document_admin.g.dart';

/// Every document for the admins: the published ones, then the drafts.
@riverpod
Future<List<LibraryDocument>> adminDocuments(Ref ref) async =>
    (await ref.watch(documentsApiProvider).adminList()).items;

/// The categories to file a document under (the archived ones left aside).
@riverpod
Future<List<DocumentCategory>> adminDocumentCategories(Ref ref) =>
    ref.watch(documentsApiProvider).adminCategories();

/// The file chosen weighs more than the server takes (10 MB).
class DocumentTooLarge implements Exception {
  const DocumentTooLarge();
}

/// What the admins do with Nos documents. Each method throws an
/// AppException on failure; after a change, the lists of the members and of
/// the admins are asked again.
class DocumentAdmin {
  const DocumentAdmin(this._ref);

  final Ref _ref;

  /// What the server takes: 10 MB.
  static const maxBytes = 10 * 1024 * 1024;

  /// Sends a file picked on the phone; [DocumentTooLarge] above 10 MB, before
  /// sending anything.
  Future<LibraryFile> upload(PickedDocument document) {
    if (document.bytes.length > maxBytes) {
      throw const DocumentTooLarge();
    }
    return _kept(
      () => _ref
          .read(documentsApiProvider)
          .upload(document.bytes, filename: document.name),
    );
  }

  Future<LibraryDocument> create(DocumentDraft draft) =>
      _changing(() => _ref.read(documentsApiProvider).create(draft));

  Future<LibraryDocument> save(int id, DocumentDraft draft) =>
      _changing(() => _ref.read(documentsApiProvider).update(id, draft));

  Future<void> delete(int id) =>
      _changing(() => _ref.read(documentsApiProvider).delete(id));

  Future<T> _changing<T>(Future<T> Function() request) => _kept(() async {
    final result = await request();
    _ref
      ..invalidate(documentsProvider)
      ..invalidate(documentCategoriesProvider)
      ..invalidate(adminDocumentsProvider)
      ..invalidate(adminDocumentCategoriesProvider);
    return result;
  });

  /// The answer is used even if the admin left the page meanwhile.
  Future<T> _kept<T>(Future<T> Function() action) async {
    final link = _ref.keepAlive();
    try {
      return await action();
    } finally {
      link.close();
    }
  }
}

@riverpod
DocumentAdmin documentAdmin(Ref ref) => DocumentAdmin(ref);
