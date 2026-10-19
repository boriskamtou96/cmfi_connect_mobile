import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/received_report.dart';
import '../infrastructure/disciples_api.dart';

part 'received_reports.freezed.dart';
part 'received_reports.g.dart';

@freezed
abstract class ReceivedReportsState with _$ReceivedReportsState {
  const factory ReceivedReportsState({
    required List<ReceivedReport> items,
    required int total,
    @Default(1) int page,
    @Default(false) bool loadingMore,
  }) = _ReceivedReportsState;

  const ReceivedReportsState._();

  bool get hasMore => items.length < total;

  /// Not opened yet, among those loaded (the newest).
  int get unread => items.where((item) => item.unread).length;
}

/// The reports the disciples sent the user in the app (« Comptes rendus
/// reçus »), a page at a time; opened and answered here.
@Riverpod(keepAlive: true)
class ReceivedReports extends _$ReceivedReports {
  static const pageSize = 20;

  @override
  Future<ReceivedReportsState> build() async {
    final page = await ref.watch(disciplesApiProvider).received(size: pageSize);
    return ReceivedReportsState(items: page.items, total: page.total);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) {
      return;
    }
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final next = await ref
          .read(disciplesApiProvider)
          .received(page: current.page + 1, size: pageSize);
      state = AsyncData(
        current.copyWith(
          items: [
            ...current.items,
            ...next.items.where(
              (item) => current.items.every((known) => known.id != item.id),
            ),
          ],
          total: next.total,
          page: current.page + 1,
          loadingMore: false,
        ),
      );
    } on Object {
      state = AsyncData(current.copyWith(loadingMore: false));
    }
  }

  void _replace(ReceivedReport report) {
    final current = state.value;
    if (current == null) {
      return;
    }
    state = AsyncData(
      current.copyWith(
        items: [
          for (final item in current.items)
            item.id == report.id ? report : item,
        ],
      ),
    );
  }

  /// Opened: read at once on the phone, then told to the server.
  Future<void> markRead(ReceivedReport report) async {
    if (!report.unread) {
      return;
    }
    _replace(report.copyWith(readAt: DateTime.now()));
    try {
      await ref.read(disciplesApiProvider).markRead(report.id);
    } on Object {
      // read again next time
    }
  }

  /// The word of encouragement; throws when it doesn't leave.
  Future<void> reply(ReceivedReport report, String text) async {
    final answered = await ref
        .read(disciplesApiProvider)
        .reply(report.id, text);
    _replace(answered);
  }
}

/// The reports received not opened yet (the newest page): the badge of
/// Plus; 0 without network.
@riverpod
int receivedReportsUnread(Ref ref) =>
    ref.watch(receivedReportsProvider).value?.unread ?? 0;
