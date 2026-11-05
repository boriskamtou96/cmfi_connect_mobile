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
}
