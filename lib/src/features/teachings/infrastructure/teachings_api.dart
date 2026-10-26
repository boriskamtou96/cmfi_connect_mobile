import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/teaching.dart';
import '../domain/teaching_query.dart';

part 'teachings_api.g.dart';

/// A page of teachings, and how many answer the search in all.
typedef TeachingsPage = ({List<Teaching> items, int total});

/// Enseignements (/v1/teachings): the published ones, the newest message
/// first.
class TeachingsApi {
  const TeachingsApi(this._dio);

  final Dio _dio;

  /// [query]: the words, the category, the speaker, the year, the edition
  /// and the day (case and accents left aside on the server).
  Future<TeachingsPage> list({
    TeachingQuery query = const TeachingQuery(),
    int page = 1,
    int size = 20,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/teachings',
      queryParameters: {
        if (query.search.trim().isNotEmpty) 'search': query.search.trim(),
        if (query.category.isNotEmpty) 'category': query.category,
        if (query.speaker.isNotEmpty) 'speaker': query.speaker,
        if (query.year != null) 'year': query.year,
        if (query.edition != null) 'edition_id': query.edition,
        if (query.day != null) 'day': query.day,
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

  /// The speakers, the years, the editions, and the days of [editionId] when
  /// one is chosen: what the filters offer.
  Future<TeachingFacets> facets({int? editionId}) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/teachings/facets',
      queryParameters: {'edition_id': ?editionId},
    );
    return TeachingFacets.fromJson(response.content);
  });
}

@Riverpod(keepAlive: true)
TeachingsApi teachingsApi(Ref ref) => TeachingsApi(ref.watch(dioProvider));
