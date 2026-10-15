import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../../reports/application/day_report_controller.dart';
import '../domain/bible.dart';

part 'bible_reading.g.dart';

/// The chapters marked "J'ai lu ce chapitre" today ("JHN.3"), each one added
/// to "Lecture biblique" in today's report.
@riverpod
class BibleReading extends _$BibleReading {
  static const _key = 'bible_read_today';

  /// The standard item of the Bible reading, counted in chapters.
  static const readingCode = 'LB';

  @override
  Set<String> build() {
    final json = ref.watch(sharedPreferencesProvider).getString(_key);
    if (json == null) {
      return const {};
    }
    try {
      final saved = jsonDecode(json) as Map<String, dynamic>;
      if (saved['day'] != _day) {
        return const {};
      }
      return {for (final key in saved['chapters'] as List<dynamic>) '$key'};
    } on Object {
      return const {};
    }
  }

  static String get _day => today().toIso8601String().substring(0, 10);

  /// Counts [chapter] in today's report. Returns the chapters of the day,
  /// or null when the report has no Bible reading item.
  Future<int?> markRead(BibleRef chapter) async {
    final total = await _addToReport(1);
    if (total != null) {
      await _keep({...state, chapter.chapterRef.key});
    }
    return total;
  }

  /// "Annuler": takes the chapter back out of the report.
  Future<int?> unmark(BibleRef chapter) async {
    final total = await _addToReport(-1);
    await _keep({...state}..remove(chapter.chapterRef.key));
    return total;
  }

  Future<void> _keep(Set<String> chapters) async {
    state = chapters;
    await ref
        .read(sharedPreferencesProvider)
        .setString(
          _key,
          jsonEncode({'day': _day, 'chapters': chapters.toList()}),
        );
  }

  Future<int?> _addToReport(int chapters) async {
    final day = today();
    // keeps the day alive while it is read and saved
    final subscription = ref.listen(
      dayReportControllerProvider(day),
      (_, _) {},
    );
    try {
      final draft = await ref.read(dayReportControllerProvider(day).future);
      final entry = draft.entries
          .where((entry) => entry.code == readingCode && entry.tracksQuantity)
          .firstOrNull;
      if (entry == null) {
        return null;
      }
      final total = ((entry.quantity ?? 0) + chapters).clamp(0, 9999);
      ref
          .read(dayReportControllerProvider(day).notifier)
          .updateEntry(
            entry.activityTypeId,
            quantity: total == 0 ? null : total,
            durationMinutes: entry.durationMinutes,
          );
      await ref.read(dayReportControllerProvider(day).notifier).save();
      return total;
    } finally {
      subscription.close();
    }
  }
}
