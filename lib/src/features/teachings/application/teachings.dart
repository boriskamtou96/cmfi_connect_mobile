import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/teaching.dart';
import '../infrastructure/teachings_api.dart';

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
@riverpod
class Teachings extends _$Teachings {
  static const pageSize = 20;

  @override
  Future<TeachingsState> build(String search, String category) async {
    final page = await ref
        .watch(teachingsApiProvider)
        .list(search: search, category: category, size: pageSize);
    return TeachingsState(items: page.items, total: page.total);
  }

  /// Pulled down: the first page again (the list stays without network).
  Future<void> refresh() async {
    final result = await AsyncValue.guard(() => build(search, category));
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
