// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flavor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Overridden in bootstrap.dart with the real flavor.

@ProviderFor(flavor)
final flavorProvider = FlavorProvider._();

/// Overridden in bootstrap.dart with the real flavor.

final class FlavorProvider extends $FunctionalProvider<Flavor, Flavor, Flavor>
    with $Provider<Flavor> {
  /// Overridden in bootstrap.dart with the real flavor.
  FlavorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flavorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flavorHash();

  @$internal
  @override
  $ProviderElement<Flavor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Flavor create(Ref ref) {
    return flavor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Flavor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Flavor>(value),
    );
  }
}

String _$flavorHash() => r'2ca8b4a72eb1a4363857f0eeb747f929fb8c76c0';
