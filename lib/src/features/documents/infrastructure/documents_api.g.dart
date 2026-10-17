// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(documentsApi)
final documentsApiProvider = DocumentsApiProvider._();

final class DocumentsApiProvider
    extends $FunctionalProvider<DocumentsApi, DocumentsApi, DocumentsApi>
    with $Provider<DocumentsApi> {
  DocumentsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentsApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentsApiHash();

  @$internal
  @override
  $ProviderElement<DocumentsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentsApi create(Ref ref) {
    return documentsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentsApi>(value),
    );
  }
}

String _$documentsApiHash() => r'4f74b9c2e5e33e02aff7c2c68015e96ade1c1b12';
