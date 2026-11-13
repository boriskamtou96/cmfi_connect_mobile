import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/payment.dart';

part 'payments_api.g.dart';

/// Payments by mobile money (Wajub, through /v1/payments): the operators,
/// the registration to a paid event, and following a payment while the member
/// confirms it on their phone.
class PaymentsApi {
  const PaymentsApi(this._dio);

  final Dio _dio;

  /// The countries and operators taking [currency], and whether cards are
  /// taken. 503 PAYMENTS_DISABLED.
  Future<PaymentOptions> options({String currency = 'XAF'}) =>
      apiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>(
          '/payments/providers',
          queryParameters: {'currency': currency},
        );
        return PaymentOptions.fromJson(response.content);
      });

  /// The operator of [phoneNumber] (with its country code). 400 INVALID_PHONE.
  Future<OperatorGuess> guessOperator(String phoneNumber) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/payments/predict-provider',
      data: {'phone_number': phoneNumber},
    );
    return OperatorGuess.fromJson(response.content);
  });

  /// Asks the member's phone for the price of their registration, or opens
  /// Wajub's page for a card ([Payment.gatewayUrl]); the registration is made
  /// once paid. 409 EVENT_FULL, REGISTRATION_CLOSED, ALREADY_PAID,
  /// PROVIDER_UNAVAILABLE, AMOUNT_OUT_OF_BOUNDS, CARDS_DISABLED; 400
  /// INVALID_PHONE.
  Future<Payment> payForEvent(
    int eventId, {
    required int people,
    bool needsLodging = false,
    String departureCity = '',
    PaymentMethod method = PaymentMethod.mobileMoney,
    String phoneNumber = '',
    String provider = '',
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/events/$eventId/payments',
      data: {
        'people': people,
        'needs_lodging': needsLodging,
        'departure_city': departureCity,
        'method': method.code,
        if (method == PaymentMethod.mobileMoney) ...{
          'phone_number': phoneNumber,
          'provider': provider,
        },
      },
    );
    return Payment.fromJson(response.content);
  });

  /// « Faire un don »: [amount] of [currency]'s whole units, asked of the
  /// member's phone or paid on Wajub's page for a card. Nothing is given in
  /// return. 409 AMOUNT_OUT_OF_BOUNDS, PROVIDER_UNAVAILABLE, CARDS_DISABLED;
  /// 400 INVALID_PHONE; 503 PAYMENTS_DISABLED.
  Future<Payment> donate(
    int amount, {
    PaymentMethod method = PaymentMethod.mobileMoney,
    String phoneNumber = '',
    String provider = '',
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/donations',
      data: {
        'amount': amount,
        'method': method.code,
        if (method == PaymentMethod.mobileMoney) ...{
          'phone_number': phoneNumber,
          'provider': provider,
        },
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

/// The operators taking [currency], and cards, asked once per sheet.
@riverpod
Future<PaymentOptions> paymentOptions(Ref ref, String currency) =>
    ref.watch(paymentsApiProvider).options(currency: currency);
