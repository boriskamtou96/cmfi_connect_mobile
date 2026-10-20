import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/services/app_log.dart';
import '../../../core/utils/countries.dart';
import '../../../core/utils/date_extensions.dart';
import '../../authorities/application/authorities_controller.dart';
import '../../authorities/domain/authority.dart';
import '../../profile/application/current_profile.dart';
import '../../profile/domain/profile.dart';
import '../../reports/application/day_report_controller.dart';
import '../domain/prayer.dart';
import '../domain/retreat.dart';
import '../infrastructure/prayer_api.dart';
import '../infrastructure/prayer_local_store.dart';
import 'prayer_people.dart';
import 'retreat_reminders.dart';

part 'retreats.g.dart';

/// The texts of the retreats in [language], French when it has none.
@Riverpod(keepAlive: true)
Future<RetreatContent> retreatContent(Ref ref, String language) async {
  // read once per language (the provider stays): no need for the bundle's cache
  Future<String> load(String code) =>
      rootBundle.loadString('assets/prayer/retreats_$code.json', cache: false);
  String raw;
  try {
    raw = await load(language);
  } on Object {
    raw = await load('fr');
  }
  return RetreatContent.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

/// A point of a retreat as the user prays it: the text, and what the app
/// adds to it ([people] of a list, or a [value]: the assembly, the leaders,
/// the country of the day…).
class PlannedPoint {
  const PlannedPoint({
    required this.number,
    required this.text,
    this.hint,
    this.people = const [],
    this.value,
  });

  final int number;
  final String text;
  final RetreatHint? hint;
  final List<PrayerPerson> people;

  /// null: nothing to show (no assembly in the profile, no leader…).
  final String? value;
}

/// The fifteen points of a retreat, filled with the user's data. The texts
/// are in the app; what comes from the network (the assembly, the
/// authorities, the lists) is waited for 2 seconds at most, all at once, and
/// what is kept on the phone fills in meanwhile: a retreat opens at once,
/// on a weak network or without one. The fresh values, once there, are kept
/// for the next time.
@riverpod
Future<List<PlannedPoint>> retreatPlan(
  Ref ref,
  RetreatMoment moment,
  String language,
) async {
  final content = await ref.watch(retreatContentProvider(language).future);
  final hints = retreatHints[moment] ?? const {};
  final store = ref.watch(prayerLocalStoreProvider);
  final kept = store.retreatExtras();
  Future<T?> quick<T>(Future<T> future) => future
      .then<T?>((value) => value)
      .timeout(_networkWait, onTimeout: () => null)
      .catchError((Object _) => null);

  final needs = hints.values;
  // asked together, not one after the other
  final profileAsked =
      needs.any((hint) => hint is AssemblyHint || hint is MyCountryHint)
      ? quick(ref.watch(currentProfileProvider.future))
      : Future<Profile?>.value();
  final authoritiesAsked = needs.any((hint) => hint is AuthoritiesHint)
      ? quick(ref.watch(authoritiesControllerProvider.future))
      : Future<List<Authority>?>.value();
  final peopleAsked = needs.any((hint) => hint is ListHint)
      ? quick(ref.watch(prayerPeopleProvider.future))
      : Future<List<PrayerPerson>?>.value();
  final profile = await profileAsked;
  final authorities = await authoritiesAsked;
  final people = await peopleAsked ?? store.people();
  final day = today();

  final assembly =
      _nonEmpty(profile?.assembly) ??
      _nonEmpty(profile?.church) ??
      (profile == null ? _nonEmpty(kept['assembly']) : null);
  final country = profile == null
      ? _nonEmpty(kept['country'])
      : Country.tryParse(profile.country)?.name(language) ??
            _nonEmpty(profile.country);
  final leaders = authorities == null
      ? _nonEmpty(kept['authorities'])
      : _nonEmpty(
          [
            for (final authority in authorities)
              if (authority.status != AuthorityStatus.declined)
                [
                  authority.firstName,
                  authority.lastName ?? '',
                ].where((part) => part.isNotEmpty).join(' '),
          ].join(', '),
        );
  if (profile != null || authorities != null) {
    unawaited(
      store.saveRetreatExtras({
        ...kept,
        if (profile != null) 'assembly': assembly ?? '',
        if (profile != null) 'country': country ?? '',
        if (authorities != null) 'authorities': leaders ?? '',
      }),
    );
  }

  final texts = content.points[moment] ?? const <String>[];
  return [
    for (final (i, text) in texts.indexed)
      switch (hints[i + 1]) {
        null => PlannedPoint(number: i + 1, text: text),
        final AssemblyHint hint => PlannedPoint(
          number: i + 1,
          text: text,
          hint: hint,
          value: assembly,
        ),
        final AuthoritiesHint hint => PlannedPoint(
          number: i + 1,
          text: text,
          hint: hint,
          value: leaders,
        ),
        final ListHint hint => PlannedPoint(
          number: i + 1,
          text: text,
          hint: hint,
          people: nextPeople(people ?? const [], hint.list, group: hint.group),
        ),
        final NationHint hint => PlannedPoint(
          number: i + 1,
          text: text,
          hint: hint,
          value: content.nationOfDay(hint.kind, day),
        ),
        final MyCountryHint hint => PlannedPoint(
          number: i + 1,
          text: text,
          hint: hint,
          // a code ("CM") since the list of countries, free text before
          value: country,
        ),
        final HymnHint hint => PlannedPoint(
          number: i + 1,
          text: text,
          hint: hint,
        ),
      },
  ];
}

/// How long a retreat waits for the network before opening with what the
/// phone keeps.
const _networkWait = Duration(seconds: 2);

String? _nonEmpty(String? value) =>
    value == null || value.trim().isEmpty ? null : value.trim();

/// The retreats of the last week: from the server, with those made without
/// network (sent as soon as it comes back).
@Riverpod(keepAlive: true)
class RetreatLog extends _$RetreatLog {
  /// Days shown (the strip of the Prière tab, the count of the week).
  static const days = 7;

  @override
  Future<List<RetreatRecord>> build() async {
    final store = ref.watch(prayerLocalStoreProvider);
    await sendPending();
    final now = today();
    try {
      final records = await ref
          .watch(prayerApiProvider)
          .retreats(
            from: DateTime(now.year, now.month, now.day - (days - 1)),
            to: now,
          );
      await store.saveRetreats(records);
      return _merge(records, store.pendingRetreats());
    } on NetworkException {
      return _merge(store.retreats() ?? const [], store.pendingRetreats());
    }
  }

  /// The retreat is made: kept on the phone at once, sent when possible.
  /// The people of the lists it prayed for move to the end of their list.
  Future<void> markDone(
    RetreatMoment moment, {
    int minutes = retreatMinutes,
    List<PrayerPerson> prayedFor = const [],
  }) async {
    final record = RetreatRecord(
      day: today(),
      moment: moment,
      minutes: minutes,
    );
    final store = ref.read(prayerLocalStoreProvider);
    state = AsyncData(_merge(state.value ?? const [], [record]));
    try {
      await ref.read(prayerApiProvider).saveRetreat(record);
    } on NetworkException {
      await store.savePendingRetreats(
        _merge(store.pendingRetreats(), [record]),
      );
    }
    await store.saveRetreats(state.value ?? const []);
    if (prayedFor.isNotEmpty) {
      unawaited(
        ref
            .read(prayerPeopleProvider.notifier)
            .markPrayed([for (final person in prayedFor) person.id])
            .catchError((Object _) {}),
      );
    }
    // a retreat done today doesn't need its reminder any more
    unawaited(ref.read(retreatRemindersProvider.notifier).reschedule());
  }

  /// Marked by mistake ("Annuler" after a retreat).
  Future<void> undo(RetreatMoment moment) async {
    final day = today();
    final store = ref.read(prayerLocalStoreProvider);
    bool same(RetreatRecord record) =>
        record.day.isSameDay(day) && record.moment == moment;
    state = AsyncData([...?state.value?.where((record) => !same(record))]);
    await store.savePendingRetreats(
      store.pendingRetreats().where((record) => !same(record)).toList(),
    );
    await store.saveRetreats(state.value ?? const []);
    try {
      await ref.read(prayerApiProvider).deleteRetreat(day, moment);
    } on NetworkException {
      // it will come back from the server; nothing more to do offline
    }
  }

  /// Sends the retreats made without network.
  Future<void> sendPending() async {
    final store = ref.read(prayerLocalStoreProvider);
    final pending = store.pendingRetreats();
    if (pending.isEmpty) {
      return;
    }
    final left = <RetreatRecord>[];
    for (final record in pending) {
      try {
        await ref.read(prayerApiProvider).saveRetreat(record);
      } on NetworkException {
        left.add(record);
      } on UnauthorizedException {
        // the session ended: kept until the next sign-in
        left.add(record);
      } on UnknownException catch (error, stack) {
        left.add(record);
        AppLog.error(error, stack, reason: 'retreat not sent: kept');
      } on ApiException catch (error, stack) {
        // refused for good: dropped
        AppLog.error(
          error,
          stack,
          reason: 'retreat refused (${error.code}): dropped',
        );
      }
    }
    await store.savePendingRetreats(left);
  }

  static List<RetreatRecord> _merge(
    List<RetreatRecord> records,
    List<RetreatRecord> more,
  ) {
    final byKey = <String, RetreatRecord>{
      for (final record in [...records, ...more])
        '${record.day.toApiDate()}/${record.moment.name}': record,
    };
    return byKey.values.toList()..sort((a, b) {
      final day = a.day.compareTo(b.day);
      return day != 0 ? day : a.moment.index.compareTo(b.moment.index);
    });
  }
}

/// The retreats made today.
@Riverpod(keepAlive: true)
Set<RetreatMoment> retreatsToday(Ref ref) {
  final records = ref.watch(retreatLogProvider).value ?? const [];
  final day = today();
  return {
    for (final record in records)
      if (record.day.isSameDay(day)) record.moment,
  };
}

/// The retreats of the week starting on [monday] ("Ta semaine avec Dieu"):
/// from the server, or what the phone keeps of the last days without network.
@riverpod
Future<List<RetreatRecord>> retreatsOfWeek(Ref ref, DateTime monday) =>
    _retreatsBetween(
      ref,
      monday,
      DateTime(monday.year, monday.month, monday.day + 6),
    );

/// The retreats of [year] ("Ton année avec Dieu"), as [retreatsOfWeek]: the
/// server gives a year at most.
@riverpod
Future<List<RetreatRecord>> retreatsOfYear(Ref ref, int year) =>
    _retreatsBetween(ref, DateTime(year), DateTime(year, 12, 31));

Future<List<RetreatRecord>> _retreatsBetween(
  Ref ref,
  DateTime from,
  DateTime to,
) async {
  bool inPeriod(RetreatRecord record) =>
      !record.day.dateOnly.isBefore(from) && !record.day.dateOnly.isAfter(to);
  try {
    final records = await ref
        .watch(prayerApiProvider)
        .retreats(from: from, to: to);
    final pending = ref.read(prayerLocalStoreProvider).pendingRetreats();
    return RetreatLog._merge(records, pending).where(inPeriod).toList();
  } on NetworkException {
    final log = await ref.watch(retreatLogProvider.future);
    return log.where(inPeriod).toList();
  }
}

/// What a retreat added to the day's report.
typedef ReportAddition = ({int added, int total});

/// Adds the minutes of a retreat to "Prière seule" in today's report (and
/// takes them back for "Annuler"). null when the report has no such item.
@riverpod
class RetreatReport extends _$RetreatReport {
  /// The standard item of the solitary prayer.
  static const prayerCode = 'PS';

  @override
  void build() {}

  Future<ReportAddition?> add(int minutes) async {
    final day = today();
    // keeps the day alive while it is read and saved
    final subscription = ref.listen(
      dayReportControllerProvider(day),
      (_, _) {},
    );
    try {
      final draft = await ref.read(dayReportControllerProvider(day).future);
      final entry = draft.entries
          .where((entry) => entry.code == prayerCode && entry.tracksDuration)
          .firstOrNull;
      if (entry == null) {
        return null;
      }
      final total = ((entry.durationMinutes ?? 0) + minutes).clamp(0, 24 * 60);
      ref
          .read(dayReportControllerProvider(day).notifier)
          .updateEntry(
            entry.activityTypeId,
            quantity: entry.quantity,
            durationMinutes: total == 0 ? null : total,
          );
      await ref.read(dayReportControllerProvider(day).notifier).save();
      return (added: minutes, total: total);
    } finally {
      subscription.close();
    }
  }
}
