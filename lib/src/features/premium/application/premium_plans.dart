import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/premium_store.dart';

part 'premium_plans.g.dart';

/// The monthly and yearly plans, with the store's prices.
@riverpod
Future<List<PremiumPlan>> premiumPlans(Ref ref) =>
    ref.watch(premiumStoreProvider).plans();
