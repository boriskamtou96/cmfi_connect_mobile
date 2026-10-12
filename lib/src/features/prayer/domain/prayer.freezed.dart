// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrayerDocument {

 String get url; String get name; int get sizeBytes;
/// Create a copy of PrayerDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerDocumentCopyWith<PrayerDocument> get copyWith => _$PrayerDocumentCopyWithImpl<PrayerDocument>(this as PrayerDocument, _$identity);

  /// Serializes this PrayerDocument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerDocument&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,sizeBytes);

@override
String toString() {
  return 'PrayerDocument(url: $url, name: $name, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $PrayerDocumentCopyWith<$Res>  {
  factory $PrayerDocumentCopyWith(PrayerDocument value, $Res Function(PrayerDocument) _then) = _$PrayerDocumentCopyWithImpl;
@useResult
$Res call({
 String url, String name, int sizeBytes
});




}
/// @nodoc
class _$PrayerDocumentCopyWithImpl<$Res>
    implements $PrayerDocumentCopyWith<$Res> {
  _$PrayerDocumentCopyWithImpl(this._self, this._then);

  final PrayerDocument _self;
  final $Res Function(PrayerDocument) _then;

/// Create a copy of PrayerDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? name = null,Object? sizeBytes = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerDocument].
extension PrayerDocumentPatterns on PrayerDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerDocument value)  $default,){
final _that = this;
switch (_that) {
case _PrayerDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerDocument value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String name,  int sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerDocument() when $default != null:
return $default(_that.url,_that.name,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String name,  int sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _PrayerDocument():
return $default(_that.url,_that.name,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String name,  int sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _PrayerDocument() when $default != null:
return $default(_that.url,_that.name,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrayerDocument implements PrayerDocument {
  const _PrayerDocument({required this.url, this.name = '', this.sizeBytes = 0});
  factory _PrayerDocument.fromJson(Map<String, dynamic> json) => _$PrayerDocumentFromJson(json);

@override final  String url;
@override@JsonKey() final  String name;
@override@JsonKey() final  int sizeBytes;

/// Create a copy of PrayerDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerDocumentCopyWith<_PrayerDocument> get copyWith => __$PrayerDocumentCopyWithImpl<_PrayerDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrayerDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerDocument&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,sizeBytes);

@override
String toString() {
  return 'PrayerDocument(url: $url, name: $name, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$PrayerDocumentCopyWith<$Res> implements $PrayerDocumentCopyWith<$Res> {
  factory _$PrayerDocumentCopyWith(_PrayerDocument value, $Res Function(_PrayerDocument) _then) = __$PrayerDocumentCopyWithImpl;
@override @useResult
$Res call({
 String url, String name, int sizeBytes
});




}
/// @nodoc
class __$PrayerDocumentCopyWithImpl<$Res>
    implements _$PrayerDocumentCopyWith<$Res> {
  __$PrayerDocumentCopyWithImpl(this._self, this._then);

  final _PrayerDocument _self;
  final $Res Function(_PrayerDocument) _then;

/// Create a copy of PrayerDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? name = null,Object? sizeBytes = null,}) {
  return _then(_PrayerDocument(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PrayerTopic {

 int get id; String get title;@JsonKey(unknownEnumValue: PrayerTopicCategory.other) PrayerTopicCategory get category; String get verse;@ApiDateConverter() DateTime get startsOn;/// null: no end.
@ApiDateConverter() DateTime? get endsOn; int? get eventId; PrayerDocument? get document; List<String> get points;/// How many members pray for it (never who).
 int get people;/// The points (1, 2…) the user prayed for today.
 List<int> get prayedToday;
/// Create a copy of PrayerTopic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerTopicCopyWith<PrayerTopic> get copyWith => _$PrayerTopicCopyWithImpl<PrayerTopic>(this as PrayerTopic, _$identity);

  /// Serializes this PrayerTopic to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerTopic&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.document, document) || other.document == document)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other.prayedToday, prayedToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,verse,startsOn,endsOn,eventId,document,const DeepCollectionEquality().hash(points),people,const DeepCollectionEquality().hash(prayedToday));

@override
String toString() {
  return 'PrayerTopic(id: $id, title: $title, category: $category, verse: $verse, startsOn: $startsOn, endsOn: $endsOn, eventId: $eventId, document: $document, points: $points, people: $people, prayedToday: $prayedToday)';
}


}

/// @nodoc
abstract mixin class $PrayerTopicCopyWith<$Res>  {
  factory $PrayerTopicCopyWith(PrayerTopic value, $Res Function(PrayerTopic) _then) = _$PrayerTopicCopyWithImpl;
@useResult
$Res call({
 int id, String title,@JsonKey(unknownEnumValue: PrayerTopicCategory.other) PrayerTopicCategory category, String verse,@ApiDateConverter() DateTime startsOn,@ApiDateConverter() DateTime? endsOn, int? eventId, PrayerDocument? document, List<String> points, int people, List<int> prayedToday
});


$PrayerDocumentCopyWith<$Res>? get document;

}
/// @nodoc
class _$PrayerTopicCopyWithImpl<$Res>
    implements $PrayerTopicCopyWith<$Res> {
  _$PrayerTopicCopyWithImpl(this._self, this._then);

  final PrayerTopic _self;
  final $Res Function(PrayerTopic) _then;

/// Create a copy of PrayerTopic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? category = null,Object? verse = null,Object? startsOn = null,Object? endsOn = freezed,Object? eventId = freezed,Object? document = freezed,Object? points = null,Object? people = null,Object? prayedToday = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PrayerTopicCategory,verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,document: freezed == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as PrayerDocument?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<String>,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,prayedToday: null == prayedToday ? _self.prayedToday : prayedToday // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}
/// Create a copy of PrayerTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrayerDocumentCopyWith<$Res>? get document {
    if (_self.document == null) {
    return null;
  }

  return $PrayerDocumentCopyWith<$Res>(_self.document!, (value) {
    return _then(_self.copyWith(document: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrayerTopic].
extension PrayerTopicPatterns on PrayerTopic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerTopic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerTopic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerTopic value)  $default,){
final _that = this;
switch (_that) {
case _PrayerTopic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerTopic value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerTopic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title, @JsonKey(unknownEnumValue: PrayerTopicCategory.other)  PrayerTopicCategory category,  String verse, @ApiDateConverter()  DateTime startsOn, @ApiDateConverter()  DateTime? endsOn,  int? eventId,  PrayerDocument? document,  List<String> points,  int people,  List<int> prayedToday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerTopic() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.verse,_that.startsOn,_that.endsOn,_that.eventId,_that.document,_that.points,_that.people,_that.prayedToday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title, @JsonKey(unknownEnumValue: PrayerTopicCategory.other)  PrayerTopicCategory category,  String verse, @ApiDateConverter()  DateTime startsOn, @ApiDateConverter()  DateTime? endsOn,  int? eventId,  PrayerDocument? document,  List<String> points,  int people,  List<int> prayedToday)  $default,) {final _that = this;
switch (_that) {
case _PrayerTopic():
return $default(_that.id,_that.title,_that.category,_that.verse,_that.startsOn,_that.endsOn,_that.eventId,_that.document,_that.points,_that.people,_that.prayedToday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title, @JsonKey(unknownEnumValue: PrayerTopicCategory.other)  PrayerTopicCategory category,  String verse, @ApiDateConverter()  DateTime startsOn, @ApiDateConverter()  DateTime? endsOn,  int? eventId,  PrayerDocument? document,  List<String> points,  int people,  List<int> prayedToday)?  $default,) {final _that = this;
switch (_that) {
case _PrayerTopic() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.verse,_that.startsOn,_that.endsOn,_that.eventId,_that.document,_that.points,_that.people,_that.prayedToday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrayerTopic extends PrayerTopic {
  const _PrayerTopic({required this.id, required this.title, @JsonKey(unknownEnumValue: PrayerTopicCategory.other) this.category = PrayerTopicCategory.church, this.verse = '', @ApiDateConverter() required this.startsOn, @ApiDateConverter() this.endsOn, this.eventId, this.document, final  List<String> points = const <String>[], this.people = 0, final  List<int> prayedToday = const <int>[]}): _points = points,_prayedToday = prayedToday,super._();
  factory _PrayerTopic.fromJson(Map<String, dynamic> json) => _$PrayerTopicFromJson(json);

@override final  int id;
@override final  String title;
@override@JsonKey(unknownEnumValue: PrayerTopicCategory.other) final  PrayerTopicCategory category;
@override@JsonKey() final  String verse;
@override@ApiDateConverter() final  DateTime startsOn;
/// null: no end.
@override@ApiDateConverter() final  DateTime? endsOn;
@override final  int? eventId;
@override final  PrayerDocument? document;
 final  List<String> _points;
@override@JsonKey() List<String> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

/// How many members pray for it (never who).
@override@JsonKey() final  int people;
/// The points (1, 2…) the user prayed for today.
 final  List<int> _prayedToday;
/// The points (1, 2…) the user prayed for today.
@override@JsonKey() List<int> get prayedToday {
  if (_prayedToday is EqualUnmodifiableListView) return _prayedToday;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prayedToday);
}


/// Create a copy of PrayerTopic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerTopicCopyWith<_PrayerTopic> get copyWith => __$PrayerTopicCopyWithImpl<_PrayerTopic>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrayerTopicToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerTopic&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.document, document) || other.document == document)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other._prayedToday, _prayedToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,verse,startsOn,endsOn,eventId,document,const DeepCollectionEquality().hash(_points),people,const DeepCollectionEquality().hash(_prayedToday));

@override
String toString() {
  return 'PrayerTopic(id: $id, title: $title, category: $category, verse: $verse, startsOn: $startsOn, endsOn: $endsOn, eventId: $eventId, document: $document, points: $points, people: $people, prayedToday: $prayedToday)';
}


}

/// @nodoc
abstract mixin class _$PrayerTopicCopyWith<$Res> implements $PrayerTopicCopyWith<$Res> {
  factory _$PrayerTopicCopyWith(_PrayerTopic value, $Res Function(_PrayerTopic) _then) = __$PrayerTopicCopyWithImpl;
@override @useResult
$Res call({
 int id, String title,@JsonKey(unknownEnumValue: PrayerTopicCategory.other) PrayerTopicCategory category, String verse,@ApiDateConverter() DateTime startsOn,@ApiDateConverter() DateTime? endsOn, int? eventId, PrayerDocument? document, List<String> points, int people, List<int> prayedToday
});


@override $PrayerDocumentCopyWith<$Res>? get document;

}
/// @nodoc
class __$PrayerTopicCopyWithImpl<$Res>
    implements _$PrayerTopicCopyWith<$Res> {
  __$PrayerTopicCopyWithImpl(this._self, this._then);

  final _PrayerTopic _self;
  final $Res Function(_PrayerTopic) _then;

/// Create a copy of PrayerTopic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? category = null,Object? verse = null,Object? startsOn = null,Object? endsOn = freezed,Object? eventId = freezed,Object? document = freezed,Object? points = null,Object? people = null,Object? prayedToday = null,}) {
  return _then(_PrayerTopic(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PrayerTopicCategory,verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,document: freezed == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as PrayerDocument?,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<String>,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,prayedToday: null == prayedToday ? _self._prayedToday : prayedToday // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of PrayerTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrayerDocumentCopyWith<$Res>? get document {
    if (_self.document == null) {
    return null;
  }

  return $PrayerDocumentCopyWith<$Res>(_self.document!, (value) {
    return _then(_self.copyWith(document: value));
  });
}
}


/// @nodoc
mixin _$PrayerPerson {

 int get id; PrayerList get list; String get name; String get note;/// The last day a retreat prayed for them: the others come first.
@ApiDateConverter() DateTime? get lastPrayedOn;/// Believed in the Lord, came back, or the prayer was answered.
@ApiDateConverter() DateTime? get answeredOn;
/// Create a copy of PrayerPerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerPersonCopyWith<PrayerPerson> get copyWith => _$PrayerPersonCopyWithImpl<PrayerPerson>(this as PrayerPerson, _$identity);

  /// Serializes this PrayerPerson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerPerson&&(identical(other.id, id) || other.id == id)&&(identical(other.list, list) || other.list == list)&&(identical(other.name, name) || other.name == name)&&(identical(other.note, note) || other.note == note)&&(identical(other.lastPrayedOn, lastPrayedOn) || other.lastPrayedOn == lastPrayedOn)&&(identical(other.answeredOn, answeredOn) || other.answeredOn == answeredOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,list,name,note,lastPrayedOn,answeredOn);

@override
String toString() {
  return 'PrayerPerson(id: $id, list: $list, name: $name, note: $note, lastPrayedOn: $lastPrayedOn, answeredOn: $answeredOn)';
}


}

/// @nodoc
abstract mixin class $PrayerPersonCopyWith<$Res>  {
  factory $PrayerPersonCopyWith(PrayerPerson value, $Res Function(PrayerPerson) _then) = _$PrayerPersonCopyWithImpl;
@useResult
$Res call({
 int id, PrayerList list, String name, String note,@ApiDateConverter() DateTime? lastPrayedOn,@ApiDateConverter() DateTime? answeredOn
});




}
/// @nodoc
class _$PrayerPersonCopyWithImpl<$Res>
    implements $PrayerPersonCopyWith<$Res> {
  _$PrayerPersonCopyWithImpl(this._self, this._then);

  final PrayerPerson _self;
  final $Res Function(PrayerPerson) _then;

/// Create a copy of PrayerPerson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? list = null,Object? name = null,Object? note = null,Object? lastPrayedOn = freezed,Object? answeredOn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as PrayerList,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,lastPrayedOn: freezed == lastPrayedOn ? _self.lastPrayedOn : lastPrayedOn // ignore: cast_nullable_to_non_nullable
as DateTime?,answeredOn: freezed == answeredOn ? _self.answeredOn : answeredOn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerPerson].
extension PrayerPersonPatterns on PrayerPerson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerPerson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerPerson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerPerson value)  $default,){
final _that = this;
switch (_that) {
case _PrayerPerson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerPerson value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerPerson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  PrayerList list,  String name,  String note, @ApiDateConverter()  DateTime? lastPrayedOn, @ApiDateConverter()  DateTime? answeredOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerPerson() when $default != null:
return $default(_that.id,_that.list,_that.name,_that.note,_that.lastPrayedOn,_that.answeredOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  PrayerList list,  String name,  String note, @ApiDateConverter()  DateTime? lastPrayedOn, @ApiDateConverter()  DateTime? answeredOn)  $default,) {final _that = this;
switch (_that) {
case _PrayerPerson():
return $default(_that.id,_that.list,_that.name,_that.note,_that.lastPrayedOn,_that.answeredOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  PrayerList list,  String name,  String note, @ApiDateConverter()  DateTime? lastPrayedOn, @ApiDateConverter()  DateTime? answeredOn)?  $default,) {final _that = this;
switch (_that) {
case _PrayerPerson() when $default != null:
return $default(_that.id,_that.list,_that.name,_that.note,_that.lastPrayedOn,_that.answeredOn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrayerPerson extends PrayerPerson {
  const _PrayerPerson({required this.id, required this.list, required this.name, this.note = '', @ApiDateConverter() this.lastPrayedOn, @ApiDateConverter() this.answeredOn}): super._();
  factory _PrayerPerson.fromJson(Map<String, dynamic> json) => _$PrayerPersonFromJson(json);

@override final  int id;
@override final  PrayerList list;
@override final  String name;
@override@JsonKey() final  String note;
/// The last day a retreat prayed for them: the others come first.
@override@ApiDateConverter() final  DateTime? lastPrayedOn;
/// Believed in the Lord, came back, or the prayer was answered.
@override@ApiDateConverter() final  DateTime? answeredOn;

/// Create a copy of PrayerPerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerPersonCopyWith<_PrayerPerson> get copyWith => __$PrayerPersonCopyWithImpl<_PrayerPerson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrayerPersonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerPerson&&(identical(other.id, id) || other.id == id)&&(identical(other.list, list) || other.list == list)&&(identical(other.name, name) || other.name == name)&&(identical(other.note, note) || other.note == note)&&(identical(other.lastPrayedOn, lastPrayedOn) || other.lastPrayedOn == lastPrayedOn)&&(identical(other.answeredOn, answeredOn) || other.answeredOn == answeredOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,list,name,note,lastPrayedOn,answeredOn);

@override
String toString() {
  return 'PrayerPerson(id: $id, list: $list, name: $name, note: $note, lastPrayedOn: $lastPrayedOn, answeredOn: $answeredOn)';
}


}

/// @nodoc
abstract mixin class _$PrayerPersonCopyWith<$Res> implements $PrayerPersonCopyWith<$Res> {
  factory _$PrayerPersonCopyWith(_PrayerPerson value, $Res Function(_PrayerPerson) _then) = __$PrayerPersonCopyWithImpl;
@override @useResult
$Res call({
 int id, PrayerList list, String name, String note,@ApiDateConverter() DateTime? lastPrayedOn,@ApiDateConverter() DateTime? answeredOn
});




}
/// @nodoc
class __$PrayerPersonCopyWithImpl<$Res>
    implements _$PrayerPersonCopyWith<$Res> {
  __$PrayerPersonCopyWithImpl(this._self, this._then);

  final _PrayerPerson _self;
  final $Res Function(_PrayerPerson) _then;

/// Create a copy of PrayerPerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? list = null,Object? name = null,Object? note = null,Object? lastPrayedOn = freezed,Object? answeredOn = freezed,}) {
  return _then(_PrayerPerson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as PrayerList,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,lastPrayedOn: freezed == lastPrayedOn ? _self.lastPrayedOn : lastPrayedOn // ignore: cast_nullable_to_non_nullable
as DateTime?,answeredOn: freezed == answeredOn ? _self.answeredOn : answeredOn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$RetreatRecord {

@ApiDateConverter() DateTime get day; RetreatMoment get moment; int get minutes;
/// Create a copy of RetreatRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetreatRecordCopyWith<RetreatRecord> get copyWith => _$RetreatRecordCopyWithImpl<RetreatRecord>(this as RetreatRecord, _$identity);

  /// Serializes this RetreatRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetreatRecord&&(identical(other.day, day) || other.day == day)&&(identical(other.moment, moment) || other.moment == moment)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,moment,minutes);

@override
String toString() {
  return 'RetreatRecord(day: $day, moment: $moment, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class $RetreatRecordCopyWith<$Res>  {
  factory $RetreatRecordCopyWith(RetreatRecord value, $Res Function(RetreatRecord) _then) = _$RetreatRecordCopyWithImpl;
@useResult
$Res call({
@ApiDateConverter() DateTime day, RetreatMoment moment, int minutes
});




}
/// @nodoc
class _$RetreatRecordCopyWithImpl<$Res>
    implements $RetreatRecordCopyWith<$Res> {
  _$RetreatRecordCopyWithImpl(this._self, this._then);

  final RetreatRecord _self;
  final $Res Function(RetreatRecord) _then;

/// Create a copy of RetreatRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? moment = null,Object? minutes = null,}) {
  return _then(_self.copyWith(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as RetreatMoment,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RetreatRecord].
extension RetreatRecordPatterns on RetreatRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RetreatRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RetreatRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RetreatRecord value)  $default,){
final _that = this;
switch (_that) {
case _RetreatRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RetreatRecord value)?  $default,){
final _that = this;
switch (_that) {
case _RetreatRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ApiDateConverter()  DateTime day,  RetreatMoment moment,  int minutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RetreatRecord() when $default != null:
return $default(_that.day,_that.moment,_that.minutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ApiDateConverter()  DateTime day,  RetreatMoment moment,  int minutes)  $default,) {final _that = this;
switch (_that) {
case _RetreatRecord():
return $default(_that.day,_that.moment,_that.minutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ApiDateConverter()  DateTime day,  RetreatMoment moment,  int minutes)?  $default,) {final _that = this;
switch (_that) {
case _RetreatRecord() when $default != null:
return $default(_that.day,_that.moment,_that.minutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RetreatRecord implements RetreatRecord {
  const _RetreatRecord({@ApiDateConverter() required this.day, required this.moment, this.minutes = 15});
  factory _RetreatRecord.fromJson(Map<String, dynamic> json) => _$RetreatRecordFromJson(json);

@override@ApiDateConverter() final  DateTime day;
@override final  RetreatMoment moment;
@override@JsonKey() final  int minutes;

/// Create a copy of RetreatRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetreatRecordCopyWith<_RetreatRecord> get copyWith => __$RetreatRecordCopyWithImpl<_RetreatRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RetreatRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetreatRecord&&(identical(other.day, day) || other.day == day)&&(identical(other.moment, moment) || other.moment == moment)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,moment,minutes);

@override
String toString() {
  return 'RetreatRecord(day: $day, moment: $moment, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class _$RetreatRecordCopyWith<$Res> implements $RetreatRecordCopyWith<$Res> {
  factory _$RetreatRecordCopyWith(_RetreatRecord value, $Res Function(_RetreatRecord) _then) = __$RetreatRecordCopyWithImpl;
@override @useResult
$Res call({
@ApiDateConverter() DateTime day, RetreatMoment moment, int minutes
});




}
/// @nodoc
class __$RetreatRecordCopyWithImpl<$Res>
    implements _$RetreatRecordCopyWith<$Res> {
  __$RetreatRecordCopyWithImpl(this._self, this._then);

  final _RetreatRecord _self;
  final $Res Function(_RetreatRecord) _then;

/// Create a copy of RetreatRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? moment = null,Object? minutes = null,}) {
  return _then(_RetreatRecord(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as RetreatMoment,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Importunity {

 int get id; String get title; String get description;/// null: the proclamations are only counted.
 int? get goal; int get total; DateTime? get reachedAt;@JsonKey(unknownEnumValue: ImportunityStatus.open) ImportunityStatus get status; MemberCard get owner; bool get isOwner;@JsonKey(unknownEnumValue: ImportunityMemberStatus.joined) ImportunityMemberStatus get myStatus; int get myCount; MemberCard? get invitedBy;/// How many joined, and how many invitations wait for an answer.
 int get participants; int get invited;/// Who prays (names only), in the detail.
 List<MemberCard> get members;
/// Create a copy of Importunity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportunityCopyWith<Importunity> get copyWith => _$ImportunityCopyWithImpl<Importunity>(this as Importunity, _$identity);

  /// Serializes this Importunity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Importunity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.total, total) || other.total == total)&&(identical(other.reachedAt, reachedAt) || other.reachedAt == reachedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner)&&(identical(other.myStatus, myStatus) || other.myStatus == myStatus)&&(identical(other.myCount, myCount) || other.myCount == myCount)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.participants, participants) || other.participants == participants)&&(identical(other.invited, invited) || other.invited == invited)&&const DeepCollectionEquality().equals(other.members, members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,goal,total,reachedAt,status,owner,isOwner,myStatus,myCount,invitedBy,participants,invited,const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'Importunity(id: $id, title: $title, description: $description, goal: $goal, total: $total, reachedAt: $reachedAt, status: $status, owner: $owner, isOwner: $isOwner, myStatus: $myStatus, myCount: $myCount, invitedBy: $invitedBy, participants: $participants, invited: $invited, members: $members)';
}


}

/// @nodoc
abstract mixin class $ImportunityCopyWith<$Res>  {
  factory $ImportunityCopyWith(Importunity value, $Res Function(Importunity) _then) = _$ImportunityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, int? goal, int total, DateTime? reachedAt,@JsonKey(unknownEnumValue: ImportunityStatus.open) ImportunityStatus status, MemberCard owner, bool isOwner,@JsonKey(unknownEnumValue: ImportunityMemberStatus.joined) ImportunityMemberStatus myStatus, int myCount, MemberCard? invitedBy, int participants, int invited, List<MemberCard> members
});


$MemberCardCopyWith<$Res> get owner;$MemberCardCopyWith<$Res>? get invitedBy;

}
/// @nodoc
class _$ImportunityCopyWithImpl<$Res>
    implements $ImportunityCopyWith<$Res> {
  _$ImportunityCopyWithImpl(this._self, this._then);

  final Importunity _self;
  final $Res Function(Importunity) _then;

/// Create a copy of Importunity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? goal = freezed,Object? total = null,Object? reachedAt = freezed,Object? status = null,Object? owner = null,Object? isOwner = null,Object? myStatus = null,Object? myCount = null,Object? invitedBy = freezed,Object? participants = null,Object? invited = null,Object? members = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,goal: freezed == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as int?,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,reachedAt: freezed == reachedAt ? _self.reachedAt : reachedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ImportunityStatus,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as MemberCard,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,myStatus: null == myStatus ? _self.myStatus : myStatus // ignore: cast_nullable_to_non_nullable
as ImportunityMemberStatus,myCount: null == myCount ? _self.myCount : myCount // ignore: cast_nullable_to_non_nullable
as int,invitedBy: freezed == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as MemberCard?,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as int,invited: null == invited ? _self.invited : invited // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberCard>,
  ));
}
/// Create a copy of Importunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get owner {
  
  return $MemberCardCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of Importunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res>? get invitedBy {
    if (_self.invitedBy == null) {
    return null;
  }

  return $MemberCardCopyWith<$Res>(_self.invitedBy!, (value) {
    return _then(_self.copyWith(invitedBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [Importunity].
extension ImportunityPatterns on Importunity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Importunity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Importunity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Importunity value)  $default,){
final _that = this;
switch (_that) {
case _Importunity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Importunity value)?  $default,){
final _that = this;
switch (_that) {
case _Importunity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  int? goal,  int total,  DateTime? reachedAt, @JsonKey(unknownEnumValue: ImportunityStatus.open)  ImportunityStatus status,  MemberCard owner,  bool isOwner, @JsonKey(unknownEnumValue: ImportunityMemberStatus.joined)  ImportunityMemberStatus myStatus,  int myCount,  MemberCard? invitedBy,  int participants,  int invited,  List<MemberCard> members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Importunity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.goal,_that.total,_that.reachedAt,_that.status,_that.owner,_that.isOwner,_that.myStatus,_that.myCount,_that.invitedBy,_that.participants,_that.invited,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  int? goal,  int total,  DateTime? reachedAt, @JsonKey(unknownEnumValue: ImportunityStatus.open)  ImportunityStatus status,  MemberCard owner,  bool isOwner, @JsonKey(unknownEnumValue: ImportunityMemberStatus.joined)  ImportunityMemberStatus myStatus,  int myCount,  MemberCard? invitedBy,  int participants,  int invited,  List<MemberCard> members)  $default,) {final _that = this;
switch (_that) {
case _Importunity():
return $default(_that.id,_that.title,_that.description,_that.goal,_that.total,_that.reachedAt,_that.status,_that.owner,_that.isOwner,_that.myStatus,_that.myCount,_that.invitedBy,_that.participants,_that.invited,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  int? goal,  int total,  DateTime? reachedAt, @JsonKey(unknownEnumValue: ImportunityStatus.open)  ImportunityStatus status,  MemberCard owner,  bool isOwner, @JsonKey(unknownEnumValue: ImportunityMemberStatus.joined)  ImportunityMemberStatus myStatus,  int myCount,  MemberCard? invitedBy,  int participants,  int invited,  List<MemberCard> members)?  $default,) {final _that = this;
switch (_that) {
case _Importunity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.goal,_that.total,_that.reachedAt,_that.status,_that.owner,_that.isOwner,_that.myStatus,_that.myCount,_that.invitedBy,_that.participants,_that.invited,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Importunity extends Importunity {
  const _Importunity({required this.id, required this.title, this.description = '', this.goal, this.total = 0, this.reachedAt, @JsonKey(unknownEnumValue: ImportunityStatus.open) this.status = ImportunityStatus.open, required this.owner, this.isOwner = false, @JsonKey(unknownEnumValue: ImportunityMemberStatus.joined) this.myStatus = ImportunityMemberStatus.joined, this.myCount = 0, this.invitedBy, this.participants = 0, this.invited = 0, final  List<MemberCard> members = const <MemberCard>[]}): _members = members,super._();
  factory _Importunity.fromJson(Map<String, dynamic> json) => _$ImportunityFromJson(json);

@override final  int id;
@override final  String title;
@override@JsonKey() final  String description;
/// null: the proclamations are only counted.
@override final  int? goal;
@override@JsonKey() final  int total;
@override final  DateTime? reachedAt;
@override@JsonKey(unknownEnumValue: ImportunityStatus.open) final  ImportunityStatus status;
@override final  MemberCard owner;
@override@JsonKey() final  bool isOwner;
@override@JsonKey(unknownEnumValue: ImportunityMemberStatus.joined) final  ImportunityMemberStatus myStatus;
@override@JsonKey() final  int myCount;
@override final  MemberCard? invitedBy;
/// How many joined, and how many invitations wait for an answer.
@override@JsonKey() final  int participants;
@override@JsonKey() final  int invited;
/// Who prays (names only), in the detail.
 final  List<MemberCard> _members;
/// Who prays (names only), in the detail.
@override@JsonKey() List<MemberCard> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of Importunity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportunityCopyWith<_Importunity> get copyWith => __$ImportunityCopyWithImpl<_Importunity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImportunityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Importunity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.total, total) || other.total == total)&&(identical(other.reachedAt, reachedAt) || other.reachedAt == reachedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner)&&(identical(other.myStatus, myStatus) || other.myStatus == myStatus)&&(identical(other.myCount, myCount) || other.myCount == myCount)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.participants, participants) || other.participants == participants)&&(identical(other.invited, invited) || other.invited == invited)&&const DeepCollectionEquality().equals(other._members, _members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,goal,total,reachedAt,status,owner,isOwner,myStatus,myCount,invitedBy,participants,invited,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'Importunity(id: $id, title: $title, description: $description, goal: $goal, total: $total, reachedAt: $reachedAt, status: $status, owner: $owner, isOwner: $isOwner, myStatus: $myStatus, myCount: $myCount, invitedBy: $invitedBy, participants: $participants, invited: $invited, members: $members)';
}


}

/// @nodoc
abstract mixin class _$ImportunityCopyWith<$Res> implements $ImportunityCopyWith<$Res> {
  factory _$ImportunityCopyWith(_Importunity value, $Res Function(_Importunity) _then) = __$ImportunityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, int? goal, int total, DateTime? reachedAt,@JsonKey(unknownEnumValue: ImportunityStatus.open) ImportunityStatus status, MemberCard owner, bool isOwner,@JsonKey(unknownEnumValue: ImportunityMemberStatus.joined) ImportunityMemberStatus myStatus, int myCount, MemberCard? invitedBy, int participants, int invited, List<MemberCard> members
});


@override $MemberCardCopyWith<$Res> get owner;@override $MemberCardCopyWith<$Res>? get invitedBy;

}
/// @nodoc
class __$ImportunityCopyWithImpl<$Res>
    implements _$ImportunityCopyWith<$Res> {
  __$ImportunityCopyWithImpl(this._self, this._then);

  final _Importunity _self;
  final $Res Function(_Importunity) _then;

/// Create a copy of Importunity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? goal = freezed,Object? total = null,Object? reachedAt = freezed,Object? status = null,Object? owner = null,Object? isOwner = null,Object? myStatus = null,Object? myCount = null,Object? invitedBy = freezed,Object? participants = null,Object? invited = null,Object? members = null,}) {
  return _then(_Importunity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,goal: freezed == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as int?,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,reachedAt: freezed == reachedAt ? _self.reachedAt : reachedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ImportunityStatus,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as MemberCard,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,myStatus: null == myStatus ? _self.myStatus : myStatus // ignore: cast_nullable_to_non_nullable
as ImportunityMemberStatus,myCount: null == myCount ? _self.myCount : myCount // ignore: cast_nullable_to_non_nullable
as int,invitedBy: freezed == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as MemberCard?,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as int,invited: null == invited ? _self.invited : invited // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberCard>,
  ));
}

/// Create a copy of Importunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res> get owner {
  
  return $MemberCardCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}/// Create a copy of Importunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res>? get invitedBy {
    if (_self.invitedBy == null) {
    return null;
  }

  return $MemberCardCopyWith<$Res>(_self.invitedBy!, (value) {
    return _then(_self.copyWith(invitedBy: value));
  });
}
}


/// @nodoc
mixin _$PrayerFamily {

/// null: no disciple maker linked in the app.
 MemberCard? get discipleMaker; int get members;
/// Create a copy of PrayerFamily
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerFamilyCopyWith<PrayerFamily> get copyWith => _$PrayerFamilyCopyWithImpl<PrayerFamily>(this as PrayerFamily, _$identity);

  /// Serializes this PrayerFamily to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerFamily&&(identical(other.discipleMaker, discipleMaker) || other.discipleMaker == discipleMaker)&&(identical(other.members, members) || other.members == members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,discipleMaker,members);

@override
String toString() {
  return 'PrayerFamily(discipleMaker: $discipleMaker, members: $members)';
}


}

/// @nodoc
abstract mixin class $PrayerFamilyCopyWith<$Res>  {
  factory $PrayerFamilyCopyWith(PrayerFamily value, $Res Function(PrayerFamily) _then) = _$PrayerFamilyCopyWithImpl;
@useResult
$Res call({
 MemberCard? discipleMaker, int members
});


$MemberCardCopyWith<$Res>? get discipleMaker;

}
/// @nodoc
class _$PrayerFamilyCopyWithImpl<$Res>
    implements $PrayerFamilyCopyWith<$Res> {
  _$PrayerFamilyCopyWithImpl(this._self, this._then);

  final PrayerFamily _self;
  final $Res Function(PrayerFamily) _then;

/// Create a copy of PrayerFamily
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? discipleMaker = freezed,Object? members = null,}) {
  return _then(_self.copyWith(
discipleMaker: freezed == discipleMaker ? _self.discipleMaker : discipleMaker // ignore: cast_nullable_to_non_nullable
as MemberCard?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PrayerFamily
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res>? get discipleMaker {
    if (_self.discipleMaker == null) {
    return null;
  }

  return $MemberCardCopyWith<$Res>(_self.discipleMaker!, (value) {
    return _then(_self.copyWith(discipleMaker: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrayerFamily].
extension PrayerFamilyPatterns on PrayerFamily {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerFamily value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerFamily() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerFamily value)  $default,){
final _that = this;
switch (_that) {
case _PrayerFamily():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerFamily value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerFamily() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MemberCard? discipleMaker,  int members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerFamily() when $default != null:
return $default(_that.discipleMaker,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MemberCard? discipleMaker,  int members)  $default,) {final _that = this;
switch (_that) {
case _PrayerFamily():
return $default(_that.discipleMaker,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MemberCard? discipleMaker,  int members)?  $default,) {final _that = this;
switch (_that) {
case _PrayerFamily() when $default != null:
return $default(_that.discipleMaker,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrayerFamily implements PrayerFamily {
  const _PrayerFamily({this.discipleMaker, this.members = 0});
  factory _PrayerFamily.fromJson(Map<String, dynamic> json) => _$PrayerFamilyFromJson(json);

/// null: no disciple maker linked in the app.
@override final  MemberCard? discipleMaker;
@override@JsonKey() final  int members;

/// Create a copy of PrayerFamily
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerFamilyCopyWith<_PrayerFamily> get copyWith => __$PrayerFamilyCopyWithImpl<_PrayerFamily>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrayerFamilyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerFamily&&(identical(other.discipleMaker, discipleMaker) || other.discipleMaker == discipleMaker)&&(identical(other.members, members) || other.members == members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,discipleMaker,members);

@override
String toString() {
  return 'PrayerFamily(discipleMaker: $discipleMaker, members: $members)';
}


}

/// @nodoc
abstract mixin class _$PrayerFamilyCopyWith<$Res> implements $PrayerFamilyCopyWith<$Res> {
  factory _$PrayerFamilyCopyWith(_PrayerFamily value, $Res Function(_PrayerFamily) _then) = __$PrayerFamilyCopyWithImpl;
@override @useResult
$Res call({
 MemberCard? discipleMaker, int members
});


@override $MemberCardCopyWith<$Res>? get discipleMaker;

}
/// @nodoc
class __$PrayerFamilyCopyWithImpl<$Res>
    implements _$PrayerFamilyCopyWith<$Res> {
  __$PrayerFamilyCopyWithImpl(this._self, this._then);

  final _PrayerFamily _self;
  final $Res Function(_PrayerFamily) _then;

/// Create a copy of PrayerFamily
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? discipleMaker = freezed,Object? members = null,}) {
  return _then(_PrayerFamily(
discipleMaker: freezed == discipleMaker ? _self.discipleMaker : discipleMaker // ignore: cast_nullable_to_non_nullable
as MemberCard?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PrayerFamily
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberCardCopyWith<$Res>? get discipleMaker {
    if (_self.discipleMaker == null) {
    return null;
  }

  return $MemberCardCopyWith<$Res>(_self.discipleMaker!, (value) {
    return _then(_self.copyWith(discipleMaker: value));
  });
}
}

// dart format on
