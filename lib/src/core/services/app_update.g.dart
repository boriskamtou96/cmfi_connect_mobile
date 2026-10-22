// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateRulesSource)
final updateRulesSourceProvider = UpdateRulesSourceProvider._();

final class UpdateRulesSourceProvider
    extends
        $FunctionalProvider<
          UpdateRulesSource,
          UpdateRulesSource,
          UpdateRulesSource
        >
    with $Provider<UpdateRulesSource> {
  UpdateRulesSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateRulesSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateRulesSourceHash();

  @$internal
  @override
  $ProviderElement<UpdateRulesSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateRulesSource create(Ref ref) {
    return updateRulesSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateRulesSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateRulesSource>(value),
    );
  }
}

String _$updateRulesSourceHash() => r'abb675743de6e5121528a3239f7c6e5f1cdb587a';

@ProviderFor(appInstaller)
final appInstallerProvider = AppInstallerProvider._();

final class AppInstallerProvider
    extends $FunctionalProvider<AppInstaller, AppInstaller, AppInstaller>
    with $Provider<AppInstaller> {
  AppInstallerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appInstallerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInstallerHash();

  @$internal
  @override
  $ProviderElement<AppInstaller> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppInstaller create(Ref ref) {
    return appInstaller(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppInstaller value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppInstaller>(value),
    );
  }
}

String _$appInstallerHash() => r'db22f7d7ecc0e69e7d2f0ddc9f8cc8ef9c8000d5';

/// Where this phone stands, read at launch, again when the app comes back
/// and as soon as the rules change. AppUpdateGate locks the app when the
/// update is required; SignedInTasks offers it once per version otherwise.

@ProviderFor(AppUpdate)
final appUpdateProvider = AppUpdateProvider._();

/// Where this phone stands, read at launch, again when the app comes back
/// and as soon as the rules change. AppUpdateGate locks the app when the
/// update is required; SignedInTasks offers it once per version otherwise.
final class AppUpdateProvider
    extends $AsyncNotifierProvider<AppUpdate, AppUpdateStatus> {
  /// Where this phone stands, read at launch, again when the app comes back
  /// and as soon as the rules change. AppUpdateGate locks the app when the
  /// update is required; SignedInTasks offers it once per version otherwise.
  AppUpdateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appUpdateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appUpdateHash();

  @$internal
  @override
  AppUpdate create() => AppUpdate();
}

String _$appUpdateHash() => r'dd2a0a691dc6b01186aba2bad33408be5f350e74';

/// Where this phone stands, read at launch, again when the app comes back
/// and as soon as the rules change. AppUpdateGate locks the app when the
/// update is required; SignedInTasks offers it once per version otherwise.

abstract class _$AppUpdate extends $AsyncNotifier<AppUpdateStatus> {
  FutureOr<AppUpdateStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppUpdateStatus>, AppUpdateStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppUpdateStatus>, AppUpdateStatus>,
              AsyncValue<AppUpdateStatus>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
