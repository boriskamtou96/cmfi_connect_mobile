// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether a user is signed in. The router guard and the 401 handling rely on it.

@ProviderFor(Session)
final sessionProvider = SessionProvider._();

/// Whether a user is signed in. The router guard and the 401 handling rely on it.
final class SessionProvider
    extends $AsyncNotifierProvider<Session, SessionStatus> {
  /// Whether a user is signed in. The router guard and the 401 handling rely on it.
  SessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionHash();

  @$internal
  @override
  Session create() => Session();
}

String _$sessionHash() => r'46cd2ccec9be2e59f6428f055c7f3377a82228b1';

/// Whether a user is signed in. The router guard and the 401 handling rely on it.

abstract class _$Session extends $AsyncNotifier<SessionStatus> {
  FutureOr<SessionStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SessionStatus>, SessionStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SessionStatus>, SessionStatus>,
              AsyncValue<SessionStatus>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The signed-in account saved at login. null when signed out, or when the
/// session was opened by a version of the app that didn't save it yet.

@ProviderFor(signedInAccount)
final signedInAccountProvider = SignedInAccountProvider._();

/// The signed-in account saved at login. null when signed out, or when the
/// session was opened by a version of the app that didn't save it yet.

final class SignedInAccountProvider
    extends
        $FunctionalProvider<AsyncValue<Account?>, Account?, FutureOr<Account?>>
    with $FutureModifier<Account?>, $FutureProvider<Account?> {
  /// The signed-in account saved at login. null when signed out, or when the
  /// session was opened by a version of the app that didn't save it yet.
  SignedInAccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signedInAccountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signedInAccountHash();

  @$internal
  @override
  $FutureProviderElement<Account?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Account?> create(Ref ref) {
    return signedInAccount(ref);
  }
}

String _$signedInAccountHash() => r'03b29623bbaf7438c925aaa175f77a4d3d7cb198';
