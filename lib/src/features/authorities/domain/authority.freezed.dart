// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authority.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Authority {

 int get id; String get firstName; String? get lastName;/// For a member found by pseudo: only once they accepted.
 String? get phoneNumber; String? get email; bool get isDiscipleMaker;/// A member of the app, found by pseudo (null: typed by hand).
 String? get username; String? get church; String? get assembly;@JsonKey(unknownEnumValue: AuthorityStatus.accepted) AuthorityStatus get status;/// The profile photo of a member found by pseudo, or null.
 EventImage? get avatar;/// A disciple maker found by pseudo sees the user's regularity (days
/// filled in, streak, % of goals; never the reports), unless turned off.
 bool get sharesRegularity;
/// Create a copy of Authority
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorityCopyWith<Authority> get copyWith => _$AuthorityCopyWithImpl<Authority>(this as Authority, _$identity);

  /// Serializes this Authority to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authority&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker)&&(identical(other.username, username) || other.username == username)&&(identical(other.church, church) || other.church == church)&&(identical(other.assembly, assembly) || other.assembly == assembly)&&(identical(other.status, status) || other.status == status)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.sharesRegularity, sharesRegularity) || other.sharesRegularity == sharesRegularity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,phoneNumber,email,isDiscipleMaker,username,church,assembly,status,avatar,sharesRegularity);

@override
String toString() {
  return 'Authority(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, isDiscipleMaker: $isDiscipleMaker, username: $username, church: $church, assembly: $assembly, status: $status, avatar: $avatar, sharesRegularity: $sharesRegularity)';
}


}

/// @nodoc
abstract mixin class $AuthorityCopyWith<$Res>  {
  factory $AuthorityCopyWith(Authority value, $Res Function(Authority) _then) = _$AuthorityCopyWithImpl;
@useResult
$Res call({
 int id, String firstName, String? lastName, String? phoneNumber, String? email, bool isDiscipleMaker, String? username, String? church, String? assembly,@JsonKey(unknownEnumValue: AuthorityStatus.accepted) AuthorityStatus status, EventImage? avatar, bool sharesRegularity
});


$EventImageCopyWith<$Res>? get avatar;

}
/// @nodoc
class _$AuthorityCopyWithImpl<$Res>
    implements $AuthorityCopyWith<$Res> {
  _$AuthorityCopyWithImpl(this._self, this._then);

  final Authority _self;
  final $Res Function(Authority) _then;

/// Create a copy of Authority
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? isDiscipleMaker = null,Object? username = freezed,Object? church = freezed,Object? assembly = freezed,Object? status = null,Object? avatar = freezed,Object? sharesRegularity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,church: freezed == church ? _self.church : church // ignore: cast_nullable_to_non_nullable
as String?,assembly: freezed == assembly ? _self.assembly : assembly // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthorityStatus,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as EventImage?,sharesRegularity: null == sharesRegularity ? _self.sharesRegularity : sharesRegularity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Authority
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get avatar {
    if (_self.avatar == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.avatar!, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}
}


/// Adds pattern-matching-related methods to [Authority].
extension AuthorityPatterns on Authority {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Authority value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Authority() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Authority value)  $default,){
final _that = this;
switch (_that) {
case _Authority():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Authority value)?  $default,){
final _that = this;
switch (_that) {
case _Authority() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String firstName,  String? lastName,  String? phoneNumber,  String? email,  bool isDiscipleMaker,  String? username,  String? church,  String? assembly, @JsonKey(unknownEnumValue: AuthorityStatus.accepted)  AuthorityStatus status,  EventImage? avatar,  bool sharesRegularity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Authority() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.phoneNumber,_that.email,_that.isDiscipleMaker,_that.username,_that.church,_that.assembly,_that.status,_that.avatar,_that.sharesRegularity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String firstName,  String? lastName,  String? phoneNumber,  String? email,  bool isDiscipleMaker,  String? username,  String? church,  String? assembly, @JsonKey(unknownEnumValue: AuthorityStatus.accepted)  AuthorityStatus status,  EventImage? avatar,  bool sharesRegularity)  $default,) {final _that = this;
switch (_that) {
case _Authority():
return $default(_that.id,_that.firstName,_that.lastName,_that.phoneNumber,_that.email,_that.isDiscipleMaker,_that.username,_that.church,_that.assembly,_that.status,_that.avatar,_that.sharesRegularity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String firstName,  String? lastName,  String? phoneNumber,  String? email,  bool isDiscipleMaker,  String? username,  String? church,  String? assembly, @JsonKey(unknownEnumValue: AuthorityStatus.accepted)  AuthorityStatus status,  EventImage? avatar,  bool sharesRegularity)?  $default,) {final _that = this;
switch (_that) {
case _Authority() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.phoneNumber,_that.email,_that.isDiscipleMaker,_that.username,_that.church,_that.assembly,_that.status,_that.avatar,_that.sharesRegularity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Authority extends Authority {
  const _Authority({required this.id, required this.firstName, this.lastName, this.phoneNumber, this.email, this.isDiscipleMaker = false, this.username, this.church, this.assembly, @JsonKey(unknownEnumValue: AuthorityStatus.accepted) this.status = AuthorityStatus.accepted, this.avatar, this.sharesRegularity = true}): super._();
  factory _Authority.fromJson(Map<String, dynamic> json) => _$AuthorityFromJson(json);

@override final  int id;
@override final  String firstName;
@override final  String? lastName;
/// For a member found by pseudo: only once they accepted.
@override final  String? phoneNumber;
@override final  String? email;
@override@JsonKey() final  bool isDiscipleMaker;
/// A member of the app, found by pseudo (null: typed by hand).
@override final  String? username;
@override final  String? church;
@override final  String? assembly;
@override@JsonKey(unknownEnumValue: AuthorityStatus.accepted) final  AuthorityStatus status;
/// The profile photo of a member found by pseudo, or null.
@override final  EventImage? avatar;
/// A disciple maker found by pseudo sees the user's regularity (days
/// filled in, streak, % of goals; never the reports), unless turned off.
@override@JsonKey() final  bool sharesRegularity;

/// Create a copy of Authority
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthorityCopyWith<_Authority> get copyWith => __$AuthorityCopyWithImpl<_Authority>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthorityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authority&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker)&&(identical(other.username, username) || other.username == username)&&(identical(other.church, church) || other.church == church)&&(identical(other.assembly, assembly) || other.assembly == assembly)&&(identical(other.status, status) || other.status == status)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.sharesRegularity, sharesRegularity) || other.sharesRegularity == sharesRegularity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,phoneNumber,email,isDiscipleMaker,username,church,assembly,status,avatar,sharesRegularity);

@override
String toString() {
  return 'Authority(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, isDiscipleMaker: $isDiscipleMaker, username: $username, church: $church, assembly: $assembly, status: $status, avatar: $avatar, sharesRegularity: $sharesRegularity)';
}


}

/// @nodoc
abstract mixin class _$AuthorityCopyWith<$Res> implements $AuthorityCopyWith<$Res> {
  factory _$AuthorityCopyWith(_Authority value, $Res Function(_Authority) _then) = __$AuthorityCopyWithImpl;
@override @useResult
$Res call({
 int id, String firstName, String? lastName, String? phoneNumber, String? email, bool isDiscipleMaker, String? username, String? church, String? assembly,@JsonKey(unknownEnumValue: AuthorityStatus.accepted) AuthorityStatus status, EventImage? avatar, bool sharesRegularity
});


@override $EventImageCopyWith<$Res>? get avatar;

}
/// @nodoc
class __$AuthorityCopyWithImpl<$Res>
    implements _$AuthorityCopyWith<$Res> {
  __$AuthorityCopyWithImpl(this._self, this._then);

  final _Authority _self;
  final $Res Function(_Authority) _then;

/// Create a copy of Authority
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? isDiscipleMaker = null,Object? username = freezed,Object? church = freezed,Object? assembly = freezed,Object? status = null,Object? avatar = freezed,Object? sharesRegularity = null,}) {
  return _then(_Authority(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,church: freezed == church ? _self.church : church // ignore: cast_nullable_to_non_nullable
as String?,assembly: freezed == assembly ? _self.assembly : assembly // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthorityStatus,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as EventImage?,sharesRegularity: null == sharesRegularity ? _self.sharesRegularity : sharesRegularity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Authority
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get avatar {
    if (_self.avatar == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.avatar!, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}
}


/// @nodoc
mixin _$AuthorityRequest {

 int get id; MemberCard get from; bool get isDiscipleMaker;
/// Create a copy of AuthorityRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorityRequestCopyWith<AuthorityRequest> get copyWith => _$AuthorityRequestCopyWithImpl<AuthorityRequest>(this as AuthorityRequest, _$identity);

  /// Serializes this AuthorityRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthorityRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.from, from) || other.from == from)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,from,isDiscipleMaker);

@override
String toString() {
  return 'AuthorityRequest(id: $id, from: $from, isDiscipleMaker: $isDiscipleMaker)';
}


}

/// @nodoc
abstract mixin class $AuthorityRequestCopyWith<$Res>  {
  factory $AuthorityRequestCopyWith(AuthorityRequest value, $Res Function(AuthorityRequest) _then) = _$AuthorityRequestCopyWithImpl;
@useResult
$Res call({
 int id, MemberCard from, bool isDiscipleMaker
});


$MemberCardCopyWith<$Res> get from;

}
/// @nodoc
class _$AuthorityRequestCopyWithImpl<$Res>
    implements $AuthorityRequestCopyWith<$Res> {
  _$AuthorityRequestCopyWithImpl(this._self, this._then);

  final AuthorityRequest _self;
  final $Res Function(AuthorityRequest) _then;

/// Create a copy of AuthorityRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? from = null,Object? isDiscipleMaker = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as MemberCard,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AuthorityRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get from {
  
  return $MemberCardCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthorityRequest].
extension AuthorityRequestPatterns on AuthorityRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthorityRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthorityRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthorityRequest value)  $default,){
final _that = this;
switch (_that) {
case _AuthorityRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthorityRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AuthorityRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  MemberCard from,  bool isDiscipleMaker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthorityRequest() when $default != null:
return $default(_that.id,_that.from,_that.isDiscipleMaker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  MemberCard from,  bool isDiscipleMaker)  $default,) {final _that = this;
switch (_that) {
case _AuthorityRequest():
return $default(_that.id,_that.from,_that.isDiscipleMaker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  MemberCard from,  bool isDiscipleMaker)?  $default,) {final _that = this;
switch (_that) {
case _AuthorityRequest() when $default != null:
return $default(_that.id,_that.from,_that.isDiscipleMaker);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthorityRequest implements AuthorityRequest {
  const _AuthorityRequest({required this.id, required this.from, this.isDiscipleMaker = false});
  factory _AuthorityRequest.fromJson(Map<String, dynamic> json) => _$AuthorityRequestFromJson(json);

@override final  int id;
@override final  MemberCard from;
@override@JsonKey() final  bool isDiscipleMaker;

/// Create a copy of AuthorityRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthorityRequestCopyWith<_AuthorityRequest> get copyWith => __$AuthorityRequestCopyWithImpl<_AuthorityRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthorityRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthorityRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.from, from) || other.from == from)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,from,isDiscipleMaker);

@override
String toString() {
  return 'AuthorityRequest(id: $id, from: $from, isDiscipleMaker: $isDiscipleMaker)';
}


}

/// @nodoc
abstract mixin class _$AuthorityRequestCopyWith<$Res> implements $AuthorityRequestCopyWith<$Res> {
  factory _$AuthorityRequestCopyWith(_AuthorityRequest value, $Res Function(_AuthorityRequest) _then) = __$AuthorityRequestCopyWithImpl;
@override @useResult
$Res call({
 int id, MemberCard from, bool isDiscipleMaker
});


@override $MemberCardCopyWith<$Res> get from;

}
/// @nodoc
class __$AuthorityRequestCopyWithImpl<$Res>
    implements _$AuthorityRequestCopyWith<$Res> {
  __$AuthorityRequestCopyWithImpl(this._self, this._then);

  final _AuthorityRequest _self;
  final $Res Function(_AuthorityRequest) _then;

/// Create a copy of AuthorityRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? from = null,Object? isDiscipleMaker = null,}) {
  return _then(_AuthorityRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as MemberCard,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthorityRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get from {
  
  return $MemberCardCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}
}

// dart format on
