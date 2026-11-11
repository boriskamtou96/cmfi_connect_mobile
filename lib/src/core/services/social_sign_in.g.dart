// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_sign_in.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Firebase started in bootstrap.dart (firebase_options.dart), or not.

@ProviderFor(socialSignIn)
final socialSignInProvider = SocialSignInProvider._();

/// Firebase started in bootstrap.dart (firebase_options.dart), or not.

final class SocialSignInProvider
    extends $FunctionalProvider<SocialSignIn, SocialSignIn, SocialSignIn>
    with $Provider<SocialSignIn> {
  /// Firebase started in bootstrap.dart (firebase_options.dart), or not.
  SocialSignInProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socialSignInProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socialSignInHash();

  @$internal
  @override
  $ProviderElement<SocialSignIn> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SocialSignIn create(Ref ref) {
    return socialSignIn(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SocialSignIn value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SocialSignIn>(value),
    );
  }
}

String _$socialSignInHash() => r'fef0f1a0f970ccb4425c9e9f605ccc3cbefbe336';
