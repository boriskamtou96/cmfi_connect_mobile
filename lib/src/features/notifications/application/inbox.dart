import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/fetch_policy.dart';
import '../domain/announcement.dart';
import '../infrastructure/inbox_local_store.dart';
import '../infrastructure/notifications_api.dart';

part 'inbox.freezed.dart';
part 'inbox.g.dart';

@freezed
abstract class InboxState with _$InboxState {
  const factory InboxState({
    required List<Announcement> items,
    required int unread,
    required int total,
    @Default(1) int page,
    @Default(false) bool loadingMore,
  }) = _InboxState;

  const InboxState._();

  bool get hasMore => items.length < total;
}

/// The member's notifications, the latest first, and how many are not read
/// (the badge of the bell). Kept alive: the home screen and Plus show the
/// badge; refreshed when a push arrives. The first page kept on the phone
/// shows at once ([FetchPolicy.cacheAndNetwork]), then the server's.
@Riverpod(keepAlive: true)
class Inbox extends _$Inbox {
  static const pageSize = 20;

  @override
  Future<InboxState> build() => _firstPage(
    FetchPolicy.cacheAndNetwork,
    onFresh: (fresh) {
      if (ref.mounted) {
        state = AsyncData(fresh);
      }
    },
  );

  Future<InboxState> _firstPage(
    FetchPolicy policy, {
    void Function(InboxState fresh)? onFresh,
  }) async {
    InboxState of(AnnouncementPage page) =>
        InboxState(items: page.items, unread: page.unread, total: page.total);
    final store = ref.read(inboxLocalStoreProvider);
    final page = await fetchWithPolicy<AnnouncementPage>(
      policy: policy,
      cached: store.read,
      network: () => ref.read(notificationsApiProvider).list(size: pageSize),
      save: store.save,
      onFresh: onFresh == null ? null : (fresh) => onFresh(of(fresh)),
    );
    return of(page);
  }

  /// The server's first page (the one shown stays without network).
  Future<void> refresh() async {
    final result = await AsyncValue.guard(
      () => _firstPage(FetchPolicy.networkOnly),
    );
    if (ref.mounted && (result.hasValue || !state.hasValue)) {
      state = result;
    }
  }

  /// The next page, at the end of the list.
  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) {
      return;
    }
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final next = await ref
          .read(notificationsApiProvider)
          .list(page: current.page + 1, size: pageSize);
      if (ref.mounted) {
        state = AsyncData(
          current.copyWith(
            items: [
              ...current.items,
              ...next.items.where(
                (item) => current.items.every((known) => known.id != item.id),
              ),
            ],
            unread: next.unread,
            total: next.total,
            page: current.page + 1,
          ),
        );
      }
    } on Object {
      if (ref.mounted) {
        state = AsyncData(current);
      }
    }
  }

  /// Opened: read on the server, and one less on the badge. Without network
  /// it stays unread, to be marked the next time.
  Future<void> markRead(int id) async {
    final known = state.value?.items.where((item) => item.id == id).firstOrNull;
    if (known?.isRead ?? false) {
      return;
    }
    try {
      final read = await ref.read(notificationsApiProvider).markRead(id);
      final current = state.value;
      if (!ref.mounted || current == null) {
        return;
      }
      state = AsyncData(
        current.copyWith(
          items: [
            for (final item in current.items) item.id == id ? read : item,
          ],
          unread: known == null ? current.unread : current.unread - 1,
        ),
      );
    } on Object {
      // the next refresh tells the truth
    }
  }
}

/// One notification: from the list when it is there, else from the server
/// (opened from a push).
@riverpod
Future<Announcement> announcement(Ref ref, int id) async {
  final inbox = await ref.watch(inboxProvider.future);
  return inbox.items.where((item) => item.id == id).firstOrNull ??
      await ref.read(notificationsApiProvider).get(id);
}
