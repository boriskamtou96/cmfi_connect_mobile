import 'dart:async';

import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/core/network/fetch_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // a copy on the phone, a server that answers (or not), what is saved
  late String? copy;
  late bool offline;
  late List<String> saved;
  late int calls;

  setUp(() {
    copy = 'copie';
    offline = false;
    saved = [];
    calls = 0;
  });

  Future<String> fetch(
    FetchPolicy policy, {
    void Function(String fresh)? onFresh,
    void Function(Object error, StackTrace stack)? onFailed,
  }) => fetchWithPolicy(
    policy: policy,
    cached: () => copy,
    network: () async {
      calls++;
      if (offline) {
        throw const NetworkException();
      }
      return 'serveur';
    },
    save: (value) async => saved.add(value),
    onFresh: onFresh,
    onFailed: onFailed,
  );

  test('cacheAndNetwork: the copy at once, then the server, kept', () async {
    final fresh = Completer<String>();
    expect(
      await fetch(FetchPolicy.cacheAndNetwork, onFresh: fresh.complete),
      'copie',
    );
    expect(await fresh.future, 'serveur');
    expect(saved, ['serveur']);
  });

  test('cacheAndNetwork offline: the copy stays, onFailed is told', () async {
    offline = true;
    final failed = Completer<Object>();
    expect(
      await fetch(
        FetchPolicy.cacheAndNetwork,
        onFailed: (error, _) => failed.complete(error),
      ),
      'copie',
    );
    expect(await failed.future, isA<NetworkException>());
    expect(saved, isEmpty);
  });

  test('cacheAndNetwork without a copy: the server', () async {
    copy = null;
    expect(await fetch(FetchPolicy.cacheAndNetwork), 'serveur');
    expect(calls, 1);
  });

  test('networkPreferably: the server, the copy without network', () async {
    expect(await fetch(FetchPolicy.networkPreferably), 'serveur');
    offline = true;
    expect(await fetch(FetchPolicy.networkPreferably), 'copie');
    copy = null;
    expect(
      () => fetch(FetchPolicy.networkPreferably),
      throwsA(isA<NetworkException>()),
    );
  });

  test('cachePreferably: the copy, the server only without one', () async {
    expect(await fetch(FetchPolicy.cachePreferably), 'copie');
    expect(calls, 0);
    copy = null;
    expect(await fetch(FetchPolicy.cachePreferably), 'serveur');
  });

  test('networkOnly: the server, never the copy', () async {
    expect(await fetch(FetchPolicy.networkOnly), 'serveur');
    offline = true;
    expect(
      () => fetch(FetchPolicy.networkOnly),
      throwsA(isA<NetworkException>()),
    );
  });
}
