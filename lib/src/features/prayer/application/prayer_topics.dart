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
      // kept on another day: those ended since are left out
      return [
        for (final topic in cached)
          if (topic.endsOn == null || !topic.endsOn!.isBefore(today())) topic,
      ];
    }
  }
}

/// The topics that ended, the latest first.
@riverpod
Future<List<PrayerTopic>> pastPrayerTopics(Ref ref) =>
    ref.watch(prayerApiProvider).topics(day: today(), archive: true);
