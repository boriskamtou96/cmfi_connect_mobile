// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'received_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceivedReport {

 int get id; int get authorityId;/// The disciple.
 MemberCard get member;@ApiDateConverter() DateTime get periodFrom;@ApiDateConverter() DateTime get periodTo; DateTime get sentAt; DateTime? get readAt;/// The user's answer, '' before it.
 String get reply; DateTime? get repliedAt;
/// Create a copy of ReceivedReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceivedReportCopyWith<ReceivedReport> get copyWith => _$ReceivedReportCopyWithImpl<ReceivedReport>(this as ReceivedReport, _$identity);

  /// Serializes this ReceivedReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceivedReport&&(identical(other.id, id) || other.id == id)&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorityId,member,periodFrom,periodTo,sentAt,readAt,reply,repliedAt);

@override
String toString() {
  return 'ReceivedReport(id: $id, authorityId: $authorityId, member: $member, periodFrom: $periodFrom, periodTo: $periodTo, sentAt: $sentAt, readAt: $readAt, reply: $reply, repliedAt: $repliedAt)';
}


}

/// @nodoc
abstract mixin class $ReceivedReportCopyWith<$Res>  {
  factory $ReceivedReportCopyWith(ReceivedReport value, $Res Function(ReceivedReport) _then) = _$ReceivedReportCopyWithImpl;
@useResult
$Res call({
 int id, int authorityId, MemberCard member,@ApiDateConverter() DateTime periodFrom,@ApiDateConverter() DateTime periodTo, DateTime sentAt, DateTime? readAt, String reply, DateTime? repliedAt
});


$MemberCardCopyWith<$Res> get member;

}
/// @nodoc
class _$ReceivedReportCopyWithImpl<$Res>
    implements $ReceivedReportCopyWith<$Res> {
  _$ReceivedReportCopyWithImpl(this._self, this._then);

  final ReceivedReport _self;
  final $Res Function(ReceivedReport) _then;

/// Create a copy of ReceivedReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorityId = null,Object? member = null,Object? periodFrom = null,Object? periodTo = null,Object? sentAt = null,Object? readAt = freezed,Object? reply = null,Object? repliedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,periodFrom: null == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime,periodTo: null == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as DateTime,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,repliedAt: freezed == repliedAt ? _self.repliedAt : repliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of ReceivedReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get member {
  
  return $MemberCardCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReceivedReport].
extension ReceivedReportPatterns on ReceivedReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceivedReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceivedReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceivedReport value)  $default,){
final _that = this;
switch (_that) {
case _ReceivedReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceivedReport value)?  $default,){
final _that = this;
switch (_that) {
case _ReceivedReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int authorityId,  MemberCard member, @ApiDateConverter()  DateTime periodFrom, @ApiDateConverter()  DateTime periodTo,  DateTime sentAt,  DateTime? readAt,  String reply,  DateTime? repliedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceivedReport() when $default != null:
return $default(_that.id,_that.authorityId,_that.member,_that.periodFrom,_that.periodTo,_that.sentAt,_that.readAt,_that.reply,_that.repliedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int authorityId,  MemberCard member, @ApiDateConverter()  DateTime periodFrom, @ApiDateConverter()  DateTime periodTo,  DateTime sentAt,  DateTime? readAt,  String reply,  DateTime? repliedAt)  $default,) {final _that = this;
switch (_that) {
case _ReceivedReport():
return $default(_that.id,_that.authorityId,_that.member,_that.periodFrom,_that.periodTo,_that.sentAt,_that.readAt,_that.reply,_that.repliedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int authorityId,  MemberCard member, @ApiDateConverter()  DateTime periodFrom, @ApiDateConverter()  DateTime periodTo,  DateTime sentAt,  DateTime? readAt,  String reply,  DateTime? repliedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReceivedReport() when $default != null:
return $default(_that.id,_that.authorityId,_that.member,_that.periodFrom,_that.periodTo,_that.sentAt,_that.readAt,_that.reply,_that.repliedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReceivedReport extends ReceivedReport {
  const _ReceivedReport({required this.id, required this.authorityId, required this.member, @ApiDateConverter() required this.periodFrom, @ApiDateConverter() required this.periodTo, required this.sentAt, this.readAt, this.reply = '', this.repliedAt}): super._();
  factory _ReceivedReport.fromJson(Map<String, dynamic> json) => _$ReceivedReportFromJson(json);

@override final  int id;
@override final  int authorityId;
/// The disciple.
@override final  MemberCard member;
@override@ApiDateConverter() final  DateTime periodFrom;
@override@ApiDateConverter() final  DateTime periodTo;
@override final  DateTime sentAt;
@override final  DateTime? readAt;
/// The user's answer, '' before it.
@override@JsonKey() final  String reply;
@override final  DateTime? repliedAt;

/// Create a copy of ReceivedReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceivedReportCopyWith<_ReceivedReport> get copyWith => __$ReceivedReportCopyWithImpl<_ReceivedReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceivedReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceivedReport&&(identical(other.id, id) || other.id == id)&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.member, member) || other.member == member)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorityId,member,periodFrom,periodTo,sentAt,readAt,reply,repliedAt);

@override
String toString() {
  return 'ReceivedReport(id: $id, authorityId: $authorityId, member: $member, periodFrom: $periodFrom, periodTo: $periodTo, sentAt: $sentAt, readAt: $readAt, reply: $reply, repliedAt: $repliedAt)';
}


}

/// @nodoc
abstract mixin class _$ReceivedReportCopyWith<$Res> implements $ReceivedReportCopyWith<$Res> {
  factory _$ReceivedReportCopyWith(_ReceivedReport value, $Res Function(_ReceivedReport) _then) = __$ReceivedReportCopyWithImpl;
@override @useResult
$Res call({
 int id, int authorityId, MemberCard member,@ApiDateConverter() DateTime periodFrom,@ApiDateConverter() DateTime periodTo, DateTime sentAt, DateTime? readAt, String reply, DateTime? repliedAt
});


@override $MemberCardCopyWith<$Res> get member;

}
/// @nodoc
class __$ReceivedReportCopyWithImpl<$Res>
    implements _$ReceivedReportCopyWith<$Res> {
  __$ReceivedReportCopyWithImpl(this._self, this._then);

  final _ReceivedReport _self;
  final $Res Function(_ReceivedReport) _then;

/// Create a copy of ReceivedReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorityId = null,Object? member = null,Object? periodFrom = null,Object? periodTo = null,Object? sentAt = null,Object? readAt = freezed,Object? reply = null,Object? repliedAt = freezed,}) {
  return _then(_ReceivedReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberCard,periodFrom: null == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime,periodTo: null == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as DateTime,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,repliedAt: freezed == repliedAt ? _self.repliedAt : repliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of ReceivedReport
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
