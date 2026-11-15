// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_share_background.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The background last chosen for the image of a verse (of the day or of
/// the Bible) (its id in
/// `verseBackgrounds`), kept on the phone (`verse_share_background`): the
/// next share starts from it. null: the first photo.

@ProviderFor(VerseShareBackground)
final verseShareBackgroundProvider = VerseShareBackgroundProvider._();

/// The background last chosen for the image of a verse (of the day or of
/// the Bible) (its id in
/// `verseBackgrounds`), kept on the phone (`verse_share_background`): the
/// next share starts from it. null: the first photo.
final class VerseShareBackgroundProvider
    extends $NotifierProvider<VerseShareBackground, String?> {
  /// The background last chosen for the image of a verse (of the day or of
  /// the Bible) (its id in
  /// `verseBackgrounds`), kept on the phone (`verse_share_background`): the
  /// next share starts from it. null: the first photo.
  VerseShareBackgroundProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verseShareBackgroundProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verseShareBackgroundHash();

  @$internal
  @override
  VerseShareBackground create() => VerseShareBackground();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$verseShareBackgroundHash() =>
    r'7e10db297da4ed5edd375464eb1468b2c8e855ba';

/// The background last chosen for the image of a verse (of the day or of
/// the Bible) (its id in
/// `verseBackgrounds`), kept on the phone (`verse_share_background`): the
/// next share starts from it. null: the first photo.

abstract class _$VerseShareBackground extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
