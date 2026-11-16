import 'package:intl/intl.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/services/premium_store.dart';

/// The payload of the reminders before Premium ends: the Premium page.
const premiumEndPayload = 'premium:end';

/// When the reminders before [until] come: 7 days and 1 day before, at
/// 10:00, those still ahead of [now].
List<DateTime> premiumEndTimes(DateTime until, {required DateTime now}) => [
  for (final days in const [7, 1])
    DateTime(until.year, until.month, until.day - days, 10),
].where((at) => at.isAfter(now)).toList();

/// Plans the reminders before the Premium of the member ends ([until]: null
/// without one, for life, or for the team: none). Without [renewal], Premium
/// bought on the site doesn't go on by itself: the member is told in time.
/// With it, the server sends the payment request the day before (and its own
/// push): the member is only told a week before that it will come.
Future<void> planPremiumEnd(
  LocalNotifications notifications, {
  required DateTime? until,
  required DateTime now,
  PremiumRenewal? renewal,
}) async {
  if (until == null || !until.isAfter(now)) {
    return notifications.cancel(NotificationGroup.premiumEnd);
  }
  final t = LocaleSettings.instance.currentTranslations;
  final t2 = t.premium.end;
  final date = DateFormat.MMMMd(
    LocaleSettings.currentLocale.languageCode,
  ).format(until);
  final week = DateTime(until.year, until.month, until.day - 7, 10);
  if (renewal != null) {
    final request = DateFormat.MMMMd(
      LocaleSettings.currentLocale.languageCode,
    ).format(renewal.nextRequestAt);
    return notifications.replace(NotificationGroup.premiumEnd, [
      if (week.isAfter(now))
        (
          id: 0,
          at: week,
          title: t2.renewTitle,
          body: t2.renewBody(date: request),
          payload: premiumEndPayload,
        ),
    ], channelName: t2.channel);
  }
  return notifications.replace(NotificationGroup.premiumEnd, [
    for (final (i, at) in premiumEndTimes(until, now: now).indexed)
      (
        id: i,
        at: at,
        title: at == week ? t2.weekTitle : t2.dayTitle,
        body: at == week ? t2.weekBody(date: date) : t2.dayBody,
        payload: premiumEndPayload,
      ),
  ], channelName: t2.channel);
}
