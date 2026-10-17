// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_reading.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The chapters marked "J'ai lu ce chapitre" today ("JHN.3"), each one added
/// to "Lecture biblique" in today's report.

@ProviderFor(BibleReading)
final bibleReadingProvider = BibleReadingProvider._();

/// The chapters marked "J'ai lu ce chapitre" today ("JHN.3"), each one added
/// to "Lecture biblique" in today's report.
final class BibleReadingProvider
    extends $NotifierProvider<BibleReading, Set<String>> {
  /// The chapters marked "J'ai lu ce chapitre" today ("JHN.3"), each one added
  /// to "Lecture biblique" in today's report.
  BibleReadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleReadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleReadingHash();

  @$internal
  @override
  BibleReading create() => BibleReading();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$bibleReadingHash() => r'4b89a343f7215beb505e1c15530faf082cb4e149';

/// The chapters marked "J'ai lu ce chapitre" today ("JHN.3"), each one added
/// to "Lecture biblique" in today's report.

abstract class _$BibleReading extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
