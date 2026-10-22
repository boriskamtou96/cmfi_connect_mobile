import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/date_extensions.dart';
import '../domain/disciple.dart';
import '../infrastructure/disciples_api.dart';

part 'disciples.g.dart';

/// The members who chose the user as disciple maker or as an authority,
/// matching [search] ("Mes disciples"): the first page, then the next ones
/// added by [loadMore] as the list scrolls to its end.
@riverpod
class DisciplesList extends _$DisciplesList {
  var _loadingMore = false;

  @override
  Future<DisciplesPage> build({String search = ''}) =>
      ref.watch(disciplesApiProvider).list(today: today(), search: search);

  /// More pages to come.
  bool get _hasMore => switch (state.value) {
    final page? => page.items.length < page.total,
    null => false,
  };

  /// Adds the next page (once at a time). A failure leaves the list as it
  /// is: scrolling to its end again retries.
  Future<void> loadMore() async {
    final loaded = state.value;
    if (loaded == null || _loadingMore || !_hasMore) {
      return;
    }
    _loadingMore = true;
    try {
      final next = await ref
          .read(disciplesApiProvider)
          .list(
            today: today(),
            search: search,
            page: loaded.items.length ~/ disciplesPageSize + 1,
          );
      if (ref.mounted) {
        state = AsyncData((
          items: [...loaded.items, ...next.items],
          total: next.total,
        ));
      }
    } on Object {
      // the skeleton stays at the end; the next scroll asks again
    } finally {
      _loadingMore = false;
    }
  }
}

/// The longest period the server gives at once.
const maxDiscipleReportDays = 92;

/// How many days a page of a disciple's reports covers.
const discipleReportsPage = 30;

/// The reports of the disciple [authorityId] over [pages] pages of 30 days,
/// ending today (one more page with "Voir les 30 jours précédents").
@riverpod
Future<DiscipleReports> discipleReports(
  Ref ref,
  int authorityId, {
  int pages = 1,
}) {
  final end = today();
  return ref
      .watch(disciplesApiProvider)
      .reports(
        authorityId,
        from: DateTime(
          end.year,
          end.month,
          end.day - discipleReportsPage * pages + 1,
        ),
        to: end,
      );
}

/// The reports of the disciple [authorityId] from [from] to [to] (92 days at
/// most): the period picked with "Filtrer par date".
@riverpod
Future<DiscipleReports> discipleReportsBetween(
  Ref ref,
  int authorityId, {
  required DateTime from,
  required DateTime to,
}) => ref.watch(disciplesApiProvider).reports(authorityId, from: from, to: to);
