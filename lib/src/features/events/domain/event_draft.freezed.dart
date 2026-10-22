// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventDraft {

 String get title; String get theme; String get themeVerse; String get description;@UtcInstantConverter() DateTime get startsAt;@UtcInstantConverter() DateTime get endsAt; String get timeZone; String get venue; String get address; String get city; String get country; String get mapsUrl; String get contactName; String get contactPhone; int? get posterId; bool get registrationOpen;@UtcInstantConverter() DateTime? get registrationDeadline; int? get capacity; bool get asksLodging; bool get asksDepartureCity; String get feeNote;/// Per person, in whole XAF; null for a free event.
 int? get priceAmount; String get priceCurrency; EventStatus get status;
/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDraftCopyWith<EventDraft> get copyWith => _$EventDraftCopyWithImpl<EventDraft>(this as EventDraft, _$identity);

  /// Serializes this EventDraft to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.themeVerse, themeVerse) || other.themeVerse == themeVerse)&&(identical(other.description, description) || other.description == description)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.posterId, posterId) || other.posterId == posterId)&&(identical(other.registrationOpen, registrationOpen) || other.registrationOpen == registrationOpen)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.asksLodging, asksLodging) || other.asksLodging == asksLodging)&&(identical(other.asksDepartureCity, asksDepartureCity) || other.asksDepartureCity == asksDepartureCity)&&(identical(other.feeNote, feeNote) || other.feeNote == feeNote)&&(identical(other.priceAmount, priceAmount) || other.priceAmount == priceAmount)&&(identical(other.priceCurrency, priceCurrency) || other.priceCurrency == priceCurrency)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,title,theme,themeVerse,description,startsAt,endsAt,timeZone,venue,address,city,country,mapsUrl,contactName,contactPhone,posterId,registrationOpen,registrationDeadline,capacity,asksLodging,asksDepartureCity,feeNote,priceAmount,priceCurrency,status]);

@override
String toString() {
  return 'EventDraft(title: $title, theme: $theme, themeVerse: $themeVerse, description: $description, startsAt: $startsAt, endsAt: $endsAt, timeZone: $timeZone, venue: $venue, address: $address, city: $city, country: $country, mapsUrl: $mapsUrl, contactName: $contactName, contactPhone: $contactPhone, posterId: $posterId, registrationOpen: $registrationOpen, registrationDeadline: $registrationDeadline, capacity: $capacity, asksLodging: $asksLodging, asksDepartureCity: $asksDepartureCity, feeNote: $feeNote, priceAmount: $priceAmount, priceCurrency: $priceCurrency, status: $status)';
}


}

/// @nodoc
abstract mixin class $EventDraftCopyWith<$Res>  {
  factory $EventDraftCopyWith(EventDraft value, $Res Function(EventDraft) _then) = _$EventDraftCopyWithImpl;
@useResult
$Res call({
 String title, String theme, String themeVerse, String description,@UtcInstantConverter() DateTime startsAt,@UtcInstantConverter() DateTime endsAt, String timeZone, String venue, String address, String city, String country, String mapsUrl, String contactName, String contactPhone, int? posterId, bool registrationOpen,@UtcInstantConverter() DateTime? registrationDeadline, int? capacity, bool asksLodging, bool asksDepartureCity, String feeNote, int? priceAmount, String priceCurrency, EventStatus status
});




}
/// @nodoc
class _$EventDraftCopyWithImpl<$Res>
    implements $EventDraftCopyWith<$Res> {
  _$EventDraftCopyWithImpl(this._self, this._then);

  final EventDraft _self;
  final $Res Function(EventDraft) _then;

/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? theme = null,Object? themeVerse = null,Object? description = null,Object? startsAt = null,Object? endsAt = null,Object? timeZone = null,Object? venue = null,Object? address = null,Object? city = null,Object? country = null,Object? mapsUrl = null,Object? contactName = null,Object? contactPhone = null,Object? posterId = freezed,Object? registrationOpen = null,Object? registrationDeadline = freezed,Object? capacity = freezed,Object? asksLodging = null,Object? asksDepartureCity = null,Object? feeNote = null,Object? priceAmount = freezed,Object? priceCurrency = null,Object? status = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,themeVerse: null == themeVerse ? _self.themeVerse : themeVerse // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,mapsUrl: null == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactPhone: null == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String,posterId: freezed == posterId ? _self.posterId : posterId // ignore: cast_nullable_to_non_nullable
as int?,registrationOpen: null == registrationOpen ? _self.registrationOpen : registrationOpen // ignore: cast_nullable_to_non_nullable
as bool,registrationDeadline: freezed == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,capacity: freezed == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int?,asksLodging: null == asksLodging ? _self.asksLodging : asksLodging // ignore: cast_nullable_to_non_nullable
as bool,asksDepartureCity: null == asksDepartureCity ? _self.asksDepartureCity : asksDepartureCity // ignore: cast_nullable_to_non_nullable
as bool,feeNote: null == feeNote ? _self.feeNote : feeNote // ignore: cast_nullable_to_non_nullable
as String,priceAmount: freezed == priceAmount ? _self.priceAmount : priceAmount // ignore: cast_nullable_to_non_nullable
as int?,priceCurrency: null == priceCurrency ? _self.priceCurrency : priceCurrency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [EventDraft].
extension EventDraftPatterns on EventDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDraft value)  $default,){
final _that = this;
switch (_that) {
case _EventDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDraft value)?  $default,){
final _that = this;
switch (_that) {
case _EventDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String theme,  String themeVerse,  String description, @UtcInstantConverter()  DateTime startsAt, @UtcInstantConverter()  DateTime endsAt,  String timeZone,  String venue,  String address,  String city,  String country,  String mapsUrl,  String contactName,  String contactPhone,  int? posterId,  bool registrationOpen, @UtcInstantConverter()  DateTime? registrationDeadline,  int? capacity,  bool asksLodging,  bool asksDepartureCity,  String feeNote,  int? priceAmount,  String priceCurrency,  EventStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDraft() when $default != null:
return $default(_that.title,_that.theme,_that.themeVerse,_that.description,_that.startsAt,_that.endsAt,_that.timeZone,_that.venue,_that.address,_that.city,_that.country,_that.mapsUrl,_that.contactName,_that.contactPhone,_that.posterId,_that.registrationOpen,_that.registrationDeadline,_that.capacity,_that.asksLodging,_that.asksDepartureCity,_that.feeNote,_that.priceAmount,_that.priceCurrency,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String theme,  String themeVerse,  String description, @UtcInstantConverter()  DateTime startsAt, @UtcInstantConverter()  DateTime endsAt,  String timeZone,  String venue,  String address,  String city,  String country,  String mapsUrl,  String contactName,  String contactPhone,  int? posterId,  bool registrationOpen, @UtcInstantConverter()  DateTime? registrationDeadline,  int? capacity,  bool asksLodging,  bool asksDepartureCity,  String feeNote,  int? priceAmount,  String priceCurrency,  EventStatus status)  $default,) {final _that = this;
switch (_that) {
case _EventDraft():
return $default(_that.title,_that.theme,_that.themeVerse,_that.description,_that.startsAt,_that.endsAt,_that.timeZone,_that.venue,_that.address,_that.city,_that.country,_that.mapsUrl,_that.contactName,_that.contactPhone,_that.posterId,_that.registrationOpen,_that.registrationDeadline,_that.capacity,_that.asksLodging,_that.asksDepartureCity,_that.feeNote,_that.priceAmount,_that.priceCurrency,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String theme,  String themeVerse,  String description, @UtcInstantConverter()  DateTime startsAt, @UtcInstantConverter()  DateTime endsAt,  String timeZone,  String venue,  String address,  String city,  String country,  String mapsUrl,  String contactName,  String contactPhone,  int? posterId,  bool registrationOpen, @UtcInstantConverter()  DateTime? registrationDeadline,  int? capacity,  bool asksLodging,  bool asksDepartureCity,  String feeNote,  int? priceAmount,  String priceCurrency,  EventStatus status)?  $default,) {final _that = this;
switch (_that) {
case _EventDraft() when $default != null:
return $default(_that.title,_that.theme,_that.themeVerse,_that.description,_that.startsAt,_that.endsAt,_that.timeZone,_that.venue,_that.address,_that.city,_that.country,_that.mapsUrl,_that.contactName,_that.contactPhone,_that.posterId,_that.registrationOpen,_that.registrationDeadline,_that.capacity,_that.asksLodging,_that.asksDepartureCity,_that.feeNote,_that.priceAmount,_that.priceCurrency,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDraft implements EventDraft {
  const _EventDraft({required this.title, this.theme = '', this.themeVerse = '', this.description = '', @UtcInstantConverter() required this.startsAt, @UtcInstantConverter() required this.endsAt, this.timeZone = CommunityEvent.defaultTimeZone, this.venue = '', this.address = '', this.city = '', this.country = '', this.mapsUrl = '', this.contactName = '', this.contactPhone = '', this.posterId, this.registrationOpen = true, @UtcInstantConverter() this.registrationDeadline, this.capacity, this.asksLodging = false, this.asksDepartureCity = false, this.feeNote = '', this.priceAmount, this.priceCurrency = 'XAF', this.status = EventStatus.draft});
  factory _EventDraft.fromJson(Map<String, dynamic> json) => _$EventDraftFromJson(json);

@override final  String title;
@override@JsonKey() final  String theme;
@override@JsonKey() final  String themeVerse;
@override@JsonKey() final  String description;
@override@UtcInstantConverter() final  DateTime startsAt;
@override@UtcInstantConverter() final  DateTime endsAt;
@override@JsonKey() final  String timeZone;
@override@JsonKey() final  String venue;
@override@JsonKey() final  String address;
@override@JsonKey() final  String city;
@override@JsonKey() final  String country;
@override@JsonKey() final  String mapsUrl;
@override@JsonKey() final  String contactName;
@override@JsonKey() final  String contactPhone;
@override final  int? posterId;
@override@JsonKey() final  bool registrationOpen;
@override@UtcInstantConverter() final  DateTime? registrationDeadline;
@override final  int? capacity;
@override@JsonKey() final  bool asksLodging;
@override@JsonKey() final  bool asksDepartureCity;
@override@JsonKey() final  String feeNote;
/// Per person, in whole XAF; null for a free event.
@override final  int? priceAmount;
@override@JsonKey() final  String priceCurrency;
@override@JsonKey() final  EventStatus status;

/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDraftCopyWith<_EventDraft> get copyWith => __$EventDraftCopyWithImpl<_EventDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.themeVerse, themeVerse) || other.themeVerse == themeVerse)&&(identical(other.description, description) || other.description == description)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.posterId, posterId) || other.posterId == posterId)&&(identical(other.registrationOpen, registrationOpen) || other.registrationOpen == registrationOpen)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.asksLodging, asksLodging) || other.asksLodging == asksLodging)&&(identical(other.asksDepartureCity, asksDepartureCity) || other.asksDepartureCity == asksDepartureCity)&&(identical(other.feeNote, feeNote) || other.feeNote == feeNote)&&(identical(other.priceAmount, priceAmount) || other.priceAmount == priceAmount)&&(identical(other.priceCurrency, priceCurrency) || other.priceCurrency == priceCurrency)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,title,theme,themeVerse,description,startsAt,endsAt,timeZone,venue,address,city,country,mapsUrl,contactName,contactPhone,posterId,registrationOpen,registrationDeadline,capacity,asksLodging,asksDepartureCity,feeNote,priceAmount,priceCurrency,status]);

@override
String toString() {
  return 'EventDraft(title: $title, theme: $theme, themeVerse: $themeVerse, description: $description, startsAt: $startsAt, endsAt: $endsAt, timeZone: $timeZone, venue: $venue, address: $address, city: $city, country: $country, mapsUrl: $mapsUrl, contactName: $contactName, contactPhone: $contactPhone, posterId: $posterId, registrationOpen: $registrationOpen, registrationDeadline: $registrationDeadline, capacity: $capacity, asksLodging: $asksLodging, asksDepartureCity: $asksDepartureCity, feeNote: $feeNote, priceAmount: $priceAmount, priceCurrency: $priceCurrency, status: $status)';
}


}

/// @nodoc
abstract mixin class _$EventDraftCopyWith<$Res> implements $EventDraftCopyWith<$Res> {
  factory _$EventDraftCopyWith(_EventDraft value, $Res Function(_EventDraft) _then) = __$EventDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, String theme, String themeVerse, String description,@UtcInstantConverter() DateTime startsAt,@UtcInstantConverter() DateTime endsAt, String timeZone, String venue, String address, String city, String country, String mapsUrl, String contactName, String contactPhone, int? posterId, bool registrationOpen,@UtcInstantConverter() DateTime? registrationDeadline, int? capacity, bool asksLodging, bool asksDepartureCity, String feeNote, int? priceAmount, String priceCurrency, EventStatus status
});




}
/// @nodoc
class __$EventDraftCopyWithImpl<$Res>
    implements _$EventDraftCopyWith<$Res> {
  __$EventDraftCopyWithImpl(this._self, this._then);

  final _EventDraft _self;
  final $Res Function(_EventDraft) _then;

/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? theme = null,Object? themeVerse = null,Object? description = null,Object? startsAt = null,Object? endsAt = null,Object? timeZone = null,Object? venue = null,Object? address = null,Object? city = null,Object? country = null,Object? mapsUrl = null,Object? contactName = null,Object? contactPhone = null,Object? posterId = freezed,Object? registrationOpen = null,Object? registrationDeadline = freezed,Object? capacity = freezed,Object? asksLodging = null,Object? asksDepartureCity = null,Object? feeNote = null,Object? priceAmount = freezed,Object? priceCurrency = null,Object? status = null,}) {
  return _then(_EventDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,themeVerse: null == themeVerse ? _self.themeVerse : themeVerse // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,mapsUrl: null == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactPhone: null == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String,posterId: freezed == posterId ? _self.posterId : posterId // ignore: cast_nullable_to_non_nullable
as int?,registrationOpen: null == registrationOpen ? _self.registrationOpen : registrationOpen // ignore: cast_nullable_to_non_nullable
as bool,registrationDeadline: freezed == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,capacity: freezed == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int?,asksLodging: null == asksLodging ? _self.asksLodging : asksLodging // ignore: cast_nullable_to_non_nullable
as bool,asksDepartureCity: null == asksDepartureCity ? _self.asksDepartureCity : asksDepartureCity // ignore: cast_nullable_to_non_nullable
as bool,feeNote: null == feeNote ? _self.feeNote : feeNote // ignore: cast_nullable_to_non_nullable
as String,priceAmount: freezed == priceAmount ? _self.priceAmount : priceAmount // ignore: cast_nullable_to_non_nullable
as int?,priceCurrency: null == priceCurrency ? _self.priceCurrency : priceCurrency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventStatus,
  ));
}


}


/// @nodoc
mixin _$SessionDraft {

@UtcInstantConverter() DateTime get startsAt;@UtcInstantConverter() DateTime? get endsAt; String get title; String get speaker; String get place; String get description; List<SessionHymn> get hymns;
/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionDraftCopyWith<SessionDraft> get copyWith => _$SessionDraftCopyWithImpl<SessionDraft>(this as SessionDraft, _$identity);

  /// Serializes this SessionDraft to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionDraft&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.place, place) || other.place == place)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.hymns, hymns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startsAt,endsAt,title,speaker,place,description,const DeepCollectionEquality().hash(hymns));

@override
String toString() {
  return 'SessionDraft(startsAt: $startsAt, endsAt: $endsAt, title: $title, speaker: $speaker, place: $place, description: $description, hymns: $hymns)';
}


}

/// @nodoc
abstract mixin class $SessionDraftCopyWith<$Res>  {
  factory $SessionDraftCopyWith(SessionDraft value, $Res Function(SessionDraft) _then) = _$SessionDraftCopyWithImpl;
@useResult
$Res call({
@UtcInstantConverter() DateTime startsAt,@UtcInstantConverter() DateTime? endsAt, String title, String speaker, String place, String description, List<SessionHymn> hymns
});




}
/// @nodoc
class _$SessionDraftCopyWithImpl<$Res>
    implements $SessionDraftCopyWith<$Res> {
  _$SessionDraftCopyWithImpl(this._self, this._then);

  final SessionDraft _self;
  final $Res Function(SessionDraft) _then;

/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startsAt = null,Object? endsAt = freezed,Object? title = null,Object? speaker = null,Object? place = null,Object? description = null,Object? hymns = null,}) {
  return _then(_self.copyWith(
startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,hymns: null == hymns ? _self.hymns : hymns // ignore: cast_nullable_to_non_nullable
as List<SessionHymn>,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionDraft].
extension SessionDraftPatterns on SessionDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionDraft value)  $default,){
final _that = this;
switch (_that) {
case _SessionDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionDraft value)?  $default,){
final _that = this;
switch (_that) {
case _SessionDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@UtcInstantConverter()  DateTime startsAt, @UtcInstantConverter()  DateTime? endsAt,  String title,  String speaker,  String place,  String description,  List<SessionHymn> hymns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionDraft() when $default != null:
return $default(_that.startsAt,_that.endsAt,_that.title,_that.speaker,_that.place,_that.description,_that.hymns);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@UtcInstantConverter()  DateTime startsAt, @UtcInstantConverter()  DateTime? endsAt,  String title,  String speaker,  String place,  String description,  List<SessionHymn> hymns)  $default,) {final _that = this;
switch (_that) {
case _SessionDraft():
return $default(_that.startsAt,_that.endsAt,_that.title,_that.speaker,_that.place,_that.description,_that.hymns);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@UtcInstantConverter()  DateTime startsAt, @UtcInstantConverter()  DateTime? endsAt,  String title,  String speaker,  String place,  String description,  List<SessionHymn> hymns)?  $default,) {final _that = this;
switch (_that) {
case _SessionDraft() when $default != null:
return $default(_that.startsAt,_that.endsAt,_that.title,_that.speaker,_that.place,_that.description,_that.hymns);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionDraft implements SessionDraft {
  const _SessionDraft({@UtcInstantConverter() required this.startsAt, @UtcInstantConverter() this.endsAt, required this.title, this.speaker = '', this.place = '', this.description = '', final  List<SessionHymn> hymns = const <SessionHymn>[]}): _hymns = hymns;
  factory _SessionDraft.fromJson(Map<String, dynamic> json) => _$SessionDraftFromJson(json);

@override@UtcInstantConverter() final  DateTime startsAt;
@override@UtcInstantConverter() final  DateTime? endsAt;
@override final  String title;
@override@JsonKey() final  String speaker;
@override@JsonKey() final  String place;
@override@JsonKey() final  String description;
 final  List<SessionHymn> _hymns;
@override@JsonKey() List<SessionHymn> get hymns {
  if (_hymns is EqualUnmodifiableListView) return _hymns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hymns);
}


/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionDraftCopyWith<_SessionDraft> get copyWith => __$SessionDraftCopyWithImpl<_SessionDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionDraft&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.place, place) || other.place == place)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._hymns, _hymns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startsAt,endsAt,title,speaker,place,description,const DeepCollectionEquality().hash(_hymns));

@override
String toString() {
  return 'SessionDraft(startsAt: $startsAt, endsAt: $endsAt, title: $title, speaker: $speaker, place: $place, description: $description, hymns: $hymns)';
}


}

/// @nodoc
abstract mixin class _$SessionDraftCopyWith<$Res> implements $SessionDraftCopyWith<$Res> {
  factory _$SessionDraftCopyWith(_SessionDraft value, $Res Function(_SessionDraft) _then) = __$SessionDraftCopyWithImpl;
@override @useResult
$Res call({
@UtcInstantConverter() DateTime startsAt,@UtcInstantConverter() DateTime? endsAt, String title, String speaker, String place, String description, List<SessionHymn> hymns
});




}
/// @nodoc
class __$SessionDraftCopyWithImpl<$Res>
    implements _$SessionDraftCopyWith<$Res> {
  __$SessionDraftCopyWithImpl(this._self, this._then);

  final _SessionDraft _self;
  final $Res Function(_SessionDraft) _then;

/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startsAt = null,Object? endsAt = freezed,Object? title = null,Object? speaker = null,Object? place = null,Object? description = null,Object? hymns = null,}) {
  return _then(_SessionDraft(
startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,hymns: null == hymns ? _self._hymns : hymns // ignore: cast_nullable_to_non_nullable
as List<SessionHymn>,
  ));
}


}

// dart format on
