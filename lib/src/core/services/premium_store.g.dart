// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(premiumStore)
final premiumStoreProvider = PremiumStoreProvider._();

final class PremiumStoreProvider
    extends $FunctionalProvider<PremiumStore, PremiumStore, PremiumStore>
    with $Provider<PremiumStore> {
  PremiumStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'premiumStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$premiumStoreHash();

  @$internal
  @override
  $ProviderElement<PremiumStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PremiumStore create(Ref ref) {
    return premiumStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PremiumStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PremiumStore>(value),
    );
  }
}

String _$premiumStoreHash() => r'4344947680dffcc6e220a2733ebf5bd4af98c498';

/// Premium offered to everyone: the widget, the year of the summary and the
/// progress of the goals open, and nothing leading to the paywall. It was so
/// in the published app of v1; Premium is sold in the stores and on the
/// website now. Kept to
/// offer it again if ever needed: return true.

@ProviderFor(premiumForEveryone)
final premiumForEveryoneProvider = PremiumForEveryoneProvider._();

/// Premium offered to everyone: the widget, the year of the summary and the
/// progress of the goals open, and nothing leading to the paywall. It was so
/// in the published app of v1; Premium is sold in the stores and on the
/// website now. Kept to
/// offer it again if ever needed: return true.

final class PremiumForEveryoneProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Premium offered to everyone: the widget, the year of the summary and the
  /// progress of the goals open, and nothing leading to the paywall. It was so
  /// in the published app of v1; Premium is sold in the stores and on the
  /// website now. Kept to
  /// offer it again if ever needed: return true.
  PremiumForEveryoneProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'premiumForEveryoneProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$premiumForEveryoneHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return premiumForEveryone(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$premiumForEveryoneHash() =>
    r'57abe0cb68d701cefe358ab8c851c214631569fc';

/// Whether the signed-in member has Premium (the home-screen widget, the
/// year and the progress of the goals in the summary). false while unknown.
/// The team (admins and superadmins) has it without paying: the role of the
/// account saved at sign-in, refreshed at each launch (GET /v1/users/me).
/// Always true while [premiumForEveryone].

@ProviderFor(Premium)
final premiumProvider = PremiumProvider._();

/// Whether the signed-in member has Premium (the home-screen widget, the
/// year and the progress of the goals in the summary). false while unknown.
/// The team (admins and superadmins) has it without paying: the role of the
/// account saved at sign-in, refreshed at each launch (GET /v1/users/me).
/// Always true while [premiumForEveryone].
final class PremiumProvider extends $AsyncNotifierProvider<Premium, bool> {
  /// Whether the signed-in member has Premium (the home-screen widget, the
  /// year and the progress of the goals in the summary). false while unknown.
  /// The team (admins and superadmins) has it without paying: the role of the
  /// account saved at sign-in, refreshed at each launch (GET /v1/users/me).
  /// Always true while [premiumForEveryone].
  PremiumProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'premiumProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$premiumHash();

  @$internal
  @override
  Premium create() => Premium();
}

String _$premiumHash() => r'382a587e0fbf7a7005a1e88d5d14e0e56b8c5246';

/// Whether the signed-in member has Premium (the home-screen widget, the
/// year and the progress of the goals in the summary). false while unknown.
/// The team (admins and superadmins) has it without paying: the role of the
/// account saved at sign-in, refreshed at each launch (GET /v1/users/me).
/// Always true while [premiumForEveryone].

abstract class _$Premium extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Premium comes with the role: admins and superadmins don't pay.

@ProviderFor(premiumIsOffered)
final premiumIsOfferedProvider = PremiumIsOfferedProvider._();

/// Premium comes with the role: admins and superadmins don't pay.

final class PremiumIsOfferedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Premium comes with the role: admins and superadmins don't pay.
  PremiumIsOfferedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'premiumIsOfferedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$premiumIsOfferedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return premiumIsOffered(ref);
  }
}

String _$premiumIsOfferedHash() => r'1ed1c1aa1a91d7560ab6bcda817e5d4c963887a3';

/// The user of the store for an account: its number (« 12 »). In the dev app
/// only, « Annuler la souscription (dev) » (18/11/2026, in « Vous ») gives it
/// a new one (« 12-dev-1731… », kept on the phone): the purchase of the Test
/// Store stays with the old user, so Premium can be bought again. Premium
/// bought on the website or offered to the team does not change.

@ProviderFor(devSubscription)
final devSubscriptionProvider = DevSubscriptionProvider._();

/// The user of the store for an account: its number (« 12 »). In the dev app
/// only, « Annuler la souscription (dev) » (18/11/2026, in « Vous ») gives it
/// a new one (« 12-dev-1731… », kept on the phone): the purchase of the Test
/// Store stays with the old user, so Premium can be bought again. Premium
/// bought on the website or offered to the team does not change.

final class DevSubscriptionProvider
    extends
        $FunctionalProvider<DevSubscription, DevSubscription, DevSubscription>
    with $Provider<DevSubscription> {
  /// The user of the store for an account: its number (« 12 »). In the dev app
  /// only, « Annuler la souscription (dev) » (18/11/2026, in « Vous ») gives it
  /// a new one (« 12-dev-1731… », kept on the phone): the purchase of the Test
  /// Store stays with the old user, so Premium can be bought again. Premium
  /// bought on the website or offered to the team does not change.
  DevSubscriptionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devSubscriptionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devSubscriptionHash();

  @$internal
  @override
  $ProviderElement<DevSubscription> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DevSubscription create(Ref ref) {
    return devSubscription(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DevSubscription value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DevSubscription>(value),
    );
  }
}

String _$devSubscriptionHash() => r'9b993e1afa0ee805bf897c835ff913a331acfcbd';
