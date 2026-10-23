// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hymn_reader_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HymnReaderSettings {

/// 1 = normal size. From [minScale] to [maxScale].
 double get textScale; HymnTypeface get typeface;/// The color of the book, like a song's lyrics on its cover.
 ReaderTheme get theme;/// Show the chorus again after each verse.
 bool get repeatChorus;/// Keep the screen on while a hymn is open.
 bool get keepScreenOn;
/// Create a copy of HymnReaderSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnReaderSettingsCopyWith<HymnReaderSettings> get copyWith => _$HymnReaderSettingsCopyWithImpl<HymnReaderSettings>(this as HymnReaderSettings, _$identity);

  /// Serializes this HymnReaderSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HymnReaderSettings&&(identical(other.textScale, textScale) || other.textScale == textScale)&&(identical(other.typeface, typeface) || other.typeface == typeface)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.repeatChorus, repeatChorus) || other.repeatChorus == repeatChorus)&&(identical(other.keepScreenOn, keepScreenOn) || other.keepScreenOn == keepScreenOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textScale,typeface,theme,repeatChorus,keepScreenOn);

@override
String toString() {
  return 'HymnReaderSettings(textScale: $textScale, typeface: $typeface, theme: $theme, repeatChorus: $repeatChorus, keepScreenOn: $keepScreenOn)';
}


}

/// @nodoc
abstract mixin class $HymnReaderSettingsCopyWith<$Res>  {
  factory $HymnReaderSettingsCopyWith(HymnReaderSettings value, $Res Function(HymnReaderSettings) _then) = _$HymnReaderSettingsCopyWithImpl;
@useResult
$Res call({
 double textScale, HymnTypeface typeface, ReaderTheme theme, bool repeatChorus, bool keepScreenOn
});




}
/// @nodoc
class _$HymnReaderSettingsCopyWithImpl<$Res>
    implements $HymnReaderSettingsCopyWith<$Res> {
  _$HymnReaderSettingsCopyWithImpl(this._self, this._then);

  final HymnReaderSettings _self;
  final $Res Function(HymnReaderSettings) _then;

/// Create a copy of HymnReaderSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textScale = null,Object? typeface = null,Object? theme = null,Object? repeatChorus = null,Object? keepScreenOn = null,}) {
  return _then(_self.copyWith(
textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,typeface: null == typeface ? _self.typeface : typeface // ignore: cast_nullable_to_non_nullable
as HymnTypeface,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ReaderTheme,repeatChorus: null == repeatChorus ? _self.repeatChorus : repeatChorus // ignore: cast_nullable_to_non_nullable
as bool,keepScreenOn: null == keepScreenOn ? _self.keepScreenOn : keepScreenOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HymnReaderSettings].
extension HymnReaderSettingsPatterns on HymnReaderSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HymnReaderSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HymnReaderSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HymnReaderSettings value)  $default,){
final _that = this;
switch (_that) {
case _HymnReaderSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HymnReaderSettings value)?  $default,){
final _that = this;
switch (_that) {
case _HymnReaderSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double textScale,  HymnTypeface typeface,  ReaderTheme theme,  bool repeatChorus,  bool keepScreenOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HymnReaderSettings() when $default != null:
return $default(_that.textScale,_that.typeface,_that.theme,_that.repeatChorus,_that.keepScreenOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double textScale,  HymnTypeface typeface,  ReaderTheme theme,  bool repeatChorus,  bool keepScreenOn)  $default,) {final _that = this;
switch (_that) {
case _HymnReaderSettings():
return $default(_that.textScale,_that.typeface,_that.theme,_that.repeatChorus,_that.keepScreenOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double textScale,  HymnTypeface typeface,  ReaderTheme theme,  bool repeatChorus,  bool keepScreenOn)?  $default,) {final _that = this;
switch (_that) {
case _HymnReaderSettings() when $default != null:
return $default(_that.textScale,_that.typeface,_that.theme,_that.repeatChorus,_that.keepScreenOn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HymnReaderSettings extends HymnReaderSettings {
  const _HymnReaderSettings({this.textScale = 1.0, this.typeface = HymnTypeface.auto, this.theme = ReaderTheme.book, this.repeatChorus = false, this.keepScreenOn = true}): super._();
  factory _HymnReaderSettings.fromJson(Map<String, dynamic> json) => _$HymnReaderSettingsFromJson(json);

/// 1 = normal size. From [minScale] to [maxScale].
@override@JsonKey() final  double textScale;
@override@JsonKey() final  HymnTypeface typeface;
/// The color of the book, like a song's lyrics on its cover.
@override@JsonKey() final  ReaderTheme theme;
/// Show the chorus again after each verse.
@override@JsonKey() final  bool repeatChorus;
/// Keep the screen on while a hymn is open.
@override@JsonKey() final  bool keepScreenOn;

/// Create a copy of HymnReaderSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnReaderSettingsCopyWith<_HymnReaderSettings> get copyWith => __$HymnReaderSettingsCopyWithImpl<_HymnReaderSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HymnReaderSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HymnReaderSettings&&(identical(other.textScale, textScale) || other.textScale == textScale)&&(identical(other.typeface, typeface) || other.typeface == typeface)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.repeatChorus, repeatChorus) || other.repeatChorus == repeatChorus)&&(identical(other.keepScreenOn, keepScreenOn) || other.keepScreenOn == keepScreenOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textScale,typeface,theme,repeatChorus,keepScreenOn);

@override
String toString() {
  return 'HymnReaderSettings(textScale: $textScale, typeface: $typeface, theme: $theme, repeatChorus: $repeatChorus, keepScreenOn: $keepScreenOn)';
}


}

/// @nodoc
abstract mixin class _$HymnReaderSettingsCopyWith<$Res> implements $HymnReaderSettingsCopyWith<$Res> {
  factory _$HymnReaderSettingsCopyWith(_HymnReaderSettings value, $Res Function(_HymnReaderSettings) _then) = __$HymnReaderSettingsCopyWithImpl;
@override @useResult
$Res call({
 double textScale, HymnTypeface typeface, ReaderTheme theme, bool repeatChorus, bool keepScreenOn
});




}
/// @nodoc
class __$HymnReaderSettingsCopyWithImpl<$Res>
    implements _$HymnReaderSettingsCopyWith<$Res> {
  __$HymnReaderSettingsCopyWithImpl(this._self, this._then);

  final _HymnReaderSettings _self;
  final $Res Function(_HymnReaderSettings) _then;

/// Create a copy of HymnReaderSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textScale = null,Object? typeface = null,Object? theme = null,Object? repeatChorus = null,Object? keepScreenOn = null,}) {
  return _then(_HymnReaderSettings(
textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,typeface: null == typeface ? _self.typeface : typeface // ignore: cast_nullable_to_non_nullable
as HymnTypeface,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ReaderTheme,repeatChorus: null == repeatChorus ? _self.repeatChorus : repeatChorus // ignore: cast_nullable_to_non_nullable
as bool,keepScreenOn: null == keepScreenOn ? _self.keepScreenOn : keepScreenOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
