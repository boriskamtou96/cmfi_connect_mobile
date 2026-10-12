// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityType {

 int get id; String get code; String get label; bool get tracksQuantity; String? get quantityUnit; bool get tracksDuration; int get position; bool get isStandard;
/// Create a copy of ActivityType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityTypeCopyWith<ActivityType> get copyWith => _$ActivityTypeCopyWithImpl<ActivityType>(this as ActivityType, _$identity);

  /// Serializes this ActivityType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityType&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.tracksQuantity, tracksQuantity) || other.tracksQuantity == tracksQuantity)&&(identical(other.quantityUnit, quantityUnit) || other.quantityUnit == quantityUnit)&&(identical(other.tracksDuration, tracksDuration) || other.tracksDuration == tracksDuration)&&(identical(other.position, position) || other.position == position)&&(identical(other.isStandard, isStandard) || other.isStandard == isStandard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,tracksQuantity,quantityUnit,tracksDuration,position,isStandard);

@override
String toString() {
  return 'ActivityType(id: $id, code: $code, label: $label, tracksQuantity: $tracksQuantity, quantityUnit: $quantityUnit, tracksDuration: $tracksDuration, position: $position, isStandard: $isStandard)';
}


}

/// @nodoc
abstract mixin class $ActivityTypeCopyWith<$Res>  {
  factory $ActivityTypeCopyWith(ActivityType value, $Res Function(ActivityType) _then) = _$ActivityTypeCopyWithImpl;
@useResult
$Res call({
 int id, String code, String label, bool tracksQuantity, String? quantityUnit, bool tracksDuration, int position, bool isStandard
});




}
/// @nodoc
class _$ActivityTypeCopyWithImpl<$Res>
    implements $ActivityTypeCopyWith<$Res> {
  _$ActivityTypeCopyWithImpl(this._self, this._then);

  final ActivityType _self;
  final $Res Function(ActivityType) _then;

/// Create a copy of ActivityType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? label = null,Object? tracksQuantity = null,Object? quantityUnit = freezed,Object? tracksDuration = null,Object? position = null,Object? isStandard = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tracksQuantity: null == tracksQuantity ? _self.tracksQuantity : tracksQuantity // ignore: cast_nullable_to_non_nullable
as bool,quantityUnit: freezed == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as String?,tracksDuration: null == tracksDuration ? _self.tracksDuration : tracksDuration // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,isStandard: null == isStandard ? _self.isStandard : isStandard // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityType].
extension ActivityTypePatterns on ActivityType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityType value)  $default,){
final _that = this;
switch (_that) {
case _ActivityType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityType value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String label,  bool tracksQuantity,  String? quantityUnit,  bool tracksDuration,  int position,  bool isStandard)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityType() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.tracksQuantity,_that.quantityUnit,_that.tracksDuration,_that.position,_that.isStandard);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String label,  bool tracksQuantity,  String? quantityUnit,  bool tracksDuration,  int position,  bool isStandard)  $default,) {final _that = this;
switch (_that) {
case _ActivityType():
return $default(_that.id,_that.code,_that.label,_that.tracksQuantity,_that.quantityUnit,_that.tracksDuration,_that.position,_that.isStandard);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String label,  bool tracksQuantity,  String? quantityUnit,  bool tracksDuration,  int position,  bool isStandard)?  $default,) {final _that = this;
switch (_that) {
case _ActivityType() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.tracksQuantity,_that.quantityUnit,_that.tracksDuration,_that.position,_that.isStandard);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityType implements ActivityType {
  const _ActivityType({required this.id, required this.code, required this.label, this.tracksQuantity = false, this.quantityUnit, this.tracksDuration = false, this.position = 0, this.isStandard = false});
  factory _ActivityType.fromJson(Map<String, dynamic> json) => _$ActivityTypeFromJson(json);

@override final  int id;
@override final  String code;
@override final  String label;
@override@JsonKey() final  bool tracksQuantity;
@override final  String? quantityUnit;
@override@JsonKey() final  bool tracksDuration;
@override@JsonKey() final  int position;
@override@JsonKey() final  bool isStandard;

/// Create a copy of ActivityType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityTypeCopyWith<_ActivityType> get copyWith => __$ActivityTypeCopyWithImpl<_ActivityType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityType&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.tracksQuantity, tracksQuantity) || other.tracksQuantity == tracksQuantity)&&(identical(other.quantityUnit, quantityUnit) || other.quantityUnit == quantityUnit)&&(identical(other.tracksDuration, tracksDuration) || other.tracksDuration == tracksDuration)&&(identical(other.position, position) || other.position == position)&&(identical(other.isStandard, isStandard) || other.isStandard == isStandard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,tracksQuantity,quantityUnit,tracksDuration,position,isStandard);

@override
String toString() {
  return 'ActivityType(id: $id, code: $code, label: $label, tracksQuantity: $tracksQuantity, quantityUnit: $quantityUnit, tracksDuration: $tracksDuration, position: $position, isStandard: $isStandard)';
}


}

/// @nodoc
abstract mixin class _$ActivityTypeCopyWith<$Res> implements $ActivityTypeCopyWith<$Res> {
  factory _$ActivityTypeCopyWith(_ActivityType value, $Res Function(_ActivityType) _then) = __$ActivityTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String label, bool tracksQuantity, String? quantityUnit, bool tracksDuration, int position, bool isStandard
});




}
/// @nodoc
class __$ActivityTypeCopyWithImpl<$Res>
    implements _$ActivityTypeCopyWith<$Res> {
  __$ActivityTypeCopyWithImpl(this._self, this._then);

  final _ActivityType _self;
  final $Res Function(_ActivityType) _then;

/// Create a copy of ActivityType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? label = null,Object? tracksQuantity = null,Object? quantityUnit = freezed,Object? tracksDuration = null,Object? position = null,Object? isStandard = null,}) {
  return _then(_ActivityType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tracksQuantity: null == tracksQuantity ? _self.tracksQuantity : tracksQuantity // ignore: cast_nullable_to_non_nullable
as bool,quantityUnit: freezed == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as String?,tracksDuration: null == tracksDuration ? _self.tracksDuration : tracksDuration // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,isStandard: null == isStandard ? _self.isStandard : isStandard // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
