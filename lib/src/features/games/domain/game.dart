import 'package:freezed_annotation/freezed_annotation.dart';

import '../../events/domain/event.dart';

part 'game.freezed.dart';
part 'game.g.dart';

/// The id that stands for the challenge of the day: played and sent like
/// a lesson, from its own routes of the API.
const dailyLessonId = 0;

/// A course of the games: « Notre ministère », « La Bible ».
@freezed
abstract class GameCourse with _$GameCourse {
  const factory GameCourse({required String code, required String title}) =
      _GameCourse;

  factory GameCourse.fromJson(Map<String, dynamic> json) =>
      _$GameCourseFromJson(json);
}

/// The member as a player: what the top of the tab shows.
@freezed
abstract class GamePlayer with _$GamePlayer {
  const factory GamePlayer({
    @Default(0) int totalPoints,

    /// Their level, the points where it began and those of the next one.
    @Default(1) int level,
    @Default(0) int levelFloor,
    @Default(200) int nextLevelAt,

    /// The days played in a row (0 once broken).
    @Default(0) int streakDays,
    @Default(false) bool playedToday,
    @Default(50) int dailyGoal,
    @Default(0) int pointsToday,

    /// Null until they chose to appear in the leaderboard or not.
    bool? inLeaderboard,
    int? weekRank,
    @Default(false) bool dailyDone,
  }) = _GamePlayer;

  factory GamePlayer.fromJson(Map<String, dynamic> json) =>
      _$GamePlayerFromJson(json);
}

/// Where a lesson stands on the path of the member.
enum LessonState {
  @JsonValue('done')
  done,
  @JsonValue('open')
  open,
  @JsonValue('locked')
  locked,
}

/// A lesson on the path.
@freezed
abstract class GameLessonSummary with _$GameLessonSummary {
  const factory GameLessonSummary({
    required int id,
    @Default(0) int position,
    required String title,
    @JsonKey(unknownEnumValue: LessonState.locked)
    @Default(LessonState.locked)
    LessonState state,

    /// The best play of the lesson: 1 to 3, 0 before.
    @Default(0) int stars,
  }) = _GameLessonSummary;

  factory GameLessonSummary.fromJson(Map<String, dynamic> json) =>
      _$GameLessonSummaryFromJson(json);
}

/// A level of a course: a theme, its lessons in order.
@freezed
abstract class GameLevel with _$GameLevel {
  const factory GameLevel({
    required int id,
    @Default(0) int position,
    required String title,
    @Default('') String description,

    /// The color of its banner, #RRGGBB.
    @Default('#0B3B70') String color,
    @Default(<GameLessonSummary>[]) List<GameLessonSummary> lessons,
  }) = _GameLevel;

  factory GameLevel.fromJson(Map<String, dynamic> json) =>
      _$GameLevelFromJson(json);
}

/// The tab: the courses, and the path of one of them (GET /v1/games/path).
@freezed
abstract class GamePath with _$GamePath {
  const factory GamePath({
    @Default(<GameCourse>[]) List<GameCourse> courses,

    /// The code of the course shown.
    required String course,
    @Default(GamePlayer()) GamePlayer player,
    @Default(<GameLevel>[]) List<GameLevel> levels,

    /// Read from the copy of the phone, without network (never from the
    /// server).
    @Default(false) bool offline,
  }) = _GamePath;

  factory GamePath.fromJson(Map<String, dynamic> json) =>
      _$GamePathFromJson(json);
}

/// [path] as the phone sees it while plays wait to be sent: the lessons in
/// [played] are done (one star until the server counts them), and the
/// lessons open again one after the other.
GamePath withPlayedOffline(GamePath path, Set<int> played) {
  if (played.isEmpty) {
    return path;
  }
  var previousDone = true;
  return path.copyWith(
    levels: [
      for (final level in path.levels)
        level.copyWith(
          lessons: [
            for (final lesson in level.lessons)
              () {
                final done =
                    lesson.state == LessonState.done ||
                    played.contains(lesson.id);
                final state = done
                    ? LessonState.done
                    : previousDone
                    ? LessonState.open
                    : LessonState.locked;
                previousDone = done;
                return lesson.copyWith(
                  state: state,
                  stars: done && lesson.stars == 0 ? 1 : lesson.stars,
                );
              }(),
          ],
        ),
    ],
  );
}

@freezed
abstract class GameChoice with _$GameChoice {
  const factory GameChoice({required String id, required String text}) =
      _GameChoice;

  factory GameChoice.fromJson(Map<String, dynamic> json) =>
      _$GameChoiceFromJson(json);
}

/// A question: its choices, the right one ([answer], the id of a choice),
/// why, and where it comes from.
@freezed
abstract class GameQuestion with _$GameQuestion {
  const factory GameQuestion({
    required int id,
    @Default('choice') String kind,
    required String prompt,
    @Default(<GameChoice>[]) List<GameChoice> choices,
    required String answer,
    @Default('') String explanation,
    @Default('') String source,
  }) = _GameQuestion;

  factory GameQuestion.fromJson(Map<String, dynamic> json) =>
      _$GameQuestionFromJson(json);
}

/// The kinds of questions beyond a single choice: « order » (put the things
/// in order; [GameQuestion.answer] is their ids in the right order, "c,a,d,b")
/// and « match » (link pairs, ids l1… on the left and r1… on the right; the
/// answer is "l1=r2,l2=r1,…", by left id).
extension GameQuestionKinds on GameQuestion {
  bool get isOrder => kind == 'order';
  bool get isMatch => kind == 'match';

  String _text(String id) => choices
      .firstWhere(
        (choice) => choice.id == id,
        orElse: () => GameChoice(id: id, text: id),
      )
      .text;

  /// The right answer in words: the choice, the things in order
  /// (« A → B → C »), or the pairs (« Noé — L'arche · … »).
  String get answerText {
    if (isOrder) {
      return answer.split(',').map(_text).join(' → ');
    }
    if (isMatch) {
      return answer
          .split(',')
          .map((pair) {
            final [left, right] = pair.split('=');
            return '${_text(left)} — ${_text(right)}';
          })
          .join(' · ');
    }
    return _text(answer);
  }
}

/// The answer of a match, its pairs written by left id as the server keeps
/// them ("l1=r2,l2=r1,…").
String matchAnswer(Map<String, String> pairs) =>
    (pairs.entries.map((pair) => '${pair.key}=${pair.value}').toList()..sort())
        .join(',');

/// A lesson to play (GET /v1/games/lessons/:id).
@freezed
abstract class GameLesson with _$GameLesson {
  const factory GameLesson({
    required int id,
    required String title,
    @Default('') String levelTitle,
    @Default('') String course,
    @Default(<GameQuestion>[]) List<GameQuestion> questions,
  }) = _GameLesson;

  factory GameLesson.fromJson(Map<String, dynamic> json) =>
      _$GameLessonFromJson(json);
}

/// One answer of a play, in the order given: a question answered wrong comes
/// back once ([attempt] 2).
@freezed
abstract class GameAnswer with _$GameAnswer {
  const factory GameAnswer({
    required int questionId,
    required String choice,
    required int attempt,
  }) = _GameAnswer;

  factory GameAnswer.fromJson(Map<String, dynamic> json) =>
      _$GameAnswerFromJson(json);
}

/// What a lesson played gave, counted by the server.
@freezed
abstract class GameResult with _$GameResult {
  const factory GameResult({
    @Default(0) int points,
    @Default(0) int firstTry,
    @Default(0) int total,
    @Default(1) int stars,
    @Default(1) int bestStars,
    @Default(false) bool perfect,
    @Default(0) int comboBonus,

    /// The lesson was already done: few points, capped by day.
    @Default(false) bool replay,
    @Default(false) bool levelUp,
    int? nextLessonId,
    @Default(false) bool levelCompleted,
    @Default(GamePlayer()) GamePlayer player,
  }) = _GameResult;

  factory GameResult.fromJson(Map<String, dynamic> json) =>
      _$GameResultFromJson(json);
}

/// A line of the leaderboard: a pseudo and a photo, never a name.
@freezed
abstract class GameLeaderboardEntry with _$GameLeaderboardEntry {
  const factory GameLeaderboardEntry({
    required int rank,
    required String username,
    EventImage? avatar,
    @Default(0) int points,

    /// The line of the member who asks.
    @Default(false) bool me,
  }) = _GameLeaderboardEntry;

  factory GameLeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$GameLeaderboardEntryFromJson(json);
}

/// Where the member stands in a leaderboard.
@freezed
abstract class GameStanding with _$GameStanding {
  const factory GameStanding({required int rank, @Default(0) int points}) =
      _GameStanding;

  factory GameStanding.fromJson(Map<String, dynamic> json) =>
      _$GameStandingFromJson(json);
}

/// The leaderboard (GET /v1/games/leaderboard): the 50 first of those who
/// chose to appear, over a period and a scope.
@freezed
abstract class GameLeaderboard with _$GameLeaderboard {
  const factory GameLeaderboard({
    @Default('week') String period,
    @Default('all') String scope,
    @Default(<GameLeaderboardEntry>[]) List<GameLeaderboardEntry> entries,

    /// Null when the member is not in it (they said no, have not chosen
    /// yet, or have no point over the period).
    GameStanding? me,
  }) = _GameLeaderboard;

  factory GameLeaderboard.fromJson(Map<String, dynamic> json) =>
      _$GameLeaderboardFromJson(json);
}

/// The challenge of the day: 5 questions drawn from the lessons done.
@freezed
abstract class GameDaily with _$GameDaily {
  const factory GameDaily({
    /// Already done today.
    @Default(false) bool done,
    @Default(<GameQuestion>[]) List<GameQuestion> questions,
  }) = _GameDaily;

  factory GameDaily.fromJson(Map<String, dynamic> json) =>
      _$GameDailyFromJson(json);
}

/// What the challenge of the day gave: 15 points the first time of the day.
@freezed
abstract class GameDailyResult with _$GameDailyResult {
  const factory GameDailyResult({
    @Default(0) int points,
    @Default(0) int firstTry,
    @Default(0) int total,
    @Default(false) bool levelUp,
    @Default(GamePlayer()) GamePlayer player,
  }) = _GameDailyResult;

  factory GameDailyResult.fromJson(Map<String, dynamic> json) =>
      _$GameDailyResultFromJson(json);
}
