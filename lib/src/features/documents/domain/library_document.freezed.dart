// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibraryFile {

 int get id; String get url;/// "Règlement intérieur.pdf": the name it keeps on the phone.
 String get name;@JsonKey(unknownEnumValue: DocumentKind.pdf) DocumentKind get kind; int get sizeBytes;
/// Create a copy of LibraryFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryFileCopyWith<LibraryFile> get copyWith => _$LibraryFileCopyWithImpl<LibraryFile>(this as LibraryFile, _$identity);

  /// Serializes this LibraryFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryFile&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,name,kind,sizeBytes);

@override
String toString() {
  return 'LibraryFile(id: $id, url: $url, name: $name, kind: $kind, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $LibraryFileCopyWith<$Res>  {
  factory $LibraryFileCopyWith(LibraryFile value, $Res Function(LibraryFile) _then) = _$LibraryFileCopyWithImpl;
@useResult
$Res call({
 int id, String url, String name,@JsonKey(unknownEnumValue: DocumentKind.pdf) DocumentKind kind, int sizeBytes
});




}
/// @nodoc
class _$LibraryFileCopyWithImpl<$Res>
    implements $LibraryFileCopyWith<$Res> {
  _$LibraryFileCopyWithImpl(this._self, this._then);

  final LibraryFile _self;
  final $Res Function(LibraryFile) _then;

/// Create a copy of LibraryFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? name = null,Object? kind = null,Object? sizeBytes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DocumentKind,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LibraryFile].
extension LibraryFilePatterns on LibraryFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryFile value)  $default,){
final _that = this;
switch (_that) {
case _LibraryFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryFile value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String url,  String name, @JsonKey(unknownEnumValue: DocumentKind.pdf)  DocumentKind kind,  int sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryFile() when $default != null:
return $default(_that.id,_that.url,_that.name,_that.kind,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String url,  String name, @JsonKey(unknownEnumValue: DocumentKind.pdf)  DocumentKind kind,  int sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _LibraryFile():
return $default(_that.id,_that.url,_that.name,_that.kind,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String url,  String name, @JsonKey(unknownEnumValue: DocumentKind.pdf)  DocumentKind kind,  int sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _LibraryFile() when $default != null:
return $default(_that.id,_that.url,_that.name,_that.kind,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LibraryFile implements LibraryFile {
  const _LibraryFile({required this.id, required this.url, this.name = '', @JsonKey(unknownEnumValue: DocumentKind.pdf) this.kind = DocumentKind.pdf, this.sizeBytes = 0});
  factory _LibraryFile.fromJson(Map<String, dynamic> json) => _$LibraryFileFromJson(json);

@override final  int id;
@override final  String url;
/// "Règlement intérieur.pdf": the name it keeps on the phone.
@override@JsonKey() final  String name;
@override@JsonKey(unknownEnumValue: DocumentKind.pdf) final  DocumentKind kind;
@override@JsonKey() final  int sizeBytes;

/// Create a copy of LibraryFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryFileCopyWith<_LibraryFile> get copyWith => __$LibraryFileCopyWithImpl<_LibraryFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LibraryFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryFile&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,name,kind,sizeBytes);

@override
String toString() {
  return 'LibraryFile(id: $id, url: $url, name: $name, kind: $kind, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$LibraryFileCopyWith<$Res> implements $LibraryFileCopyWith<$Res> {
  factory _$LibraryFileCopyWith(_LibraryFile value, $Res Function(_LibraryFile) _then) = __$LibraryFileCopyWithImpl;
@override @useResult
$Res call({
 int id, String url, String name,@JsonKey(unknownEnumValue: DocumentKind.pdf) DocumentKind kind, int sizeBytes
});




}
/// @nodoc
class __$LibraryFileCopyWithImpl<$Res>
    implements _$LibraryFileCopyWith<$Res> {
  __$LibraryFileCopyWithImpl(this._self, this._then);

  final _LibraryFile _self;
  final $Res Function(_LibraryFile) _then;

/// Create a copy of LibraryFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? name = null,Object? kind = null,Object? sizeBytes = null,}) {
  return _then(_LibraryFile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DocumentKind,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LibraryDocument {

 int get id; String get title; String get description;/// "Enseignements", "Formulaires"…; '' when none.
 String get category; LibraryFile get file; DateTime? get publishedAt;
/// Create a copy of LibraryDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryDocumentCopyWith<LibraryDocument> get copyWith => _$LibraryDocumentCopyWithImpl<LibraryDocument>(this as LibraryDocument, _$identity);

  /// Serializes this LibraryDocument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.file, file) || other.file == file)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,file,publishedAt);

@override
String toString() {
  return 'LibraryDocument(id: $id, title: $title, description: $description, category: $category, file: $file, publishedAt: $publishedAt)';
}


}

/// @nodoc
abstract mixin class $LibraryDocumentCopyWith<$Res>  {
  factory $LibraryDocumentCopyWith(LibraryDocument value, $Res Function(LibraryDocument) _then) = _$LibraryDocumentCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String category, LibraryFile file, DateTime? publishedAt
});


$LibraryFileCopyWith<$Res> get file;

}
/// @nodoc
class _$LibraryDocumentCopyWithImpl<$Res>
    implements $LibraryDocumentCopyWith<$Res> {
  _$LibraryDocumentCopyWithImpl(this._self, this._then);

  final LibraryDocument _self;
  final $Res Function(LibraryDocument) _then;

/// Create a copy of LibraryDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? file = null,Object? publishedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as LibraryFile,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of LibraryDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LibraryFileCopyWith<$Res> get file {
  
  return $LibraryFileCopyWith<$Res>(_self.file, (value) {
    return _then(_self.copyWith(file: value));
  });
}
}


/// Adds pattern-matching-related methods to [LibraryDocument].
extension LibraryDocumentPatterns on LibraryDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryDocument value)  $default,){
final _that = this;
switch (_that) {
case _LibraryDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryDocument value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String category,  LibraryFile file,  DateTime? publishedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryDocument() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.file,_that.publishedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String category,  LibraryFile file,  DateTime? publishedAt)  $default,) {final _that = this;
switch (_that) {
case _LibraryDocument():
return $default(_that.id,_that.title,_that.description,_that.category,_that.file,_that.publishedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  String category,  LibraryFile file,  DateTime? publishedAt)?  $default,) {final _that = this;
switch (_that) {
case _LibraryDocument() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.file,_that.publishedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LibraryDocument implements LibraryDocument {
  const _LibraryDocument({required this.id, required this.title, this.description = '', this.category = '', required this.file, this.publishedAt});
  factory _LibraryDocument.fromJson(Map<String, dynamic> json) => _$LibraryDocumentFromJson(json);

@override final  int id;
@override final  String title;
@override@JsonKey() final  String description;
/// "Enseignements", "Formulaires"…; '' when none.
@override@JsonKey() final  String category;
@override final  LibraryFile file;
@override final  DateTime? publishedAt;

/// Create a copy of LibraryDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryDocumentCopyWith<_LibraryDocument> get copyWith => __$LibraryDocumentCopyWithImpl<_LibraryDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LibraryDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.file, file) || other.file == file)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,file,publishedAt);

@override
String toString() {
  return 'LibraryDocument(id: $id, title: $title, description: $description, category: $category, file: $file, publishedAt: $publishedAt)';
}


}

/// @nodoc
abstract mixin class _$LibraryDocumentCopyWith<$Res> implements $LibraryDocumentCopyWith<$Res> {
  factory _$LibraryDocumentCopyWith(_LibraryDocument value, $Res Function(_LibraryDocument) _then) = __$LibraryDocumentCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String category, LibraryFile file, DateTime? publishedAt
});


@override $LibraryFileCopyWith<$Res> get file;

}
/// @nodoc
class __$LibraryDocumentCopyWithImpl<$Res>
    implements _$LibraryDocumentCopyWith<$Res> {
  __$LibraryDocumentCopyWithImpl(this._self, this._then);

  final _LibraryDocument _self;
  final $Res Function(_LibraryDocument) _then;

/// Create a copy of LibraryDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? file = null,Object? publishedAt = freezed,}) {
  return _then(_LibraryDocument(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as LibraryFile,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of LibraryDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LibraryFileCopyWith<$Res> get file {
  
  return $LibraryFileCopyWith<$Res>(_self.file, (value) {
    return _then(_self.copyWith(file: value));
  });
}
}


/// @nodoc
mixin _$DocumentCategory {

 String get name; int get count;
/// Create a copy of DocumentCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentCategoryCopyWith<DocumentCategory> get copyWith => _$DocumentCategoryCopyWithImpl<DocumentCategory>(this as DocumentCategory, _$identity);

  /// Serializes this DocumentCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentCategory&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'DocumentCategory(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class $DocumentCategoryCopyWith<$Res>  {
  factory $DocumentCategoryCopyWith(DocumentCategory value, $Res Function(DocumentCategory) _then) = _$DocumentCategoryCopyWithImpl;
@useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class _$DocumentCategoryCopyWithImpl<$Res>
    implements $DocumentCategoryCopyWith<$Res> {
  _$DocumentCategoryCopyWithImpl(this._self, this._then);

  final DocumentCategory _self;
  final $Res Function(DocumentCategory) _then;

/// Create a copy of DocumentCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? count = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentCategory].
extension DocumentCategoryPatterns on DocumentCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentCategory value)  $default,){
final _that = this;
switch (_that) {
case _DocumentCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentCategory value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentCategory() when $default != null:
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
case _DocumentCategory() when $default != null:
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
case _DocumentCategory():
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
case _DocumentCategory() when $default != null:
return $default(_that.name,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentCategory implements DocumentCategory {
  const _DocumentCategory({required this.name, this.count = 0});
  factory _DocumentCategory.fromJson(Map<String, dynamic> json) => _$DocumentCategoryFromJson(json);

@override final  String name;
@override@JsonKey() final  int count;

/// Create a copy of DocumentCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentCategoryCopyWith<_DocumentCategory> get copyWith => __$DocumentCategoryCopyWithImpl<_DocumentCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentCategory&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'DocumentCategory(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class _$DocumentCategoryCopyWith<$Res> implements $DocumentCategoryCopyWith<$Res> {
  factory _$DocumentCategoryCopyWith(_DocumentCategory value, $Res Function(_DocumentCategory) _then) = __$DocumentCategoryCopyWithImpl;
@override @useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class __$DocumentCategoryCopyWithImpl<$Res>
    implements _$DocumentCategoryCopyWith<$Res> {
  __$DocumentCategoryCopyWithImpl(this._self, this._then);

  final _DocumentCategory _self;
  final $Res Function(_DocumentCategory) _then;

/// Create a copy of DocumentCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? count = null,}) {
  return _then(_DocumentCategory(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
