// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_reports.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The days saved without network, by date. They are sent again when the
/// network comes back, when the app comes to the front, and after a save.

@ProviderFor(PendingReports)
final pendingReportsProvider = PendingReportsProvider._();

/// The days saved without network, by date. They are sent again when the
/// network comes back, when the app comes to the front, and after a save.
final class PendingReportsProvider
    extends $NotifierProvider<PendingReports, Set<DateTime>> {
  /// The days saved without network, by date. They are sent again when the
  /// network comes back, when the app comes to the front, and after a save.
  PendingReportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingReportsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingReportsHash();

  @$internal
  @override
  PendingReports create() => PendingReports();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<DateTime> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<DateTime>>(value),
    );
  }
}

String _$pendingReportsHash() => r'f496cedd8b1dddd8c6d0ff5695b260a09b1ce4ab';

/// The days saved without network, by date. They are sent again when the
/// network comes back, when the app comes to the front, and after a save.

abstract class _$PendingReports extends $Notifier<Set<DateTime>> {
  Set<DateTime> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<DateTime>, Set<DateTime>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<DateTime>, Set<DateTime>>,
              Set<DateTime>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
