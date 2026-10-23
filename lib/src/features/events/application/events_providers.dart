import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/fetch_policy.dart';
import '../domain/event.dart';
import '../infrastructure/events_api.dart';
import '../infrastructure/events_local_store.dart';
import 'event_reminders.dart';

part 'events_providers.g.dart';

/// Upcoming or past events ([FetchPolicy.cacheAndNetwork]): the last list
/// kept on the phone at once, then the server's; without network, the list
/// kept stays.
@riverpod
class EventList extends _$EventList {
  @override
  Future<List<CommunityEvent>> build(EventPeriod period) => _fetch(
    FetchPolicy.cacheAndNetwork,
    onFresh: (fresh) {
      if (ref.mounted) {
        state = AsyncData(fresh);
      }
    },
  );

  /// Pulled down: the server's list (the one shown stays without network).
  Future<void> refresh() async {
    final result = await AsyncValue.guard(
      () => _fetch(FetchPolicy.networkOnly),
    );
    if (ref.mounted && (result.hasValue || !state.hasValue)) {
      state = result;
    }
  }

  Future<List<CommunityEvent>> _fetch(
    FetchPolicy policy, {
    void Function(List<CommunityEvent> fresh)? onFresh,
  }) {
    final store = ref.read(eventsLocalStoreProvider);
    return fetchWithPolicy(
      policy: policy,
      cached: () => store.list(period),
      network: () => ref.read(eventsApiProvider).list(period: period),
      save: (events) async {
        await store.saveList(period, events);
        // the reminders follow the server's list
        if (period == EventPeriod.upcoming) {
          await ref.read(eventRemindersProvider).plan(events);
        }
      },
      onFresh: onFresh,
    );
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
  // the event as last opened at once (the program on the spot, where the
  // network is often poor), then the server's
  @override
  Future<CommunityEvent> build(int id) {
    final store = ref.read(eventsLocalStoreProvider);
    return fetchWithPolicy(
      policy: FetchPolicy.cacheAndNetwork,
      cached: () => store.event(id),
      network: () => ref.read(eventsApiProvider).get(id),
      save: store.saveEvent,
      onFresh: (fresh) {
        if (ref.mounted) {
          state = AsyncData(fresh);
        }
      },
    );
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
