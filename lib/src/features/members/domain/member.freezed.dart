// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberCard {

 String get username; String get firstName; String get lastName; String get church; String get assembly;
/// Create a copy of MemberCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberCardCopyWith<MemberCard> get copyWith => _$MemberCardCopyWithImpl<MemberCard>(this as MemberCard, _$identity);

  /// Serializes this MemberCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberCard&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.church, church) || other.church == church)&&(identical(other.assembly, assembly) || other.assembly == assembly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,firstName,lastName,church,assembly);

@override
String toString() {
  return 'MemberCard(username: $username, firstName: $firstName, lastName: $lastName, church: $church, assembly: $assembly)';
}


}

/// @nodoc
abstract mixin class $MemberCardCopyWith<$Res>  {
  factory $MemberCardCopyWith(MemberCard value, $Res Function(MemberCard) _then) = _$MemberCardCopyWithImpl;
@useResult
$Res call({
 String username, String firstName, String lastName, String church, String assembly
});




}
/// @nodoc
class _$MemberCardCopyWithImpl<$Res>
    implements $MemberCardCopyWith<$Res> {
  _$MemberCardCopyWithImpl(this._self, this._then);

  final MemberCard _self;
  final $Res Function(MemberCard) _then;

/// Create a copy of MemberCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? firstName = null,Object? lastName = null,Object? church = null,Object? assembly = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,church: null == church ? _self.church : church // ignore: cast_nullable_to_non_nullable
as String,assembly: null == assembly ? _self.assembly : assembly // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberCard].
extension MemberCardPatterns on MemberCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberCard value)  $default,){
final _that = this;
switch (_that) {
case _MemberCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberCard value)?  $default,){
final _that = this;
switch (_that) {
case _MemberCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String firstName,  String lastName,  String church,  String assembly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberCard() when $default != null:
return $default(_that.username,_that.firstName,_that.lastName,_that.church,_that.assembly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String firstName,  String lastName,  String church,  String assembly)  $default,) {final _that = this;
switch (_that) {
case _MemberCard():
return $default(_that.username,_that.firstName,_that.lastName,_that.church,_that.assembly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String firstName,  String lastName,  String church,  String assembly)?  $default,) {final _that = this;
switch (_that) {
case _MemberCard() when $default != null:
return $default(_that.username,_that.firstName,_that.lastName,_that.church,_that.assembly);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberCard extends MemberCard {
  const _MemberCard({required this.username, required this.firstName, this.lastName = '', this.church = '', this.assembly = ''}): super._();
  factory _MemberCard.fromJson(Map<String, dynamic> json) => _$MemberCardFromJson(json);

@override final  String username;
@override final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String church;
@override@JsonKey() final  String assembly;

/// Create a copy of MemberCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberCardCopyWith<_MemberCard> get copyWith => __$MemberCardCopyWithImpl<_MemberCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberCard&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.church, church) || other.church == church)&&(identical(other.assembly, assembly) || other.assembly == assembly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,firstName,lastName,church,assembly);

@override
String toString() {
  return 'MemberCard(username: $username, firstName: $firstName, lastName: $lastName, church: $church, assembly: $assembly)';
}


}

/// @nodoc
abstract mixin class _$MemberCardCopyWith<$Res> implements $MemberCardCopyWith<$Res> {
  factory _$MemberCardCopyWith(_MemberCard value, $Res Function(_MemberCard) _then) = __$MemberCardCopyWithImpl;
@override @useResult
$Res call({
 String username, String firstName, String lastName, String church, String assembly
});




}
/// @nodoc
class __$MemberCardCopyWithImpl<$Res>
    implements _$MemberCardCopyWith<$Res> {
  __$MemberCardCopyWithImpl(this._self, this._then);

  final _MemberCard _self;
  final $Res Function(_MemberCard) _then;

/// Create a copy of MemberCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? firstName = null,Object? lastName = null,Object? church = null,Object? assembly = null,}) {
  return _then(_MemberCard(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,church: null == church ? _self.church : church // ignore: cast_nullable_to_non_nullable
as String,assembly: null == assembly ? _self.assembly : assembly // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UsernameCheck {

 String get username; bool get available;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) UsernameProblem? get problem; List<String> get suggestions;
/// Create a copy of UsernameCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsernameCheckCopyWith<UsernameCheck> get copyWith => _$UsernameCheckCopyWithImpl<UsernameCheck>(this as UsernameCheck, _$identity);

  /// Serializes this UsernameCheck to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsernameCheck&&(identical(other.username, username) || other.username == username)&&(identical(other.available, available) || other.available == available)&&(identical(other.problem, problem) || other.problem == problem)&&const DeepCollectionEquality().equals(other.suggestions, suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,available,problem,const DeepCollectionEquality().hash(suggestions));

@override
String toString() {
  return 'UsernameCheck(username: $username, available: $available, problem: $problem, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class $UsernameCheckCopyWith<$Res>  {
  factory $UsernameCheckCopyWith(UsernameCheck value, $Res Function(UsernameCheck) _then) = _$UsernameCheckCopyWithImpl;
@useResult
$Res call({
 String username, bool available,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) UsernameProblem? problem, List<String> suggestions
});




}
/// @nodoc
class _$UsernameCheckCopyWithImpl<$Res>
    implements $UsernameCheckCopyWith<$Res> {
  _$UsernameCheckCopyWithImpl(this._self, this._then);

  final UsernameCheck _self;
  final $Res Function(UsernameCheck) _then;

/// Create a copy of UsernameCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? available = null,Object? problem = freezed,Object? suggestions = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,problem: freezed == problem ? _self.problem : problem // ignore: cast_nullable_to_non_nullable
as UsernameProblem?,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [UsernameCheck].
extension UsernameCheckPatterns on UsernameCheck {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsernameCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsernameCheck() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsernameCheck value)  $default,){
final _that = this;
switch (_that) {
case _UsernameCheck():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsernameCheck value)?  $default,){
final _that = this;
switch (_that) {
case _UsernameCheck() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  bool available, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  UsernameProblem? problem,  List<String> suggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsernameCheck() when $default != null:
return $default(_that.username,_that.available,_that.problem,_that.suggestions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  bool available, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  UsernameProblem? problem,  List<String> suggestions)  $default,) {final _that = this;
switch (_that) {
case _UsernameCheck():
return $default(_that.username,_that.available,_that.problem,_that.suggestions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  bool available, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  UsernameProblem? problem,  List<String> suggestions)?  $default,) {final _that = this;
switch (_that) {
case _UsernameCheck() when $default != null:
return $default(_that.username,_that.available,_that.problem,_that.suggestions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsernameCheck implements UsernameCheck {
  const _UsernameCheck({this.username = '', this.available = false, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.problem, final  List<String> suggestions = const <String>[]}): _suggestions = suggestions;
  factory _UsernameCheck.fromJson(Map<String, dynamic> json) => _$UsernameCheckFromJson(json);

@override@JsonKey() final  String username;
@override@JsonKey() final  bool available;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  UsernameProblem? problem;
 final  List<String> _suggestions;
@override@JsonKey() List<String> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}


/// Create a copy of UsernameCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsernameCheckCopyWith<_UsernameCheck> get copyWith => __$UsernameCheckCopyWithImpl<_UsernameCheck>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsernameCheckToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsernameCheck&&(identical(other.username, username) || other.username == username)&&(identical(other.available, available) || other.available == available)&&(identical(other.problem, problem) || other.problem == problem)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,available,problem,const DeepCollectionEquality().hash(_suggestions));

@override
String toString() {
  return 'UsernameCheck(username: $username, available: $available, problem: $problem, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class _$UsernameCheckCopyWith<$Res> implements $UsernameCheckCopyWith<$Res> {
  factory _$UsernameCheckCopyWith(_UsernameCheck value, $Res Function(_UsernameCheck) _then) = __$UsernameCheckCopyWithImpl;
@override @useResult
$Res call({
 String username, bool available,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) UsernameProblem? problem, List<String> suggestions
});




}
/// @nodoc
class __$UsernameCheckCopyWithImpl<$Res>
    implements _$UsernameCheckCopyWith<$Res> {
  __$UsernameCheckCopyWithImpl(this._self, this._then);

  final _UsernameCheck _self;
  final $Res Function(_UsernameCheck) _then;

/// Create a copy of UsernameCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? available = null,Object? problem = freezed,Object? suggestions = null,}) {
  return _then(_UsernameCheck(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,problem: freezed == problem ? _self.problem : problem // ignore: cast_nullable_to_non_nullable
as UsernameProblem?,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
