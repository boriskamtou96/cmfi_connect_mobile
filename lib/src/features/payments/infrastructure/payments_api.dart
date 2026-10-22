import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/payment.dart';

part 'payments_api.g.dart';

/// Payments by mobile money (pawaPay, through /v1/payments): the operators,
/// the registration to a paid event, and following a payment while the member
/// confirms it on their phone.
class PaymentsApi {
  const PaymentsApi(this._dio);

  final Dio _dio;

  /// The countries and operators taking [currency]. 503 PAYMENTS_DISABLED.
  Future<List<MobileMoneyCountry>> operators({String currency = 'XAF'}) =>
      apiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>(
          '/payments/providers',
          queryParameters: {'currency': currency},
        );
        final content = response.content;
        return [
          for (final json in content['countries'] as List<dynamic>? ?? [])
            MobileMoneyCountry.fromJson(json as Map<String, dynamic>),
        ];
      });

  /// The operator of [phoneNumber] (with its country code). 400 INVALID_PHONE.
  Future<OperatorGuess> guessOperator(String phoneNumber) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/payments/predict-provider',
      data: {'phone_number': phoneNumber},
    );
    return OperatorGuess.fromJson(response.content);
  });

  /// Asks the member's phone for the price of their registration; the
  /// registration is made once paid. 409 EVENT_FULL, REGISTRATION_CLOSED,
  /// ALREADY_PAID, PROVIDER_UNAVAILABLE, AMOUNT_OUT_OF_BOUNDS; 400
  /// INVALID_PHONE.
  Future<Payment> payForEvent(
    int eventId, {
    required int people,
    bool needsLodging = false,
    String departureCity = '',
    required String phoneNumber,
    String provider = '',
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/events/$eventId/payments',
      data: {
        'people': people,
        'needs_lodging': needsLodging,
        'departure_city': departureCity,
        'phone_number': phoneNumber,
        'provider': provider,
      },
    );
    return Payment.fromJson(response.content);
  });

  Future<Payment> get(String id) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/payments/$id');
    return Payment.fromJson(response.content);
  });
}

@riverpod
PaymentsApi paymentsApi(Ref ref) => PaymentsApi(ref.watch(dioProvider));

/// The operators taking [currency], asked once per sheet.
@riverpod
Future<List<MobileMoneyCountry>> mobileMoneyOperators(
  Ref ref,
  String currency,
) => ref.watch(paymentsApiProvider).operators(currency: currency);
