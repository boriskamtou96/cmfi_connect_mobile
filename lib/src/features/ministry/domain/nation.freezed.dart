// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Nation {

 int get id; int get position;/// As the list writes it ("Le Cameroun"). A country is shown with its
/// name in the app language (countryCode); a region keeps this one.
 String get name;/// ISO code ("CM"), '' for a region that is not a country (Écosse…).
 String get countryCode; double get latitude; double get longitude;/// The year the ministry arrived, when known.
 int? get arrivalYear;
/// Create a copy of Nation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NationCopyWith<Nation> get copyWith => _$NationCopyWithImpl<Nation>(this as Nation, _$identity);

  /// Serializes this Nation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Nation&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.name, name) || other.name == name)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.arrivalYear, arrivalYear) || other.arrivalYear == arrivalYear));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,position,name,countryCode,latitude,longitude,arrivalYear);

@override
String toString() {
  return 'Nation(id: $id, position: $position, name: $name, countryCode: $countryCode, latitude: $latitude, longitude: $longitude, arrivalYear: $arrivalYear)';
}


}

/// @nodoc
abstract mixin class $NationCopyWith<$Res>  {
  factory $NationCopyWith(Nation value, $Res Function(Nation) _then) = _$NationCopyWithImpl;
@useResult
$Res call({
 int id, int position, String name, String countryCode, double latitude, double longitude, int? arrivalYear
});




}
/// @nodoc
class _$NationCopyWithImpl<$Res>
    implements $NationCopyWith<$Res> {
  _$NationCopyWithImpl(this._self, this._then);

  final Nation _self;
  final $Res Function(Nation) _then;

/// Create a copy of Nation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? position = null,Object? name = null,Object? countryCode = null,Object? latitude = null,Object? longitude = null,Object? arrivalYear = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,arrivalYear: freezed == arrivalYear ? _self.arrivalYear : arrivalYear // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Nation].
extension NationPatterns on Nation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Nation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Nation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Nation value)  $default,){
final _that = this;
switch (_that) {
case _Nation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Nation value)?  $default,){
final _that = this;
switch (_that) {
case _Nation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int position,  String name,  String countryCode,  double latitude,  double longitude,  int? arrivalYear)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Nation() when $default != null:
return $default(_that.id,_that.position,_that.name,_that.countryCode,_that.latitude,_that.longitude,_that.arrivalYear);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int position,  String name,  String countryCode,  double latitude,  double longitude,  int? arrivalYear)  $default,) {final _that = this;
switch (_that) {
case _Nation():
return $default(_that.id,_that.position,_that.name,_that.countryCode,_that.latitude,_that.longitude,_that.arrivalYear);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int position,  String name,  String countryCode,  double latitude,  double longitude,  int? arrivalYear)?  $default,) {final _that = this;
switch (_that) {
case _Nation() when $default != null:
return $default(_that.id,_that.position,_that.name,_that.countryCode,_that.latitude,_that.longitude,_that.arrivalYear);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Nation implements Nation {
  const _Nation({required this.id, required this.position, required this.name, this.countryCode = '', required this.latitude, required this.longitude, this.arrivalYear});
  factory _Nation.fromJson(Map<String, dynamic> json) => _$NationFromJson(json);

@override final  int id;
@override final  int position;
/// As the list writes it ("Le Cameroun"). A country is shown with its
/// name in the app language (countryCode); a region keeps this one.
@override final  String name;
/// ISO code ("CM"), '' for a region that is not a country (Écosse…).
@override@JsonKey() final  String countryCode;
@override final  double latitude;
@override final  double longitude;
/// The year the ministry arrived, when known.
@override final  int? arrivalYear;

/// Create a copy of Nation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NationCopyWith<_Nation> get copyWith => __$NationCopyWithImpl<_Nation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Nation&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.name, name) || other.name == name)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.arrivalYear, arrivalYear) || other.arrivalYear == arrivalYear));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,position,name,countryCode,latitude,longitude,arrivalYear);

@override
String toString() {
  return 'Nation(id: $id, position: $position, name: $name, countryCode: $countryCode, latitude: $latitude, longitude: $longitude, arrivalYear: $arrivalYear)';
}


}

/// @nodoc
abstract mixin class _$NationCopyWith<$Res> implements $NationCopyWith<$Res> {
  factory _$NationCopyWith(_Nation value, $Res Function(_Nation) _then) = __$NationCopyWithImpl;
@override @useResult
$Res call({
 int id, int position, String name, String countryCode, double latitude, double longitude, int? arrivalYear
});




}
/// @nodoc
class __$NationCopyWithImpl<$Res>
    implements _$NationCopyWith<$Res> {
  __$NationCopyWithImpl(this._self, this._then);

  final _Nation _self;
  final $Res Function(_Nation) _then;

/// Create a copy of Nation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? position = null,Object? name = null,Object? countryCode = null,Object? latitude = null,Object? longitude = null,Object? arrivalYear = freezed,}) {
  return _then(_Nation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,arrivalYear: freezed == arrivalYear ? _self.arrivalYear : arrivalYear // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
