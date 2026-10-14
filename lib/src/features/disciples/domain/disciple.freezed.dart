// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'disciple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Disciple {

 int get authorityId; MemberCard get member;/// Set by the disciple (on by default); off, [regularity] is null.
 bool get sharesRegularity; DiscipleRegularity? get regularity;
/// Create a copy of Disciple
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscipleCopyWith<Disciple> get copyWith => _$DiscipleCopyWithImpl<Disciple>(this as Disciple, _$identity);

  /// Serializes this Disciple to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Disciple&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.sharesRegularity, sharesRegularity) || other.sharesRegularity == sharesRegularity)&&(identical(other.regularity, regularity) || other.regularity == regularity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorityId,member,sharesRegularity,regularity);

@override
String toString() {
  return 'Disciple(authorityId: $authorityId, member: $member, sharesRegularity: $sharesRegularity, regularity: $regularity)';
}


}

/// @nodoc
abstract mixin class $DiscipleCopyWith<$Res>  {
  factory $DiscipleCopyWith(Disciple value, $Res Function(Disciple) _then) = _$DiscipleCopyWithImpl;
@useResult
$Res call({
 int authorityId, MemberCard member, bool sharesRegularity, DiscipleRegularity? regularity
});


$MemberCardCopyWith<$Res> get member;$DiscipleRegularityCopyWith<$Res>? get regularity;

}
/// @nodoc
class _$DiscipleCopyWithImpl<$Res>
    implements $DiscipleCopyWith<$Res> {
  _$DiscipleCopyWithImpl(this._self, this._then);

  final Disciple _self;
  final $Res Function(Disciple) _then;

/// Create a copy of Disciple
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authorityId = null,Object? member = null,Object? sharesRegularity = null,Object? regularity = freezed,}) {
  return _then(_self.copyWith(
authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,sharesRegularity: null == sharesRegularity ? _self.sharesRegularity : sharesRegularity // ignore: cast_nullable_to_non_nullable
as bool,regularity: freezed == regularity ? _self.regularity : regularity // ignore: cast_nullable_to_non_nullable
as DiscipleRegularity?,
  ));
}
/// Create a copy of Disciple
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get member {
  
  return $MemberCardCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}/// Create a copy of Disciple
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscipleRegularityCopyWith<$Res>? get regularity {
    if (_self.regularity == null) {
    return null;
  }

  return $DiscipleRegularityCopyWith<$Res>(_self.regularity!, (value) {
    return _then(_self.copyWith(regularity: value));
  });
}
}


/// Adds pattern-matching-related methods to [Disciple].
extension DisciplePatterns on Disciple {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Disciple value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Disciple() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Disciple value)  $default,){
final _that = this;
switch (_that) {
case _Disciple():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Disciple value)?  $default,){
final _that = this;
switch (_that) {
case _Disciple() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int authorityId,  MemberCard member,  bool sharesRegularity,  DiscipleRegularity? regularity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Disciple() when $default != null:
return $default(_that.authorityId,_that.member,_that.sharesRegularity,_that.regularity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int authorityId,  MemberCard member,  bool sharesRegularity,  DiscipleRegularity? regularity)  $default,) {final _that = this;
switch (_that) {
case _Disciple():
return $default(_that.authorityId,_that.member,_that.sharesRegularity,_that.regularity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int authorityId,  MemberCard member,  bool sharesRegularity,  DiscipleRegularity? regularity)?  $default,) {final _that = this;
switch (_that) {
case _Disciple() when $default != null:
return $default(_that.authorityId,_that.member,_that.sharesRegularity,_that.regularity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Disciple implements Disciple {
  const _Disciple({required this.authorityId, required this.member, this.sharesRegularity = true, this.regularity});
  factory _Disciple.fromJson(Map<String, dynamic> json) => _$DiscipleFromJson(json);

@override final  int authorityId;
@override final  MemberCard member;
/// Set by the disciple (on by default); off, [regularity] is null.
@override@JsonKey() final  bool sharesRegularity;
@override final  DiscipleRegularity? regularity;

/// Create a copy of Disciple
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscipleCopyWith<_Disciple> get copyWith => __$DiscipleCopyWithImpl<_Disciple>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscipleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Disciple&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.sharesRegularity, sharesRegularity) || other.sharesRegularity == sharesRegularity)&&(identical(other.regularity, regularity) || other.regularity == regularity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorityId,member,sharesRegularity,regularity);

@override
String toString() {
  return 'Disciple(authorityId: $authorityId, member: $member, sharesRegularity: $sharesRegularity, regularity: $regularity)';
}


}

/// @nodoc
abstract mixin class _$DiscipleCopyWith<$Res> implements $DiscipleCopyWith<$Res> {
  factory _$DiscipleCopyWith(_Disciple value, $Res Function(_Disciple) _then) = __$DiscipleCopyWithImpl;
@override @useResult
$Res call({
 int authorityId, MemberCard member, bool sharesRegularity, DiscipleRegularity? regularity
});


@override $MemberCardCopyWith<$Res> get member;@override $DiscipleRegularityCopyWith<$Res>? get regularity;

}
/// @nodoc
class __$DiscipleCopyWithImpl<$Res>
    implements _$DiscipleCopyWith<$Res> {
  __$DiscipleCopyWithImpl(this._self, this._then);

  final _Disciple _self;
  final $Res Function(_Disciple) _then;

/// Create a copy of Disciple
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authorityId = null,Object? member = null,Object? sharesRegularity = null,Object? regularity = freezed,}) {
  return _then(_Disciple(
authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,sharesRegularity: null == sharesRegularity ? _self.sharesRegularity : sharesRegularity // ignore: cast_nullable_to_non_nullable
as bool,regularity: freezed == regularity ? _self.regularity : regularity // ignore: cast_nullable_to_non_nullable
as DiscipleRegularity?,
  ));
}

/// Create a copy of Disciple
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get member {
  
  return $MemberCardCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}/// Create a copy of Disciple
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscipleRegularityCopyWith<$Res>? get regularity {
    if (_self.regularity == null) {
    return null;
  }

  return $DiscipleRegularityCopyWith<$Res>(_self.regularity!, (value) {
    return _then(_self.copyWith(regularity: value));
  });
}
}


/// @nodoc
mixin _$DiscipleRegularity {

/// Days in a row with a report, like the disciple's own streak.
 int get streak;/// The days with a report among the last 30, the newest first.
@ApiDateConverter() List<DateTime> get days; int get filledLast30;/// Their latest report this year, or null.
@ApiDateConverter() DateTime? get lastDay;/// The mean share of their goals reached over 30 days (0 to 100), null
/// without goals.
 int? get goalPercent;
/// Create a copy of DiscipleRegularity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscipleRegularityCopyWith<DiscipleRegularity> get copyWith => _$DiscipleRegularityCopyWithImpl<DiscipleRegularity>(this as DiscipleRegularity, _$identity);

  /// Serializes this DiscipleRegularity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscipleRegularity&&(identical(other.streak, streak) || other.streak == streak)&&const DeepCollectionEquality().equals(other.days, days)&&(identical(other.filledLast30, filledLast30) || other.filledLast30 == filledLast30)&&(identical(other.lastDay, lastDay) || other.lastDay == lastDay)&&(identical(other.goalPercent, goalPercent) || other.goalPercent == goalPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streak,const DeepCollectionEquality().hash(days),filledLast30,lastDay,goalPercent);

@override
String toString() {
  return 'DiscipleRegularity(streak: $streak, days: $days, filledLast30: $filledLast30, lastDay: $lastDay, goalPercent: $goalPercent)';
}


}

/// @nodoc
abstract mixin class $DiscipleRegularityCopyWith<$Res>  {
  factory $DiscipleRegularityCopyWith(DiscipleRegularity value, $Res Function(DiscipleRegularity) _then) = _$DiscipleRegularityCopyWithImpl;
@useResult
$Res call({
 int streak,@ApiDateConverter() List<DateTime> days, int filledLast30,@ApiDateConverter() DateTime? lastDay, int? goalPercent
});




}
/// @nodoc
class _$DiscipleRegularityCopyWithImpl<$Res>
    implements $DiscipleRegularityCopyWith<$Res> {
  _$DiscipleRegularityCopyWithImpl(this._self, this._then);

  final DiscipleRegularity _self;
  final $Res Function(DiscipleRegularity) _then;

/// Create a copy of DiscipleRegularity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streak = null,Object? days = null,Object? filledLast30 = null,Object? lastDay = freezed,Object? goalPercent = freezed,}) {
  return _then(_self.copyWith(
streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<DateTime>,filledLast30: null == filledLast30 ? _self.filledLast30 : filledLast30 // ignore: cast_nullable_to_non_nullable
as int,lastDay: freezed == lastDay ? _self.lastDay : lastDay // ignore: cast_nullable_to_non_nullable
as DateTime?,goalPercent: freezed == goalPercent ? _self.goalPercent : goalPercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DiscipleRegularity].
extension DiscipleRegularityPatterns on DiscipleRegularity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscipleRegularity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscipleRegularity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscipleRegularity value)  $default,){
final _that = this;
switch (_that) {
case _DiscipleRegularity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscipleRegularity value)?  $default,){
final _that = this;
switch (_that) {
case _DiscipleRegularity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int streak, @ApiDateConverter()  List<DateTime> days,  int filledLast30, @ApiDateConverter()  DateTime? lastDay,  int? goalPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscipleRegularity() when $default != null:
return $default(_that.streak,_that.days,_that.filledLast30,_that.lastDay,_that.goalPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int streak, @ApiDateConverter()  List<DateTime> days,  int filledLast30, @ApiDateConverter()  DateTime? lastDay,  int? goalPercent)  $default,) {final _that = this;
switch (_that) {
case _DiscipleRegularity():
return $default(_that.streak,_that.days,_that.filledLast30,_that.lastDay,_that.goalPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int streak, @ApiDateConverter()  List<DateTime> days,  int filledLast30, @ApiDateConverter()  DateTime? lastDay,  int? goalPercent)?  $default,) {final _that = this;
switch (_that) {
case _DiscipleRegularity() when $default != null:
return $default(_that.streak,_that.days,_that.filledLast30,_that.lastDay,_that.goalPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiscipleRegularity implements DiscipleRegularity {
  const _DiscipleRegularity({this.streak = 0, @ApiDateConverter() final  List<DateTime> days = const <DateTime>[], this.filledLast30 = 0, @ApiDateConverter() this.lastDay, this.goalPercent}): _days = days;
  factory _DiscipleRegularity.fromJson(Map<String, dynamic> json) => _$DiscipleRegularityFromJson(json);

/// Days in a row with a report, like the disciple's own streak.
@override@JsonKey() final  int streak;
/// The days with a report among the last 30, the newest first.
 final  List<DateTime> _days;
/// The days with a report among the last 30, the newest first.
@override@JsonKey()@ApiDateConverter() List<DateTime> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

@override@JsonKey() final  int filledLast30;
/// Their latest report this year, or null.
@override@ApiDateConverter() final  DateTime? lastDay;
/// The mean share of their goals reached over 30 days (0 to 100), null
/// without goals.
@override final  int? goalPercent;

/// Create a copy of DiscipleRegularity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscipleRegularityCopyWith<_DiscipleRegularity> get copyWith => __$DiscipleRegularityCopyWithImpl<_DiscipleRegularity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscipleRegularityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscipleRegularity&&(identical(other.streak, streak) || other.streak == streak)&&const DeepCollectionEquality().equals(other._days, _days)&&(identical(other.filledLast30, filledLast30) || other.filledLast30 == filledLast30)&&(identical(other.lastDay, lastDay) || other.lastDay == lastDay)&&(identical(other.goalPercent, goalPercent) || other.goalPercent == goalPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streak,const DeepCollectionEquality().hash(_days),filledLast30,lastDay,goalPercent);

@override
String toString() {
  return 'DiscipleRegularity(streak: $streak, days: $days, filledLast30: $filledLast30, lastDay: $lastDay, goalPercent: $goalPercent)';
}


}

/// @nodoc
abstract mixin class _$DiscipleRegularityCopyWith<$Res> implements $DiscipleRegularityCopyWith<$Res> {
  factory _$DiscipleRegularityCopyWith(_DiscipleRegularity value, $Res Function(_DiscipleRegularity) _then) = __$DiscipleRegularityCopyWithImpl;
@override @useResult
$Res call({
 int streak,@ApiDateConverter() List<DateTime> days, int filledLast30,@ApiDateConverter() DateTime? lastDay, int? goalPercent
});




}
/// @nodoc
class __$DiscipleRegularityCopyWithImpl<$Res>
    implements _$DiscipleRegularityCopyWith<$Res> {
  __$DiscipleRegularityCopyWithImpl(this._self, this._then);

  final _DiscipleRegularity _self;
  final $Res Function(_DiscipleRegularity) _then;

/// Create a copy of DiscipleRegularity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streak = null,Object? days = null,Object? filledLast30 = null,Object? lastDay = freezed,Object? goalPercent = freezed,}) {
  return _then(_DiscipleRegularity(
streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<DateTime>,filledLast30: null == filledLast30 ? _self.filledLast30 : filledLast30 // ignore: cast_nullable_to_non_nullable
as int,lastDay: freezed == lastDay ? _self.lastDay : lastDay // ignore: cast_nullable_to_non_nullable
as DateTime?,goalPercent: freezed == goalPercent ? _self.goalPercent : goalPercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
