import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

/// pending: the member confirms on their phone (PIN), or the server finishes
/// it; completed: paid and done (the registration is made); failed;
/// refunding, refunded: the money goes back.
enum PaymentStatus { pending, completed, failed, refunding, refunded }

/// A payment by mobile money (pawaPay, through the server).
@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    required String id,
    @Default('event') String purpose,
    @JsonKey(unknownEnumValue: PaymentStatus.pending)
    @Default(PaymentStatus.pending)
    PaymentStatus status,

    /// Why it failed (INSUFFICIENT_BALANCE…), or ''.
    @Default('') String failureCode,
    required int amount,
    @Default('XAF') String currency,

    /// MTN_MOMO_CMR, ORANGE_CMR…
    @Default('') String provider,
    int? eventId,
    @Default(1) int people,
    DateTime? createdAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}

/// A mobile money operator that takes payments in a currency.
@freezed
abstract class MobileMoneyOperator with _$MobileMoneyOperator {
  const factory MobileMoneyOperator({
    required String provider,

    /// MTN, Orange…
    required String name,
    @Default('') String logo,
    @Default('') String minAmount,
    @Default('') String maxAmount,

    /// OPERATIONAL, DELAYED or CLOSED
    @Default('OPERATIONAL') String status,
  }) = _MobileMoneyOperator;

  const MobileMoneyOperator._();

  factory MobileMoneyOperator.fromJson(Map<String, dynamic> json) =>
      _$MobileMoneyOperatorFromJson(json);

  bool get isOpen => status != 'CLOSED';
}

/// A country and its operators.
@freezed
abstract class MobileMoneyCountry with _$MobileMoneyCountry {
  const factory MobileMoneyCountry({
    /// CMR
    required String country,
    @Default(<String, String>{}) Map<String, String> names,

    /// 237
    @Default('') String prefix,
    @JsonKey(name: 'providers')
    @Default(<MobileMoneyOperator>[])
    List<MobileMoneyOperator> operators,
  }) = _MobileMoneyCountry;

  const MobileMoneyCountry._();

  factory MobileMoneyCountry.fromJson(Map<String, dynamic> json) =>
      _$MobileMoneyCountryFromJson(json);

  /// In [language], else in French or English, else the code.
  String nameIn(String language) =>
      names[language] ?? names['fr'] ?? names['en'] ?? country;
}

/// The operator of a number, and the number as the operator writes it.
@freezed
abstract class OperatorGuess with _$OperatorGuess {
  const factory OperatorGuess({
    required String country,
    required String provider,
    required String phoneNumber,
  }) = _OperatorGuess;

  factory OperatorGuess.fromJson(Map<String, dynamic> json) =>
      _$OperatorGuessFromJson(json);
}

/// "10 000 FCFA", "2 500 GHS": whole units, grouped the way of [locale].
String formatMoney(int amount, String currency, String locale) {
  final number = NumberFormat.decimalPattern(locale).format(amount);
  final unit = switch (currency) {
    'XAF' || 'XOF' => 'FCFA',
    _ => currency,
  };
  return '$number $unit';
}
