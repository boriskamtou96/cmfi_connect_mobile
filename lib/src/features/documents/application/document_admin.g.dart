// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_admin.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every document for the admins: the published ones, then the drafts.

@ProviderFor(adminDocuments)
final adminDocumentsProvider = AdminDocumentsProvider._();

/// Every document for the admins: the published ones, then the drafts.

final class AdminDocumentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LibraryDocument>>,
          List<LibraryDocument>,
          FutureOr<List<LibraryDocument>>
        >
    with
        $FutureModifier<List<LibraryDocument>>,
        $FutureProvider<List<LibraryDocument>> {
  /// Every document for the admins: the published ones, then the drafts.
  AdminDocumentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminDocumentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminDocumentsHash();

  @$internal
  @override
  $FutureProviderElement<List<LibraryDocument>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LibraryDocument>> create(Ref ref) {
    return adminDocuments(ref);
  }
}

String _$adminDocumentsHash() => r'b9c6af5afa1268498a7e3cba9a6d01ac146c9ed1';

/// The categories to file a document under (the archived ones left aside).

@ProviderFor(adminDocumentCategories)
final adminDocumentCategoriesProvider = AdminDocumentCategoriesProvider._();

/// The categories to file a document under (the archived ones left aside).

final class AdminDocumentCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DocumentCategory>>,
          List<DocumentCategory>,
          FutureOr<List<DocumentCategory>>
        >
    with
        $FutureModifier<List<DocumentCategory>>,
        $FutureProvider<List<DocumentCategory>> {
  /// The categories to file a document under (the archived ones left aside).
  AdminDocumentCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminDocumentCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminDocumentCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<DocumentCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DocumentCategory>> create(Ref ref) {
    return adminDocumentCategories(ref);
  }
}

String _$adminDocumentCategoriesHash() =>
    r'8ed697933bb025c495b5c2f27851585bf992f0d9';

@ProviderFor(documentAdmin)
final documentAdminProvider = DocumentAdminProvider._();

final class DocumentAdminProvider
    extends $FunctionalProvider<DocumentAdmin, DocumentAdmin, DocumentAdmin>
    with $Provider<DocumentAdmin> {
  DocumentAdminProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentAdminProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentAdminHash();

  @$internal
  @override
  $ProviderElement<DocumentAdmin> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentAdmin create(Ref ref) {
    return documentAdmin(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentAdmin value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentAdmin>(value),
    );
  }
}

String _$documentAdminHash() => r'd94045d78270db7796b847406264ccc61cc56012';
