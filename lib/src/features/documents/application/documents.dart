import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/documents_query.dart';
import '../domain/library_document.dart';
import '../infrastructure/documents_api.dart';

part 'documents.freezed.dart';
part 'documents.g.dart';

@freezed
abstract class DocumentsState with _$DocumentsState {
  const factory DocumentsState({
    required List<LibraryDocument> items,
    required int total,
    @Default(1) int page,
    @Default(false) bool loadingMore,
  }) = _DocumentsState;

  const DocumentsState._();

  bool get hasMore => items.length < total;
}

/// The documents that answer [query], a page at a time: the first one at
/// once, the next ones at the end of the list.
@riverpod
class Documents extends _$Documents {
  static const pageSize = 20;

  @override
  Future<DocumentsState> build(DocumentsQuery query) async {
    final page = await ref
        .watch(documentsApiProvider)
        .list(query: query, size: pageSize);
    return DocumentsState(items: page.items, total: page.total);
  }

  /// Pulled down: the first page again (the list stays without network).
  Future<void> refresh() async {
    final result = await AsyncValue.guard(() => build(query));
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
          .read(documentsApiProvider)
          .list(
            query: query,
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

/// The categories of the published documents: the chips above the list;
/// none without network (the list says why).
@riverpod
Future<List<DocumentCategory>> documentCategories(Ref ref) async {
  try {
    return await ref.watch(documentsApiProvider).categories();
  } on Object {
    return const [];
  }
}
