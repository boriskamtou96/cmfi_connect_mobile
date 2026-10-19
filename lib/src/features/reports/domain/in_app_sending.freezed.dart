// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'in_app_sending.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InAppSending {

 int get id; int get authorityId;@ApiDateConverter() DateTime get periodFrom;@ApiDateConverter() DateTime get periodTo; DateTime get sentAt; DateTime? get readAt;/// '' before an answer.
 String get reply; DateTime? get repliedAt;
/// Create a copy of InAppSending
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InAppSendingCopyWith<InAppSending> get copyWith => _$InAppSendingCopyWithImpl<InAppSending>(this as InAppSending, _$identity);

  /// Serializes this InAppSending to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InAppSending&&(identical(other.id, id) || other.id == id)&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorityId,periodFrom,periodTo,sentAt,readAt,reply,repliedAt);

@override
String toString() {
  return 'InAppSending(id: $id, authorityId: $authorityId, periodFrom: $periodFrom, periodTo: $periodTo, sentAt: $sentAt, readAt: $readAt, reply: $reply, repliedAt: $repliedAt)';
}


}

/// @nodoc
abstract mixin class $InAppSendingCopyWith<$Res>  {
  factory $InAppSendingCopyWith(InAppSending value, $Res Function(InAppSending) _then) = _$InAppSendingCopyWithImpl;
@useResult
$Res call({
 int id, int authorityId,@ApiDateConverter() DateTime periodFrom,@ApiDateConverter() DateTime periodTo, DateTime sentAt, DateTime? readAt, String reply, DateTime? repliedAt
});




}
/// @nodoc
class _$InAppSendingCopyWithImpl<$Res>
    implements $InAppSendingCopyWith<$Res> {
  _$InAppSendingCopyWithImpl(this._self, this._then);

  final InAppSending _self;
  final $Res Function(InAppSending) _then;

/// Create a copy of InAppSending
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorityId = null,Object? periodFrom = null,Object? periodTo = null,Object? sentAt = null,Object? readAt = freezed,Object? reply = null,Object? repliedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,periodFrom: null == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime,periodTo: null == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as DateTime,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,repliedAt: freezed == repliedAt ? _self.repliedAt : repliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InAppSending].
extension InAppSendingPatterns on InAppSending {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InAppSending value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InAppSending() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InAppSending value)  $default,){
final _that = this;
switch (_that) {
case _InAppSending():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InAppSending value)?  $default,){
final _that = this;
switch (_that) {
case _InAppSending() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int authorityId, @ApiDateConverter()  DateTime periodFrom, @ApiDateConverter()  DateTime periodTo,  DateTime sentAt,  DateTime? readAt,  String reply,  DateTime? repliedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InAppSending() when $default != null:
return $default(_that.id,_that.authorityId,_that.periodFrom,_that.periodTo,_that.sentAt,_that.readAt,_that.reply,_that.repliedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int authorityId, @ApiDateConverter()  DateTime periodFrom, @ApiDateConverter()  DateTime periodTo,  DateTime sentAt,  DateTime? readAt,  String reply,  DateTime? repliedAt)  $default,) {final _that = this;
switch (_that) {
case _InAppSending():
return $default(_that.id,_that.authorityId,_that.periodFrom,_that.periodTo,_that.sentAt,_that.readAt,_that.reply,_that.repliedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int authorityId, @ApiDateConverter()  DateTime periodFrom, @ApiDateConverter()  DateTime periodTo,  DateTime sentAt,  DateTime? readAt,  String reply,  DateTime? repliedAt)?  $default,) {final _that = this;
switch (_that) {
case _InAppSending() when $default != null:
return $default(_that.id,_that.authorityId,_that.periodFrom,_that.periodTo,_that.sentAt,_that.readAt,_that.reply,_that.repliedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InAppSending implements InAppSending {
  const _InAppSending({required this.id, required this.authorityId, @ApiDateConverter() required this.periodFrom, @ApiDateConverter() required this.periodTo, required this.sentAt, this.readAt, this.reply = '', this.repliedAt});
  factory _InAppSending.fromJson(Map<String, dynamic> json) => _$InAppSendingFromJson(json);

@override final  int id;
@override final  int authorityId;
@override@ApiDateConverter() final  DateTime periodFrom;
@override@ApiDateConverter() final  DateTime periodTo;
@override final  DateTime sentAt;
@override final  DateTime? readAt;
/// '' before an answer.
@override@JsonKey() final  String reply;
@override final  DateTime? repliedAt;

/// Create a copy of InAppSending
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InAppSendingCopyWith<_InAppSending> get copyWith => __$InAppSendingCopyWithImpl<_InAppSending>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InAppSendingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InAppSending&&(identical(other.id, id) || other.id == id)&&(identical(other.authorityId, authorityId) || other.authorityId == authorityId)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorityId,periodFrom,periodTo,sentAt,readAt,reply,repliedAt);

@override
String toString() {
  return 'InAppSending(id: $id, authorityId: $authorityId, periodFrom: $periodFrom, periodTo: $periodTo, sentAt: $sentAt, readAt: $readAt, reply: $reply, repliedAt: $repliedAt)';
}


}

/// @nodoc
abstract mixin class _$InAppSendingCopyWith<$Res> implements $InAppSendingCopyWith<$Res> {
  factory _$InAppSendingCopyWith(_InAppSending value, $Res Function(_InAppSending) _then) = __$InAppSendingCopyWithImpl;
@override @useResult
$Res call({
 int id, int authorityId,@ApiDateConverter() DateTime periodFrom,@ApiDateConverter() DateTime periodTo, DateTime sentAt, DateTime? readAt, String reply, DateTime? repliedAt
});




}
/// @nodoc
class __$InAppSendingCopyWithImpl<$Res>
    implements _$InAppSendingCopyWith<$Res> {
  __$InAppSendingCopyWithImpl(this._self, this._then);

  final _InAppSending _self;
  final $Res Function(_InAppSending) _then;

/// Create a copy of InAppSending
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorityId = null,Object? periodFrom = null,Object? periodTo = null,Object? sentAt = null,Object? readAt = freezed,Object? reply = null,Object? repliedAt = freezed,}) {
  return _then(_InAppSending(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,authorityId: null == authorityId ? _self.authorityId : authorityId // ignore: cast_nullable_to_non_nullable
as int,periodFrom: null == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime,periodTo: null == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as DateTime,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,repliedAt: freezed == repliedAt ? _self.repliedAt : repliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
