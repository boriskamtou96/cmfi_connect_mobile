import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/storage/preferences.dart';
import '../../reports/application/report_counts.dart';
import '../domain/fast.dart';

part 'fasts.g.dart';

/// The fast under way (null without one) and the last ones over.
@immutable
class FastsState {
  const FastsState({this.current, this.history = const []});

  final Fast? current;

  /// The newest first, 20 at most.
  final List<PastFast> history;
}

/// Mes jeûnes, on the phone (keys `fast_current`, `fast_history`): each day
/// kept adds 1 to « Jeûne complet » (JC) or « Jeûne partiel » (JP) in the
/// report of the day it ends, when the app opens again after it (`catchUp`,
/// at launch, on the screen, after a notification). The end of each day and
/// of the fast come as notifications.
@Riverpod(keepAlive: true)
class Fasts extends _$Fasts {
  static const currentKey = 'fast_current';
  static const historyKey = 'fast_history';

  /// The payload of its notifications: opens Mes jeûnes.
  static const payload = 'fast';

  /// The standard items of the report, counted in times.
  static const fullCode = 'JC';
  static const partialCode = 'JP';

  @override
  FastsState build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    Fast? current;
    final raw = preferences.getString(currentKey);
    if (raw != null) {
      try {
        current = Fast.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      } on Object {
        current = null;
      }
    }
    final history = <PastFast>[];
    for (final json
        in preferences.getStringList(historyKey) ?? const <String>[]) {
      try {
        history.add(
          PastFast.fromJson(jsonDecode(json) as Map<String, dynamic>),
        );
      } on Object {
        // written by an older version
      }
    }
    return FastsState(current: current, history: history);
  }

  Future<void> _save(FastsState next) async {
    state = next;
    final preferences = ref.read(sharedPreferencesProvider);
    final current = next.current;
    if (current == null) {
      await preferences.remove(currentKey);
    } else {
      await preferences.setString(currentKey, jsonEncode(current.toJson()));
    }
    await preferences.setStringList(historyKey, [
      for (final past in next.history) jsonEncode(past.toJson()),
    ]);
  }

  Future<void> start({
    required FastKind kind,
    required int days,
    int endMinutes = 18 * 60,
    List<String> topics = const [],
  }) async {
    await ref.read(localNotificationsProvider).requestPermission();
    await _save(
      FastsState(
        current: Fast(
          kind: kind,
          start: DateTime.now(),
          days: days,
          endMinutes: endMinutes,
          topics: topics,
        ),
        history: state.history,
      ),
    );
    await reschedule();
  }

  Future<void> setTopics(List<String> topics) async {
    final current = state.current;
    if (current == null) {
      return;
    }
    await _save(
      FastsState(
        current: current.copyWith(topics: topics),
        history: state.history,
      ),
    );
  }

  /// Broken before its end: the days already kept still count.
  Future<void> stop() async {
    final current = state.current;
    if (current == null) {
      return;
    }
    await _save(
      FastsState(
        current: current.copyWith(stoppedAt: DateTime.now()),
        history: state.history,
      ),
    );
    await catchUp();
  }

  /// Adds the days kept since the last time to the report, and puts a fast
  /// over in the history. Returns the days added.
  Future<int> catchUp() async {
    final fast = state.current;
    if (fast == null) {
      return 0;
    }
    var current = fast;
    final now = DateTime.now();
    if (fast.toCountAt(now).isEmpty && !fast.isOverAt(now)) {
      return 0;
    }
    var added = 0;
    for (final end in fast.toCountAt(now)) {
      if (await _addToReport(fast.kind, end)) {
        added++;
      }
      // counted even without the item: never asked again
      current = current.copyWith(
        counted: {...current.counted, Fast.dayKey(end)},
      );
    }
    if (current.isOverAt(now)) {
      await _save(
        FastsState(
          history: [
            PastFast(
              kind: current.kind,
              start: current.start,
              days: current.days,
              kept: current.keptAt(now),
            ),
            ...state.history,
          ].take(20).toList(),
        ),
      );
      await ref
          .read(localNotificationsProvider)
          .cancel(NotificationGroup.fasts);
    } else {
      await _save(FastsState(current: current, history: state.history));
    }
    return added;
  }

  /// 1 more in JC or JP of the day [end] falls in; false when the report
  /// has no such item (or can't be reached).
  Future<bool> _addToReport(FastKind kind, DateTime end) async {
    try {
      return await addToDayReport(
        ref,
        day: DateTime(end.year, end.month, end.day),
        code: kind == FastKind.full ? fullCode : partialCode,
      );
    } on Object {
      return false;
    }
  }

  /// The end of each day to come, and of the fast.
  Future<void> reschedule() async {
    final notifications = ref.read(localNotificationsProvider);
    final current = state.current;
    final now = DateTime.now();
    if (current == null || current.isOverAt(now)) {
      await notifications.cancel(NotificationGroup.fasts);
      return;
    }
    final t = LocaleSettings.instance.currentTranslations.fasts;
    await notifications.replace(NotificationGroup.fasts, [
      for (var i = 0; i < current.days; i++)
        if (current.endOfDay(i) case final at when at.isAfter(now))
          (
            id: i,
            at: at,
            title: i == current.days - 1 ? t.endTitle : t.dayTitle(day: i + 1),
            body: i == current.days - 1 ? t.endBody : t.dayBody,
            payload: payload,
          ),
    ], channelName: t.channel);
  }

  /// Signing out: the fasts were the account's.
  Future<void> forget() async {
    final preferences = ref.read(sharedPreferencesProvider);
    await preferences.remove(currentKey);
    await preferences.remove(historyKey);
    await ref.read(localNotificationsProvider).cancel(NotificationGroup.fasts);
    ref.invalidateSelf();
  }
}
