import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/bible.dart';
import '../domain/reading_plan.dart';
import 'bible_library.dart';
import 'bible_settings.dart';

part 'bible_plan.g.dart';

/// The plan and the chapters read in it ("GEN.4"), with where the member
/// stands on [day].
@immutable
class PlanProgress {
  PlanProgress({required this.plan, required this.read});

  final ReadingPlan plan;
  final Set<String> read;

  late final List<List<BibleRef>> schedule = plan.schedule;

  /// The days of the plan, 0 the first.
  int get length => schedule.length;

  int indexOf(DateTime day) => plan.dayOf(day);

  /// [day]'s chapters, none before the start or after the end.
  List<BibleRef> chaptersOf(DateTime day) {
    final index = indexOf(day);
    return index < 0 || index >= length ? const [] : schedule[index];
  }

  bool isRead(BibleRef chapter) => read.contains(chapter.chapterRef.key);

  bool doneOn(DateTime day) => chaptersOf(day).every(isRead);

  /// The days before [day] with chapters still to read.
  int behindOn(DateTime day) {
    final index = indexOf(day).clamp(0, length);
    var behind = 0;
    for (var i = 0; i < index; i++) {
      if (!schedule[i].every(isRead)) {
        behind++;
      }
    }
    return behind;
  }

  /// The first chapter not read yet, the late ones first.
  BibleRef? nextOn(DateTime day) {
    final until = indexOf(day).clamp(0, length - 1);
    for (var i = 0; i <= until; i++) {
      for (final chapter in schedule[i]) {
        if (!isRead(chapter)) {
          return chapter;
        }
      }
    }
    return null;
  }

  int get readCount => read.length;

  bool get finished => readCount >= plan.total;

  double get progress => plan.total == 0 ? 0 : readCount / plan.total;
}

/// The Bible reading plan of the member (one at a time), kept on the phone:
/// what was asked (`bible_plan`) and the chapters read (`bible_plan_read`).
/// A chapter marked "J'ai lu ce chapitre" in the reader is read in the plan
/// too. The reminder of each day is planned 14 days ahead, silent once the
/// day's reading is done.
@Riverpod(keepAlive: true)
class BiblePlan extends _$BiblePlan {
  static const _planKey = 'bible_plan';
  static const _readKey = 'bible_plan_read';
  static const plannedDays = 14;

  /// Payload of the reminder: opens the plan.
  static const payload = 'bible_plan';

  @override
  PlanProgress? build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    final raw = preferences.getString(_planKey);
    if (raw == null) {
      return null;
    }
    try {
      final plan = ReadingPlan.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      final read = preferences.getStringList(_readKey) ?? const [];
      return PlanProgress(plan: plan, read: read.toSet());
    } on Object {
      return null;
    }
  }

  Future<void> start(ReadingPlan plan) async {
    final preferences = ref.read(sharedPreferencesProvider);
    if (plan.reminder) {
      await ref.read(localNotificationsProvider).requestPermission();
    }
    await preferences.setString(_planKey, jsonEncode(plan.toJson()));
    await preferences.setStringList(_readKey, const []);
    state = PlanProgress(plan: plan, read: const {});
    await reschedule();
  }

  Future<void> stop() async {
    final preferences = ref.read(sharedPreferencesProvider);
    await preferences.remove(_planKey);
    await preferences.remove(_readKey);
    state = null;
    await ref
        .read(localNotificationsProvider)
        .cancel(NotificationGroup.biblePlan);
  }

  Future<void> setReminder({bool? on, int? minutes}) async {
    final current = state;
    if (current == null) {
      return;
    }
    if (on ?? false) {
      await ref.read(localNotificationsProvider).requestPermission();
    }
    final plan = current.plan.copyWith(reminder: on, reminderMinutes: minutes);
    await ref
        .read(sharedPreferencesProvider)
        .setString(_planKey, jsonEncode(plan.toJson()));
    state = PlanProgress(plan: plan, read: current.read);
    await reschedule();
  }

  /// [chapter] read, if the plan has it.
  Future<void> markRead(BibleRef chapter) => _set(chapter, read: true);

  Future<void> unmark(BibleRef chapter) => _set(chapter, read: false);

  Future<void> _set(BibleRef chapter, {required bool read}) async {
    final current = state;
    final key = chapter.chapterRef.key;
    if (current == null ||
        !current.schedule.any((day) => day.contains(chapter.chapterRef)) ||
        current.read.contains(key) == read) {
      return;
    }
    final chapters = {...current.read};
    read ? chapters.add(key) : chapters.remove(key);
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(_readKey, chapters.toList());
    state = PlanProgress(plan: current.plan, read: chapters);
    await reschedule();
  }

  /// The reminders of the next days: from the start, until the end, at the
  /// hour chosen; today's only if its reading isn't done.
  Future<void> reschedule() async {
    final notifications = ref.read(localNotificationsProvider);
    final current = state;
    if (current == null || !current.plan.reminder) {
      await notifications.cancel(NotificationGroup.biblePlan);
      return;
    }
    final t = LocaleSettings.instance.currentTranslations.biblePlan;
    final names = await _bookNames();
    final now = DateTime.now();
    final first = today();
    final planned = <PlannedNotification>[];
    for (var i = 0; i < plannedDays; i++) {
      final day = DateTime(first.year, first.month, first.day + i);
      final chapters = current.chaptersOf(day);
      if (chapters.isEmpty) {
        continue;
      }
      final at = day.add(Duration(minutes: current.plan.reminderMinutes));
      if (!at.isAfter(now) || (i == 0 && current.doneOn(day))) {
        continue;
      }
      planned.add((
        id: i,
        at: at,
        title: t.reminderTitle,
        body: readingLabel(chapters, (book) => names[book] ?? book),
        payload: payload,
      ));
    }
    await notifications.replace(
      NotificationGroup.biblePlan,
      planned,
      channelName: t.reminderChannel,
    );
  }

  /// The names of the books in the Bible read; the codes without network.
  Future<Map<String, String>> _bookNames() async {
    try {
      final version = ref.read(bibleVersionProvider);
      final books = await ref.read(bibleBooksProvider(version.id).future);
      return {for (final book in books) book.id: book.name};
    } on Object {
      return const {};
    }
  }
}
