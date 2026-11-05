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
mixin _$TeachingEditionBrief {

 int get id; String get title; String get theme; int get year;
/// Create a copy of TeachingEditionBrief
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingEditionBriefCopyWith<TeachingEditionBrief> get copyWith => _$TeachingEditionBriefCopyWithImpl<TeachingEditionBrief>(this as TeachingEditionBrief, _$identity);

  /// Serializes this TeachingEditionBrief to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeachingEditionBrief&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,theme,year);

@override
String toString() {
  return 'TeachingEditionBrief(id: $id, title: $title, theme: $theme, year: $year)';
}


}

/// @nodoc
abstract mixin class $TeachingEditionBriefCopyWith<$Res>  {
  factory $TeachingEditionBriefCopyWith(TeachingEditionBrief value, $Res Function(TeachingEditionBrief) _then) = _$TeachingEditionBriefCopyWithImpl;
@useResult
$Res call({
 int id, String title, String theme, int year
});




}
/// @nodoc
class _$TeachingEditionBriefCopyWithImpl<$Res>
    implements $TeachingEditionBriefCopyWith<$Res> {
  _$TeachingEditionBriefCopyWithImpl(this._self, this._then);

  final TeachingEditionBrief _self;
  final $Res Function(TeachingEditionBrief) _then;

/// Create a copy of TeachingEditionBrief
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? theme = null,Object? year = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeachingEditionBrief].
extension TeachingEditionBriefPatterns on TeachingEditionBrief {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeachingEditionBrief value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeachingEditionBrief() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeachingEditionBrief value)  $default,){
final _that = this;
switch (_that) {
case _TeachingEditionBrief():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeachingEditionBrief value)?  $default,){
final _that = this;
switch (_that) {
case _TeachingEditionBrief() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String theme,  int year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeachingEditionBrief() when $default != null:
return $default(_that.id,_that.title,_that.theme,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String theme,  int year)  $default,) {final _that = this;
switch (_that) {
case _TeachingEditionBrief():
return $default(_that.id,_that.title,_that.theme,_that.year);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String theme,  int year)?  $default,) {final _that = this;
switch (_that) {
case _TeachingEditionBrief() when $default != null:
return $default(_that.id,_that.title,_that.theme,_that.year);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeachingEditionBrief implements TeachingEditionBrief {
  const _TeachingEditionBrief({required this.id, this.title = '', this.theme = '', this.year = 0});
  factory _TeachingEditionBrief.fromJson(Map<String, dynamic> json) => _$TeachingEditionBriefFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String theme;
@override@JsonKey() final  int year;

/// Create a copy of TeachingEditionBrief
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeachingEditionBriefCopyWith<_TeachingEditionBrief> get copyWith => __$TeachingEditionBriefCopyWithImpl<_TeachingEditionBrief>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeachingEditionBriefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeachingEditionBrief&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,theme,year);

@override
String toString() {
  return 'TeachingEditionBrief(id: $id, title: $title, theme: $theme, year: $year)';
}


}

/// @nodoc
abstract mixin class _$TeachingEditionBriefCopyWith<$Res> implements $TeachingEditionBriefCopyWith<$Res> {
  factory _$TeachingEditionBriefCopyWith(_TeachingEditionBrief value, $Res Function(_TeachingEditionBrief) _then) = __$TeachingEditionBriefCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String theme, int year
});




}
/// @nodoc
class __$TeachingEditionBriefCopyWithImpl<$Res>
    implements _$TeachingEditionBriefCopyWith<$Res> {
  __$TeachingEditionBriefCopyWithImpl(this._self, this._then);

  final _TeachingEditionBrief _self;
  final $Res Function(_TeachingEditionBrief) _then;

/// Create a copy of TeachingEditionBrief
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? theme = null,Object? year = null,}) {
  return _then(_TeachingEditionBrief(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Teaching {

 int get id; String get title;/// "Pr Zacharias Tanee Fomum"; '' when not said.
 String get speaker; String get description;/// "Prédications"…; '' when none. Kept for the apps that don't know
/// [categoryId] yet.
 String get category;/// The category chosen by the admins; null when none.
 int? get categoryId;/// "camp-des-jeunes": the category in the addresses of the API.
 String get categorySlug;/// "2026"; null when unknown.
 int? get year;/// Day 1, 2… of a camp or a crusade; several may share it.
 int? get dayNumber;/// Their order inside the day.
 int get position;/// The annual edition ("Camp des jeunes 2026"); null when none.
 TeachingEditionBrief? get edition;/// The day the message was given ("1994-08-15"), null when unknown.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Teaching&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.year, year) || other.year == year)&&(identical(other.dayNumber, dayNumber) || other.dayNumber == dayNumber)&&(identical(other.position, position) || other.position == position)&&(identical(other.edition, edition) || other.edition == edition)&&(identical(other.recordedOn, recordedOn) || other.recordedOn == recordedOn)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.cover, cover) || other.cover == cover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,speaker,description,category,categoryId,categorySlug,year,dayNumber,position,edition,recordedOn,audio,durationSeconds,cover);

@override
String toString() {
  return 'Teaching(id: $id, title: $title, speaker: $speaker, description: $description, category: $category, categoryId: $categoryId, categorySlug: $categorySlug, year: $year, dayNumber: $dayNumber, position: $position, edition: $edition, recordedOn: $recordedOn, audio: $audio, durationSeconds: $durationSeconds, cover: $cover)';
}


}

/// @nodoc
abstract mixin class $TeachingCopyWith<$Res>  {
  factory $TeachingCopyWith(Teaching value, $Res Function(Teaching) _then) = _$TeachingCopyWithImpl;
@useResult
$Res call({
 int id, String title, String speaker, String description, String category, int? categoryId, String categorySlug, int? year, int? dayNumber, int position, TeachingEditionBrief? edition, String? recordedOn, TeachingAudio audio, int durationSeconds, EventImage? cover
});


$TeachingEditionBriefCopyWith<$Res>? get edition;$TeachingAudioCopyWith<$Res> get audio;$EventImageCopyWith<$Res>? get cover;

}
/// @nodoc
class _$TeachingCopyWithImpl<$Res>
    implements $TeachingCopyWith<$Res> {
  _$TeachingCopyWithImpl(this._self, this._then);

  final Teaching _self;
  final $Res Function(Teaching) _then;

/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? speaker = null,Object? description = null,Object? category = null,Object? categoryId = freezed,Object? categorySlug = null,Object? year = freezed,Object? dayNumber = freezed,Object? position = null,Object? edition = freezed,Object? recordedOn = freezed,Object? audio = null,Object? durationSeconds = null,Object? cover = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,categorySlug: null == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,dayNumber: freezed == dayNumber ? _self.dayNumber : dayNumber // ignore: cast_nullable_to_non_nullable
as int?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,edition: freezed == edition ? _self.edition : edition // ignore: cast_nullable_to_non_nullable
as TeachingEditionBrief?,recordedOn: freezed == recordedOn ? _self.recordedOn : recordedOn // ignore: cast_nullable_to_non_nullable
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
$TeachingEditionBriefCopyWith<$Res>? get edition {
    if (_self.edition == null) {
    return null;
  }

  return $TeachingEditionBriefCopyWith<$Res>(_self.edition!, (value) {
    return _then(_self.copyWith(edition: value));
  });
}/// Create a copy of Teaching
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String speaker,  String description,  String category,  int? categoryId,  String categorySlug,  int? year,  int? dayNumber,  int position,  TeachingEditionBrief? edition,  String? recordedOn,  TeachingAudio audio,  int durationSeconds,  EventImage? cover)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Teaching() when $default != null:
return $default(_that.id,_that.title,_that.speaker,_that.description,_that.category,_that.categoryId,_that.categorySlug,_that.year,_that.dayNumber,_that.position,_that.edition,_that.recordedOn,_that.audio,_that.durationSeconds,_that.cover);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String speaker,  String description,  String category,  int? categoryId,  String categorySlug,  int? year,  int? dayNumber,  int position,  TeachingEditionBrief? edition,  String? recordedOn,  TeachingAudio audio,  int durationSeconds,  EventImage? cover)  $default,) {final _that = this;
switch (_that) {
case _Teaching():
return $default(_that.id,_that.title,_that.speaker,_that.description,_that.category,_that.categoryId,_that.categorySlug,_that.year,_that.dayNumber,_that.position,_that.edition,_that.recordedOn,_that.audio,_that.durationSeconds,_that.cover);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String speaker,  String description,  String category,  int? categoryId,  String categorySlug,  int? year,  int? dayNumber,  int position,  TeachingEditionBrief? edition,  String? recordedOn,  TeachingAudio audio,  int durationSeconds,  EventImage? cover)?  $default,) {final _that = this;
switch (_that) {
case _Teaching() when $default != null:
return $default(_that.id,_that.title,_that.speaker,_that.description,_that.category,_that.categoryId,_that.categorySlug,_that.year,_that.dayNumber,_that.position,_that.edition,_that.recordedOn,_that.audio,_that.durationSeconds,_that.cover);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Teaching extends Teaching {
  const _Teaching({required this.id, required this.title, this.speaker = '', this.description = '', this.category = '', this.categoryId, this.categorySlug = '', this.year, this.dayNumber, this.position = 0, this.edition, this.recordedOn, required this.audio, this.durationSeconds = 0, this.cover}): super._();
  factory _Teaching.fromJson(Map<String, dynamic> json) => _$TeachingFromJson(json);

@override final  int id;
@override final  String title;
/// "Pr Zacharias Tanee Fomum"; '' when not said.
@override@JsonKey() final  String speaker;
@override@JsonKey() final  String description;
/// "Prédications"…; '' when none. Kept for the apps that don't know
/// [categoryId] yet.
@override@JsonKey() final  String category;
/// The category chosen by the admins; null when none.
@override final  int? categoryId;
/// "camp-des-jeunes": the category in the addresses of the API.
@override@JsonKey() final  String categorySlug;
/// "2026"; null when unknown.
@override final  int? year;
/// Day 1, 2… of a camp or a crusade; several may share it.
@override final  int? dayNumber;
/// Their order inside the day.
@override@JsonKey() final  int position;
/// The annual edition ("Camp des jeunes 2026"); null when none.
@override final  TeachingEditionBrief? edition;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Teaching&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.year, year) || other.year == year)&&(identical(other.dayNumber, dayNumber) || other.dayNumber == dayNumber)&&(identical(other.position, position) || other.position == position)&&(identical(other.edition, edition) || other.edition == edition)&&(identical(other.recordedOn, recordedOn) || other.recordedOn == recordedOn)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.cover, cover) || other.cover == cover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,speaker,description,category,categoryId,categorySlug,year,dayNumber,position,edition,recordedOn,audio,durationSeconds,cover);

@override
String toString() {
  return 'Teaching(id: $id, title: $title, speaker: $speaker, description: $description, category: $category, categoryId: $categoryId, categorySlug: $categorySlug, year: $year, dayNumber: $dayNumber, position: $position, edition: $edition, recordedOn: $recordedOn, audio: $audio, durationSeconds: $durationSeconds, cover: $cover)';
}


}

/// @nodoc
abstract mixin class _$TeachingCopyWith<$Res> implements $TeachingCopyWith<$Res> {
  factory _$TeachingCopyWith(_Teaching value, $Res Function(_Teaching) _then) = __$TeachingCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String speaker, String description, String category, int? categoryId, String categorySlug, int? year, int? dayNumber, int position, TeachingEditionBrief? edition, String? recordedOn, TeachingAudio audio, int durationSeconds, EventImage? cover
});


@override $TeachingEditionBriefCopyWith<$Res>? get edition;@override $TeachingAudioCopyWith<$Res> get audio;@override $EventImageCopyWith<$Res>? get cover;

}
/// @nodoc
class __$TeachingCopyWithImpl<$Res>
    implements _$TeachingCopyWith<$Res> {
  __$TeachingCopyWithImpl(this._self, this._then);

  final _Teaching _self;
  final $Res Function(_Teaching) _then;

/// Create a copy of Teaching
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? speaker = null,Object? description = null,Object? category = null,Object? categoryId = freezed,Object? categorySlug = null,Object? year = freezed,Object? dayNumber = freezed,Object? position = null,Object? edition = freezed,Object? recordedOn = freezed,Object? audio = null,Object? durationSeconds = null,Object? cover = freezed,}) {
  return _then(_Teaching(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,categorySlug: null == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,dayNumber: freezed == dayNumber ? _self.dayNumber : dayNumber // ignore: cast_nullable_to_non_nullable
as int?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,edition: freezed == edition ? _self.edition : edition // ignore: cast_nullable_to_non_nullable
as TeachingEditionBrief?,recordedOn: freezed == recordedOn ? _self.recordedOn : recordedOn // ignore: cast_nullable_to_non_nullable
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
$TeachingEditionBriefCopyWith<$Res>? get edition {
    if (_self.edition == null) {
    return null;
  }

  return $TeachingEditionBriefCopyWith<$Res>(_self.edition!, (value) {
    return _then(_self.copyWith(edition: value));
  });
}/// Create a copy of Teaching
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

 int get id; String get name; String get slug; int get count;
/// Create a copy of TeachingCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingCategoryCopyWith<TeachingCategory> get copyWith => _$TeachingCategoryCopyWithImpl<TeachingCategory>(this as TeachingCategory, _$identity);

  /// Serializes this TeachingCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeachingCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,count);

@override
String toString() {
  return 'TeachingCategory(id: $id, name: $name, slug: $slug, count: $count)';
}


}

/// @nodoc
abstract mixin class $TeachingCategoryCopyWith<$Res>  {
  factory $TeachingCategoryCopyWith(TeachingCategory value, $Res Function(TeachingCategory) _then) = _$TeachingCategoryCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, int count
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? count = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeachingCategory() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  int count)  $default,) {final _that = this;
switch (_that) {
case _TeachingCategory():
return $default(_that.id,_that.name,_that.slug,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  int count)?  $default,) {final _that = this;
switch (_that) {
case _TeachingCategory() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeachingCategory implements TeachingCategory {
  const _TeachingCategory({this.id = 0, required this.name, this.slug = '', this.count = 0});
  factory _TeachingCategory.fromJson(Map<String, dynamic> json) => _$TeachingCategoryFromJson(json);

@override@JsonKey() final  int id;
@override final  String name;
@override@JsonKey() final  String slug;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeachingCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,count);

@override
String toString() {
  return 'TeachingCategory(id: $id, name: $name, slug: $slug, count: $count)';
}


}

/// @nodoc
abstract mixin class _$TeachingCategoryCopyWith<$Res> implements $TeachingCategoryCopyWith<$Res> {
  factory _$TeachingCategoryCopyWith(_TeachingCategory value, $Res Function(_TeachingCategory) _then) = __$TeachingCategoryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, int count
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? count = null,}) {
  return _then(_TeachingCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TeachingSpeakerFacet {

 String get name; int get count;
/// Create a copy of TeachingSpeakerFacet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingSpeakerFacetCopyWith<TeachingSpeakerFacet> get copyWith => _$TeachingSpeakerFacetCopyWithImpl<TeachingSpeakerFacet>(this as TeachingSpeakerFacet, _$identity);

  /// Serializes this TeachingSpeakerFacet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeachingSpeakerFacet&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'TeachingSpeakerFacet(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class $TeachingSpeakerFacetCopyWith<$Res>  {
  factory $TeachingSpeakerFacetCopyWith(TeachingSpeakerFacet value, $Res Function(TeachingSpeakerFacet) _then) = _$TeachingSpeakerFacetCopyWithImpl;
@useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class _$TeachingSpeakerFacetCopyWithImpl<$Res>
    implements $TeachingSpeakerFacetCopyWith<$Res> {
  _$TeachingSpeakerFacetCopyWithImpl(this._self, this._then);

  final TeachingSpeakerFacet _self;
  final $Res Function(TeachingSpeakerFacet) _then;

/// Create a copy of TeachingSpeakerFacet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? count = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeachingSpeakerFacet].
extension TeachingSpeakerFacetPatterns on TeachingSpeakerFacet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeachingSpeakerFacet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeachingSpeakerFacet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeachingSpeakerFacet value)  $default,){
final _that = this;
switch (_that) {
case _TeachingSpeakerFacet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeachingSpeakerFacet value)?  $default,){
final _that = this;
switch (_that) {
case _TeachingSpeakerFacet() when $default != null:
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
case _TeachingSpeakerFacet() when $default != null:
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
case _TeachingSpeakerFacet():
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
case _TeachingSpeakerFacet() when $default != null:
return $default(_that.name,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeachingSpeakerFacet implements TeachingSpeakerFacet {
  const _TeachingSpeakerFacet({required this.name, this.count = 0});
  factory _TeachingSpeakerFacet.fromJson(Map<String, dynamic> json) => _$TeachingSpeakerFacetFromJson(json);

@override final  String name;
@override@JsonKey() final  int count;

/// Create a copy of TeachingSpeakerFacet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeachingSpeakerFacetCopyWith<_TeachingSpeakerFacet> get copyWith => __$TeachingSpeakerFacetCopyWithImpl<_TeachingSpeakerFacet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeachingSpeakerFacetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeachingSpeakerFacet&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'TeachingSpeakerFacet(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class _$TeachingSpeakerFacetCopyWith<$Res> implements $TeachingSpeakerFacetCopyWith<$Res> {
  factory _$TeachingSpeakerFacetCopyWith(_TeachingSpeakerFacet value, $Res Function(_TeachingSpeakerFacet) _then) = __$TeachingSpeakerFacetCopyWithImpl;
@override @useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class __$TeachingSpeakerFacetCopyWithImpl<$Res>
    implements _$TeachingSpeakerFacetCopyWith<$Res> {
  __$TeachingSpeakerFacetCopyWithImpl(this._self, this._then);

  final _TeachingSpeakerFacet _self;
  final $Res Function(_TeachingSpeakerFacet) _then;

/// Create a copy of TeachingSpeakerFacet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? count = null,}) {
  return _then(_TeachingSpeakerFacet(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TeachingYearFacet {

 int get year; int get count;
/// Create a copy of TeachingYearFacet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingYearFacetCopyWith<TeachingYearFacet> get copyWith => _$TeachingYearFacetCopyWithImpl<TeachingYearFacet>(this as TeachingYearFacet, _$identity);

  /// Serializes this TeachingYearFacet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeachingYearFacet&&(identical(other.year, year) || other.year == year)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,count);

@override
String toString() {
  return 'TeachingYearFacet(year: $year, count: $count)';
}


}

/// @nodoc
abstract mixin class $TeachingYearFacetCopyWith<$Res>  {
  factory $TeachingYearFacetCopyWith(TeachingYearFacet value, $Res Function(TeachingYearFacet) _then) = _$TeachingYearFacetCopyWithImpl;
@useResult
$Res call({
 int year, int count
});




}
/// @nodoc
class _$TeachingYearFacetCopyWithImpl<$Res>
    implements $TeachingYearFacetCopyWith<$Res> {
  _$TeachingYearFacetCopyWithImpl(this._self, this._then);

  final TeachingYearFacet _self;
  final $Res Function(TeachingYearFacet) _then;

/// Create a copy of TeachingYearFacet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? count = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeachingYearFacet].
extension TeachingYearFacetPatterns on TeachingYearFacet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeachingYearFacet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeachingYearFacet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeachingYearFacet value)  $default,){
final _that = this;
switch (_that) {
case _TeachingYearFacet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeachingYearFacet value)?  $default,){
final _that = this;
switch (_that) {
case _TeachingYearFacet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeachingYearFacet() when $default != null:
return $default(_that.year,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int count)  $default,) {final _that = this;
switch (_that) {
case _TeachingYearFacet():
return $default(_that.year,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int count)?  $default,) {final _that = this;
switch (_that) {
case _TeachingYearFacet() when $default != null:
return $default(_that.year,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeachingYearFacet implements TeachingYearFacet {
  const _TeachingYearFacet({required this.year, this.count = 0});
  factory _TeachingYearFacet.fromJson(Map<String, dynamic> json) => _$TeachingYearFacetFromJson(json);

@override final  int year;
@override@JsonKey() final  int count;

/// Create a copy of TeachingYearFacet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeachingYearFacetCopyWith<_TeachingYearFacet> get copyWith => __$TeachingYearFacetCopyWithImpl<_TeachingYearFacet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeachingYearFacetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeachingYearFacet&&(identical(other.year, year) || other.year == year)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,count);

@override
String toString() {
  return 'TeachingYearFacet(year: $year, count: $count)';
}


}

/// @nodoc
abstract mixin class _$TeachingYearFacetCopyWith<$Res> implements $TeachingYearFacetCopyWith<$Res> {
  factory _$TeachingYearFacetCopyWith(_TeachingYearFacet value, $Res Function(_TeachingYearFacet) _then) = __$TeachingYearFacetCopyWithImpl;
@override @useResult
$Res call({
 int year, int count
});




}
/// @nodoc
class __$TeachingYearFacetCopyWithImpl<$Res>
    implements _$TeachingYearFacetCopyWith<$Res> {
  __$TeachingYearFacetCopyWithImpl(this._self, this._then);

  final _TeachingYearFacet _self;
  final $Res Function(_TeachingYearFacet) _then;

/// Create a copy of TeachingYearFacet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? count = null,}) {
  return _then(_TeachingYearFacet(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TeachingDayFacet {

 int get day; int get count;
/// Create a copy of TeachingDayFacet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingDayFacetCopyWith<TeachingDayFacet> get copyWith => _$TeachingDayFacetCopyWithImpl<TeachingDayFacet>(this as TeachingDayFacet, _$identity);

  /// Serializes this TeachingDayFacet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeachingDayFacet&&(identical(other.day, day) || other.day == day)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,count);

@override
String toString() {
  return 'TeachingDayFacet(day: $day, count: $count)';
}


}

/// @nodoc
abstract mixin class $TeachingDayFacetCopyWith<$Res>  {
  factory $TeachingDayFacetCopyWith(TeachingDayFacet value, $Res Function(TeachingDayFacet) _then) = _$TeachingDayFacetCopyWithImpl;
@useResult
$Res call({
 int day, int count
});




}
/// @nodoc
class _$TeachingDayFacetCopyWithImpl<$Res>
    implements $TeachingDayFacetCopyWith<$Res> {
  _$TeachingDayFacetCopyWithImpl(this._self, this._then);

  final TeachingDayFacet _self;
  final $Res Function(TeachingDayFacet) _then;

/// Create a copy of TeachingDayFacet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? count = null,}) {
  return _then(_self.copyWith(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeachingDayFacet].
extension TeachingDayFacetPatterns on TeachingDayFacet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeachingDayFacet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeachingDayFacet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeachingDayFacet value)  $default,){
final _that = this;
switch (_that) {
case _TeachingDayFacet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeachingDayFacet value)?  $default,){
final _that = this;
switch (_that) {
case _TeachingDayFacet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int day,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeachingDayFacet() when $default != null:
return $default(_that.day,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int day,  int count)  $default,) {final _that = this;
switch (_that) {
case _TeachingDayFacet():
return $default(_that.day,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int day,  int count)?  $default,) {final _that = this;
switch (_that) {
case _TeachingDayFacet() when $default != null:
return $default(_that.day,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeachingDayFacet implements TeachingDayFacet {
  const _TeachingDayFacet({required this.day, this.count = 0});
  factory _TeachingDayFacet.fromJson(Map<String, dynamic> json) => _$TeachingDayFacetFromJson(json);

@override final  int day;
@override@JsonKey() final  int count;

/// Create a copy of TeachingDayFacet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeachingDayFacetCopyWith<_TeachingDayFacet> get copyWith => __$TeachingDayFacetCopyWithImpl<_TeachingDayFacet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeachingDayFacetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeachingDayFacet&&(identical(other.day, day) || other.day == day)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,count);

@override
String toString() {
  return 'TeachingDayFacet(day: $day, count: $count)';
}


}

/// @nodoc
abstract mixin class _$TeachingDayFacetCopyWith<$Res> implements $TeachingDayFacetCopyWith<$Res> {
  factory _$TeachingDayFacetCopyWith(_TeachingDayFacet value, $Res Function(_TeachingDayFacet) _then) = __$TeachingDayFacetCopyWithImpl;
@override @useResult
$Res call({
 int day, int count
});




}
/// @nodoc
class __$TeachingDayFacetCopyWithImpl<$Res>
    implements _$TeachingDayFacetCopyWith<$Res> {
  __$TeachingDayFacetCopyWithImpl(this._self, this._then);

  final _TeachingDayFacet _self;
  final $Res Function(_TeachingDayFacet) _then;

/// Create a copy of TeachingDayFacet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? count = null,}) {
  return _then(_TeachingDayFacet(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TeachingEditionFacet {

 int get id; int get categoryId; String get categoryName; String get categorySlug; int get year; String get title; int get count;
/// Create a copy of TeachingEditionFacet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingEditionFacetCopyWith<TeachingEditionFacet> get copyWith => _$TeachingEditionFacetCopyWithImpl<TeachingEditionFacet>(this as TeachingEditionFacet, _$identity);

  /// Serializes this TeachingEditionFacet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeachingEditionFacet&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.year, year) || other.year == year)&&(identical(other.title, title) || other.title == title)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,categoryName,categorySlug,year,title,count);

@override
String toString() {
  return 'TeachingEditionFacet(id: $id, categoryId: $categoryId, categoryName: $categoryName, categorySlug: $categorySlug, year: $year, title: $title, count: $count)';
}


}

/// @nodoc
abstract mixin class $TeachingEditionFacetCopyWith<$Res>  {
  factory $TeachingEditionFacetCopyWith(TeachingEditionFacet value, $Res Function(TeachingEditionFacet) _then) = _$TeachingEditionFacetCopyWithImpl;
@useResult
$Res call({
 int id, int categoryId, String categoryName, String categorySlug, int year, String title, int count
});




}
/// @nodoc
class _$TeachingEditionFacetCopyWithImpl<$Res>
    implements $TeachingEditionFacetCopyWith<$Res> {
  _$TeachingEditionFacetCopyWithImpl(this._self, this._then);

  final TeachingEditionFacet _self;
  final $Res Function(TeachingEditionFacet) _then;

/// Create a copy of TeachingEditionFacet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? categoryName = null,Object? categorySlug = null,Object? year = null,Object? title = null,Object? count = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categorySlug: null == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeachingEditionFacet].
extension TeachingEditionFacetPatterns on TeachingEditionFacet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeachingEditionFacet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeachingEditionFacet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeachingEditionFacet value)  $default,){
final _that = this;
switch (_that) {
case _TeachingEditionFacet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeachingEditionFacet value)?  $default,){
final _that = this;
switch (_that) {
case _TeachingEditionFacet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int categoryId,  String categoryName,  String categorySlug,  int year,  String title,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeachingEditionFacet() when $default != null:
return $default(_that.id,_that.categoryId,_that.categoryName,_that.categorySlug,_that.year,_that.title,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int categoryId,  String categoryName,  String categorySlug,  int year,  String title,  int count)  $default,) {final _that = this;
switch (_that) {
case _TeachingEditionFacet():
return $default(_that.id,_that.categoryId,_that.categoryName,_that.categorySlug,_that.year,_that.title,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int categoryId,  String categoryName,  String categorySlug,  int year,  String title,  int count)?  $default,) {final _that = this;
switch (_that) {
case _TeachingEditionFacet() when $default != null:
return $default(_that.id,_that.categoryId,_that.categoryName,_that.categorySlug,_that.year,_that.title,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeachingEditionFacet implements TeachingEditionFacet {
  const _TeachingEditionFacet({required this.id, this.categoryId = 0, this.categoryName = '', this.categorySlug = '', this.year = 0, this.title = '', this.count = 0});
  factory _TeachingEditionFacet.fromJson(Map<String, dynamic> json) => _$TeachingEditionFacetFromJson(json);

@override final  int id;
@override@JsonKey() final  int categoryId;
@override@JsonKey() final  String categoryName;
@override@JsonKey() final  String categorySlug;
@override@JsonKey() final  int year;
@override@JsonKey() final  String title;
@override@JsonKey() final  int count;

/// Create a copy of TeachingEditionFacet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeachingEditionFacetCopyWith<_TeachingEditionFacet> get copyWith => __$TeachingEditionFacetCopyWithImpl<_TeachingEditionFacet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeachingEditionFacetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeachingEditionFacet&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.year, year) || other.year == year)&&(identical(other.title, title) || other.title == title)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,categoryName,categorySlug,year,title,count);

@override
String toString() {
  return 'TeachingEditionFacet(id: $id, categoryId: $categoryId, categoryName: $categoryName, categorySlug: $categorySlug, year: $year, title: $title, count: $count)';
}


}

/// @nodoc
abstract mixin class _$TeachingEditionFacetCopyWith<$Res> implements $TeachingEditionFacetCopyWith<$Res> {
  factory _$TeachingEditionFacetCopyWith(_TeachingEditionFacet value, $Res Function(_TeachingEditionFacet) _then) = __$TeachingEditionFacetCopyWithImpl;
@override @useResult
$Res call({
 int id, int categoryId, String categoryName, String categorySlug, int year, String title, int count
});




}
/// @nodoc
class __$TeachingEditionFacetCopyWithImpl<$Res>
    implements _$TeachingEditionFacetCopyWith<$Res> {
  __$TeachingEditionFacetCopyWithImpl(this._self, this._then);

  final _TeachingEditionFacet _self;
  final $Res Function(_TeachingEditionFacet) _then;

/// Create a copy of TeachingEditionFacet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? categoryName = null,Object? categorySlug = null,Object? year = null,Object? title = null,Object? count = null,}) {
  return _then(_TeachingEditionFacet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categorySlug: null == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TeachingFacets {

 List<TeachingCategory> get categories; List<TeachingSpeakerFacet> get speakers; List<TeachingYearFacet> get years; List<TeachingEditionFacet> get editions; List<TeachingDayFacet> get days;
/// Create a copy of TeachingFacets
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeachingFacetsCopyWith<TeachingFacets> get copyWith => _$TeachingFacetsCopyWithImpl<TeachingFacets>(this as TeachingFacets, _$identity);

  /// Serializes this TeachingFacets to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeachingFacets&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.speakers, speakers)&&const DeepCollectionEquality().equals(other.years, years)&&const DeepCollectionEquality().equals(other.editions, editions)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(speakers),const DeepCollectionEquality().hash(years),const DeepCollectionEquality().hash(editions),const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'TeachingFacets(categories: $categories, speakers: $speakers, years: $years, editions: $editions, days: $days)';
}


}

/// @nodoc
abstract mixin class $TeachingFacetsCopyWith<$Res>  {
  factory $TeachingFacetsCopyWith(TeachingFacets value, $Res Function(TeachingFacets) _then) = _$TeachingFacetsCopyWithImpl;
@useResult
$Res call({
 List<TeachingCategory> categories, List<TeachingSpeakerFacet> speakers, List<TeachingYearFacet> years, List<TeachingEditionFacet> editions, List<TeachingDayFacet> days
});




}
/// @nodoc
class _$TeachingFacetsCopyWithImpl<$Res>
    implements $TeachingFacetsCopyWith<$Res> {
  _$TeachingFacetsCopyWithImpl(this._self, this._then);

  final TeachingFacets _self;
  final $Res Function(TeachingFacets) _then;

/// Create a copy of TeachingFacets
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? speakers = null,Object? years = null,Object? editions = null,Object? days = null,}) {
  return _then(_self.copyWith(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<TeachingCategory>,speakers: null == speakers ? _self.speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<TeachingSpeakerFacet>,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as List<TeachingYearFacet>,editions: null == editions ? _self.editions : editions // ignore: cast_nullable_to_non_nullable
as List<TeachingEditionFacet>,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<TeachingDayFacet>,
  ));
}

}


/// Adds pattern-matching-related methods to [TeachingFacets].
extension TeachingFacetsPatterns on TeachingFacets {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeachingFacets value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeachingFacets() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeachingFacets value)  $default,){
final _that = this;
switch (_that) {
case _TeachingFacets():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeachingFacets value)?  $default,){
final _that = this;
switch (_that) {
case _TeachingFacets() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TeachingCategory> categories,  List<TeachingSpeakerFacet> speakers,  List<TeachingYearFacet> years,  List<TeachingEditionFacet> editions,  List<TeachingDayFacet> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeachingFacets() when $default != null:
return $default(_that.categories,_that.speakers,_that.years,_that.editions,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TeachingCategory> categories,  List<TeachingSpeakerFacet> speakers,  List<TeachingYearFacet> years,  List<TeachingEditionFacet> editions,  List<TeachingDayFacet> days)  $default,) {final _that = this;
switch (_that) {
case _TeachingFacets():
return $default(_that.categories,_that.speakers,_that.years,_that.editions,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TeachingCategory> categories,  List<TeachingSpeakerFacet> speakers,  List<TeachingYearFacet> years,  List<TeachingEditionFacet> editions,  List<TeachingDayFacet> days)?  $default,) {final _that = this;
switch (_that) {
case _TeachingFacets() when $default != null:
return $default(_that.categories,_that.speakers,_that.years,_that.editions,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeachingFacets implements TeachingFacets {
  const _TeachingFacets({final  List<TeachingCategory> categories = const [], final  List<TeachingSpeakerFacet> speakers = const [], final  List<TeachingYearFacet> years = const [], final  List<TeachingEditionFacet> editions = const [], final  List<TeachingDayFacet> days = const []}): _categories = categories,_speakers = speakers,_years = years,_editions = editions,_days = days;
  factory _TeachingFacets.fromJson(Map<String, dynamic> json) => _$TeachingFacetsFromJson(json);

 final  List<TeachingCategory> _categories;
@override@JsonKey() List<TeachingCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<TeachingSpeakerFacet> _speakers;
@override@JsonKey() List<TeachingSpeakerFacet> get speakers {
  if (_speakers is EqualUnmodifiableListView) return _speakers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_speakers);
}

 final  List<TeachingYearFacet> _years;
@override@JsonKey() List<TeachingYearFacet> get years {
  if (_years is EqualUnmodifiableListView) return _years;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_years);
}

 final  List<TeachingEditionFacet> _editions;
@override@JsonKey() List<TeachingEditionFacet> get editions {
  if (_editions is EqualUnmodifiableListView) return _editions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_editions);
}

 final  List<TeachingDayFacet> _days;
@override@JsonKey() List<TeachingDayFacet> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of TeachingFacets
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeachingFacetsCopyWith<_TeachingFacets> get copyWith => __$TeachingFacetsCopyWithImpl<_TeachingFacets>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeachingFacetsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeachingFacets&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._speakers, _speakers)&&const DeepCollectionEquality().equals(other._years, _years)&&const DeepCollectionEquality().equals(other._editions, _editions)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_speakers),const DeepCollectionEquality().hash(_years),const DeepCollectionEquality().hash(_editions),const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'TeachingFacets(categories: $categories, speakers: $speakers, years: $years, editions: $editions, days: $days)';
}


}

/// @nodoc
abstract mixin class _$TeachingFacetsCopyWith<$Res> implements $TeachingFacetsCopyWith<$Res> {
  factory _$TeachingFacetsCopyWith(_TeachingFacets value, $Res Function(_TeachingFacets) _then) = __$TeachingFacetsCopyWithImpl;
@override @useResult
$Res call({
 List<TeachingCategory> categories, List<TeachingSpeakerFacet> speakers, List<TeachingYearFacet> years, List<TeachingEditionFacet> editions, List<TeachingDayFacet> days
});




}
/// @nodoc
class __$TeachingFacetsCopyWithImpl<$Res>
    implements _$TeachingFacetsCopyWith<$Res> {
  __$TeachingFacetsCopyWithImpl(this._self, this._then);

  final _TeachingFacets _self;
  final $Res Function(_TeachingFacets) _then;

/// Create a copy of TeachingFacets
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? speakers = null,Object? years = null,Object? editions = null,Object? days = null,}) {
  return _then(_TeachingFacets(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<TeachingCategory>,speakers: null == speakers ? _self._speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<TeachingSpeakerFacet>,years: null == years ? _self._years : years // ignore: cast_nullable_to_non_nullable
as List<TeachingYearFacet>,editions: null == editions ? _self._editions : editions // ignore: cast_nullable_to_non_nullable
as List<TeachingEditionFacet>,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<TeachingDayFacet>,
  ));
}


}

// dart format on
