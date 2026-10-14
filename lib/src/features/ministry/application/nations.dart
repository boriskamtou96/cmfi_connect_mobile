import 'dart:async';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/nation.dart';
import '../infrastructure/ministry_api.dart';

part 'nations.g.dart';

/// The nations of the ministry: the copy of the phone at once (the last one
/// seen, or the one shipped with the app), then the server's when it answers.
/// Without network, the copy stays.
@Riverpod(keepAlive: true)
class Nations extends _$Nations {
  @override
  Future<List<Nation>> build() async {
    final store = ref.watch(ministryLocalStoreProvider);
    final local = store.saved() ?? await store.shipped(rootBundle);
    unawaited(refresh());
    return local;
  }

  Future<void> refresh() async {
    try {
      final nations = await ref.read(ministryApiProvider).nations();
      if (!ref.mounted) {
        return;
      }
      state = AsyncData(nations);
      await ref.read(ministryLocalStoreProvider).save(nations);
    } on Object {
      // no network: the copy of the phone stays
    }
  }
}
