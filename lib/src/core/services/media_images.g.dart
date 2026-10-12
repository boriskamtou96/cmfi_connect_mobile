// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_images.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mediaImages)
final mediaImagesProvider = MediaImagesProvider._();

final class MediaImagesProvider
    extends $FunctionalProvider<MediaImages, MediaImages, MediaImages>
    with $Provider<MediaImages> {
  MediaImagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaImagesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaImagesHash();

  @$internal
  @override
  $ProviderElement<MediaImages> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MediaImages create(Ref ref) {
    return mediaImages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MediaImages value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MediaImages>(value),
    );
  }
}

String _$mediaImagesHash() => r'5fa331fc0b9e7478e8207c70439c90fdef98752f';
