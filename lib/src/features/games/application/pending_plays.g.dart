// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_plays.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The plays that could not be sent, kept on the phone (key
/// `games_pending_plays`) until the network is back: a lesson finished is
/// never lost. They are sent again when the tab reads its path; the client
/// id makes a play count once, even sent twice.

@ProviderFor(PendingGamePlays)
final pendingGamePlaysProvider = PendingGamePlaysProvider._();

/// The plays that could not be sent, kept on the phone (key
/// `games_pending_plays`) until the network is back: a lesson finished is
/// never lost. They are sent again when the tab reads its path; the client
/// id makes a play count once, even sent twice.
final class PendingGamePlaysProvider
    extends $NotifierProvider<PendingGamePlays, List<PendingPlay>> {
  /// The plays that could not be sent, kept on the phone (key
  /// `games_pending_plays`) until the network is back: a lesson finished is
  /// never lost. They are sent again when the tab reads its path; the client
  /// id makes a play count once, even sent twice.
  PendingGamePlaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingGamePlaysProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingGamePlaysHash();

  @$internal
  @override
  PendingGamePlays create() => PendingGamePlays();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PendingPlay> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PendingPlay>>(value),
    );
  }
}

String _$pendingGamePlaysHash() => r'b47963e798d7eb9608d0dfe029727904917bce73';

/// The plays that could not be sent, kept on the phone (key
/// `games_pending_plays`) until the network is back: a lesson finished is
/// never lost. They are sent again when the tab reads its path; the client
/// id makes a play count once, even sent twice.

abstract class _$PendingGamePlays extends $Notifier<List<PendingPlay>> {
  List<PendingPlay> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<PendingPlay>, List<PendingPlay>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<PendingPlay>, List<PendingPlay>>,
              List<PendingPlay>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
