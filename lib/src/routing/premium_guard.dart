import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/services/premium_store.dart';
import 'app_router.dart';

/// On the pages Premium opens (« Ton année avec Dieu »): without Premium, the
/// Premium page comes instead, whatever led there (the home card, Plus, the
/// notification of the end of the year).
class PremiumGuard extends AutoRouteGuard {
  PremiumGuard(this._ref);

  final Ref _ref;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    bool premium;
    try {
      premium = await _ref.read(premiumProvider.future);
    } on Object {
      premium = false;
    }
    if (premium) {
      resolver.next();
    } else {
      resolver.next(false);
      // after the current navigation is over
      scheduleMicrotask(() => router.root.push(const PremiumRoute()));
    }
  }
}
