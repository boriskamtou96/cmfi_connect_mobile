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

String _$premiumStoreHash() => r'bc858f62f0ff7df01e4e80ab4f76f68d1eddb08a';

/// v1: Premium is offered to everyone (the purchases come in v1.1): the
/// widget, the year of the summary and the progress of the goals are open,
/// and nothing leads to the paywall. Set to false to open the purchases; all
/// the Premium code stays in place.

@ProviderFor(premiumForEveryone)
final premiumForEveryoneProvider = PremiumForEveryoneProvider._();

/// v1: Premium is offered to everyone (the purchases come in v1.1): the
/// widget, the year of the summary and the progress of the goals are open,
/// and nothing leads to the paywall. Set to false to open the purchases; all
/// the Premium code stays in place.

final class PremiumForEveryoneProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// v1: Premium is offered to everyone (the purchases come in v1.1): the
  /// widget, the year of the summary and the progress of the goals are open,
  /// and nothing leads to the paywall. Set to false to open the purchases; all
  /// the Premium code stays in place.
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
    r'1fa6ffac897c468af6dcbb7b0a2480118d12a797';

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

String _$premiumHash() => r'5773c1852114b398956ccd15349f8f37a7ad47ad';

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
