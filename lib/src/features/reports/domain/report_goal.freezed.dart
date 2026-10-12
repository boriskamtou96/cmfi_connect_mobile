// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportGoal {

 int? get quantity; int? get minutes;
/// Create a copy of ReportGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportGoalCopyWith<ReportGoal> get copyWith => _$ReportGoalCopyWithImpl<ReportGoal>(this as ReportGoal, _$identity);

  /// Serializes this ReportGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportGoal&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quantity,minutes);

@override
String toString() {
  return 'ReportGoal(quantity: $quantity, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class $ReportGoalCopyWith<$Res>  {
  factory $ReportGoalCopyWith(ReportGoal value, $Res Function(ReportGoal) _then) = _$ReportGoalCopyWithImpl;
@useResult
$Res call({
 int? quantity, int? minutes
});




}
/// @nodoc
class _$ReportGoalCopyWithImpl<$Res>
    implements $ReportGoalCopyWith<$Res> {
  _$ReportGoalCopyWithImpl(this._self, this._then);

  final ReportGoal _self;
  final $Res Function(ReportGoal) _then;

/// Create a copy of ReportGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quantity = freezed,Object? minutes = freezed,}) {
  return _then(_self.copyWith(
quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportGoal].
extension ReportGoalPatterns on ReportGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportGoal value)  $default,){
final _that = this;
switch (_that) {
case _ReportGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportGoal value)?  $default,){
final _that = this;
switch (_that) {
case _ReportGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? quantity,  int? minutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportGoal() when $default != null:
return $default(_that.quantity,_that.minutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? quantity,  int? minutes)  $default,) {final _that = this;
switch (_that) {
case _ReportGoal():
return $default(_that.quantity,_that.minutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? quantity,  int? minutes)?  $default,) {final _that = this;
switch (_that) {
case _ReportGoal() when $default != null:
return $default(_that.quantity,_that.minutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportGoal extends ReportGoal {
  const _ReportGoal({this.quantity, this.minutes}): super._();
  factory _ReportGoal.fromJson(Map<String, dynamic> json) => _$ReportGoalFromJson(json);

@override final  int? quantity;
@override final  int? minutes;

/// Create a copy of ReportGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportGoalCopyWith<_ReportGoal> get copyWith => __$ReportGoalCopyWithImpl<_ReportGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportGoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportGoal&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quantity,minutes);

@override
String toString() {
  return 'ReportGoal(quantity: $quantity, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class _$ReportGoalCopyWith<$Res> implements $ReportGoalCopyWith<$Res> {
  factory _$ReportGoalCopyWith(_ReportGoal value, $Res Function(_ReportGoal) _then) = __$ReportGoalCopyWithImpl;
@override @useResult
$Res call({
 int? quantity, int? minutes
});




}
/// @nodoc
class __$ReportGoalCopyWithImpl<$Res>
    implements _$ReportGoalCopyWith<$Res> {
  __$ReportGoalCopyWithImpl(this._self, this._then);

  final _ReportGoal _self;
  final $Res Function(_ReportGoal) _then;

/// Create a copy of ReportGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quantity = freezed,Object? minutes = freezed,}) {
  return _then(_ReportGoal(
quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
