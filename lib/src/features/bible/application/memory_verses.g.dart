// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_verses.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The verses learnt by heart, on the phone (key `memory_verses`), the
/// newest first; the reviews of the day and their reminder (key
/// `memory_reminder`, off until the member turns it on). Nothing goes to the
/// report: the member chose to keep them apart.

@ProviderFor(MemoryVerses)
final memoryVersesProvider = MemoryVersesProvider._();

/// The verses learnt by heart, on the phone (key `memory_verses`), the
/// newest first; the reviews of the day and their reminder (key
/// `memory_reminder`, off until the member turns it on). Nothing goes to the
/// report: the member chose to keep them apart.
final class MemoryVersesProvider
    extends $NotifierProvider<MemoryVerses, List<MemoryVerse>> {
  /// The verses learnt by heart, on the phone (key `memory_verses`), the
  /// newest first; the reviews of the day and their reminder (key
  /// `memory_reminder`, off until the member turns it on). Nothing goes to the
  /// report: the member chose to keep them apart.
  MemoryVersesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memoryVersesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memoryVersesHash();

  @$internal
  @override
  MemoryVerses create() => MemoryVerses();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<MemoryVerse> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<MemoryVerse>>(value),
    );
  }
}

String _$memoryVersesHash() => r'9ab62631e3716743b71604de33aa05dd93243a9b';

/// The verses learnt by heart, on the phone (key `memory_verses`), the
/// newest first; the reviews of the day and their reminder (key
/// `memory_reminder`, off until the member turns it on). Nothing goes to the
/// report: the member chose to keep them apart.

abstract class _$MemoryVerses extends $Notifier<List<MemoryVerse>> {
  List<MemoryVerse> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<MemoryVerse>, List<MemoryVerse>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<MemoryVerse>, List<MemoryVerse>>,
              List<MemoryVerse>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
