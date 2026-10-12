// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_report_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DayDraft {

 DateTime get date; List<ReportEntry> get entries;/// Items shared by everyone; the others are the user's own.
 Set<int> get standardIds; String get note;/// The day exists on the server (saved at least once).
 bool get submitted;/// Changed since the last save.
 bool get dirty; bool get saving;/// Saved on the phone without network, not sent to the server yet.
 bool get pending;
/// Create a copy of DayDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayDraftCopyWith<DayDraft> get copyWith => _$DayDraftCopyWithImpl<DayDraft>(this as DayDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayDraft&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.standardIds, standardIds)&&(identical(other.note, note) || other.note == note)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&(identical(other.dirty, dirty) || other.dirty == dirty)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.pending, pending) || other.pending == pending));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(standardIds),note,submitted,dirty,saving,pending);

@override
String toString() {
  return 'DayDraft(date: $date, entries: $entries, standardIds: $standardIds, note: $note, submitted: $submitted, dirty: $dirty, saving: $saving, pending: $pending)';
}


}

/// @nodoc
abstract mixin class $DayDraftCopyWith<$Res>  {
  factory $DayDraftCopyWith(DayDraft value, $Res Function(DayDraft) _then) = _$DayDraftCopyWithImpl;
@useResult
$Res call({
 DateTime date, List<ReportEntry> entries, Set<int> standardIds, String note, bool submitted, bool dirty, bool saving, bool pending
});




}
/// @nodoc
class _$DayDraftCopyWithImpl<$Res>
    implements $DayDraftCopyWith<$Res> {
  _$DayDraftCopyWithImpl(this._self, this._then);

  final DayDraft _self;
  final $Res Function(DayDraft) _then;

/// Create a copy of DayDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? entries = null,Object? standardIds = null,Object? note = null,Object? submitted = null,Object? dirty = null,Object? saving = null,Object? pending = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<ReportEntry>,standardIds: null == standardIds ? _self.standardIds : standardIds // ignore: cast_nullable_to_non_nullable
as Set<int>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,dirty: null == dirty ? _self.dirty : dirty // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DayDraft].
extension DayDraftPatterns on DayDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayDraft value)  $default,){
final _that = this;
switch (_that) {
case _DayDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayDraft value)?  $default,){
final _that = this;
switch (_that) {
case _DayDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  List<ReportEntry> entries,  Set<int> standardIds,  String note,  bool submitted,  bool dirty,  bool saving,  bool pending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayDraft() when $default != null:
return $default(_that.date,_that.entries,_that.standardIds,_that.note,_that.submitted,_that.dirty,_that.saving,_that.pending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  List<ReportEntry> entries,  Set<int> standardIds,  String note,  bool submitted,  bool dirty,  bool saving,  bool pending)  $default,) {final _that = this;
switch (_that) {
case _DayDraft():
return $default(_that.date,_that.entries,_that.standardIds,_that.note,_that.submitted,_that.dirty,_that.saving,_that.pending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  List<ReportEntry> entries,  Set<int> standardIds,  String note,  bool submitted,  bool dirty,  bool saving,  bool pending)?  $default,) {final _that = this;
switch (_that) {
case _DayDraft() when $default != null:
return $default(_that.date,_that.entries,_that.standardIds,_that.note,_that.submitted,_that.dirty,_that.saving,_that.pending);case _:
  return null;

}
}

}

/// @nodoc


class _DayDraft extends DayDraft {
  const _DayDraft({required this.date, required final  List<ReportEntry> entries, required final  Set<int> standardIds, this.note = '', this.submitted = false, this.dirty = false, this.saving = false, this.pending = false}): _entries = entries,_standardIds = standardIds,super._();
  

@override final  DateTime date;
 final  List<ReportEntry> _entries;
@override List<ReportEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

/// Items shared by everyone; the others are the user's own.
 final  Set<int> _standardIds;
/// Items shared by everyone; the others are the user's own.
@override Set<int> get standardIds {
  if (_standardIds is EqualUnmodifiableSetView) return _standardIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_standardIds);
}

@override@JsonKey() final  String note;
/// The day exists on the server (saved at least once).
@override@JsonKey() final  bool submitted;
/// Changed since the last save.
@override@JsonKey() final  bool dirty;
@override@JsonKey() final  bool saving;
/// Saved on the phone without network, not sent to the server yet.
@override@JsonKey() final  bool pending;

/// Create a copy of DayDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayDraftCopyWith<_DayDraft> get copyWith => __$DayDraftCopyWithImpl<_DayDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayDraft&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._standardIds, _standardIds)&&(identical(other.note, note) || other.note == note)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&(identical(other.dirty, dirty) || other.dirty == dirty)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.pending, pending) || other.pending == pending));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_standardIds),note,submitted,dirty,saving,pending);

@override
String toString() {
  return 'DayDraft(date: $date, entries: $entries, standardIds: $standardIds, note: $note, submitted: $submitted, dirty: $dirty, saving: $saving, pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$DayDraftCopyWith<$Res> implements $DayDraftCopyWith<$Res> {
  factory _$DayDraftCopyWith(_DayDraft value, $Res Function(_DayDraft) _then) = __$DayDraftCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, List<ReportEntry> entries, Set<int> standardIds, String note, bool submitted, bool dirty, bool saving, bool pending
});




}
/// @nodoc
class __$DayDraftCopyWithImpl<$Res>
    implements _$DayDraftCopyWith<$Res> {
  __$DayDraftCopyWithImpl(this._self, this._then);

  final _DayDraft _self;
  final $Res Function(_DayDraft) _then;

/// Create a copy of DayDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? entries = null,Object? standardIds = null,Object? note = null,Object? submitted = null,Object? dirty = null,Object? saving = null,Object? pending = null,}) {
  return _then(_DayDraft(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<ReportEntry>,standardIds: null == standardIds ? _self._standardIds : standardIds // ignore: cast_nullable_to_non_nullable
as Set<int>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,dirty: null == dirty ? _self.dirty : dirty // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
