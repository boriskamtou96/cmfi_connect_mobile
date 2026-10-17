// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_account.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in account as the server has it now (pseudo, role), kept on the
/// phone. Without network, the copy saved at the last sign-in or refresh.

@ProviderFor(MyAccount)
final myAccountProvider = MyAccountProvider._();

/// The signed-in account as the server has it now (pseudo, role), kept on the
/// phone. Without network, the copy saved at the last sign-in or refresh.
final class MyAccountProvider
    extends $AsyncNotifierProvider<MyAccount, Account?> {
  /// The signed-in account as the server has it now (pseudo, role), kept on the
  /// phone. Without network, the copy saved at the last sign-in or refresh.
  MyAccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myAccountProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myAccountHash();

  @$internal
  @override
  MyAccount create() => MyAccount();
}

String _$myAccountHash() => r'ca878c122fed4aa56345eff3b015df5393ff60de';

/// The signed-in account as the server has it now (pseudo, role), kept on the
/// phone. Without network, the copy saved at the last sign-in or refresh.

abstract class _$MyAccount extends $AsyncNotifier<Account?> {
  FutureOr<Account?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Account?>, Account?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Account?>, Account?>,
              AsyncValue<Account?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
