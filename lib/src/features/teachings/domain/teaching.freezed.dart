// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teaching.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TeachingAudio {

 int get id; String get url;@JsonKey(unknownEnumValue: AudioFormat.mp3) AudioFormat get format; int get sizeBytes;
/// Create a copy of TeachingAudio
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingAudioCopyWith<TeachingAudio> get copyWith => _$TeachingAudioCopyWithImpl<TeachingAudio>(this as TeachingAudio, _$identity);

  /// Serializes this TeachingAudio to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeachingAudio&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.format, format) || other.format == format)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,format,sizeBytes);

@override
String toString() {
  return 'TeachingAudio(id: $id, url: $url, format: $format, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $TeachingAudioCopyWith<$Res>  {
  factory $TeachingAudioCopyWith(TeachingAudio value, $Res Function(TeachingAudio) _then) = _$TeachingAudioCopyWithImpl;
@useResult
$Res call({
 int id, String url,@JsonKey(unknownEnumValue: AudioFormat.mp3) AudioFormat format, int sizeBytes
});




}
/// @nodoc
class _$TeachingAudioCopyWithImpl<$Res>
    implements $TeachingAudioCopyWith<$Res> {
  _$TeachingAudioCopyWithImpl(this._self, this._then);

  final TeachingAudio _self;
  final $Res Function(TeachingAudio) _then;

/// Create a copy of TeachingAudio
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? format = null,Object? sizeBytes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as AudioFormat,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeachingAudio].
extension TeachingAudioPatterns on TeachingAudio {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeachingAudio value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeachingAudio() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeachingAudio value)  $default,){
final _that = this;
switch (_that) {
case _TeachingAudio():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeachingAudio value)?  $default,){
final _that = this;
switch (_that) {
case _TeachingAudio() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String url, @JsonKey(unknownEnumValue: AudioFormat.mp3)  AudioFormat format,  int sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeachingAudio() when $default != null:
return $default(_that.id,_that.url,_that.format,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String url, @JsonKey(unknownEnumValue: AudioFormat.mp3)  AudioFormat format,  int sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _TeachingAudio():
return $default(_that.id,_that.url,_that.format,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String url, @JsonKey(unknownEnumValue: AudioFormat.mp3)  AudioFormat format,  int sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _TeachingAudio() when $default != null:
return $default(_that.id,_that.url,_that.format,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeachingAudio implements TeachingAudio {
  const _TeachingAudio({required this.id, required this.url, @JsonKey(unknownEnumValue: AudioFormat.mp3) this.format = AudioFormat.mp3, this.sizeBytes = 0});
  factory _TeachingAudio.fromJson(Map<String, dynamic> json) => _$TeachingAudioFromJson(json);

@override final  int id;
@override final  String url;
@override@JsonKey(unknownEnumValue: AudioFormat.mp3) final  AudioFormat format;
@override@JsonKey() final  int sizeBytes;

/// Create a copy of TeachingAudio
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeachingAudioCopyWith<_TeachingAudio> get copyWith => __$TeachingAudioCopyWithImpl<_TeachingAudio>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeachingAudioToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeachingAudio&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.format, format) || other.format == format)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,format,sizeBytes);

@override
String toString() {
  return 'TeachingAudio(id: $id, url: $url, format: $format, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$TeachingAudioCopyWith<$Res> implements $TeachingAudioCopyWith<$Res> {
  factory _$TeachingAudioCopyWith(_TeachingAudio value, $Res Function(_TeachingAudio) _then) = __$TeachingAudioCopyWithImpl;
@override @useResult
$Res call({
 int id, String url,@JsonKey(unknownEnumValue: AudioFormat.mp3) AudioFormat format, int sizeBytes
});




}
/// @nodoc
class __$TeachingAudioCopyWithImpl<$Res>
    implements _$TeachingAudioCopyWith<$Res> {
  __$TeachingAudioCopyWithImpl(this._self, this._then);

  final _TeachingAudio _self;
  final $Res Function(_TeachingAudio) _then;

/// Create a copy of TeachingAudio
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? format = null,Object? sizeBytes = null,}) {
  return _then(_TeachingAudio(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as AudioFormat,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Teaching {

 int get id; String get title;/// "Pr Zacharias Tanee Fomum"; '' when not said.
 String get speaker; String get description;/// "Prédications"…; '' when none.
 String get category;/// The day the message was given ("1994-08-15"), null when unknown.
 String? get recordedOn; TeachingAudio get audio;/// Read by the admin site; 0 when unknown (the player knows it then).
 int get durationSeconds; EventImage? get cover;
/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingCopyWith<Teaching> get copyWith => _$TeachingCopyWithImpl<Teaching>(this as Teaching, _$identity);

  /// Serializes this Teaching to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Teaching&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.recordedOn, recordedOn) || other.recordedOn == recordedOn)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.cover, cover) || other.cover == cover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,speaker,description,category,recordedOn,audio,durationSeconds,cover);

@override
String toString() {
  return 'Teaching(id: $id, title: $title, speaker: $speaker, description: $description, category: $category, recordedOn: $recordedOn, audio: $audio, durationSeconds: $durationSeconds, cover: $cover)';
}


}

/// @nodoc
abstract mixin class $TeachingCopyWith<$Res>  {
  factory $TeachingCopyWith(Teaching value, $Res Function(Teaching) _then) = _$TeachingCopyWithImpl;
@useResult
$Res call({
 int id, String title, String speaker, String description, String category, String? recordedOn, TeachingAudio audio, int durationSeconds, EventImage? cover
});


$TeachingAudioCopyWith<$Res> get audio;$EventImageCopyWith<$Res>? get cover;

}
/// @nodoc
class _$TeachingCopyWithImpl<$Res>
    implements $TeachingCopyWith<$Res> {
  _$TeachingCopyWithImpl(this._self, this._then);

  final Teaching _self;
  final $Res Function(Teaching) _then;

/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? speaker = null,Object? description = null,Object? category = null,Object? recordedOn = freezed,Object? audio = null,Object? durationSeconds = null,Object? cover = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,recordedOn: freezed == recordedOn ? _self.recordedOn : recordedOn // ignore: cast_nullable_to_non_nullable
as String?,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as TeachingAudio,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as EventImage?,
  ));
}
/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeachingAudioCopyWith<$Res> get audio {
  
  return $TeachingAudioCopyWith<$Res>(_self.audio, (value) {
    return _then(_self.copyWith(audio: value));
  });
}/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get cover {
    if (_self.cover == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.cover!, (value) {
    return _then(_self.copyWith(cover: value));
  });
}
}


/// Adds pattern-matching-related methods to [Teaching].
extension TeachingPatterns on Teaching {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Teaching value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Teaching() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Teaching value)  $default,){
final _that = this;
switch (_that) {
case _Teaching():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Teaching value)?  $default,){
final _that = this;
switch (_that) {
case _Teaching() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String speaker,  String description,  String category,  String? recordedOn,  TeachingAudio audio,  int durationSeconds,  EventImage? cover)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Teaching() when $default != null:
return $default(_that.id,_that.title,_that.speaker,_that.description,_that.category,_that.recordedOn,_that.audio,_that.durationSeconds,_that.cover);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String speaker,  String description,  String category,  String? recordedOn,  TeachingAudio audio,  int durationSeconds,  EventImage? cover)  $default,) {final _that = this;
switch (_that) {
case _Teaching():
return $default(_that.id,_that.title,_that.speaker,_that.description,_that.category,_that.recordedOn,_that.audio,_that.durationSeconds,_that.cover);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String speaker,  String description,  String category,  String? recordedOn,  TeachingAudio audio,  int durationSeconds,  EventImage? cover)?  $default,) {final _that = this;
switch (_that) {
case _Teaching() when $default != null:
return $default(_that.id,_that.title,_that.speaker,_that.description,_that.category,_that.recordedOn,_that.audio,_that.durationSeconds,_that.cover);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Teaching extends Teaching {
  const _Teaching({required this.id, required this.title, this.speaker = '', this.description = '', this.category = '', this.recordedOn, required this.audio, this.durationSeconds = 0, this.cover}): super._();
  factory _Teaching.fromJson(Map<String, dynamic> json) => _$TeachingFromJson(json);

@override final  int id;
@override final  String title;
/// "Pr Zacharias Tanee Fomum"; '' when not said.
@override@JsonKey() final  String speaker;
@override@JsonKey() final  String description;
/// "Prédications"…; '' when none.
@override@JsonKey() final  String category;
/// The day the message was given ("1994-08-15"), null when unknown.
@override final  String? recordedOn;
@override final  TeachingAudio audio;
/// Read by the admin site; 0 when unknown (the player knows it then).
@override@JsonKey() final  int durationSeconds;
@override final  EventImage? cover;

/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeachingCopyWith<_Teaching> get copyWith => __$TeachingCopyWithImpl<_Teaching>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeachingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Teaching&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.recordedOn, recordedOn) || other.recordedOn == recordedOn)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.cover, cover) || other.cover == cover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,speaker,description,category,recordedOn,audio,durationSeconds,cover);

@override
String toString() {
  return 'Teaching(id: $id, title: $title, speaker: $speaker, description: $description, category: $category, recordedOn: $recordedOn, audio: $audio, durationSeconds: $durationSeconds, cover: $cover)';
}


}

/// @nodoc
abstract mixin class _$TeachingCopyWith<$Res> implements $TeachingCopyWith<$Res> {
  factory _$TeachingCopyWith(_Teaching value, $Res Function(_Teaching) _then) = __$TeachingCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String speaker, String description, String category, String? recordedOn, TeachingAudio audio, int durationSeconds, EventImage? cover
});


@override $TeachingAudioCopyWith<$Res> get audio;@override $EventImageCopyWith<$Res>? get cover;

}
/// @nodoc
class __$TeachingCopyWithImpl<$Res>
    implements _$TeachingCopyWith<$Res> {
  __$TeachingCopyWithImpl(this._self, this._then);

  final _Teaching _self;
  final $Res Function(_Teaching) _then;

/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? speaker = null,Object? description = null,Object? category = null,Object? recordedOn = freezed,Object? audio = null,Object? durationSeconds = null,Object? cover = freezed,}) {
  return _then(_Teaching(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,recordedOn: freezed == recordedOn ? _self.recordedOn : recordedOn // ignore: cast_nullable_to_non_nullable
as String?,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as TeachingAudio,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as EventImage?,
  ));
}

/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeachingAudioCopyWith<$Res> get audio {
  
  return $TeachingAudioCopyWith<$Res>(_self.audio, (value) {
    return _then(_self.copyWith(audio: value));
  });
}/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get cover {
    if (_self.cover == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.cover!, (value) {
    return _then(_self.copyWith(cover: value));
  });
}
}


/// @nodoc
mixin _$TeachingCategory {

 String get name; int get count;
/// Create a copy of TeachingCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingCategoryCopyWith<TeachingCategory> get copyWith => _$TeachingCategoryCopyWithImpl<TeachingCategory>(this as TeachingCategory, _$identity);

  /// Serializes this TeachingCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeachingCategory&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'TeachingCategory(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class $TeachingCategoryCopyWith<$Res>  {
  factory $TeachingCategoryCopyWith(TeachingCategory value, $Res Function(TeachingCategory) _then) = _$TeachingCategoryCopyWithImpl;
@useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class _$TeachingCategoryCopyWithImpl<$Res>
    implements $TeachingCategoryCopyWith<$Res> {
  _$TeachingCategoryCopyWithImpl(this._self, this._then);

  final TeachingCategory _self;
  final $Res Function(TeachingCategory) _then;

/// Create a copy of TeachingCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? count = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeachingCategory].
extension TeachingCategoryPatterns on TeachingCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeachingCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeachingCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeachingCategory value)  $default,){
final _that = this;
switch (_that) {
case _TeachingCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeachingCategory value)?  $default,){
final _that = this;
switch (_that) {
case _TeachingCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeachingCategory() when $default != null:
return $default(_that.name,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int count)  $default,) {final _that = this;
switch (_that) {
case _TeachingCategory():
return $default(_that.name,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int count)?  $default,) {final _that = this;
switch (_that) {
case _TeachingCategory() when $default != null:
return $default(_that.name,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeachingCategory implements TeachingCategory {
  const _TeachingCategory({required this.name, this.count = 0});
  factory _TeachingCategory.fromJson(Map<String, dynamic> json) => _$TeachingCategoryFromJson(json);

@override final  String name;
@override@JsonKey() final  int count;

/// Create a copy of TeachingCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeachingCategoryCopyWith<_TeachingCategory> get copyWith => __$TeachingCategoryCopyWithImpl<_TeachingCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeachingCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeachingCategory&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'TeachingCategory(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class _$TeachingCategoryCopyWith<$Res> implements $TeachingCategoryCopyWith<$Res> {
  factory _$TeachingCategoryCopyWith(_TeachingCategory value, $Res Function(_TeachingCategory) _then) = __$TeachingCategoryCopyWithImpl;
@override @useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class __$TeachingCategoryCopyWithImpl<$Res>
    implements _$TeachingCategoryCopyWith<$Res> {
  __$TeachingCategoryCopyWithImpl(this._self, this._then);

  final _TeachingCategory _self;
  final $Res Function(_TeachingCategory) _then;

/// Create a copy of TeachingCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? count = null,}) {
  return _then(_TeachingCategory(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
