// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_picking.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(documentPicking)
final documentPickingProvider = DocumentPickingProvider._();

final class DocumentPickingProvider
    extends
        $FunctionalProvider<DocumentPicking, DocumentPicking, DocumentPicking>
    with $Provider<DocumentPicking> {
  DocumentPickingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentPickingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentPickingHash();

  @$internal
  @override
  $ProviderElement<DocumentPicking> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentPicking create(Ref ref) {
    return documentPicking(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentPicking value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentPicking>(value),
    );
  }
}

String _$documentPickingHash() => r'f13d4bfff3e2ccdb161abfd79018ed8e95645b04';
