// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_story.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "Ta semaine avec Dieu" for the week starting on [monday]: the reports of
/// the year before (for the streaks), the items, the goals and the retreats.

@ProviderFor(weekStory)
final weekStoryProvider = WeekStoryFamily._();

/// "Ta semaine avec Dieu" for the week starting on [monday]: the reports of
/// the year before (for the streaks), the items, the goals and the retreats.

final class WeekStoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<WeekStory>,
          WeekStory,
          FutureOr<WeekStory>
        >
    with $FutureModifier<WeekStory>, $FutureProvider<WeekStory> {
  /// "Ta semaine avec Dieu" for the week starting on [monday]: the reports of
  /// the year before (for the streaks), the items, the goals and the retreats.
  WeekStoryProvider._({
    required WeekStoryFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'weekStoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$weekStoryHash();

  @override
  String toString() {
    return r'weekStoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WeekStory> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<WeekStory> create(Ref ref) {
    final argument = this.argument as DateTime;
    return weekStory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WeekStoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weekStoryHash() => r'ceb07774f80413bf8f4a2f4f12d6acf2ccd7597f';

/// "Ta semaine avec Dieu" for the week starting on [monday]: the reports of
/// the year before (for the streaks), the items, the goals and the retreats.

final class WeekStoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WeekStory>, DateTime> {
  WeekStoryFamily._()
    : super(
        retry: null,
        name: r'weekStoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// "Ta semaine avec Dieu" for the week starting on [monday]: the reports of
  /// the year before (for the streaks), the items, the goals and the retreats.

  WeekStoryProvider call(DateTime monday) =>
      WeekStoryProvider._(argument: monday, from: this);

  @override
  String toString() => r'weekStoryProvider';
}
