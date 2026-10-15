// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_position.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The chapter read last: the Bible opens on it again. The first time, John 1
/// (an easier start than Genesis).

@ProviderFor(BiblePosition)
final biblePositionProvider = BiblePositionProvider._();

/// The chapter read last: the Bible opens on it again. The first time, John 1
/// (an easier start than Genesis).
final class BiblePositionProvider
    extends $NotifierProvider<BiblePosition, BibleRef> {
  /// The chapter read last: the Bible opens on it again. The first time, John 1
  /// (an easier start than Genesis).
  BiblePositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biblePositionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biblePositionHash();

  @$internal
  @override
  BiblePosition create() => BiblePosition();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BibleRef value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BibleRef>(value),
    );
  }
}

String _$biblePositionHash() => r'344cf3f55c4f2df71a9edfb8bc980e1984564b66';

/// The chapter read last: the Bible opens on it again. The first time, John 1
/// (an easier start than Genesis).

abstract class _$BiblePosition extends $Notifier<BibleRef> {
  BibleRef build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BibleRef, BibleRef>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BibleRef, BibleRef>,
              BibleRef,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// A verse to show (the verse of the day, a search result, a shared link):
/// the Bible goes to its chapter, brings it into view and lights it a moment.

@ProviderFor(BibleFocus)
final bibleFocusProvider = BibleFocusProvider._();

/// A verse to show (the verse of the day, a search result, a shared link):
/// the Bible goes to its chapter, brings it into view and lights it a moment.
final class BibleFocusProvider
    extends $NotifierProvider<BibleFocus, BibleRef?> {
  /// A verse to show (the verse of the day, a search result, a shared link):
  /// the Bible goes to its chapter, brings it into view and lights it a moment.
  BibleFocusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleFocusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleFocusHash();

  @$internal
  @override
  BibleFocus create() => BibleFocus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BibleRef? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BibleRef?>(value),
    );
  }
}

String _$bibleFocusHash() => r'e7dd850500c41f583f69c835dc9d981d3ab22dd8';

/// A verse to show (the verse of the day, a search result, a shared link):
/// the Bible goes to its chapter, brings it into view and lights it a moment.

abstract class _$BibleFocus extends $Notifier<BibleRef?> {
  BibleRef? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BibleRef?, BibleRef?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BibleRef?, BibleRef?>,
              BibleRef?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
