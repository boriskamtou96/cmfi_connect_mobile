// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameCourse {

 String get code; String get title;
/// Create a copy of GameCourse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameCourseCopyWith<GameCourse> get copyWith => _$GameCourseCopyWithImpl<GameCourse>(this as GameCourse, _$identity);

  /// Serializes this GameCourse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameCourse&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title);

@override
String toString() {
  return 'GameCourse(code: $code, title: $title)';
}


}

/// @nodoc
abstract mixin class $GameCourseCopyWith<$Res>  {
  factory $GameCourseCopyWith(GameCourse value, $Res Function(GameCourse) _then) = _$GameCourseCopyWithImpl;
@useResult
$Res call({
 String code, String title
});




}
/// @nodoc
class _$GameCourseCopyWithImpl<$Res>
    implements $GameCourseCopyWith<$Res> {
  _$GameCourseCopyWithImpl(this._self, this._then);

  final GameCourse _self;
  final $Res Function(GameCourse) _then;

/// Create a copy of GameCourse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? title = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GameCourse].
extension GameCoursePatterns on GameCourse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameCourse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameCourse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameCourse value)  $default,){
final _that = this;
switch (_that) {
case _GameCourse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameCourse value)?  $default,){
final _that = this;
switch (_that) {
case _GameCourse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameCourse() when $default != null:
return $default(_that.code,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String title)  $default,) {final _that = this;
switch (_that) {
case _GameCourse():
return $default(_that.code,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String title)?  $default,) {final _that = this;
switch (_that) {
case _GameCourse() when $default != null:
return $default(_that.code,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameCourse implements GameCourse {
  const _GameCourse({required this.code, required this.title});
  factory _GameCourse.fromJson(Map<String, dynamic> json) => _$GameCourseFromJson(json);

@override final  String code;
@override final  String title;

/// Create a copy of GameCourse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameCourseCopyWith<_GameCourse> get copyWith => __$GameCourseCopyWithImpl<_GameCourse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameCourseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameCourse&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title);

@override
String toString() {
  return 'GameCourse(code: $code, title: $title)';
}


}

/// @nodoc
abstract mixin class _$GameCourseCopyWith<$Res> implements $GameCourseCopyWith<$Res> {
  factory _$GameCourseCopyWith(_GameCourse value, $Res Function(_GameCourse) _then) = __$GameCourseCopyWithImpl;
@override @useResult
$Res call({
 String code, String title
});




}
/// @nodoc
class __$GameCourseCopyWithImpl<$Res>
    implements _$GameCourseCopyWith<$Res> {
  __$GameCourseCopyWithImpl(this._self, this._then);

  final _GameCourse _self;
  final $Res Function(_GameCourse) _then;

/// Create a copy of GameCourse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? title = null,}) {
  return _then(_GameCourse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GamePlayer {

 int get totalPoints;/// Their level, the points where it began and those of the next one.
 int get level; int get levelFloor; int get nextLevelAt;/// The days played in a row (0 once broken).
 int get streakDays; bool get playedToday; int get dailyGoal; int get pointsToday;/// Null until they chose to appear in the leaderboard or not.
 bool? get inLeaderboard; int? get weekRank; bool get dailyDone;
/// Create a copy of GamePlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GamePlayerCopyWith<GamePlayer> get copyWith => _$GamePlayerCopyWithImpl<GamePlayer>(this as GamePlayer, _$identity);

  /// Serializes this GamePlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GamePlayer&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.level, level) || other.level == level)&&(identical(other.levelFloor, levelFloor) || other.levelFloor == levelFloor)&&(identical(other.nextLevelAt, nextLevelAt) || other.nextLevelAt == nextLevelAt)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.playedToday, playedToday) || other.playedToday == playedToday)&&(identical(other.dailyGoal, dailyGoal) || other.dailyGoal == dailyGoal)&&(identical(other.pointsToday, pointsToday) || other.pointsToday == pointsToday)&&(identical(other.inLeaderboard, inLeaderboard) || other.inLeaderboard == inLeaderboard)&&(identical(other.weekRank, weekRank) || other.weekRank == weekRank)&&(identical(other.dailyDone, dailyDone) || other.dailyDone == dailyDone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalPoints,level,levelFloor,nextLevelAt,streakDays,playedToday,dailyGoal,pointsToday,inLeaderboard,weekRank,dailyDone);

@override
String toString() {
  return 'GamePlayer(totalPoints: $totalPoints, level: $level, levelFloor: $levelFloor, nextLevelAt: $nextLevelAt, streakDays: $streakDays, playedToday: $playedToday, dailyGoal: $dailyGoal, pointsToday: $pointsToday, inLeaderboard: $inLeaderboard, weekRank: $weekRank, dailyDone: $dailyDone)';
}


}

/// @nodoc
abstract mixin class $GamePlayerCopyWith<$Res>  {
  factory $GamePlayerCopyWith(GamePlayer value, $Res Function(GamePlayer) _then) = _$GamePlayerCopyWithImpl;
@useResult
$Res call({
 int totalPoints, int level, int levelFloor, int nextLevelAt, int streakDays, bool playedToday, int dailyGoal, int pointsToday, bool? inLeaderboard, int? weekRank, bool dailyDone
});




}
/// @nodoc
class _$GamePlayerCopyWithImpl<$Res>
    implements $GamePlayerCopyWith<$Res> {
  _$GamePlayerCopyWithImpl(this._self, this._then);

  final GamePlayer _self;
  final $Res Function(GamePlayer) _then;

/// Create a copy of GamePlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalPoints = null,Object? level = null,Object? levelFloor = null,Object? nextLevelAt = null,Object? streakDays = null,Object? playedToday = null,Object? dailyGoal = null,Object? pointsToday = null,Object? inLeaderboard = freezed,Object? weekRank = freezed,Object? dailyDone = null,}) {
  return _then(_self.copyWith(
totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,levelFloor: null == levelFloor ? _self.levelFloor : levelFloor // ignore: cast_nullable_to_non_nullable
as int,nextLevelAt: null == nextLevelAt ? _self.nextLevelAt : nextLevelAt // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,playedToday: null == playedToday ? _self.playedToday : playedToday // ignore: cast_nullable_to_non_nullable
as bool,dailyGoal: null == dailyGoal ? _self.dailyGoal : dailyGoal // ignore: cast_nullable_to_non_nullable
as int,pointsToday: null == pointsToday ? _self.pointsToday : pointsToday // ignore: cast_nullable_to_non_nullable
as int,inLeaderboard: freezed == inLeaderboard ? _self.inLeaderboard : inLeaderboard // ignore: cast_nullable_to_non_nullable
as bool?,weekRank: freezed == weekRank ? _self.weekRank : weekRank // ignore: cast_nullable_to_non_nullable
as int?,dailyDone: null == dailyDone ? _self.dailyDone : dailyDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GamePlayer].
extension GamePlayerPatterns on GamePlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GamePlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GamePlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GamePlayer value)  $default,){
final _that = this;
switch (_that) {
case _GamePlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GamePlayer value)?  $default,){
final _that = this;
switch (_that) {
case _GamePlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalPoints,  int level,  int levelFloor,  int nextLevelAt,  int streakDays,  bool playedToday,  int dailyGoal,  int pointsToday,  bool? inLeaderboard,  int? weekRank,  bool dailyDone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GamePlayer() when $default != null:
return $default(_that.totalPoints,_that.level,_that.levelFloor,_that.nextLevelAt,_that.streakDays,_that.playedToday,_that.dailyGoal,_that.pointsToday,_that.inLeaderboard,_that.weekRank,_that.dailyDone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalPoints,  int level,  int levelFloor,  int nextLevelAt,  int streakDays,  bool playedToday,  int dailyGoal,  int pointsToday,  bool? inLeaderboard,  int? weekRank,  bool dailyDone)  $default,) {final _that = this;
switch (_that) {
case _GamePlayer():
return $default(_that.totalPoints,_that.level,_that.levelFloor,_that.nextLevelAt,_that.streakDays,_that.playedToday,_that.dailyGoal,_that.pointsToday,_that.inLeaderboard,_that.weekRank,_that.dailyDone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalPoints,  int level,  int levelFloor,  int nextLevelAt,  int streakDays,  bool playedToday,  int dailyGoal,  int pointsToday,  bool? inLeaderboard,  int? weekRank,  bool dailyDone)?  $default,) {final _that = this;
switch (_that) {
case _GamePlayer() when $default != null:
return $default(_that.totalPoints,_that.level,_that.levelFloor,_that.nextLevelAt,_that.streakDays,_that.playedToday,_that.dailyGoal,_that.pointsToday,_that.inLeaderboard,_that.weekRank,_that.dailyDone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GamePlayer implements GamePlayer {
  const _GamePlayer({this.totalPoints = 0, this.level = 1, this.levelFloor = 0, this.nextLevelAt = 200, this.streakDays = 0, this.playedToday = false, this.dailyGoal = 50, this.pointsToday = 0, this.inLeaderboard, this.weekRank, this.dailyDone = false});
  factory _GamePlayer.fromJson(Map<String, dynamic> json) => _$GamePlayerFromJson(json);

@override@JsonKey() final  int totalPoints;
/// Their level, the points where it began and those of the next one.
@override@JsonKey() final  int level;
@override@JsonKey() final  int levelFloor;
@override@JsonKey() final  int nextLevelAt;
/// The days played in a row (0 once broken).
@override@JsonKey() final  int streakDays;
@override@JsonKey() final  bool playedToday;
@override@JsonKey() final  int dailyGoal;
@override@JsonKey() final  int pointsToday;
/// Null until they chose to appear in the leaderboard or not.
@override final  bool? inLeaderboard;
@override final  int? weekRank;
@override@JsonKey() final  bool dailyDone;

/// Create a copy of GamePlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GamePlayerCopyWith<_GamePlayer> get copyWith => __$GamePlayerCopyWithImpl<_GamePlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GamePlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GamePlayer&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.level, level) || other.level == level)&&(identical(other.levelFloor, levelFloor) || other.levelFloor == levelFloor)&&(identical(other.nextLevelAt, nextLevelAt) || other.nextLevelAt == nextLevelAt)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.playedToday, playedToday) || other.playedToday == playedToday)&&(identical(other.dailyGoal, dailyGoal) || other.dailyGoal == dailyGoal)&&(identical(other.pointsToday, pointsToday) || other.pointsToday == pointsToday)&&(identical(other.inLeaderboard, inLeaderboard) || other.inLeaderboard == inLeaderboard)&&(identical(other.weekRank, weekRank) || other.weekRank == weekRank)&&(identical(other.dailyDone, dailyDone) || other.dailyDone == dailyDone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalPoints,level,levelFloor,nextLevelAt,streakDays,playedToday,dailyGoal,pointsToday,inLeaderboard,weekRank,dailyDone);

@override
String toString() {
  return 'GamePlayer(totalPoints: $totalPoints, level: $level, levelFloor: $levelFloor, nextLevelAt: $nextLevelAt, streakDays: $streakDays, playedToday: $playedToday, dailyGoal: $dailyGoal, pointsToday: $pointsToday, inLeaderboard: $inLeaderboard, weekRank: $weekRank, dailyDone: $dailyDone)';
}


}

/// @nodoc
abstract mixin class _$GamePlayerCopyWith<$Res> implements $GamePlayerCopyWith<$Res> {
  factory _$GamePlayerCopyWith(_GamePlayer value, $Res Function(_GamePlayer) _then) = __$GamePlayerCopyWithImpl;
@override @useResult
$Res call({
 int totalPoints, int level, int levelFloor, int nextLevelAt, int streakDays, bool playedToday, int dailyGoal, int pointsToday, bool? inLeaderboard, int? weekRank, bool dailyDone
});




}
/// @nodoc
class __$GamePlayerCopyWithImpl<$Res>
    implements _$GamePlayerCopyWith<$Res> {
  __$GamePlayerCopyWithImpl(this._self, this._then);

  final _GamePlayer _self;
  final $Res Function(_GamePlayer) _then;

/// Create a copy of GamePlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalPoints = null,Object? level = null,Object? levelFloor = null,Object? nextLevelAt = null,Object? streakDays = null,Object? playedToday = null,Object? dailyGoal = null,Object? pointsToday = null,Object? inLeaderboard = freezed,Object? weekRank = freezed,Object? dailyDone = null,}) {
  return _then(_GamePlayer(
totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,levelFloor: null == levelFloor ? _self.levelFloor : levelFloor // ignore: cast_nullable_to_non_nullable
as int,nextLevelAt: null == nextLevelAt ? _self.nextLevelAt : nextLevelAt // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,playedToday: null == playedToday ? _self.playedToday : playedToday // ignore: cast_nullable_to_non_nullable
as bool,dailyGoal: null == dailyGoal ? _self.dailyGoal : dailyGoal // ignore: cast_nullable_to_non_nullable
as int,pointsToday: null == pointsToday ? _self.pointsToday : pointsToday // ignore: cast_nullable_to_non_nullable
as int,inLeaderboard: freezed == inLeaderboard ? _self.inLeaderboard : inLeaderboard // ignore: cast_nullable_to_non_nullable
as bool?,weekRank: freezed == weekRank ? _self.weekRank : weekRank // ignore: cast_nullable_to_non_nullable
as int?,dailyDone: null == dailyDone ? _self.dailyDone : dailyDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$GameLessonSummary {

 int get id; int get position; String get title;@JsonKey(unknownEnumValue: LessonState.locked) LessonState get state;/// The best play of the lesson: 1 to 3, 0 before.
 int get stars;
/// Create a copy of GameLessonSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameLessonSummaryCopyWith<GameLessonSummary> get copyWith => _$GameLessonSummaryCopyWithImpl<GameLessonSummary>(this as GameLessonSummary, _$identity);

  /// Serializes this GameLessonSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameLessonSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.title, title) || other.title == title)&&(identical(other.state, state) || other.state == state)&&(identical(other.stars, stars) || other.stars == stars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,position,title,state,stars);

@override
String toString() {
  return 'GameLessonSummary(id: $id, position: $position, title: $title, state: $state, stars: $stars)';
}


}

/// @nodoc
abstract mixin class $GameLessonSummaryCopyWith<$Res>  {
  factory $GameLessonSummaryCopyWith(GameLessonSummary value, $Res Function(GameLessonSummary) _then) = _$GameLessonSummaryCopyWithImpl;
@useResult
$Res call({
 int id, int position, String title,@JsonKey(unknownEnumValue: LessonState.locked) LessonState state, int stars
});




}
/// @nodoc
class _$GameLessonSummaryCopyWithImpl<$Res>
    implements $GameLessonSummaryCopyWith<$Res> {
  _$GameLessonSummaryCopyWithImpl(this._self, this._then);

  final GameLessonSummary _self;
  final $Res Function(GameLessonSummary) _then;

/// Create a copy of GameLessonSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? position = null,Object? title = null,Object? state = null,Object? stars = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as LessonState,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GameLessonSummary].
extension GameLessonSummaryPatterns on GameLessonSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameLessonSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameLessonSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameLessonSummary value)  $default,){
final _that = this;
switch (_that) {
case _GameLessonSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameLessonSummary value)?  $default,){
final _that = this;
switch (_that) {
case _GameLessonSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int position,  String title, @JsonKey(unknownEnumValue: LessonState.locked)  LessonState state,  int stars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameLessonSummary() when $default != null:
return $default(_that.id,_that.position,_that.title,_that.state,_that.stars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int position,  String title, @JsonKey(unknownEnumValue: LessonState.locked)  LessonState state,  int stars)  $default,) {final _that = this;
switch (_that) {
case _GameLessonSummary():
return $default(_that.id,_that.position,_that.title,_that.state,_that.stars);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int position,  String title, @JsonKey(unknownEnumValue: LessonState.locked)  LessonState state,  int stars)?  $default,) {final _that = this;
switch (_that) {
case _GameLessonSummary() when $default != null:
return $default(_that.id,_that.position,_that.title,_that.state,_that.stars);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameLessonSummary implements GameLessonSummary {
  const _GameLessonSummary({required this.id, this.position = 0, required this.title, @JsonKey(unknownEnumValue: LessonState.locked) this.state = LessonState.locked, this.stars = 0});
  factory _GameLessonSummary.fromJson(Map<String, dynamic> json) => _$GameLessonSummaryFromJson(json);

@override final  int id;
@override@JsonKey() final  int position;
@override final  String title;
@override@JsonKey(unknownEnumValue: LessonState.locked) final  LessonState state;
/// The best play of the lesson: 1 to 3, 0 before.
@override@JsonKey() final  int stars;

/// Create a copy of GameLessonSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameLessonSummaryCopyWith<_GameLessonSummary> get copyWith => __$GameLessonSummaryCopyWithImpl<_GameLessonSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameLessonSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameLessonSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.title, title) || other.title == title)&&(identical(other.state, state) || other.state == state)&&(identical(other.stars, stars) || other.stars == stars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,position,title,state,stars);

@override
String toString() {
  return 'GameLessonSummary(id: $id, position: $position, title: $title, state: $state, stars: $stars)';
}


}

/// @nodoc
abstract mixin class _$GameLessonSummaryCopyWith<$Res> implements $GameLessonSummaryCopyWith<$Res> {
  factory _$GameLessonSummaryCopyWith(_GameLessonSummary value, $Res Function(_GameLessonSummary) _then) = __$GameLessonSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, int position, String title,@JsonKey(unknownEnumValue: LessonState.locked) LessonState state, int stars
});




}
/// @nodoc
class __$GameLessonSummaryCopyWithImpl<$Res>
    implements _$GameLessonSummaryCopyWith<$Res> {
  __$GameLessonSummaryCopyWithImpl(this._self, this._then);

  final _GameLessonSummary _self;
  final $Res Function(_GameLessonSummary) _then;

/// Create a copy of GameLessonSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? position = null,Object? title = null,Object? state = null,Object? stars = null,}) {
  return _then(_GameLessonSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as LessonState,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$GameLevel {

 int get id; int get position; String get title; String get description;/// The color of its banner, #RRGGBB.
 String get color; List<GameLessonSummary> get lessons;
/// Create a copy of GameLevel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameLevelCopyWith<GameLevel> get copyWith => _$GameLevelCopyWithImpl<GameLevel>(this as GameLevel, _$identity);

  /// Serializes this GameLevel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameLevel&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other.lessons, lessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,position,title,description,color,const DeepCollectionEquality().hash(lessons));

@override
String toString() {
  return 'GameLevel(id: $id, position: $position, title: $title, description: $description, color: $color, lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class $GameLevelCopyWith<$Res>  {
  factory $GameLevelCopyWith(GameLevel value, $Res Function(GameLevel) _then) = _$GameLevelCopyWithImpl;
@useResult
$Res call({
 int id, int position, String title, String description, String color, List<GameLessonSummary> lessons
});




}
/// @nodoc
class _$GameLevelCopyWithImpl<$Res>
    implements $GameLevelCopyWith<$Res> {
  _$GameLevelCopyWithImpl(this._self, this._then);

  final GameLevel _self;
  final $Res Function(GameLevel) _then;

/// Create a copy of GameLevel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? position = null,Object? title = null,Object? description = null,Object? color = null,Object? lessons = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,lessons: null == lessons ? _self.lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<GameLessonSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameLevel].
extension GameLevelPatterns on GameLevel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameLevel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameLevel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameLevel value)  $default,){
final _that = this;
switch (_that) {
case _GameLevel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameLevel value)?  $default,){
final _that = this;
switch (_that) {
case _GameLevel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int position,  String title,  String description,  String color,  List<GameLessonSummary> lessons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameLevel() when $default != null:
return $default(_that.id,_that.position,_that.title,_that.description,_that.color,_that.lessons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int position,  String title,  String description,  String color,  List<GameLessonSummary> lessons)  $default,) {final _that = this;
switch (_that) {
case _GameLevel():
return $default(_that.id,_that.position,_that.title,_that.description,_that.color,_that.lessons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int position,  String title,  String description,  String color,  List<GameLessonSummary> lessons)?  $default,) {final _that = this;
switch (_that) {
case _GameLevel() when $default != null:
return $default(_that.id,_that.position,_that.title,_that.description,_that.color,_that.lessons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameLevel implements GameLevel {
  const _GameLevel({required this.id, this.position = 0, required this.title, this.description = '', this.color = '#0B3B70', final  List<GameLessonSummary> lessons = const <GameLessonSummary>[]}): _lessons = lessons;
  factory _GameLevel.fromJson(Map<String, dynamic> json) => _$GameLevelFromJson(json);

@override final  int id;
@override@JsonKey() final  int position;
@override final  String title;
@override@JsonKey() final  String description;
/// The color of its banner, #RRGGBB.
@override@JsonKey() final  String color;
 final  List<GameLessonSummary> _lessons;
@override@JsonKey() List<GameLessonSummary> get lessons {
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessons);
}


/// Create a copy of GameLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameLevelCopyWith<_GameLevel> get copyWith => __$GameLevelCopyWithImpl<_GameLevel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameLevelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameLevel&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._lessons, _lessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,position,title,description,color,const DeepCollectionEquality().hash(_lessons));

@override
String toString() {
  return 'GameLevel(id: $id, position: $position, title: $title, description: $description, color: $color, lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class _$GameLevelCopyWith<$Res> implements $GameLevelCopyWith<$Res> {
  factory _$GameLevelCopyWith(_GameLevel value, $Res Function(_GameLevel) _then) = __$GameLevelCopyWithImpl;
@override @useResult
$Res call({
 int id, int position, String title, String description, String color, List<GameLessonSummary> lessons
});




}
/// @nodoc
class __$GameLevelCopyWithImpl<$Res>
    implements _$GameLevelCopyWith<$Res> {
  __$GameLevelCopyWithImpl(this._self, this._then);

  final _GameLevel _self;
  final $Res Function(_GameLevel) _then;

/// Create a copy of GameLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? position = null,Object? title = null,Object? description = null,Object? color = null,Object? lessons = null,}) {
  return _then(_GameLevel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,lessons: null == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<GameLessonSummary>,
  ));
}


}


/// @nodoc
mixin _$GamePath {

 List<GameCourse> get courses;/// The code of the course shown.
 String get course; GamePlayer get player; List<GameLevel> get levels;/// Read from the copy of the phone, without network (never from the
/// server).
 bool get offline;
/// Create a copy of GamePath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GamePathCopyWith<GamePath> get copyWith => _$GamePathCopyWithImpl<GamePath>(this as GamePath, _$identity);

  /// Serializes this GamePath to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GamePath&&const DeepCollectionEquality().equals(other.courses, courses)&&(identical(other.course, course) || other.course == course)&&(identical(other.player, player) || other.player == player)&&const DeepCollectionEquality().equals(other.levels, levels)&&(identical(other.offline, offline) || other.offline == offline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(courses),course,player,const DeepCollectionEquality().hash(levels),offline);

@override
String toString() {
  return 'GamePath(courses: $courses, course: $course, player: $player, levels: $levels, offline: $offline)';
}


}

/// @nodoc
abstract mixin class $GamePathCopyWith<$Res>  {
  factory $GamePathCopyWith(GamePath value, $Res Function(GamePath) _then) = _$GamePathCopyWithImpl;
@useResult
$Res call({
 List<GameCourse> courses, String course, GamePlayer player, List<GameLevel> levels, bool offline
});


$GamePlayerCopyWith<$Res> get player;

}
/// @nodoc
class _$GamePathCopyWithImpl<$Res>
    implements $GamePathCopyWith<$Res> {
  _$GamePathCopyWithImpl(this._self, this._then);

  final GamePath _self;
  final $Res Function(GamePath) _then;

/// Create a copy of GamePath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courses = null,Object? course = null,Object? player = null,Object? levels = null,Object? offline = null,}) {
  return _then(_self.copyWith(
courses: null == courses ? _self.courses : courses // ignore: cast_nullable_to_non_nullable
as List<GameCourse>,course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as String,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as GamePlayer,levels: null == levels ? _self.levels : levels // ignore: cast_nullable_to_non_nullable
as List<GameLevel>,offline: null == offline ? _self.offline : offline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of GamePath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GamePlayerCopyWith<$Res> get player {
  
  return $GamePlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// Adds pattern-matching-related methods to [GamePath].
extension GamePathPatterns on GamePath {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GamePath value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GamePath() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GamePath value)  $default,){
final _that = this;
switch (_that) {
case _GamePath():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GamePath value)?  $default,){
final _that = this;
switch (_that) {
case _GamePath() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GameCourse> courses,  String course,  GamePlayer player,  List<GameLevel> levels,  bool offline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GamePath() when $default != null:
return $default(_that.courses,_that.course,_that.player,_that.levels,_that.offline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GameCourse> courses,  String course,  GamePlayer player,  List<GameLevel> levels,  bool offline)  $default,) {final _that = this;
switch (_that) {
case _GamePath():
return $default(_that.courses,_that.course,_that.player,_that.levels,_that.offline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GameCourse> courses,  String course,  GamePlayer player,  List<GameLevel> levels,  bool offline)?  $default,) {final _that = this;
switch (_that) {
case _GamePath() when $default != null:
return $default(_that.courses,_that.course,_that.player,_that.levels,_that.offline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GamePath implements GamePath {
  const _GamePath({final  List<GameCourse> courses = const <GameCourse>[], required this.course, this.player = const GamePlayer(), final  List<GameLevel> levels = const <GameLevel>[], this.offline = false}): _courses = courses,_levels = levels;
  factory _GamePath.fromJson(Map<String, dynamic> json) => _$GamePathFromJson(json);

 final  List<GameCourse> _courses;
@override@JsonKey() List<GameCourse> get courses {
  if (_courses is EqualUnmodifiableListView) return _courses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courses);
}

/// The code of the course shown.
@override final  String course;
@override@JsonKey() final  GamePlayer player;
 final  List<GameLevel> _levels;
@override@JsonKey() List<GameLevel> get levels {
  if (_levels is EqualUnmodifiableListView) return _levels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_levels);
}

/// Read from the copy of the phone, without network (never from the
/// server).
@override@JsonKey() final  bool offline;

/// Create a copy of GamePath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GamePathCopyWith<_GamePath> get copyWith => __$GamePathCopyWithImpl<_GamePath>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GamePathToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GamePath&&const DeepCollectionEquality().equals(other._courses, _courses)&&(identical(other.course, course) || other.course == course)&&(identical(other.player, player) || other.player == player)&&const DeepCollectionEquality().equals(other._levels, _levels)&&(identical(other.offline, offline) || other.offline == offline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_courses),course,player,const DeepCollectionEquality().hash(_levels),offline);

@override
String toString() {
  return 'GamePath(courses: $courses, course: $course, player: $player, levels: $levels, offline: $offline)';
}


}

/// @nodoc
abstract mixin class _$GamePathCopyWith<$Res> implements $GamePathCopyWith<$Res> {
  factory _$GamePathCopyWith(_GamePath value, $Res Function(_GamePath) _then) = __$GamePathCopyWithImpl;
@override @useResult
$Res call({
 List<GameCourse> courses, String course, GamePlayer player, List<GameLevel> levels, bool offline
});


@override $GamePlayerCopyWith<$Res> get player;

}
/// @nodoc
class __$GamePathCopyWithImpl<$Res>
    implements _$GamePathCopyWith<$Res> {
  __$GamePathCopyWithImpl(this._self, this._then);

  final _GamePath _self;
  final $Res Function(_GamePath) _then;

/// Create a copy of GamePath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courses = null,Object? course = null,Object? player = null,Object? levels = null,Object? offline = null,}) {
  return _then(_GamePath(
courses: null == courses ? _self._courses : courses // ignore: cast_nullable_to_non_nullable
as List<GameCourse>,course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as String,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as GamePlayer,levels: null == levels ? _self._levels : levels // ignore: cast_nullable_to_non_nullable
as List<GameLevel>,offline: null == offline ? _self.offline : offline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of GamePath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GamePlayerCopyWith<$Res> get player {
  
  return $GamePlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// @nodoc
mixin _$GameChoice {

 String get id; String get text;
/// Create a copy of GameChoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameChoiceCopyWith<GameChoice> get copyWith => _$GameChoiceCopyWithImpl<GameChoice>(this as GameChoice, _$identity);

  /// Serializes this GameChoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameChoice&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text);

@override
String toString() {
  return 'GameChoice(id: $id, text: $text)';
}


}

/// @nodoc
abstract mixin class $GameChoiceCopyWith<$Res>  {
  factory $GameChoiceCopyWith(GameChoice value, $Res Function(GameChoice) _then) = _$GameChoiceCopyWithImpl;
@useResult
$Res call({
 String id, String text
});




}
/// @nodoc
class _$GameChoiceCopyWithImpl<$Res>
    implements $GameChoiceCopyWith<$Res> {
  _$GameChoiceCopyWithImpl(this._self, this._then);

  final GameChoice _self;
  final $Res Function(GameChoice) _then;

/// Create a copy of GameChoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GameChoice].
extension GameChoicePatterns on GameChoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameChoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameChoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameChoice value)  $default,){
final _that = this;
switch (_that) {
case _GameChoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameChoice value)?  $default,){
final _that = this;
switch (_that) {
case _GameChoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameChoice() when $default != null:
return $default(_that.id,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text)  $default,) {final _that = this;
switch (_that) {
case _GameChoice():
return $default(_that.id,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text)?  $default,) {final _that = this;
switch (_that) {
case _GameChoice() when $default != null:
return $default(_that.id,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameChoice implements GameChoice {
  const _GameChoice({required this.id, required this.text});
  factory _GameChoice.fromJson(Map<String, dynamic> json) => _$GameChoiceFromJson(json);

@override final  String id;
@override final  String text;

/// Create a copy of GameChoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameChoiceCopyWith<_GameChoice> get copyWith => __$GameChoiceCopyWithImpl<_GameChoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameChoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameChoice&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text);

@override
String toString() {
  return 'GameChoice(id: $id, text: $text)';
}


}

/// @nodoc
abstract mixin class _$GameChoiceCopyWith<$Res> implements $GameChoiceCopyWith<$Res> {
  factory _$GameChoiceCopyWith(_GameChoice value, $Res Function(_GameChoice) _then) = __$GameChoiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String text
});




}
/// @nodoc
class __$GameChoiceCopyWithImpl<$Res>
    implements _$GameChoiceCopyWith<$Res> {
  __$GameChoiceCopyWithImpl(this._self, this._then);

  final _GameChoice _self;
  final $Res Function(_GameChoice) _then;

/// Create a copy of GameChoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,}) {
  return _then(_GameChoice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GameQuestion {

 int get id; String get kind; String get prompt; List<GameChoice> get choices; String get answer; String get explanation; String get source;
/// Create a copy of GameQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameQuestionCopyWith<GameQuestion> get copyWith => _$GameQuestionCopyWithImpl<GameQuestion>(this as GameQuestion, _$identity);

  /// Serializes this GameQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other.choices, choices)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,prompt,const DeepCollectionEquality().hash(choices),answer,explanation,source);

@override
String toString() {
  return 'GameQuestion(id: $id, kind: $kind, prompt: $prompt, choices: $choices, answer: $answer, explanation: $explanation, source: $source)';
}


}

/// @nodoc
abstract mixin class $GameQuestionCopyWith<$Res>  {
  factory $GameQuestionCopyWith(GameQuestion value, $Res Function(GameQuestion) _then) = _$GameQuestionCopyWithImpl;
@useResult
$Res call({
 int id, String kind, String prompt, List<GameChoice> choices, String answer, String explanation, String source
});




}
/// @nodoc
class _$GameQuestionCopyWithImpl<$Res>
    implements $GameQuestionCopyWith<$Res> {
  _$GameQuestionCopyWithImpl(this._self, this._then);

  final GameQuestion _self;
  final $Res Function(GameQuestion) _then;

/// Create a copy of GameQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? prompt = null,Object? choices = null,Object? answer = null,Object? explanation = null,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<GameChoice>,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GameQuestion].
extension GameQuestionPatterns on GameQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameQuestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameQuestion value)  $default,){
final _that = this;
switch (_that) {
case _GameQuestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _GameQuestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String kind,  String prompt,  List<GameChoice> choices,  String answer,  String explanation,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameQuestion() when $default != null:
return $default(_that.id,_that.kind,_that.prompt,_that.choices,_that.answer,_that.explanation,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String kind,  String prompt,  List<GameChoice> choices,  String answer,  String explanation,  String source)  $default,) {final _that = this;
switch (_that) {
case _GameQuestion():
return $default(_that.id,_that.kind,_that.prompt,_that.choices,_that.answer,_that.explanation,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String kind,  String prompt,  List<GameChoice> choices,  String answer,  String explanation,  String source)?  $default,) {final _that = this;
switch (_that) {
case _GameQuestion() when $default != null:
return $default(_that.id,_that.kind,_that.prompt,_that.choices,_that.answer,_that.explanation,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameQuestion implements GameQuestion {
  const _GameQuestion({required this.id, this.kind = 'choice', required this.prompt, final  List<GameChoice> choices = const <GameChoice>[], required this.answer, this.explanation = '', this.source = ''}): _choices = choices;
  factory _GameQuestion.fromJson(Map<String, dynamic> json) => _$GameQuestionFromJson(json);

@override final  int id;
@override@JsonKey() final  String kind;
@override final  String prompt;
 final  List<GameChoice> _choices;
@override@JsonKey() List<GameChoice> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

@override final  String answer;
@override@JsonKey() final  String explanation;
@override@JsonKey() final  String source;

/// Create a copy of GameQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameQuestionCopyWith<_GameQuestion> get copyWith => __$GameQuestionCopyWithImpl<_GameQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other._choices, _choices)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,prompt,const DeepCollectionEquality().hash(_choices),answer,explanation,source);

@override
String toString() {
  return 'GameQuestion(id: $id, kind: $kind, prompt: $prompt, choices: $choices, answer: $answer, explanation: $explanation, source: $source)';
}


}

/// @nodoc
abstract mixin class _$GameQuestionCopyWith<$Res> implements $GameQuestionCopyWith<$Res> {
  factory _$GameQuestionCopyWith(_GameQuestion value, $Res Function(_GameQuestion) _then) = __$GameQuestionCopyWithImpl;
@override @useResult
$Res call({
 int id, String kind, String prompt, List<GameChoice> choices, String answer, String explanation, String source
});




}
/// @nodoc
class __$GameQuestionCopyWithImpl<$Res>
    implements _$GameQuestionCopyWith<$Res> {
  __$GameQuestionCopyWithImpl(this._self, this._then);

  final _GameQuestion _self;
  final $Res Function(_GameQuestion) _then;

/// Create a copy of GameQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? prompt = null,Object? choices = null,Object? answer = null,Object? explanation = null,Object? source = null,}) {
  return _then(_GameQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<GameChoice>,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GameLesson {

 int get id; String get title; String get levelTitle; String get course; List<GameQuestion> get questions;
/// Create a copy of GameLesson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameLessonCopyWith<GameLesson> get copyWith => _$GameLessonCopyWithImpl<GameLesson>(this as GameLesson, _$identity);

  /// Serializes this GameLesson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameLesson&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.levelTitle, levelTitle) || other.levelTitle == levelTitle)&&(identical(other.course, course) || other.course == course)&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,levelTitle,course,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'GameLesson(id: $id, title: $title, levelTitle: $levelTitle, course: $course, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $GameLessonCopyWith<$Res>  {
  factory $GameLessonCopyWith(GameLesson value, $Res Function(GameLesson) _then) = _$GameLessonCopyWithImpl;
@useResult
$Res call({
 int id, String title, String levelTitle, String course, List<GameQuestion> questions
});




}
/// @nodoc
class _$GameLessonCopyWithImpl<$Res>
    implements $GameLessonCopyWith<$Res> {
  _$GameLessonCopyWithImpl(this._self, this._then);

  final GameLesson _self;
  final $Res Function(GameLesson) _then;

/// Create a copy of GameLesson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? levelTitle = null,Object? course = null,Object? questions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,levelTitle: null == levelTitle ? _self.levelTitle : levelTitle // ignore: cast_nullable_to_non_nullable
as String,course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<GameQuestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameLesson].
extension GameLessonPatterns on GameLesson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameLesson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameLesson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameLesson value)  $default,){
final _that = this;
switch (_that) {
case _GameLesson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameLesson value)?  $default,){
final _that = this;
switch (_that) {
case _GameLesson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String levelTitle,  String course,  List<GameQuestion> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameLesson() when $default != null:
return $default(_that.id,_that.title,_that.levelTitle,_that.course,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String levelTitle,  String course,  List<GameQuestion> questions)  $default,) {final _that = this;
switch (_that) {
case _GameLesson():
return $default(_that.id,_that.title,_that.levelTitle,_that.course,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String levelTitle,  String course,  List<GameQuestion> questions)?  $default,) {final _that = this;
switch (_that) {
case _GameLesson() when $default != null:
return $default(_that.id,_that.title,_that.levelTitle,_that.course,_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameLesson implements GameLesson {
  const _GameLesson({required this.id, required this.title, this.levelTitle = '', this.course = '', final  List<GameQuestion> questions = const <GameQuestion>[]}): _questions = questions;
  factory _GameLesson.fromJson(Map<String, dynamic> json) => _$GameLessonFromJson(json);

@override final  int id;
@override final  String title;
@override@JsonKey() final  String levelTitle;
@override@JsonKey() final  String course;
 final  List<GameQuestion> _questions;
@override@JsonKey() List<GameQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of GameLesson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameLessonCopyWith<_GameLesson> get copyWith => __$GameLessonCopyWithImpl<_GameLesson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameLessonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameLesson&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.levelTitle, levelTitle) || other.levelTitle == levelTitle)&&(identical(other.course, course) || other.course == course)&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,levelTitle,course,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'GameLesson(id: $id, title: $title, levelTitle: $levelTitle, course: $course, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$GameLessonCopyWith<$Res> implements $GameLessonCopyWith<$Res> {
  factory _$GameLessonCopyWith(_GameLesson value, $Res Function(_GameLesson) _then) = __$GameLessonCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String levelTitle, String course, List<GameQuestion> questions
});




}
/// @nodoc
class __$GameLessonCopyWithImpl<$Res>
    implements _$GameLessonCopyWith<$Res> {
  __$GameLessonCopyWithImpl(this._self, this._then);

  final _GameLesson _self;
  final $Res Function(_GameLesson) _then;

/// Create a copy of GameLesson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? levelTitle = null,Object? course = null,Object? questions = null,}) {
  return _then(_GameLesson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,levelTitle: null == levelTitle ? _self.levelTitle : levelTitle // ignore: cast_nullable_to_non_nullable
as String,course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<GameQuestion>,
  ));
}


}


/// @nodoc
mixin _$GameAnswer {

 int get questionId; String get choice; int get attempt;
/// Create a copy of GameAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameAnswerCopyWith<GameAnswer> get copyWith => _$GameAnswerCopyWithImpl<GameAnswer>(this as GameAnswer, _$identity);

  /// Serializes this GameAnswer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameAnswer&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.choice, choice) || other.choice == choice)&&(identical(other.attempt, attempt) || other.attempt == attempt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,choice,attempt);

@override
String toString() {
  return 'GameAnswer(questionId: $questionId, choice: $choice, attempt: $attempt)';
}


}

/// @nodoc
abstract mixin class $GameAnswerCopyWith<$Res>  {
  factory $GameAnswerCopyWith(GameAnswer value, $Res Function(GameAnswer) _then) = _$GameAnswerCopyWithImpl;
@useResult
$Res call({
 int questionId, String choice, int attempt
});




}
/// @nodoc
class _$GameAnswerCopyWithImpl<$Res>
    implements $GameAnswerCopyWith<$Res> {
  _$GameAnswerCopyWithImpl(this._self, this._then);

  final GameAnswer _self;
  final $Res Function(GameAnswer) _then;

/// Create a copy of GameAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? choice = null,Object? attempt = null,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,choice: null == choice ? _self.choice : choice // ignore: cast_nullable_to_non_nullable
as String,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GameAnswer].
extension GameAnswerPatterns on GameAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameAnswer value)  $default,){
final _that = this;
switch (_that) {
case _GameAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _GameAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int questionId,  String choice,  int attempt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameAnswer() when $default != null:
return $default(_that.questionId,_that.choice,_that.attempt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int questionId,  String choice,  int attempt)  $default,) {final _that = this;
switch (_that) {
case _GameAnswer():
return $default(_that.questionId,_that.choice,_that.attempt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int questionId,  String choice,  int attempt)?  $default,) {final _that = this;
switch (_that) {
case _GameAnswer() when $default != null:
return $default(_that.questionId,_that.choice,_that.attempt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameAnswer implements GameAnswer {
  const _GameAnswer({required this.questionId, required this.choice, required this.attempt});
  factory _GameAnswer.fromJson(Map<String, dynamic> json) => _$GameAnswerFromJson(json);

@override final  int questionId;
@override final  String choice;
@override final  int attempt;

/// Create a copy of GameAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameAnswerCopyWith<_GameAnswer> get copyWith => __$GameAnswerCopyWithImpl<_GameAnswer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameAnswerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameAnswer&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.choice, choice) || other.choice == choice)&&(identical(other.attempt, attempt) || other.attempt == attempt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,choice,attempt);

@override
String toString() {
  return 'GameAnswer(questionId: $questionId, choice: $choice, attempt: $attempt)';
}


}

/// @nodoc
abstract mixin class _$GameAnswerCopyWith<$Res> implements $GameAnswerCopyWith<$Res> {
  factory _$GameAnswerCopyWith(_GameAnswer value, $Res Function(_GameAnswer) _then) = __$GameAnswerCopyWithImpl;
@override @useResult
$Res call({
 int questionId, String choice, int attempt
});




}
/// @nodoc
class __$GameAnswerCopyWithImpl<$Res>
    implements _$GameAnswerCopyWith<$Res> {
  __$GameAnswerCopyWithImpl(this._self, this._then);

  final _GameAnswer _self;
  final $Res Function(_GameAnswer) _then;

/// Create a copy of GameAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? choice = null,Object? attempt = null,}) {
  return _then(_GameAnswer(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,choice: null == choice ? _self.choice : choice // ignore: cast_nullable_to_non_nullable
as String,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$GameResult {

 int get points; int get firstTry; int get total; int get stars; int get bestStars; bool get perfect; int get comboBonus;/// The lesson was already done: few points, capped by day.
 bool get replay; bool get levelUp; int? get nextLessonId; bool get levelCompleted; GamePlayer get player;
/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameResultCopyWith<GameResult> get copyWith => _$GameResultCopyWithImpl<GameResult>(this as GameResult, _$identity);

  /// Serializes this GameResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameResult&&(identical(other.points, points) || other.points == points)&&(identical(other.firstTry, firstTry) || other.firstTry == firstTry)&&(identical(other.total, total) || other.total == total)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.bestStars, bestStars) || other.bestStars == bestStars)&&(identical(other.perfect, perfect) || other.perfect == perfect)&&(identical(other.comboBonus, comboBonus) || other.comboBonus == comboBonus)&&(identical(other.replay, replay) || other.replay == replay)&&(identical(other.levelUp, levelUp) || other.levelUp == levelUp)&&(identical(other.nextLessonId, nextLessonId) || other.nextLessonId == nextLessonId)&&(identical(other.levelCompleted, levelCompleted) || other.levelCompleted == levelCompleted)&&(identical(other.player, player) || other.player == player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,points,firstTry,total,stars,bestStars,perfect,comboBonus,replay,levelUp,nextLessonId,levelCompleted,player);

@override
String toString() {
  return 'GameResult(points: $points, firstTry: $firstTry, total: $total, stars: $stars, bestStars: $bestStars, perfect: $perfect, comboBonus: $comboBonus, replay: $replay, levelUp: $levelUp, nextLessonId: $nextLessonId, levelCompleted: $levelCompleted, player: $player)';
}


}

/// @nodoc
abstract mixin class $GameResultCopyWith<$Res>  {
  factory $GameResultCopyWith(GameResult value, $Res Function(GameResult) _then) = _$GameResultCopyWithImpl;
@useResult
$Res call({
 int points, int firstTry, int total, int stars, int bestStars, bool perfect, int comboBonus, bool replay, bool levelUp, int? nextLessonId, bool levelCompleted, GamePlayer player
});


$GamePlayerCopyWith<$Res> get player;

}
/// @nodoc
class _$GameResultCopyWithImpl<$Res>
    implements $GameResultCopyWith<$Res> {
  _$GameResultCopyWithImpl(this._self, this._then);

  final GameResult _self;
  final $Res Function(GameResult) _then;

/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? firstTry = null,Object? total = null,Object? stars = null,Object? bestStars = null,Object? perfect = null,Object? comboBonus = null,Object? replay = null,Object? levelUp = null,Object? nextLessonId = freezed,Object? levelCompleted = null,Object? player = null,}) {
  return _then(_self.copyWith(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,firstTry: null == firstTry ? _self.firstTry : firstTry // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,bestStars: null == bestStars ? _self.bestStars : bestStars // ignore: cast_nullable_to_non_nullable
as int,perfect: null == perfect ? _self.perfect : perfect // ignore: cast_nullable_to_non_nullable
as bool,comboBonus: null == comboBonus ? _self.comboBonus : comboBonus // ignore: cast_nullable_to_non_nullable
as int,replay: null == replay ? _self.replay : replay // ignore: cast_nullable_to_non_nullable
as bool,levelUp: null == levelUp ? _self.levelUp : levelUp // ignore: cast_nullable_to_non_nullable
as bool,nextLessonId: freezed == nextLessonId ? _self.nextLessonId : nextLessonId // ignore: cast_nullable_to_non_nullable
as int?,levelCompleted: null == levelCompleted ? _self.levelCompleted : levelCompleted // ignore: cast_nullable_to_non_nullable
as bool,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as GamePlayer,
  ));
}
/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GamePlayerCopyWith<$Res> get player {
  
  return $GamePlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameResult].
extension GameResultPatterns on GameResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameResult value)  $default,){
final _that = this;
switch (_that) {
case _GameResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameResult value)?  $default,){
final _that = this;
switch (_that) {
case _GameResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int points,  int firstTry,  int total,  int stars,  int bestStars,  bool perfect,  int comboBonus,  bool replay,  bool levelUp,  int? nextLessonId,  bool levelCompleted,  GamePlayer player)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameResult() when $default != null:
return $default(_that.points,_that.firstTry,_that.total,_that.stars,_that.bestStars,_that.perfect,_that.comboBonus,_that.replay,_that.levelUp,_that.nextLessonId,_that.levelCompleted,_that.player);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int points,  int firstTry,  int total,  int stars,  int bestStars,  bool perfect,  int comboBonus,  bool replay,  bool levelUp,  int? nextLessonId,  bool levelCompleted,  GamePlayer player)  $default,) {final _that = this;
switch (_that) {
case _GameResult():
return $default(_that.points,_that.firstTry,_that.total,_that.stars,_that.bestStars,_that.perfect,_that.comboBonus,_that.replay,_that.levelUp,_that.nextLessonId,_that.levelCompleted,_that.player);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int points,  int firstTry,  int total,  int stars,  int bestStars,  bool perfect,  int comboBonus,  bool replay,  bool levelUp,  int? nextLessonId,  bool levelCompleted,  GamePlayer player)?  $default,) {final _that = this;
switch (_that) {
case _GameResult() when $default != null:
return $default(_that.points,_that.firstTry,_that.total,_that.stars,_that.bestStars,_that.perfect,_that.comboBonus,_that.replay,_that.levelUp,_that.nextLessonId,_that.levelCompleted,_that.player);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameResult implements GameResult {
  const _GameResult({this.points = 0, this.firstTry = 0, this.total = 0, this.stars = 1, this.bestStars = 1, this.perfect = false, this.comboBonus = 0, this.replay = false, this.levelUp = false, this.nextLessonId, this.levelCompleted = false, this.player = const GamePlayer()});
  factory _GameResult.fromJson(Map<String, dynamic> json) => _$GameResultFromJson(json);

@override@JsonKey() final  int points;
@override@JsonKey() final  int firstTry;
@override@JsonKey() final  int total;
@override@JsonKey() final  int stars;
@override@JsonKey() final  int bestStars;
@override@JsonKey() final  bool perfect;
@override@JsonKey() final  int comboBonus;
/// The lesson was already done: few points, capped by day.
@override@JsonKey() final  bool replay;
@override@JsonKey() final  bool levelUp;
@override final  int? nextLessonId;
@override@JsonKey() final  bool levelCompleted;
@override@JsonKey() final  GamePlayer player;

/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameResultCopyWith<_GameResult> get copyWith => __$GameResultCopyWithImpl<_GameResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameResult&&(identical(other.points, points) || other.points == points)&&(identical(other.firstTry, firstTry) || other.firstTry == firstTry)&&(identical(other.total, total) || other.total == total)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.bestStars, bestStars) || other.bestStars == bestStars)&&(identical(other.perfect, perfect) || other.perfect == perfect)&&(identical(other.comboBonus, comboBonus) || other.comboBonus == comboBonus)&&(identical(other.replay, replay) || other.replay == replay)&&(identical(other.levelUp, levelUp) || other.levelUp == levelUp)&&(identical(other.nextLessonId, nextLessonId) || other.nextLessonId == nextLessonId)&&(identical(other.levelCompleted, levelCompleted) || other.levelCompleted == levelCompleted)&&(identical(other.player, player) || other.player == player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,points,firstTry,total,stars,bestStars,perfect,comboBonus,replay,levelUp,nextLessonId,levelCompleted,player);

@override
String toString() {
  return 'GameResult(points: $points, firstTry: $firstTry, total: $total, stars: $stars, bestStars: $bestStars, perfect: $perfect, comboBonus: $comboBonus, replay: $replay, levelUp: $levelUp, nextLessonId: $nextLessonId, levelCompleted: $levelCompleted, player: $player)';
}


}

/// @nodoc
abstract mixin class _$GameResultCopyWith<$Res> implements $GameResultCopyWith<$Res> {
  factory _$GameResultCopyWith(_GameResult value, $Res Function(_GameResult) _then) = __$GameResultCopyWithImpl;
@override @useResult
$Res call({
 int points, int firstTry, int total, int stars, int bestStars, bool perfect, int comboBonus, bool replay, bool levelUp, int? nextLessonId, bool levelCompleted, GamePlayer player
});


@override $GamePlayerCopyWith<$Res> get player;

}
/// @nodoc
class __$GameResultCopyWithImpl<$Res>
    implements _$GameResultCopyWith<$Res> {
  __$GameResultCopyWithImpl(this._self, this._then);

  final _GameResult _self;
  final $Res Function(_GameResult) _then;

/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? firstTry = null,Object? total = null,Object? stars = null,Object? bestStars = null,Object? perfect = null,Object? comboBonus = null,Object? replay = null,Object? levelUp = null,Object? nextLessonId = freezed,Object? levelCompleted = null,Object? player = null,}) {
  return _then(_GameResult(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,firstTry: null == firstTry ? _self.firstTry : firstTry // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,bestStars: null == bestStars ? _self.bestStars : bestStars // ignore: cast_nullable_to_non_nullable
as int,perfect: null == perfect ? _self.perfect : perfect // ignore: cast_nullable_to_non_nullable
as bool,comboBonus: null == comboBonus ? _self.comboBonus : comboBonus // ignore: cast_nullable_to_non_nullable
as int,replay: null == replay ? _self.replay : replay // ignore: cast_nullable_to_non_nullable
as bool,levelUp: null == levelUp ? _self.levelUp : levelUp // ignore: cast_nullable_to_non_nullable
as bool,nextLessonId: freezed == nextLessonId ? _self.nextLessonId : nextLessonId // ignore: cast_nullable_to_non_nullable
as int?,levelCompleted: null == levelCompleted ? _self.levelCompleted : levelCompleted // ignore: cast_nullable_to_non_nullable
as bool,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as GamePlayer,
  ));
}

/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GamePlayerCopyWith<$Res> get player {
  
  return $GamePlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// @nodoc
mixin _$GameLeaderboardEntry {

 int get rank; String get username; EventImage? get avatar; int get points;/// The line of the member who asks.
 bool get me;
/// Create a copy of GameLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameLeaderboardEntryCopyWith<GameLeaderboardEntry> get copyWith => _$GameLeaderboardEntryCopyWithImpl<GameLeaderboardEntry>(this as GameLeaderboardEntry, _$identity);

  /// Serializes this GameLeaderboardEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameLeaderboardEntry&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.points, points) || other.points == points)&&(identical(other.me, me) || other.me == me));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rank,username,avatar,points,me);

@override
String toString() {
  return 'GameLeaderboardEntry(rank: $rank, username: $username, avatar: $avatar, points: $points, me: $me)';
}


}

/// @nodoc
abstract mixin class $GameLeaderboardEntryCopyWith<$Res>  {
  factory $GameLeaderboardEntryCopyWith(GameLeaderboardEntry value, $Res Function(GameLeaderboardEntry) _then) = _$GameLeaderboardEntryCopyWithImpl;
@useResult
$Res call({
 int rank, String username, EventImage? avatar, int points, bool me
});


$EventImageCopyWith<$Res>? get avatar;

}
/// @nodoc
class _$GameLeaderboardEntryCopyWithImpl<$Res>
    implements $GameLeaderboardEntryCopyWith<$Res> {
  _$GameLeaderboardEntryCopyWithImpl(this._self, this._then);

  final GameLeaderboardEntry _self;
  final $Res Function(GameLeaderboardEntry) _then;

/// Create a copy of GameLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = null,Object? username = null,Object? avatar = freezed,Object? points = null,Object? me = null,}) {
  return _then(_self.copyWith(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as EventImage?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,me: null == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of GameLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get avatar {
    if (_self.avatar == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.avatar!, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameLeaderboardEntry].
extension GameLeaderboardEntryPatterns on GameLeaderboardEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameLeaderboardEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameLeaderboardEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameLeaderboardEntry value)  $default,){
final _that = this;
switch (_that) {
case _GameLeaderboardEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameLeaderboardEntry value)?  $default,){
final _that = this;
switch (_that) {
case _GameLeaderboardEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rank,  String username,  EventImage? avatar,  int points,  bool me)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameLeaderboardEntry() when $default != null:
return $default(_that.rank,_that.username,_that.avatar,_that.points,_that.me);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rank,  String username,  EventImage? avatar,  int points,  bool me)  $default,) {final _that = this;
switch (_that) {
case _GameLeaderboardEntry():
return $default(_that.rank,_that.username,_that.avatar,_that.points,_that.me);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rank,  String username,  EventImage? avatar,  int points,  bool me)?  $default,) {final _that = this;
switch (_that) {
case _GameLeaderboardEntry() when $default != null:
return $default(_that.rank,_that.username,_that.avatar,_that.points,_that.me);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameLeaderboardEntry implements GameLeaderboardEntry {
  const _GameLeaderboardEntry({required this.rank, required this.username, this.avatar, this.points = 0, this.me = false});
  factory _GameLeaderboardEntry.fromJson(Map<String, dynamic> json) => _$GameLeaderboardEntryFromJson(json);

@override final  int rank;
@override final  String username;
@override final  EventImage? avatar;
@override@JsonKey() final  int points;
/// The line of the member who asks.
@override@JsonKey() final  bool me;

/// Create a copy of GameLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameLeaderboardEntryCopyWith<_GameLeaderboardEntry> get copyWith => __$GameLeaderboardEntryCopyWithImpl<_GameLeaderboardEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameLeaderboardEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameLeaderboardEntry&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.points, points) || other.points == points)&&(identical(other.me, me) || other.me == me));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rank,username,avatar,points,me);

@override
String toString() {
  return 'GameLeaderboardEntry(rank: $rank, username: $username, avatar: $avatar, points: $points, me: $me)';
}


}

/// @nodoc
abstract mixin class _$GameLeaderboardEntryCopyWith<$Res> implements $GameLeaderboardEntryCopyWith<$Res> {
  factory _$GameLeaderboardEntryCopyWith(_GameLeaderboardEntry value, $Res Function(_GameLeaderboardEntry) _then) = __$GameLeaderboardEntryCopyWithImpl;
@override @useResult
$Res call({
 int rank, String username, EventImage? avatar, int points, bool me
});


@override $EventImageCopyWith<$Res>? get avatar;

}
/// @nodoc
class __$GameLeaderboardEntryCopyWithImpl<$Res>
    implements _$GameLeaderboardEntryCopyWith<$Res> {
  __$GameLeaderboardEntryCopyWithImpl(this._self, this._then);

  final _GameLeaderboardEntry _self;
  final $Res Function(_GameLeaderboardEntry) _then;

/// Create a copy of GameLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = null,Object? username = null,Object? avatar = freezed,Object? points = null,Object? me = null,}) {
  return _then(_GameLeaderboardEntry(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as EventImage?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,me: null == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of GameLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get avatar {
    if (_self.avatar == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.avatar!, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}
}


/// @nodoc
mixin _$GameStanding {

 int get rank; int get points;
/// Create a copy of GameStanding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStandingCopyWith<GameStanding> get copyWith => _$GameStandingCopyWithImpl<GameStanding>(this as GameStanding, _$identity);

  /// Serializes this GameStanding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStanding&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rank,points);

@override
String toString() {
  return 'GameStanding(rank: $rank, points: $points)';
}


}

/// @nodoc
abstract mixin class $GameStandingCopyWith<$Res>  {
  factory $GameStandingCopyWith(GameStanding value, $Res Function(GameStanding) _then) = _$GameStandingCopyWithImpl;
@useResult
$Res call({
 int rank, int points
});




}
/// @nodoc
class _$GameStandingCopyWithImpl<$Res>
    implements $GameStandingCopyWith<$Res> {
  _$GameStandingCopyWithImpl(this._self, this._then);

  final GameStanding _self;
  final $Res Function(GameStanding) _then;

/// Create a copy of GameStanding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = null,Object? points = null,}) {
  return _then(_self.copyWith(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GameStanding].
extension GameStandingPatterns on GameStanding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameStanding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameStanding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameStanding value)  $default,){
final _that = this;
switch (_that) {
case _GameStanding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameStanding value)?  $default,){
final _that = this;
switch (_that) {
case _GameStanding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rank,  int points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameStanding() when $default != null:
return $default(_that.rank,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rank,  int points)  $default,) {final _that = this;
switch (_that) {
case _GameStanding():
return $default(_that.rank,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rank,  int points)?  $default,) {final _that = this;
switch (_that) {
case _GameStanding() when $default != null:
return $default(_that.rank,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameStanding implements GameStanding {
  const _GameStanding({required this.rank, this.points = 0});
  factory _GameStanding.fromJson(Map<String, dynamic> json) => _$GameStandingFromJson(json);

@override final  int rank;
@override@JsonKey() final  int points;

/// Create a copy of GameStanding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStandingCopyWith<_GameStanding> get copyWith => __$GameStandingCopyWithImpl<_GameStanding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameStandingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameStanding&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rank,points);

@override
String toString() {
  return 'GameStanding(rank: $rank, points: $points)';
}


}

/// @nodoc
abstract mixin class _$GameStandingCopyWith<$Res> implements $GameStandingCopyWith<$Res> {
  factory _$GameStandingCopyWith(_GameStanding value, $Res Function(_GameStanding) _then) = __$GameStandingCopyWithImpl;
@override @useResult
$Res call({
 int rank, int points
});




}
/// @nodoc
class __$GameStandingCopyWithImpl<$Res>
    implements _$GameStandingCopyWith<$Res> {
  __$GameStandingCopyWithImpl(this._self, this._then);

  final _GameStanding _self;
  final $Res Function(_GameStanding) _then;

/// Create a copy of GameStanding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = null,Object? points = null,}) {
  return _then(_GameStanding(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$GameLeaderboard {

 String get period; String get scope; List<GameLeaderboardEntry> get entries;/// Null when the member is not in it (they said no, have not chosen
/// yet, or have no point over the period).
 GameStanding? get me;
/// Create a copy of GameLeaderboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameLeaderboardCopyWith<GameLeaderboard> get copyWith => _$GameLeaderboardCopyWithImpl<GameLeaderboard>(this as GameLeaderboard, _$identity);

  /// Serializes this GameLeaderboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameLeaderboard&&(identical(other.period, period) || other.period == period)&&(identical(other.scope, scope) || other.scope == scope)&&const DeepCollectionEquality().equals(other.entries, entries)&&(identical(other.me, me) || other.me == me));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,scope,const DeepCollectionEquality().hash(entries),me);

@override
String toString() {
  return 'GameLeaderboard(period: $period, scope: $scope, entries: $entries, me: $me)';
}


}

/// @nodoc
abstract mixin class $GameLeaderboardCopyWith<$Res>  {
  factory $GameLeaderboardCopyWith(GameLeaderboard value, $Res Function(GameLeaderboard) _then) = _$GameLeaderboardCopyWithImpl;
@useResult
$Res call({
 String period, String scope, List<GameLeaderboardEntry> entries, GameStanding? me
});


$GameStandingCopyWith<$Res>? get me;

}
/// @nodoc
class _$GameLeaderboardCopyWithImpl<$Res>
    implements $GameLeaderboardCopyWith<$Res> {
  _$GameLeaderboardCopyWithImpl(this._self, this._then);

  final GameLeaderboard _self;
  final $Res Function(GameLeaderboard) _then;

/// Create a copy of GameLeaderboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? scope = null,Object? entries = null,Object? me = freezed,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<GameLeaderboardEntry>,me: freezed == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as GameStanding?,
  ));
}
/// Create a copy of GameLeaderboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStandingCopyWith<$Res>? get me {
    if (_self.me == null) {
    return null;
  }

  return $GameStandingCopyWith<$Res>(_self.me!, (value) {
    return _then(_self.copyWith(me: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameLeaderboard].
extension GameLeaderboardPatterns on GameLeaderboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameLeaderboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameLeaderboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameLeaderboard value)  $default,){
final _that = this;
switch (_that) {
case _GameLeaderboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameLeaderboard value)?  $default,){
final _that = this;
switch (_that) {
case _GameLeaderboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String period,  String scope,  List<GameLeaderboardEntry> entries,  GameStanding? me)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameLeaderboard() when $default != null:
return $default(_that.period,_that.scope,_that.entries,_that.me);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String period,  String scope,  List<GameLeaderboardEntry> entries,  GameStanding? me)  $default,) {final _that = this;
switch (_that) {
case _GameLeaderboard():
return $default(_that.period,_that.scope,_that.entries,_that.me);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String period,  String scope,  List<GameLeaderboardEntry> entries,  GameStanding? me)?  $default,) {final _that = this;
switch (_that) {
case _GameLeaderboard() when $default != null:
return $default(_that.period,_that.scope,_that.entries,_that.me);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameLeaderboard implements GameLeaderboard {
  const _GameLeaderboard({this.period = 'week', this.scope = 'all', final  List<GameLeaderboardEntry> entries = const <GameLeaderboardEntry>[], this.me}): _entries = entries;
  factory _GameLeaderboard.fromJson(Map<String, dynamic> json) => _$GameLeaderboardFromJson(json);

@override@JsonKey() final  String period;
@override@JsonKey() final  String scope;
 final  List<GameLeaderboardEntry> _entries;
@override@JsonKey() List<GameLeaderboardEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

/// Null when the member is not in it (they said no, have not chosen
/// yet, or have no point over the period).
@override final  GameStanding? me;

/// Create a copy of GameLeaderboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameLeaderboardCopyWith<_GameLeaderboard> get copyWith => __$GameLeaderboardCopyWithImpl<_GameLeaderboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameLeaderboardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameLeaderboard&&(identical(other.period, period) || other.period == period)&&(identical(other.scope, scope) || other.scope == scope)&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.me, me) || other.me == me));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,scope,const DeepCollectionEquality().hash(_entries),me);

@override
String toString() {
  return 'GameLeaderboard(period: $period, scope: $scope, entries: $entries, me: $me)';
}


}

/// @nodoc
abstract mixin class _$GameLeaderboardCopyWith<$Res> implements $GameLeaderboardCopyWith<$Res> {
  factory _$GameLeaderboardCopyWith(_GameLeaderboard value, $Res Function(_GameLeaderboard) _then) = __$GameLeaderboardCopyWithImpl;
@override @useResult
$Res call({
 String period, String scope, List<GameLeaderboardEntry> entries, GameStanding? me
});


@override $GameStandingCopyWith<$Res>? get me;

}
/// @nodoc
class __$GameLeaderboardCopyWithImpl<$Res>
    implements _$GameLeaderboardCopyWith<$Res> {
  __$GameLeaderboardCopyWithImpl(this._self, this._then);

  final _GameLeaderboard _self;
  final $Res Function(_GameLeaderboard) _then;

/// Create a copy of GameLeaderboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? scope = null,Object? entries = null,Object? me = freezed,}) {
  return _then(_GameLeaderboard(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<GameLeaderboardEntry>,me: freezed == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as GameStanding?,
  ));
}

/// Create a copy of GameLeaderboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStandingCopyWith<$Res>? get me {
    if (_self.me == null) {
    return null;
  }

  return $GameStandingCopyWith<$Res>(_self.me!, (value) {
    return _then(_self.copyWith(me: value));
  });
}
}


/// @nodoc
mixin _$GameDaily {

/// Already done today.
 bool get done; List<GameQuestion> get questions;
/// Create a copy of GameDaily
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameDailyCopyWith<GameDaily> get copyWith => _$GameDailyCopyWithImpl<GameDaily>(this as GameDaily, _$identity);

  /// Serializes this GameDaily to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameDaily&&(identical(other.done, done) || other.done == done)&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,done,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'GameDaily(done: $done, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $GameDailyCopyWith<$Res>  {
  factory $GameDailyCopyWith(GameDaily value, $Res Function(GameDaily) _then) = _$GameDailyCopyWithImpl;
@useResult
$Res call({
 bool done, List<GameQuestion> questions
});




}
/// @nodoc
class _$GameDailyCopyWithImpl<$Res>
    implements $GameDailyCopyWith<$Res> {
  _$GameDailyCopyWithImpl(this._self, this._then);

  final GameDaily _self;
  final $Res Function(GameDaily) _then;

/// Create a copy of GameDaily
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? done = null,Object? questions = null,}) {
  return _then(_self.copyWith(
done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<GameQuestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameDaily].
extension GameDailyPatterns on GameDaily {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameDaily value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameDaily() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameDaily value)  $default,){
final _that = this;
switch (_that) {
case _GameDaily():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameDaily value)?  $default,){
final _that = this;
switch (_that) {
case _GameDaily() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool done,  List<GameQuestion> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameDaily() when $default != null:
return $default(_that.done,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool done,  List<GameQuestion> questions)  $default,) {final _that = this;
switch (_that) {
case _GameDaily():
return $default(_that.done,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool done,  List<GameQuestion> questions)?  $default,) {final _that = this;
switch (_that) {
case _GameDaily() when $default != null:
return $default(_that.done,_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameDaily implements GameDaily {
  const _GameDaily({this.done = false, final  List<GameQuestion> questions = const <GameQuestion>[]}): _questions = questions;
  factory _GameDaily.fromJson(Map<String, dynamic> json) => _$GameDailyFromJson(json);

/// Already done today.
@override@JsonKey() final  bool done;
 final  List<GameQuestion> _questions;
@override@JsonKey() List<GameQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of GameDaily
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameDailyCopyWith<_GameDaily> get copyWith => __$GameDailyCopyWithImpl<_GameDaily>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameDailyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameDaily&&(identical(other.done, done) || other.done == done)&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,done,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'GameDaily(done: $done, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$GameDailyCopyWith<$Res> implements $GameDailyCopyWith<$Res> {
  factory _$GameDailyCopyWith(_GameDaily value, $Res Function(_GameDaily) _then) = __$GameDailyCopyWithImpl;
@override @useResult
$Res call({
 bool done, List<GameQuestion> questions
});




}
/// @nodoc
class __$GameDailyCopyWithImpl<$Res>
    implements _$GameDailyCopyWith<$Res> {
  __$GameDailyCopyWithImpl(this._self, this._then);

  final _GameDaily _self;
  final $Res Function(_GameDaily) _then;

/// Create a copy of GameDaily
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? done = null,Object? questions = null,}) {
  return _then(_GameDaily(
done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<GameQuestion>,
  ));
}


}


/// @nodoc
mixin _$GameDailyResult {

 int get points; int get firstTry; int get total; bool get levelUp; GamePlayer get player;
/// Create a copy of GameDailyResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameDailyResultCopyWith<GameDailyResult> get copyWith => _$GameDailyResultCopyWithImpl<GameDailyResult>(this as GameDailyResult, _$identity);

  /// Serializes this GameDailyResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameDailyResult&&(identical(other.points, points) || other.points == points)&&(identical(other.firstTry, firstTry) || other.firstTry == firstTry)&&(identical(other.total, total) || other.total == total)&&(identical(other.levelUp, levelUp) || other.levelUp == levelUp)&&(identical(other.player, player) || other.player == player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,points,firstTry,total,levelUp,player);

@override
String toString() {
  return 'GameDailyResult(points: $points, firstTry: $firstTry, total: $total, levelUp: $levelUp, player: $player)';
}


}

/// @nodoc
abstract mixin class $GameDailyResultCopyWith<$Res>  {
  factory $GameDailyResultCopyWith(GameDailyResult value, $Res Function(GameDailyResult) _then) = _$GameDailyResultCopyWithImpl;
@useResult
$Res call({
 int points, int firstTry, int total, bool levelUp, GamePlayer player
});


$GamePlayerCopyWith<$Res> get player;

}
/// @nodoc
class _$GameDailyResultCopyWithImpl<$Res>
    implements $GameDailyResultCopyWith<$Res> {
  _$GameDailyResultCopyWithImpl(this._self, this._then);

  final GameDailyResult _self;
  final $Res Function(GameDailyResult) _then;

/// Create a copy of GameDailyResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? firstTry = null,Object? total = null,Object? levelUp = null,Object? player = null,}) {
  return _then(_self.copyWith(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,firstTry: null == firstTry ? _self.firstTry : firstTry // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,levelUp: null == levelUp ? _self.levelUp : levelUp // ignore: cast_nullable_to_non_nullable
as bool,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as GamePlayer,
  ));
}
/// Create a copy of GameDailyResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GamePlayerCopyWith<$Res> get player {
  
  return $GamePlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameDailyResult].
extension GameDailyResultPatterns on GameDailyResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameDailyResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameDailyResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameDailyResult value)  $default,){
final _that = this;
switch (_that) {
case _GameDailyResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameDailyResult value)?  $default,){
final _that = this;
switch (_that) {
case _GameDailyResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int points,  int firstTry,  int total,  bool levelUp,  GamePlayer player)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameDailyResult() when $default != null:
return $default(_that.points,_that.firstTry,_that.total,_that.levelUp,_that.player);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int points,  int firstTry,  int total,  bool levelUp,  GamePlayer player)  $default,) {final _that = this;
switch (_that) {
case _GameDailyResult():
return $default(_that.points,_that.firstTry,_that.total,_that.levelUp,_that.player);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int points,  int firstTry,  int total,  bool levelUp,  GamePlayer player)?  $default,) {final _that = this;
switch (_that) {
case _GameDailyResult() when $default != null:
return $default(_that.points,_that.firstTry,_that.total,_that.levelUp,_that.player);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameDailyResult implements GameDailyResult {
  const _GameDailyResult({this.points = 0, this.firstTry = 0, this.total = 0, this.levelUp = false, this.player = const GamePlayer()});
  factory _GameDailyResult.fromJson(Map<String, dynamic> json) => _$GameDailyResultFromJson(json);

@override@JsonKey() final  int points;
@override@JsonKey() final  int firstTry;
@override@JsonKey() final  int total;
@override@JsonKey() final  bool levelUp;
@override@JsonKey() final  GamePlayer player;

/// Create a copy of GameDailyResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameDailyResultCopyWith<_GameDailyResult> get copyWith => __$GameDailyResultCopyWithImpl<_GameDailyResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameDailyResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameDailyResult&&(identical(other.points, points) || other.points == points)&&(identical(other.firstTry, firstTry) || other.firstTry == firstTry)&&(identical(other.total, total) || other.total == total)&&(identical(other.levelUp, levelUp) || other.levelUp == levelUp)&&(identical(other.player, player) || other.player == player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,points,firstTry,total,levelUp,player);

@override
String toString() {
  return 'GameDailyResult(points: $points, firstTry: $firstTry, total: $total, levelUp: $levelUp, player: $player)';
}


}

/// @nodoc
abstract mixin class _$GameDailyResultCopyWith<$Res> implements $GameDailyResultCopyWith<$Res> {
  factory _$GameDailyResultCopyWith(_GameDailyResult value, $Res Function(_GameDailyResult) _then) = __$GameDailyResultCopyWithImpl;
@override @useResult
$Res call({
 int points, int firstTry, int total, bool levelUp, GamePlayer player
});


@override $GamePlayerCopyWith<$Res> get player;

}
/// @nodoc
class __$GameDailyResultCopyWithImpl<$Res>
    implements _$GameDailyResultCopyWith<$Res> {
  __$GameDailyResultCopyWithImpl(this._self, this._then);

  final _GameDailyResult _self;
  final $Res Function(_GameDailyResult) _then;

/// Create a copy of GameDailyResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? firstTry = null,Object? total = null,Object? levelUp = null,Object? player = null,}) {
  return _then(_GameDailyResult(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,firstTry: null == firstTry ? _self.firstTry : firstTry // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,levelUp: null == levelUp ? _self.levelUp : levelUp // ignore: cast_nullable_to_non_nullable
as bool,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as GamePlayer,
  ));
}

/// Create a copy of GameDailyResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GamePlayerCopyWith<$Res> get player {
  
  return $GamePlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}

// dart format on
