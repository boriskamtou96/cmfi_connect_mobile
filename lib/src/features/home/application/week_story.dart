import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/utils/date_extensions.dart';
import '../../prayer/application/retreats.dart';
import '../../reports/application/report_goals.dart';
import '../../reports/application/reports_providers.dart';
import '../domain/week_story.dart';

part 'week_story.g.dart';

/// "Ta semaine avec Dieu" for the week starting on [monday]: the reports of
/// the year before (for the streaks), the items, the goals and the retreats.
@riverpod
Future<WeekStory> weekStory(Ref ref, DateTime monday) async {
  final now = today();
  final sunday = DateTime(monday.year, monday.month, monday.day + 6);
  final end = now.isBefore(sunday) ? now : sunday;
  final (history, activities, retreats) = await (
    ref.watch(
      reportHistoryProvider(
        from: DateTime(end.year - 1, end.month, end.day + 1),
        to: end,
      ).future,
    ),
    ref.watch(activitiesProvider.future),
    ref.watch(retreatsOfWeekProvider(monday).future),
  ).wait;
  return WeekStory.build(
    monday: monday,
    today: now,
    history: history,
    activities: activities,
    goals: ref.watch(reportGoalsProvider),
    retreats: retreats,
  );
}

/// The notifications of the next Sundays at 18:00: "Ta semaine avec Dieu est
/// prête". Replanned with the other reminders, in the app's language.
Future<void> planWeekStories(
  LocalNotifications notifications, {
  required DateTime now,
}) {
  final t = LocaleSettings.instance.currentTranslations;
  return notifications.replace(NotificationGroup.weekStory, [
    for (final (i, at) in weekStoryTimes(now: now).indexed)
      (
        id: i,
        at: at,
        title: t.weekStory.notificationTitle,
        body: t.weekStory.notificationBody,
        payload: weekStoryPayload(at),
      ),
  ], channelName: t.weekStory.channel);
}
