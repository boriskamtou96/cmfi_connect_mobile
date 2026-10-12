import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/preferences.dart';
import '../domain/event.dart';
import 'events_api.dart';

part 'events_local_store.g.dart';

/// The last answers of the server, to show the events without network: the
/// upcoming and past lists, and the last events opened (the program on the
/// spot, where the network is often poor). The images stay in the cache of
/// cached_network_image.
class EventsLocalStore {
  const EventsLocalStore(this._preferences);

  final SharedPreferences _preferences;

  static const _listKey = 'events_list_';
  static const _eventsKey = 'events_opened';

  /// Events opened recently, kept to show them offline.
  static const keptEvents = 10;

  List<CommunityEvent>? list(EventPeriod period) {
    final raw = _preferences.getString('$_listKey${period.name}');
    if (raw == null) {
      return null;
    }
    return [
      for (final json in jsonDecode(raw) as List<dynamic>)
        CommunityEvent.fromJson(json as Map<String, dynamic>),
    ];
  }

  Future<void> saveList(EventPeriod period, List<CommunityEvent> events) =>
      _preferences.setString('$_listKey${period.name}', jsonEncode(events));

  CommunityEvent? event(int id) {
    final json = _opened()[id.toString()];
    return json == null ? null : CommunityEvent.fromJson(json);
  }

  /// Keeps [event], and forgets the oldest past [keptEvents].
  Future<void> saveEvent(CommunityEvent event) async {
    final opened = _opened()
      ..remove(event.id.toString())
      ..[event.id.toString()] = event.toJson();
    while (opened.length > keptEvents) {
      opened.remove(opened.keys.first);
    }
    await _preferences.setString(_eventsKey, jsonEncode(opened));
  }

  /// Signing out: the registrations of this account don't stay.
  Future<void> clear() async {
    for (final period in EventPeriod.values) {
      await _preferences.remove('$_listKey${period.name}');
    }
    await _preferences.remove(_eventsKey);
  }

  /// By id, oldest first (a JSON object keeps its order).
  Map<String, Map<String, dynamic>> _opened() {
    final raw = _preferences.getString(_eventsKey);
    if (raw == null) {
      return {};
    }
    return {
      for (final entry in (jsonDecode(raw) as Map<String, dynamic>).entries)
        entry.key: entry.value as Map<String, dynamic>,
    };
  }
}

@Riverpod(keepAlive: true)
EventsLocalStore eventsLocalStore(Ref ref) =>
    EventsLocalStore(ref.watch(sharedPreferencesProvider));
