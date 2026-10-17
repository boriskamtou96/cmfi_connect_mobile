// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The documents that answer [search] in [category] ('' for all), a page at
/// a time: the first one at once, the next ones at the end of the list.

@ProviderFor(Documents)
final documentsProvider = DocumentsFamily._();

/// The documents that answer [search] in [category] ('' for all), a page at
/// a time: the first one at once, the next ones at the end of the list.
final class DocumentsProvider
    extends $AsyncNotifierProvider<Documents, DocumentsState> {
  /// The documents that answer [search] in [category] ('' for all), a page at
  /// a time: the first one at once, the next ones at the end of the list.
  DocumentsProvider._({
    required DocumentsFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'documentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$documentsHash();

  @override
  String toString() {
    return r'documentsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  Documents create() => Documents();

  @override
  bool operator ==(Object other) {
    return other is DocumentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$documentsHash() => r'42182e2fdb078a62688d2a908967aaa856072906';

/// The documents that answer [search] in [category] ('' for all), a page at
/// a time: the first one at once, the next ones at the end of the list.

final class DocumentsFamily extends $Family
    with
        $ClassFamilyOverride<
          Documents,
          AsyncValue<DocumentsState>,
          DocumentsState,
          FutureOr<DocumentsState>,
          (String, String)
        > {
  DocumentsFamily._()
    : super(
        retry: null,
        name: r'documentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The documents that answer [search] in [category] ('' for all), a page at
  /// a time: the first one at once, the next ones at the end of the list.

  DocumentsProvider call(String search, String category) =>
      DocumentsProvider._(argument: (search, category), from: this);

  @override
  String toString() => r'documentsProvider';
}

/// The documents that answer [search] in [category] ('' for all), a page at
/// a time: the first one at once, the next ones at the end of the list.

abstract class _$Documents extends $AsyncNotifier<DocumentsState> {
  late final _$args = ref.$arg as (String, String);
  String get search => _$args.$1;
  String get category => _$args.$2;

  FutureOr<DocumentsState> build(String search, String category);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DocumentsState>, DocumentsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DocumentsState>, DocumentsState>,
              AsyncValue<DocumentsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

/// The categories of the published documents: the chips above the list;
/// none without network (the list says why).

@ProviderFor(documentCategories)
final documentCategoriesProvider = DocumentCategoriesProvider._();

/// The categories of the published documents: the chips above the list;
/// none without network (the list says why).

final class DocumentCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DocumentCategory>>,
          List<DocumentCategory>,
          FutureOr<List<DocumentCategory>>
        >
    with
        $FutureModifier<List<DocumentCategory>>,
        $FutureProvider<List<DocumentCategory>> {
  /// The categories of the published documents: the chips above the list;
  /// none without network (the list says why).
  DocumentCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<DocumentCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DocumentCategory>> create(Ref ref) {
    return documentCategories(ref);
  }
}

String _$documentCategoriesHash() =>
    r'd90a0a5f994b3227b37cc04fd8c00502fbd3daee';
