// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportSummary {

@ApiDateConverter() DateTime get from;@ApiDateConverter() DateTime get to; int get daysInRange; int get daysReported; List<SummaryItem> get items;
/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportSummaryCopyWith<ReportSummary> get copyWith => _$ReportSummaryCopyWithImpl<ReportSummary>(this as ReportSummary, _$identity);

  /// Serializes this ReportSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportSummary&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.daysInRange, daysInRange) || other.daysInRange == daysInRange)&&(identical(other.daysReported, daysReported) || other.daysReported == daysReported)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,daysInRange,daysReported,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ReportSummary(from: $from, to: $to, daysInRange: $daysInRange, daysReported: $daysReported, items: $items)';
}


}

/// @nodoc
abstract mixin class $ReportSummaryCopyWith<$Res>  {
  factory $ReportSummaryCopyWith(ReportSummary value, $Res Function(ReportSummary) _then) = _$ReportSummaryCopyWithImpl;
@useResult
$Res call({
@ApiDateConverter() DateTime from,@ApiDateConverter() DateTime to, int daysInRange, int daysReported, List<SummaryItem> items
});




}
/// @nodoc
class _$ReportSummaryCopyWithImpl<$Res>
    implements $ReportSummaryCopyWith<$Res> {
  _$ReportSummaryCopyWithImpl(this._self, this._then);

  final ReportSummary _self;
  final $Res Function(ReportSummary) _then;

/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? daysInRange = null,Object? daysReported = null,Object? items = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,daysInRange: null == daysInRange ? _self.daysInRange : daysInRange // ignore: cast_nullable_to_non_nullable
as int,daysReported: null == daysReported ? _self.daysReported : daysReported // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SummaryItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportSummary].
extension ReportSummaryPatterns on ReportSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportSummary value)  $default,){
final _that = this;
switch (_that) {
case _ReportSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ApiDateConverter()  DateTime from, @ApiDateConverter()  DateTime to,  int daysInRange,  int daysReported,  List<SummaryItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
return $default(_that.from,_that.to,_that.daysInRange,_that.daysReported,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ApiDateConverter()  DateTime from, @ApiDateConverter()  DateTime to,  int daysInRange,  int daysReported,  List<SummaryItem> items)  $default,) {final _that = this;
switch (_that) {
case _ReportSummary():
return $default(_that.from,_that.to,_that.daysInRange,_that.daysReported,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ApiDateConverter()  DateTime from, @ApiDateConverter()  DateTime to,  int daysInRange,  int daysReported,  List<SummaryItem> items)?  $default,) {final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
return $default(_that.from,_that.to,_that.daysInRange,_that.daysReported,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportSummary implements ReportSummary {
  const _ReportSummary({@ApiDateConverter() required this.from, @ApiDateConverter() required this.to, required this.daysInRange, required this.daysReported, final  List<SummaryItem> items = const <SummaryItem>[]}): _items = items;
  factory _ReportSummary.fromJson(Map<String, dynamic> json) => _$ReportSummaryFromJson(json);

@override@ApiDateConverter() final  DateTime from;
@override@ApiDateConverter() final  DateTime to;
@override final  int daysInRange;
@override final  int daysReported;
 final  List<SummaryItem> _items;
@override@JsonKey() List<SummaryItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportSummaryCopyWith<_ReportSummary> get copyWith => __$ReportSummaryCopyWithImpl<_ReportSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportSummary&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.daysInRange, daysInRange) || other.daysInRange == daysInRange)&&(identical(other.daysReported, daysReported) || other.daysReported == daysReported)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,daysInRange,daysReported,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ReportSummary(from: $from, to: $to, daysInRange: $daysInRange, daysReported: $daysReported, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ReportSummaryCopyWith<$Res> implements $ReportSummaryCopyWith<$Res> {
  factory _$ReportSummaryCopyWith(_ReportSummary value, $Res Function(_ReportSummary) _then) = __$ReportSummaryCopyWithImpl;
@override @useResult
$Res call({
@ApiDateConverter() DateTime from,@ApiDateConverter() DateTime to, int daysInRange, int daysReported, List<SummaryItem> items
});




}
/// @nodoc
class __$ReportSummaryCopyWithImpl<$Res>
    implements _$ReportSummaryCopyWith<$Res> {
  __$ReportSummaryCopyWithImpl(this._self, this._then);

  final _ReportSummary _self;
  final $Res Function(_ReportSummary) _then;

/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? daysInRange = null,Object? daysReported = null,Object? items = null,}) {
  return _then(_ReportSummary(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,daysInRange: null == daysInRange ? _self.daysInRange : daysInRange // ignore: cast_nullable_to_non_nullable
as int,daysReported: null == daysReported ? _self.daysReported : daysReported // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SummaryItem>,
  ));
}


}


/// @nodoc
mixin _$SummaryItem {

 int get activityTypeId; String get code; String get label; String? get quantityUnit; bool get tracksQuantity; bool get tracksDuration;/// Days on which this item was filled in.
 int get daysCount; int get totalQuantity; int get totalMinutes;
/// Create a copy of SummaryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryItemCopyWith<SummaryItem> get copyWith => _$SummaryItemCopyWithImpl<SummaryItem>(this as SummaryItem, _$identity);

  /// Serializes this SummaryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryItem&&(identical(other.activityTypeId, activityTypeId) || other.activityTypeId == activityTypeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.quantityUnit, quantityUnit) || other.quantityUnit == quantityUnit)&&(identical(other.tracksQuantity, tracksQuantity) || other.tracksQuantity == tracksQuantity)&&(identical(other.tracksDuration, tracksDuration) || other.tracksDuration == tracksDuration)&&(identical(other.daysCount, daysCount) || other.daysCount == daysCount)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityTypeId,code,label,quantityUnit,tracksQuantity,tracksDuration,daysCount,totalQuantity,totalMinutes);

@override
String toString() {
  return 'SummaryItem(activityTypeId: $activityTypeId, code: $code, label: $label, quantityUnit: $quantityUnit, tracksQuantity: $tracksQuantity, tracksDuration: $tracksDuration, daysCount: $daysCount, totalQuantity: $totalQuantity, totalMinutes: $totalMinutes)';
}


}

/// @nodoc
abstract mixin class $SummaryItemCopyWith<$Res>  {
  factory $SummaryItemCopyWith(SummaryItem value, $Res Function(SummaryItem) _then) = _$SummaryItemCopyWithImpl;
@useResult
$Res call({
 int activityTypeId, String code, String label, String? quantityUnit, bool tracksQuantity, bool tracksDuration, int daysCount, int totalQuantity, int totalMinutes
});




}
/// @nodoc
class _$SummaryItemCopyWithImpl<$Res>
    implements $SummaryItemCopyWith<$Res> {
  _$SummaryItemCopyWithImpl(this._self, this._then);

  final SummaryItem _self;
  final $Res Function(SummaryItem) _then;

/// Create a copy of SummaryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityTypeId = null,Object? code = null,Object? label = null,Object? quantityUnit = freezed,Object? tracksQuantity = null,Object? tracksDuration = null,Object? daysCount = null,Object? totalQuantity = null,Object? totalMinutes = null,}) {
  return _then(_self.copyWith(
activityTypeId: null == activityTypeId ? _self.activityTypeId : activityTypeId // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,quantityUnit: freezed == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as String?,tracksQuantity: null == tracksQuantity ? _self.tracksQuantity : tracksQuantity // ignore: cast_nullable_to_non_nullable
as bool,tracksDuration: null == tracksDuration ? _self.tracksDuration : tracksDuration // ignore: cast_nullable_to_non_nullable
as bool,daysCount: null == daysCount ? _self.daysCount : daysCount // ignore: cast_nullable_to_non_nullable
as int,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SummaryItem].
extension SummaryItemPatterns on SummaryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryItem value)  $default,){
final _that = this;
switch (_that) {
case _SummaryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryItem value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activityTypeId,  String code,  String label,  String? quantityUnit,  bool tracksQuantity,  bool tracksDuration,  int daysCount,  int totalQuantity,  int totalMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryItem() when $default != null:
return $default(_that.activityTypeId,_that.code,_that.label,_that.quantityUnit,_that.tracksQuantity,_that.tracksDuration,_that.daysCount,_that.totalQuantity,_that.totalMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activityTypeId,  String code,  String label,  String? quantityUnit,  bool tracksQuantity,  bool tracksDuration,  int daysCount,  int totalQuantity,  int totalMinutes)  $default,) {final _that = this;
switch (_that) {
case _SummaryItem():
return $default(_that.activityTypeId,_that.code,_that.label,_that.quantityUnit,_that.tracksQuantity,_that.tracksDuration,_that.daysCount,_that.totalQuantity,_that.totalMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activityTypeId,  String code,  String label,  String? quantityUnit,  bool tracksQuantity,  bool tracksDuration,  int daysCount,  int totalQuantity,  int totalMinutes)?  $default,) {final _that = this;
switch (_that) {
case _SummaryItem() when $default != null:
return $default(_that.activityTypeId,_that.code,_that.label,_that.quantityUnit,_that.tracksQuantity,_that.tracksDuration,_that.daysCount,_that.totalQuantity,_that.totalMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SummaryItem implements SummaryItem {
  const _SummaryItem({required this.activityTypeId, required this.code, required this.label, this.quantityUnit, this.tracksQuantity = false, this.tracksDuration = false, this.daysCount = 0, this.totalQuantity = 0, this.totalMinutes = 0});
  factory _SummaryItem.fromJson(Map<String, dynamic> json) => _$SummaryItemFromJson(json);

@override final  int activityTypeId;
@override final  String code;
@override final  String label;
@override final  String? quantityUnit;
@override@JsonKey() final  bool tracksQuantity;
@override@JsonKey() final  bool tracksDuration;
/// Days on which this item was filled in.
@override@JsonKey() final  int daysCount;
@override@JsonKey() final  int totalQuantity;
@override@JsonKey() final  int totalMinutes;

/// Create a copy of SummaryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryItemCopyWith<_SummaryItem> get copyWith => __$SummaryItemCopyWithImpl<_SummaryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SummaryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryItem&&(identical(other.activityTypeId, activityTypeId) || other.activityTypeId == activityTypeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.quantityUnit, quantityUnit) || other.quantityUnit == quantityUnit)&&(identical(other.tracksQuantity, tracksQuantity) || other.tracksQuantity == tracksQuantity)&&(identical(other.tracksDuration, tracksDuration) || other.tracksDuration == tracksDuration)&&(identical(other.daysCount, daysCount) || other.daysCount == daysCount)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityTypeId,code,label,quantityUnit,tracksQuantity,tracksDuration,daysCount,totalQuantity,totalMinutes);

@override
String toString() {
  return 'SummaryItem(activityTypeId: $activityTypeId, code: $code, label: $label, quantityUnit: $quantityUnit, tracksQuantity: $tracksQuantity, tracksDuration: $tracksDuration, daysCount: $daysCount, totalQuantity: $totalQuantity, totalMinutes: $totalMinutes)';
}


}

/// @nodoc
abstract mixin class _$SummaryItemCopyWith<$Res> implements $SummaryItemCopyWith<$Res> {
  factory _$SummaryItemCopyWith(_SummaryItem value, $Res Function(_SummaryItem) _then) = __$SummaryItemCopyWithImpl;
@override @useResult
$Res call({
 int activityTypeId, String code, String label, String? quantityUnit, bool tracksQuantity, bool tracksDuration, int daysCount, int totalQuantity, int totalMinutes
});




}
/// @nodoc
class __$SummaryItemCopyWithImpl<$Res>
    implements _$SummaryItemCopyWith<$Res> {
  __$SummaryItemCopyWithImpl(this._self, this._then);

  final _SummaryItem _self;
  final $Res Function(_SummaryItem) _then;

/// Create a copy of SummaryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityTypeId = null,Object? code = null,Object? label = null,Object? quantityUnit = freezed,Object? tracksQuantity = null,Object? tracksDuration = null,Object? daysCount = null,Object? totalQuantity = null,Object? totalMinutes = null,}) {
  return _then(_SummaryItem(
activityTypeId: null == activityTypeId ? _self.activityTypeId : activityTypeId // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,quantityUnit: freezed == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as String?,tracksQuantity: null == tracksQuantity ? _self.tracksQuantity : tracksQuantity // ignore: cast_nullable_to_non_nullable
as bool,tracksDuration: null == tracksDuration ? _self.tracksDuration : tracksDuration // ignore: cast_nullable_to_non_nullable
as bool,daysCount: null == daysCount ? _self.daysCount : daysCount // ignore: cast_nullable_to_non_nullable
as int,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
