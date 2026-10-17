import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/teaching.dart';

part 'teachings_api.g.dart';

/// A page of teachings, and how many answer the search in all.
typedef TeachingsPage = ({List<Teaching> items, int total});

/// Enseignements (/v1/teachings): the published ones, the newest message
/// first.
class TeachingsApi {
  const TeachingsApi(this._dio);

  final Dio _dio;

  /// [search]: words of the title, the speaker, the description or the
  /// category (case and accents left aside); [category]: one of
  /// [categories], '' for all.
  Future<TeachingsPage> list({
    String search = '',
    String category = '',
    int page = 1,
    int size = 20,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/teachings',
      queryParameters: {
        if (search.trim().isNotEmpty) 'search': search.trim(),
        if (category.isNotEmpty) 'category': category,
        'page': page,
        'size': size,
      },
    );
    final meta = response.data!['meta'] as Map<String, dynamic>?;
    return (
      items: [
        for (final json in response.contentList)
          Teaching.fromJson(json as Map<String, dynamic>),
      ],
      total: meta?['total'] as int? ?? 0,
    );
  });

  Future<List<TeachingCategory>> categories() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/teachings/categories',
    );
    return [
      for (final json in response.contentList)
        TeachingCategory.fromJson(json as Map<String, dynamic>),
    ];
  });
}

@Riverpod(keepAlive: true)
TeachingsApi teachingsApi(Ref ref) => TeachingsApi(ref.watch(dioProvider));
