// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Payment {

 String get id; String get purpose;@JsonKey(unknownEnumValue: PaymentStatus.pending) PaymentStatus get status;/// Why it failed (INSUFFICIENT_BALANCE…), or ''.
 String get failureCode; int get amount; String get currency;/// MTN_MOMO_CMR, ORANGE_CMR…
 String get provider; int? get eventId; int get people; DateTime? get createdAt;/// A card: the provider's secure page to open, given when the payment starts.
 String get gatewayUrl;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureCode, failureCode) || other.failureCode == failureCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.people, people) || other.people == people)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.gatewayUrl, gatewayUrl) || other.gatewayUrl == gatewayUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,purpose,status,failureCode,amount,currency,provider,eventId,people,createdAt,gatewayUrl);

@override
String toString() {
  return 'Payment(id: $id, purpose: $purpose, status: $status, failureCode: $failureCode, amount: $amount, currency: $currency, provider: $provider, eventId: $eventId, people: $people, createdAt: $createdAt, gatewayUrl: $gatewayUrl)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String id, String purpose,@JsonKey(unknownEnumValue: PaymentStatus.pending) PaymentStatus status, String failureCode, int amount, String currency, String provider, int? eventId, int people, DateTime? createdAt, String gatewayUrl
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? purpose = null,Object? status = null,Object? failureCode = null,Object? amount = null,Object? currency = null,Object? provider = null,Object? eventId = freezed,Object? people = null,Object? createdAt = freezed,Object? gatewayUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,failureCode: null == failureCode ? _self.failureCode : failureCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,gatewayUrl: null == gatewayUrl ? _self.gatewayUrl : gatewayUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String purpose, @JsonKey(unknownEnumValue: PaymentStatus.pending)  PaymentStatus status,  String failureCode,  int amount,  String currency,  String provider,  int? eventId,  int people,  DateTime? createdAt,  String gatewayUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.purpose,_that.status,_that.failureCode,_that.amount,_that.currency,_that.provider,_that.eventId,_that.people,_that.createdAt,_that.gatewayUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String purpose, @JsonKey(unknownEnumValue: PaymentStatus.pending)  PaymentStatus status,  String failureCode,  int amount,  String currency,  String provider,  int? eventId,  int people,  DateTime? createdAt,  String gatewayUrl)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.purpose,_that.status,_that.failureCode,_that.amount,_that.currency,_that.provider,_that.eventId,_that.people,_that.createdAt,_that.gatewayUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String purpose, @JsonKey(unknownEnumValue: PaymentStatus.pending)  PaymentStatus status,  String failureCode,  int amount,  String currency,  String provider,  int? eventId,  int people,  DateTime? createdAt,  String gatewayUrl)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.purpose,_that.status,_that.failureCode,_that.amount,_that.currency,_that.provider,_that.eventId,_that.people,_that.createdAt,_that.gatewayUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payment extends Payment {
  const _Payment({required this.id, this.purpose = 'event', @JsonKey(unknownEnumValue: PaymentStatus.pending) this.status = PaymentStatus.pending, this.failureCode = '', required this.amount, this.currency = 'XAF', this.provider = '', this.eventId, this.people = 1, this.createdAt, this.gatewayUrl = ''}): super._();
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

@override final  String id;
@override@JsonKey() final  String purpose;
@override@JsonKey(unknownEnumValue: PaymentStatus.pending) final  PaymentStatus status;
/// Why it failed (INSUFFICIENT_BALANCE…), or ''.
@override@JsonKey() final  String failureCode;
@override final  int amount;
@override@JsonKey() final  String currency;
/// MTN_MOMO_CMR, ORANGE_CMR…
@override@JsonKey() final  String provider;
@override final  int? eventId;
@override@JsonKey() final  int people;
@override final  DateTime? createdAt;
/// A card: the provider's secure page to open, given when the payment starts.
@override@JsonKey() final  String gatewayUrl;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureCode, failureCode) || other.failureCode == failureCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.people, people) || other.people == people)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.gatewayUrl, gatewayUrl) || other.gatewayUrl == gatewayUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,purpose,status,failureCode,amount,currency,provider,eventId,people,createdAt,gatewayUrl);

@override
String toString() {
  return 'Payment(id: $id, purpose: $purpose, status: $status, failureCode: $failureCode, amount: $amount, currency: $currency, provider: $provider, eventId: $eventId, people: $people, createdAt: $createdAt, gatewayUrl: $gatewayUrl)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String purpose,@JsonKey(unknownEnumValue: PaymentStatus.pending) PaymentStatus status, String failureCode, int amount, String currency, String provider, int? eventId, int people, DateTime? createdAt, String gatewayUrl
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? purpose = null,Object? status = null,Object? failureCode = null,Object? amount = null,Object? currency = null,Object? provider = null,Object? eventId = freezed,Object? people = null,Object? createdAt = freezed,Object? gatewayUrl = null,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,failureCode: null == failureCode ? _self.failureCode : failureCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,gatewayUrl: null == gatewayUrl ? _self.gatewayUrl : gatewayUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PaymentOptions {

 List<MobileMoneyCountry> get countries; bool get cards; String get cardCurrency;/// The least a card pays, in the currency asked (KPAY takes no card
/// under 1 USD); 0 from a server that doesn't say it.
 int get cardMin;/// mobile_money or card
 String get preferred; List<DonationRule> get donations;
/// Create a copy of PaymentOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentOptionsCopyWith<PaymentOptions> get copyWith => _$PaymentOptionsCopyWithImpl<PaymentOptions>(this as PaymentOptions, _$identity);

  /// Serializes this PaymentOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentOptions&&const DeepCollectionEquality().equals(other.countries, countries)&&(identical(other.cards, cards) || other.cards == cards)&&(identical(other.cardCurrency, cardCurrency) || other.cardCurrency == cardCurrency)&&(identical(other.cardMin, cardMin) || other.cardMin == cardMin)&&(identical(other.preferred, preferred) || other.preferred == preferred)&&const DeepCollectionEquality().equals(other.donations, donations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(countries),cards,cardCurrency,cardMin,preferred,const DeepCollectionEquality().hash(donations));

@override
String toString() {
  return 'PaymentOptions(countries: $countries, cards: $cards, cardCurrency: $cardCurrency, cardMin: $cardMin, preferred: $preferred, donations: $donations)';
}


}

/// @nodoc
abstract mixin class $PaymentOptionsCopyWith<$Res>  {
  factory $PaymentOptionsCopyWith(PaymentOptions value, $Res Function(PaymentOptions) _then) = _$PaymentOptionsCopyWithImpl;
@useResult
$Res call({
 List<MobileMoneyCountry> countries, bool cards, String cardCurrency, int cardMin, String preferred, List<DonationRule> donations
});




}
/// @nodoc
class _$PaymentOptionsCopyWithImpl<$Res>
    implements $PaymentOptionsCopyWith<$Res> {
  _$PaymentOptionsCopyWithImpl(this._self, this._then);

  final PaymentOptions _self;
  final $Res Function(PaymentOptions) _then;

/// Create a copy of PaymentOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? countries = null,Object? cards = null,Object? cardCurrency = null,Object? cardMin = null,Object? preferred = null,Object? donations = null,}) {
  return _then(_self.copyWith(
countries: null == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<MobileMoneyCountry>,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as bool,cardCurrency: null == cardCurrency ? _self.cardCurrency : cardCurrency // ignore: cast_nullable_to_non_nullable
as String,cardMin: null == cardMin ? _self.cardMin : cardMin // ignore: cast_nullable_to_non_nullable
as int,preferred: null == preferred ? _self.preferred : preferred // ignore: cast_nullable_to_non_nullable
as String,donations: null == donations ? _self.donations : donations // ignore: cast_nullable_to_non_nullable
as List<DonationRule>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentOptions].
extension PaymentOptionsPatterns on PaymentOptions {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentOptions() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentOptions value)  $default,){
final _that = this;
switch (_that) {
case _PaymentOptions():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentOptions value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentOptions() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MobileMoneyCountry> countries,  bool cards,  String cardCurrency,  int cardMin,  String preferred,  List<DonationRule> donations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentOptions() when $default != null:
return $default(_that.countries,_that.cards,_that.cardCurrency,_that.cardMin,_that.preferred,_that.donations);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MobileMoneyCountry> countries,  bool cards,  String cardCurrency,  int cardMin,  String preferred,  List<DonationRule> donations)  $default,) {final _that = this;
switch (_that) {
case _PaymentOptions():
return $default(_that.countries,_that.cards,_that.cardCurrency,_that.cardMin,_that.preferred,_that.donations);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MobileMoneyCountry> countries,  bool cards,  String cardCurrency,  int cardMin,  String preferred,  List<DonationRule> donations)?  $default,) {final _that = this;
switch (_that) {
case _PaymentOptions() when $default != null:
return $default(_that.countries,_that.cards,_that.cardCurrency,_that.cardMin,_that.preferred,_that.donations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentOptions extends PaymentOptions {
  const _PaymentOptions({final  List<MobileMoneyCountry> countries = const <MobileMoneyCountry>[], this.cards = false, this.cardCurrency = 'XAF', this.cardMin = 0, this.preferred = 'mobile_money', final  List<DonationRule> donations = const <DonationRule>[]}): _countries = countries,_donations = donations,super._();
  factory _PaymentOptions.fromJson(Map<String, dynamic> json) => _$PaymentOptionsFromJson(json);

 final  List<MobileMoneyCountry> _countries;
@override@JsonKey() List<MobileMoneyCountry> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}

@override@JsonKey() final  bool cards;
@override@JsonKey() final  String cardCurrency;
/// The least a card pays, in the currency asked (KPAY takes no card
/// under 1 USD); 0 from a server that doesn't say it.
@override@JsonKey() final  int cardMin;
/// mobile_money or card
@override@JsonKey() final  String preferred;
 final  List<DonationRule> _donations;
@override@JsonKey() List<DonationRule> get donations {
  if (_donations is EqualUnmodifiableListView) return _donations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_donations);
}


/// Create a copy of PaymentOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentOptionsCopyWith<_PaymentOptions> get copyWith => __$PaymentOptionsCopyWithImpl<_PaymentOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentOptions&&const DeepCollectionEquality().equals(other._countries, _countries)&&(identical(other.cards, cards) || other.cards == cards)&&(identical(other.cardCurrency, cardCurrency) || other.cardCurrency == cardCurrency)&&(identical(other.cardMin, cardMin) || other.cardMin == cardMin)&&(identical(other.preferred, preferred) || other.preferred == preferred)&&const DeepCollectionEquality().equals(other._donations, _donations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_countries),cards,cardCurrency,cardMin,preferred,const DeepCollectionEquality().hash(_donations));

@override
String toString() {
  return 'PaymentOptions(countries: $countries, cards: $cards, cardCurrency: $cardCurrency, cardMin: $cardMin, preferred: $preferred, donations: $donations)';
}


}

/// @nodoc
abstract mixin class _$PaymentOptionsCopyWith<$Res> implements $PaymentOptionsCopyWith<$Res> {
  factory _$PaymentOptionsCopyWith(_PaymentOptions value, $Res Function(_PaymentOptions) _then) = __$PaymentOptionsCopyWithImpl;
@override @useResult
$Res call({
 List<MobileMoneyCountry> countries, bool cards, String cardCurrency, int cardMin, String preferred, List<DonationRule> donations
});




}
/// @nodoc
class __$PaymentOptionsCopyWithImpl<$Res>
    implements _$PaymentOptionsCopyWith<$Res> {
  __$PaymentOptionsCopyWithImpl(this._self, this._then);

  final _PaymentOptions _self;
  final $Res Function(_PaymentOptions) _then;

/// Create a copy of PaymentOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? countries = null,Object? cards = null,Object? cardCurrency = null,Object? cardMin = null,Object? preferred = null,Object? donations = null,}) {
  return _then(_PaymentOptions(
countries: null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<MobileMoneyCountry>,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as bool,cardCurrency: null == cardCurrency ? _self.cardCurrency : cardCurrency // ignore: cast_nullable_to_non_nullable
as String,cardMin: null == cardMin ? _self.cardMin : cardMin // ignore: cast_nullable_to_non_nullable
as int,preferred: null == preferred ? _self.preferred : preferred // ignore: cast_nullable_to_non_nullable
as String,donations: null == donations ? _self._donations : donations // ignore: cast_nullable_to_non_nullable
as List<DonationRule>,
  ));
}


}


/// @nodoc
mixin _$DonationRule {

 String get currency; List<int> get amounts; int get min; int get cardMin; int get max;
/// Create a copy of DonationRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationRuleCopyWith<DonationRule> get copyWith => _$DonationRuleCopyWithImpl<DonationRule>(this as DonationRule, _$identity);

  /// Serializes this DonationRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationRule&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.amounts, amounts)&&(identical(other.min, min) || other.min == min)&&(identical(other.cardMin, cardMin) || other.cardMin == cardMin)&&(identical(other.max, max) || other.max == max));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,const DeepCollectionEquality().hash(amounts),min,cardMin,max);

@override
String toString() {
  return 'DonationRule(currency: $currency, amounts: $amounts, min: $min, cardMin: $cardMin, max: $max)';
}


}

/// @nodoc
abstract mixin class $DonationRuleCopyWith<$Res>  {
  factory $DonationRuleCopyWith(DonationRule value, $Res Function(DonationRule) _then) = _$DonationRuleCopyWithImpl;
@useResult
$Res call({
 String currency, List<int> amounts, int min, int cardMin, int max
});




}
/// @nodoc
class _$DonationRuleCopyWithImpl<$Res>
    implements $DonationRuleCopyWith<$Res> {
  _$DonationRuleCopyWithImpl(this._self, this._then);

  final DonationRule _self;
  final $Res Function(DonationRule) _then;

/// Create a copy of DonationRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = null,Object? amounts = null,Object? min = null,Object? cardMin = null,Object? max = null,}) {
  return _then(_self.copyWith(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,amounts: null == amounts ? _self.amounts : amounts // ignore: cast_nullable_to_non_nullable
as List<int>,min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as int,cardMin: null == cardMin ? _self.cardMin : cardMin // ignore: cast_nullable_to_non_nullable
as int,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DonationRule].
extension DonationRulePatterns on DonationRule {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DonationRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DonationRule() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DonationRule value)  $default,){
final _that = this;
switch (_that) {
case _DonationRule():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DonationRule value)?  $default,){
final _that = this;
switch (_that) {
case _DonationRule() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currency,  List<int> amounts,  int min,  int cardMin,  int max)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DonationRule() when $default != null:
return $default(_that.currency,_that.amounts,_that.min,_that.cardMin,_that.max);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currency,  List<int> amounts,  int min,  int cardMin,  int max)  $default,) {final _that = this;
switch (_that) {
case _DonationRule():
return $default(_that.currency,_that.amounts,_that.min,_that.cardMin,_that.max);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currency,  List<int> amounts,  int min,  int cardMin,  int max)?  $default,) {final _that = this;
switch (_that) {
case _DonationRule() when $default != null:
return $default(_that.currency,_that.amounts,_that.min,_that.cardMin,_that.max);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DonationRule implements DonationRule {
  const _DonationRule({required this.currency, required final  List<int> amounts, required this.min, required this.cardMin, required this.max}): _amounts = amounts;
  factory _DonationRule.fromJson(Map<String, dynamic> json) => _$DonationRuleFromJson(json);

@override final  String currency;
 final  List<int> _amounts;
@override List<int> get amounts {
  if (_amounts is EqualUnmodifiableListView) return _amounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amounts);
}

@override final  int min;
@override final  int cardMin;
@override final  int max;

/// Create a copy of DonationRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DonationRuleCopyWith<_DonationRule> get copyWith => __$DonationRuleCopyWithImpl<_DonationRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DonationRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DonationRule&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._amounts, _amounts)&&(identical(other.min, min) || other.min == min)&&(identical(other.cardMin, cardMin) || other.cardMin == cardMin)&&(identical(other.max, max) || other.max == max));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,const DeepCollectionEquality().hash(_amounts),min,cardMin,max);

@override
String toString() {
  return 'DonationRule(currency: $currency, amounts: $amounts, min: $min, cardMin: $cardMin, max: $max)';
}


}

/// @nodoc
abstract mixin class _$DonationRuleCopyWith<$Res> implements $DonationRuleCopyWith<$Res> {
  factory _$DonationRuleCopyWith(_DonationRule value, $Res Function(_DonationRule) _then) = __$DonationRuleCopyWithImpl;
@override @useResult
$Res call({
 String currency, List<int> amounts, int min, int cardMin, int max
});




}
/// @nodoc
class __$DonationRuleCopyWithImpl<$Res>
    implements _$DonationRuleCopyWith<$Res> {
  __$DonationRuleCopyWithImpl(this._self, this._then);

  final _DonationRule _self;
  final $Res Function(_DonationRule) _then;

/// Create a copy of DonationRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = null,Object? amounts = null,Object? min = null,Object? cardMin = null,Object? max = null,}) {
  return _then(_DonationRule(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,amounts: null == amounts ? _self._amounts : amounts // ignore: cast_nullable_to_non_nullable
as List<int>,min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as int,cardMin: null == cardMin ? _self.cardMin : cardMin // ignore: cast_nullable_to_non_nullable
as int,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MobileMoneyOperator {

 String get provider;/// MTN, Orange…
 String get name; String get logo; String get minAmount; String get maxAmount;/// OPERATIONAL, DELAYED or CLOSED
 String get status;
/// Create a copy of MobileMoneyOperator
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MobileMoneyOperatorCopyWith<MobileMoneyOperator> get copyWith => _$MobileMoneyOperatorCopyWithImpl<MobileMoneyOperator>(this as MobileMoneyOperator, _$identity);

  /// Serializes this MobileMoneyOperator to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MobileMoneyOperator&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.name, name) || other.name == name)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.minAmount, minAmount) || other.minAmount == minAmount)&&(identical(other.maxAmount, maxAmount) || other.maxAmount == maxAmount)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,name,logo,minAmount,maxAmount,status);

@override
String toString() {
  return 'MobileMoneyOperator(provider: $provider, name: $name, logo: $logo, minAmount: $minAmount, maxAmount: $maxAmount, status: $status)';
}


}

/// @nodoc
abstract mixin class $MobileMoneyOperatorCopyWith<$Res>  {
  factory $MobileMoneyOperatorCopyWith(MobileMoneyOperator value, $Res Function(MobileMoneyOperator) _then) = _$MobileMoneyOperatorCopyWithImpl;
@useResult
$Res call({
 String provider, String name, String logo, String minAmount, String maxAmount, String status
});




}
/// @nodoc
class _$MobileMoneyOperatorCopyWithImpl<$Res>
    implements $MobileMoneyOperatorCopyWith<$Res> {
  _$MobileMoneyOperatorCopyWithImpl(this._self, this._then);

  final MobileMoneyOperator _self;
  final $Res Function(MobileMoneyOperator) _then;

/// Create a copy of MobileMoneyOperator
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? name = null,Object? logo = null,Object? minAmount = null,Object? maxAmount = null,Object? status = null,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,minAmount: null == minAmount ? _self.minAmount : minAmount // ignore: cast_nullable_to_non_nullable
as String,maxAmount: null == maxAmount ? _self.maxAmount : maxAmount // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MobileMoneyOperator].
extension MobileMoneyOperatorPatterns on MobileMoneyOperator {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MobileMoneyOperator value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MobileMoneyOperator() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MobileMoneyOperator value)  $default,){
final _that = this;
switch (_that) {
case _MobileMoneyOperator():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MobileMoneyOperator value)?  $default,){
final _that = this;
switch (_that) {
case _MobileMoneyOperator() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provider,  String name,  String logo,  String minAmount,  String maxAmount,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MobileMoneyOperator() when $default != null:
return $default(_that.provider,_that.name,_that.logo,_that.minAmount,_that.maxAmount,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provider,  String name,  String logo,  String minAmount,  String maxAmount,  String status)  $default,) {final _that = this;
switch (_that) {
case _MobileMoneyOperator():
return $default(_that.provider,_that.name,_that.logo,_that.minAmount,_that.maxAmount,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provider,  String name,  String logo,  String minAmount,  String maxAmount,  String status)?  $default,) {final _that = this;
switch (_that) {
case _MobileMoneyOperator() when $default != null:
return $default(_that.provider,_that.name,_that.logo,_that.minAmount,_that.maxAmount,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MobileMoneyOperator extends MobileMoneyOperator {
  const _MobileMoneyOperator({required this.provider, required this.name, this.logo = '', this.minAmount = '', this.maxAmount = '', this.status = 'OPERATIONAL'}): super._();
  factory _MobileMoneyOperator.fromJson(Map<String, dynamic> json) => _$MobileMoneyOperatorFromJson(json);

@override final  String provider;
/// MTN, Orange…
@override final  String name;
@override@JsonKey() final  String logo;
@override@JsonKey() final  String minAmount;
@override@JsonKey() final  String maxAmount;
/// OPERATIONAL, DELAYED or CLOSED
@override@JsonKey() final  String status;

/// Create a copy of MobileMoneyOperator
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MobileMoneyOperatorCopyWith<_MobileMoneyOperator> get copyWith => __$MobileMoneyOperatorCopyWithImpl<_MobileMoneyOperator>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MobileMoneyOperatorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MobileMoneyOperator&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.name, name) || other.name == name)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.minAmount, minAmount) || other.minAmount == minAmount)&&(identical(other.maxAmount, maxAmount) || other.maxAmount == maxAmount)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,name,logo,minAmount,maxAmount,status);

@override
String toString() {
  return 'MobileMoneyOperator(provider: $provider, name: $name, logo: $logo, minAmount: $minAmount, maxAmount: $maxAmount, status: $status)';
}


}

/// @nodoc
abstract mixin class _$MobileMoneyOperatorCopyWith<$Res> implements $MobileMoneyOperatorCopyWith<$Res> {
  factory _$MobileMoneyOperatorCopyWith(_MobileMoneyOperator value, $Res Function(_MobileMoneyOperator) _then) = __$MobileMoneyOperatorCopyWithImpl;
@override @useResult
$Res call({
 String provider, String name, String logo, String minAmount, String maxAmount, String status
});




}
/// @nodoc
class __$MobileMoneyOperatorCopyWithImpl<$Res>
    implements _$MobileMoneyOperatorCopyWith<$Res> {
  __$MobileMoneyOperatorCopyWithImpl(this._self, this._then);

  final _MobileMoneyOperator _self;
  final $Res Function(_MobileMoneyOperator) _then;

/// Create a copy of MobileMoneyOperator
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? name = null,Object? logo = null,Object? minAmount = null,Object? maxAmount = null,Object? status = null,}) {
  return _then(_MobileMoneyOperator(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,minAmount: null == minAmount ? _self.minAmount : minAmount // ignore: cast_nullable_to_non_nullable
as String,maxAmount: null == maxAmount ? _self.maxAmount : maxAmount // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MobileMoneyCountry {

/// CMR
 String get country; Map<String, String> get names;/// 237
 String get prefix;@JsonKey(name: 'providers') List<MobileMoneyOperator> get operators;
/// Create a copy of MobileMoneyCountry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MobileMoneyCountryCopyWith<MobileMoneyCountry> get copyWith => _$MobileMoneyCountryCopyWithImpl<MobileMoneyCountry>(this as MobileMoneyCountry, _$identity);

  /// Serializes this MobileMoneyCountry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MobileMoneyCountry&&(identical(other.country, country) || other.country == country)&&const DeepCollectionEquality().equals(other.names, names)&&(identical(other.prefix, prefix) || other.prefix == prefix)&&const DeepCollectionEquality().equals(other.operators, operators));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country,const DeepCollectionEquality().hash(names),prefix,const DeepCollectionEquality().hash(operators));

@override
String toString() {
  return 'MobileMoneyCountry(country: $country, names: $names, prefix: $prefix, operators: $operators)';
}


}

/// @nodoc
abstract mixin class $MobileMoneyCountryCopyWith<$Res>  {
  factory $MobileMoneyCountryCopyWith(MobileMoneyCountry value, $Res Function(MobileMoneyCountry) _then) = _$MobileMoneyCountryCopyWithImpl;
@useResult
$Res call({
 String country, Map<String, String> names, String prefix,@JsonKey(name: 'providers') List<MobileMoneyOperator> operators
});




}
/// @nodoc
class _$MobileMoneyCountryCopyWithImpl<$Res>
    implements $MobileMoneyCountryCopyWith<$Res> {
  _$MobileMoneyCountryCopyWithImpl(this._self, this._then);

  final MobileMoneyCountry _self;
  final $Res Function(MobileMoneyCountry) _then;

/// Create a copy of MobileMoneyCountry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? country = null,Object? names = null,Object? prefix = null,Object? operators = null,}) {
  return _then(_self.copyWith(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,names: null == names ? _self.names : names // ignore: cast_nullable_to_non_nullable
as Map<String, String>,prefix: null == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as String,operators: null == operators ? _self.operators : operators // ignore: cast_nullable_to_non_nullable
as List<MobileMoneyOperator>,
  ));
}

}


/// Adds pattern-matching-related methods to [MobileMoneyCountry].
extension MobileMoneyCountryPatterns on MobileMoneyCountry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MobileMoneyCountry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MobileMoneyCountry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MobileMoneyCountry value)  $default,){
final _that = this;
switch (_that) {
case _MobileMoneyCountry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MobileMoneyCountry value)?  $default,){
final _that = this;
switch (_that) {
case _MobileMoneyCountry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String country,  Map<String, String> names,  String prefix, @JsonKey(name: 'providers')  List<MobileMoneyOperator> operators)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MobileMoneyCountry() when $default != null:
return $default(_that.country,_that.names,_that.prefix,_that.operators);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String country,  Map<String, String> names,  String prefix, @JsonKey(name: 'providers')  List<MobileMoneyOperator> operators)  $default,) {final _that = this;
switch (_that) {
case _MobileMoneyCountry():
return $default(_that.country,_that.names,_that.prefix,_that.operators);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String country,  Map<String, String> names,  String prefix, @JsonKey(name: 'providers')  List<MobileMoneyOperator> operators)?  $default,) {final _that = this;
switch (_that) {
case _MobileMoneyCountry() when $default != null:
return $default(_that.country,_that.names,_that.prefix,_that.operators);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MobileMoneyCountry extends MobileMoneyCountry {
  const _MobileMoneyCountry({required this.country, final  Map<String, String> names = const <String, String>{}, this.prefix = '', @JsonKey(name: 'providers') final  List<MobileMoneyOperator> operators = const <MobileMoneyOperator>[]}): _names = names,_operators = operators,super._();
  factory _MobileMoneyCountry.fromJson(Map<String, dynamic> json) => _$MobileMoneyCountryFromJson(json);

/// CMR
@override final  String country;
 final  Map<String, String> _names;
@override@JsonKey() Map<String, String> get names {
  if (_names is EqualUnmodifiableMapView) return _names;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_names);
}

/// 237
@override@JsonKey() final  String prefix;
 final  List<MobileMoneyOperator> _operators;
@override@JsonKey(name: 'providers') List<MobileMoneyOperator> get operators {
  if (_operators is EqualUnmodifiableListView) return _operators;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_operators);
}


/// Create a copy of MobileMoneyCountry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MobileMoneyCountryCopyWith<_MobileMoneyCountry> get copyWith => __$MobileMoneyCountryCopyWithImpl<_MobileMoneyCountry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MobileMoneyCountryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MobileMoneyCountry&&(identical(other.country, country) || other.country == country)&&const DeepCollectionEquality().equals(other._names, _names)&&(identical(other.prefix, prefix) || other.prefix == prefix)&&const DeepCollectionEquality().equals(other._operators, _operators));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country,const DeepCollectionEquality().hash(_names),prefix,const DeepCollectionEquality().hash(_operators));

@override
String toString() {
  return 'MobileMoneyCountry(country: $country, names: $names, prefix: $prefix, operators: $operators)';
}


}

/// @nodoc
abstract mixin class _$MobileMoneyCountryCopyWith<$Res> implements $MobileMoneyCountryCopyWith<$Res> {
  factory _$MobileMoneyCountryCopyWith(_MobileMoneyCountry value, $Res Function(_MobileMoneyCountry) _then) = __$MobileMoneyCountryCopyWithImpl;
@override @useResult
$Res call({
 String country, Map<String, String> names, String prefix,@JsonKey(name: 'providers') List<MobileMoneyOperator> operators
});




}
/// @nodoc
class __$MobileMoneyCountryCopyWithImpl<$Res>
    implements _$MobileMoneyCountryCopyWith<$Res> {
  __$MobileMoneyCountryCopyWithImpl(this._self, this._then);

  final _MobileMoneyCountry _self;
  final $Res Function(_MobileMoneyCountry) _then;

/// Create a copy of MobileMoneyCountry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? country = null,Object? names = null,Object? prefix = null,Object? operators = null,}) {
  return _then(_MobileMoneyCountry(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,names: null == names ? _self._names : names // ignore: cast_nullable_to_non_nullable
as Map<String, String>,prefix: null == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as String,operators: null == operators ? _self._operators : operators // ignore: cast_nullable_to_non_nullable
as List<MobileMoneyOperator>,
  ));
}


}


/// @nodoc
mixin _$OperatorGuess {

 String get country; String get provider; String get phoneNumber;
/// Create a copy of OperatorGuess
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OperatorGuessCopyWith<OperatorGuess> get copyWith => _$OperatorGuessCopyWithImpl<OperatorGuess>(this as OperatorGuess, _$identity);

  /// Serializes this OperatorGuess to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperatorGuess&&(identical(other.country, country) || other.country == country)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country,provider,phoneNumber);

@override
String toString() {
  return 'OperatorGuess(country: $country, provider: $provider, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $OperatorGuessCopyWith<$Res>  {
  factory $OperatorGuessCopyWith(OperatorGuess value, $Res Function(OperatorGuess) _then) = _$OperatorGuessCopyWithImpl;
@useResult
$Res call({
 String country, String provider, String phoneNumber
});




}
/// @nodoc
class _$OperatorGuessCopyWithImpl<$Res>
    implements $OperatorGuessCopyWith<$Res> {
  _$OperatorGuessCopyWithImpl(this._self, this._then);

  final OperatorGuess _self;
  final $Res Function(OperatorGuess) _then;

/// Create a copy of OperatorGuess
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? country = null,Object? provider = null,Object? phoneNumber = null,}) {
  return _then(_self.copyWith(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OperatorGuess].
extension OperatorGuessPatterns on OperatorGuess {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OperatorGuess value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OperatorGuess() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OperatorGuess value)  $default,){
final _that = this;
switch (_that) {
case _OperatorGuess():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OperatorGuess value)?  $default,){
final _that = this;
switch (_that) {
case _OperatorGuess() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String country,  String provider,  String phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OperatorGuess() when $default != null:
return $default(_that.country,_that.provider,_that.phoneNumber);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String country,  String provider,  String phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _OperatorGuess():
return $default(_that.country,_that.provider,_that.phoneNumber);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String country,  String provider,  String phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _OperatorGuess() when $default != null:
return $default(_that.country,_that.provider,_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OperatorGuess implements OperatorGuess {
  const _OperatorGuess({required this.country, required this.provider, required this.phoneNumber});
  factory _OperatorGuess.fromJson(Map<String, dynamic> json) => _$OperatorGuessFromJson(json);

@override final  String country;
@override final  String provider;
@override final  String phoneNumber;

/// Create a copy of OperatorGuess
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OperatorGuessCopyWith<_OperatorGuess> get copyWith => __$OperatorGuessCopyWithImpl<_OperatorGuess>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OperatorGuessToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OperatorGuess&&(identical(other.country, country) || other.country == country)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country,provider,phoneNumber);

@override
String toString() {
  return 'OperatorGuess(country: $country, provider: $provider, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$OperatorGuessCopyWith<$Res> implements $OperatorGuessCopyWith<$Res> {
  factory _$OperatorGuessCopyWith(_OperatorGuess value, $Res Function(_OperatorGuess) _then) = __$OperatorGuessCopyWithImpl;
@override @useResult
$Res call({
 String country, String provider, String phoneNumber
});




}
/// @nodoc
class __$OperatorGuessCopyWithImpl<$Res>
    implements _$OperatorGuessCopyWith<$Res> {
  __$OperatorGuessCopyWithImpl(this._self, this._then);

  final _OperatorGuess _self;
  final $Res Function(_OperatorGuess) _then;

/// Create a copy of OperatorGuess
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? country = null,Object? provider = null,Object? phoneNumber = null,}) {
  return _then(_OperatorGuess(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
