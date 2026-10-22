// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Raw: the router is a ChangeNotifier that Riverpod neither listens to nor disposes.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// Raw: the router is a ChangeNotifier that Riverpod neither listens to nor disposes.

final class AppRouterProvider
    extends $FunctionalProvider<Raw<AppRouter>, Raw<AppRouter>, Raw<AppRouter>>
    with $Provider<Raw<AppRouter>> {
  /// Raw: the router is a ChangeNotifier that Riverpod neither listens to nor disposes.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<Raw<AppRouter>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Raw<AppRouter> create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Raw<AppRouter> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Raw<AppRouter>>(value),
    );
  }
}

String _$appRouterHash() => r'12e0c1db97fa01d1d84d767ab8121f10983e430d';
