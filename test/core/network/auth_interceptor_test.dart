import 'dart:convert';
import 'dart:typed_data';

import 'package:cmfi_connect/src/core/config/app_config.dart';
import 'package:cmfi_connect/src/core/network/dio_provider.dart';
import 'package:cmfi_connect/src/core/storage/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../helpers/fakes.dart';

/// Answers {} to everything and keeps the headers sent.
class _RecordingAdapter implements HttpClientAdapter {
  final sent = <Uri, Map<String, dynamic>>{};

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    sent[options.uri] = {...options.headers};
    return ResponseBody.fromString(
      jsonEncode({}),
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
  test('the token goes to our API only, never to another host', () async {
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(apiBaseUrl: 'https://api.cmfi-connect.com/v1'),
        ),
        tokenStorageProvider.overrideWithValue(FakeTokenStorage('secret')),
      ],
    );
    addTearDown(container.dispose);
    final dio = container.read(dioProvider);
    final adapter = _RecordingAdapter();
    dio.httpClientAdapter = adapter;

    await dio.get<Map<String, dynamic>>('/reports/');
    await dio.get<Map<String, dynamic>>(
      'https://bible.helloao.org/api/fra_lsg/books.json',
    );

    expect(
      adapter.sent[Uri.parse(
        'https://api.cmfi-connect.com/v1/reports/',
      )]!['Authorization'],
      'Bearer secret',
    );
    expect(
      adapter
          .sent[Uri.parse('https://bible.helloao.org/api/fra_lsg/books.json')]!
          .containsKey('Authorization'),
      isFalse,
    );
  });
}
