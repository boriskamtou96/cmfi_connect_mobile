// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_plans.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The monthly and yearly plans, with the store's prices.

@ProviderFor(premiumPlans)
final premiumPlansProvider = PremiumPlansProvider._();

/// The monthly and yearly plans, with the store's prices.

final class PremiumPlansProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PremiumPlan>>,
          List<PremiumPlan>,
          FutureOr<List<PremiumPlan>>
        >
    with
        $FutureModifier<List<PremiumPlan>>,
        $FutureProvider<List<PremiumPlan>> {
  /// The monthly and yearly plans, with the store's prices.
  PremiumPlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'premiumPlansProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$premiumPlansHash();

  @$internal
  @override
  $FutureProviderElement<List<PremiumPlan>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PremiumPlan>> create(Ref ref) {
    return premiumPlans(ref);
  }
}

String _$premiumPlansHash() => r'2a1306276dab1ea4eac9d78c5b9a0ae3735119cc';
