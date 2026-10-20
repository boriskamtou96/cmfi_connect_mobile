import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/utils/date_extensions.dart';
import '../../bible/application/memory_verses.dart';
import '../../prayer/application/retreats.dart';
import '../../reports/application/report_goals.dart';
import '../../reports/application/reports_providers.dart';
import '../domain/year_story.dart';

part 'year_story.g.dart';

/// "Ton année avec Dieu" for [year]: its reports (the server gives 366 days
/// at most), whether the member was there in the December before, the items,
/// the goals, the retreats and the verses learnt by heart.
@riverpod
Future<YearStory> yearStory(Ref ref, int year) async {
  final now = today();
  final last = DateTime(year, 12, 31);
  final end = now.isBefore(last) ? now : last;
  final (history, startedBefore, activities, retreats) = await (
    ref.watch(
      reportHistoryProvider(
        from: DateTime(year),
        to: end.isBefore(DateTime(year)) ? DateTime(year) : end,
      ).future,
    ),
    // without an answer, the year starts on the first day filled in
    ref
        .watch(
          reportHistoryProvider(
            from: DateTime(year - 1, 12),
            to: DateTime(year - 1, 12, 31),
          ).future,
        )
        .then((days) => days.isNotEmpty, onError: (Object _) => false),
    ref.watch(activitiesProvider.future),
    ref.watch(retreatsOfYearProvider(year).future),
  ).wait;
  return YearStory.build(
    year: year,
    today: now,
    history: history,
    activities: activities,
    goals: ref.watch(reportGoalsProvider),
    retreats: retreats,
    verses: ref.watch(memoryVersesProvider),
    startedBefore: startedBefore,
  );
}

/// The notification of the next 31 December at 18:00: "Ton année avec Dieu
/// est prête". Replanned with the other reminders, in the app's language.
Future<void> planYearStory(
  LocalNotifications notifications, {
  required DateTime now,
}) {
  final t = LocaleSettings.instance.currentTranslations;
  final at = yearStoryTime(now: now);
  return notifications.replace(NotificationGroup.yearStory, [
    (
      id: 0,
      at: at,
      title: t.yearStory.notificationTitle,
      body: t.yearStory.notificationBody(year: at.year),
      payload: yearStoryPayload(at.year),
    ),
  ], channelName: t.yearStory.channel);
}
