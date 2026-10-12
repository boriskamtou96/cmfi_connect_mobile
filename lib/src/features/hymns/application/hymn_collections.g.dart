// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_collections.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Hymns starred by the user, most recent first. Kept on the phone.

@ProviderFor(FavoriteHymns)
final favoriteHymnsProvider = FavoriteHymnsProvider._();

/// Hymns starred by the user, most recent first. Kept on the phone.
final class FavoriteHymnsProvider
    extends $NotifierProvider<FavoriteHymns, List<HymnRef>> {
  /// Hymns starred by the user, most recent first. Kept on the phone.
  FavoriteHymnsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteHymnsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteHymnsHash();

  @$internal
  @override
  FavoriteHymns create() => FavoriteHymns();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<HymnRef> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<HymnRef>>(value),
    );
  }
}

String _$favoriteHymnsHash() => r'391c010c230b07f61028d591f8ab8de4aca5096a';

/// Hymns starred by the user, most recent first. Kept on the phone.

abstract class _$FavoriteHymns extends $Notifier<List<HymnRef>> {
  List<HymnRef> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<HymnRef>, List<HymnRef>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<HymnRef>, List<HymnRef>>,
              List<HymnRef>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The last hymns opened, most recent first.

@ProviderFor(RecentHymns)
final recentHymnsProvider = RecentHymnsProvider._();

/// The last hymns opened, most recent first.
final class RecentHymnsProvider
    extends $NotifierProvider<RecentHymns, List<HymnRef>> {
  /// The last hymns opened, most recent first.
  RecentHymnsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentHymnsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentHymnsHash();

  @$internal
  @override
  RecentHymns create() => RecentHymns();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<HymnRef> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<HymnRef>>(value),
    );
  }
}

String _$recentHymnsHash() => r'18997eec5af094254454f2d629210f462fd98671';

/// The last hymns opened, most recent first.

abstract class _$RecentHymns extends $Notifier<List<HymnRef>> {
  List<HymnRef> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<HymnRef>, List<HymnRef>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<HymnRef>, List<HymnRef>>,
              List<HymnRef>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
