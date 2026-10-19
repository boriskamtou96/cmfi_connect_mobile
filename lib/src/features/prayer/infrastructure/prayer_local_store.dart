import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/preferences.dart';
import '../domain/prayer.dart';

part 'prayer_local_store.g.dart';

/// What the prayer module keeps on the phone: the last answers of the server
/// (to pray without network) and what waits to be sent (retreats made and
/// proclamations counted offline).
class PrayerLocalStore {
  const PrayerLocalStore(this._preferences);

  final SharedPreferences _preferences;

  static const _topicsKey = 'prayer_topics';
  static const _peopleKey = 'prayer_people';
  static const _retreatsKey = 'prayer_retreats';
  static const _pendingRetreatsKey = 'prayer_retreats_pending';
  static const _importunitiesKey = 'prayer_importunities';
  static const _pendingCountsKey = 'prayer_counts_pending';
  static const _retreatExtrasKey = 'prayer_retreat_extras';

  List<T>? _list<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final raw = _preferences.getString(key);
    if (raw == null) {
      return null;
    }
    return [
      for (final json in jsonDecode(raw) as List<dynamic>)
        fromJson(json as Map<String, dynamic>),
    ];
  }

  Future<void> _save(String key, List<Object> items) =>
      _preferences.setString(key, jsonEncode(items));

  /// What the retreats add from the network (the assembly, the country,
  /// the authorities' names), as last known: a retreat opens at once,
  /// without network too.
  Map<String, String> retreatExtras() {
    final raw = _preferences.getString(_retreatExtrasKey);
    if (raw == null) {
      return const {};
    }
    try {
      return (jsonDecode(raw) as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, '$value'),
      );
    } on Object {
      return const {};
    }
  }

  Future<void> saveRetreatExtras(Map<String, String> extras) =>
      _preferences.setString(_retreatExtrasKey, jsonEncode(extras));

  List<PrayerTopic>? topics() => _list(_topicsKey, PrayerTopic.fromJson);
  Future<void> saveTopics(List<PrayerTopic> topics) =>
      _save(_topicsKey, topics);

  List<PrayerPerson>? people() => _list(_peopleKey, PrayerPerson.fromJson);
  Future<void> savePeople(List<PrayerPerson> people) =>
      _save(_peopleKey, people);

  /// The retreats of the last days, as the server last sent them.
  List<RetreatRecord>? retreats() =>
      _list(_retreatsKey, RetreatRecord.fromJson);
  Future<void> saveRetreats(List<RetreatRecord> retreats) =>
      _save(_retreatsKey, retreats);

  /// Retreats made without network, to send.
  List<RetreatRecord> pendingRetreats() =>
      _list(_pendingRetreatsKey, RetreatRecord.fromJson) ?? const [];
  Future<void> savePendingRetreats(List<RetreatRecord> retreats) =>
      _save(_pendingRetreatsKey, retreats);

  List<Importunity>? importunities() =>
      _list(_importunitiesKey, Importunity.fromJson);
  Future<void> saveImportunities(List<Importunity> importunities) =>
      _save(_importunitiesKey, importunities);

  /// Proclamations counted and not sent yet, by topic.
  Map<int, int> pendingCounts() {
    final raw = _preferences.getString(_pendingCountsKey);
    if (raw == null) {
      return {};
    }
    return {
      for (final entry in (jsonDecode(raw) as Map<String, dynamic>).entries)
        int.parse(entry.key): entry.value as int,
    };
  }

  Future<void> savePendingCounts(Map<int, int> counts) =>
      _preferences.setString(
        _pendingCountsKey,
        jsonEncode({
          for (final entry in counts.entries)
            if (entry.value > 0) entry.key.toString(): entry.value,
        }),
      );

  /// Signing out: nothing of this account stays on the phone.
  Future<void> clear() async {
    for (final key in [
      _topicsKey,
      _peopleKey,
      _retreatsKey,
      _pendingRetreatsKey,
      _importunitiesKey,
      _pendingCountsKey,
      _retreatExtrasKey,
    ]) {
      await _preferences.remove(key);
    }
  }
}

@Riverpod(keepAlive: true)
PrayerLocalStore prayerLocalStore(Ref ref) =>
    PrayerLocalStore(ref.watch(sharedPreferencesProvider));
