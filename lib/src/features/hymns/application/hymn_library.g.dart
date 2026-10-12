// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every hymn book on the phone. Shown at once from the local copies; the server is asked
/// for newer versions in the background (at most every few hours, or on pull to refresh).

@ProviderFor(HymnLibrary)
final hymnLibraryProvider = HymnLibraryProvider._();

/// Every hymn book on the phone. Shown at once from the local copies; the server is asked
/// for newer versions in the background (at most every few hours, or on pull to refresh).
final class HymnLibraryProvider
    extends $AsyncNotifierProvider<HymnLibrary, List<HymnBook>> {
  /// Every hymn book on the phone. Shown at once from the local copies; the server is asked
  /// for newer versions in the background (at most every few hours, or on pull to refresh).
  HymnLibraryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hymnLibraryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hymnLibraryHash();

  @$internal
  @override
  HymnLibrary create() => HymnLibrary();
}

String _$hymnLibraryHash() => r'6ae5b67e1bcf8a91d2d85824f586ec1e169819c7';

/// Every hymn book on the phone. Shown at once from the local copies; the server is asked
/// for newer versions in the background (at most every few hours, or on pull to refresh).

abstract class _$HymnLibrary extends $AsyncNotifier<List<HymnBook>> {
  FutureOr<List<HymnBook>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<HymnBook>>, List<HymnBook>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<HymnBook>>, List<HymnBook>>,
              AsyncValue<List<HymnBook>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The book chosen in the Hymns tab, remembered.

@ProviderFor(SelectedHymnBookCode)
final selectedHymnBookCodeProvider = SelectedHymnBookCodeProvider._();

/// The book chosen in the Hymns tab, remembered.
final class SelectedHymnBookCodeProvider
    extends $NotifierProvider<SelectedHymnBookCode, String?> {
  /// The book chosen in the Hymns tab, remembered.
  SelectedHymnBookCodeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedHymnBookCodeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedHymnBookCodeHash();

  @$internal
  @override
  SelectedHymnBookCode create() => SelectedHymnBookCode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedHymnBookCodeHash() =>
    r'b608ad5640fdc1640258dbbb7f5c4f4faf16ca75';

/// The book chosen in the Hymns tab, remembered.

abstract class _$SelectedHymnBookCode extends $Notifier<String?> {
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

/// The chosen book; by default the first one in the app's language.

@ProviderFor(selectedHymnBook)
final selectedHymnBookProvider = SelectedHymnBookProvider._();

/// The chosen book; by default the first one in the app's language.

final class SelectedHymnBookProvider
    extends $FunctionalProvider<HymnBook?, HymnBook?, HymnBook?>
    with $Provider<HymnBook?> {
  /// The chosen book; by default the first one in the app's language.
  SelectedHymnBookProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedHymnBookProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedHymnBookHash();

  @$internal
  @override
  $ProviderElement<HymnBook?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HymnBook? create(Ref ref) {
    return selectedHymnBook(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HymnBook? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HymnBook?>(value),
    );
  }
}

String _$selectedHymnBookHash() => r'3fa66aecc1db9a14f1c658347dd61ce403084553';

/// A book by its code, or null while the library loads.

@ProviderFor(hymnBook)
final hymnBookProvider = HymnBookFamily._();

/// A book by its code, or null while the library loads.

final class HymnBookProvider
    extends $FunctionalProvider<HymnBook?, HymnBook?, HymnBook?>
    with $Provider<HymnBook?> {
  /// A book by its code, or null while the library loads.
  HymnBookProvider._({
    required HymnBookFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hymnBookProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hymnBookHash();

  @override
  String toString() {
    return r'hymnBookProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<HymnBook?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HymnBook? create(Ref ref) {
    final argument = this.argument as String;
    return hymnBook(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HymnBook? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HymnBook?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HymnBookProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hymnBookHash() => r'1d5fd6e8cdb513b9c63e2c643e1304ea919b6e8c';

/// A book by its code, or null while the library loads.

final class HymnBookFamily extends $Family
    with $FunctionalFamilyOverride<HymnBook?, String> {
  HymnBookFamily._()
    : super(
        retry: null,
        name: r'hymnBookProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A book by its code, or null while the library loads.

  HymnBookProvider call(String code) =>
      HymnBookProvider._(argument: code, from: this);

  @override
  String toString() => r'hymnBookProvider';
}

/// The search index of a book, built once per version of the book.

@ProviderFor(hymnSearchIndex)
final hymnSearchIndexProvider = HymnSearchIndexFamily._();

/// The search index of a book, built once per version of the book.

final class HymnSearchIndexProvider
    extends
        $FunctionalProvider<HymnSearchIndex, HymnSearchIndex, HymnSearchIndex>
    with $Provider<HymnSearchIndex> {
  /// The search index of a book, built once per version of the book.
  HymnSearchIndexProvider._({
    required HymnSearchIndexFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hymnSearchIndexProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hymnSearchIndexHash();

  @override
  String toString() {
    return r'hymnSearchIndexProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<HymnSearchIndex> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HymnSearchIndex create(Ref ref) {
    final argument = this.argument as String;
    return hymnSearchIndex(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HymnSearchIndex value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HymnSearchIndex>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HymnSearchIndexProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hymnSearchIndexHash() => r'2cecd9f3105204cbbc1a9d32c154f16e4a3af6eb';

/// The search index of a book, built once per version of the book.

final class HymnSearchIndexFamily extends $Family
    with $FunctionalFamilyOverride<HymnSearchIndex, String> {
  HymnSearchIndexFamily._()
    : super(
        retry: null,
        name: r'hymnSearchIndexProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The search index of a book, built once per version of the book.

  HymnSearchIndexProvider call(String code) =>
      HymnSearchIndexProvider._(argument: code, from: this);

  @override
  String toString() => r'hymnSearchIndexProvider';
}
