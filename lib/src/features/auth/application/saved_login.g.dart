// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_login.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The number kept from one sign-in to the next, and the sign-in with Face
/// ID / the fingerprint. Signing out keeps both (it is the point: back in
/// without typing); deleting the account forgets them.

@ProviderFor(SavedLogin)
final savedLoginProvider = SavedLoginProvider._();

/// The number kept from one sign-in to the next, and the sign-in with Face
/// ID / the fingerprint. Signing out keeps both (it is the point: back in
/// without typing); deleting the account forgets them.
final class SavedLoginProvider
    extends $AsyncNotifierProvider<SavedLogin, SavedLoginState> {
  /// The number kept from one sign-in to the next, and the sign-in with Face
  /// ID / the fingerprint. Signing out keeps both (it is the point: back in
  /// without typing); deleting the account forgets them.
  SavedLoginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedLoginProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedLoginHash();

  @$internal
  @override
  SavedLogin create() => SavedLogin();
}

String _$savedLoginHash() => r'd211038989f900d196ddaf4b7c107b86c848cea6';

/// The number kept from one sign-in to the next, and the sign-in with Face
/// ID / the fingerprint. Signing out keeps both (it is the point: back in
/// without typing); deleting the account forgets them.

abstract class _$SavedLogin extends $AsyncNotifier<SavedLoginState> {
  FutureOr<SavedLoginState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SavedLoginState>, SavedLoginState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SavedLoginState>, SavedLoginState>,
              AsyncValue<SavedLoginState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
