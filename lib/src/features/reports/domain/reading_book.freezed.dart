// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadingBook {

 int get id; String get title; String get author; int get totalPages; String get coverUrl;@JsonKey(unknownEnumValue: ReadingStatus.reading) ReadingStatus get status;/// The first day a report named it (else the day it was added).
@ApiDateConverter() DateTime get startedOn;@ApiDateConverter() DateTime? get finishedOn;/// The pages of the reports that name it (may pass [totalPages]).
 int get pagesRead;
/// Create a copy of ReadingBook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingBookCopyWith<ReadingBook> get copyWith => _$ReadingBookCopyWithImpl<ReadingBook>(this as ReadingBook, _$identity);

  /// Serializes this ReadingBook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingBook&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedOn, startedOn) || other.startedOn == startedOn)&&(identical(other.finishedOn, finishedOn) || other.finishedOn == finishedOn)&&(identical(other.pagesRead, pagesRead) || other.pagesRead == pagesRead));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,totalPages,coverUrl,status,startedOn,finishedOn,pagesRead);

@override
String toString() {
  return 'ReadingBook(id: $id, title: $title, author: $author, totalPages: $totalPages, coverUrl: $coverUrl, status: $status, startedOn: $startedOn, finishedOn: $finishedOn, pagesRead: $pagesRead)';
}


}

/// @nodoc
abstract mixin class $ReadingBookCopyWith<$Res>  {
  factory $ReadingBookCopyWith(ReadingBook value, $Res Function(ReadingBook) _then) = _$ReadingBookCopyWithImpl;
@useResult
$Res call({
 int id, String title, String author, int totalPages, String coverUrl,@JsonKey(unknownEnumValue: ReadingStatus.reading) ReadingStatus status,@ApiDateConverter() DateTime startedOn,@ApiDateConverter() DateTime? finishedOn, int pagesRead
});




}
/// @nodoc
class _$ReadingBookCopyWithImpl<$Res>
    implements $ReadingBookCopyWith<$Res> {
  _$ReadingBookCopyWithImpl(this._self, this._then);

  final ReadingBook _self;
  final $Res Function(ReadingBook) _then;

/// Create a copy of ReadingBook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? author = null,Object? totalPages = null,Object? coverUrl = null,Object? status = null,Object? startedOn = null,Object? finishedOn = freezed,Object? pagesRead = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReadingStatus,startedOn: null == startedOn ? _self.startedOn : startedOn // ignore: cast_nullable_to_non_nullable
as DateTime,finishedOn: freezed == finishedOn ? _self.finishedOn : finishedOn // ignore: cast_nullable_to_non_nullable
as DateTime?,pagesRead: null == pagesRead ? _self.pagesRead : pagesRead // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingBook].
extension ReadingBookPatterns on ReadingBook {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingBook value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingBook() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingBook value)  $default,){
final _that = this;
switch (_that) {
case _ReadingBook():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingBook value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingBook() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String author,  int totalPages,  String coverUrl, @JsonKey(unknownEnumValue: ReadingStatus.reading)  ReadingStatus status, @ApiDateConverter()  DateTime startedOn, @ApiDateConverter()  DateTime? finishedOn,  int pagesRead)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingBook() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.totalPages,_that.coverUrl,_that.status,_that.startedOn,_that.finishedOn,_that.pagesRead);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String author,  int totalPages,  String coverUrl, @JsonKey(unknownEnumValue: ReadingStatus.reading)  ReadingStatus status, @ApiDateConverter()  DateTime startedOn, @ApiDateConverter()  DateTime? finishedOn,  int pagesRead)  $default,) {final _that = this;
switch (_that) {
case _ReadingBook():
return $default(_that.id,_that.title,_that.author,_that.totalPages,_that.coverUrl,_that.status,_that.startedOn,_that.finishedOn,_that.pagesRead);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String author,  int totalPages,  String coverUrl, @JsonKey(unknownEnumValue: ReadingStatus.reading)  ReadingStatus status, @ApiDateConverter()  DateTime startedOn, @ApiDateConverter()  DateTime? finishedOn,  int pagesRead)?  $default,) {final _that = this;
switch (_that) {
case _ReadingBook() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.totalPages,_that.coverUrl,_that.status,_that.startedOn,_that.finishedOn,_that.pagesRead);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingBook extends ReadingBook {
  const _ReadingBook({required this.id, required this.title, this.author = '', required this.totalPages, this.coverUrl = '', @JsonKey(unknownEnumValue: ReadingStatus.reading) this.status = ReadingStatus.reading, @ApiDateConverter() required this.startedOn, @ApiDateConverter() this.finishedOn, this.pagesRead = 0}): super._();
  factory _ReadingBook.fromJson(Map<String, dynamic> json) => _$ReadingBookFromJson(json);

@override final  int id;
@override final  String title;
@override@JsonKey() final  String author;
@override final  int totalPages;
@override@JsonKey() final  String coverUrl;
@override@JsonKey(unknownEnumValue: ReadingStatus.reading) final  ReadingStatus status;
/// The first day a report named it (else the day it was added).
@override@ApiDateConverter() final  DateTime startedOn;
@override@ApiDateConverter() final  DateTime? finishedOn;
/// The pages of the reports that name it (may pass [totalPages]).
@override@JsonKey() final  int pagesRead;

/// Create a copy of ReadingBook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingBookCopyWith<_ReadingBook> get copyWith => __$ReadingBookCopyWithImpl<_ReadingBook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingBookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingBook&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedOn, startedOn) || other.startedOn == startedOn)&&(identical(other.finishedOn, finishedOn) || other.finishedOn == finishedOn)&&(identical(other.pagesRead, pagesRead) || other.pagesRead == pagesRead));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,totalPages,coverUrl,status,startedOn,finishedOn,pagesRead);

@override
String toString() {
  return 'ReadingBook(id: $id, title: $title, author: $author, totalPages: $totalPages, coverUrl: $coverUrl, status: $status, startedOn: $startedOn, finishedOn: $finishedOn, pagesRead: $pagesRead)';
}


}

/// @nodoc
abstract mixin class _$ReadingBookCopyWith<$Res> implements $ReadingBookCopyWith<$Res> {
  factory _$ReadingBookCopyWith(_ReadingBook value, $Res Function(_ReadingBook) _then) = __$ReadingBookCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String author, int totalPages, String coverUrl,@JsonKey(unknownEnumValue: ReadingStatus.reading) ReadingStatus status,@ApiDateConverter() DateTime startedOn,@ApiDateConverter() DateTime? finishedOn, int pagesRead
});




}
/// @nodoc
class __$ReadingBookCopyWithImpl<$Res>
    implements _$ReadingBookCopyWith<$Res> {
  __$ReadingBookCopyWithImpl(this._self, this._then);

  final _ReadingBook _self;
  final $Res Function(_ReadingBook) _then;

/// Create a copy of ReadingBook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? author = null,Object? totalPages = null,Object? coverUrl = null,Object? status = null,Object? startedOn = null,Object? finishedOn = freezed,Object? pagesRead = null,}) {
  return _then(_ReadingBook(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReadingStatus,startedOn: null == startedOn ? _self.startedOn : startedOn // ignore: cast_nullable_to_non_nullable
as DateTime,finishedOn: freezed == finishedOn ? _self.finishedOn : finishedOn // ignore: cast_nullable_to_non_nullable
as DateTime?,pagesRead: null == pagesRead ? _self.pagesRead : pagesRead // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BookFound {

 String get title; String get author; int get totalPages; String get coverUrl;
/// Create a copy of BookFound
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookFoundCopyWith<BookFound> get copyWith => _$BookFoundCopyWithImpl<BookFound>(this as BookFound, _$identity);

  /// Serializes this BookFound to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookFound&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,author,totalPages,coverUrl);

@override
String toString() {
  return 'BookFound(title: $title, author: $author, totalPages: $totalPages, coverUrl: $coverUrl)';
}


}

/// @nodoc
abstract mixin class $BookFoundCopyWith<$Res>  {
  factory $BookFoundCopyWith(BookFound value, $Res Function(BookFound) _then) = _$BookFoundCopyWithImpl;
@useResult
$Res call({
 String title, String author, int totalPages, String coverUrl
});




}
/// @nodoc
class _$BookFoundCopyWithImpl<$Res>
    implements $BookFoundCopyWith<$Res> {
  _$BookFoundCopyWithImpl(this._self, this._then);

  final BookFound _self;
  final $Res Function(BookFound) _then;

/// Create a copy of BookFound
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? author = null,Object? totalPages = null,Object? coverUrl = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookFound].
extension BookFoundPatterns on BookFound {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookFound value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookFound() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookFound value)  $default,){
final _that = this;
switch (_that) {
case _BookFound():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookFound value)?  $default,){
final _that = this;
switch (_that) {
case _BookFound() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String author,  int totalPages,  String coverUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookFound() when $default != null:
return $default(_that.title,_that.author,_that.totalPages,_that.coverUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String author,  int totalPages,  String coverUrl)  $default,) {final _that = this;
switch (_that) {
case _BookFound():
return $default(_that.title,_that.author,_that.totalPages,_that.coverUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String author,  int totalPages,  String coverUrl)?  $default,) {final _that = this;
switch (_that) {
case _BookFound() when $default != null:
return $default(_that.title,_that.author,_that.totalPages,_that.coverUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookFound implements BookFound {
  const _BookFound({required this.title, this.author = '', this.totalPages = 0, this.coverUrl = ''});
  factory _BookFound.fromJson(Map<String, dynamic> json) => _$BookFoundFromJson(json);

@override final  String title;
@override@JsonKey() final  String author;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  String coverUrl;

/// Create a copy of BookFound
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookFoundCopyWith<_BookFound> get copyWith => __$BookFoundCopyWithImpl<_BookFound>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookFoundToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookFound&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,author,totalPages,coverUrl);

@override
String toString() {
  return 'BookFound(title: $title, author: $author, totalPages: $totalPages, coverUrl: $coverUrl)';
}


}

/// @nodoc
abstract mixin class _$BookFoundCopyWith<$Res> implements $BookFoundCopyWith<$Res> {
  factory _$BookFoundCopyWith(_BookFound value, $Res Function(_BookFound) _then) = __$BookFoundCopyWithImpl;
@override @useResult
$Res call({
 String title, String author, int totalPages, String coverUrl
});




}
/// @nodoc
class __$BookFoundCopyWithImpl<$Res>
    implements _$BookFoundCopyWith<$Res> {
  __$BookFoundCopyWithImpl(this._self, this._then);

  final _BookFound _self;
  final $Res Function(_BookFound) _then;

/// Create a copy of BookFound
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? author = null,Object? totalPages = null,Object? coverUrl = null,}) {
  return _then(_BookFound(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReadingStats {

 int get year;/// The 12 months, January first.
 List<ReadingMonth> get months; int get booksFinished;/// The pages read in books that year.
 int get pages;
/// Create a copy of ReadingStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingStatsCopyWith<ReadingStats> get copyWith => _$ReadingStatsCopyWithImpl<ReadingStats>(this as ReadingStats, _$identity);

  /// Serializes this ReadingStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingStats&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other.months, months)&&(identical(other.booksFinished, booksFinished) || other.booksFinished == booksFinished)&&(identical(other.pages, pages) || other.pages == pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,const DeepCollectionEquality().hash(months),booksFinished,pages);

@override
String toString() {
  return 'ReadingStats(year: $year, months: $months, booksFinished: $booksFinished, pages: $pages)';
}


}

/// @nodoc
abstract mixin class $ReadingStatsCopyWith<$Res>  {
  factory $ReadingStatsCopyWith(ReadingStats value, $Res Function(ReadingStats) _then) = _$ReadingStatsCopyWithImpl;
@useResult
$Res call({
 int year, List<ReadingMonth> months, int booksFinished, int pages
});




}
/// @nodoc
class _$ReadingStatsCopyWithImpl<$Res>
    implements $ReadingStatsCopyWith<$Res> {
  _$ReadingStatsCopyWithImpl(this._self, this._then);

  final ReadingStats _self;
  final $Res Function(ReadingStats) _then;

/// Create a copy of ReadingStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? months = null,Object? booksFinished = null,Object? pages = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as List<ReadingMonth>,booksFinished: null == booksFinished ? _self.booksFinished : booksFinished // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingStats].
extension ReadingStatsPatterns on ReadingStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingStats value)  $default,){
final _that = this;
switch (_that) {
case _ReadingStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingStats value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  List<ReadingMonth> months,  int booksFinished,  int pages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingStats() when $default != null:
return $default(_that.year,_that.months,_that.booksFinished,_that.pages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  List<ReadingMonth> months,  int booksFinished,  int pages)  $default,) {final _that = this;
switch (_that) {
case _ReadingStats():
return $default(_that.year,_that.months,_that.booksFinished,_that.pages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  List<ReadingMonth> months,  int booksFinished,  int pages)?  $default,) {final _that = this;
switch (_that) {
case _ReadingStats() when $default != null:
return $default(_that.year,_that.months,_that.booksFinished,_that.pages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingStats extends ReadingStats {
  const _ReadingStats({required this.year, final  List<ReadingMonth> months = const <ReadingMonth>[], this.booksFinished = 0, this.pages = 0}): _months = months,super._();
  factory _ReadingStats.fromJson(Map<String, dynamic> json) => _$ReadingStatsFromJson(json);

@override final  int year;
/// The 12 months, January first.
 final  List<ReadingMonth> _months;
/// The 12 months, January first.
@override@JsonKey() List<ReadingMonth> get months {
  if (_months is EqualUnmodifiableListView) return _months;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_months);
}

@override@JsonKey() final  int booksFinished;
/// The pages read in books that year.
@override@JsonKey() final  int pages;

/// Create a copy of ReadingStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingStatsCopyWith<_ReadingStats> get copyWith => __$ReadingStatsCopyWithImpl<_ReadingStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingStats&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other._months, _months)&&(identical(other.booksFinished, booksFinished) || other.booksFinished == booksFinished)&&(identical(other.pages, pages) || other.pages == pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,const DeepCollectionEquality().hash(_months),booksFinished,pages);

@override
String toString() {
  return 'ReadingStats(year: $year, months: $months, booksFinished: $booksFinished, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$ReadingStatsCopyWith<$Res> implements $ReadingStatsCopyWith<$Res> {
  factory _$ReadingStatsCopyWith(_ReadingStats value, $Res Function(_ReadingStats) _then) = __$ReadingStatsCopyWithImpl;
@override @useResult
$Res call({
 int year, List<ReadingMonth> months, int booksFinished, int pages
});




}
/// @nodoc
class __$ReadingStatsCopyWithImpl<$Res>
    implements _$ReadingStatsCopyWith<$Res> {
  __$ReadingStatsCopyWithImpl(this._self, this._then);

  final _ReadingStats _self;
  final $Res Function(_ReadingStats) _then;

/// Create a copy of ReadingStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? months = null,Object? booksFinished = null,Object? pages = null,}) {
  return _then(_ReadingStats(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,months: null == months ? _self._months : months // ignore: cast_nullable_to_non_nullable
as List<ReadingMonth>,booksFinished: null == booksFinished ? _self.booksFinished : booksFinished // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReadingMonth {

 String get month; int get books;
/// Create a copy of ReadingMonth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingMonthCopyWith<ReadingMonth> get copyWith => _$ReadingMonthCopyWithImpl<ReadingMonth>(this as ReadingMonth, _$identity);

  /// Serializes this ReadingMonth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingMonth&&(identical(other.month, month) || other.month == month)&&(identical(other.books, books) || other.books == books));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,books);

@override
String toString() {
  return 'ReadingMonth(month: $month, books: $books)';
}


}

/// @nodoc
abstract mixin class $ReadingMonthCopyWith<$Res>  {
  factory $ReadingMonthCopyWith(ReadingMonth value, $Res Function(ReadingMonth) _then) = _$ReadingMonthCopyWithImpl;
@useResult
$Res call({
 String month, int books
});




}
/// @nodoc
class _$ReadingMonthCopyWithImpl<$Res>
    implements $ReadingMonthCopyWith<$Res> {
  _$ReadingMonthCopyWithImpl(this._self, this._then);

  final ReadingMonth _self;
  final $Res Function(ReadingMonth) _then;

/// Create a copy of ReadingMonth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? books = null,}) {
  return _then(_self.copyWith(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingMonth].
extension ReadingMonthPatterns on ReadingMonth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingMonth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingMonth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingMonth value)  $default,){
final _that = this;
switch (_that) {
case _ReadingMonth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingMonth value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingMonth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  int books)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingMonth() when $default != null:
return $default(_that.month,_that.books);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  int books)  $default,) {final _that = this;
switch (_that) {
case _ReadingMonth():
return $default(_that.month,_that.books);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  int books)?  $default,) {final _that = this;
switch (_that) {
case _ReadingMonth() when $default != null:
return $default(_that.month,_that.books);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingMonth implements ReadingMonth {
  const _ReadingMonth({required this.month, this.books = 0});
  factory _ReadingMonth.fromJson(Map<String, dynamic> json) => _$ReadingMonthFromJson(json);

@override final  String month;
@override@JsonKey() final  int books;

/// Create a copy of ReadingMonth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingMonthCopyWith<_ReadingMonth> get copyWith => __$ReadingMonthCopyWithImpl<_ReadingMonth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingMonthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingMonth&&(identical(other.month, month) || other.month == month)&&(identical(other.books, books) || other.books == books));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,books);

@override
String toString() {
  return 'ReadingMonth(month: $month, books: $books)';
}


}

/// @nodoc
abstract mixin class _$ReadingMonthCopyWith<$Res> implements $ReadingMonthCopyWith<$Res> {
  factory _$ReadingMonthCopyWith(_ReadingMonth value, $Res Function(_ReadingMonth) _then) = __$ReadingMonthCopyWithImpl;
@override @useResult
$Res call({
 String month, int books
});




}
/// @nodoc
class __$ReadingMonthCopyWithImpl<$Res>
    implements _$ReadingMonthCopyWith<$Res> {
  __$ReadingMonthCopyWithImpl(this._self, this._then);

  final _ReadingMonth _self;
  final $Res Function(_ReadingMonth) _then;

/// Create a copy of ReadingMonth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? books = null,}) {
  return _then(_ReadingMonth(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
