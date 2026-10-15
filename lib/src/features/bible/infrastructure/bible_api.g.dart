// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bibleApi)
final bibleApiProvider = BibleApiProvider._();

final class BibleApiProvider
    extends $FunctionalProvider<BibleApi, BibleApi, BibleApi>
    with $Provider<BibleApi> {
  BibleApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleApiHash();

  @$internal
  @override
  $ProviderElement<BibleApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BibleApi create(Ref ref) {
    return bibleApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BibleApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BibleApi>(value),
    );
  }
}

String _$bibleApiHash() => r'ecc0e39fdc2fefe06dab3e13cfc7bfbaa484e03b';
