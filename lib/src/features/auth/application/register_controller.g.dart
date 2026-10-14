// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Step 1 of the sign-up: creates the account, then signs in with it
/// (the API gives no token on register).

@ProviderFor(RegisterController)
final registerControllerProvider = RegisterControllerProvider._();

/// Step 1 of the sign-up: creates the account, then signs in with it
/// (the API gives no token on register).
final class RegisterControllerProvider
    extends $AsyncNotifierProvider<RegisterController, void> {
  /// Step 1 of the sign-up: creates the account, then signs in with it
  /// (the API gives no token on register).
  RegisterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerControllerHash();

  @$internal
  @override
  RegisterController create() => RegisterController();
}

String _$registerControllerHash() =>
    r'0e1df902dddd32a0e83248564501c06d3682d013';

/// Step 1 of the sign-up: creates the account, then signs in with it
/// (the API gives no token on register).

abstract class _$RegisterController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
