// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_profile.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user's profile (greeting, avatar, "Plus" tab, profile form).
/// Name and phone fall back to the account used to sign in when the server has
/// them empty, or has no profile at all.

@ProviderFor(currentProfile)
final currentProfileProvider = CurrentProfileProvider._();

/// The signed-in user's profile (greeting, avatar, "Plus" tab, profile form).
/// Name and phone fall back to the account used to sign in when the server has
/// them empty, or has no profile at all.

final class CurrentProfileProvider
    extends $FunctionalProvider<AsyncValue<Profile>, Profile, FutureOr<Profile>>
    with $FutureModifier<Profile>, $FutureProvider<Profile> {
  /// The signed-in user's profile (greeting, avatar, "Plus" tab, profile form).
  /// Name and phone fall back to the account used to sign in when the server has
  /// them empty, or has no profile at all.
  CurrentProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentProfileHash();

  @$internal
  @override
  $FutureProviderElement<Profile> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Profile> create(Ref ref) {
    return currentProfile(ref);
  }
}

String _$currentProfileHash() => r'505559b81bde9e37f36a07244ee3c1837f056015';
