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

 int get authorityId; MemberCard get member;/// The user is their disciple maker (else one of their authorities).
 bool get isDiscipleMaker;/// Set by the disciple (on by default); off, [regularity] is null and
/// their reports can't be read.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Disciple&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker)&&(identical(other.sharesRegularity, sharesRegularity) || other.sharesRegularity == sharesRegularity)&&(identical(other.regularity, regularity) || other.regularity == regularity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorityId,member,isDiscipleMaker,sharesRegularity,regularity);

@override
String toString() {
  return 'Disciple(authorityId: $authorityId, member: $member, isDiscipleMaker: $isDiscipleMaker, sharesRegularity: $sharesRegularity, regularity: $regularity)';
}


}

/// @nodoc
abstract mixin class $DiscipleCopyWith<$Res>  {
  factory $DiscipleCopyWith(Disciple value, $Res Function(Disciple) _then) = _$DiscipleCopyWithImpl;
@useResult
$Res call({
 int authorityId, MemberCard member, bool isDiscipleMaker, bool sharesRegularity, DiscipleRegularity? regularity
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
@pragma('vm:prefer-inline') @override $Res call({Object? authorityId = null,Object? member = null,Object? isDiscipleMaker = null,Object? sharesRegularity = null,Object? regularity = freezed,}) {
  return _then(_self.copyWith(
authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,sharesRegularity: null == sharesRegularity ? _self.sharesRegularity : sharesRegularity // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int authorityId,  MemberCard member,  bool isDiscipleMaker,  bool sharesRegularity,  DiscipleRegularity? regularity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Disciple() when $default != null:
return $default(_that.authorityId,_that.member,_that.isDiscipleMaker,_that.sharesRegularity,_that.regularity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int authorityId,  MemberCard member,  bool isDiscipleMaker,  bool sharesRegularity,  DiscipleRegularity? regularity)  $default,) {final _that = this;
switch (_that) {
case _Disciple():
return $default(_that.authorityId,_that.member,_that.isDiscipleMaker,_that.sharesRegularity,_that.regularity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int authorityId,  MemberCard member,  bool isDiscipleMaker,  bool sharesRegularity,  DiscipleRegularity? regularity)?  $default,) {final _that = this;
switch (_that) {
case _Disciple() when $default != null:
return $default(_that.authorityId,_that.member,_that.isDiscipleMaker,_that.sharesRegularity,_that.regularity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Disciple implements Disciple {
  const _Disciple({required this.authorityId, required this.member, this.isDiscipleMaker = true, this.sharesRegularity = true, this.regularity});
  factory _Disciple.fromJson(Map<String, dynamic> json) => _$DiscipleFromJson(json);

@override final  int authorityId;
@override final  MemberCard member;
/// The user is their disciple maker (else one of their authorities).
@override@JsonKey() final  bool isDiscipleMaker;
/// Set by the disciple (on by default); off, [regularity] is null and
/// their reports can't be read.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Disciple&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker)&&(identical(other.sharesRegularity, sharesRegularity) || other.sharesRegularity == sharesRegularity)&&(identical(other.regularity, regularity) || other.regularity == regularity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorityId,member,isDiscipleMaker,sharesRegularity,regularity);

@override
String toString() {
  return 'Disciple(authorityId: $authorityId, member: $member, isDiscipleMaker: $isDiscipleMaker, sharesRegularity: $sharesRegularity, regularity: $regularity)';
}


}

/// @nodoc
abstract mixin class _$DiscipleCopyWith<$Res> implements $DiscipleCopyWith<$Res> {
  factory _$DiscipleCopyWith(_Disciple value, $Res Function(_Disciple) _then) = __$DiscipleCopyWithImpl;
@override @useResult
$Res call({
 int authorityId, MemberCard member, bool isDiscipleMaker, bool sharesRegularity, DiscipleRegularity? regularity
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
@override @pragma('vm:prefer-inline') $Res call({Object? authorityId = null,Object? member = null,Object? isDiscipleMaker = null,Object? sharesRegularity = null,Object? regularity = freezed,}) {
  return _then(_Disciple(
authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,sharesRegularity: null == sharesRegularity ? _self.sharesRegularity : sharesRegularity // ignore: cast_nullable_to_non_nullable
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
 int? get goalPercent;/// The mean share of their items filled on the days with a report (0 to
/// 100), null without report.
 int? get itemsPercent;
/// Create a copy of DiscipleRegularity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscipleRegularityCopyWith<DiscipleRegularity> get copyWith => _$DiscipleRegularityCopyWithImpl<DiscipleRegularity>(this as DiscipleRegularity, _$identity);

  /// Serializes this DiscipleRegularity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscipleRegularity&&(identical(other.streak, streak) || other.streak == streak)&&const DeepCollectionEquality().equals(other.days, days)&&(identical(other.filledLast30, filledLast30) || other.filledLast30 == filledLast30)&&(identical(other.lastDay, lastDay) || other.lastDay == lastDay)&&(identical(other.goalPercent, goalPercent) || other.goalPercent == goalPercent)&&(identical(other.itemsPercent, itemsPercent) || other.itemsPercent == itemsPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streak,const DeepCollectionEquality().hash(days),filledLast30,lastDay,goalPercent,itemsPercent);

@override
String toString() {
  return 'DiscipleRegularity(streak: $streak, days: $days, filledLast30: $filledLast30, lastDay: $lastDay, goalPercent: $goalPercent, itemsPercent: $itemsPercent)';
}


}

/// @nodoc
abstract mixin class $DiscipleRegularityCopyWith<$Res>  {
  factory $DiscipleRegularityCopyWith(DiscipleRegularity value, $Res Function(DiscipleRegularity) _then) = _$DiscipleRegularityCopyWithImpl;
@useResult
$Res call({
 int streak,@ApiDateConverter() List<DateTime> days, int filledLast30,@ApiDateConverter() DateTime? lastDay, int? goalPercent, int? itemsPercent
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
@pragma('vm:prefer-inline') @override $Res call({Object? streak = null,Object? days = null,Object? filledLast30 = null,Object? lastDay = freezed,Object? goalPercent = freezed,Object? itemsPercent = freezed,}) {
  return _then(_self.copyWith(
streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<DateTime>,filledLast30: null == filledLast30 ? _self.filledLast30 : filledLast30 // ignore: cast_nullable_to_non_nullable
as int,lastDay: freezed == lastDay ? _self.lastDay : lastDay // ignore: cast_nullable_to_non_nullable
as DateTime?,goalPercent: freezed == goalPercent ? _self.goalPercent : goalPercent // ignore: cast_nullable_to_non_nullable
as int?,itemsPercent: freezed == itemsPercent ? _self.itemsPercent : itemsPercent // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int streak, @ApiDateConverter()  List<DateTime> days,  int filledLast30, @ApiDateConverter()  DateTime? lastDay,  int? goalPercent,  int? itemsPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscipleRegularity() when $default != null:
return $default(_that.streak,_that.days,_that.filledLast30,_that.lastDay,_that.goalPercent,_that.itemsPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int streak, @ApiDateConverter()  List<DateTime> days,  int filledLast30, @ApiDateConverter()  DateTime? lastDay,  int? goalPercent,  int? itemsPercent)  $default,) {final _that = this;
switch (_that) {
case _DiscipleRegularity():
return $default(_that.streak,_that.days,_that.filledLast30,_that.lastDay,_that.goalPercent,_that.itemsPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int streak, @ApiDateConverter()  List<DateTime> days,  int filledLast30, @ApiDateConverter()  DateTime? lastDay,  int? goalPercent,  int? itemsPercent)?  $default,) {final _that = this;
switch (_that) {
case _DiscipleRegularity() when $default != null:
return $default(_that.streak,_that.days,_that.filledLast30,_that.lastDay,_that.goalPercent,_that.itemsPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiscipleRegularity implements DiscipleRegularity {
  const _DiscipleRegularity({this.streak = 0, @ApiDateConverter() final  List<DateTime> days = const <DateTime>[], this.filledLast30 = 0, @ApiDateConverter() this.lastDay, this.goalPercent, this.itemsPercent}): _days = days;
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
/// The mean share of their items filled on the days with a report (0 to
/// 100), null without report.
@override final  int? itemsPercent;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscipleRegularity&&(identical(other.streak, streak) || other.streak == streak)&&const DeepCollectionEquality().equals(other._days, _days)&&(identical(other.filledLast30, filledLast30) || other.filledLast30 == filledLast30)&&(identical(other.lastDay, lastDay) || other.lastDay == lastDay)&&(identical(other.goalPercent, goalPercent) || other.goalPercent == goalPercent)&&(identical(other.itemsPercent, itemsPercent) || other.itemsPercent == itemsPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streak,const DeepCollectionEquality().hash(_days),filledLast30,lastDay,goalPercent,itemsPercent);

@override
String toString() {
  return 'DiscipleRegularity(streak: $streak, days: $days, filledLast30: $filledLast30, lastDay: $lastDay, goalPercent: $goalPercent, itemsPercent: $itemsPercent)';
}


}

/// @nodoc
abstract mixin class _$DiscipleRegularityCopyWith<$Res> implements $DiscipleRegularityCopyWith<$Res> {
  factory _$DiscipleRegularityCopyWith(_DiscipleRegularity value, $Res Function(_DiscipleRegularity) _then) = __$DiscipleRegularityCopyWithImpl;
@override @useResult
$Res call({
 int streak,@ApiDateConverter() List<DateTime> days, int filledLast30,@ApiDateConverter() DateTime? lastDay, int? goalPercent, int? itemsPercent
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
@override @pragma('vm:prefer-inline') $Res call({Object? streak = null,Object? days = null,Object? filledLast30 = null,Object? lastDay = freezed,Object? goalPercent = freezed,Object? itemsPercent = freezed,}) {
  return _then(_DiscipleRegularity(
streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<DateTime>,filledLast30: null == filledLast30 ? _self.filledLast30 : filledLast30 // ignore: cast_nullable_to_non_nullable
as int,lastDay: freezed == lastDay ? _self.lastDay : lastDay // ignore: cast_nullable_to_non_nullable
as DateTime?,goalPercent: freezed == goalPercent ? _self.goalPercent : goalPercent // ignore: cast_nullable_to_non_nullable
as int?,itemsPercent: freezed == itemsPercent ? _self.itemsPercent : itemsPercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DiscipleReports {

 int get authorityId; MemberCard get member; bool get isDiscipleMaker;/// The items they have now (standard and their own).
 int get totalItems; List<DiscipleDay> get days;
/// Create a copy of DiscipleReports
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscipleReportsCopyWith<DiscipleReports> get copyWith => _$DiscipleReportsCopyWithImpl<DiscipleReports>(this as DiscipleReports, _$identity);

  /// Serializes this DiscipleReports to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscipleReports&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorityId,member,isDiscipleMaker,totalItems,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'DiscipleReports(authorityId: $authorityId, member: $member, isDiscipleMaker: $isDiscipleMaker, totalItems: $totalItems, days: $days)';
}


}

/// @nodoc
abstract mixin class $DiscipleReportsCopyWith<$Res>  {
  factory $DiscipleReportsCopyWith(DiscipleReports value, $Res Function(DiscipleReports) _then) = _$DiscipleReportsCopyWithImpl;
@useResult
$Res call({
 int authorityId, MemberCard member, bool isDiscipleMaker, int totalItems, List<DiscipleDay> days
});


$MemberCardCopyWith<$Res> get member;

}
/// @nodoc
class _$DiscipleReportsCopyWithImpl<$Res>
    implements $DiscipleReportsCopyWith<$Res> {
  _$DiscipleReportsCopyWithImpl(this._self, this._then);

  final DiscipleReports _self;
  final $Res Function(DiscipleReports) _then;

/// Create a copy of DiscipleReports
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authorityId = null,Object? member = null,Object? isDiscipleMaker = null,Object? totalItems = null,Object? days = null,}) {
  return _then(_self.copyWith(
authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<DiscipleDay>,
  ));
}
/// Create a copy of DiscipleReports
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get member {
  
  return $MemberCardCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// Adds pattern-matching-related methods to [DiscipleReports].
extension DiscipleReportsPatterns on DiscipleReports {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscipleReports value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscipleReports() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscipleReports value)  $default,){
final _that = this;
switch (_that) {
case _DiscipleReports():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscipleReports value)?  $default,){
final _that = this;
switch (_that) {
case _DiscipleReports() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int authorityId,  MemberCard member,  bool isDiscipleMaker,  int totalItems,  List<DiscipleDay> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscipleReports() when $default != null:
return $default(_that.authorityId,_that.member,_that.isDiscipleMaker,_that.totalItems,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int authorityId,  MemberCard member,  bool isDiscipleMaker,  int totalItems,  List<DiscipleDay> days)  $default,) {final _that = this;
switch (_that) {
case _DiscipleReports():
return $default(_that.authorityId,_that.member,_that.isDiscipleMaker,_that.totalItems,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int authorityId,  MemberCard member,  bool isDiscipleMaker,  int totalItems,  List<DiscipleDay> days)?  $default,) {final _that = this;
switch (_that) {
case _DiscipleReports() when $default != null:
return $default(_that.authorityId,_that.member,_that.isDiscipleMaker,_that.totalItems,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiscipleReports implements DiscipleReports {
  const _DiscipleReports({required this.authorityId, required this.member, this.isDiscipleMaker = true, this.totalItems = 0, final  List<DiscipleDay> days = const <DiscipleDay>[]}): _days = days;
  factory _DiscipleReports.fromJson(Map<String, dynamic> json) => _$DiscipleReportsFromJson(json);

@override final  int authorityId;
@override final  MemberCard member;
@override@JsonKey() final  bool isDiscipleMaker;
/// The items they have now (standard and their own).
@override@JsonKey() final  int totalItems;
 final  List<DiscipleDay> _days;
@override@JsonKey() List<DiscipleDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of DiscipleReports
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscipleReportsCopyWith<_DiscipleReports> get copyWith => __$DiscipleReportsCopyWithImpl<_DiscipleReports>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscipleReportsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscipleReports&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.isDiscipleMaker, isDiscipleMaker) || other.isDiscipleMaker == isDiscipleMaker)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorityId,member,isDiscipleMaker,totalItems,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'DiscipleReports(authorityId: $authorityId, member: $member, isDiscipleMaker: $isDiscipleMaker, totalItems: $totalItems, days: $days)';
}


}

/// @nodoc
abstract mixin class _$DiscipleReportsCopyWith<$Res> implements $DiscipleReportsCopyWith<$Res> {
  factory _$DiscipleReportsCopyWith(_DiscipleReports value, $Res Function(_DiscipleReports) _then) = __$DiscipleReportsCopyWithImpl;
@override @useResult
$Res call({
 int authorityId, MemberCard member, bool isDiscipleMaker, int totalItems, List<DiscipleDay> days
});


@override $MemberCardCopyWith<$Res> get member;

}
/// @nodoc
class __$DiscipleReportsCopyWithImpl<$Res>
    implements _$DiscipleReportsCopyWith<$Res> {
  __$DiscipleReportsCopyWithImpl(this._self, this._then);

  final _DiscipleReports _self;
  final $Res Function(_DiscipleReports) _then;

/// Create a copy of DiscipleReports
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authorityId = null,Object? member = null,Object? isDiscipleMaker = null,Object? totalItems = null,Object? days = null,}) {
  return _then(_DiscipleReports(
authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,isDiscipleMaker: null == isDiscipleMaker ? _self.isDiscipleMaker : isDiscipleMaker // ignore: cast_nullable_to_non_nullable
as bool,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<DiscipleDay>,
  ));
}

/// Create a copy of DiscipleReports
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get member {
  
  return $MemberCardCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// @nodoc
mixin _$DiscipleDay {

@ApiDateConverter() DateTime get date;/// The share of the day's goals reached (0 to 100), null without goals.
 int? get goalPercent; int get filled; int get total; int get itemsPercent; List<DiscipleEntry> get entries;
/// Create a copy of DiscipleDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscipleDayCopyWith<DiscipleDay> get copyWith => _$DiscipleDayCopyWithImpl<DiscipleDay>(this as DiscipleDay, _$identity);

  /// Serializes this DiscipleDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscipleDay&&(identical(other.date, date) || other.date == date)&&(identical(other.goalPercent, goalPercent) || other.goalPercent == goalPercent)&&(identical(other.filled, filled) || other.filled == filled)&&(identical(other.total, total) || other.total == total)&&(identical(other.itemsPercent, itemsPercent) || other.itemsPercent == itemsPercent)&&const DeepCollectionEquality().equals(other.entries, entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,goalPercent,filled,total,itemsPercent,const DeepCollectionEquality().hash(entries));

@override
String toString() {
  return 'DiscipleDay(date: $date, goalPercent: $goalPercent, filled: $filled, total: $total, itemsPercent: $itemsPercent, entries: $entries)';
}


}

/// @nodoc
abstract mixin class $DiscipleDayCopyWith<$Res>  {
  factory $DiscipleDayCopyWith(DiscipleDay value, $Res Function(DiscipleDay) _then) = _$DiscipleDayCopyWithImpl;
@useResult
$Res call({
@ApiDateConverter() DateTime date, int? goalPercent, int filled, int total, int itemsPercent, List<DiscipleEntry> entries
});




}
/// @nodoc
class _$DiscipleDayCopyWithImpl<$Res>
    implements $DiscipleDayCopyWith<$Res> {
  _$DiscipleDayCopyWithImpl(this._self, this._then);

  final DiscipleDay _self;
  final $Res Function(DiscipleDay) _then;

/// Create a copy of DiscipleDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? goalPercent = freezed,Object? filled = null,Object? total = null,Object? itemsPercent = null,Object? entries = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,goalPercent: freezed == goalPercent ? _self.goalPercent : goalPercent // ignore: cast_nullable_to_non_nullable
as int?,filled: null == filled ? _self.filled : filled // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,itemsPercent: null == itemsPercent ? _self.itemsPercent : itemsPercent // ignore: cast_nullable_to_non_nullable
as int,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<DiscipleEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [DiscipleDay].
extension DiscipleDayPatterns on DiscipleDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscipleDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscipleDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscipleDay value)  $default,){
final _that = this;
switch (_that) {
case _DiscipleDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscipleDay value)?  $default,){
final _that = this;
switch (_that) {
case _DiscipleDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ApiDateConverter()  DateTime date,  int? goalPercent,  int filled,  int total,  int itemsPercent,  List<DiscipleEntry> entries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscipleDay() when $default != null:
return $default(_that.date,_that.goalPercent,_that.filled,_that.total,_that.itemsPercent,_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ApiDateConverter()  DateTime date,  int? goalPercent,  int filled,  int total,  int itemsPercent,  List<DiscipleEntry> entries)  $default,) {final _that = this;
switch (_that) {
case _DiscipleDay():
return $default(_that.date,_that.goalPercent,_that.filled,_that.total,_that.itemsPercent,_that.entries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ApiDateConverter()  DateTime date,  int? goalPercent,  int filled,  int total,  int itemsPercent,  List<DiscipleEntry> entries)?  $default,) {final _that = this;
switch (_that) {
case _DiscipleDay() when $default != null:
return $default(_that.date,_that.goalPercent,_that.filled,_that.total,_that.itemsPercent,_that.entries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiscipleDay implements DiscipleDay {
  const _DiscipleDay({@ApiDateConverter() required this.date, this.goalPercent, this.filled = 0, this.total = 0, this.itemsPercent = 0, final  List<DiscipleEntry> entries = const <DiscipleEntry>[]}): _entries = entries;
  factory _DiscipleDay.fromJson(Map<String, dynamic> json) => _$DiscipleDayFromJson(json);

@override@ApiDateConverter() final  DateTime date;
/// The share of the day's goals reached (0 to 100), null without goals.
@override final  int? goalPercent;
@override@JsonKey() final  int filled;
@override@JsonKey() final  int total;
@override@JsonKey() final  int itemsPercent;
 final  List<DiscipleEntry> _entries;
@override@JsonKey() List<DiscipleEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of DiscipleDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscipleDayCopyWith<_DiscipleDay> get copyWith => __$DiscipleDayCopyWithImpl<_DiscipleDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscipleDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscipleDay&&(identical(other.date, date) || other.date == date)&&(identical(other.goalPercent, goalPercent) || other.goalPercent == goalPercent)&&(identical(other.filled, filled) || other.filled == filled)&&(identical(other.total, total) || other.total == total)&&(identical(other.itemsPercent, itemsPercent) || other.itemsPercent == itemsPercent)&&const DeepCollectionEquality().equals(other._entries, _entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,goalPercent,filled,total,itemsPercent,const DeepCollectionEquality().hash(_entries));

@override
String toString() {
  return 'DiscipleDay(date: $date, goalPercent: $goalPercent, filled: $filled, total: $total, itemsPercent: $itemsPercent, entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$DiscipleDayCopyWith<$Res> implements $DiscipleDayCopyWith<$Res> {
  factory _$DiscipleDayCopyWith(_DiscipleDay value, $Res Function(_DiscipleDay) _then) = __$DiscipleDayCopyWithImpl;
@override @useResult
$Res call({
@ApiDateConverter() DateTime date, int? goalPercent, int filled, int total, int itemsPercent, List<DiscipleEntry> entries
});




}
/// @nodoc
class __$DiscipleDayCopyWithImpl<$Res>
    implements _$DiscipleDayCopyWith<$Res> {
  __$DiscipleDayCopyWithImpl(this._self, this._then);

  final _DiscipleDay _self;
  final $Res Function(_DiscipleDay) _then;

/// Create a copy of DiscipleDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? goalPercent = freezed,Object? filled = null,Object? total = null,Object? itemsPercent = null,Object? entries = null,}) {
  return _then(_DiscipleDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,goalPercent: freezed == goalPercent ? _self.goalPercent : goalPercent // ignore: cast_nullable_to_non_nullable
as int?,filled: null == filled ? _self.filled : filled // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,itemsPercent: null == itemsPercent ? _self.itemsPercent : itemsPercent // ignore: cast_nullable_to_non_nullable
as int,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<DiscipleEntry>,
  ));
}


}


/// @nodoc
mixin _$DiscipleEntry {

 int get activityTypeId; String get code; String get label; String? get quantityUnit; int? get quantity; int? get durationMinutes;
/// Create a copy of DiscipleEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscipleEntryCopyWith<DiscipleEntry> get copyWith => _$DiscipleEntryCopyWithImpl<DiscipleEntry>(this as DiscipleEntry, _$identity);

  /// Serializes this DiscipleEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscipleEntry&&(identical(other.activityTypeId, activityTypeId) || other.activityTypeId == activityTypeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.quantityUnit, quantityUnit) || other.quantityUnit == quantityUnit)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityTypeId,code,label,quantityUnit,quantity,durationMinutes);

@override
String toString() {
  return 'DiscipleEntry(activityTypeId: $activityTypeId, code: $code, label: $label, quantityUnit: $quantityUnit, quantity: $quantity, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class $DiscipleEntryCopyWith<$Res>  {
  factory $DiscipleEntryCopyWith(DiscipleEntry value, $Res Function(DiscipleEntry) _then) = _$DiscipleEntryCopyWithImpl;
@useResult
$Res call({
 int activityTypeId, String code, String label, String? quantityUnit, int? quantity, int? durationMinutes
});




}
/// @nodoc
class _$DiscipleEntryCopyWithImpl<$Res>
    implements $DiscipleEntryCopyWith<$Res> {
  _$DiscipleEntryCopyWithImpl(this._self, this._then);

  final DiscipleEntry _self;
  final $Res Function(DiscipleEntry) _then;

/// Create a copy of DiscipleEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityTypeId = null,Object? code = null,Object? label = null,Object? quantityUnit = freezed,Object? quantity = freezed,Object? durationMinutes = freezed,}) {
  return _then(_self.copyWith(
activityTypeId: null == activityTypeId ? _self.activityTypeId : activityTypeId // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,quantityUnit: freezed == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DiscipleEntry].
extension DiscipleEntryPatterns on DiscipleEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscipleEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscipleEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscipleEntry value)  $default,){
final _that = this;
switch (_that) {
case _DiscipleEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscipleEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DiscipleEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activityTypeId,  String code,  String label,  String? quantityUnit,  int? quantity,  int? durationMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscipleEntry() when $default != null:
return $default(_that.activityTypeId,_that.code,_that.label,_that.quantityUnit,_that.quantity,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activityTypeId,  String code,  String label,  String? quantityUnit,  int? quantity,  int? durationMinutes)  $default,) {final _that = this;
switch (_that) {
case _DiscipleEntry():
return $default(_that.activityTypeId,_that.code,_that.label,_that.quantityUnit,_that.quantity,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activityTypeId,  String code,  String label,  String? quantityUnit,  int? quantity,  int? durationMinutes)?  $default,) {final _that = this;
switch (_that) {
case _DiscipleEntry() when $default != null:
return $default(_that.activityTypeId,_that.code,_that.label,_that.quantityUnit,_that.quantity,_that.durationMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiscipleEntry implements DiscipleEntry {
  const _DiscipleEntry({required this.activityTypeId, required this.code, required this.label, this.quantityUnit, this.quantity, this.durationMinutes});
  factory _DiscipleEntry.fromJson(Map<String, dynamic> json) => _$DiscipleEntryFromJson(json);

@override final  int activityTypeId;
@override final  String code;
@override final  String label;
@override final  String? quantityUnit;
@override final  int? quantity;
@override final  int? durationMinutes;

/// Create a copy of DiscipleEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscipleEntryCopyWith<_DiscipleEntry> get copyWith => __$DiscipleEntryCopyWithImpl<_DiscipleEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscipleEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscipleEntry&&(identical(other.activityTypeId, activityTypeId) || other.activityTypeId == activityTypeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.quantityUnit, quantityUnit) || other.quantityUnit == quantityUnit)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityTypeId,code,label,quantityUnit,quantity,durationMinutes);

@override
String toString() {
  return 'DiscipleEntry(activityTypeId: $activityTypeId, code: $code, label: $label, quantityUnit: $quantityUnit, quantity: $quantity, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$DiscipleEntryCopyWith<$Res> implements $DiscipleEntryCopyWith<$Res> {
  factory _$DiscipleEntryCopyWith(_DiscipleEntry value, $Res Function(_DiscipleEntry) _then) = __$DiscipleEntryCopyWithImpl;
@override @useResult
$Res call({
 int activityTypeId, String code, String label, String? quantityUnit, int? quantity, int? durationMinutes
});




}
/// @nodoc
class __$DiscipleEntryCopyWithImpl<$Res>
    implements _$DiscipleEntryCopyWith<$Res> {
  __$DiscipleEntryCopyWithImpl(this._self, this._then);

  final _DiscipleEntry _self;
  final $Res Function(_DiscipleEntry) _then;

/// Create a copy of DiscipleEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityTypeId = null,Object? code = null,Object? label = null,Object? quantityUnit = freezed,Object? quantity = freezed,Object? durationMinutes = freezed,}) {
  return _then(_DiscipleEntry(
activityTypeId: null == activityTypeId ? _self.activityTypeId : activityTypeId // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,quantityUnit: freezed == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
