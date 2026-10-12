// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hymn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HymnPart {

@JsonKey(unknownEnumValue: HymnPartKind.verse) HymnPartKind get kind; String? get label; int get repeat; List<String> get lines;
/// Create a copy of HymnPart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnPartCopyWith<HymnPart> get copyWith => _$HymnPartCopyWithImpl<HymnPart>(this as HymnPart, _$identity);

  /// Serializes this HymnPart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HymnPart&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&const DeepCollectionEquality().equals(other.lines, lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,label,repeat,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'HymnPart(kind: $kind, label: $label, repeat: $repeat, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $HymnPartCopyWith<$Res>  {
  factory $HymnPartCopyWith(HymnPart value, $Res Function(HymnPart) _then) = _$HymnPartCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: HymnPartKind.verse) HymnPartKind kind, String? label, int repeat, List<String> lines
});




}
/// @nodoc
class _$HymnPartCopyWithImpl<$Res>
    implements $HymnPartCopyWith<$Res> {
  _$HymnPartCopyWithImpl(this._self, this._then);

  final HymnPart _self;
  final $Res Function(HymnPart) _then;

/// Create a copy of HymnPart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? label = freezed,Object? repeat = null,Object? lines = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as HymnPartKind,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as int,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [HymnPart].
extension HymnPartPatterns on HymnPart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HymnPart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HymnPart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HymnPart value)  $default,){
final _that = this;
switch (_that) {
case _HymnPart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HymnPart value)?  $default,){
final _that = this;
switch (_that) {
case _HymnPart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: HymnPartKind.verse)  HymnPartKind kind,  String? label,  int repeat,  List<String> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HymnPart() when $default != null:
return $default(_that.kind,_that.label,_that.repeat,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: HymnPartKind.verse)  HymnPartKind kind,  String? label,  int repeat,  List<String> lines)  $default,) {final _that = this;
switch (_that) {
case _HymnPart():
return $default(_that.kind,_that.label,_that.repeat,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: HymnPartKind.verse)  HymnPartKind kind,  String? label,  int repeat,  List<String> lines)?  $default,) {final _that = this;
switch (_that) {
case _HymnPart() when $default != null:
return $default(_that.kind,_that.label,_that.repeat,_that.lines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HymnPart implements HymnPart {
  const _HymnPart({@JsonKey(unknownEnumValue: HymnPartKind.verse) required this.kind, this.label, this.repeat = 0, required final  List<String> lines}): _lines = lines;
  factory _HymnPart.fromJson(Map<String, dynamic> json) => _$HymnPartFromJson(json);

@override@JsonKey(unknownEnumValue: HymnPartKind.verse) final  HymnPartKind kind;
@override final  String? label;
@override@JsonKey() final  int repeat;
 final  List<String> _lines;
@override List<String> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of HymnPart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnPartCopyWith<_HymnPart> get copyWith => __$HymnPartCopyWithImpl<_HymnPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HymnPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HymnPart&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&const DeepCollectionEquality().equals(other._lines, _lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,label,repeat,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'HymnPart(kind: $kind, label: $label, repeat: $repeat, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$HymnPartCopyWith<$Res> implements $HymnPartCopyWith<$Res> {
  factory _$HymnPartCopyWith(_HymnPart value, $Res Function(_HymnPart) _then) = __$HymnPartCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: HymnPartKind.verse) HymnPartKind kind, String? label, int repeat, List<String> lines
});




}
/// @nodoc
class __$HymnPartCopyWithImpl<$Res>
    implements _$HymnPartCopyWith<$Res> {
  __$HymnPartCopyWithImpl(this._self, this._then);

  final _HymnPart _self;
  final $Res Function(_HymnPart) _then;

/// Create a copy of HymnPart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? label = freezed,Object? repeat = null,Object? lines = null,}) {
  return _then(_HymnPart(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as HymnPartKind,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as int,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$Hymn {

 int get number; String get title;/// Words / music credit printed under the hymn, when the book has one.
 String? get author; String get firstLine; List<HymnPart> get parts;
/// Create a copy of Hymn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnCopyWith<Hymn> get copyWith => _$HymnCopyWithImpl<Hymn>(this as Hymn, _$identity);

  /// Serializes this Hymn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hymn&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.firstLine, firstLine) || other.firstLine == firstLine)&&const DeepCollectionEquality().equals(other.parts, parts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,title,author,firstLine,const DeepCollectionEquality().hash(parts));

@override
String toString() {
  return 'Hymn(number: $number, title: $title, author: $author, firstLine: $firstLine, parts: $parts)';
}


}

/// @nodoc
abstract mixin class $HymnCopyWith<$Res>  {
  factory $HymnCopyWith(Hymn value, $Res Function(Hymn) _then) = _$HymnCopyWithImpl;
@useResult
$Res call({
 int number, String title, String? author, String firstLine, List<HymnPart> parts
});




}
/// @nodoc
class _$HymnCopyWithImpl<$Res>
    implements $HymnCopyWith<$Res> {
  _$HymnCopyWithImpl(this._self, this._then);

  final Hymn _self;
  final $Res Function(Hymn) _then;

/// Create a copy of Hymn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? title = null,Object? author = freezed,Object? firstLine = null,Object? parts = null,}) {
  return _then(_self.copyWith(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,firstLine: null == firstLine ? _self.firstLine : firstLine // ignore: cast_nullable_to_non_nullable
as String,parts: null == parts ? _self.parts : parts // ignore: cast_nullable_to_non_nullable
as List<HymnPart>,
  ));
}

}


/// Adds pattern-matching-related methods to [Hymn].
extension HymnPatterns on Hymn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hymn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hymn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hymn value)  $default,){
final _that = this;
switch (_that) {
case _Hymn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hymn value)?  $default,){
final _that = this;
switch (_that) {
case _Hymn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String title,  String? author,  String firstLine,  List<HymnPart> parts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hymn() when $default != null:
return $default(_that.number,_that.title,_that.author,_that.firstLine,_that.parts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String title,  String? author,  String firstLine,  List<HymnPart> parts)  $default,) {final _that = this;
switch (_that) {
case _Hymn():
return $default(_that.number,_that.title,_that.author,_that.firstLine,_that.parts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String title,  String? author,  String firstLine,  List<HymnPart> parts)?  $default,) {final _that = this;
switch (_that) {
case _Hymn() when $default != null:
return $default(_that.number,_that.title,_that.author,_that.firstLine,_that.parts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hymn implements Hymn {
  const _Hymn({required this.number, required this.title, this.author, this.firstLine = '', required final  List<HymnPart> parts}): _parts = parts;
  factory _Hymn.fromJson(Map<String, dynamic> json) => _$HymnFromJson(json);

@override final  int number;
@override final  String title;
/// Words / music credit printed under the hymn, when the book has one.
@override final  String? author;
@override@JsonKey() final  String firstLine;
 final  List<HymnPart> _parts;
@override List<HymnPart> get parts {
  if (_parts is EqualUnmodifiableListView) return _parts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parts);
}


/// Create a copy of Hymn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnCopyWith<_Hymn> get copyWith => __$HymnCopyWithImpl<_Hymn>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HymnToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hymn&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.firstLine, firstLine) || other.firstLine == firstLine)&&const DeepCollectionEquality().equals(other._parts, _parts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,title,author,firstLine,const DeepCollectionEquality().hash(_parts));

@override
String toString() {
  return 'Hymn(number: $number, title: $title, author: $author, firstLine: $firstLine, parts: $parts)';
}


}

/// @nodoc
abstract mixin class _$HymnCopyWith<$Res> implements $HymnCopyWith<$Res> {
  factory _$HymnCopyWith(_Hymn value, $Res Function(_Hymn) _then) = __$HymnCopyWithImpl;
@override @useResult
$Res call({
 int number, String title, String? author, String firstLine, List<HymnPart> parts
});




}
/// @nodoc
class __$HymnCopyWithImpl<$Res>
    implements _$HymnCopyWith<$Res> {
  __$HymnCopyWithImpl(this._self, this._then);

  final _Hymn _self;
  final $Res Function(_Hymn) _then;

/// Create a copy of Hymn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? title = null,Object? author = freezed,Object? firstLine = null,Object? parts = null,}) {
  return _then(_Hymn(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,firstLine: null == firstLine ? _self.firstLine : firstLine // ignore: cast_nullable_to_non_nullable
as String,parts: null == parts ? _self._parts : parts // ignore: cast_nullable_to_non_nullable
as List<HymnPart>,
  ));
}


}


/// @nodoc
mixin _$HymnBook {

 String get code; String get title; String get language; int get hymnCount;/// Changes each time the book changes on the server.
 String get version; List<Hymn> get hymns;
/// Create a copy of HymnBook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnBookCopyWith<HymnBook> get copyWith => _$HymnBookCopyWithImpl<HymnBook>(this as HymnBook, _$identity);

  /// Serializes this HymnBook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HymnBook&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.language, language) || other.language == language)&&(identical(other.hymnCount, hymnCount) || other.hymnCount == hymnCount)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.hymns, hymns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,language,hymnCount,version,const DeepCollectionEquality().hash(hymns));

@override
String toString() {
  return 'HymnBook(code: $code, title: $title, language: $language, hymnCount: $hymnCount, version: $version, hymns: $hymns)';
}


}

/// @nodoc
abstract mixin class $HymnBookCopyWith<$Res>  {
  factory $HymnBookCopyWith(HymnBook value, $Res Function(HymnBook) _then) = _$HymnBookCopyWithImpl;
@useResult
$Res call({
 String code, String title, String language, int hymnCount, String version, List<Hymn> hymns
});




}
/// @nodoc
class _$HymnBookCopyWithImpl<$Res>
    implements $HymnBookCopyWith<$Res> {
  _$HymnBookCopyWithImpl(this._self, this._then);

  final HymnBook _self;
  final $Res Function(HymnBook) _then;

/// Create a copy of HymnBook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? title = null,Object? language = null,Object? hymnCount = null,Object? version = null,Object? hymns = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,hymnCount: null == hymnCount ? _self.hymnCount : hymnCount // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,hymns: null == hymns ? _self.hymns : hymns // ignore: cast_nullable_to_non_nullable
as List<Hymn>,
  ));
}

}


/// Adds pattern-matching-related methods to [HymnBook].
extension HymnBookPatterns on HymnBook {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HymnBook value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HymnBook() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HymnBook value)  $default,){
final _that = this;
switch (_that) {
case _HymnBook():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HymnBook value)?  $default,){
final _that = this;
switch (_that) {
case _HymnBook() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String title,  String language,  int hymnCount,  String version,  List<Hymn> hymns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HymnBook() when $default != null:
return $default(_that.code,_that.title,_that.language,_that.hymnCount,_that.version,_that.hymns);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String title,  String language,  int hymnCount,  String version,  List<Hymn> hymns)  $default,) {final _that = this;
switch (_that) {
case _HymnBook():
return $default(_that.code,_that.title,_that.language,_that.hymnCount,_that.version,_that.hymns);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String title,  String language,  int hymnCount,  String version,  List<Hymn> hymns)?  $default,) {final _that = this;
switch (_that) {
case _HymnBook() when $default != null:
return $default(_that.code,_that.title,_that.language,_that.hymnCount,_that.version,_that.hymns);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HymnBook extends HymnBook {
  const _HymnBook({required this.code, required this.title, this.language = 'fr', this.hymnCount = 0, required this.version, final  List<Hymn> hymns = const <Hymn>[]}): _hymns = hymns,super._();
  factory _HymnBook.fromJson(Map<String, dynamic> json) => _$HymnBookFromJson(json);

@override final  String code;
@override final  String title;
@override@JsonKey() final  String language;
@override@JsonKey() final  int hymnCount;
/// Changes each time the book changes on the server.
@override final  String version;
 final  List<Hymn> _hymns;
@override@JsonKey() List<Hymn> get hymns {
  if (_hymns is EqualUnmodifiableListView) return _hymns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hymns);
}


/// Create a copy of HymnBook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnBookCopyWith<_HymnBook> get copyWith => __$HymnBookCopyWithImpl<_HymnBook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HymnBookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HymnBook&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.language, language) || other.language == language)&&(identical(other.hymnCount, hymnCount) || other.hymnCount == hymnCount)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._hymns, _hymns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,language,hymnCount,version,const DeepCollectionEquality().hash(_hymns));

@override
String toString() {
  return 'HymnBook(code: $code, title: $title, language: $language, hymnCount: $hymnCount, version: $version, hymns: $hymns)';
}


}

/// @nodoc
abstract mixin class _$HymnBookCopyWith<$Res> implements $HymnBookCopyWith<$Res> {
  factory _$HymnBookCopyWith(_HymnBook value, $Res Function(_HymnBook) _then) = __$HymnBookCopyWithImpl;
@override @useResult
$Res call({
 String code, String title, String language, int hymnCount, String version, List<Hymn> hymns
});




}
/// @nodoc
class __$HymnBookCopyWithImpl<$Res>
    implements _$HymnBookCopyWith<$Res> {
  __$HymnBookCopyWithImpl(this._self, this._then);

  final _HymnBook _self;
  final $Res Function(_HymnBook) _then;

/// Create a copy of HymnBook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? title = null,Object? language = null,Object? hymnCount = null,Object? version = null,Object? hymns = null,}) {
  return _then(_HymnBook(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,hymnCount: null == hymnCount ? _self.hymnCount : hymnCount // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,hymns: null == hymns ? _self._hymns : hymns // ignore: cast_nullable_to_non_nullable
as List<Hymn>,
  ));
}


}


/// @nodoc
mixin _$HymnBookSummary {

 String get code; String get title; String get language; int get hymnCount; String get version;
/// Create a copy of HymnBookSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnBookSummaryCopyWith<HymnBookSummary> get copyWith => _$HymnBookSummaryCopyWithImpl<HymnBookSummary>(this as HymnBookSummary, _$identity);

  /// Serializes this HymnBookSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HymnBookSummary&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.language, language) || other.language == language)&&(identical(other.hymnCount, hymnCount) || other.hymnCount == hymnCount)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,language,hymnCount,version);

@override
String toString() {
  return 'HymnBookSummary(code: $code, title: $title, language: $language, hymnCount: $hymnCount, version: $version)';
}


}

/// @nodoc
abstract mixin class $HymnBookSummaryCopyWith<$Res>  {
  factory $HymnBookSummaryCopyWith(HymnBookSummary value, $Res Function(HymnBookSummary) _then) = _$HymnBookSummaryCopyWithImpl;
@useResult
$Res call({
 String code, String title, String language, int hymnCount, String version
});




}
/// @nodoc
class _$HymnBookSummaryCopyWithImpl<$Res>
    implements $HymnBookSummaryCopyWith<$Res> {
  _$HymnBookSummaryCopyWithImpl(this._self, this._then);

  final HymnBookSummary _self;
  final $Res Function(HymnBookSummary) _then;

/// Create a copy of HymnBookSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? title = null,Object? language = null,Object? hymnCount = null,Object? version = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,hymnCount: null == hymnCount ? _self.hymnCount : hymnCount // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HymnBookSummary].
extension HymnBookSummaryPatterns on HymnBookSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HymnBookSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HymnBookSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HymnBookSummary value)  $default,){
final _that = this;
switch (_that) {
case _HymnBookSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HymnBookSummary value)?  $default,){
final _that = this;
switch (_that) {
case _HymnBookSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String title,  String language,  int hymnCount,  String version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HymnBookSummary() when $default != null:
return $default(_that.code,_that.title,_that.language,_that.hymnCount,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String title,  String language,  int hymnCount,  String version)  $default,) {final _that = this;
switch (_that) {
case _HymnBookSummary():
return $default(_that.code,_that.title,_that.language,_that.hymnCount,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String title,  String language,  int hymnCount,  String version)?  $default,) {final _that = this;
switch (_that) {
case _HymnBookSummary() when $default != null:
return $default(_that.code,_that.title,_that.language,_that.hymnCount,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HymnBookSummary implements HymnBookSummary {
  const _HymnBookSummary({required this.code, required this.title, this.language = 'fr', this.hymnCount = 0, required this.version});
  factory _HymnBookSummary.fromJson(Map<String, dynamic> json) => _$HymnBookSummaryFromJson(json);

@override final  String code;
@override final  String title;
@override@JsonKey() final  String language;
@override@JsonKey() final  int hymnCount;
@override final  String version;

/// Create a copy of HymnBookSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnBookSummaryCopyWith<_HymnBookSummary> get copyWith => __$HymnBookSummaryCopyWithImpl<_HymnBookSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HymnBookSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HymnBookSummary&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.language, language) || other.language == language)&&(identical(other.hymnCount, hymnCount) || other.hymnCount == hymnCount)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,language,hymnCount,version);

@override
String toString() {
  return 'HymnBookSummary(code: $code, title: $title, language: $language, hymnCount: $hymnCount, version: $version)';
}


}

/// @nodoc
abstract mixin class _$HymnBookSummaryCopyWith<$Res> implements $HymnBookSummaryCopyWith<$Res> {
  factory _$HymnBookSummaryCopyWith(_HymnBookSummary value, $Res Function(_HymnBookSummary) _then) = __$HymnBookSummaryCopyWithImpl;
@override @useResult
$Res call({
 String code, String title, String language, int hymnCount, String version
});




}
/// @nodoc
class __$HymnBookSummaryCopyWithImpl<$Res>
    implements _$HymnBookSummaryCopyWith<$Res> {
  __$HymnBookSummaryCopyWithImpl(this._self, this._then);

  final _HymnBookSummary _self;
  final $Res Function(_HymnBookSummary) _then;

/// Create a copy of HymnBookSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? title = null,Object? language = null,Object? hymnCount = null,Object? version = null,}) {
  return _then(_HymnBookSummary(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,hymnCount: null == hymnCount ? _self.hymnCount : hymnCount // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$HymnRef {

 String get bookCode; int get number;
/// Create a copy of HymnRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnRefCopyWith<HymnRef> get copyWith => _$HymnRefCopyWithImpl<HymnRef>(this as HymnRef, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HymnRef&&(identical(other.bookCode, bookCode) || other.bookCode == bookCode)&&(identical(other.number, number) || other.number == number));
}


@override
int get hashCode => Object.hash(runtimeType,bookCode,number);

@override
String toString() {
  return 'HymnRef(bookCode: $bookCode, number: $number)';
}


}

/// @nodoc
abstract mixin class $HymnRefCopyWith<$Res>  {
  factory $HymnRefCopyWith(HymnRef value, $Res Function(HymnRef) _then) = _$HymnRefCopyWithImpl;
@useResult
$Res call({
 String bookCode, int number
});




}
/// @nodoc
class _$HymnRefCopyWithImpl<$Res>
    implements $HymnRefCopyWith<$Res> {
  _$HymnRefCopyWithImpl(this._self, this._then);

  final HymnRef _self;
  final $Res Function(HymnRef) _then;

/// Create a copy of HymnRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookCode = null,Object? number = null,}) {
  return _then(_self.copyWith(
bookCode: null == bookCode ? _self.bookCode : bookCode // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HymnRef].
extension HymnRefPatterns on HymnRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HymnRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HymnRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HymnRef value)  $default,){
final _that = this;
switch (_that) {
case _HymnRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HymnRef value)?  $default,){
final _that = this;
switch (_that) {
case _HymnRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bookCode,  int number)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HymnRef() when $default != null:
return $default(_that.bookCode,_that.number);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bookCode,  int number)  $default,) {final _that = this;
switch (_that) {
case _HymnRef():
return $default(_that.bookCode,_that.number);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bookCode,  int number)?  $default,) {final _that = this;
switch (_that) {
case _HymnRef() when $default != null:
return $default(_that.bookCode,_that.number);case _:
  return null;

}
}

}

/// @nodoc


class _HymnRef extends HymnRef {
  const _HymnRef({required this.bookCode, required this.number}): super._();
  

@override final  String bookCode;
@override final  int number;

/// Create a copy of HymnRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnRefCopyWith<_HymnRef> get copyWith => __$HymnRefCopyWithImpl<_HymnRef>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HymnRef&&(identical(other.bookCode, bookCode) || other.bookCode == bookCode)&&(identical(other.number, number) || other.number == number));
}


@override
int get hashCode => Object.hash(runtimeType,bookCode,number);

@override
String toString() {
  return 'HymnRef(bookCode: $bookCode, number: $number)';
}


}

/// @nodoc
abstract mixin class _$HymnRefCopyWith<$Res> implements $HymnRefCopyWith<$Res> {
  factory _$HymnRefCopyWith(_HymnRef value, $Res Function(_HymnRef) _then) = __$HymnRefCopyWithImpl;
@override @useResult
$Res call({
 String bookCode, int number
});




}
/// @nodoc
class __$HymnRefCopyWithImpl<$Res>
    implements _$HymnRefCopyWith<$Res> {
  __$HymnRefCopyWithImpl(this._self, this._then);

  final _HymnRef _self;
  final $Res Function(_HymnRef) _then;

/// Create a copy of HymnRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookCode = null,Object? number = null,}) {
  return _then(_HymnRef(
bookCode: null == bookCode ? _self.bookCode : bookCode // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
