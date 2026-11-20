// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teaching_batch.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Downloads the messages of an edition or a day, one after the other
/// (through [TeachingDownloads], so each row shows its own progress), and
/// removes them again. Kept alive: it goes on when the page is left. Stopped
/// by [stop], and by signing out.

@ProviderFor(TeachingBatch)
final teachingBatchProvider = TeachingBatchProvider._();

/// Downloads the messages of an edition or a day, one after the other
/// (through [TeachingDownloads], so each row shows its own progress), and
/// removes them again. Kept alive: it goes on when the page is left. Stopped
/// by [stop], and by signing out.
final class TeachingBatchProvider
    extends $NotifierProvider<TeachingBatch, TeachingBatchState> {
  /// Downloads the messages of an edition or a day, one after the other
  /// (through [TeachingDownloads], so each row shows its own progress), and
  /// removes them again. Kept alive: it goes on when the page is left. Stopped
  /// by [stop], and by signing out.
  TeachingBatchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teachingBatchProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teachingBatchHash();

  @$internal
  @override
  TeachingBatch create() => TeachingBatch();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeachingBatchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeachingBatchState>(value),
    );
  }
}

String _$teachingBatchHash() => r'3badf4a099cd28725e0b894eed0de383acfae4df';

/// Downloads the messages of an edition or a day, one after the other
/// (through [TeachingDownloads], so each row shows its own progress), and
/// removes them again. Kept alive: it goes on when the page is left. Stopped
/// by [stop], and by signing out.

abstract class _$TeachingBatch extends $Notifier<TeachingBatchState> {
  TeachingBatchState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TeachingBatchState, TeachingBatchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TeachingBatchState, TeachingBatchState>,
              TeachingBatchState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
