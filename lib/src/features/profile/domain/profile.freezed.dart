// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Profile {

 String get firstName; String get lastName; String get phoneNumber; String get email; DateTime? get birthDate; String? get city; String? get country; String? get church; String? get assembly;/// false when the server has no profile for this user yet (it must be created).
@JsonKey(includeFromJson: false, includeToJson: false) bool get exists;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.church, church) || other.church == church)&&(identical(other.assembly, assembly) || other.assembly == assembly)&&(identical(other.exists, exists) || other.exists == exists));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,phoneNumber,email,birthDate,city,country,church,assembly,exists);

@override
String toString() {
  return 'Profile(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, birthDate: $birthDate, city: $city, country: $country, church: $church, assembly: $assembly, exists: $exists)';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String phoneNumber, String email, DateTime? birthDate, String? city, String? country, String? church, String? assembly,@JsonKey(includeFromJson: false, includeToJson: false) bool exists
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? phoneNumber = null,Object? email = null,Object? birthDate = freezed,Object? city = freezed,Object? country = freezed,Object? church = freezed,Object? assembly = freezed,Object? exists = null,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,church: freezed == church ? _self.church : church // ignore: cast_nullable_to_non_nullable
as String?,assembly: freezed == assembly ? _self.assembly : assembly // ignore: cast_nullable_to_non_nullable
as String?,exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String phoneNumber,  String email,  DateTime? birthDate,  String? city,  String? country,  String? church,  String? assembly, @JsonKey(includeFromJson: false, includeToJson: false)  bool exists)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.firstName,_that.lastName,_that.phoneNumber,_that.email,_that.birthDate,_that.city,_that.country,_that.church,_that.assembly,_that.exists);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String phoneNumber,  String email,  DateTime? birthDate,  String? city,  String? country,  String? church,  String? assembly, @JsonKey(includeFromJson: false, includeToJson: false)  bool exists)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.firstName,_that.lastName,_that.phoneNumber,_that.email,_that.birthDate,_that.city,_that.country,_that.church,_that.assembly,_that.exists);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String phoneNumber,  String email,  DateTime? birthDate,  String? city,  String? country,  String? church,  String? assembly, @JsonKey(includeFromJson: false, includeToJson: false)  bool exists)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.firstName,_that.lastName,_that.phoneNumber,_that.email,_that.birthDate,_that.city,_that.country,_that.church,_that.assembly,_that.exists);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile extends Profile {
  const _Profile({required this.firstName, this.lastName = '', required this.phoneNumber, this.email = '', this.birthDate, this.city, this.country, this.church, this.assembly, @JsonKey(includeFromJson: false, includeToJson: false) this.exists = true}): super._();
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  String firstName;
@override@JsonKey() final  String lastName;
@override final  String phoneNumber;
@override@JsonKey() final  String email;
@override final  DateTime? birthDate;
@override final  String? city;
@override final  String? country;
@override final  String? church;
@override final  String? assembly;
/// false when the server has no profile for this user yet (it must be created).
@override@JsonKey(includeFromJson: false, includeToJson: false) final  bool exists;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.church, church) || other.church == church)&&(identical(other.assembly, assembly) || other.assembly == assembly)&&(identical(other.exists, exists) || other.exists == exists));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,phoneNumber,email,birthDate,city,country,church,assembly,exists);

@override
String toString() {
  return 'Profile(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, birthDate: $birthDate, city: $city, country: $country, church: $church, assembly: $assembly, exists: $exists)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String phoneNumber, String email, DateTime? birthDate, String? city, String? country, String? church, String? assembly,@JsonKey(includeFromJson: false, includeToJson: false) bool exists
});




}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? phoneNumber = null,Object? email = null,Object? birthDate = freezed,Object? city = freezed,Object? country = freezed,Object? church = freezed,Object? assembly = freezed,Object? exists = null,}) {
  return _then(_Profile(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,church: freezed == church ? _self.church : church // ignore: cast_nullable_to_non_nullable
as String?,assembly: freezed == assembly ? _self.assembly : assembly // ignore: cast_nullable_to_non_nullable
as String?,exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
