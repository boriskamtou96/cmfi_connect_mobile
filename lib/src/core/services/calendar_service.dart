import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_service.g.dart';

/// Opens the phone's calendar on a new entry, filled in: the user confirms
/// there. Behind a provider so tests replace it.
class CalendarService {
  const CalendarService();

  /// false when no calendar app could open.
  Future<bool> add({
    required String title,
    required DateTime start,
    required DateTime end,
    String description = '',
    String location = '',
  }) => Add2Calendar.addEvent2Cal(
    Event(
      title: title,
      description: description,
      location: location,
      startDate: start,
      endDate: end,
      iosParams: const IOSParams(reminder: Duration(days: 1)),
    ),
  );
}

@Riverpod(keepAlive: true)
CalendarService calendarService(Ref ref) => const CalendarService();
