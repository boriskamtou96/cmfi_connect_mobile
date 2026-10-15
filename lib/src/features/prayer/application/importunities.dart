import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/services/app_log.dart';
import '../../members/domain/member.dart';
import '../domain/prayer.dart';
import '../infrastructure/prayer_api.dart';
import '../infrastructure/prayer_local_store.dart';

part 'importunities.g.dart';

/// The importunity topics the user prays for or is invited to. The
/// proclamations counted without network are added to what the server says,
/// and sent as soon as it comes back.
@Riverpod(keepAlive: true)
class Importunities extends _$Importunities {
  @override
  Future<List<Importunity>> build() async {
    final store = ref.watch(prayerLocalStoreProvider);
    await sendCounts();
    try {
      final topics = await ref.watch(prayerApiProvider).importunities();
      await store.saveImportunities(topics);
      return _withPending(topics);
    } on NetworkException {
      final cached = store.importunities();
      if (cached == null) {
        rethrow;
      }
      return _withPending(cached);
    }
  }

  /// Creates a topic; throws an AppException on failure.
  Future<Importunity> create({
    required String title,
    String description = '',
    int? goal,
  }) async {
    final created = await ref
        .read(prayerApiProvider)
        .createImportunity(
          title: title.trim(),
          description: description.trim(),
          goal: goal,
        );
    await _show(created);
    return created;
  }

  /// Its author changes it, or closes / opens it again.
  Future<Importunity> edit(
    Importunity topic, {
    required String title,
    required String description,
    required int? goal,
    ImportunityStatus? status,
  }) async {
    final saved = await ref
        .read(prayerApiProvider)
        .updateImportunity(
          topic.id,
          title: title.trim(),
          description: description.trim(),
          goal: goal,
          status: status ?? topic.status,
        );
    await _show(saved);
    return saved;
  }

  Future<void> delete(Importunity topic) async {
    await ref.read(prayerApiProvider).deleteImportunity(topic.id);
    await _forget(topic.id);
  }

  Future<void> leave(Importunity topic) async {
    await ref.read(prayerApiProvider).leave(topic.id);
    await _forget(topic.id);
  }

  /// Joins or declines an invitation.
  Future<Importunity?> answer(Importunity topic, {required bool join}) async {
    final joined = await ref
        .read(prayerApiProvider)
        .answer(topic.id, join: join);
    if (joined == null) {
      await _forget(topic.id);
    } else {
      await _show(joined);
    }
    return joined;
  }

  /// Blocks whoever sent this invitation: the server removes their pending
  /// invitations to the user and drops the next ones. The list comes again
  /// from the server.
  Future<void> blockInviter(Importunity topic) async {
    await ref.read(prayerApiProvider).block(topic.inviter.username);
    await _forget(topic.id);
    ref
      ..invalidate(blockedMembersProvider)
      ..invalidateSelf();
  }

  /// Reports this invitation (and who sent it) to the leaders.
  Future<void> reportInvitation(
    Importunity topic, {
    required ReportReason reason,
    String comment = '',
  }) => ref
      .read(prayerApiProvider)
      .report(
        username: topic.inviter.username,
        importunityId: topic.id,
        reason: reason,
        comment: comment,
      );

  /// How many new invitations went out (USERNAME_NOT_FOUND…).
  Future<int> invite(
    Importunity topic, {
    List<String> usernames = const [],
    bool family = false,
  }) async {
    final count = await ref
        .read(prayerApiProvider)
        .invite(topic.id, usernames: usernames, family: family);
    await refresh(topic.id);
    return count;
  }

  /// Counts [amount] proclamations at once on the phone; [sendCounts] sends
  /// them (the counter calls it a moment after the last tap).
  Future<void> count(Importunity topic, int amount) async {
    final store = ref.read(prayerLocalStoreProvider);
    final pending = store.pendingCounts();
    pending[topic.id] = (pending[topic.id] ?? 0) + amount;
    await store.savePendingCounts(pending);
    if (ref.mounted) {
      state = AsyncData([
        for (final other in state.value ?? const <Importunity>[])
          other.id == topic.id
              ? other.copyWith(
                  total: other.total + amount,
                  myCount: other.myCount + amount,
                )
              : other,
      ]);
    }
  }

  /// Proclamations of [id] not sent yet.
  int pendingOf(int id) =>
      ref.read(prayerLocalStoreProvider).pendingCounts()[id] ?? 0;

  /// Sends the proclamations counted on the phone. Without network they
  /// wait; refused for good (topic closed, deleted…) they are dropped.
  Future<void> sendCounts() async {
    final store = ref.read(prayerLocalStoreProvider);
    final pending = store.pendingCounts();
    for (final entry in pending.entries.toList()) {
      var left = entry.value;
      try {
        // the server takes 10 000 at most at once
        while (left > 0) {
          final amount = left > 10000 ? 10000 : left;
          final topic = await ref
              .read(prayerApiProvider)
              .count(entry.key, amount);
          left -= amount;
          final now = store.pendingCounts()..[entry.key] = left;
          await store.savePendingCounts(now);
          if (left == 0 && ref.mounted && state.hasValue) {
            await _show(topic);
          }
        }
      } on NetworkException {
        return;
      } on UnauthorizedException {
        // the session ended: kept until the next sign-in
        return;
      } on UnknownException catch (error, stack) {
        AppLog.error(error, stack, reason: 'proclamations not sent: kept');
        return;
      } on ApiException catch (error, stack) {
        // the topic is gone or closed: these proclamations can't be counted
        AppLog.error(
          error,
          stack,
          reason: '$left proclamations refused (${error.code}): dropped',
        );
        final now = store.pendingCounts()..remove(entry.key);
        await store.savePendingCounts(now);
      }
    }
  }

  /// The topic as the server has it now (after an invitation, an answer…).
  Future<Importunity> refresh(int id) async {
    final topic = await ref.read(prayerApiProvider).importunity(id);
    await _show(topic);
    return topic;
  }

  List<Importunity> _withPending(List<Importunity> topics) {
    final pending = ref.read(prayerLocalStoreProvider).pendingCounts();
    return [
      for (final topic in topics)
        switch (pending[topic.id]) {
          final amount? when amount > 0 => topic.copyWith(
            total: topic.total + amount,
            myCount: topic.myCount + amount,
          ),
          _ => topic,
        },
    ];
  }

  Future<void> _show(Importunity topic) async {
    final shown = _withPending([topic]).single;
    final topics = [...?state.value];
    final at = topics.indexWhere((other) => other.id == topic.id);
    if (at < 0) {
      topics.insert(0, shown);
    } else {
      topics[at] = shown;
    }
    if (ref.mounted) {
      state = AsyncData(topics);
    }
    await ref.read(prayerLocalStoreProvider).saveImportunities(topics);
  }

  Future<void> _forget(int id) async {
    final topics = [
      for (final other in state.value ?? const <Importunity>[])
        if (other.id != id) other,
    ];
    if (ref.mounted) {
      state = AsyncData(topics);
    }
    final store = ref.read(prayerLocalStoreProvider);
    await store.saveImportunities(topics);
    await store.savePendingCounts(store.pendingCounts()..remove(id));
  }
}

/// One topic as the server has it, with who prays (names only). The counts
/// shown come from [importunitiesProvider], which adds the taps not sent yet:
/// counting doesn't ask the server again.
@riverpod
Future<Importunity> importunityDetail(Ref ref, int id) =>
    ref.watch(prayerApiProvider).importunity(id);

/// Whom "invite my spiritual family" reaches.
@riverpod
Future<PrayerFamily> prayerFamily(Ref ref) =>
    ref.watch(prayerApiProvider).family();

/// The members the user blocked (Plus › Membres bloqués): their invitations
/// to pray don't reach the user any more.
@riverpod
class BlockedMembers extends _$BlockedMembers {
  @override
  Future<List<MemberCard>> build() => ref.watch(prayerApiProvider).blocked();

  /// They can invite the user again. Throws an AppException on failure.
  Future<void> unblock(MemberCard member) async {
    await ref.read(prayerApiProvider).unblock(member.username);
    if (ref.mounted) {
      state = AsyncData([
        for (final other in state.value ?? const <MemberCard>[])
          if (other.username != member.username) other,
      ]);
    }
  }
}
