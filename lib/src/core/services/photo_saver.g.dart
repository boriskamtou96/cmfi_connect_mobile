// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_saver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(photoSaver)
final photoSaverProvider = PhotoSaverProvider._();

final class PhotoSaverProvider
    extends $FunctionalProvider<PhotoSaver, PhotoSaver, PhotoSaver>
    with $Provider<PhotoSaver> {
  PhotoSaverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoSaverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoSaverHash();

  @$internal
  @override
  $ProviderElement<PhotoSaver> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PhotoSaver create(Ref ref) {
    return photoSaver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoSaver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoSaver>(value),
    );
  }
}

String _$photoSaverHash() => r'6e1d92be854b5e380101c5edac6ad90eec6ffd22';
