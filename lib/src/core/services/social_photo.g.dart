// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_photo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The photo of the Google account a member just created their account with,
/// waiting to become their profile photo once they are signed in.

@ProviderFor(PendingSocialPhoto)
final pendingSocialPhotoProvider = PendingSocialPhotoProvider._();

/// The photo of the Google account a member just created their account with,
/// waiting to become their profile photo once they are signed in.
final class PendingSocialPhotoProvider
    extends $NotifierProvider<PendingSocialPhoto, String?> {
  /// The photo of the Google account a member just created their account with,
  /// waiting to become their profile photo once they are signed in.
  PendingSocialPhotoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingSocialPhotoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingSocialPhotoHash();

  @$internal
  @override
  PendingSocialPhoto create() => PendingSocialPhoto();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$pendingSocialPhotoHash() =>
    r'63d0b182e77c1f13c1eacefca32311b82c59a618';

/// The photo of the Google account a member just created their account with,
/// waiting to become their profile photo once they are signed in.

abstract class _$PendingSocialPhoto extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(photoDownloader)
final photoDownloaderProvider = PhotoDownloaderProvider._();

final class PhotoDownloaderProvider
    extends
        $FunctionalProvider<PhotoDownloader, PhotoDownloader, PhotoDownloader>
    with $Provider<PhotoDownloader> {
  PhotoDownloaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoDownloaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoDownloaderHash();

  @$internal
  @override
  $ProviderElement<PhotoDownloader> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PhotoDownloader create(Ref ref) {
    return photoDownloader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoDownloader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoDownloader>(value),
    );
  }
}

String _$photoDownloaderHash() => r'8a2f77038253c3c031f0946e7ab52c0d9439c26c';
