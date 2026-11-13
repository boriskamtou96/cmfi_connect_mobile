// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Plays lesson [lessonId]: loads its questions (shuffled), takes the
/// answers, and sends the play once every question is settled. The server
/// counts the points.

@ProviderFor(LessonController)
final lessonControllerProvider = LessonControllerFamily._();

/// Plays lesson [lessonId]: loads its questions (shuffled), takes the
/// answers, and sends the play once every question is settled. The server
/// counts the points.
final class LessonControllerProvider
    extends $AsyncNotifierProvider<LessonController, LessonSession> {
  /// Plays lesson [lessonId]: loads its questions (shuffled), takes the
  /// answers, and sends the play once every question is settled. The server
  /// counts the points.
  LessonControllerProvider._({
    required LessonControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'lessonControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lessonControllerHash();

  @override
  String toString() {
    return r'lessonControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LessonController create() => LessonController();

  @override
  bool operator ==(Object other) {
    return other is LessonControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lessonControllerHash() => r'2f9b1c590322067e1a19c38621475199b4f98f33';

/// Plays lesson [lessonId]: loads its questions (shuffled), takes the
/// answers, and sends the play once every question is settled. The server
/// counts the points.

final class LessonControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          LessonController,
          AsyncValue<LessonSession>,
          LessonSession,
          FutureOr<LessonSession>,
          int
        > {
  LessonControllerFamily._()
    : super(
        retry: null,
        name: r'lessonControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Plays lesson [lessonId]: loads its questions (shuffled), takes the
  /// answers, and sends the play once every question is settled. The server
  /// counts the points.

  LessonControllerProvider call(int lessonId) =>
      LessonControllerProvider._(argument: lessonId, from: this);

  @override
  String toString() => r'lessonControllerProvider';
}

/// Plays lesson [lessonId]: loads its questions (shuffled), takes the
/// answers, and sends the play once every question is settled. The server
/// counts the points.

abstract class _$LessonController extends $AsyncNotifier<LessonSession> {
  late final _$args = ref.$arg as int;
  int get lessonId => _$args;

  FutureOr<LessonSession> build(int lessonId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LessonSession>, LessonSession>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LessonSession>, LessonSession>,
              AsyncValue<LessonSession>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
