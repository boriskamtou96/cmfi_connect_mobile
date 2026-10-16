import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/ministry_person.dart';
import '../infrastructure/ministry_api.dart';

part 'ministry_people.g.dart';

/// Nos missionnaires, Nos héros: the copy of the phone at once (the last
/// one seen), then the server's when it answers. Never seen and no network:
/// the error, with "Réessayer".
@Riverpod(keepAlive: true)
class MinistryPeople extends _$MinistryPeople {
  @override
  Future<List<MinistryPerson>> build(MinistryPersonKind kind) async {
    final saved = ref.watch(ministryLocalStoreProvider).savedPeople(kind);
    if (saved == null) {
      return _fetch();
    }
    unawaited(refresh());
    return saved;
  }

  Future<List<MinistryPerson>> _fetch() async {
    final people = await ref.read(ministryApiProvider).people(kind);
    await ref.read(ministryLocalStoreProvider).savePeople(kind, people);
    return people;
  }

  Future<void> refresh() async {
    try {
      final people = await _fetch();
      if (ref.mounted) {
        state = AsyncData(people);
      }
    } on Object {
      // no network: the copy of the phone stays
    }
  }
}
