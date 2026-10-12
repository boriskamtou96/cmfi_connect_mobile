// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventImage {

 int get id;/// "/v1/media/3f91….jpg", relative to the API origin.
 String get url; int get width; int get height;/// "#1F4D3A", or ''.
 String get color;
/// Create a copy of EventImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventImageCopyWith<EventImage> get copyWith => _$EventImageCopyWithImpl<EventImage>(this as EventImage, _$identity);

  /// Serializes this EventImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,width,height,color);

@override
String toString() {
  return 'EventImage(id: $id, url: $url, width: $width, height: $height, color: $color)';
}


}

/// @nodoc
abstract mixin class $EventImageCopyWith<$Res>  {
  factory $EventImageCopyWith(EventImage value, $Res Function(EventImage) _then) = _$EventImageCopyWithImpl;
@useResult
$Res call({
 int id, String url, int width, int height, String color
});




}
/// @nodoc
class _$EventImageCopyWithImpl<$Res>
    implements $EventImageCopyWith<$Res> {
  _$EventImageCopyWithImpl(this._self, this._then);

  final EventImage _self;
  final $Res Function(EventImage) _then;

/// Create a copy of EventImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? width = null,Object? height = null,Object? color = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EventImage].
extension EventImagePatterns on EventImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventImage value)  $default,){
final _that = this;
switch (_that) {
case _EventImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventImage value)?  $default,){
final _that = this;
switch (_that) {
case _EventImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String url,  int width,  int height,  String color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventImage() when $default != null:
return $default(_that.id,_that.url,_that.width,_that.height,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String url,  int width,  int height,  String color)  $default,) {final _that = this;
switch (_that) {
case _EventImage():
return $default(_that.id,_that.url,_that.width,_that.height,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String url,  int width,  int height,  String color)?  $default,) {final _that = this;
switch (_that) {
case _EventImage() when $default != null:
return $default(_that.id,_that.url,_that.width,_that.height,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventImage extends EventImage {
  const _EventImage({required this.id, required this.url, this.width = 0, this.height = 0, this.color = ''}): super._();
  factory _EventImage.fromJson(Map<String, dynamic> json) => _$EventImageFromJson(json);

@override final  int id;
/// "/v1/media/3f91….jpg", relative to the API origin.
@override final  String url;
@override@JsonKey() final  int width;
@override@JsonKey() final  int height;
/// "#1F4D3A", or ''.
@override@JsonKey() final  String color;

/// Create a copy of EventImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventImageCopyWith<_EventImage> get copyWith => __$EventImageCopyWithImpl<_EventImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,width,height,color);

@override
String toString() {
  return 'EventImage(id: $id, url: $url, width: $width, height: $height, color: $color)';
}


}

/// @nodoc
abstract mixin class _$EventImageCopyWith<$Res> implements $EventImageCopyWith<$Res> {
  factory _$EventImageCopyWith(_EventImage value, $Res Function(_EventImage) _then) = __$EventImageCopyWithImpl;
@override @useResult
$Res call({
 int id, String url, int width, int height, String color
});




}
/// @nodoc
class __$EventImageCopyWithImpl<$Res>
    implements _$EventImageCopyWith<$Res> {
  __$EventImageCopyWithImpl(this._self, this._then);

  final _EventImage _self;
  final $Res Function(_EventImage) _then;

/// Create a copy of EventImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? width = null,Object? height = null,Object? color = null,}) {
  return _then(_EventImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegistrationSummary {

@JsonKey(unknownEnumValue: RegistrationState.closed) RegistrationState get state; bool get registered; int get registrations; int get people;
/// Create a copy of RegistrationSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationSummaryCopyWith<RegistrationSummary> get copyWith => _$RegistrationSummaryCopyWithImpl<RegistrationSummary>(this as RegistrationSummary, _$identity);

  /// Serializes this RegistrationSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationSummary&&(identical(other.state, state) || other.state == state)&&(identical(other.registered, registered) || other.registered == registered)&&(identical(other.registrations, registrations) || other.registrations == registrations)&&(identical(other.people, people) || other.people == people));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,registered,registrations,people);

@override
String toString() {
  return 'RegistrationSummary(state: $state, registered: $registered, registrations: $registrations, people: $people)';
}


}

/// @nodoc
abstract mixin class $RegistrationSummaryCopyWith<$Res>  {
  factory $RegistrationSummaryCopyWith(RegistrationSummary value, $Res Function(RegistrationSummary) _then) = _$RegistrationSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: RegistrationState.closed) RegistrationState state, bool registered, int registrations, int people
});




}
/// @nodoc
class _$RegistrationSummaryCopyWithImpl<$Res>
    implements $RegistrationSummaryCopyWith<$Res> {
  _$RegistrationSummaryCopyWithImpl(this._self, this._then);

  final RegistrationSummary _self;
  final $Res Function(RegistrationSummary) _then;

/// Create a copy of RegistrationSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? registered = null,Object? registrations = null,Object? people = null,}) {
  return _then(_self.copyWith(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RegistrationState,registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,registrations: null == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationSummary].
extension RegistrationSummaryPatterns on RegistrationSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationSummary value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationSummary value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RegistrationState.closed)  RegistrationState state,  bool registered,  int registrations,  int people)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegistrationSummary() when $default != null:
return $default(_that.state,_that.registered,_that.registrations,_that.people);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RegistrationState.closed)  RegistrationState state,  bool registered,  int registrations,  int people)  $default,) {final _that = this;
switch (_that) {
case _RegistrationSummary():
return $default(_that.state,_that.registered,_that.registrations,_that.people);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: RegistrationState.closed)  RegistrationState state,  bool registered,  int registrations,  int people)?  $default,) {final _that = this;
switch (_that) {
case _RegistrationSummary() when $default != null:
return $default(_that.state,_that.registered,_that.registrations,_that.people);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegistrationSummary implements RegistrationSummary {
  const _RegistrationSummary({@JsonKey(unknownEnumValue: RegistrationState.closed) this.state = RegistrationState.closed, this.registered = false, this.registrations = 0, this.people = 0});
  factory _RegistrationSummary.fromJson(Map<String, dynamic> json) => _$RegistrationSummaryFromJson(json);

@override@JsonKey(unknownEnumValue: RegistrationState.closed) final  RegistrationState state;
@override@JsonKey() final  bool registered;
@override@JsonKey() final  int registrations;
@override@JsonKey() final  int people;

/// Create a copy of RegistrationSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationSummaryCopyWith<_RegistrationSummary> get copyWith => __$RegistrationSummaryCopyWithImpl<_RegistrationSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegistrationSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationSummary&&(identical(other.state, state) || other.state == state)&&(identical(other.registered, registered) || other.registered == registered)&&(identical(other.registrations, registrations) || other.registrations == registrations)&&(identical(other.people, people) || other.people == people));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,registered,registrations,people);

@override
String toString() {
  return 'RegistrationSummary(state: $state, registered: $registered, registrations: $registrations, people: $people)';
}


}

/// @nodoc
abstract mixin class _$RegistrationSummaryCopyWith<$Res> implements $RegistrationSummaryCopyWith<$Res> {
  factory _$RegistrationSummaryCopyWith(_RegistrationSummary value, $Res Function(_RegistrationSummary) _then) = __$RegistrationSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: RegistrationState.closed) RegistrationState state, bool registered, int registrations, int people
});




}
/// @nodoc
class __$RegistrationSummaryCopyWithImpl<$Res>
    implements _$RegistrationSummaryCopyWith<$Res> {
  __$RegistrationSummaryCopyWithImpl(this._self, this._then);

  final _RegistrationSummary _self;
  final $Res Function(_RegistrationSummary) _then;

/// Create a copy of RegistrationSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? registered = null,Object? registrations = null,Object? people = null,}) {
  return _then(_RegistrationSummary(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RegistrationState,registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,registrations: null == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SessionHymn {

 String get book; int get number;
/// Create a copy of SessionHymn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionHymnCopyWith<SessionHymn> get copyWith => _$SessionHymnCopyWithImpl<SessionHymn>(this as SessionHymn, _$identity);

  /// Serializes this SessionHymn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionHymn&&(identical(other.book, book) || other.book == book)&&(identical(other.number, number) || other.number == number));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,number);

@override
String toString() {
  return 'SessionHymn(book: $book, number: $number)';
}


}

/// @nodoc
abstract mixin class $SessionHymnCopyWith<$Res>  {
  factory $SessionHymnCopyWith(SessionHymn value, $Res Function(SessionHymn) _then) = _$SessionHymnCopyWithImpl;
@useResult
$Res call({
 String book, int number
});




}
/// @nodoc
class _$SessionHymnCopyWithImpl<$Res>
    implements $SessionHymnCopyWith<$Res> {
  _$SessionHymnCopyWithImpl(this._self, this._then);

  final SessionHymn _self;
  final $Res Function(SessionHymn) _then;

/// Create a copy of SessionHymn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? number = null,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionHymn].
extension SessionHymnPatterns on SessionHymn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionHymn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionHymn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionHymn value)  $default,){
final _that = this;
switch (_that) {
case _SessionHymn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionHymn value)?  $default,){
final _that = this;
switch (_that) {
case _SessionHymn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String book,  int number)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionHymn() when $default != null:
return $default(_that.book,_that.number);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String book,  int number)  $default,) {final _that = this;
switch (_that) {
case _SessionHymn():
return $default(_that.book,_that.number);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String book,  int number)?  $default,) {final _that = this;
switch (_that) {
case _SessionHymn() when $default != null:
return $default(_that.book,_that.number);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionHymn implements SessionHymn {
  const _SessionHymn({required this.book, required this.number});
  factory _SessionHymn.fromJson(Map<String, dynamic> json) => _$SessionHymnFromJson(json);

@override final  String book;
@override final  int number;

/// Create a copy of SessionHymn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionHymnCopyWith<_SessionHymn> get copyWith => __$SessionHymnCopyWithImpl<_SessionHymn>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionHymnToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionHymn&&(identical(other.book, book) || other.book == book)&&(identical(other.number, number) || other.number == number));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,number);

@override
String toString() {
  return 'SessionHymn(book: $book, number: $number)';
}


}

/// @nodoc
abstract mixin class _$SessionHymnCopyWith<$Res> implements $SessionHymnCopyWith<$Res> {
  factory _$SessionHymnCopyWith(_SessionHymn value, $Res Function(_SessionHymn) _then) = __$SessionHymnCopyWithImpl;
@override @useResult
$Res call({
 String book, int number
});




}
/// @nodoc
class __$SessionHymnCopyWithImpl<$Res>
    implements _$SessionHymnCopyWith<$Res> {
  __$SessionHymnCopyWithImpl(this._self, this._then);

  final _SessionHymn _self;
  final $Res Function(_SessionHymn) _then;

/// Create a copy of SessionHymn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? number = null,}) {
  return _then(_SessionHymn(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EventSession {

 int get id; DateTime get startsAt; DateTime? get endsAt; String get title; String get speaker; String get place; String get description; List<SessionHymn> get hymns;
/// Create a copy of EventSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventSessionCopyWith<EventSession> get copyWith => _$EventSessionCopyWithImpl<EventSession>(this as EventSession, _$identity);

  /// Serializes this EventSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventSession&&(identical(other.id, id) || other.id == id)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.place, place) || other.place == place)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.hymns, hymns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsAt,endsAt,title,speaker,place,description,const DeepCollectionEquality().hash(hymns));

@override
String toString() {
  return 'EventSession(id: $id, startsAt: $startsAt, endsAt: $endsAt, title: $title, speaker: $speaker, place: $place, description: $description, hymns: $hymns)';
}


}

/// @nodoc
abstract mixin class $EventSessionCopyWith<$Res>  {
  factory $EventSessionCopyWith(EventSession value, $Res Function(EventSession) _then) = _$EventSessionCopyWithImpl;
@useResult
$Res call({
 int id, DateTime startsAt, DateTime? endsAt, String title, String speaker, String place, String description, List<SessionHymn> hymns
});




}
/// @nodoc
class _$EventSessionCopyWithImpl<$Res>
    implements $EventSessionCopyWith<$Res> {
  _$EventSessionCopyWithImpl(this._self, this._then);

  final EventSession _self;
  final $Res Function(EventSession) _then;

/// Create a copy of EventSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = freezed,Object? title = null,Object? speaker = null,Object? place = null,Object? description = null,Object? hymns = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,hymns: null == hymns ? _self.hymns : hymns // ignore: cast_nullable_to_non_nullable
as List<SessionHymn>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventSession].
extension EventSessionPatterns on EventSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventSession value)  $default,){
final _that = this;
switch (_that) {
case _EventSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventSession value)?  $default,){
final _that = this;
switch (_that) {
case _EventSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime startsAt,  DateTime? endsAt,  String title,  String speaker,  String place,  String description,  List<SessionHymn> hymns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventSession() when $default != null:
return $default(_that.id,_that.startsAt,_that.endsAt,_that.title,_that.speaker,_that.place,_that.description,_that.hymns);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime startsAt,  DateTime? endsAt,  String title,  String speaker,  String place,  String description,  List<SessionHymn> hymns)  $default,) {final _that = this;
switch (_that) {
case _EventSession():
return $default(_that.id,_that.startsAt,_that.endsAt,_that.title,_that.speaker,_that.place,_that.description,_that.hymns);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime startsAt,  DateTime? endsAt,  String title,  String speaker,  String place,  String description,  List<SessionHymn> hymns)?  $default,) {final _that = this;
switch (_that) {
case _EventSession() when $default != null:
return $default(_that.id,_that.startsAt,_that.endsAt,_that.title,_that.speaker,_that.place,_that.description,_that.hymns);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventSession implements EventSession {
  const _EventSession({required this.id, required this.startsAt, this.endsAt, required this.title, this.speaker = '', this.place = '', this.description = '', final  List<SessionHymn> hymns = const <SessionHymn>[]}): _hymns = hymns;
  factory _EventSession.fromJson(Map<String, dynamic> json) => _$EventSessionFromJson(json);

@override final  int id;
@override final  DateTime startsAt;
@override final  DateTime? endsAt;
@override final  String title;
@override@JsonKey() final  String speaker;
@override@JsonKey() final  String place;
@override@JsonKey() final  String description;
 final  List<SessionHymn> _hymns;
@override@JsonKey() List<SessionHymn> get hymns {
  if (_hymns is EqualUnmodifiableListView) return _hymns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hymns);
}


/// Create a copy of EventSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventSessionCopyWith<_EventSession> get copyWith => __$EventSessionCopyWithImpl<_EventSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventSession&&(identical(other.id, id) || other.id == id)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.place, place) || other.place == place)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._hymns, _hymns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsAt,endsAt,title,speaker,place,description,const DeepCollectionEquality().hash(_hymns));

@override
String toString() {
  return 'EventSession(id: $id, startsAt: $startsAt, endsAt: $endsAt, title: $title, speaker: $speaker, place: $place, description: $description, hymns: $hymns)';
}


}

/// @nodoc
abstract mixin class _$EventSessionCopyWith<$Res> implements $EventSessionCopyWith<$Res> {
  factory _$EventSessionCopyWith(_EventSession value, $Res Function(_EventSession) _then) = __$EventSessionCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime startsAt, DateTime? endsAt, String title, String speaker, String place, String description, List<SessionHymn> hymns
});




}
/// @nodoc
class __$EventSessionCopyWithImpl<$Res>
    implements _$EventSessionCopyWith<$Res> {
  __$EventSessionCopyWithImpl(this._self, this._then);

  final _EventSession _self;
  final $Res Function(_EventSession) _then;

/// Create a copy of EventSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = freezed,Object? title = null,Object? speaker = null,Object? place = null,Object? description = null,Object? hymns = null,}) {
  return _then(_EventSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,hymns: null == hymns ? _self._hymns : hymns // ignore: cast_nullable_to_non_nullable
as List<SessionHymn>,
  ));
}


}


/// @nodoc
mixin _$EventPost {

 int get id; String get body; EventImage? get image; bool get pinned; DateTime get createdAt;
/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPostCopyWith<EventPost> get copyWith => _$EventPostCopyWithImpl<EventPost>(this as EventPost, _$identity);

  /// Serializes this EventPost to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPost&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.image, image) || other.image == image)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,body,image,pinned,createdAt);

@override
String toString() {
  return 'EventPost(id: $id, body: $body, image: $image, pinned: $pinned, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EventPostCopyWith<$Res>  {
  factory $EventPostCopyWith(EventPost value, $Res Function(EventPost) _then) = _$EventPostCopyWithImpl;
@useResult
$Res call({
 int id, String body, EventImage? image, bool pinned, DateTime createdAt
});


$EventImageCopyWith<$Res>? get image;

}
/// @nodoc
class _$EventPostCopyWithImpl<$Res>
    implements $EventPostCopyWith<$Res> {
  _$EventPostCopyWithImpl(this._self, this._then);

  final EventPost _self;
  final $Res Function(EventPost) _then;

/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? body = null,Object? image = freezed,Object? pinned = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as EventImage?,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventPost].
extension EventPostPatterns on EventPost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPost value)  $default,){
final _that = this;
switch (_that) {
case _EventPost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPost value)?  $default,){
final _that = this;
switch (_that) {
case _EventPost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String body,  EventImage? image,  bool pinned,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPost() when $default != null:
return $default(_that.id,_that.body,_that.image,_that.pinned,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String body,  EventImage? image,  bool pinned,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _EventPost():
return $default(_that.id,_that.body,_that.image,_that.pinned,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String body,  EventImage? image,  bool pinned,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EventPost() when $default != null:
return $default(_that.id,_that.body,_that.image,_that.pinned,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventPost implements EventPost {
  const _EventPost({required this.id, required this.body, this.image, this.pinned = false, required this.createdAt});
  factory _EventPost.fromJson(Map<String, dynamic> json) => _$EventPostFromJson(json);

@override final  int id;
@override final  String body;
@override final  EventImage? image;
@override@JsonKey() final  bool pinned;
@override final  DateTime createdAt;

/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPostCopyWith<_EventPost> get copyWith => __$EventPostCopyWithImpl<_EventPost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventPostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPost&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.image, image) || other.image == image)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,body,image,pinned,createdAt);

@override
String toString() {
  return 'EventPost(id: $id, body: $body, image: $image, pinned: $pinned, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EventPostCopyWith<$Res> implements $EventPostCopyWith<$Res> {
  factory _$EventPostCopyWith(_EventPost value, $Res Function(_EventPost) _then) = __$EventPostCopyWithImpl;
@override @useResult
$Res call({
 int id, String body, EventImage? image, bool pinned, DateTime createdAt
});


@override $EventImageCopyWith<$Res>? get image;

}
/// @nodoc
class __$EventPostCopyWithImpl<$Res>
    implements _$EventPostCopyWith<$Res> {
  __$EventPostCopyWithImpl(this._self, this._then);

  final _EventPost _self;
  final $Res Function(_EventPost) _then;

/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? body = null,Object? image = freezed,Object? pinned = null,Object? createdAt = null,}) {
  return _then(_EventPost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as EventImage?,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// @nodoc
mixin _$EventPhoto {

 int get id; EventImage get image; String get caption;
/// Create a copy of EventPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPhotoCopyWith<EventPhoto> get copyWith => _$EventPhotoCopyWithImpl<EventPhoto>(this as EventPhoto, _$identity);

  /// Serializes this EventPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,caption);

@override
String toString() {
  return 'EventPhoto(id: $id, image: $image, caption: $caption)';
}


}

/// @nodoc
abstract mixin class $EventPhotoCopyWith<$Res>  {
  factory $EventPhotoCopyWith(EventPhoto value, $Res Function(EventPhoto) _then) = _$EventPhotoCopyWithImpl;
@useResult
$Res call({
 int id, EventImage image, String caption
});


$EventImageCopyWith<$Res> get image;

}
/// @nodoc
class _$EventPhotoCopyWithImpl<$Res>
    implements $EventPhotoCopyWith<$Res> {
  _$EventPhotoCopyWithImpl(this._self, this._then);

  final EventPhoto _self;
  final $Res Function(EventPhoto) _then;

/// Create a copy of EventPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? image = null,Object? caption = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as EventImage,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of EventPhoto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res> get image {
  
  return $EventImageCopyWith<$Res>(_self.image, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventPhoto].
extension EventPhotoPatterns on EventPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPhoto value)  $default,){
final _that = this;
switch (_that) {
case _EventPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _EventPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  EventImage image,  String caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPhoto() when $default != null:
return $default(_that.id,_that.image,_that.caption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  EventImage image,  String caption)  $default,) {final _that = this;
switch (_that) {
case _EventPhoto():
return $default(_that.id,_that.image,_that.caption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  EventImage image,  String caption)?  $default,) {final _that = this;
switch (_that) {
case _EventPhoto() when $default != null:
return $default(_that.id,_that.image,_that.caption);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventPhoto implements EventPhoto {
  const _EventPhoto({required this.id, required this.image, this.caption = ''});
  factory _EventPhoto.fromJson(Map<String, dynamic> json) => _$EventPhotoFromJson(json);

@override final  int id;
@override final  EventImage image;
@override@JsonKey() final  String caption;

/// Create a copy of EventPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPhotoCopyWith<_EventPhoto> get copyWith => __$EventPhotoCopyWithImpl<_EventPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,caption);

@override
String toString() {
  return 'EventPhoto(id: $id, image: $image, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$EventPhotoCopyWith<$Res> implements $EventPhotoCopyWith<$Res> {
  factory _$EventPhotoCopyWith(_EventPhoto value, $Res Function(_EventPhoto) _then) = __$EventPhotoCopyWithImpl;
@override @useResult
$Res call({
 int id, EventImage image, String caption
});


@override $EventImageCopyWith<$Res> get image;

}
/// @nodoc
class __$EventPhotoCopyWithImpl<$Res>
    implements _$EventPhotoCopyWith<$Res> {
  __$EventPhotoCopyWithImpl(this._self, this._then);

  final _EventPhoto _self;
  final $Res Function(_EventPhoto) _then;

/// Create a copy of EventPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? image = null,Object? caption = null,}) {
  return _then(_EventPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as EventImage,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of EventPhoto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res> get image {
  
  return $EventImageCopyWith<$Res>(_self.image, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// @nodoc
mixin _$MyRegistration {

 int get people; bool get needsLodging; String get departureCity; DateTime? get updatedAt;
/// Create a copy of MyRegistration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyRegistrationCopyWith<MyRegistration> get copyWith => _$MyRegistrationCopyWithImpl<MyRegistration>(this as MyRegistration, _$identity);

  /// Serializes this MyRegistration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyRegistration&&(identical(other.people, people) || other.people == people)&&(identical(other.needsLodging, needsLodging) || other.needsLodging == needsLodging)&&(identical(other.departureCity, departureCity) || other.departureCity == departureCity)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,people,needsLodging,departureCity,updatedAt);

@override
String toString() {
  return 'MyRegistration(people: $people, needsLodging: $needsLodging, departureCity: $departureCity, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MyRegistrationCopyWith<$Res>  {
  factory $MyRegistrationCopyWith(MyRegistration value, $Res Function(MyRegistration) _then) = _$MyRegistrationCopyWithImpl;
@useResult
$Res call({
 int people, bool needsLodging, String departureCity, DateTime? updatedAt
});




}
/// @nodoc
class _$MyRegistrationCopyWithImpl<$Res>
    implements $MyRegistrationCopyWith<$Res> {
  _$MyRegistrationCopyWithImpl(this._self, this._then);

  final MyRegistration _self;
  final $Res Function(MyRegistration) _then;

/// Create a copy of MyRegistration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? people = null,Object? needsLodging = null,Object? departureCity = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,needsLodging: null == needsLodging ? _self.needsLodging : needsLodging // ignore: cast_nullable_to_non_nullable
as bool,departureCity: null == departureCity ? _self.departureCity : departureCity // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MyRegistration].
extension MyRegistrationPatterns on MyRegistration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyRegistration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyRegistration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyRegistration value)  $default,){
final _that = this;
switch (_that) {
case _MyRegistration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyRegistration value)?  $default,){
final _that = this;
switch (_that) {
case _MyRegistration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int people,  bool needsLodging,  String departureCity,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyRegistration() when $default != null:
return $default(_that.people,_that.needsLodging,_that.departureCity,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int people,  bool needsLodging,  String departureCity,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MyRegistration():
return $default(_that.people,_that.needsLodging,_that.departureCity,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int people,  bool needsLodging,  String departureCity,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MyRegistration() when $default != null:
return $default(_that.people,_that.needsLodging,_that.departureCity,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyRegistration implements MyRegistration {
  const _MyRegistration({this.people = 1, this.needsLodging = false, this.departureCity = '', this.updatedAt});
  factory _MyRegistration.fromJson(Map<String, dynamic> json) => _$MyRegistrationFromJson(json);

@override@JsonKey() final  int people;
@override@JsonKey() final  bool needsLodging;
@override@JsonKey() final  String departureCity;
@override final  DateTime? updatedAt;

/// Create a copy of MyRegistration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyRegistrationCopyWith<_MyRegistration> get copyWith => __$MyRegistrationCopyWithImpl<_MyRegistration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyRegistrationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyRegistration&&(identical(other.people, people) || other.people == people)&&(identical(other.needsLodging, needsLodging) || other.needsLodging == needsLodging)&&(identical(other.departureCity, departureCity) || other.departureCity == departureCity)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,people,needsLodging,departureCity,updatedAt);

@override
String toString() {
  return 'MyRegistration(people: $people, needsLodging: $needsLodging, departureCity: $departureCity, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MyRegistrationCopyWith<$Res> implements $MyRegistrationCopyWith<$Res> {
  factory _$MyRegistrationCopyWith(_MyRegistration value, $Res Function(_MyRegistration) _then) = __$MyRegistrationCopyWithImpl;
@override @useResult
$Res call({
 int people, bool needsLodging, String departureCity, DateTime? updatedAt
});




}
/// @nodoc
class __$MyRegistrationCopyWithImpl<$Res>
    implements _$MyRegistrationCopyWith<$Res> {
  __$MyRegistrationCopyWithImpl(this._self, this._then);

  final _MyRegistration _self;
  final $Res Function(_MyRegistration) _then;

/// Create a copy of MyRegistration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? people = null,Object? needsLodging = null,Object? departureCity = null,Object? updatedAt = freezed,}) {
  return _then(_MyRegistration(
people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,needsLodging: null == needsLodging ? _self.needsLodging : needsLodging // ignore: cast_nullable_to_non_nullable
as bool,departureCity: null == departureCity ? _self.departureCity : departureCity // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$EventEdition {

 int get id; String get title; DateTime get startsAt; DateTime get endsAt; String get timeZone; EventImage? get poster;
/// Create a copy of EventEdition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventEditionCopyWith<EventEdition> get copyWith => _$EventEditionCopyWithImpl<EventEdition>(this as EventEdition, _$identity);

  /// Serializes this EventEdition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventEdition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.poster, poster) || other.poster == poster));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,endsAt,timeZone,poster);

@override
String toString() {
  return 'EventEdition(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, timeZone: $timeZone, poster: $poster)';
}


}

/// @nodoc
abstract mixin class $EventEditionCopyWith<$Res>  {
  factory $EventEditionCopyWith(EventEdition value, $Res Function(EventEdition) _then) = _$EventEditionCopyWithImpl;
@useResult
$Res call({
 int id, String title, DateTime startsAt, DateTime endsAt, String timeZone, EventImage? poster
});


$EventImageCopyWith<$Res>? get poster;

}
/// @nodoc
class _$EventEditionCopyWithImpl<$Res>
    implements $EventEditionCopyWith<$Res> {
  _$EventEditionCopyWithImpl(this._self, this._then);

  final EventEdition _self;
  final $Res Function(EventEdition) _then;

/// Create a copy of EventEdition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? timeZone = null,Object? poster = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,poster: freezed == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as EventImage?,
  ));
}
/// Create a copy of EventEdition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get poster {
    if (_self.poster == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.poster!, (value) {
    return _then(_self.copyWith(poster: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventEdition].
extension EventEditionPatterns on EventEdition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventEdition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventEdition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventEdition value)  $default,){
final _that = this;
switch (_that) {
case _EventEdition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventEdition value)?  $default,){
final _that = this;
switch (_that) {
case _EventEdition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  DateTime startsAt,  DateTime endsAt,  String timeZone,  EventImage? poster)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventEdition() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.timeZone,_that.poster);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  DateTime startsAt,  DateTime endsAt,  String timeZone,  EventImage? poster)  $default,) {final _that = this;
switch (_that) {
case _EventEdition():
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.timeZone,_that.poster);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  DateTime startsAt,  DateTime endsAt,  String timeZone,  EventImage? poster)?  $default,) {final _that = this;
switch (_that) {
case _EventEdition() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.timeZone,_that.poster);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventEdition implements EventEdition {
  const _EventEdition({required this.id, required this.title, required this.startsAt, required this.endsAt, this.timeZone = CommunityEvent.defaultTimeZone, this.poster});
  factory _EventEdition.fromJson(Map<String, dynamic> json) => _$EventEditionFromJson(json);

@override final  int id;
@override final  String title;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override@JsonKey() final  String timeZone;
@override final  EventImage? poster;

/// Create a copy of EventEdition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventEditionCopyWith<_EventEdition> get copyWith => __$EventEditionCopyWithImpl<_EventEdition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventEditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventEdition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.poster, poster) || other.poster == poster));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,endsAt,timeZone,poster);

@override
String toString() {
  return 'EventEdition(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, timeZone: $timeZone, poster: $poster)';
}


}

/// @nodoc
abstract mixin class _$EventEditionCopyWith<$Res> implements $EventEditionCopyWith<$Res> {
  factory _$EventEditionCopyWith(_EventEdition value, $Res Function(_EventEdition) _then) = __$EventEditionCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, DateTime startsAt, DateTime endsAt, String timeZone, EventImage? poster
});


@override $EventImageCopyWith<$Res>? get poster;

}
/// @nodoc
class __$EventEditionCopyWithImpl<$Res>
    implements _$EventEditionCopyWith<$Res> {
  __$EventEditionCopyWithImpl(this._self, this._then);

  final _EventEdition _self;
  final $Res Function(_EventEdition) _then;

/// Create a copy of EventEdition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? timeZone = null,Object? poster = freezed,}) {
  return _then(_EventEdition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,poster: freezed == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as EventImage?,
  ));
}

/// Create a copy of EventEdition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get poster {
    if (_self.poster == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.poster!, (value) {
    return _then(_self.copyWith(poster: value));
  });
}
}


/// @nodoc
mixin _$CommunityEvent {

 int get id; int? get seriesId; String get title; String get theme; DateTime get startsAt; DateTime get endsAt;/// The clock of the venue: times are shown as announced there.
 String get timeZone; String get venue; String get city; String get country; EventImage? get poster;@JsonKey(unknownEnumValue: EventStatus.published) EventStatus get status; RegistrationSummary get registration;// ----- the whole event only -----
 String get themeVerse; String get description; String get address; String get mapsUrl; String get contactName; String get contactPhone; bool get registrationOpen; DateTime? get registrationDeadline; int? get capacity; bool get asksLodging; bool get asksDepartureCity; String get feeNote; List<EventSession> get sessions; List<EventPost> get posts; List<EventPhoto> get photos; MyRegistration? get myRegistration; List<EventEdition> get editions;
/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityEventCopyWith<CommunityEvent> get copyWith => _$CommunityEventCopyWithImpl<CommunityEvent>(this as CommunityEvent, _$identity);

  /// Serializes this CommunityEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.seriesId, seriesId) || other.seriesId == seriesId)&&(identical(other.title, title) || other.title == title)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.status, status) || other.status == status)&&(identical(other.registration, registration) || other.registration == registration)&&(identical(other.themeVerse, themeVerse) || other.themeVerse == themeVerse)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.registrationOpen, registrationOpen) || other.registrationOpen == registrationOpen)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.asksLodging, asksLodging) || other.asksLodging == asksLodging)&&(identical(other.asksDepartureCity, asksDepartureCity) || other.asksDepartureCity == asksDepartureCity)&&(identical(other.feeNote, feeNote) || other.feeNote == feeNote)&&const DeepCollectionEquality().equals(other.sessions, sessions)&&const DeepCollectionEquality().equals(other.posts, posts)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.myRegistration, myRegistration) || other.myRegistration == myRegistration)&&const DeepCollectionEquality().equals(other.editions, editions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,seriesId,title,theme,startsAt,endsAt,timeZone,venue,city,country,poster,status,registration,themeVerse,description,address,mapsUrl,contactName,contactPhone,registrationOpen,registrationDeadline,capacity,asksLodging,asksDepartureCity,feeNote,const DeepCollectionEquality().hash(sessions),const DeepCollectionEquality().hash(posts),const DeepCollectionEquality().hash(photos),myRegistration,const DeepCollectionEquality().hash(editions)]);

@override
String toString() {
  return 'CommunityEvent(id: $id, seriesId: $seriesId, title: $title, theme: $theme, startsAt: $startsAt, endsAt: $endsAt, timeZone: $timeZone, venue: $venue, city: $city, country: $country, poster: $poster, status: $status, registration: $registration, themeVerse: $themeVerse, description: $description, address: $address, mapsUrl: $mapsUrl, contactName: $contactName, contactPhone: $contactPhone, registrationOpen: $registrationOpen, registrationDeadline: $registrationDeadline, capacity: $capacity, asksLodging: $asksLodging, asksDepartureCity: $asksDepartureCity, feeNote: $feeNote, sessions: $sessions, posts: $posts, photos: $photos, myRegistration: $myRegistration, editions: $editions)';
}


}

/// @nodoc
abstract mixin class $CommunityEventCopyWith<$Res>  {
  factory $CommunityEventCopyWith(CommunityEvent value, $Res Function(CommunityEvent) _then) = _$CommunityEventCopyWithImpl;
@useResult
$Res call({
 int id, int? seriesId, String title, String theme, DateTime startsAt, DateTime endsAt, String timeZone, String venue, String city, String country, EventImage? poster,@JsonKey(unknownEnumValue: EventStatus.published) EventStatus status, RegistrationSummary registration, String themeVerse, String description, String address, String mapsUrl, String contactName, String contactPhone, bool registrationOpen, DateTime? registrationDeadline, int? capacity, bool asksLodging, bool asksDepartureCity, String feeNote, List<EventSession> sessions, List<EventPost> posts, List<EventPhoto> photos, MyRegistration? myRegistration, List<EventEdition> editions
});


$EventImageCopyWith<$Res>? get poster;$RegistrationSummaryCopyWith<$Res> get registration;$MyRegistrationCopyWith<$Res>? get myRegistration;

}
/// @nodoc
class _$CommunityEventCopyWithImpl<$Res>
    implements $CommunityEventCopyWith<$Res> {
  _$CommunityEventCopyWithImpl(this._self, this._then);

  final CommunityEvent _self;
  final $Res Function(CommunityEvent) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? seriesId = freezed,Object? title = null,Object? theme = null,Object? startsAt = null,Object? endsAt = null,Object? timeZone = null,Object? venue = null,Object? city = null,Object? country = null,Object? poster = freezed,Object? status = null,Object? registration = null,Object? themeVerse = null,Object? description = null,Object? address = null,Object? mapsUrl = null,Object? contactName = null,Object? contactPhone = null,Object? registrationOpen = null,Object? registrationDeadline = freezed,Object? capacity = freezed,Object? asksLodging = null,Object? asksDepartureCity = null,Object? feeNote = null,Object? sessions = null,Object? posts = null,Object? photos = null,Object? myRegistration = freezed,Object? editions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,seriesId: freezed == seriesId ? _self.seriesId : seriesId // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,poster: freezed == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as EventImage?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventStatus,registration: null == registration ? _self.registration : registration // ignore: cast_nullable_to_non_nullable
as RegistrationSummary,themeVerse: null == themeVerse ? _self.themeVerse : themeVerse // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,mapsUrl: null == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactPhone: null == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String,registrationOpen: null == registrationOpen ? _self.registrationOpen : registrationOpen // ignore: cast_nullable_to_non_nullable
as bool,registrationDeadline: freezed == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,capacity: freezed == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int?,asksLodging: null == asksLodging ? _self.asksLodging : asksLodging // ignore: cast_nullable_to_non_nullable
as bool,asksDepartureCity: null == asksDepartureCity ? _self.asksDepartureCity : asksDepartureCity // ignore: cast_nullable_to_non_nullable
as bool,feeNote: null == feeNote ? _self.feeNote : feeNote // ignore: cast_nullable_to_non_nullable
as String,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<EventSession>,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<EventPost>,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<EventPhoto>,myRegistration: freezed == myRegistration ? _self.myRegistration : myRegistration // ignore: cast_nullable_to_non_nullable
as MyRegistration?,editions: null == editions ? _self.editions : editions // ignore: cast_nullable_to_non_nullable
as List<EventEdition>,
  ));
}
/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get poster {
    if (_self.poster == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.poster!, (value) {
    return _then(_self.copyWith(poster: value));
  });
}/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationSummaryCopyWith<$Res> get registration {
  
  return $RegistrationSummaryCopyWith<$Res>(_self.registration, (value) {
    return _then(_self.copyWith(registration: value));
  });
}/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyRegistrationCopyWith<$Res>? get myRegistration {
    if (_self.myRegistration == null) {
    return null;
  }

  return $MyRegistrationCopyWith<$Res>(_self.myRegistration!, (value) {
    return _then(_self.copyWith(myRegistration: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommunityEvent].
extension CommunityEventPatterns on CommunityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityEvent value)  $default,){
final _that = this;
switch (_that) {
case _CommunityEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityEvent value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? seriesId,  String title,  String theme,  DateTime startsAt,  DateTime endsAt,  String timeZone,  String venue,  String city,  String country,  EventImage? poster, @JsonKey(unknownEnumValue: EventStatus.published)  EventStatus status,  RegistrationSummary registration,  String themeVerse,  String description,  String address,  String mapsUrl,  String contactName,  String contactPhone,  bool registrationOpen,  DateTime? registrationDeadline,  int? capacity,  bool asksLodging,  bool asksDepartureCity,  String feeNote,  List<EventSession> sessions,  List<EventPost> posts,  List<EventPhoto> photos,  MyRegistration? myRegistration,  List<EventEdition> editions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityEvent() when $default != null:
return $default(_that.id,_that.seriesId,_that.title,_that.theme,_that.startsAt,_that.endsAt,_that.timeZone,_that.venue,_that.city,_that.country,_that.poster,_that.status,_that.registration,_that.themeVerse,_that.description,_that.address,_that.mapsUrl,_that.contactName,_that.contactPhone,_that.registrationOpen,_that.registrationDeadline,_that.capacity,_that.asksLodging,_that.asksDepartureCity,_that.feeNote,_that.sessions,_that.posts,_that.photos,_that.myRegistration,_that.editions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? seriesId,  String title,  String theme,  DateTime startsAt,  DateTime endsAt,  String timeZone,  String venue,  String city,  String country,  EventImage? poster, @JsonKey(unknownEnumValue: EventStatus.published)  EventStatus status,  RegistrationSummary registration,  String themeVerse,  String description,  String address,  String mapsUrl,  String contactName,  String contactPhone,  bool registrationOpen,  DateTime? registrationDeadline,  int? capacity,  bool asksLodging,  bool asksDepartureCity,  String feeNote,  List<EventSession> sessions,  List<EventPost> posts,  List<EventPhoto> photos,  MyRegistration? myRegistration,  List<EventEdition> editions)  $default,) {final _that = this;
switch (_that) {
case _CommunityEvent():
return $default(_that.id,_that.seriesId,_that.title,_that.theme,_that.startsAt,_that.endsAt,_that.timeZone,_that.venue,_that.city,_that.country,_that.poster,_that.status,_that.registration,_that.themeVerse,_that.description,_that.address,_that.mapsUrl,_that.contactName,_that.contactPhone,_that.registrationOpen,_that.registrationDeadline,_that.capacity,_that.asksLodging,_that.asksDepartureCity,_that.feeNote,_that.sessions,_that.posts,_that.photos,_that.myRegistration,_that.editions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? seriesId,  String title,  String theme,  DateTime startsAt,  DateTime endsAt,  String timeZone,  String venue,  String city,  String country,  EventImage? poster, @JsonKey(unknownEnumValue: EventStatus.published)  EventStatus status,  RegistrationSummary registration,  String themeVerse,  String description,  String address,  String mapsUrl,  String contactName,  String contactPhone,  bool registrationOpen,  DateTime? registrationDeadline,  int? capacity,  bool asksLodging,  bool asksDepartureCity,  String feeNote,  List<EventSession> sessions,  List<EventPost> posts,  List<EventPhoto> photos,  MyRegistration? myRegistration,  List<EventEdition> editions)?  $default,) {final _that = this;
switch (_that) {
case _CommunityEvent() when $default != null:
return $default(_that.id,_that.seriesId,_that.title,_that.theme,_that.startsAt,_that.endsAt,_that.timeZone,_that.venue,_that.city,_that.country,_that.poster,_that.status,_that.registration,_that.themeVerse,_that.description,_that.address,_that.mapsUrl,_that.contactName,_that.contactPhone,_that.registrationOpen,_that.registrationDeadline,_that.capacity,_that.asksLodging,_that.asksDepartureCity,_that.feeNote,_that.sessions,_that.posts,_that.photos,_that.myRegistration,_that.editions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityEvent extends CommunityEvent {
  const _CommunityEvent({required this.id, this.seriesId, required this.title, this.theme = '', required this.startsAt, required this.endsAt, this.timeZone = CommunityEvent.defaultTimeZone, this.venue = '', this.city = '', this.country = '', this.poster, @JsonKey(unknownEnumValue: EventStatus.published) this.status = EventStatus.published, this.registration = const RegistrationSummary(), this.themeVerse = '', this.description = '', this.address = '', this.mapsUrl = '', this.contactName = '', this.contactPhone = '', this.registrationOpen = true, this.registrationDeadline, this.capacity, this.asksLodging = false, this.asksDepartureCity = false, this.feeNote = '', final  List<EventSession> sessions = const <EventSession>[], final  List<EventPost> posts = const <EventPost>[], final  List<EventPhoto> photos = const <EventPhoto>[], this.myRegistration, final  List<EventEdition> editions = const <EventEdition>[]}): _sessions = sessions,_posts = posts,_photos = photos,_editions = editions,super._();
  factory _CommunityEvent.fromJson(Map<String, dynamic> json) => _$CommunityEventFromJson(json);

@override final  int id;
@override final  int? seriesId;
@override final  String title;
@override@JsonKey() final  String theme;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
/// The clock of the venue: times are shown as announced there.
@override@JsonKey() final  String timeZone;
@override@JsonKey() final  String venue;
@override@JsonKey() final  String city;
@override@JsonKey() final  String country;
@override final  EventImage? poster;
@override@JsonKey(unknownEnumValue: EventStatus.published) final  EventStatus status;
@override@JsonKey() final  RegistrationSummary registration;
// ----- the whole event only -----
@override@JsonKey() final  String themeVerse;
@override@JsonKey() final  String description;
@override@JsonKey() final  String address;
@override@JsonKey() final  String mapsUrl;
@override@JsonKey() final  String contactName;
@override@JsonKey() final  String contactPhone;
@override@JsonKey() final  bool registrationOpen;
@override final  DateTime? registrationDeadline;
@override final  int? capacity;
@override@JsonKey() final  bool asksLodging;
@override@JsonKey() final  bool asksDepartureCity;
@override@JsonKey() final  String feeNote;
 final  List<EventSession> _sessions;
@override@JsonKey() List<EventSession> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

 final  List<EventPost> _posts;
@override@JsonKey() List<EventPost> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

 final  List<EventPhoto> _photos;
@override@JsonKey() List<EventPhoto> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  MyRegistration? myRegistration;
 final  List<EventEdition> _editions;
@override@JsonKey() List<EventEdition> get editions {
  if (_editions is EqualUnmodifiableListView) return _editions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_editions);
}


/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityEventCopyWith<_CommunityEvent> get copyWith => __$CommunityEventCopyWithImpl<_CommunityEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.seriesId, seriesId) || other.seriesId == seriesId)&&(identical(other.title, title) || other.title == title)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.status, status) || other.status == status)&&(identical(other.registration, registration) || other.registration == registration)&&(identical(other.themeVerse, themeVerse) || other.themeVerse == themeVerse)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.registrationOpen, registrationOpen) || other.registrationOpen == registrationOpen)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.asksLodging, asksLodging) || other.asksLodging == asksLodging)&&(identical(other.asksDepartureCity, asksDepartureCity) || other.asksDepartureCity == asksDepartureCity)&&(identical(other.feeNote, feeNote) || other.feeNote == feeNote)&&const DeepCollectionEquality().equals(other._sessions, _sessions)&&const DeepCollectionEquality().equals(other._posts, _posts)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.myRegistration, myRegistration) || other.myRegistration == myRegistration)&&const DeepCollectionEquality().equals(other._editions, _editions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,seriesId,title,theme,startsAt,endsAt,timeZone,venue,city,country,poster,status,registration,themeVerse,description,address,mapsUrl,contactName,contactPhone,registrationOpen,registrationDeadline,capacity,asksLodging,asksDepartureCity,feeNote,const DeepCollectionEquality().hash(_sessions),const DeepCollectionEquality().hash(_posts),const DeepCollectionEquality().hash(_photos),myRegistration,const DeepCollectionEquality().hash(_editions)]);

@override
String toString() {
  return 'CommunityEvent(id: $id, seriesId: $seriesId, title: $title, theme: $theme, startsAt: $startsAt, endsAt: $endsAt, timeZone: $timeZone, venue: $venue, city: $city, country: $country, poster: $poster, status: $status, registration: $registration, themeVerse: $themeVerse, description: $description, address: $address, mapsUrl: $mapsUrl, contactName: $contactName, contactPhone: $contactPhone, registrationOpen: $registrationOpen, registrationDeadline: $registrationDeadline, capacity: $capacity, asksLodging: $asksLodging, asksDepartureCity: $asksDepartureCity, feeNote: $feeNote, sessions: $sessions, posts: $posts, photos: $photos, myRegistration: $myRegistration, editions: $editions)';
}


}

/// @nodoc
abstract mixin class _$CommunityEventCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$CommunityEventCopyWith(_CommunityEvent value, $Res Function(_CommunityEvent) _then) = __$CommunityEventCopyWithImpl;
@override @useResult
$Res call({
 int id, int? seriesId, String title, String theme, DateTime startsAt, DateTime endsAt, String timeZone, String venue, String city, String country, EventImage? poster,@JsonKey(unknownEnumValue: EventStatus.published) EventStatus status, RegistrationSummary registration, String themeVerse, String description, String address, String mapsUrl, String contactName, String contactPhone, bool registrationOpen, DateTime? registrationDeadline, int? capacity, bool asksLodging, bool asksDepartureCity, String feeNote, List<EventSession> sessions, List<EventPost> posts, List<EventPhoto> photos, MyRegistration? myRegistration, List<EventEdition> editions
});


@override $EventImageCopyWith<$Res>? get poster;@override $RegistrationSummaryCopyWith<$Res> get registration;@override $MyRegistrationCopyWith<$Res>? get myRegistration;

}
/// @nodoc
class __$CommunityEventCopyWithImpl<$Res>
    implements _$CommunityEventCopyWith<$Res> {
  __$CommunityEventCopyWithImpl(this._self, this._then);

  final _CommunityEvent _self;
  final $Res Function(_CommunityEvent) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? seriesId = freezed,Object? title = null,Object? theme = null,Object? startsAt = null,Object? endsAt = null,Object? timeZone = null,Object? venue = null,Object? city = null,Object? country = null,Object? poster = freezed,Object? status = null,Object? registration = null,Object? themeVerse = null,Object? description = null,Object? address = null,Object? mapsUrl = null,Object? contactName = null,Object? contactPhone = null,Object? registrationOpen = null,Object? registrationDeadline = freezed,Object? capacity = freezed,Object? asksLodging = null,Object? asksDepartureCity = null,Object? feeNote = null,Object? sessions = null,Object? posts = null,Object? photos = null,Object? myRegistration = freezed,Object? editions = null,}) {
  return _then(_CommunityEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,seriesId: freezed == seriesId ? _self.seriesId : seriesId // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,poster: freezed == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as EventImage?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventStatus,registration: null == registration ? _self.registration : registration // ignore: cast_nullable_to_non_nullable
as RegistrationSummary,themeVerse: null == themeVerse ? _self.themeVerse : themeVerse // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,mapsUrl: null == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactPhone: null == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String,registrationOpen: null == registrationOpen ? _self.registrationOpen : registrationOpen // ignore: cast_nullable_to_non_nullable
as bool,registrationDeadline: freezed == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,capacity: freezed == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int?,asksLodging: null == asksLodging ? _self.asksLodging : asksLodging // ignore: cast_nullable_to_non_nullable
as bool,asksDepartureCity: null == asksDepartureCity ? _self.asksDepartureCity : asksDepartureCity // ignore: cast_nullable_to_non_nullable
as bool,feeNote: null == feeNote ? _self.feeNote : feeNote // ignore: cast_nullable_to_non_nullable
as String,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<EventSession>,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<EventPost>,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<EventPhoto>,myRegistration: freezed == myRegistration ? _self.myRegistration : myRegistration // ignore: cast_nullable_to_non_nullable
as MyRegistration?,editions: null == editions ? _self._editions : editions // ignore: cast_nullable_to_non_nullable
as List<EventEdition>,
  ));
}

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get poster {
    if (_self.poster == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.poster!, (value) {
    return _then(_self.copyWith(poster: value));
  });
}/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationSummaryCopyWith<$Res> get registration {
  
  return $RegistrationSummaryCopyWith<$Res>(_self.registration, (value) {
    return _then(_self.copyWith(registration: value));
  });
}/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyRegistrationCopyWith<$Res>? get myRegistration {
    if (_self.myRegistration == null) {
    return null;
  }

  return $MyRegistrationCopyWith<$Res>(_self.myRegistration!, (value) {
    return _then(_self.copyWith(myRegistration: value));
  });
}
}


/// @nodoc
mixin _$EventRegistrations {

 int get registrations; int get people; int get lodging; List<CityCount> get cities; List<Registrant> get registrants;
/// Create a copy of EventRegistrations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventRegistrationsCopyWith<EventRegistrations> get copyWith => _$EventRegistrationsCopyWithImpl<EventRegistrations>(this as EventRegistrations, _$identity);

  /// Serializes this EventRegistrations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventRegistrations&&(identical(other.registrations, registrations) || other.registrations == registrations)&&(identical(other.people, people) || other.people == people)&&(identical(other.lodging, lodging) || other.lodging == lodging)&&const DeepCollectionEquality().equals(other.cities, cities)&&const DeepCollectionEquality().equals(other.registrants, registrants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrations,people,lodging,const DeepCollectionEquality().hash(cities),const DeepCollectionEquality().hash(registrants));

@override
String toString() {
  return 'EventRegistrations(registrations: $registrations, people: $people, lodging: $lodging, cities: $cities, registrants: $registrants)';
}


}

/// @nodoc
abstract mixin class $EventRegistrationsCopyWith<$Res>  {
  factory $EventRegistrationsCopyWith(EventRegistrations value, $Res Function(EventRegistrations) _then) = _$EventRegistrationsCopyWithImpl;
@useResult
$Res call({
 int registrations, int people, int lodging, List<CityCount> cities, List<Registrant> registrants
});




}
/// @nodoc
class _$EventRegistrationsCopyWithImpl<$Res>
    implements $EventRegistrationsCopyWith<$Res> {
  _$EventRegistrationsCopyWithImpl(this._self, this._then);

  final EventRegistrations _self;
  final $Res Function(EventRegistrations) _then;

/// Create a copy of EventRegistrations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registrations = null,Object? people = null,Object? lodging = null,Object? cities = null,Object? registrants = null,}) {
  return _then(_self.copyWith(
registrations: null == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,lodging: null == lodging ? _self.lodging : lodging // ignore: cast_nullable_to_non_nullable
as int,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<CityCount>,registrants: null == registrants ? _self.registrants : registrants // ignore: cast_nullable_to_non_nullable
as List<Registrant>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventRegistrations].
extension EventRegistrationsPatterns on EventRegistrations {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventRegistrations value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventRegistrations() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventRegistrations value)  $default,){
final _that = this;
switch (_that) {
case _EventRegistrations():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventRegistrations value)?  $default,){
final _that = this;
switch (_that) {
case _EventRegistrations() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int registrations,  int people,  int lodging,  List<CityCount> cities,  List<Registrant> registrants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventRegistrations() when $default != null:
return $default(_that.registrations,_that.people,_that.lodging,_that.cities,_that.registrants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int registrations,  int people,  int lodging,  List<CityCount> cities,  List<Registrant> registrants)  $default,) {final _that = this;
switch (_that) {
case _EventRegistrations():
return $default(_that.registrations,_that.people,_that.lodging,_that.cities,_that.registrants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int registrations,  int people,  int lodging,  List<CityCount> cities,  List<Registrant> registrants)?  $default,) {final _that = this;
switch (_that) {
case _EventRegistrations() when $default != null:
return $default(_that.registrations,_that.people,_that.lodging,_that.cities,_that.registrants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventRegistrations implements EventRegistrations {
  const _EventRegistrations({this.registrations = 0, this.people = 0, this.lodging = 0, final  List<CityCount> cities = const <CityCount>[], final  List<Registrant> registrants = const <Registrant>[]}): _cities = cities,_registrants = registrants;
  factory _EventRegistrations.fromJson(Map<String, dynamic> json) => _$EventRegistrationsFromJson(json);

@override@JsonKey() final  int registrations;
@override@JsonKey() final  int people;
@override@JsonKey() final  int lodging;
 final  List<CityCount> _cities;
@override@JsonKey() List<CityCount> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}

 final  List<Registrant> _registrants;
@override@JsonKey() List<Registrant> get registrants {
  if (_registrants is EqualUnmodifiableListView) return _registrants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_registrants);
}


/// Create a copy of EventRegistrations
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventRegistrationsCopyWith<_EventRegistrations> get copyWith => __$EventRegistrationsCopyWithImpl<_EventRegistrations>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventRegistrationsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventRegistrations&&(identical(other.registrations, registrations) || other.registrations == registrations)&&(identical(other.people, people) || other.people == people)&&(identical(other.lodging, lodging) || other.lodging == lodging)&&const DeepCollectionEquality().equals(other._cities, _cities)&&const DeepCollectionEquality().equals(other._registrants, _registrants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrations,people,lodging,const DeepCollectionEquality().hash(_cities),const DeepCollectionEquality().hash(_registrants));

@override
String toString() {
  return 'EventRegistrations(registrations: $registrations, people: $people, lodging: $lodging, cities: $cities, registrants: $registrants)';
}


}

/// @nodoc
abstract mixin class _$EventRegistrationsCopyWith<$Res> implements $EventRegistrationsCopyWith<$Res> {
  factory _$EventRegistrationsCopyWith(_EventRegistrations value, $Res Function(_EventRegistrations) _then) = __$EventRegistrationsCopyWithImpl;
@override @useResult
$Res call({
 int registrations, int people, int lodging, List<CityCount> cities, List<Registrant> registrants
});




}
/// @nodoc
class __$EventRegistrationsCopyWithImpl<$Res>
    implements _$EventRegistrationsCopyWith<$Res> {
  __$EventRegistrationsCopyWithImpl(this._self, this._then);

  final _EventRegistrations _self;
  final $Res Function(_EventRegistrations) _then;

/// Create a copy of EventRegistrations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? registrations = null,Object? people = null,Object? lodging = null,Object? cities = null,Object? registrants = null,}) {
  return _then(_EventRegistrations(
registrations: null == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,lodging: null == lodging ? _self.lodging : lodging // ignore: cast_nullable_to_non_nullable
as int,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<CityCount>,registrants: null == registrants ? _self._registrants : registrants // ignore: cast_nullable_to_non_nullable
as List<Registrant>,
  ));
}


}


/// @nodoc
mixin _$CityCount {

 String get city; int get people;
/// Create a copy of CityCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityCountCopyWith<CityCount> get copyWith => _$CityCountCopyWithImpl<CityCount>(this as CityCount, _$identity);

  /// Serializes this CityCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityCount&&(identical(other.city, city) || other.city == city)&&(identical(other.people, people) || other.people == people));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,people);

@override
String toString() {
  return 'CityCount(city: $city, people: $people)';
}


}

/// @nodoc
abstract mixin class $CityCountCopyWith<$Res>  {
  factory $CityCountCopyWith(CityCount value, $Res Function(CityCount) _then) = _$CityCountCopyWithImpl;
@useResult
$Res call({
 String city, int people
});




}
/// @nodoc
class _$CityCountCopyWithImpl<$Res>
    implements $CityCountCopyWith<$Res> {
  _$CityCountCopyWithImpl(this._self, this._then);

  final CityCount _self;
  final $Res Function(CityCount) _then;

/// Create a copy of CityCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? people = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CityCount].
extension CityCountPatterns on CityCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityCount value)  $default,){
final _that = this;
switch (_that) {
case _CityCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityCount value)?  $default,){
final _that = this;
switch (_that) {
case _CityCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city,  int people)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityCount() when $default != null:
return $default(_that.city,_that.people);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city,  int people)  $default,) {final _that = this;
switch (_that) {
case _CityCount():
return $default(_that.city,_that.people);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city,  int people)?  $default,) {final _that = this;
switch (_that) {
case _CityCount() when $default != null:
return $default(_that.city,_that.people);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityCount implements CityCount {
  const _CityCount({required this.city, required this.people});
  factory _CityCount.fromJson(Map<String, dynamic> json) => _$CityCountFromJson(json);

@override final  String city;
@override final  int people;

/// Create a copy of CityCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityCountCopyWith<_CityCount> get copyWith => __$CityCountCopyWithImpl<_CityCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityCount&&(identical(other.city, city) || other.city == city)&&(identical(other.people, people) || other.people == people));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,people);

@override
String toString() {
  return 'CityCount(city: $city, people: $people)';
}


}

/// @nodoc
abstract mixin class _$CityCountCopyWith<$Res> implements $CityCountCopyWith<$Res> {
  factory _$CityCountCopyWith(_CityCount value, $Res Function(_CityCount) _then) = __$CityCountCopyWithImpl;
@override @useResult
$Res call({
 String city, int people
});




}
/// @nodoc
class __$CityCountCopyWithImpl<$Res>
    implements _$CityCountCopyWith<$Res> {
  __$CityCountCopyWithImpl(this._self, this._then);

  final _CityCount _self;
  final $Res Function(_CityCount) _then;

/// Create a copy of CityCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? people = null,}) {
  return _then(_CityCount(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Registrant {

 String get username; String get firstName; String get lastName; String get church; String get assembly; String get phoneNumber; int get people; bool get needsLodging; String get departureCity; DateTime get createdAt;
/// Create a copy of Registrant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrantCopyWith<Registrant> get copyWith => _$RegistrantCopyWithImpl<Registrant>(this as Registrant, _$identity);

  /// Serializes this Registrant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Registrant&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.church, church) || other.church == church)&&(identical(other.assembly, assembly) || other.assembly == assembly)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.people, people) || other.people == people)&&(identical(other.needsLodging, needsLodging) || other.needsLodging == needsLodging)&&(identical(other.departureCity, departureCity) || other.departureCity == departureCity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,firstName,lastName,church,assembly,phoneNumber,people,needsLodging,departureCity,createdAt);

@override
String toString() {
  return 'Registrant(username: $username, firstName: $firstName, lastName: $lastName, church: $church, assembly: $assembly, phoneNumber: $phoneNumber, people: $people, needsLodging: $needsLodging, departureCity: $departureCity, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RegistrantCopyWith<$Res>  {
  factory $RegistrantCopyWith(Registrant value, $Res Function(Registrant) _then) = _$RegistrantCopyWithImpl;
@useResult
$Res call({
 String username, String firstName, String lastName, String church, String assembly, String phoneNumber, int people, bool needsLodging, String departureCity, DateTime createdAt
});




}
/// @nodoc
class _$RegistrantCopyWithImpl<$Res>
    implements $RegistrantCopyWith<$Res> {
  _$RegistrantCopyWithImpl(this._self, this._then);

  final Registrant _self;
  final $Res Function(Registrant) _then;

/// Create a copy of Registrant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? firstName = null,Object? lastName = null,Object? church = null,Object? assembly = null,Object? phoneNumber = null,Object? people = null,Object? needsLodging = null,Object? departureCity = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,church: null == church ? _self.church : church // ignore: cast_nullable_to_non_nullable
as String,assembly: null == assembly ? _self.assembly : assembly // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,needsLodging: null == needsLodging ? _self.needsLodging : needsLodging // ignore: cast_nullable_to_non_nullable
as bool,departureCity: null == departureCity ? _self.departureCity : departureCity // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Registrant].
extension RegistrantPatterns on Registrant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Registrant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Registrant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Registrant value)  $default,){
final _that = this;
switch (_that) {
case _Registrant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Registrant value)?  $default,){
final _that = this;
switch (_that) {
case _Registrant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String firstName,  String lastName,  String church,  String assembly,  String phoneNumber,  int people,  bool needsLodging,  String departureCity,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Registrant() when $default != null:
return $default(_that.username,_that.firstName,_that.lastName,_that.church,_that.assembly,_that.phoneNumber,_that.people,_that.needsLodging,_that.departureCity,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String firstName,  String lastName,  String church,  String assembly,  String phoneNumber,  int people,  bool needsLodging,  String departureCity,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Registrant():
return $default(_that.username,_that.firstName,_that.lastName,_that.church,_that.assembly,_that.phoneNumber,_that.people,_that.needsLodging,_that.departureCity,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String firstName,  String lastName,  String church,  String assembly,  String phoneNumber,  int people,  bool needsLodging,  String departureCity,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Registrant() when $default != null:
return $default(_that.username,_that.firstName,_that.lastName,_that.church,_that.assembly,_that.phoneNumber,_that.people,_that.needsLodging,_that.departureCity,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Registrant extends Registrant {
  const _Registrant({required this.username, required this.firstName, this.lastName = '', this.church = '', this.assembly = '', this.phoneNumber = '', this.people = 1, this.needsLodging = false, this.departureCity = '', required this.createdAt}): super._();
  factory _Registrant.fromJson(Map<String, dynamic> json) => _$RegistrantFromJson(json);

@override final  String username;
@override final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String church;
@override@JsonKey() final  String assembly;
@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  int people;
@override@JsonKey() final  bool needsLodging;
@override@JsonKey() final  String departureCity;
@override final  DateTime createdAt;

/// Create a copy of Registrant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrantCopyWith<_Registrant> get copyWith => __$RegistrantCopyWithImpl<_Registrant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegistrantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Registrant&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.church, church) || other.church == church)&&(identical(other.assembly, assembly) || other.assembly == assembly)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.people, people) || other.people == people)&&(identical(other.needsLodging, needsLodging) || other.needsLodging == needsLodging)&&(identical(other.departureCity, departureCity) || other.departureCity == departureCity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,firstName,lastName,church,assembly,phoneNumber,people,needsLodging,departureCity,createdAt);

@override
String toString() {
  return 'Registrant(username: $username, firstName: $firstName, lastName: $lastName, church: $church, assembly: $assembly, phoneNumber: $phoneNumber, people: $people, needsLodging: $needsLodging, departureCity: $departureCity, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RegistrantCopyWith<$Res> implements $RegistrantCopyWith<$Res> {
  factory _$RegistrantCopyWith(_Registrant value, $Res Function(_Registrant) _then) = __$RegistrantCopyWithImpl;
@override @useResult
$Res call({
 String username, String firstName, String lastName, String church, String assembly, String phoneNumber, int people, bool needsLodging, String departureCity, DateTime createdAt
});




}
/// @nodoc
class __$RegistrantCopyWithImpl<$Res>
    implements _$RegistrantCopyWith<$Res> {
  __$RegistrantCopyWithImpl(this._self, this._then);

  final _Registrant _self;
  final $Res Function(_Registrant) _then;

/// Create a copy of Registrant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? firstName = null,Object? lastName = null,Object? church = null,Object? assembly = null,Object? phoneNumber = null,Object? people = null,Object? needsLodging = null,Object? departureCity = null,Object? createdAt = null,}) {
  return _then(_Registrant(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,church: null == church ? _self.church : church // ignore: cast_nullable_to_non_nullable
as String,assembly: null == assembly ? _self.assembly : assembly // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,needsLodging: null == needsLodging ? _self.needsLodging : needsLodging // ignore: cast_nullable_to_non_nullable
as bool,departureCity: null == departureCity ? _self.departureCity : departureCity // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
