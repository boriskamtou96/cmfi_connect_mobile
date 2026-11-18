import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cmfi_connect/src/core/services/premium_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// The server's answer to GET /premium/status, or no network.
class _StatusAdapter implements HttpClientAdapter {
  Map<String, dynamic>? status;
  var paths = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    final status = this.status;
    if (status == null) {
      throw DioException.connectionError(
        requestOptions: options,
        reason: 'offline',
      );
    }
    return ResponseBody.fromString(
      jsonEncode({'status': 200, 'content': status}),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// RevenueCat as the tests want it: active or not, its plans, and what was
/// asked of it.
class _Shop implements PremiumShop {
  bool active = false;

  /// RevenueCat unreachable: every call throws.
  bool broken = false;
  final loggedIn = <String>[];
  var loggedOut = false;
  final bought = <PremiumPeriod>[];
  final controller = StreamController<bool>.broadcast();

  static const monthly = PremiumPlan(
    period: PremiumPeriod.monthly,
    price: '1,99 \$',
    amount: 1.99,
  );

  @override
  Future<bool> isActive() async => active;

  @override
  Stream<bool> get changes => controller.stream;

  @override
  Future<void> logIn(String userId) async => loggedIn.add(userId);

  @override
  Future<void> logOut() async => loggedOut = true;

  @override
  Future<List<PremiumPlan>> plans() async => const [monthly];

  @override
  Future<bool> buy(PremiumPlan plan) async {
    bought.add(plan.period);
    return active = true;
  }

  @override
  Future<bool> restore() async => active;

  @override
  Future<void> manage() async {}

  @override
  Future<void> refresh() async {
    if (broken) {
      throw StateError('RevenueCat unreachable');
    }
    controller.add(active);
  }
}

void main() {
  test(
    'Premium is read on the server: for life, until a date, or none',
    () async {
      final adapter = _StatusAdapter();
      final store = ServerPremiumStore(
        Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
          ..httpClientAdapter = adapter,
      );
      final later = DateTime.now().add(const Duration(days: 30));
      final past = DateTime.now().subtract(const Duration(days: 1));

      adapter.status = {'lifetime': false, 'until': null};
      expect(await store.isActive(), isFalse);
      adapter.status = {
        'lifetime': false,
        'until': later.toUtc().toIso8601String(),
      };
      expect(await store.isActive(), isTrue);
      expect(adapter.paths.last, '/premium/status');
      // offline: what was known stays
      adapter.status = null;
      expect(await store.isActive(), isTrue);
      adapter.status = {
        'lifetime': false,
        'until': past.toUtc().toIso8601String(),
      };
      expect(await store.isActive(), isFalse);
      adapter.status = {'lifetime': true, 'until': null};
      expect(await store.isActive(), isTrue);

      // signed out: no Premium, said at once
      final changes = <bool>[];
      store.changes.listen(changes.add);
      await store.logOut();
      await store.refresh();
      await Future<void>.delayed(Duration.zero);
      expect(changes, [false, true]);
    },
  );

  group('Premium from the site and from the store', () {
    late _StatusAdapter adapter;
    late _Shop shop;
    late AppPremiumStore store;

    setUp(() {
      adapter = _StatusAdapter()..status = {'lifetime': false, 'until': null};
      shop = _Shop();
      store = AppPremiumStore(
        ServerPremiumStore(
          Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
            ..httpClientAdapter = adapter,
        ),
        shop,
      );
    });

    test('bought on the site: active, not managed in the store', () async {
      adapter.status = {'lifetime': true, 'until': null};
      expect(await store.isActive(), isTrue);
      expect(store.boughtInStore, isFalse);
    });

    test('bought in the store: active, managed there', () async {
      expect(await store.isActive(), isFalse);
      expect(await store.plans(), [_Shop.monthly]);
      expect(await store.buy(_Shop.monthly), isTrue);
      expect(shop.bought, [PremiumPeriod.monthly]);
      expect(await store.isActive(), isTrue);
      expect(store.boughtInStore, isTrue);
    });

    test('the account goes to both, and leaves both', () async {
      shop.active = true;
      await store.logIn('42');
      expect(shop.loggedIn, ['42']);
      expect(adapter.paths, contains('/premium/status'));

      final changes = <bool>[];
      store.changes.listen(changes.add);
      shop.active = false;
      await store.logOut();
      await Future<void>.delayed(Duration.zero);
      expect(shop.loggedOut, isTrue);
      expect(changes.last, isFalse);
      expect(store.boughtInStore, isFalse);
    });

    test('the store broken: the site is asked again all the same', () async {
      shop.broken = true;
      final changes = <bool>[];
      store.changes.listen(changes.add);
      adapter.status = {'lifetime': true, 'until': null};
      await store.refresh();
      await Future<void>.delayed(Duration.zero);
      expect(changes, [true]);
    });

    test('a change in the store is a change of Premium', () async {
      final changes = <bool>[];
      store.changes.listen(changes.add);
      shop.active = true;
      shop.controller.add(true);
      await Future<void>.delayed(Duration.zero);
      expect(changes, [true]);
      // the store ends it, the site still has it
      adapter.status = {'lifetime': true, 'until': null};
      await store.isActive();
      shop.active = false;
      shop.controller.add(false);
      await Future<void>.delayed(Duration.zero);
      expect(changes.last, isTrue);
    });
  });
}
