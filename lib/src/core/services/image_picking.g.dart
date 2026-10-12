// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_picking.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imagePicking)
final imagePickingProvider = ImagePickingProvider._();

final class ImagePickingProvider
    extends $FunctionalProvider<ImagePicking, ImagePicking, ImagePicking>
    with $Provider<ImagePicking> {
  ImagePickingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imagePickingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imagePickingHash();

  @$internal
  @override
  $ProviderElement<ImagePicking> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ImagePicking create(Ref ref) {
    return imagePicking(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImagePicking value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImagePicking>(value),
    );
  }
}

String _$imagePickingHash() => r'ccfe93fabef1dfb28826031f6c06bbf7ccb92cd6';
