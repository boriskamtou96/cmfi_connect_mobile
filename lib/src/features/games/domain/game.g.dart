// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameCourse _$GameCourseFromJson(Map<String, dynamic> json) =>
    _GameCourse(code: json['code'] as String, title: json['title'] as String);

Map<String, dynamic> _$GameCourseToJson(_GameCourse instance) =>
    <String, dynamic>{'code': instance.code, 'title': instance.title};

_GamePlayer _$GamePlayerFromJson(Map<String, dynamic> json) => _GamePlayer(
  totalPoints: (json['total_points'] as num?)?.toInt() ?? 0,
  level: (json['level'] as num?)?.toInt() ?? 1,
  levelFloor: (json['level_floor'] as num?)?.toInt() ?? 0,
  nextLevelAt: (json['next_level_at'] as num?)?.toInt() ?? 200,
  streakDays: (json['streak_days'] as num?)?.toInt() ?? 0,
  playedToday: json['played_today'] as bool? ?? false,
  dailyGoal: (json['daily_goal'] as num?)?.toInt() ?? 50,
  pointsToday: (json['points_today'] as num?)?.toInt() ?? 0,
  inLeaderboard: json['in_leaderboard'] as bool?,
  weekRank: (json['week_rank'] as num?)?.toInt(),
  dailyDone: json['daily_done'] as bool? ?? false,
);

Map<String, dynamic> _$GamePlayerToJson(_GamePlayer instance) =>
    <String, dynamic>{
      'total_points': instance.totalPoints,
      'level': instance.level,
      'level_floor': instance.levelFloor,
      'next_level_at': instance.nextLevelAt,
      'streak_days': instance.streakDays,
      'played_today': instance.playedToday,
      'daily_goal': instance.dailyGoal,
      'points_today': instance.pointsToday,
      'in_leaderboard': ?instance.inLeaderboard,
      'week_rank': ?instance.weekRank,
      'daily_done': instance.dailyDone,
    };

_GameLessonSummary _$GameLessonSummaryFromJson(Map<String, dynamic> json) =>
    _GameLessonSummary(
      id: (json['id'] as num).toInt(),
      position: (json['position'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
      state:
          $enumDecodeNullable(
            _$LessonStateEnumMap,
            json['state'],
            unknownValue: LessonState.locked,
          ) ??
          LessonState.locked,
      stars: (json['stars'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GameLessonSummaryToJson(_GameLessonSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'title': instance.title,
      'state': _$LessonStateEnumMap[instance.state]!,
      'stars': instance.stars,
    };

const _$LessonStateEnumMap = {
  LessonState.done: 'done',
  LessonState.open: 'open',
  LessonState.locked: 'locked',
};

_GameLevel _$GameLevelFromJson(Map<String, dynamic> json) => _GameLevel(
  id: (json['id'] as num).toInt(),
  position: (json['position'] as num?)?.toInt() ?? 0,
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  color: json['color'] as String? ?? '#0B3B70',
  lessons:
      (json['lessons'] as List<dynamic>?)
          ?.map((e) => GameLessonSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GameLessonSummary>[],
);

Map<String, dynamic> _$GameLevelToJson(_GameLevel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'title': instance.title,
      'description': instance.description,
      'color': instance.color,
      'lessons': instance.lessons.map((e) => e.toJson()).toList(),
    };

_GamePath _$GamePathFromJson(Map<String, dynamic> json) => _GamePath(
  courses:
      (json['courses'] as List<dynamic>?)
          ?.map((e) => GameCourse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GameCourse>[],
  course: json['course'] as String,
  player: json['player'] == null
      ? const GamePlayer()
      : GamePlayer.fromJson(json['player'] as Map<String, dynamic>),
  levels:
      (json['levels'] as List<dynamic>?)
          ?.map((e) => GameLevel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GameLevel>[],
);

Map<String, dynamic> _$GamePathToJson(_GamePath instance) => <String, dynamic>{
  'courses': instance.courses.map((e) => e.toJson()).toList(),
  'course': instance.course,
  'player': instance.player.toJson(),
  'levels': instance.levels.map((e) => e.toJson()).toList(),
};

_GameChoice _$GameChoiceFromJson(Map<String, dynamic> json) =>
    _GameChoice(id: json['id'] as String, text: json['text'] as String);

Map<String, dynamic> _$GameChoiceToJson(_GameChoice instance) =>
    <String, dynamic>{'id': instance.id, 'text': instance.text};

_GameQuestion _$GameQuestionFromJson(Map<String, dynamic> json) =>
    _GameQuestion(
      id: (json['id'] as num).toInt(),
      kind: json['kind'] as String? ?? 'choice',
      prompt: json['prompt'] as String,
      choices:
          (json['choices'] as List<dynamic>?)
              ?.map((e) => GameChoice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GameChoice>[],
      answer: json['answer'] as String,
      explanation: json['explanation'] as String? ?? '',
      source: json['source'] as String? ?? '',
    );

Map<String, dynamic> _$GameQuestionToJson(_GameQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'prompt': instance.prompt,
      'choices': instance.choices.map((e) => e.toJson()).toList(),
      'answer': instance.answer,
      'explanation': instance.explanation,
      'source': instance.source,
    };

_GameLesson _$GameLessonFromJson(Map<String, dynamic> json) => _GameLesson(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  levelTitle: json['level_title'] as String? ?? '',
  course: json['course'] as String? ?? '',
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => GameQuestion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GameQuestion>[],
);

Map<String, dynamic> _$GameLessonToJson(_GameLesson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'level_title': instance.levelTitle,
      'course': instance.course,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

_GameAnswer _$GameAnswerFromJson(Map<String, dynamic> json) => _GameAnswer(
  questionId: (json['question_id'] as num).toInt(),
  choice: json['choice'] as String,
  attempt: (json['attempt'] as num).toInt(),
);

Map<String, dynamic> _$GameAnswerToJson(_GameAnswer instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'choice': instance.choice,
      'attempt': instance.attempt,
    };

_GameResult _$GameResultFromJson(Map<String, dynamic> json) => _GameResult(
  points: (json['points'] as num?)?.toInt() ?? 0,
  firstTry: (json['first_try'] as num?)?.toInt() ?? 0,
  total: (json['total'] as num?)?.toInt() ?? 0,
  stars: (json['stars'] as num?)?.toInt() ?? 1,
  bestStars: (json['best_stars'] as num?)?.toInt() ?? 1,
  perfect: json['perfect'] as bool? ?? false,
  comboBonus: (json['combo_bonus'] as num?)?.toInt() ?? 0,
  replay: json['replay'] as bool? ?? false,
  levelUp: json['level_up'] as bool? ?? false,
  nextLessonId: (json['next_lesson_id'] as num?)?.toInt(),
  levelCompleted: json['level_completed'] as bool? ?? false,
  player: json['player'] == null
      ? const GamePlayer()
      : GamePlayer.fromJson(json['player'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GameResultToJson(_GameResult instance) =>
    <String, dynamic>{
      'points': instance.points,
      'first_try': instance.firstTry,
      'total': instance.total,
      'stars': instance.stars,
      'best_stars': instance.bestStars,
      'perfect': instance.perfect,
      'combo_bonus': instance.comboBonus,
      'replay': instance.replay,
      'level_up': instance.levelUp,
      'next_lesson_id': ?instance.nextLessonId,
      'level_completed': instance.levelCompleted,
      'player': instance.player.toJson(),
    };

_GameLeaderboardEntry _$GameLeaderboardEntryFromJson(
  Map<String, dynamic> json,
) => _GameLeaderboardEntry(
  rank: (json['rank'] as num).toInt(),
  username: json['username'] as String,
  avatar: json['avatar'] == null
      ? null
      : EventImage.fromJson(json['avatar'] as Map<String, dynamic>),
  points: (json['points'] as num?)?.toInt() ?? 0,
  me: json['me'] as bool? ?? false,
);

Map<String, dynamic> _$GameLeaderboardEntryToJson(
  _GameLeaderboardEntry instance,
) => <String, dynamic>{
  'rank': instance.rank,
  'username': instance.username,
  'avatar': ?instance.avatar?.toJson(),
  'points': instance.points,
  'me': instance.me,
};

_GameStanding _$GameStandingFromJson(Map<String, dynamic> json) =>
    _GameStanding(
      rank: (json['rank'] as num).toInt(),
      points: (json['points'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GameStandingToJson(_GameStanding instance) =>
    <String, dynamic>{'rank': instance.rank, 'points': instance.points};

_GameLeaderboard _$GameLeaderboardFromJson(Map<String, dynamic> json) =>
    _GameLeaderboard(
      period: json['period'] as String? ?? 'week',
      scope: json['scope'] as String? ?? 'all',
      entries:
          (json['entries'] as List<dynamic>?)
              ?.map(
                (e) => GameLeaderboardEntry.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <GameLeaderboardEntry>[],
      me: json['me'] == null
          ? null
          : GameStanding.fromJson(json['me'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameLeaderboardToJson(_GameLeaderboard instance) =>
    <String, dynamic>{
      'period': instance.period,
      'scope': instance.scope,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
      'me': ?instance.me?.toJson(),
    };

_GameDaily _$GameDailyFromJson(Map<String, dynamic> json) => _GameDaily(
  done: json['done'] as bool? ?? false,
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => GameQuestion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GameQuestion>[],
);

Map<String, dynamic> _$GameDailyToJson(_GameDaily instance) =>
    <String, dynamic>{
      'done': instance.done,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

_GameDailyResult _$GameDailyResultFromJson(Map<String, dynamic> json) =>
    _GameDailyResult(
      points: (json['points'] as num?)?.toInt() ?? 0,
      firstTry: (json['first_try'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      levelUp: json['level_up'] as bool? ?? false,
      player: json['player'] == null
          ? const GamePlayer()
          : GamePlayer.fromJson(json['player'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameDailyResultToJson(_GameDailyResult instance) =>
    <String, dynamic>{
      'points': instance.points,
      'first_try': instance.firstTry,
      'total': instance.total,
      'level_up': instance.levelUp,
      'player': instance.player.toJson(),
    };
