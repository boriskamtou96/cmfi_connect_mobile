import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../domain/event.dart';
import '../infrastructure/events_api.dart';
import '../infrastructure/events_local_store.dart';
import 'event_reminders.dart';

part 'events_providers.g.dart';

/// Upcoming or past events: from the server, or its last answer kept on the
/// phone when there is no network.
@riverpod
Future<List<CommunityEvent>> eventList(Ref ref, EventPeriod period) async {
  final store = ref.watch(eventsLocalStoreProvider);
  try {
    final events = await ref.watch(eventsApiProvider).list(period: period);
    await store.saveList(period, events);
    if (period == EventPeriod.upcoming) {
      await ref.read(eventRemindersProvider).plan(events);
    }
    return events;
  } on NetworkException {
    final cached = store.list(period);
    if (cached == null) {
      rethrow;
    }
    return cached;
  }
}

/// The event of the home card: the one going on, or the next one.
@riverpod
Future<CommunityEvent?> nextEvent(Ref ref) async {
  final events = await ref.watch(
    eventListProvider(EventPeriod.upcoming).future,
  );
  for (final event in events) {
    if (event.status == EventStatus.published) {
      return event;
    }
  }
  return null;
}

/// The whole event (program, news, photos, the user's registration).
@riverpod
class EventDetail extends _$EventDetail {
  @override
  Future<CommunityEvent> build(int id) async {
    final store = ref.watch(eventsLocalStoreProvider);
    try {
      final event = await ref.watch(eventsApiProvider).get(id);
      await store.saveEvent(event);
      return event;
    } on NetworkException {
      final cached = store.event(id);
      if (cached == null) {
        rethrow;
      }
      return cached;
    }
  }

  /// Registers the user, or changes their answers. Throws an AppException
  /// (EVENT_FULL, REGISTRATION_CLOSED…).
  Future<void> register({
    required int people,
    bool needsLodging = false,
    String departureCity = '',
  }) => _keptAlive(
    () => ref
        .read(eventsApiProvider)
        .register(
          id,
          people: people,
          needsLodging: needsLodging,
          departureCity: departureCity.trim(),
        ),
  );

  /// Throws an AppException on failure.
  Future<void> unregister() =>
      _keptAlive(() => ref.read(eventsApiProvider).unregister(id));

  /// Shows [event] as the server now sends it (after a registration or an
  /// admin's change), updates the lists and plans the reminders again.
  Future<void> replace(CommunityEvent event) async {
    state = AsyncData(event);
    final store = ref.read(eventsLocalStoreProvider);
    final reminders = ref.read(eventRemindersProvider);
    ref.invalidate(eventListProvider);
    await store.saveEvent(event);
    final upcoming = store.list(EventPeriod.upcoming);
    if (upcoming != null) {
      final updated = [
        for (final other in upcoming)
          other.id == event.id
              ? other.copyWith(registration: event.registration)
              : other,
      ];
      await store.saveList(EventPeriod.upcoming, updated);
      await reminders.plan(updated);
    }
  }

  /// The answer of the server is kept even if the user left the page meanwhile.
  Future<void> _keptAlive(Future<CommunityEvent> Function() request) async {
    final link = ref.keepAlive();
    try {
      await replace(await request());
    } finally {
      link.close();
    }
  }
}
