import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/in_app_sending.dart';

part 'report_sendings_api.g.dart';

/// The report sent in the app to the authorities who are members
/// (/v1/report-sendings): they get a push and answer with a word.
class ReportSendingsApi {
  const ReportSendingsApi(this._dio);

  final Dio _dio;

  /// Sends [from]–[to] to [authorityIds] among the authorities who can
  /// receive it (members, accepted, shared): what was sent (none when none
  /// of them can).
  Future<List<InAppSending>> send({
    required DateTime from,
    required DateTime to,
    List<int> authorityIds = const [],
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/report-sendings',
      data: {
        'from': from.toApiDate(),
        'to': to.toApiDate(),
        if (authorityIds.isNotEmpty) 'authority_ids': authorityIds,
      },
    );
    return [
      for (final json in response.contentList)
        InAppSending.fromJson(json as Map<String, dynamic>),
    ];
  });

  /// The last ones sent, with the answers.
  Future<List<InAppSending>> sent({int size = 30}) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/report-sendings/sent',
      queryParameters: {'size': size},
    );
    return [
      for (final json in response.contentList)
        InAppSending.fromJson(json as Map<String, dynamic>),
    ];
  });
}

@Riverpod(keepAlive: true)
ReportSendingsApi reportSendingsApi(Ref ref) =>
    ReportSendingsApi(ref.watch(dioProvider));
