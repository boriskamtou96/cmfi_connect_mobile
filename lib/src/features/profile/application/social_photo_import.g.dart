// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_photo_import.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Makes the photo of the Google account the profile photo, once, right after
/// the account is created. Best effort: without a photo, or if it can't be
/// had or sent, nothing changes and the member picks one later.

@ProviderFor(SocialPhotoImport)
final socialPhotoImportProvider = SocialPhotoImportProvider._();

/// Makes the photo of the Google account the profile photo, once, right after
/// the account is created. Best effort: without a photo, or if it can't be
/// had or sent, nothing changes and the member picks one later.
final class SocialPhotoImportProvider
    extends $NotifierProvider<SocialPhotoImport, void> {
  /// Makes the photo of the Google account the profile photo, once, right after
  /// the account is created. Best effort: without a photo, or if it can't be
  /// had or sent, nothing changes and the member picks one later.
  SocialPhotoImportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socialPhotoImportProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socialPhotoImportHash();

  @$internal
  @override
  SocialPhotoImport create() => SocialPhotoImport();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$socialPhotoImportHash() => r'd5c9f17d057d73c8083d4f23a39b3b1d924c34c1';

/// Makes the photo of the Google account the profile photo, once, right after
/// the account is created. Best effort: without a photo, or if it can't be
/// had or sent, nothing changes and the member picks one later.

abstract class _$SocialPhotoImport extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
