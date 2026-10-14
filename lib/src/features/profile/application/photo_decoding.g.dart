// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_decoding.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Behind a provider: the tests give pictures decoded beforehand (decoding
/// needs real time, which widget tests don't have).

@ProviderFor(photoDecoder)
final photoDecoderProvider = PhotoDecoderProvider._();

/// Behind a provider: the tests give pictures decoded beforehand (decoding
/// needs real time, which widget tests don't have).

final class PhotoDecoderProvider
    extends $FunctionalProvider<PhotoDecoder, PhotoDecoder, PhotoDecoder>
    with $Provider<PhotoDecoder> {
  /// Behind a provider: the tests give pictures decoded beforehand (decoding
  /// needs real time, which widget tests don't have).
  PhotoDecoderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoDecoderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoDecoderHash();

  @$internal
  @override
  $ProviderElement<PhotoDecoder> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PhotoDecoder create(Ref ref) {
    return photoDecoder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoDecoder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoDecoder>(value),
    );
  }
}

String _$photoDecoderHash() => r'83e4b1ff122b63273fb2005b56cad37a30d09272';
