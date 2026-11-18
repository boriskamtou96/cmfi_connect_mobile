// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_bookmark.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The reading bookmark: one chapter where the member stopped ("MAT.5"), to
/// come back to after browsing elsewhere. The same in every version; kept at
/// sign-out, like the marks. Null: none placed (or an unreadable value).

@ProviderFor(BibleBookmark)
final bibleBookmarkProvider = BibleBookmarkProvider._();

/// The reading bookmark: one chapter where the member stopped ("MAT.5"), to
/// come back to after browsing elsewhere. The same in every version; kept at
/// sign-out, like the marks. Null: none placed (or an unreadable value).
final class BibleBookmarkProvider
    extends $NotifierProvider<BibleBookmark, BibleRef?> {
  /// The reading bookmark: one chapter where the member stopped ("MAT.5"), to
  /// come back to after browsing elsewhere. The same in every version; kept at
  /// sign-out, like the marks. Null: none placed (or an unreadable value).
  BibleBookmarkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleBookmarkProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleBookmarkHash();

  @$internal
  @override
  BibleBookmark create() => BibleBookmark();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BibleRef? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BibleRef?>(value),
    );
  }
}

String _$bibleBookmarkHash() => r'04251ad8c1e0332f01cb5c085fe9a697d8f86837';

/// The reading bookmark: one chapter where the member stopped ("MAT.5"), to
/// come back to after browsing elsewhere. The same in every version; kept at
/// sign-out, like the marks. Null: none placed (or an unreadable value).

abstract class _$BibleBookmark extends $Notifier<BibleRef?> {
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
