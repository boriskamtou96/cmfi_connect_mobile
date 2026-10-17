// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teaching_library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// How far each teaching was heard (key `teaching_progress`: id → [position,
/// duration] in seconds), to start again where it stopped and to show a bar
/// in the list. Kept at sign-out: it is about public messages.

@ProviderFor(TeachingProgress)
final teachingProgressProvider = TeachingProgressProvider._();

/// How far each teaching was heard (key `teaching_progress`: id → [position,
/// duration] in seconds), to start again where it stopped and to show a bar
/// in the list. Kept at sign-out: it is about public messages.
final class TeachingProgressProvider
    extends $NotifierProvider<TeachingProgress, Map<int, Listened>> {
  /// How far each teaching was heard (key `teaching_progress`: id → [position,
  /// duration] in seconds), to start again where it stopped and to show a bar
  /// in the list. Kept at sign-out: it is about public messages.
  TeachingProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teachingProgressProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teachingProgressHash();

  @$internal
  @override
  TeachingProgress create() => TeachingProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, Listened> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, Listened>>(value),
    );
  }
}

String _$teachingProgressHash() => r'f8e912d8d312a28fef438e1eb85832777391573b';

/// How far each teaching was heard (key `teaching_progress`: id → [position,
/// duration] in seconds), to start again where it stopped and to show a bar
/// in the list. Kept at sign-out: it is about public messages.

abstract class _$TeachingProgress extends $Notifier<Map<int, Listened>> {
  Map<int, Listened> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<int, Listened>, Map<int, Listened>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<int, Listened>, Map<int, Listened>>,
              Map<int, Listened>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(TeachingDownloads)
final teachingDownloadsProvider = TeachingDownloadsProvider._();

final class TeachingDownloadsProvider
    extends $AsyncNotifierProvider<TeachingDownloads, DownloadsState> {
  TeachingDownloadsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teachingDownloadsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teachingDownloadsHash();

  @$internal
  @override
  TeachingDownloads create() => TeachingDownloads();
}

String _$teachingDownloadsHash() => r'4566a450275b9ff660056c6bd00d75240598d712';

abstract class _$TeachingDownloads extends $AsyncNotifier<DownloadsState> {
  FutureOr<DownloadsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DownloadsState>, DownloadsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DownloadsState>, DownloadsState>,
              AsyncValue<DownloadsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
