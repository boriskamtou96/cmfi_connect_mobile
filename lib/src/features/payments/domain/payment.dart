import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

/// pending: the member confirms on their phone (PIN), or the server finishes
/// it; completed: paid and done (the registration is made); failed;
/// refunding, refunded: the money goes back.
enum PaymentStatus { pending, completed, failed, refunding, refunded }

/// A payment by mobile money (KPAY-NOW or Wajub, chosen by the server).
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

    /// A card: the provider's secure page to open, given when the payment starts.
    @Default('') String gatewayUrl,
  }) = _Payment;

  const Payment._();

  /// Paid by card on the provider's secure page (not a phone).
  bool get byCard => provider == cardProvider;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}

/// The provider written on a payment by card.
const cardProvider = 'CARD';

/// How one pays: mobile money (a number and a PIN) or a card (the provider's secure page).
enum PaymentMethod {
  mobileMoney('mobile_money'),
  card('card');

  const PaymentMethod(this.code);

  /// As the API writes it.
  final String code;
}

/// What the server offers: the mobile money operators by country, and cards.
/// Since 18/11/2026, for the member's country (the code of their number):
/// the currency of their card ([cardCurrency]: XAF, XOF or USD), the way
/// shown first ([preferred]), and the donations in each currency they can
/// give in (none from a server before that: XAF, as before).
@freezed
abstract class PaymentOptions with _$PaymentOptions {
  const factory PaymentOptions({
    @Default(<MobileMoneyCountry>[]) List<MobileMoneyCountry> countries,
    @Default(false) bool cards,
    @Default('XAF') String cardCurrency,

    /// mobile_money or card
    @Default('mobile_money') String preferred,
    @Default(<DonationRule>[]) List<DonationRule> donations,
  }) = _PaymentOptions;

  const PaymentOptions._();

  factory PaymentOptions.fromJson(Map<String, dynamic> json) =>
      _$PaymentOptionsFromJson(json);

  /// The amounts and bounds of a donation in [currency].
  DonationRule ruleFor(String currency) =>
      donations.where((rule) => rule.currency == currency).firstOrNull ??
      DonationRule.fallback;
}

/// A donation in a currency: the amounts offered at a touch, and the bounds
/// of the server ([cardMin]: KPAY takes no card under 1 USD).
@freezed
abstract class DonationRule with _$DonationRule {
  const factory DonationRule({
    required String currency,
    required List<int> amounts,
    required int min,
    required int cardMin,
    required int max,
  }) = _DonationRule;

  factory DonationRule.fromJson(Map<String, dynamic> json) =>
      _$DonationRuleFromJson(json);

  /// A server before 18/11/2026: XAF, the card as low as mobile money.
  static const fallback = DonationRule(
    currency: 'XAF',
    amounts: [1000, 2000, 5000, 10000],
    min: 100,
    cardMin: 100,
    max: 500000,
  );
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
    'USD' => r'$',
    _ => currency,
  };
  return '$number $unit';
}

/// The logo of an operator (assets/payments), null when there is none.
String? operatorLogo(String provider) {
  if (provider.startsWith('MTN_')) {
    return 'assets/payments/mtn.png';
  }
  if (provider.startsWith('ORANGE_')) {
    return 'assets/payments/orange.png';
  }
  return null;
}
