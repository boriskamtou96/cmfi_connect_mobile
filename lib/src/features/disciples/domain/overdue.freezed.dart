// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overdue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Overdue {

/// The threshold asked: no report for this many days.
 int get days;/// How many disciples share their reports.
 int get sharing;/// How many don't: nothing is known about them.
 int get notSharing; List<OverdueDisciple> get overdue;
/// Create a copy of Overdue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverdueCopyWith<Overdue> get copyWith => _$OverdueCopyWithImpl<Overdue>(this as Overdue, _$identity);

  /// Serializes this Overdue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Overdue&&(identical(other.days, days) || other.days == days)&&(identical(other.sharing, sharing) || other.sharing == sharing)&&(identical(other.notSharing, notSharing) || other.notSharing == notSharing)&&const DeepCollectionEquality().equals(other.overdue, overdue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,days,sharing,notSharing,const DeepCollectionEquality().hash(overdue));

@override
String toString() {
  return 'Overdue(days: $days, sharing: $sharing, notSharing: $notSharing, overdue: $overdue)';
}


}

/// @nodoc
abstract mixin class $OverdueCopyWith<$Res>  {
  factory $OverdueCopyWith(Overdue value, $Res Function(Overdue) _then) = _$OverdueCopyWithImpl;
@useResult
$Res call({
 int days, int sharing, int notSharing, List<OverdueDisciple> overdue
});




}
/// @nodoc
class _$OverdueCopyWithImpl<$Res>
    implements $OverdueCopyWith<$Res> {
  _$OverdueCopyWithImpl(this._self, this._then);

  final Overdue _self;
  final $Res Function(Overdue) _then;

/// Create a copy of Overdue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,Object? sharing = null,Object? notSharing = null,Object? overdue = null,}) {
  return _then(_self.copyWith(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,sharing: null == sharing ? _self.sharing : sharing // ignore: cast_nullable_to_non_nullable
as int,notSharing: null == notSharing ? _self.notSharing : notSharing // ignore: cast_nullable_to_non_nullable
as int,overdue: null == overdue ? _self.overdue : overdue // ignore: cast_nullable_to_non_nullable
as List<OverdueDisciple>,
  ));
}

}


/// Adds pattern-matching-related methods to [Overdue].
extension OverduePatterns on Overdue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Overdue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Overdue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Overdue value)  $default,){
final _that = this;
switch (_that) {
case _Overdue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Overdue value)?  $default,){
final _that = this;
switch (_that) {
case _Overdue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int days,  int sharing,  int notSharing,  List<OverdueDisciple> overdue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Overdue() when $default != null:
return $default(_that.days,_that.sharing,_that.notSharing,_that.overdue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int days,  int sharing,  int notSharing,  List<OverdueDisciple> overdue)  $default,) {final _that = this;
switch (_that) {
case _Overdue():
return $default(_that.days,_that.sharing,_that.notSharing,_that.overdue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int days,  int sharing,  int notSharing,  List<OverdueDisciple> overdue)?  $default,) {final _that = this;
switch (_that) {
case _Overdue() when $default != null:
return $default(_that.days,_that.sharing,_that.notSharing,_that.overdue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Overdue implements Overdue {
  const _Overdue({this.days = 3, this.sharing = 0, this.notSharing = 0, final  List<OverdueDisciple> overdue = const <OverdueDisciple>[]}): _overdue = overdue;
  factory _Overdue.fromJson(Map<String, dynamic> json) => _$OverdueFromJson(json);

/// The threshold asked: no report for this many days.
@override@JsonKey() final  int days;
/// How many disciples share their reports.
@override@JsonKey() final  int sharing;
/// How many don't: nothing is known about them.
@override@JsonKey() final  int notSharing;
 final  List<OverdueDisciple> _overdue;
@override@JsonKey() List<OverdueDisciple> get overdue {
  if (_overdue is EqualUnmodifiableListView) return _overdue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_overdue);
}


/// Create a copy of Overdue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverdueCopyWith<_Overdue> get copyWith => __$OverdueCopyWithImpl<_Overdue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverdueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Overdue&&(identical(other.days, days) || other.days == days)&&(identical(other.sharing, sharing) || other.sharing == sharing)&&(identical(other.notSharing, notSharing) || other.notSharing == notSharing)&&const DeepCollectionEquality().equals(other._overdue, _overdue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,days,sharing,notSharing,const DeepCollectionEquality().hash(_overdue));

@override
String toString() {
  return 'Overdue(days: $days, sharing: $sharing, notSharing: $notSharing, overdue: $overdue)';
}


}

/// @nodoc
abstract mixin class _$OverdueCopyWith<$Res> implements $OverdueCopyWith<$Res> {
  factory _$OverdueCopyWith(_Overdue value, $Res Function(_Overdue) _then) = __$OverdueCopyWithImpl;
@override @useResult
$Res call({
 int days, int sharing, int notSharing, List<OverdueDisciple> overdue
});




}
/// @nodoc
class __$OverdueCopyWithImpl<$Res>
    implements _$OverdueCopyWith<$Res> {
  __$OverdueCopyWithImpl(this._self, this._then);

  final _Overdue _self;
  final $Res Function(_Overdue) _then;

/// Create a copy of Overdue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,Object? sharing = null,Object? notSharing = null,Object? overdue = null,}) {
  return _then(_Overdue(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,sharing: null == sharing ? _self.sharing : sharing // ignore: cast_nullable_to_non_nullable
as int,notSharing: null == notSharing ? _self.notSharing : notSharing // ignore: cast_nullable_to_non_nullable
as int,overdue: null == overdue ? _self._overdue : overdue // ignore: cast_nullable_to_non_nullable
as List<OverdueDisciple>,
  ));
}


}


/// @nodoc
mixin _$OverdueDisciple {

 int get authorityId; MemberCard get member; bool get isDiscipleMaker;/// Their latest report, null when they never filled one.
@ApiDateConverter() DateTime? get lastDay;/// The days since [lastDay], null without one.
 int? get daysSince;/// Whether a reminder can go now: none in the last 24 hours.
 bool get canNudge;
/// Create a copy of OverdueDisciple
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverdueDiscipleCopyWith<OverdueDisciple> get copyWith => _$OverdueDiscipleCopyWithImpl<OverdueDisciple>(this as OverdueDisciple, _$identity);

  /// Serializes this OverdueDisciple to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverdueDisciple&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker)&&(identical(other.lastDay, lastDay) || other.lastDay == lastDay)&&(identical(other.daysSince, daysSince) || other.daysSince == daysSince)&&(identical(other.canNudge, canNudge) || other.canNudge == canNudge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorityId,member,isDiscipleMaker,lastDay,daysSince,canNudge);

@override
String toString() {
  return 'OverdueDisciple(authorityId: $authorityId, member: $member, isDiscipleMaker: $isDiscipleMaker, lastDay: $lastDay, daysSince: $daysSince, canNudge: $canNudge)';
}


}

/// @nodoc
abstract mixin class $OverdueDiscipleCopyWith<$Res>  {
  factory $OverdueDiscipleCopyWith(OverdueDisciple value, $Res Function(OverdueDisciple) _then) = _$OverdueDiscipleCopyWithImpl;
@useResult
$Res call({
 int authorityId, MemberCard member, bool isDiscipleMaker,@ApiDateConverter() DateTime? lastDay, int? daysSince, bool canNudge
});


$MemberCardCopyWith<$Res> get member;

}
/// @nodoc
class _$OverdueDiscipleCopyWithImpl<$Res>
    implements $OverdueDiscipleCopyWith<$Res> {
  _$OverdueDiscipleCopyWithImpl(this._self, this._then);

  final OverdueDisciple _self;
  final $Res Function(OverdueDisciple) _then;

/// Create a copy of OverdueDisciple
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authorityId = null,Object? member = null,Object? isDiscipleMaker = null,Object? lastDay = freezed,Object? daysSince = freezed,Object? canNudge = null,}) {
  return _then(_self.copyWith(
authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,lastDay: freezed == lastDay ? _self.lastDay : lastDay // ignore: cast_nullable_to_non_nullable
as DateTime?,daysSince: freezed == daysSince ? _self.daysSince : daysSince // ignore: cast_nullable_to_non_nullable
as int?,canNudge: null == canNudge ? _self.canNudge : canNudge // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of OverdueDisciple
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get member {
  
  return $MemberCardCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// Adds pattern-matching-related methods to [OverdueDisciple].
extension OverdueDisciplePatterns on OverdueDisciple {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverdueDisciple value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverdueDisciple() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverdueDisciple value)  $default,){
final _that = this;
switch (_that) {
case _OverdueDisciple():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverdueDisciple value)?  $default,){
final _that = this;
switch (_that) {
case _OverdueDisciple() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int authorityId,  MemberCard member,  bool isDiscipleMaker, @ApiDateConverter()  DateTime? lastDay,  int? daysSince,  bool canNudge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverdueDisciple() when $default != null:
return $default(_that.authorityId,_that.member,_that.isDiscipleMaker,_that.lastDay,_that.daysSince,_that.canNudge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int authorityId,  MemberCard member,  bool isDiscipleMaker, @ApiDateConverter()  DateTime? lastDay,  int? daysSince,  bool canNudge)  $default,) {final _that = this;
switch (_that) {
case _OverdueDisciple():
return $default(_that.authorityId,_that.member,_that.isDiscipleMaker,_that.lastDay,_that.daysSince,_that.canNudge);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int authorityId,  MemberCard member,  bool isDiscipleMaker, @ApiDateConverter()  DateTime? lastDay,  int? daysSince,  bool canNudge)?  $default,) {final _that = this;
switch (_that) {
case _OverdueDisciple() when $default != null:
return $default(_that.authorityId,_that.member,_that.isDiscipleMaker,_that.lastDay,_that.daysSince,_that.canNudge);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OverdueDisciple implements OverdueDisciple {
  const _OverdueDisciple({required this.authorityId, required this.member, this.isDiscipleMaker = true, @ApiDateConverter() this.lastDay, this.daysSince, this.canNudge = true});
  factory _OverdueDisciple.fromJson(Map<String, dynamic> json) => _$OverdueDiscipleFromJson(json);

@override final  int authorityId;
@override final  MemberCard member;
@override@JsonKey() final  bool isDiscipleMaker;
/// Their latest report, null when they never filled one.
@override@ApiDateConverter() final  DateTime? lastDay;
/// The days since [lastDay], null without one.
@override final  int? daysSince;
/// Whether a reminder can go now: none in the last 24 hours.
@override@JsonKey() final  bool canNudge;

/// Create a copy of OverdueDisciple
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverdueDiscipleCopyWith<_OverdueDisciple> get copyWith => __$OverdueDiscipleCopyWithImpl<_OverdueDisciple>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverdueDiscipleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverdueDisciple&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker)&&(identical(other.lastDay, lastDay) || other.lastDay == lastDay)&&(identical(other.daysSince, daysSince) || other.daysSince == daysSince)&&(identical(other.canNudge, canNudge) || other.canNudge == canNudge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorityId,member,isDiscipleMaker,lastDay,daysSince,canNudge);

@override
String toString() {
  return 'OverdueDisciple(authorityId: $authorityId, member: $member, isDiscipleMaker: $isDiscipleMaker, lastDay: $lastDay, daysSince: $daysSince, canNudge: $canNudge)';
}


}

/// @nodoc
abstract mixin class _$OverdueDiscipleCopyWith<$Res> implements $OverdueDiscipleCopyWith<$Res> {
  factory _$OverdueDiscipleCopyWith(_OverdueDisciple value, $Res Function(_OverdueDisciple) _then) = __$OverdueDiscipleCopyWithImpl;
@override @useResult
$Res call({
 int authorityId, MemberCard member, bool isDiscipleMaker,@ApiDateConverter() DateTime? lastDay, int? daysSince, bool canNudge
});


@override $MemberCardCopyWith<$Res> get member;

}
/// @nodoc
class __$OverdueDiscipleCopyWithImpl<$Res>
    implements _$OverdueDiscipleCopyWith<$Res> {
  __$OverdueDiscipleCopyWithImpl(this._self, this._then);

  final _OverdueDisciple _self;
  final $Res Function(_OverdueDisciple) _then;

/// Create a copy of OverdueDisciple
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authorityId = null,Object? member = null,Object? isDiscipleMaker = null,Object? lastDay = freezed,Object? daysSince = freezed,Object? canNudge = null,}) {
  return _then(_OverdueDisciple(
authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,lastDay: freezed == lastDay ? _self.lastDay : lastDay // ignore: cast_nullable_to_non_nullable
as DateTime?,daysSince: freezed == daysSince ? _self.daysSince : daysSince // ignore: cast_nullable_to_non_nullable
as int?,canNudge: null == canNudge ? _self.canNudge : canNudge // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of OverdueDisciple
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get member {
  
  return $MemberCardCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}

// dart format on
