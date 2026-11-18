import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/premium_store.dart';

part 'premium_plans.g.dart';

/// The plans of the store (App Store, Google Play), with their prices.
@riverpod
Future<List<PremiumPlan>> premiumPlans(Ref ref) =>
    ref.watch(premiumStoreProvider).plans();
