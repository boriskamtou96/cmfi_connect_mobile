// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seen_tours.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The spaces whose short tour was already shown on this phone: each space
/// presents itself once, the first time the member arrives there (23/11/2026).
/// « Revoir la présentation des espaces » (Réglages) forgets them all.

@ProviderFor(SeenTours)
final seenToursProvider = SeenToursProvider._();

/// The spaces whose short tour was already shown on this phone: each space
/// presents itself once, the first time the member arrives there (23/11/2026).
/// « Revoir la présentation des espaces » (Réglages) forgets them all.
final class SeenToursProvider
    extends $NotifierProvider<SeenTours, Set<TourSpace>> {
  /// The spaces whose short tour was already shown on this phone: each space
  /// presents itself once, the first time the member arrives there (23/11/2026).
  /// « Revoir la présentation des espaces » (Réglages) forgets them all.
  SeenToursProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seenToursProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seenToursHash();

  @$internal
  @override
  SeenTours create() => SeenTours();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<TourSpace> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<TourSpace>>(value),
    );
  }
}

String _$seenToursHash() => r'3324c0abcfc74b054c9fe79629179433d377e568';

/// The spaces whose short tour was already shown on this phone: each space
/// presents itself once, the first time the member arrives there (23/11/2026).
/// « Revoir la présentation des espaces » (Réglages) forgets them all.

abstract class _$SeenTours extends $Notifier<Set<TourSpace>> {
  Set<TourSpace> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<TourSpace>, Set<TourSpace>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<TourSpace>, Set<TourSpace>>,
              Set<TourSpace>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
