import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/prayer.dart';
import '../infrastructure/prayer_api.dart';
import '../infrastructure/prayer_local_store.dart';

part 'prayer_people.g.dart';

/// The user's own lists (those who have not believed yet, believers,
/// backsliders, co-workers): from the server, or the copy kept on the phone.
@Riverpod(keepAlive: true)
class PrayerPeople extends _$PrayerPeople {
  @override
  Future<List<PrayerPerson>> build() async {
    final store = ref.watch(prayerLocalStoreProvider);
    try {
      final people = await ref.watch(prayerApiProvider).people();
      await store.savePeople(people);
      return people;
    } on NetworkException {
      final cached = store.people();
      if (cached == null) {
        rethrow;
      }
      return cached;
    }
  }

  /// Throws an AppException on failure (TOO_MANY_PEOPLE…).
  Future<PrayerPerson> add(
    PrayerList list,
    String name, {
    String note = '',
  }) async {
    final person = await ref
        .read(prayerApiProvider)
        .addPerson(list: list, name: name.trim(), note: note.trim());
    await _replace([...?state.value, person]);
    return person;
  }

  /// Throws an AppException on failure.
  Future<void> save(PrayerPerson person) async {
    final saved = await ref
        .read(prayerApiProvider)
        .updatePerson(
          person.copyWith(name: person.name.trim(), note: person.note.trim()),
        );
    await _replace([
      for (final other in state.value ?? const <PrayerPerson>[])
        other.id == saved.id ? saved : other,
    ]);
  }

  /// Believed in the Lord, came back, or the prayer was answered (today);
  /// [answered] false puts them back in the list.
  Future<void> setAnswered(PrayerPerson person, {required bool answered}) =>
      save(person.copyWith(answeredOn: answered ? today() : null));

  /// Throws an AppException on failure.
  Future<void> remove(PrayerPerson person) async {
    await ref.read(prayerApiProvider).deletePerson(person.id);
    await _replace([
      for (final other in state.value ?? const <PrayerPerson>[])
        if (other.id != person.id) other,
    ]);
  }

  /// A retreat prayed for them today: they go to the end of their list.
  Future<void> markPrayed(List<int> ids) async {
    if (ids.isEmpty) {
      return;
    }
    final day = today();
    // at once on the phone, so the next retreat takes the next ones
    await _replace([
      for (final person in state.value ?? const <PrayerPerson>[])
        ids.contains(person.id) ? person.copyWith(lastPrayedOn: day) : person,
    ]);
    try {
      await _replace(
        await ref.read(prayerApiProvider).markPrayed(ids, day: day),
      );
    } on NetworkException {
      // the phone keeps the order; the server learns it at the next retreat
    }
  }

  Future<void> _replace(List<PrayerPerson> people) async {
    if (ref.mounted) {
      state = AsyncData(people);
    }
    await ref.read(prayerLocalStoreProvider).savePeople(people);
  }
}

/// This month's answered prayers, the latest first (the Prière tab).
@riverpod
List<PrayerPerson> answeredThisMonth(Ref ref) {
  final people = ref.watch(prayerPeopleProvider).value ?? const [];
  final month = today().startOfMonth;
  return [
    for (final person in people)
      if (person.answeredOn case final day? when !day.isBefore(month)) person,
  ]..sort((a, b) => b.answeredOn!.compareTo(a.answeredOn!));
}
