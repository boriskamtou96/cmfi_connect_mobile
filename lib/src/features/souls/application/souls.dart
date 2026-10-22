import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/session/session.dart';
import '../../../core/storage/account_storage.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/soul.dart';
import '../infrastructure/souls_api.dart';
import '../infrastructure/souls_storage.dart';

part 'souls.g.dart';

/// Suivi des âmes: the people the signed-in member follows, kept on the
/// server (SoulsApi) and on the phone for this account (SoulsStorage), to
/// work offline: a change is written here at once and sent to the server,
/// again later when it can't be now; the server's list then comes back. The
/// souls an older version kept on the phone only are sent once. A day
/// planned to contact someone brings a reminder at 9 o'clock that names
/// nobody (it shows on a locked screen).
@Riverpod(keepAlive: true)
class Souls extends _$Souls {
  /// The payload of the reminders: opens the list.
  static const payload = 'souls';
  static const plannedDays = 30;
  static const _reminderMinutes = 9 * 60;

  int? _account;

  /// Changed here, not on the server yet: to send, to delete there.
  final _dirty = <String>{};
  final _deleted = <String>{};
  Future<void>? _syncing;

  @override
  Future<List<Soul>> build() async {
    final status = await ref.watch(sessionProvider.future);
    if (status != SessionStatus.authenticated) {
      _account = null;
      return const [];
    }
    // a session opened by an older version kept no account: the phone's
    // own place (0)
    final account = await ref.read(accountStorageProvider).read();
    final id = _account = account?.id ?? 0;
    final raw = await ref.watch(soulsStorageProvider).read(id);
    _dirty.clear();
    _deleted.clear();
    var souls = const <Soul>[];
    if (raw != null) {
      try {
        switch (jsonDecode(raw)) {
          // kept by an older version, on the phone only: all to send
          case final List<dynamic> list:
            souls = [
              for (final json in list)
                Soul.fromJson(json as Map<String, dynamic>),
            ];
            _dirty.addAll(souls.map((soul) => soul.id));
          case final Map<String, dynamic> kept:
            souls = [
              for (final json in kept['souls'] as List<dynamic>? ?? const [])
                Soul.fromJson(json as Map<String, dynamic>),
            ];
            _dirty.addAll([...?(kept['dirty'] as List<dynamic>?)].cast());
            _deleted.addAll([...?(kept['deleted'] as List<dynamic>?)].cast());
        }
      } on Object {
        souls = const [];
      }
    }
    // the server's list, once this one is shown
    Future.microtask(sync);
    return souls;
  }

  Future<void> _save(List<Soul> souls) async {
    state = AsyncData(souls);
    await _write();
    await reschedule();
  }

  Future<void> _write() async {
    final account = _account;
    if (account == null) {
      return;
    }
    await ref
        .read(soulsStorageProvider)
        .write(
          account,
          jsonEncode({
            'souls': [
              for (final soul in state.value ?? const <Soul>[]) soul.toJson(),
            ],
            'dirty': [..._dirty],
            'deleted': [..._deleted],
          }),
        );
  }

  /// Sends what changed here, then takes the server's list (what couldn't be
  /// sent stays as it is here). Offline: tried again later.
  Future<void> sync() =>
      _syncing ??= _sync().whenComplete(() => _syncing = null);

  Future<void> _sync() async {
    await future;
    final account = _account;
    if (account == null) {
      return;
    }
    bool same() => ref.mounted && _account == account;
    final api = ref.read(soulsApiProvider);
    try {
      for (final id in [..._dirty]) {
        final sent = byId(id);
        if (sent != null) {
          await api.save(sent);
        }
        // changed again meanwhile: sent next time
        if (byId(id) == sent) {
          _dirty.remove(id);
        }
      }
      for (final id in [..._deleted]) {
        await api.remove(id);
        _deleted.remove(id);
      }
      final server = await api.list();
      if (!same()) {
        return;
      }
      // what changed here meanwhile stays as it is here
      final local = {
        for (final soul in state.value ?? const <Soul>[]) soul.id: soul,
      };
      final kept = {
        for (final soul in server)
          if (!_deleted.contains(soul.id)) soul.id: soul,
      };
      for (final id in _dirty) {
        if (local[id] case final soul?) {
          kept[id] = soul;
        }
      }
      state = AsyncData([
        for (final id in _dirty)
          if (!server.any((soul) => soul.id == id)) ?kept[id],
        for (final soul in server) ?kept[soul.id],
      ]);
      await _write();
      await reschedule();
    } on Object {
      // offline or refused: kept here, sent next time
      if (same()) {
        await _write();
      }
    }
  }

  Soul? byId(String id) {
    for (final soul in state.value ?? const <Soul>[]) {
      if (soul.id == id) {
        return soul;
      }
    }
    return null;
  }

  /// Adds [soul] (its id made here) and gives it back.
  Future<Soul> add(Soul soul) async {
    final current = await future;
    final added = Soul(
      id: DateTime.now().microsecondsSinceEpoch.toRadixString(36),
      name: soul.name,
      phone: soul.phone,
      place: soul.place,
      metOn: soul.metOn,
      stage: soul.stage,
      nextContact: soul.nextContact,
      notes: soul.notes,
    );
    if (soul.nextContact != null) {
      await ref.read(localNotificationsProvider).requestPermission();
    }
    _dirty.add(added.id);
    await _save([added, ...current]);
    unawaited(sync());
    return added;
  }

  Future<void> save(Soul soul) async {
    final current = await future;
    final before = byId(soul.id);
    if (soul.nextContact != null && before?.nextContact == null) {
      await ref.read(localNotificationsProvider).requestPermission();
    }
    _dirty.add(soul.id);
    await _save([
      for (final known in current) known.id == soul.id ? soul : known,
    ]);
    unawaited(sync());
  }

  Future<void> remove(String id) async {
    final current = await future;
    _dirty.remove(id);
    _deleted.add(id);
    await _save([
      for (final soul in current)
        if (soul.id != id) soul,
    ]);
    unawaited(sync());
  }

  Future<void> addNote(String id, String text) async {
    final soul = byId(id);
    if (soul == null || text.trim().isEmpty) {
      return;
    }
    await save(
      soul.copyWith(
        notes: [
          SoulNote(at: DateTime.now(), text: text.trim()),
          ...soul.notes,
        ],
      ),
    );
  }

  Future<void> removeNote(String id, SoulNote note) async {
    final soul = byId(id);
    if (soul == null) {
      return;
    }
    await save(
      soul.copyWith(
        notes: [
          for (final kept in soul.notes)
            if (kept != note) kept,
        ],
      ),
    );
  }

  /// The next 30 days with someone to contact, at 9 o'clock; today too when
  /// it is not 9 yet, with those already late.
  Future<void> reschedule() async {
    final notifications = ref.read(localNotificationsProvider);
    final souls = state.value ?? const <Soul>[];
    final planned = <PlannedNotification>[];
    final t = LocaleSettings.instance.currentTranslations.souls;
    final now = DateTime.now();
    final first = today();
    for (var i = 0; i < plannedDays; i++) {
      final day = DateTime(first.year, first.month, first.day + i);
      final count = souls
          .where(
            (soul) =>
                soul.nextContact != null &&
                (i == 0 ? soul.dueBy(day) : soul.nextContact == day),
          )
          .length;
      final at = day.add(const Duration(minutes: _reminderMinutes));
      if (count == 0 || !at.isAfter(now)) {
        continue;
      }
      planned.add((
        id: i,
        at: at,
        title: t.reminderTitle,
        body: t.reminderBody(n: count),
        payload: payload,
      ));
    }
    await notifications.replace(
      NotificationGroup.souls,
      planned,
      channelName: t.reminderChannel,
    );
    await _planPrayers();
  }

  /// The person to pray for on [day]: each one in turn, the same all day
  /// (by the order they were added); null without anyone.
  Soul? toPrayFor(DateTime day) {
    final souls = [...?state.value]..sort((a, b) => a.id.compareTo(b.id));
    if (souls.isEmpty) {
      return null;
    }
    final days = DateTime.utc(
      day.year,
      day.month,
      day.day,
    ).difference(DateTime.utc(2026)).inDays;
    return souls[days % souls.length];
  }

  /// The daily reminder to pray for the person of the day (key
  /// `souls_prayer`, off until turned on, 7 o'clock).
  ({bool on, int minutes}) prayerReminder() {
    final raw = ref.read(sharedPreferencesProvider).getString(prayerKey);
    if (raw == null) {
      return (on: false, minutes: 7 * 60);
    }
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return (on: json['on'] as bool, minutes: json['minutes'] as int);
  }

  static const prayerKey = 'souls_prayer';

  Future<void> setPrayerReminder({bool? on, int? minutes}) async {
    final current = prayerReminder();
    final next = (on: on ?? current.on, minutes: minutes ?? current.minutes);
    if (next.on && !current.on) {
      await ref.read(localNotificationsProvider).requestPermission();
    }
    await ref
        .read(sharedPreferencesProvider)
        .setString(
          prayerKey,
          jsonEncode({'on': next.on, 'minutes': next.minutes}),
        );
    ref.notifyListeners();
    await reschedule();
  }

  /// The next 14 mornings, while someone is followed: no name in them.
  Future<void> _planPrayers() async {
    final notifications = ref.read(localNotificationsProvider);
    final setting = prayerReminder();
    if (!setting.on || (state.value ?? const []).isEmpty) {
      await notifications.cancel(NotificationGroup.soulsPrayer);
      return;
    }
    final t = LocaleSettings.instance.currentTranslations.souls;
    final now = DateTime.now();
    final first = today();
    await notifications.replace(NotificationGroup.soulsPrayer, [
      for (var i = 0; i < 14; i++)
        if (DateTime(
              first.year,
              first.month,
              first.day + i,
            ).add(Duration(minutes: setting.minutes))
            case final at when at.isAfter(now))
          (
            id: i,
            at: at,
            title: t.prayerTitle,
            body: t.prayerBody,
            payload: payload,
          ),
    ], channelName: t.prayerChannel);
  }

  /// Signing out: the list stays in this account's place, its reminders go.
  Future<void> forget() async {
    final notifications = ref.read(localNotificationsProvider);
    await notifications.cancel(NotificationGroup.souls);
    await notifications.cancel(NotificationGroup.soulsPrayer);
  }
}

/// The lock of Suivi des âmes (key `souls_lock`): Face ID or the fingerprint
/// each time the list is opened.
@Riverpod(keepAlive: true)
class SoulsLock extends _$SoulsLock {
  static const key = 'souls_lock';

  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(key) ?? false;

  Future<void> set(bool on) async {
    await ref.read(sharedPreferencesProvider).setBool(key, on);
    state = on;
  }
}
