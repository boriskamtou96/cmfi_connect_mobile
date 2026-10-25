import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/date_extensions.dart';
import '../../disciples/application/disciples.dart';
import '../../disciples/infrastructure/disciples_api.dart';

part 'collective_walk.g.dart';

/// The walk of the group this week, without names and without a ranking: how
/// many disciples shared a report, how many there are, and how many reports
/// came in.
class CollectiveWalk {
  const CollectiveWalk({
    required this.monday,
    required this.walkers,
    required this.disciples,
    required this.reports,
  });

  final DateTime monday;

  /// The disciples who shared at least one report this week.
  final int walkers;

  /// How many disciples the member accompanies.
  final int disciples;
  final int reports;

  double get ratio =>
      disciples <= 0 ? 0 : (walkers / disciples).clamp(0.0, 1.0);
}

/// The collective walk of the member's disciples this week (Monday to
/// Sunday), from the reports they sent in the app. null when the member
/// accompanies nobody.
@riverpod
Future<CollectiveWalk?> collectiveWalk(Ref ref) async {
  final disciples = (await ref.watch(disciplesListProvider().future)).total;
  if (disciples <= 0) {
    return null;
  }
  final monday = today().startOfWeek;
  final nextMonday = DateTime(monday.year, monday.month, monday.day + 7);
  final page = await ref.watch(disciplesApiProvider).received(size: 100);
  final week = [
    for (final report in page.items)
      if (!report.sentAt.toLocal().isBefore(monday) &&
          report.sentAt.toLocal().isBefore(nextMonday))
        report,
  ];
  return CollectiveWalk(
    monday: monday,
    walkers: {for (final report in week) report.member.username}.length,
    disciples: disciples,
    reports: week.length,
  );
}
