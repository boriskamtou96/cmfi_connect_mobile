import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/daily_report.dart';
import '../domain/report_summary.dart';

part 'reports_api.g.dart';

/// The daily reports (/v1/reports).
class ReportsApi {
  const ReportsApi(this._dio);

  final Dio _dio;

  /// Every active item of [date], filled in or not. Works for a day never saved.
  Future<DailyReport> getDay(DateTime date) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/reports/${date.toApiDate()}',
    );
    return DailyReport.fromJson(response.content);
  });

  /// Replaces the whole day: items left out are removed from it, an empty note erases it.
  /// Answers the saved day, like [getDay]. A future date answers 400.
  /// [goalPercent]: how far the day's goals are reached (0 to 100), null
  /// without goals; the disciple maker sees its mean, never the items.
  Future<DailyReport> saveDay(
    DateTime date, {
    required String note,
    required List<ReportEntry> entries,
    int? goalPercent,
  }) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/reports/${date.toApiDate()}',
      data: {
        'note': note.trim(),
        'goal_percent': goalPercent,
        'entries': [
          for (final entry in entries.where((entry) => entry.isFilled))
            {
              'activity_type_id': entry.activityTypeId,
              if (entry.quantity != null) 'quantity': entry.quantity,
              if (entry.durationMinutes != null)
                'duration_minutes': entry.durationMinutes,
            },
        ],
      },
    );
    return DailyReport.fromJson(response.content);
  });

  /// Days that have a report between [from] and [to] (included), newest first.
  Future<List<DailyReport>> history({
    required DateTime from,
    required DateTime to,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/reports/',
      queryParameters: {'from': from.toApiDate(), 'to': to.toApiDate()},
    );
    return [
      for (final json in response.contentList)
        DailyReport.fromJson(json as Map<String, dynamic>),
    ];
  });

  /// Totals per item between [from] and [to] (included, 366 days at most).
  Future<ReportSummary> summary({
    required DateTime from,
    required DateTime to,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/reports/summary',
      queryParameters: {'from': from.toApiDate(), 'to': to.toApiDate()},
    );
    return ReportSummary.fromJson(response.content);
  });
}

// kept alive: the offline queue and the reminder use it in the background
@Riverpod(keepAlive: true)
ReportsApi reportsApi(Ref ref) => ReportsApi(ref.watch(dioProvider));
