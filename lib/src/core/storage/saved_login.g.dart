// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_login.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(savedLoginStorage)
final savedLoginStorageProvider = SavedLoginStorageProvider._();

final class SavedLoginStorageProvider
    extends
        $FunctionalProvider<
          SavedLoginStorage,
          SavedLoginStorage,
          SavedLoginStorage
        >
    with $Provider<SavedLoginStorage> {
  SavedLoginStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedLoginStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedLoginStorageHash();

  @$internal
  @override
  $ProviderElement<SavedLoginStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SavedLoginStorage create(Ref ref) {
    return savedLoginStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SavedLoginStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SavedLoginStorage>(value),
    );
  }
}

String _$savedLoginStorageHash() => r'3c2293063e9c61671a35f05df86741252dd25e45';
