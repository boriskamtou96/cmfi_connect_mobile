// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ministry_person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MinistryPerson {

 int get id;@JsonKey(unknownEnumValue: MinistryPersonKind.missionary) MinistryPersonKind get kind; String get name; EventImage? get photo;/// A missionary's nation ("TD"), '' when none.
 String get countryCode;/// What they do ("Implantation d'églises"), or did, for a hero.
 String get role;/// The year a missionary was sent.
 int? get sinceYear;/// A hero's life ("1920–1998").
 String get years;/// Plain text, paragraphs separated by a blank line.
 String get story; int get position;
/// Create a copy of MinistryPerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MinistryPersonCopyWith<MinistryPerson> get copyWith => _$MinistryPersonCopyWithImpl<MinistryPerson>(this as MinistryPerson, _$identity);

  /// Serializes this MinistryPerson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MinistryPerson&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.name, name) || other.name == name)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.role, role) || other.role == role)&&(identical(other.sinceYear, sinceYear) || other.sinceYear == sinceYear)&&(identical(other.years, years) || other.years == years)&&(identical(other.story, story) || other.story == story)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,name,photo,countryCode,role,sinceYear,years,story,position);

@override
String toString() {
  return 'MinistryPerson(id: $id, kind: $kind, name: $name, photo: $photo, countryCode: $countryCode, role: $role, sinceYear: $sinceYear, years: $years, story: $story, position: $position)';
}


}

/// @nodoc
abstract mixin class $MinistryPersonCopyWith<$Res>  {
  factory $MinistryPersonCopyWith(MinistryPerson value, $Res Function(MinistryPerson) _then) = _$MinistryPersonCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(unknownEnumValue: MinistryPersonKind.missionary) MinistryPersonKind kind, String name, EventImage? photo, String countryCode, String role, int? sinceYear, String years, String story, int position
});


$EventImageCopyWith<$Res>? get photo;

}
/// @nodoc
class _$MinistryPersonCopyWithImpl<$Res>
    implements $MinistryPersonCopyWith<$Res> {
  _$MinistryPersonCopyWithImpl(this._self, this._then);

  final MinistryPerson _self;
  final $Res Function(MinistryPerson) _then;

/// Create a copy of MinistryPerson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? name = null,Object? photo = freezed,Object? countryCode = null,Object? role = null,Object? sinceYear = freezed,Object? years = null,Object? story = null,Object? position = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MinistryPersonKind,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as EventImage?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,sinceYear: freezed == sinceYear ? _self.sinceYear : sinceYear // ignore: cast_nullable_to_non_nullable
as int?,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as String,story: null == story ? _self.story : story // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of MinistryPerson
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}
}


/// Adds pattern-matching-related methods to [MinistryPerson].
extension MinistryPersonPatterns on MinistryPerson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MinistryPerson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MinistryPerson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MinistryPerson value)  $default,){
final _that = this;
switch (_that) {
case _MinistryPerson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MinistryPerson value)?  $default,){
final _that = this;
switch (_that) {
case _MinistryPerson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(unknownEnumValue: MinistryPersonKind.missionary)  MinistryPersonKind kind,  String name,  EventImage? photo,  String countryCode,  String role,  int? sinceYear,  String years,  String story,  int position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MinistryPerson() when $default != null:
return $default(_that.id,_that.kind,_that.name,_that.photo,_that.countryCode,_that.role,_that.sinceYear,_that.years,_that.story,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(unknownEnumValue: MinistryPersonKind.missionary)  MinistryPersonKind kind,  String name,  EventImage? photo,  String countryCode,  String role,  int? sinceYear,  String years,  String story,  int position)  $default,) {final _that = this;
switch (_that) {
case _MinistryPerson():
return $default(_that.id,_that.kind,_that.name,_that.photo,_that.countryCode,_that.role,_that.sinceYear,_that.years,_that.story,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(unknownEnumValue: MinistryPersonKind.missionary)  MinistryPersonKind kind,  String name,  EventImage? photo,  String countryCode,  String role,  int? sinceYear,  String years,  String story,  int position)?  $default,) {final _that = this;
switch (_that) {
case _MinistryPerson() when $default != null:
return $default(_that.id,_that.kind,_that.name,_that.photo,_that.countryCode,_that.role,_that.sinceYear,_that.years,_that.story,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MinistryPerson extends MinistryPerson {
  const _MinistryPerson({required this.id, @JsonKey(unknownEnumValue: MinistryPersonKind.missionary) required this.kind, required this.name, this.photo, this.countryCode = '', this.role = '', this.sinceYear, this.years = '', this.story = '', this.position = 0}): super._();
  factory _MinistryPerson.fromJson(Map<String, dynamic> json) => _$MinistryPersonFromJson(json);

@override final  int id;
@override@JsonKey(unknownEnumValue: MinistryPersonKind.missionary) final  MinistryPersonKind kind;
@override final  String name;
@override final  EventImage? photo;
/// A missionary's nation ("TD"), '' when none.
@override@JsonKey() final  String countryCode;
/// What they do ("Implantation d'églises"), or did, for a hero.
@override@JsonKey() final  String role;
/// The year a missionary was sent.
@override final  int? sinceYear;
/// A hero's life ("1920–1998").
@override@JsonKey() final  String years;
/// Plain text, paragraphs separated by a blank line.
@override@JsonKey() final  String story;
@override@JsonKey() final  int position;

/// Create a copy of MinistryPerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MinistryPersonCopyWith<_MinistryPerson> get copyWith => __$MinistryPersonCopyWithImpl<_MinistryPerson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MinistryPersonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MinistryPerson&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.name, name) || other.name == name)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.role, role) || other.role == role)&&(identical(other.sinceYear, sinceYear) || other.sinceYear == sinceYear)&&(identical(other.years, years) || other.years == years)&&(identical(other.story, story) || other.story == story)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,name,photo,countryCode,role,sinceYear,years,story,position);

@override
String toString() {
  return 'MinistryPerson(id: $id, kind: $kind, name: $name, photo: $photo, countryCode: $countryCode, role: $role, sinceYear: $sinceYear, years: $years, story: $story, position: $position)';
}


}

/// @nodoc
abstract mixin class _$MinistryPersonCopyWith<$Res> implements $MinistryPersonCopyWith<$Res> {
  factory _$MinistryPersonCopyWith(_MinistryPerson value, $Res Function(_MinistryPerson) _then) = __$MinistryPersonCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(unknownEnumValue: MinistryPersonKind.missionary) MinistryPersonKind kind, String name, EventImage? photo, String countryCode, String role, int? sinceYear, String years, String story, int position
});


@override $EventImageCopyWith<$Res>? get photo;

}
/// @nodoc
class __$MinistryPersonCopyWithImpl<$Res>
    implements _$MinistryPersonCopyWith<$Res> {
  __$MinistryPersonCopyWithImpl(this._self, this._then);

  final _MinistryPerson _self;
  final $Res Function(_MinistryPerson) _then;

/// Create a copy of MinistryPerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? name = null,Object? photo = freezed,Object? countryCode = null,Object? role = null,Object? sinceYear = freezed,Object? years = null,Object? story = null,Object? position = null,}) {
  return _then(_MinistryPerson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MinistryPersonKind,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as EventImage?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,sinceYear: freezed == sinceYear ? _self.sinceYear : sinceYear // ignore: cast_nullable_to_non_nullable
as int?,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as String,story: null == story ? _self.story : story // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of MinistryPerson
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}
}

// dart format on
