// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_of_the_day.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The calendar of [language], read once from the assets.

@ProviderFor(verseCalendar)
final verseCalendarProvider = VerseCalendarFamily._();

/// The calendar of [language], read once from the assets.

final class VerseCalendarProvider
    extends
        $FunctionalProvider<
          AsyncValue<VerseCalendar>,
          VerseCalendar,
          FutureOr<VerseCalendar>
        >
    with $FutureModifier<VerseCalendar>, $FutureProvider<VerseCalendar> {
  /// The calendar of [language], read once from the assets.
  VerseCalendarProvider._({
    required VerseCalendarFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'verseCalendarProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$verseCalendarHash();

  @override
  String toString() {
    return r'verseCalendarProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<VerseCalendar> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VerseCalendar> create(Ref ref) {
    final argument = this.argument as String;
    return verseCalendar(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VerseCalendarProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$verseCalendarHash() => r'163ea02966e71a16c2396f8393288b31bca99a70';

/// The calendar of [language], read once from the assets.

final class VerseCalendarFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<VerseCalendar>, String> {
  VerseCalendarFamily._()
    : super(
        retry: null,
        name: r'verseCalendarProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// The calendar of [language], read once from the assets.

  VerseCalendarProvider call(String language) =>
      VerseCalendarProvider._(argument: language, from: this);

  @override
  String toString() => r'verseCalendarProvider';
}

/// Today's verse in the app's language (the same for everyone that day).

@ProviderFor(verseOfTheDay)
final verseOfTheDayProvider = VerseOfTheDayProvider._();

/// Today's verse in the app's language (the same for everyone that day).

final class VerseOfTheDayProvider
    extends $FunctionalProvider<AsyncValue<Verse?>, Verse?, FutureOr<Verse?>>
    with $FutureModifier<Verse?>, $FutureProvider<Verse?> {
  /// Today's verse in the app's language (the same for everyone that day).
  VerseOfTheDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verseOfTheDayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verseOfTheDayHash();

  @$internal
  @override
  $FutureProviderElement<Verse?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Verse?> create(Ref ref) {
    return verseOfTheDay(ref);
  }
}

String _$verseOfTheDayHash() => r'2f44f3013d3b1ff479bb6dba05f924945a89b4b8';
