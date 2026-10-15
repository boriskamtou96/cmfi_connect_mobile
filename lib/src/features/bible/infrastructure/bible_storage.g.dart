// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bibleStorage)
final bibleStorageProvider = BibleStorageProvider._();

final class BibleStorageProvider
    extends $FunctionalProvider<BibleStorage, BibleStorage, BibleStorage>
    with $Provider<BibleStorage> {
  BibleStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleStorageHash();

  @$internal
  @override
  $ProviderElement<BibleStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BibleStorage create(Ref ref) {
    return bibleStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BibleStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BibleStorage>(value),
    );
  }
}

String _$bibleStorageHash() => r'195c9279059df90dda701d1d3f9e18907100351a';
