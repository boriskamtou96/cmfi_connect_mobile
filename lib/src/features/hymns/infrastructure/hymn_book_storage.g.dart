// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_book_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hymnBookStorage)
final hymnBookStorageProvider = HymnBookStorageProvider._();

final class HymnBookStorageProvider
    extends
        $FunctionalProvider<HymnBookStorage, HymnBookStorage, HymnBookStorage>
    with $Provider<HymnBookStorage> {
  HymnBookStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hymnBookStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hymnBookStorageHash();

  @$internal
  @override
  $ProviderElement<HymnBookStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HymnBookStorage create(Ref ref) {
    return hymnBookStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HymnBookStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HymnBookStorage>(value),
    );
  }
}

String _$hymnBookStorageHash() => r'2641424cef94bb0cf5103fd8eb99e33f0fabfb8a';
