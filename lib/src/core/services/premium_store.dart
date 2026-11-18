import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../network/api_call.dart';
import '../network/dio_provider.dart';
import '../session/session.dart';
import '../storage/account_storage.dart';
import 'app_log.dart';

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

/// A plan as the store (App Store, Google Play) sells it, in the user's
/// currency.
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

/// A purchase waiting for an approval (Ask to Buy, a deferred payment):
/// Premium opens once it is accepted, through [PremiumStore.changes].
class PurchasePending implements Exception {
  const PurchasePending();
}

/// Premium renewed by itself (chosen on the site when paying by mobile
/// money): the day before the end, the server sends the payment request of
/// the same plan to [phoneNumber]; the member types the PIN.
class PremiumRenewal {
  const PremiumRenewal({
    required this.plan,
    required this.phoneNumber,
    required this.nextRequestAt,
  });

  factory PremiumRenewal.fromJson(Map<String, dynamic> json) => PremiumRenewal(
    plan: '${json['plan'] ?? ''}',
    phoneNumber: '${json['phone_number'] ?? ''}',
    nextRequestAt:
        DateTime.tryParse('${json['next_request_at'] ?? ''}')?.toLocal() ??
        DateTime.now(),
  );

  final String plan;
  final String phoneNumber;

  /// When the next payment request goes.
  final DateTime nextRequestAt;
}

/// The Premium of the signed-in member, from two sources: the server
/// (bought on cmfi-connect.com, offered by the admins: GET
/// /v1/premium/status) and the store of the phone (App Store, Google Play,
/// through RevenueCat, entitlement "cmfi_connect_pro"). Behind a provider:
/// tests use a fake.
abstract class PremiumStore {
  /// [userId] signed in: their Premium is asked, and the store's purchases
  /// follow the account from one phone to another.
  Future<void> logIn(String userId);

  /// Signed out: no Premium any more.
  Future<void> logOut();
  Future<bool> isActive();

  /// When the Premium bought or offered ends, as last known; null without
  /// one, or for life.
  DateTime? get until;

  /// The renewal by payment request, as last known; null without one.
  PremiumRenewal? get renewal;

  /// No more payment requests: Premium goes on to its end
  /// (DELETE /v1/premium/renewal).
  Future<void> stopRenewal();

  /// Premium starts or ends (bought on the site, offered, over).
  Stream<bool> get changes;

  /// Asks the server and the store again: Premium bought on the website,
  /// offered by the admins or bought on another phone shows at once.
  Future<void> refresh();

  /// The monthly, 6-month, yearly and lifetime plans of the store; empty
  /// when unreachable, or without a store key.
  Future<List<PremiumPlan>> plans();

  /// true once bought, false when the user closed the store's sheet. Throws
  /// when the store refuses.
  Future<bool> buy(PremiumPlan plan);

  /// Premium bought in the store on another phone or before reinstalling:
  /// true if found.
  Future<bool> restore();

  /// "Gérer mon abonnement": RevenueCat's Customer Center (cancel, ask for a
  /// refund, restore, change plan). Throws when it can't open.
  Future<void> manage();

  /// Premium comes from the store (managed there), as last known.
  bool get boughtInStore;
}

/// Premium as the server keeps it: bought on the site, offered.
class ServerPremiumStore {
  ServerPremiumStore(this._dio);

  final Dio _dio;
  final _changes = StreamController<bool>.broadcast();

  /// The last answer, kept for when the network is gone.
  var _active = false;
  DateTime? _until;
  PremiumRenewal? _renewal;

  DateTime? get until => _until;

  PremiumRenewal? get renewal => _renewal;

  Future<void> stopRenewal() async {
    await apiCall(() => _dio.delete<void>('/premium/renewal'));
    _renewal = null;
    _changes.add(_active);
  }

  Future<void> logIn(String userId) => refresh();

  Future<void> logOut() async {
    _active = false;
    _until = null;
    _renewal = null;
    _changes.add(false);
  }

  Future<bool> isActive() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/premium/status');
      final status = response.content;
      final until = DateTime.tryParse('${status['until'] ?? ''}');
      final lifetime = status['lifetime'] == true;
      _until = lifetime ? null : until?.toLocal();
      final renewal = status['renewal'];
      _renewal = !lifetime && renewal is Map<String, dynamic>
          ? PremiumRenewal.fromJson(renewal)
          : null;
      _active = lifetime || (until != null && until.isAfter(DateTime.now()));
    } on DioException {
      // offline: what was known
    }
    return _active;
  }

  Stream<bool> get changes => _changes.stream;

  Future<void> refresh() async => _changes.add(await isActive());
}

/// The store of the phone, through RevenueCat. Behind an interface: tests
/// use a fake, and without a key nothing is sold in the app.
abstract class PremiumShop {
  Future<void> logIn(String userId);
  Future<void> logOut();
  Future<bool> isActive();

  /// Premium bought, restored or over in the store.
  Stream<bool> get changes;
  Future<List<PremiumPlan>> plans();
  Future<bool> buy(PremiumPlan plan);
  Future<bool> restore();
  Future<void> manage();
  Future<void> refresh();
}

class NoPremiumShop implements PremiumShop {
  const NoPremiumShop();

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

  @override
  Future<void> refresh() async {}
}

class RevenueCatShop implements PremiumShop {
  RevenueCatShop(this._apiKey);

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
    try {
      await _configure();
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
      switch (PurchasesErrorHelper.getErrorCode(error)) {
        case PurchasesErrorCode.purchaseCancelledError:
          return false;
        case PurchasesErrorCode.paymentPendingError:
          throw const PurchasePending();
        default:
          rethrow;
      }
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

  @override
  Future<void> refresh() async {
    try {
      await _configure();
      await Purchases.invalidateCustomerInfoCache();
      _changes.add(_active(await Purchases.getCustomerInfo()));
    } on PlatformException {
      // offline: the next launch asks again
    }
  }
}

/// Premium from the site (the server) or from the store (RevenueCat): on
/// when either says so.
class AppPremiumStore implements PremiumStore {
  AppPremiumStore(this._server, this._shop) {
    _server.changes.listen((active) {
      _onServer = active;
      _changes.add(_active);
    });
    _shop.changes.listen((active) {
      _inStore = active;
      _changes.add(_active);
    });
  }

  final ServerPremiumStore _server;
  final PremiumShop _shop;
  final _changes = StreamController<bool>.broadcast();
  var _onServer = false;
  var _inStore = false;

  bool get _active => _onServer || _inStore;

  @override
  bool get boughtInStore => _inStore;

  @override
  DateTime? get until => _server.until;

  @override
  PremiumRenewal? get renewal => _server.renewal;

  @override
  Future<void> stopRenewal() => _server.stopRenewal();

  @override
  Stream<bool> get changes => _changes.stream;

  @override
  Future<void> logIn(String userId) async {
    try {
      await _shop.logIn(userId);
      _inStore = await _shop.isActive();
    } on Object catch (error) {
      // the store unreachable: the site's Premium still counts
      AppLog.info('premium: store unreachable ($error)');
    }
    await _server.logIn(userId);
  }

  @override
  Future<void> logOut() async {
    try {
      await _shop.logOut();
    } on Object catch (error) {
      AppLog.info('premium: store sign-out failed ($error)');
    }
    _inStore = false;
    await _server.logOut();
  }

  @override
  Future<bool> isActive() async {
    _onServer = await _server.isActive();
    try {
      _inStore = await _shop.isActive();
    } on Object {
      // unreachable: what was known
    }
    return _active;
  }

  @override
  Future<void> refresh() async {
    // the site first: a broken store must not hide Premium bought there
    await _server.refresh();
    try {
      await _shop.refresh();
    } on Object catch (error) {
      AppLog.info('premium: store unreachable ($error)');
    }
  }

  @override
  Future<List<PremiumPlan>> plans() => _shop.plans();

  @override
  Future<bool> buy(PremiumPlan plan) async {
    final bought = await _shop.buy(plan);
    if (bought) {
      _inStore = true;
      _changes.add(true);
    }
    return bought;
  }

  @override
  Future<bool> restore() async {
    _inStore = await _shop.restore();
    _changes.add(_active);
    return _inStore;
  }

  @override
  Future<void> manage() => _shop.manage();
}

@Riverpod(keepAlive: true)
PremiumStore premiumStore(Ref ref) {
  final key = ref.watch(appConfigProvider).revenueCatKey;
  return AppPremiumStore(
    ServerPremiumStore(ref.watch(dioProvider)),
    key.isEmpty ? const NoPremiumShop() : RevenueCatShop(key),
  );
}

/// Premium offered to everyone: the widget, the year of the summary and the
/// progress of the goals open, and nothing leading to the paywall. It was so
/// in the published app of v1; Premium is sold in the stores and on the
/// website now. Kept to
/// offer it again if ever needed: return true.
@Riverpod(keepAlive: true)
bool premiumForEveryone(Ref ref) => false;

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
    final session = await ref.watch(sessionProvider.future);
    if (session == SessionStatus.unauthenticated) {
      return false;
    }
    final changes = store.changes.listen(
      (active) => state = AsyncData(active || staff),
    );
    ref.onDispose(changes.cancel);
    return staff || await store.isActive();
  }

  /// Bought in the store: Premium at once (the store confirms it as well).
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
