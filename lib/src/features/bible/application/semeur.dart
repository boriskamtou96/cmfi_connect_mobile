import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/services/remote_flags.dart';
import '../domain/bible_version.dart';
import '../infrastructure/bible_storage.dart';

part 'semeur.g.dart';

/// The key of the switch in Firebase Remote Config.
const semeurFlag = 'bible_semeur';

/// La Bible du Semeur read in the app (14/11/2026: switched on and off from
/// Firebase Remote Config, `bible_semeur` = "on" or "off", without a new
/// version): only with the key of the YouVersion Platform in .env; while
/// the console has no value, BIBLE_SEMEUR of .env decides. Switched off, it
/// leaves the versions (the one who read it goes back to the Bible of their
/// language), La Bible du Semeur is read on Bibleserver again, and the copy
/// downloaded on the phone goes (its licence).
@Riverpod(keepAlive: true)
class SemeurInApp extends _$SemeurInApp {
  @override
  bool build() {
    final flags = ref.watch(remoteFlagsProvider);
    final changes = flags.changes.listen((keys) {
      if (keys.contains(semeurFlag)) {
        unawaited(_read(flags));
      }
    });
    ref.onDispose(changes.cancel);
    try {
      // a change fetched by another reader of Remote Config meanwhile
      final listener = AppLifecycleListener(
        onResume: () => unawaited(_read(flags)),
      );
      ref.onDispose(listener.dispose);
    } on Object {
      // no Flutter binding (a unit test)
    }
    unawaited(_read(flags, fetch: true));
    // until Remote Config answers: what the app knew last time it ran
    return _available('');
  }

  static bool _available(String value) =>
      AppConfig.youversionAppKey.isNotEmpty &&
      remoteSwitch(value, fallback: AppConfig.semeurByDefault);

  Future<void> _read(RemoteFlags flags, {bool fetch = false}) async {
    if (fetch) {
      // what is kept on the phone first, then the console
      await _apply(await flags.read(semeurFlag));
      await flags.refresh();
    }
    await _apply(await flags.read(semeurFlag));
  }

  Future<void> _apply(String value) async {
    if (!ref.mounted) {
      return;
    }
    final on = _available(value);
    state = on;
    if (!on) {
      await ref.read(bibleStorageProvider).removeAll(semeurVersion.id);
    }
  }
}
