import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/network/fetch_policy.dart';
import '../domain/teaching.dart';
import '../infrastructure/teachings_api.dart';
import '../infrastructure/teachings_local_store.dart';

part 'teachings.freezed.dart';
part 'teachings.g.dart';

@freezed
abstract class TeachingsState with _$TeachingsState {
  const factory TeachingsState({
    required List<Teaching> items,
    required int total,
    @Default(1) int page,
    @Default(false) bool loadingMore,
  }) = _TeachingsState;

  const TeachingsState._();

  bool get hasMore => items.length < total;
}

/// The teachings that answer [search] in [category] ('' for all), a page at
/// a time: the first one at once, the next ones at the end of the list.
/// Without a search, the first page kept on the phone shows at once
/// ([FetchPolicy.cacheAndNetwork]); a search asks the server. Without
/// network the copy gives way to the error: the screen then lists the
/// messages downloaded, the only ones that play offline.
@riverpod
class Teachings extends _$Teachings {
  static const pageSize = 20;

  @override
  Future<TeachingsState> build(String search, String category) => _firstPage(
    search.isEmpty ? FetchPolicy.cacheAndNetwork : FetchPolicy.networkOnly,
    onFresh: (fresh) {
      if (ref.mounted) {
        state = AsyncData(fresh);
      }
    },
    onFailed: (error, stack) {
      if (ref.mounted && error is NetworkException) {
        state = AsyncError(error, stack);
      }
    },
  );

  Future<TeachingsState> _firstPage(
    FetchPolicy policy, {
    void Function(TeachingsState fresh)? onFresh,
    void Function(Object error, StackTrace stack)? onFailed,
  }) async {
    TeachingsState of(TeachingsPage page) =>
        TeachingsState(items: page.items, total: page.total);
    final store = ref.read(teachingsLocalStoreProvider);
    final page = await fetchWithPolicy<TeachingsPage>(
      policy: policy,
      cached: () => store.read(category),
      network: () => ref
          .read(teachingsApiProvider)
          .list(search: search, category: category, size: pageSize),
      // a search is not kept
      save: (page) async {
        if (search.isEmpty) {
          await store.save(category, page);
        }
      },
      onFresh: onFresh == null ? null : (fresh) => onFresh(of(fresh)),
      onFailed: onFailed,
    );
    return of(page);
  }

  /// Pulled down: the first page again (the list stays without network).
  Future<void> refresh() async {
    final result = await AsyncValue.guard(
      () => _firstPage(FetchPolicy.networkOnly),
    );
    if (ref.mounted && (result.hasValue || !state.hasValue)) {
      state = result;
    }
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) {
      return;
    }
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final next = await ref
          .read(teachingsApiProvider)
          .list(
            search: search,
            category: category,
            page: current.page + 1,
            size: pageSize,
          );
      if (ref.mounted) {
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
      }
    } on Object {
      if (ref.mounted) {
        state = AsyncData(current.copyWith(loadingMore: false));
      }
    }
  }
}

/// The categories of the published teachings: the chips above the list;
/// none without network (the list says why).
@riverpod
Future<List<TeachingCategory>> teachingCategories(Ref ref) async {
  try {
    return await ref.watch(teachingsApiProvider).categories();
  } on Object {
    return const [];
  }
}

/// The latest teachings, for « À écouter » on the home screen (its own
/// list: the Enseignements page keeps loading its own); none without
/// network.
@riverpod
Future<List<Teaching>> latestTeachings(Ref ref) async {
  try {
    final page = await ref.watch(teachingsApiProvider).list(size: 8);
    return page.items;
  } on Object {
    return const [];
  }
}
