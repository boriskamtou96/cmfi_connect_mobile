// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_marks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BibleMark {

/// The verse, the same in every version ("JHN.3.16").
 String get key; String get text;/// The version's abbreviation when it was marked ("LSG").
 String get version; DateTime get at;/// Index in [BibleMarks.colors]; null: not highlighted.
 int? get color; bool get bookmarked;
/// Create a copy of BibleMark
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BibleMarkCopyWith<BibleMark> get copyWith => _$BibleMarkCopyWithImpl<BibleMark>(this as BibleMark, _$identity);

  /// Serializes this BibleMark to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BibleMark&&(identical(other.key, key) || other.key == key)&&(identical(other.text, text) || other.text == text)&&(identical(other.version, version) || other.version == version)&&(identical(other.at, at) || other.at == at)&&(identical(other.color, color) || other.color == color)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,text,version,at,color,bookmarked);

@override
String toString() {
  return 'BibleMark(key: $key, text: $text, version: $version, at: $at, color: $color, bookmarked: $bookmarked)';
}


}

/// @nodoc
abstract mixin class $BibleMarkCopyWith<$Res>  {
  factory $BibleMarkCopyWith(BibleMark value, $Res Function(BibleMark) _then) = _$BibleMarkCopyWithImpl;
@useResult
$Res call({
 String key, String text, String version, DateTime at, int? color, bool bookmarked
});




}
/// @nodoc
class _$BibleMarkCopyWithImpl<$Res>
    implements $BibleMarkCopyWith<$Res> {
  _$BibleMarkCopyWithImpl(this._self, this._then);

  final BibleMark _self;
  final $Res Function(BibleMark) _then;

/// Create a copy of BibleMark
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? text = null,Object? version = null,Object? at = null,Object? color = freezed,Object? bookmarked = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int?,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BibleMark].
extension BibleMarkPatterns on BibleMark {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BibleMark value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BibleMark() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BibleMark value)  $default,){
final _that = this;
switch (_that) {
case _BibleMark():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BibleMark value)?  $default,){
final _that = this;
switch (_that) {
case _BibleMark() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String text,  String version,  DateTime at,  int? color,  bool bookmarked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BibleMark() when $default != null:
return $default(_that.key,_that.text,_that.version,_that.at,_that.color,_that.bookmarked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String text,  String version,  DateTime at,  int? color,  bool bookmarked)  $default,) {final _that = this;
switch (_that) {
case _BibleMark():
return $default(_that.key,_that.text,_that.version,_that.at,_that.color,_that.bookmarked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String text,  String version,  DateTime at,  int? color,  bool bookmarked)?  $default,) {final _that = this;
switch (_that) {
case _BibleMark() when $default != null:
return $default(_that.key,_that.text,_that.version,_that.at,_that.color,_that.bookmarked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BibleMark extends BibleMark {
  const _BibleMark({required this.key, required this.text, required this.version, required this.at, this.color, this.bookmarked = false}): super._();
  factory _BibleMark.fromJson(Map<String, dynamic> json) => _$BibleMarkFromJson(json);

/// The verse, the same in every version ("JHN.3.16").
@override final  String key;
@override final  String text;
/// The version's abbreviation when it was marked ("LSG").
@override final  String version;
@override final  DateTime at;
/// Index in [BibleMarks.colors]; null: not highlighted.
@override final  int? color;
@override@JsonKey() final  bool bookmarked;

/// Create a copy of BibleMark
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BibleMarkCopyWith<_BibleMark> get copyWith => __$BibleMarkCopyWithImpl<_BibleMark>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BibleMarkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BibleMark&&(identical(other.key, key) || other.key == key)&&(identical(other.text, text) || other.text == text)&&(identical(other.version, version) || other.version == version)&&(identical(other.at, at) || other.at == at)&&(identical(other.color, color) || other.color == color)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,text,version,at,color,bookmarked);

@override
String toString() {
  return 'BibleMark(key: $key, text: $text, version: $version, at: $at, color: $color, bookmarked: $bookmarked)';
}


}

/// @nodoc
abstract mixin class _$BibleMarkCopyWith<$Res> implements $BibleMarkCopyWith<$Res> {
  factory _$BibleMarkCopyWith(_BibleMark value, $Res Function(_BibleMark) _then) = __$BibleMarkCopyWithImpl;
@override @useResult
$Res call({
 String key, String text, String version, DateTime at, int? color, bool bookmarked
});




}
/// @nodoc
class __$BibleMarkCopyWithImpl<$Res>
    implements _$BibleMarkCopyWith<$Res> {
  __$BibleMarkCopyWithImpl(this._self, this._then);

  final _BibleMark _self;
  final $Res Function(_BibleMark) _then;

/// Create a copy of BibleMark
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? text = null,Object? version = null,Object? at = null,Object? color = freezed,Object? bookmarked = null,}) {
  return _then(_BibleMark(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int?,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
