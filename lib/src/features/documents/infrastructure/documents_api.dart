import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/documents_query.dart';
import '../domain/library_document.dart';

part 'documents_api.g.dart';

/// A page of documents, and how many answer the search in all.
typedef DocumentsPage = ({List<LibraryDocument> items, int total});

/// Nos documents (/v1/documents): the published ones, the newest first.
class DocumentsApi {
  const DocumentsApi(this._dio);

  final Dio _dio;

  /// [query]: the words of the title, the description, the category or the
  /// file's name (case and accents left aside), and a category's slug.
  Future<DocumentsPage> list({
    DocumentsQuery query = const DocumentsQuery(),
    int page = 1,
    int size = 20,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/documents',
      queryParameters: {
        if (query.search.trim().isNotEmpty) 'search': query.search.trim(),
        if (query.category.isNotEmpty) 'category': query.category,
        'page': page,
        'size': size,
      },
    );
    final meta = response.data!['meta'] as Map<String, dynamic>?;
    return (
      items: [
        for (final json in response.contentList)
          LibraryDocument.fromJson(json as Map<String, dynamic>),
      ],
      total: meta?['total'] as int? ?? 0,
    );
  });

  Future<List<DocumentCategory>> categories() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/documents/categories',
    );
    return [
      for (final json in response.contentList)
        DocumentCategory.fromJson(json as Map<String, dynamic>),
    ];
  });

  /// The file itself, to keep it on the phone (Enregistrer dans Fichiers).
  Future<Uint8List> file(String url) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data!);
  });
}

@Riverpod(keepAlive: true)
DocumentsApi documentsApi(Ref ref) => DocumentsApi(ref.watch(dioProvider));
