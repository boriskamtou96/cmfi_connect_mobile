import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/session/session.dart';
import '../../../core/storage/account_storage.dart';
import '../../../core/storage/preferences.dart';
import '../domain/journey_step.dart';

part 'journey_steps.g.dart';

/// The steps just reached while the app is open, to celebrate (Zoé shows
/// them).
@Riverpod(keepAlive: true)
StreamController<JourneyStep> journeyCelebrations(Ref ref) {
  final controller = StreamController<JourneyStep>.broadcast();
  ref.onDispose(controller.close);
  return controller;
}

/// The steps of the journey reached, with when, kept on the phone for each
/// account (`journey_steps_<id>`): signing out and back keeps them. A step
/// reached while the app is open is told on [journeyCelebrations].
@Riverpod(keepAlive: true)
class JourneySteps extends _$JourneySteps {
  static const _prefix = 'journey_steps_';

  String? _key;

  @override
  Future<Map<JourneyStep, DateTime>> build() async {
    final signedIn = await ref.watch(sessionProvider.future);
    if (signedIn != SessionStatus.authenticated) {
      _key = null;
      return const {};
    }
    // a session opened by an older version kept no account: the phone's
    // own place (0)
    final account = await ref.read(accountStorageProvider).read();
    final key = _key = '$_prefix${account?.id ?? 0}';
    final byName = JourneyStep.values.asNameMap();
    return {
      for (final saved
          in ref.read(sharedPreferencesProvider).getStringList(key) ??
              const <String>[])
        if (saved.split('|') case [
          final name,
          final at,
        ] when byName[name] != null && DateTime.tryParse(at) != null)
          byName[name]!: DateTime.parse(at),
    };
  }

  /// [step] reached now; told on [journeyCelebrations] unless [celebrate] is
  /// false (already shown another way, or found at the start). False when
  /// it was reached before.
  Future<bool> reach(JourneyStep step, {bool celebrate = true}) async {
    final reached = await future;
    final key = _key;
    if (key == null || reached.containsKey(step)) {
      return false;
    }
    final next = {...reached, step: DateTime.now()};
    state = AsyncData(next);
    await ref.read(sharedPreferencesProvider).setStringList(key, [
      for (final MapEntry(key: step, value: at) in next.entries)
        '${step.name}|${at.toIso8601String()}',
    ]);
    if (celebrate) {
      ref.read(journeyCelebrationsProvider).add(step);
    }
    return true;
  }
}
