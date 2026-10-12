import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/prayer.dart';
import '../infrastructure/prayer_api.dart';
import '../infrastructure/prayer_local_store.dart';

part 'prayer_topics.g.dart';

/// The topics of the community for today: from the server, or the copy kept
/// on the phone.
@riverpod
class PrayerTopics extends _$PrayerTopics {
  @override
  Future<List<PrayerTopic>> build() async {
    final store = ref.watch(prayerLocalStoreProvider);
    try {
      final topics = await ref.watch(prayerApiProvider).topics(day: today());
      await store.saveTopics(topics);
      return topics;
    } on NetworkException {
      final cached = store.topics();
      if (cached == null) {
        rethrow;
      }
      // kept on another day: today nothing is prayed yet
      return [
        for (final topic in cached)
          if (topic.endsOn == null || !topic.endsOn!.isBefore(today())) topic,
      ];
    }
  }

  /// The points prayed for today: shown at once, sent to the server. Throws
  /// an AppException on failure (the topic is shown as before).
  Future<void> setPrayed(PrayerTopic topic, List<int> positions) async {
    final before = state.value;
    final sorted = positions.toSet().toList()..sort();
    _show(topic.copyWith(prayedToday: sorted));
    final link = ref.keepAlive();
    try {
      _show(
        await ref
            .read(prayerApiProvider)
            .setPrayed(topic.id, day: today(), positions: sorted),
      );
      await ref
          .read(prayerLocalStoreProvider)
          .saveTopics(state.value ?? const []);
    } catch (_) {
      if (ref.mounted && before != null) {
        state = AsyncData(before);
      }
      rethrow;
    } finally {
      link.close();
    }
  }

  void _show(PrayerTopic topic) {
    if (!ref.mounted) {
      return;
    }
    state = AsyncData([
      for (final other in state.value ?? const <PrayerTopic>[])
        other.id == topic.id ? topic : other,
    ]);
  }
}

/// The topics that ended, the latest first.
@riverpod
Future<List<PrayerTopic>> pastPrayerTopics(Ref ref) =>
    ref.watch(prayerApiProvider).topics(day: today(), archive: true);
