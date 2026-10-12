// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportEntry {

 int get activityTypeId; String get code; String get label; bool get tracksQuantity; String? get quantityUnit; bool get tracksDuration; int? get quantity; int? get durationMinutes;
/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportEntryCopyWith<ReportEntry> get copyWith => _$ReportEntryCopyWithImpl<ReportEntry>(this as ReportEntry, _$identity);

  /// Serializes this ReportEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportEntry&&(identical(other.activityTypeId, activityTypeId) || other.activityTypeId == activityTypeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.tracksQuantity, tracksQuantity) || other.tracksQuantity == tracksQuantity)&&(identical(other.quantityUnit, quantityUnit) || other.quantityUnit == quantityUnit)&&(identical(other.tracksDuration, tracksDuration) || other.tracksDuration == tracksDuration)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityTypeId,code,label,tracksQuantity,quantityUnit,tracksDuration,quantity,durationMinutes);

@override
String toString() {
  return 'ReportEntry(activityTypeId: $activityTypeId, code: $code, label: $label, tracksQuantity: $tracksQuantity, quantityUnit: $quantityUnit, tracksDuration: $tracksDuration, quantity: $quantity, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class $ReportEntryCopyWith<$Res>  {
  factory $ReportEntryCopyWith(ReportEntry value, $Res Function(ReportEntry) _then) = _$ReportEntryCopyWithImpl;
@useResult
$Res call({
 int activityTypeId, String code, String label, bool tracksQuantity, String? quantityUnit, bool tracksDuration, int? quantity, int? durationMinutes
});




}
/// @nodoc
class _$ReportEntryCopyWithImpl<$Res>
    implements $ReportEntryCopyWith<$Res> {
  _$ReportEntryCopyWithImpl(this._self, this._then);

  final ReportEntry _self;
  final $Res Function(ReportEntry) _then;

/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityTypeId = null,Object? code = null,Object? label = null,Object? tracksQuantity = null,Object? quantityUnit = freezed,Object? tracksDuration = null,Object? quantity = freezed,Object? durationMinutes = freezed,}) {
  return _then(_self.copyWith(
activityTypeId: null == activityTypeId ? _self.activityTypeId : activityTypeId // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tracksQuantity: null == tracksQuantity ? _self.tracksQuantity : tracksQuantity // ignore: cast_nullable_to_non_nullable
as bool,quantityUnit: freezed == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as String?,tracksDuration: null == tracksDuration ? _self.tracksDuration : tracksDuration // ignore: cast_nullable_to_non_nullable
as bool,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportEntry].
extension ReportEntryPatterns on ReportEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportEntry value)  $default,){
final _that = this;
switch (_that) {
case _ReportEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ReportEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activityTypeId,  String code,  String label,  bool tracksQuantity,  String? quantityUnit,  bool tracksDuration,  int? quantity,  int? durationMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportEntry() when $default != null:
return $default(_that.activityTypeId,_that.code,_that.label,_that.tracksQuantity,_that.quantityUnit,_that.tracksDuration,_that.quantity,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activityTypeId,  String code,  String label,  bool tracksQuantity,  String? quantityUnit,  bool tracksDuration,  int? quantity,  int? durationMinutes)  $default,) {final _that = this;
switch (_that) {
case _ReportEntry():
return $default(_that.activityTypeId,_that.code,_that.label,_that.tracksQuantity,_that.quantityUnit,_that.tracksDuration,_that.quantity,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activityTypeId,  String code,  String label,  bool tracksQuantity,  String? quantityUnit,  bool tracksDuration,  int? quantity,  int? durationMinutes)?  $default,) {final _that = this;
switch (_that) {
case _ReportEntry() when $default != null:
return $default(_that.activityTypeId,_that.code,_that.label,_that.tracksQuantity,_that.quantityUnit,_that.tracksDuration,_that.quantity,_that.durationMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportEntry extends ReportEntry {
  const _ReportEntry({required this.activityTypeId, required this.code, required this.label, this.tracksQuantity = false, this.quantityUnit, this.tracksDuration = false, this.quantity, this.durationMinutes}): super._();
  factory _ReportEntry.fromJson(Map<String, dynamic> json) => _$ReportEntryFromJson(json);

@override final  int activityTypeId;
@override final  String code;
@override final  String label;
@override@JsonKey() final  bool tracksQuantity;
@override final  String? quantityUnit;
@override@JsonKey() final  bool tracksDuration;
@override final  int? quantity;
@override final  int? durationMinutes;

/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportEntryCopyWith<_ReportEntry> get copyWith => __$ReportEntryCopyWithImpl<_ReportEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportEntry&&(identical(other.activityTypeId, activityTypeId) || other.activityTypeId == activityTypeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.tracksQuantity, tracksQuantity) || other.tracksQuantity == tracksQuantity)&&(identical(other.quantityUnit, quantityUnit) || other.quantityUnit == quantityUnit)&&(identical(other.tracksDuration, tracksDuration) || other.tracksDuration == tracksDuration)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityTypeId,code,label,tracksQuantity,quantityUnit,tracksDuration,quantity,durationMinutes);

@override
String toString() {
  return 'ReportEntry(activityTypeId: $activityTypeId, code: $code, label: $label, tracksQuantity: $tracksQuantity, quantityUnit: $quantityUnit, tracksDuration: $tracksDuration, quantity: $quantity, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$ReportEntryCopyWith<$Res> implements $ReportEntryCopyWith<$Res> {
  factory _$ReportEntryCopyWith(_ReportEntry value, $Res Function(_ReportEntry) _then) = __$ReportEntryCopyWithImpl;
@override @useResult
$Res call({
 int activityTypeId, String code, String label, bool tracksQuantity, String? quantityUnit, bool tracksDuration, int? quantity, int? durationMinutes
});




}
/// @nodoc
class __$ReportEntryCopyWithImpl<$Res>
    implements _$ReportEntryCopyWith<$Res> {
  __$ReportEntryCopyWithImpl(this._self, this._then);

  final _ReportEntry _self;
  final $Res Function(_ReportEntry) _then;

/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityTypeId = null,Object? code = null,Object? label = null,Object? tracksQuantity = null,Object? quantityUnit = freezed,Object? tracksDuration = null,Object? quantity = freezed,Object? durationMinutes = freezed,}) {
  return _then(_ReportEntry(
activityTypeId: null == activityTypeId ? _self.activityTypeId : activityTypeId // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tracksQuantity: null == tracksQuantity ? _self.tracksQuantity : tracksQuantity // ignore: cast_nullable_to_non_nullable
as bool,quantityUnit: freezed == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as String?,tracksDuration: null == tracksDuration ? _self.tracksDuration : tracksDuration // ignore: cast_nullable_to_non_nullable
as bool,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DailyReport {

@ApiDateConverter() DateTime get date; String? get note;/// The day was saved at least once.
 bool get submitted; List<ReportEntry> get entries;
/// Create a copy of DailyReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyReportCopyWith<DailyReport> get copyWith => _$DailyReportCopyWithImpl<DailyReport>(this as DailyReport, _$identity);

  /// Serializes this DailyReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyReport&&(identical(other.date, date) || other.date == date)&&(identical(other.note, note) || other.note == note)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&const DeepCollectionEquality().equals(other.entries, entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,note,submitted,const DeepCollectionEquality().hash(entries));

@override
String toString() {
  return 'DailyReport(date: $date, note: $note, submitted: $submitted, entries: $entries)';
}


}

/// @nodoc
abstract mixin class $DailyReportCopyWith<$Res>  {
  factory $DailyReportCopyWith(DailyReport value, $Res Function(DailyReport) _then) = _$DailyReportCopyWithImpl;
@useResult
$Res call({
@ApiDateConverter() DateTime date, String? note, bool submitted, List<ReportEntry> entries
});




}
/// @nodoc
class _$DailyReportCopyWithImpl<$Res>
    implements $DailyReportCopyWith<$Res> {
  _$DailyReportCopyWithImpl(this._self, this._then);

  final DailyReport _self;
  final $Res Function(DailyReport) _then;

/// Create a copy of DailyReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? note = freezed,Object? submitted = null,Object? entries = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<ReportEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyReport].
extension DailyReportPatterns on DailyReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyReport value)  $default,){
final _that = this;
switch (_that) {
case _DailyReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyReport value)?  $default,){
final _that = this;
switch (_that) {
case _DailyReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ApiDateConverter()  DateTime date,  String? note,  bool submitted,  List<ReportEntry> entries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyReport() when $default != null:
return $default(_that.date,_that.note,_that.submitted,_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ApiDateConverter()  DateTime date,  String? note,  bool submitted,  List<ReportEntry> entries)  $default,) {final _that = this;
switch (_that) {
case _DailyReport():
return $default(_that.date,_that.note,_that.submitted,_that.entries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ApiDateConverter()  DateTime date,  String? note,  bool submitted,  List<ReportEntry> entries)?  $default,) {final _that = this;
switch (_that) {
case _DailyReport() when $default != null:
return $default(_that.date,_that.note,_that.submitted,_that.entries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyReport implements DailyReport {
  const _DailyReport({@ApiDateConverter() required this.date, this.note, this.submitted = false, final  List<ReportEntry> entries = const <ReportEntry>[]}): _entries = entries;
  factory _DailyReport.fromJson(Map<String, dynamic> json) => _$DailyReportFromJson(json);

@override@ApiDateConverter() final  DateTime date;
@override final  String? note;
/// The day was saved at least once.
@override@JsonKey() final  bool submitted;
 final  List<ReportEntry> _entries;
@override@JsonKey() List<ReportEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of DailyReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyReportCopyWith<_DailyReport> get copyWith => __$DailyReportCopyWithImpl<_DailyReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyReport&&(identical(other.date, date) || other.date == date)&&(identical(other.note, note) || other.note == note)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&const DeepCollectionEquality().equals(other._entries, _entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,note,submitted,const DeepCollectionEquality().hash(_entries));

@override
String toString() {
  return 'DailyReport(date: $date, note: $note, submitted: $submitted, entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$DailyReportCopyWith<$Res> implements $DailyReportCopyWith<$Res> {
  factory _$DailyReportCopyWith(_DailyReport value, $Res Function(_DailyReport) _then) = __$DailyReportCopyWithImpl;
@override @useResult
$Res call({
@ApiDateConverter() DateTime date, String? note, bool submitted, List<ReportEntry> entries
});




}
/// @nodoc
class __$DailyReportCopyWithImpl<$Res>
    implements _$DailyReportCopyWith<$Res> {
  __$DailyReportCopyWithImpl(this._self, this._then);

  final _DailyReport _self;
  final $Res Function(_DailyReport) _then;

/// Create a copy of DailyReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? note = freezed,Object? submitted = null,Object? entries = null,}) {
  return _then(_DailyReport(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<ReportEntry>,
  ));
}


}

// dart format on
