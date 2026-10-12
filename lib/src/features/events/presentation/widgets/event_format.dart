import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/zoned_time.dart';
import '../../domain/event.dart';

/// Where an event stands for the user, today.
enum EventTiming { ahead, tomorrow, today, onNow, over }

/// [timing] and the days left before [event] (on the phone's calendar).
({EventTiming timing, int days}) timingOf(CommunityEvent event, DateTime now) {
  if (event.isOver(now)) {
    return (timing: EventTiming.over, days: 0);
  }
  if (event.isOn(now)) {
    return (timing: EventTiming.onNow, days: 0);
  }
  final days = event.daysUntil(now);
  return (
    timing: switch (days) {
      0 => EventTiming.today,
      1 => EventTiming.tomorrow,
      _ => EventTiming.ahead,
    },
    days: days,
  );
}

extension EventFormatX on BuildContext {
  String get _locale => Localizations.localeOf(this).toLanguageTag();

  /// "Dans 42 jours", "Demain", "En cours"… ([short]: "J-42").
  String countdown(CommunityEvent event, DateTime now, {bool short = false}) {
    final t = this.t.events;
    final (:timing, :days) = timingOf(event, now);
    return switch (timing) {
      EventTiming.ahead => short ? t.daysLeft(n: days) : t.inDays(n: days),
      EventTiming.tomorrow => t.tomorrow,
      EventTiming.today => t.today,
      EventTiming.onNow => t.onNow,
      EventTiming.over => t.over,
    };
  }

  /// "20 – 22 nov. 2026", on the venue's calendar.
  String eventDates(DateTime startsAt, DateTime endsAt, String timeZone) =>
      formatDayRange(startsAt, endsAt, timeZone: timeZone);

  /// "Vendredi 20 – dimanche 22 novembre 2026" (or a single day).
  String eventDatesLong(CommunityEvent event) {
    final start = event.startsAt.inZone(event.timeZone);
    final end = event.endsAt.inZone(event.timeZone);
    if (start.year == end.year &&
        start.month == end.month &&
        start.day == end.day) {
      return formatDate(start, 'EEEE d MMMM y').capitalized;
    }
    final startPattern = start.year != end.year
        ? 'EEEE d MMMM y'
        : start.month != end.month
        ? 'EEEE d MMMM'
        : 'EEEE d';
    return '${formatDate(start, startPattern).capitalized} – '
        '${formatDate(end, 'EEEE d MMMM y')}';
  }

  /// "De 08:00 à 13:00", or "Ouverture le vendredi à 08:00, clôture le
  /// dimanche à 13:00".
  String eventHours(CommunityEvent event) {
    final start = event.startsAt.inZone(event.timeZone);
    final end = event.endsAt.inZone(event.timeZone);
    final sameDay =
        start.year == end.year &&
        start.month == end.month &&
        start.day == end.day;
    if (sameDay) {
      return this.t.events.oneDay(start: time(start), end: time(end));
    }
    return this.t.events.severalDays(
      startDay: formatDate(start, 'EEEE'),
      start: time(start),
      endDay: formatDate(end, 'EEEE'),
      end: time(end),
    );
  }

  /// "(heure de Yaoundé)" when the phone's clock shows another time than the
  /// venue's, '' otherwise.
  String venueTimeNote(CommunityEvent event) {
    final venue = event.startsAt.inZone(event.timeZone);
    final phone = event.startsAt.toLocal();
    if (venue.timeZoneOffset == phone.timeZoneOffset) {
      return '';
    }
    final place = event.city.isNotEmpty ? event.city : event.timeZone;
    return this.t.events.venueTime(place: place);
  }

  /// "08:00".
  String time(DateTime date) => DateFormat.Hm(_locale).format(date);

  /// "1 500" in French, "1,500" in English. The narrow space of French
  /// numbers becomes a plain no-break one: Onest doesn't draw the narrow one.
  String count(int n) => NumberFormat.decimalPattern(
    _locale,
  ).format(n).replaceAll('\u202F', '\u00A0');
}
