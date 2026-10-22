// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souls.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Suivi des âmes: the people the signed-in member follows, kept on the
/// server (SoulsApi) and on the phone for this account (SoulsStorage), to
/// work offline: a change is written here at once and sent to the server,
/// again later when it can't be now; the server's list then comes back. The
/// souls an older version kept on the phone only are sent once. A day
/// planned to contact someone brings a reminder at 9 o'clock that names
/// nobody (it shows on a locked screen).

@ProviderFor(Souls)
final soulsProvider = SoulsProvider._();

/// Suivi des âmes: the people the signed-in member follows, kept on the
/// server (SoulsApi) and on the phone for this account (SoulsStorage), to
/// work offline: a change is written here at once and sent to the server,
/// again later when it can't be now; the server's list then comes back. The
/// souls an older version kept on the phone only are sent once. A day
/// planned to contact someone brings a reminder at 9 o'clock that names
/// nobody (it shows on a locked screen).
final class SoulsProvider extends $AsyncNotifierProvider<Souls, List<Soul>> {
  /// Suivi des âmes: the people the signed-in member follows, kept on the
  /// server (SoulsApi) and on the phone for this account (SoulsStorage), to
  /// work offline: a change is written here at once and sent to the server,
  /// again later when it can't be now; the server's list then comes back. The
  /// souls an older version kept on the phone only are sent once. A day
  /// planned to contact someone brings a reminder at 9 o'clock that names
  /// nobody (it shows on a locked screen).
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

String _$soulsHash() => r'357cedd186338610ecf42c849f75a701fd60a62e';

/// Suivi des âmes: the people the signed-in member follows, kept on the
/// server (SoulsApi) and on the phone for this account (SoulsStorage), to
/// work offline: a change is written here at once and sent to the server,
/// again later when it can't be now; the server's list then comes back. The
/// souls an older version kept on the phone only are sent once. A day
/// planned to contact someone brings a reminder at 9 o'clock that names
/// nobody (it shows on a locked screen).

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
