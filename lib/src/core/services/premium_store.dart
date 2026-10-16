import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../config/flavor.dart';
import '../session/session.dart';
import '../storage/account_storage.dart';

part 'premium_store.g.dart';

enum PremiumPeriod {
  monthly(1),
  semiannual(6),
  annual(12),

  /// Paid once, never renewed.
  lifetime(0);

  const PremiumPeriod(this.months);

  /// What one payment covers; 0 for [lifetime].
  final int months;
}

/// A subscription as the store sells it, in the user's currency.
class PremiumPlan {
  const PremiumPlan({
    required this.period,
    required this.price,
    required this.amount,
    this.pricePerMonth,
    this.trialDays,
    this.trialMonths,
    this.handle,
  });

  final PremiumPeriod period;

  /// "4,99 €", "2 000 FCFA": written by the store.
  final String price;
  final double amount;

  /// For the 6-month and yearly plans: their price per month ("1,25 €").
  final String? pricePerMonth;

  /// A free trial, in days (or in months), when there is one.
  final int? trialDays;
  final int? trialMonths;

  /// What the store needs to sell it.
  final Object? handle;
}

/// The Premium subscription (RevenueCat, entitlement "cmfi_connect_pro"). Behind a
/// provider: tests use a fake, and without a key (AppConfig) Premium is
/// simply never active.
abstract class PremiumStore {
  /// The purchases follow the account, from one phone to another.
  Future<void> logIn(String userId);
  Future<void> logOut();
  Future<bool> isActive();

  /// Premium starts or ends (bought, restored, expired).
  Stream<bool> get changes;

  /// The monthly, 6-month, yearly and lifetime plans of the store; empty
  /// when unreachable.
  Future<List<PremiumPlan>> plans();

  /// true once bought, false when the user closed the store's sheet. Throws
  /// when the store refuses.
  Future<bool> buy(PremiumPlan plan);

  /// Premium bought on another phone or before reinstalling: true if found.
  Future<bool> restore();

  /// "Gérer mon abonnement": RevenueCat's Customer Center (cancel, ask for a
  /// refund, restore, change plan). Throws when it can't open.
  Future<void> manage();
}

class NoPremiumStore implements PremiumStore {
  const NoPremiumStore();

  @override
  Future<void> logIn(String userId) async {}

  @override
  Future<void> logOut() async {}

  @override
  Future<bool> isActive() async => false;

  @override
  Stream<bool> get changes => const Stream.empty();

  @override
  Future<List<PremiumPlan>> plans() async => const [];

  @override
  Future<bool> buy(PremiumPlan plan) async => false;

  @override
  Future<bool> restore() async => false;

  @override
  Future<void> manage() async {}
}

class RevenueCatStore implements PremiumStore {
  RevenueCatStore(this._apiKey);

  static const entitlement = 'cmfi_connect_pro';

  final String _apiKey;
  final _changes = StreamController<bool>.broadcast();
  Future<void>? _ready;

  Future<void> _configure({String? userId}) => _ready ??= () async {
    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.warn);
    }
    await Purchases.configure(
      PurchasesConfiguration(_apiKey)..appUserID = userId,
    );
    Purchases.addCustomerInfoUpdateListener(
      (info) => _changes.add(_active(info)),
    );
  }();

  static bool _active(CustomerInfo info) =>
      info.entitlements.active.containsKey(entitlement);

  @override
  Future<void> logIn(String userId) async {
    if (_ready == null) {
      await _configure(userId: userId);
      return;
    }
    await _ready;
    final result = await Purchases.logIn(userId);
    _changes.add(_active(result.customerInfo));
  }

  @override
  Future<void> logOut() async {
    if (_ready == null) {
      return;
    }
    await _ready;
    try {
      _changes.add(_active(await Purchases.logOut()));
    } on PlatformException {
      // already anonymous
    }
  }

  @override
  Future<bool> isActive() async {
    await _configure();
    try {
      return _active(await Purchases.getCustomerInfo());
    } on PlatformException {
      return false;
    }
  }

  @override
  Stream<bool> get changes => _changes.stream;

  @override
  Future<List<PremiumPlan>> plans() async {
    await _configure();
    try {
      final offering = (await Purchases.getOfferings()).current;
      return [
        if (offering?.monthly case final package?)
          _plan(package, PremiumPeriod.monthly),
        if (offering?.sixMonth case final package?)
          _plan(package, PremiumPeriod.semiannual),
        if (offering?.annual case final package?)
          _plan(package, PremiumPeriod.annual),
        if (offering?.lifetime case final package?)
          _plan(package, PremiumPeriod.lifetime),
      ];
    } on PlatformException {
      return const [];
    }
  }

  static PremiumPlan _plan(Package package, PremiumPeriod period) {
    final product = package.storeProduct;
    final intro = product.introductoryPrice;
    final free = intro != null && intro.price == 0;
    final units = intro?.periodNumberOfUnits ?? 0;
    return PremiumPlan(
      period: period,
      price: product.priceString,
      amount: product.price,
      pricePerMonth:
          period == PremiumPeriod.monthly || period == PremiumPeriod.lifetime
          ? null
          : product.pricePerMonthString,
      trialDays: !free
          ? null
          : switch (intro.periodUnit) {
              PeriodUnit.day => units,
              PeriodUnit.week => units * 7,
              _ => null,
            },
      trialMonths: !free
          ? null
          : switch (intro.periodUnit) {
              PeriodUnit.month => units,
              PeriodUnit.year => units * 12,
              _ => null,
            },
      handle: package,
    );
  }

  @override
  Future<bool> buy(PremiumPlan plan) async {
    await _configure();
    try {
      final result = await Purchases.purchase(
        PurchaseParams.package(plan.handle! as Package),
      );
      return _active(result.customerInfo);
    } on PlatformException catch (error) {
      if (PurchasesErrorHelper.getErrorCode(error) ==
          PurchasesErrorCode.purchaseCancelledError) {
        return false;
      }
      rethrow;
    }
  }

  @override
  Future<bool> restore() async {
    await _configure();
    return _active(await Purchases.restorePurchases());
  }

  @override
  Future<void> manage() async {
    await _configure();
    // what changed there comes back through the customer info listener
    await RevenueCatUI.presentCustomerCenter();
  }
}

@Riverpod(keepAlive: true)
PremiumStore premiumStore(Ref ref) {
  final key = ref.watch(appConfigProvider).revenueCatKey;
  return key.isEmpty ? const NoPremiumStore() : RevenueCatStore(key);
}

/// v1: in the published app (prod), Premium is offered to everyone (the
/// purchases come in v1.1): the widget, the year of the summary and the
/// progress of the goals are open, and nothing leads to the paywall. The dev
/// app sells it, with the RevenueCat Test Store (no real payment). Return
/// false for prod too to open the purchases.
@Riverpod(keepAlive: true)
bool premiumForEveryone(Ref ref) => ref.watch(flavorProvider) == Flavor.prod;

/// Whether the signed-in member has Premium (the home-screen widget, the
/// year and the progress of the goals in the summary). false while unknown.
/// The team (admins and superadmins) has it without paying: the role of the
/// account saved at sign-in, refreshed at each launch (GET /v1/users/me).
/// Always true while [premiumForEveryone].
@Riverpod(keepAlive: true)
class Premium extends _$Premium {
  @override
  Future<bool> build() async {
    if (ref.watch(premiumForEveryoneProvider)) {
      return true;
    }
    final store = ref.watch(premiumStoreProvider);
    final staff = await ref.watch(premiumIsOfferedProvider.future);
    final changes = store.changes.listen(
      (active) => state = AsyncData(active || staff),
    );
    ref.onDispose(changes.cancel);
    return staff || await store.isActive();
  }

  /// Bought: Premium at once (the store confirms it as well).
  void activated() => state = const AsyncData(true);
}

/// Premium comes with the role: admins and superadmins don't pay.
@Riverpod(keepAlive: true)
Future<bool> premiumIsOffered(Ref ref) async {
  final status = await ref.watch(sessionProvider.future);
  if (status == SessionStatus.unauthenticated) {
    return false;
  }
  final account = await ref.watch(accountStorageProvider).read();
  return account?.isAdmin ?? false;
}
