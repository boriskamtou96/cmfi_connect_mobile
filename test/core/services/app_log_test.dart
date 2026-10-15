import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/network/api_call.dart';
import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/core/services/app_log.dart';
import 'package:cmfi_connect/src/core/services/crash_reporting.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/prayer/application/importunities.dart';
import 'package:cmfi_connect/src/features/prayer/application/retreats.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/prayer/infrastructure/prayer_local_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  late FakeCrashReporting log;
  setUp(() => AppLog.reporter = log = FakeCrashReporting());
  tearDown(() => AppLog.reporter = const NoCrashReporting());

  final record = RetreatRecord(day: today(), moment: RetreatMoment.morning);

  test(
    'a server error is logged with its request id, never the query',
    () async {
      final dio = Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) => handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.badResponse,
                response: Response(
                  requestOptions: options,
                  statusCode: 500,
                  data: {'code': 'INTERNAL_SERVER_ERROR', 'message': ''},
                  headers: Headers.fromMap({
                    'x-request-id': ['a1b2c3'],
                  }),
                ),
              ),
            ),
          ),
        );

      await expectLater(
        apiCall(
          () => dio.get<Object>('https://api.test/v1/members?search=690'),
        ),
        throwsA(isA<ApiException>()),
      );
      expect(
        log.errors.single.reason,
        'server error: GET /v1/members → 500 (request a1b2c3)',
      );
    },
  );

  testWidgets('a session that ended keeps the retreats made offline', (
    tester,
  ) async {
    final api = FakePrayerApi();
    final app = await pumpApp(tester, token: 't', prayerApi: api);
    final store = app.container.read(prayerLocalStoreProvider);
    await store.savePendingRetreats([record]);

    api.failure = const UnauthorizedException();
    await tester.runAsync(
      () => app.container.read(retreatLogProvider.notifier).sendPending(),
    );
    expect(store.pendingRetreats(), [record]);

    // signed in again: they leave
    api.failure = null;
    await tester.runAsync(
      () => app.container.read(retreatLogProvider.notifier).sendPending(),
    );
    expect(store.pendingRetreats(), isEmpty);
    expect(api.retreatList, [record]);
  });

  testWidgets('a retreat refused for good is dropped, and said', (
    tester,
  ) async {
    final api = FakePrayerApi();
    final app = await pumpApp(tester, token: 't', prayerApi: api);
    final store = app.container.read(prayerLocalStoreProvider);
    await store.savePendingRetreats([record]);

    api.failure = const ApiException(
      status: 400,
      code: 'BAD_REQUEST',
      message: '',
    );
    await tester.runAsync(
      () => app.container.read(retreatLogProvider.notifier).sendPending(),
    );
    expect(store.pendingRetreats(), isEmpty);
    expect(log.errors.single.reason, 'retreat refused (BAD_REQUEST): dropped');
  });

  testWidgets('proclamations wait for the next sign-in', (tester) async {
    final api = FakePrayerApi();
    final app = await pumpApp(tester, token: 't', prayerApi: api);
    final store = app.container.read(prayerLocalStoreProvider);
    await store.savePendingCounts({7: 3});

    api.failure = const UnauthorizedException();
    await tester.runAsync(
      () => app.container.read(importunitiesProvider.notifier).sendCounts(),
    );
    expect(store.pendingCounts(), {7: 3});
  });
}
