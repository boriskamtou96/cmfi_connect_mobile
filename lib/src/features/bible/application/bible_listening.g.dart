// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_listening.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Bible read aloud by the phone's voice (the voice of the retreats,
/// offline, in the language of the version read): a chapter, or the day's
/// chapters of the reading plan one after the other, verse by verse. The
/// verse heard is brought into view and lit (`BibleFocus`). null when
/// nothing is heard.

@ProviderFor(BibleListening)
final bibleListeningProvider = BibleListeningProvider._();

/// The Bible read aloud by the phone's voice (the voice of the retreats,
/// offline, in the language of the version read): a chapter, or the day's
/// chapters of the reading plan one after the other, verse by verse. The
/// verse heard is brought into view and lit (`BibleFocus`). null when
/// nothing is heard.
final class BibleListeningProvider
    extends $NotifierProvider<BibleListening, BibleListeningState?> {
  /// The Bible read aloud by the phone's voice (the voice of the retreats,
  /// offline, in the language of the version read): a chapter, or the day's
  /// chapters of the reading plan one after the other, verse by verse. The
  /// verse heard is brought into view and lit (`BibleFocus`). null when
  /// nothing is heard.
  BibleListeningProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleListeningProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleListeningHash();

  @$internal
  @override
  BibleListening create() => BibleListening();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BibleListeningState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BibleListeningState?>(value),
    );
  }
}

String _$bibleListeningHash() => r'6b8e8913a29c040cd8860223ccc946117d4701bc';

/// The Bible read aloud by the phone's voice (the voice of the retreats,
/// offline, in the language of the version read): a chapter, or the day's
/// chapters of the reading plan one after the other, verse by verse. The
/// verse heard is brought into view and lit (`BibleFocus`). null when
/// nothing is heard.

abstract class _$BibleListening extends $Notifier<BibleListeningState?> {
  BibleListeningState? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BibleListeningState?, BibleListeningState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BibleListeningState?, BibleListeningState?>,
              BibleListeningState?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
