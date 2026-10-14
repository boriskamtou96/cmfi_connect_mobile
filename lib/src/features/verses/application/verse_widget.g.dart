// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_widget.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The "Verset du jour" widget's verses, from today, in the app language.
/// Free and without account: App hands them to the phone at each launch.

@ProviderFor(verseWidget)
final verseWidgetProvider = VerseWidgetProvider._();

/// The "Verset du jour" widget's verses, from today, in the app language.
/// Free and without account: App hands them to the phone at each launch.

final class VerseWidgetProvider
    extends
        $FunctionalProvider<
          AsyncValue<VerseWidgetData>,
          VerseWidgetData,
          FutureOr<VerseWidgetData>
        >
    with $FutureModifier<VerseWidgetData>, $FutureProvider<VerseWidgetData> {
  /// The "Verset du jour" widget's verses, from today, in the app language.
  /// Free and without account: App hands them to the phone at each launch.
  VerseWidgetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verseWidgetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verseWidgetHash();

  @$internal
  @override
  $FutureProviderElement<VerseWidgetData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VerseWidgetData> create(Ref ref) {
    return verseWidget(ref);
  }
}

String _$verseWidgetHash() => r'61cd706e8fea6ca70ed6aa89ddb76ee5d2d4ae33';
