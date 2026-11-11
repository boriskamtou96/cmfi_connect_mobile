// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_books.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mes lectures: the member's books with their progress, those being read
/// first. Read again after a report is saved (its pages move the progress).

@ProviderFor(ReadingBooks)
final readingBooksProvider = ReadingBooksProvider._();

/// Mes lectures: the member's books with their progress, those being read
/// first. Read again after a report is saved (its pages move the progress).
final class ReadingBooksProvider
    extends $AsyncNotifierProvider<ReadingBooks, List<ReadingBook>> {
  /// Mes lectures: the member's books with their progress, those being read
  /// first. Read again after a report is saved (its pages move the progress).
  ReadingBooksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingBooksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingBooksHash();

  @$internal
  @override
  ReadingBooks create() => ReadingBooks();
}

String _$readingBooksHash() => r'5410ba155a62dc88625208d823e0458a197fd9c7';

/// Mes lectures: the member's books with their progress, those being read
/// first. Read again after a report is saved (its pages move the progress).

abstract class _$ReadingBooks extends $AsyncNotifier<List<ReadingBook>> {
  FutureOr<List<ReadingBook>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ReadingBook>>, List<ReadingBook>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ReadingBook>>, List<ReadingBook>>,
              AsyncValue<List<ReadingBook>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The book being read the most recently started: the one an LLC entry
/// names by default. null without any.

@ProviderFor(currentBook)
final currentBookProvider = CurrentBookProvider._();

/// The book being read the most recently started: the one an LLC entry
/// names by default. null without any.

final class CurrentBookProvider
    extends $FunctionalProvider<ReadingBook?, ReadingBook?, ReadingBook?>
    with $Provider<ReadingBook?> {
  /// The book being read the most recently started: the one an LLC entry
  /// names by default. null without any.
  CurrentBookProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentBookProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentBookHash();

  @$internal
  @override
  $ProviderElement<ReadingBook?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReadingBook? create(Ref ref) {
    return currentBook(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReadingBook? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReadingBook?>(value),
    );
  }
}

String _$currentBookHash() => r'4a80fd6f88a6e28afa089c3800082584e2ff144d';

/// The books finished each month of [year], and the pages read.

@ProviderFor(readingStats)
final readingStatsProvider = ReadingStatsFamily._();

/// The books finished each month of [year], and the pages read.

final class ReadingStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ReadingStats>,
          ReadingStats,
          FutureOr<ReadingStats>
        >
    with $FutureModifier<ReadingStats>, $FutureProvider<ReadingStats> {
  /// The books finished each month of [year], and the pages read.
  ReadingStatsProvider._({
    required ReadingStatsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'readingStatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$readingStatsHash();

  @override
  String toString() {
    return r'readingStatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ReadingStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ReadingStats> create(Ref ref) {
    final argument = this.argument as int;
    return readingStats(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReadingStatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$readingStatsHash() => r'd7bba1615b5397969a7cebe9a3fef0ee47e60e09';

/// The books finished each month of [year], and the pages read.

final class ReadingStatsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ReadingStats>, int> {
  ReadingStatsFamily._()
    : super(
        retry: null,
        name: r'readingStatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The books finished each month of [year], and the pages read.

  ReadingStatsProvider call(int year) =>
      ReadingStatsProvider._(argument: year, from: this);

  @override
  String toString() => r'readingStatsProvider';
}
