import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/activity_type.dart';
import '../domain/report_goal.dart';

part 'activities_api.g.dart';

/// The report items (/v1/activities): standard ones + the user's own.
class ActivitiesApi {
  const ActivitiesApi(this._dio);

  final Dio _dio;

  /// Active items, in display order.
  Future<List<ActivityType>> list() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/activities/');
    return [
      for (final json in response.contentList)
        ActivityType.fromJson(json as Map<String, dynamic>),
    ];
  });

  /// Creates a personal item. A code already used (by a standard item, or one of
  /// the user's items, even archived) answers 409 CONFLICT.
  Future<ActivityType> create({
    required String code,
    required String label,
    required bool tracksQuantity,
    String? quantityUnit,
    required bool tracksDuration,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/activities/',
      data: {
        'code': code,
        'label': label,
        'tracks_quantity': tracksQuantity,
        'quantity_unit': tracksQuantity ? (quantityUnit ?? '') : '',
        'tracks_duration': tracksDuration,
      },
    );
    return ActivityType.fromJson(response.content);
  });

  /// Keeps the daily goal of an item on the account; null or empty removes
  /// it. An archived or unknown item answers 404.
  Future<void> setGoal(int id, ReportGoal? goal) => apiCall(() async {
    await _dio.put<void>(
      '/activities/$id/goal',
      data: {'quantity': goal?.quantity, 'minutes': goal?.minutes},
    );
  });

  /// Archives a personal item (204). Its past values stay in the history.
  Future<void> archive(int id) => apiCall(() async {
    await _dio.delete<void>('/activities/$id');
  });
}

// kept: the goals (a kept provider) send through it
@Riverpod(keepAlive: true)
ActivitiesApi activitiesApi(Ref ref) => ActivitiesApi(ref.watch(dioProvider));
