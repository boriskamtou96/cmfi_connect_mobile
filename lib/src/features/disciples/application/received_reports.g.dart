// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'received_reports.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The reports the disciples sent the user in the app (« Comptes rendus
/// reçus »), a page at a time; opened and answered here.

@ProviderFor(ReceivedReports)
final receivedReportsProvider = ReceivedReportsProvider._();

/// The reports the disciples sent the user in the app (« Comptes rendus
/// reçus »), a page at a time; opened and answered here.
final class ReceivedReportsProvider
    extends $AsyncNotifierProvider<ReceivedReports, ReceivedReportsState> {
  /// The reports the disciples sent the user in the app (« Comptes rendus
  /// reçus »), a page at a time; opened and answered here.
  ReceivedReportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receivedReportsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receivedReportsHash();

  @$internal
  @override
  ReceivedReports create() => ReceivedReports();
}

String _$receivedReportsHash() => r'4d5577b270883a616f1db5eb4c97effd86c3ae85';

/// The reports the disciples sent the user in the app (« Comptes rendus
/// reçus »), a page at a time; opened and answered here.

abstract class _$ReceivedReports extends $AsyncNotifier<ReceivedReportsState> {
  FutureOr<ReceivedReportsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ReceivedReportsState>, ReceivedReportsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ReceivedReportsState>,
                ReceivedReportsState
              >,
              AsyncValue<ReceivedReportsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The reports received not opened yet (the newest page): the badge of
/// Plus; 0 without network.

@ProviderFor(receivedReportsUnread)
final receivedReportsUnreadProvider = ReceivedReportsUnreadProvider._();

/// The reports received not opened yet (the newest page): the badge of
/// Plus; 0 without network.

final class ReceivedReportsUnreadProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// The reports received not opened yet (the newest page): the badge of
  /// Plus; 0 without network.
  ReceivedReportsUnreadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receivedReportsUnreadProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receivedReportsUnreadHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return receivedReportsUnread(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$receivedReportsUnreadHash() =>
    r'c3fb00bbdb3b97a4b8baed73d93afd24039760cc';
