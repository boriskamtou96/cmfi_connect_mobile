// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_story.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "Ton année avec Dieu" for [year]: its reports (the server gives 366 days
/// at most), whether the member was there in the December before, the items,
/// the goals, the retreats and the verses learnt by heart.

@ProviderFor(yearStory)
final yearStoryProvider = YearStoryFamily._();

/// "Ton année avec Dieu" for [year]: its reports (the server gives 366 days
/// at most), whether the member was there in the December before, the items,
/// the goals, the retreats and the verses learnt by heart.

final class YearStoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<YearStory>,
          YearStory,
          FutureOr<YearStory>
        >
    with $FutureModifier<YearStory>, $FutureProvider<YearStory> {
  /// "Ton année avec Dieu" for [year]: its reports (the server gives 366 days
  /// at most), whether the member was there in the December before, the items,
  /// the goals, the retreats and the verses learnt by heart.
  YearStoryProvider._({
    required YearStoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'yearStoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$yearStoryHash();

  @override
  String toString() {
    return r'yearStoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<YearStory> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<YearStory> create(Ref ref) {
    final argument = this.argument as int;
    return yearStory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is YearStoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$yearStoryHash() => r'dd1284c8418292004493dff2dfdf9f1f8032d44d';

/// "Ton année avec Dieu" for [year]: its reports (the server gives 366 days
/// at most), whether the member was there in the December before, the items,
/// the goals, the retreats and the verses learnt by heart.

final class YearStoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<YearStory>, int> {
  YearStoryFamily._()
    : super(
        retry: null,
        name: r'yearStoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// "Ton année avec Dieu" for [year]: its reports (the server gives 366 days
  /// at most), whether the member was there in the December before, the items,
  /// the goals, the retreats and the verses learnt by heart.

  YearStoryProvider call(int year) =>
      YearStoryProvider._(argument: year, from: this);

  @override
  String toString() => r'yearStoryProvider';
}
