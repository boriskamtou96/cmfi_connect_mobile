import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/disciple.dart';

part 'disciples_api.g.dart';

class DisciplesApi {
  const DisciplesApi(this._dio);

  final Dio _dio;

  /// A page of the user's disciples (those who chose them as disciple maker
  /// first, then by name), and how many there are: [search] keeps the ones
  /// whose name or pseudo contains it (case and accents left aside).
  /// [today] is the phone's date: the streak and the last 30 days count from
  /// it.
  Future<DisciplesPage> list({
    required DateTime today,
    String search = '',
    int page = 1,
    int size = disciplesPageSize,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/disciples',
      queryParameters: {
        'today': today.toApiDate(),
        if (search.trim().isNotEmpty) 'search': search.trim(),
        'page': page,
        'size': size,
      },
    );
    final meta = response.data!['meta'] as Map<String, dynamic>?;
    final items = [
      for (final item in response.contentList)
        Disciple.fromJson(item as Map<String, dynamic>),
    ];
    return (
      items: items,
      total: (meta?['total'] as num?)?.toInt() ?? items.length,
    );
  });

  /// The reports [authorityId] (an item of [list]) sent between [from] and
  /// [to] (92 days at most), newest first. 403 REPORTS_NOT_SHARED when they
  /// stopped sharing them.
  Future<DiscipleReports> reports(
    int authorityId, {
    required DateTime from,
    required DateTime to,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/disciples/$authorityId/reports',
      queryParameters: {'from': from.toApiDate(), 'to': to.toApiDate()},
    );
    return DiscipleReports.fromJson(response.content);
  });
}

@riverpod
DisciplesApi disciplesApi(Ref ref) => DisciplesApi(ref.watch(dioProvider));
