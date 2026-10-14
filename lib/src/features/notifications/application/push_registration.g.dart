// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_registration.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Gives the server the address of this phone, so the notifications of the
/// admins reach it as a push: at sign-in, and when Firebase changes it.
/// Stopped before signing out.

@ProviderFor(PushRegistration)
final pushRegistrationProvider = PushRegistrationProvider._();

/// Gives the server the address of this phone, so the notifications of the
/// admins reach it as a push: at sign-in, and when Firebase changes it.
/// Stopped before signing out.
final class PushRegistrationProvider
    extends $NotifierProvider<PushRegistration, void> {
  /// Gives the server the address of this phone, so the notifications of the
  /// admins reach it as a push: at sign-in, and when Firebase changes it.
  /// Stopped before signing out.
  PushRegistrationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushRegistrationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushRegistrationHash();

  @$internal
  @override
  PushRegistration create() => PushRegistration();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$pushRegistrationHash() => r'25afb5e93490fb3b81de19c5740b5333f5063ffb';

/// Gives the server the address of this phone, so the notifications of the
/// admins reach it as a push: at sign-in, and when Firebase changes it.
/// Stopped before signing out.

abstract class _$PushRegistration extends $Notifier<void> {
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
