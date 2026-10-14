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

  /// The disciples of the user, by name. [today] is the phone's date: the
  /// streak and the last 30 days count from it.
  Future<List<Disciple>> list({required DateTime today}) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/disciples',
      queryParameters: {'today': today.toApiDate()},
    );
    return [
      for (final item in response.contentList)
        Disciple.fromJson(item as Map<String, dynamic>),
    ];
  });
}

@riverpod
DisciplesApi disciplesApi(Ref ref) => DisciplesApi(ref.watch(dioProvider));
