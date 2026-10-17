// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souls.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Suivi des âmes: the people the signed-in member follows, kept on the
/// phone for this account (SoulsStorage). A day planned to contact someone
/// brings a reminder at 9 o'clock that names nobody (it shows on a locked
/// screen).

@ProviderFor(Souls)
final soulsProvider = SoulsProvider._();

/// Suivi des âmes: the people the signed-in member follows, kept on the
/// phone for this account (SoulsStorage). A day planned to contact someone
/// brings a reminder at 9 o'clock that names nobody (it shows on a locked
/// screen).
final class SoulsProvider extends $AsyncNotifierProvider<Souls, List<Soul>> {
  /// Suivi des âmes: the people the signed-in member follows, kept on the
  /// phone for this account (SoulsStorage). A day planned to contact someone
  /// brings a reminder at 9 o'clock that names nobody (it shows on a locked
  /// screen).
  SoulsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'soulsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$soulsHash();

  @$internal
  @override
  Souls create() => Souls();
}

String _$soulsHash() => r'3a34dbd83d2cae73da3b5074c7b7b494e2ea59ea';

/// Suivi des âmes: the people the signed-in member follows, kept on the
/// phone for this account (SoulsStorage). A day planned to contact someone
/// brings a reminder at 9 o'clock that names nobody (it shows on a locked
/// screen).

abstract class _$Souls extends $AsyncNotifier<List<Soul>> {
  FutureOr<List<Soul>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Soul>>, List<Soul>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Soul>>, List<Soul>>,
              AsyncValue<List<Soul>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The lock of Suivi des âmes (key `souls_lock`): Face ID or the fingerprint
/// each time the list is opened.

@ProviderFor(SoulsLock)
final soulsLockProvider = SoulsLockProvider._();

/// The lock of Suivi des âmes (key `souls_lock`): Face ID or the fingerprint
/// each time the list is opened.
final class SoulsLockProvider extends $NotifierProvider<SoulsLock, bool> {
  /// The lock of Suivi des âmes (key `souls_lock`): Face ID or the fingerprint
  /// each time the list is opened.
  SoulsLockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'soulsLockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$soulsLockHash();

  @$internal
  @override
  SoulsLock create() => SoulsLock();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$soulsLockHash() => r'707270cd15fe1441f6e72df2ae0a38bccd1a3575';

/// The lock of Suivi des âmes (key `souls_lock`): Face ID or the fingerprint
/// each time the list is opened.

abstract class _$SoulsLock extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
