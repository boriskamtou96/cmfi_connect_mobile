// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BibleSettings {

/// The version chosen (its id); null: the one of the app's language.
 String? get version;/// 1 = normal size. From [minScale] to [maxScale].
 double get textScale; ReaderTheme get theme;/// The classic font (Lora), else the app's.
 bool get serif;/// The words of Jesus in red, as in many printed Bibles.
 bool get jesusInRed;/// Keep the screen on while a chapter is open.
 bool get keepScreenOn;
/// Create a copy of BibleSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BibleSettingsCopyWith<BibleSettings> get copyWith => _$BibleSettingsCopyWithImpl<BibleSettings>(this as BibleSettings, _$identity);

  /// Serializes this BibleSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BibleSettings&&(identical(other.version, version) || other.version == version)&&(identical(other.textScale, textScale) || other.textScale == textScale)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.serif, serif) || other.serif == serif)&&(identical(other.jesusInRed, jesusInRed) || other.jesusInRed == jesusInRed)&&(identical(other.keepScreenOn, keepScreenOn) || other.keepScreenOn == keepScreenOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,textScale,theme,serif,jesusInRed,keepScreenOn);

@override
String toString() {
  return 'BibleSettings(version: $version, textScale: $textScale, theme: $theme, serif: $serif, jesusInRed: $jesusInRed, keepScreenOn: $keepScreenOn)';
}


}

/// @nodoc
abstract mixin class $BibleSettingsCopyWith<$Res>  {
  factory $BibleSettingsCopyWith(BibleSettings value, $Res Function(BibleSettings) _then) = _$BibleSettingsCopyWithImpl;
@useResult
$Res call({
 String? version, double textScale, ReaderTheme theme, bool serif, bool jesusInRed, bool keepScreenOn
});




}
/// @nodoc
class _$BibleSettingsCopyWithImpl<$Res>
    implements $BibleSettingsCopyWith<$Res> {
  _$BibleSettingsCopyWithImpl(this._self, this._then);

  final BibleSettings _self;
  final $Res Function(BibleSettings) _then;

/// Create a copy of BibleSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = freezed,Object? textScale = null,Object? theme = null,Object? serif = null,Object? jesusInRed = null,Object? keepScreenOn = null,}) {
  return _then(_self.copyWith(
version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ReaderTheme,serif: null == serif ? _self.serif : serif // ignore: cast_nullable_to_non_nullable
as bool,jesusInRed: null == jesusInRed ? _self.jesusInRed : jesusInRed // ignore: cast_nullable_to_non_nullable
as bool,keepScreenOn: null == keepScreenOn ? _self.keepScreenOn : keepScreenOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BibleSettings].
extension BibleSettingsPatterns on BibleSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BibleSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BibleSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BibleSettings value)  $default,){
final _that = this;
switch (_that) {
case _BibleSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BibleSettings value)?  $default,){
final _that = this;
switch (_that) {
case _BibleSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? version,  double textScale,  ReaderTheme theme,  bool serif,  bool jesusInRed,  bool keepScreenOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BibleSettings() when $default != null:
return $default(_that.version,_that.textScale,_that.theme,_that.serif,_that.jesusInRed,_that.keepScreenOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? version,  double textScale,  ReaderTheme theme,  bool serif,  bool jesusInRed,  bool keepScreenOn)  $default,) {final _that = this;
switch (_that) {
case _BibleSettings():
return $default(_that.version,_that.textScale,_that.theme,_that.serif,_that.jesusInRed,_that.keepScreenOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? version,  double textScale,  ReaderTheme theme,  bool serif,  bool jesusInRed,  bool keepScreenOn)?  $default,) {final _that = this;
switch (_that) {
case _BibleSettings() when $default != null:
return $default(_that.version,_that.textScale,_that.theme,_that.serif,_that.jesusInRed,_that.keepScreenOn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BibleSettings extends BibleSettings {
  const _BibleSettings({this.version, this.textScale = 1.0, this.theme = ReaderTheme.auto, this.serif = true, this.jesusInRed = true, this.keepScreenOn = true}): super._();
  factory _BibleSettings.fromJson(Map<String, dynamic> json) => _$BibleSettingsFromJson(json);

/// The version chosen (its id); null: the one of the app's language.
@override final  String? version;
/// 1 = normal size. From [minScale] to [maxScale].
@override@JsonKey() final  double textScale;
@override@JsonKey() final  ReaderTheme theme;
/// The classic font (Lora), else the app's.
@override@JsonKey() final  bool serif;
/// The words of Jesus in red, as in many printed Bibles.
@override@JsonKey() final  bool jesusInRed;
/// Keep the screen on while a chapter is open.
@override@JsonKey() final  bool keepScreenOn;

/// Create a copy of BibleSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BibleSettingsCopyWith<_BibleSettings> get copyWith => __$BibleSettingsCopyWithImpl<_BibleSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BibleSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BibleSettings&&(identical(other.version, version) || other.version == version)&&(identical(other.textScale, textScale) || other.textScale == textScale)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.serif, serif) || other.serif == serif)&&(identical(other.jesusInRed, jesusInRed) || other.jesusInRed == jesusInRed)&&(identical(other.keepScreenOn, keepScreenOn) || other.keepScreenOn == keepScreenOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,textScale,theme,serif,jesusInRed,keepScreenOn);

@override
String toString() {
  return 'BibleSettings(version: $version, textScale: $textScale, theme: $theme, serif: $serif, jesusInRed: $jesusInRed, keepScreenOn: $keepScreenOn)';
}


}

/// @nodoc
abstract mixin class _$BibleSettingsCopyWith<$Res> implements $BibleSettingsCopyWith<$Res> {
  factory _$BibleSettingsCopyWith(_BibleSettings value, $Res Function(_BibleSettings) _then) = __$BibleSettingsCopyWithImpl;
@override @useResult
$Res call({
 String? version, double textScale, ReaderTheme theme, bool serif, bool jesusInRed, bool keepScreenOn
});




}
/// @nodoc
class __$BibleSettingsCopyWithImpl<$Res>
    implements _$BibleSettingsCopyWith<$Res> {
  __$BibleSettingsCopyWithImpl(this._self, this._then);

  final _BibleSettings _self;
  final $Res Function(_BibleSettings) _then;

/// Create a copy of BibleSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = freezed,Object? textScale = null,Object? theme = null,Object? serif = null,Object? jesusInRed = null,Object? keepScreenOn = null,}) {
  return _then(_BibleSettings(
version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ReaderTheme,serif: null == serif ? _self.serif : serif // ignore: cast_nullable_to_non_nullable
as bool,jesusInRed: null == jesusInRed ? _self.jesusInRed : jesusInRed // ignore: cast_nullable_to_non_nullable
as bool,keepScreenOn: null == keepScreenOn ? _self.keepScreenOn : keepScreenOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
