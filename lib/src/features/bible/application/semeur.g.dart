// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semeur.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// La Bible du Semeur read in the app (14/11/2026: switched on and off from
/// Firebase Remote Config, `bible_semeur` = "on" or "off", without a new
/// version): only with the key of the YouVersion Platform in .env; while
/// the console has no value, BIBLE_SEMEUR of .env decides. Switched off, it
/// leaves the versions (the one who read it goes back to the Bible of their
/// language), La Bible du Semeur is read on Bibleserver again, and the copy
/// downloaded on the phone goes (its licence).

@ProviderFor(SemeurInApp)
final semeurInAppProvider = SemeurInAppProvider._();

/// La Bible du Semeur read in the app (14/11/2026: switched on and off from
/// Firebase Remote Config, `bible_semeur` = "on" or "off", without a new
/// version): only with the key of the YouVersion Platform in .env; while
/// the console has no value, BIBLE_SEMEUR of .env decides. Switched off, it
/// leaves the versions (the one who read it goes back to the Bible of their
/// language), La Bible du Semeur is read on Bibleserver again, and the copy
/// downloaded on the phone goes (its licence).
final class SemeurInAppProvider extends $NotifierProvider<SemeurInApp, bool> {
  /// La Bible du Semeur read in the app (14/11/2026: switched on and off from
  /// Firebase Remote Config, `bible_semeur` = "on" or "off", without a new
  /// version): only with the key of the YouVersion Platform in .env; while
  /// the console has no value, BIBLE_SEMEUR of .env decides. Switched off, it
  /// leaves the versions (the one who read it goes back to the Bible of their
  /// language), La Bible du Semeur is read on Bibleserver again, and the copy
  /// downloaded on the phone goes (its licence).
  SemeurInAppProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'semeurInAppProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$semeurInAppHash();

  @$internal
  @override
  SemeurInApp create() => SemeurInApp();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$semeurInAppHash() => r'e24b23050d3e39380b224bcb0a69b9518012a9ca';

/// La Bible du Semeur read in the app (14/11/2026: switched on and off from
/// Firebase Remote Config, `bible_semeur` = "on" or "off", without a new
/// version): only with the key of the YouVersion Platform in .env; while
/// the console has no value, BIBLE_SEMEUR of .env decides. Switched off, it
/// leaves the versions (the one who read it goes back to the Bible of their
/// language), La Bible du Semeur is read on Bibleserver again, and the copy
/// downloaded on the phone goes (its licence).

abstract class _$SemeurInApp extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
