// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chime.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chime)
final chimeProvider = ChimeProvider._();

final class ChimeProvider extends $FunctionalProvider<Chime, Chime, Chime>
    with $Provider<Chime> {
  ChimeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chimeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chimeHash();

  @$internal
  @override
  $ProviderElement<Chime> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Chime create(Ref ref) {
    return chime(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Chime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Chime>(value),
    );
  }
}

String _$chimeHash() => r'a3160f257241aa28ff6ace85c758412e36834406';
