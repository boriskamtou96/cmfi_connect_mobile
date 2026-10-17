import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/memory_verse.dart';

part 'memory_verses.g.dart';

/// The daily reminder of the reviews: on or off, and when (minutes after
/// midnight).
typedef MemoryReminder = ({bool on, int minutes});

/// The verses learnt by heart, on the phone (key `memory_verses`), the
/// newest first; the reviews of the day and their reminder (key
/// `memory_reminder`, off until the member turns it on). Nothing goes to the
/// report: the member chose to keep them apart.
@Riverpod(keepAlive: true)
class MemoryVerses extends _$MemoryVerses {
  static const key = 'memory_verses';
  static const reminderKey = 'memory_reminder';

  /// The payload of the reminder: opens the reviews.
  static const payload = 'memory';
  static const plannedDays = 14;

  @override
  List<MemoryVerse> build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(key);
    if (raw == null) {
      return const [];
    }
    try {
      return [
        for (final json in jsonDecode(raw) as List<dynamic>)
          MemoryVerse.fromJson(json as Map<String, dynamic>),
      ];
    } on Object {
      return const [];
    }
  }

  Future<void> _save(List<MemoryVerse> verses) async {
    state = verses;
    await ref
        .read(sharedPreferencesProvider)
        .setString(
          key,
          jsonEncode([for (final verse in verses) verse.toJson()]),
        );
    await reschedule();
  }

  bool has(String id) => state.any((verse) => verse.id == id);

  /// Adds the verses [first] to [last] of a chapter, to learn from today.
  /// false when they were there already.
  Future<bool> add({
    required String book,
    required int chapter,
    required int first,
    required int last,
    required String label,
    required String text,
    required String version,
  }) async {
    final day = today();
    final verse = MemoryVerse(
      book: book,
      chapter: chapter,
      first: first,
      last: last,
      label: label,
      text: text,
      version: version,
      added: day,
      due: day,
    );
    if (has(verse.id)) {
      return false;
    }
    await _save([verse, ...state]);
    return true;
  }

  Future<void> remove(String id) => _save([
    for (final verse in state)
      if (verse.id != id) verse,
  ]);

  Future<void> review(String id, MemoryGrade grade) {
    final day = today();
    return _save([
      for (final verse in state)
        verse.id == id ? verse.reviewed(grade, day) : verse,
    ]);
  }

  /// The verses to review on [day], the most late first.
  List<MemoryVerse> dueOn(DateTime day) => [
    for (final verse in state)
      if (verse.isDue(day)) verse,
  ]..sort((a, b) => a.due.compareTo(b.due));

  MemoryReminder reminder() {
    final raw = ref.read(sharedPreferencesProvider).getString(reminderKey);
    if (raw == null) {
      return (on: false, minutes: 8 * 60);
    }
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return (on: json['on'] as bool, minutes: json['minutes'] as int);
  }

  Future<void> setReminder({bool? on, int? minutes}) async {
    final current = reminder();
    final next = (on: on ?? current.on, minutes: minutes ?? current.minutes);
    if (next.on && !current.on) {
      await ref.read(localNotificationsProvider).requestPermission();
    }
    await ref
        .read(sharedPreferencesProvider)
        .setString(
          reminderKey,
          jsonEncode({'on': next.on, 'minutes': next.minutes}),
        );
    // the screen reads the reminder from here
    ref.notifyListeners();
    await reschedule();
  }

  /// The days ahead with verses to review, at the time chosen; not today
  /// once they are done or the time has passed.
  Future<void> reschedule() async {
    final notifications = ref.read(localNotificationsProvider);
    final setting = reminder();
    if (!setting.on || state.isEmpty) {
      await notifications.cancel(NotificationGroup.memory);
      return;
    }
    final t = LocaleSettings.instance.currentTranslations.memorize;
    final now = DateTime.now();
    final first = today();
    final planned = <PlannedNotification>[];
    for (var i = 0; i < plannedDays; i++) {
      final day = DateTime(first.year, first.month, first.day + i);
      final count = dueOn(day).length;
      final at = day.add(Duration(minutes: setting.minutes));
      if (count == 0 || !at.isAfter(now)) {
        continue;
      }
      planned.add((
        id: i,
        at: at,
        title: t.reminderTitle,
        body: t.reminderBody(n: count),
        payload: payload,
      ));
    }
    await notifications.replace(
      NotificationGroup.memory,
      planned,
      channelName: t.reminderChannel,
    );
  }

  /// Signing out: the verses stay on the phone, the reminders stop.
  Future<void> forget() =>
      ref.read(localNotificationsProvider).cancel(NotificationGroup.memory);
}
