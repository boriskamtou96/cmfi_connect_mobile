// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The whole of [version] once downloaded (read off the main thread), or
/// null.

@ProviderFor(bibleText)
final bibleTextProvider = BibleTextFamily._();

/// The whole of [version] once downloaded (read off the main thread), or
/// null.

final class BibleTextProvider
    extends
        $FunctionalProvider<
          AsyncValue<BibleText?>,
          BibleText?,
          FutureOr<BibleText?>
        >
    with $FutureModifier<BibleText?>, $FutureProvider<BibleText?> {
  /// The whole of [version] once downloaded (read off the main thread), or
  /// null.
  BibleTextProvider._({
    required BibleTextFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bibleTextProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bibleTextHash();

  @override
  String toString() {
    return r'bibleTextProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BibleText?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<BibleText?> create(Ref ref) {
    final argument = this.argument as String;
    return bibleText(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BibleTextProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bibleTextHash() => r'59147be7887507e4027f85605a6bd600f386c877';

/// The whole of [version] once downloaded (read off the main thread), or
/// null.

final class BibleTextFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BibleText?>, String> {
  BibleTextFamily._()
    : super(
        retry: null,
        name: r'bibleTextProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// The whole of [version] once downloaded (read off the main thread), or
  /// null.

  BibleTextProvider call(String version) =>
      BibleTextProvider._(argument: version, from: this);

  @override
  String toString() => r'bibleTextProvider';
}

/// The books of [version]: from the downloaded Bible, the list kept on the
/// phone, or the API (then kept).

@ProviderFor(bibleBooks)
final bibleBooksProvider = BibleBooksFamily._();

/// The books of [version]: from the downloaded Bible, the list kept on the
/// phone, or the API (then kept).

final class BibleBooksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BibleBook>>,
          List<BibleBook>,
          FutureOr<List<BibleBook>>
        >
    with $FutureModifier<List<BibleBook>>, $FutureProvider<List<BibleBook>> {
  /// The books of [version]: from the downloaded Bible, the list kept on the
  /// phone, or the API (then kept).
  BibleBooksProvider._({
    required BibleBooksFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bibleBooksProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bibleBooksHash();

  @override
  String toString() {
    return r'bibleBooksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<BibleBook>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BibleBook>> create(Ref ref) {
    final argument = this.argument as String;
    return bibleBooks(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BibleBooksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bibleBooksHash() => r'814423497ac1a5283d86ff167d8668337c8efd9a';

/// The books of [version]: from the downloaded Bible, the list kept on the
/// phone, or the API (then kept).

final class BibleBooksFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<BibleBook>>, String> {
  BibleBooksFamily._()
    : super(
        retry: null,
        name: r'bibleBooksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// The books of [version]: from the downloaded Bible, the list kept on the
  /// phone, or the API (then kept).

  BibleBooksProvider call(String version) =>
      BibleBooksProvider._(argument: version, from: this);

  @override
  String toString() => r'bibleBooksProvider';
}

/// A chapter of [version]: from the downloaded Bible, the copy kept when it
/// was read, or the API (then kept: it reads again without network).

@ProviderFor(bibleChapter)
final bibleChapterProvider = BibleChapterFamily._();

/// A chapter of [version]: from the downloaded Bible, the copy kept when it
/// was read, or the API (then kept: it reads again without network).

final class BibleChapterProvider
    extends
        $FunctionalProvider<
          AsyncValue<BibleChapter>,
          BibleChapter,
          FutureOr<BibleChapter>
        >
    with $FutureModifier<BibleChapter>, $FutureProvider<BibleChapter> {
  /// A chapter of [version]: from the downloaded Bible, the copy kept when it
  /// was read, or the API (then kept: it reads again without network).
  BibleChapterProvider._({
    required BibleChapterFamily super.from,
    required (String, String, int) super.argument,
  }) : super(
         retry: null,
         name: r'bibleChapterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bibleChapterHash();

  @override
  String toString() {
    return r'bibleChapterProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<BibleChapter> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BibleChapter> create(Ref ref) {
    final argument = this.argument as (String, String, int);
    return bibleChapter(ref, argument.$1, argument.$2, argument.$3);
  }

  @override
  bool operator ==(Object other) {
    return other is BibleChapterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bibleChapterHash() => r'e7b526349997d77b98b8944ec8ec600c57b4769b';

/// A chapter of [version]: from the downloaded Bible, the copy kept when it
/// was read, or the API (then kept: it reads again without network).

final class BibleChapterFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<BibleChapter>,
          (String, String, int)
        > {
  BibleChapterFamily._()
    : super(
        retry: null,
        name: r'bibleChapterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A chapter of [version]: from the downloaded Bible, the copy kept when it
  /// was read, or the API (then kept: it reads again without network).

  BibleChapterProvider call(String version, String book, int number) =>
      BibleChapterProvider._(argument: (version, book, number), from: this);

  @override
  String toString() => r'bibleChapterProvider';
}

/// The whole of a version on the phone (about 7 MB): to read and search
/// without network.

@ProviderFor(BibleDownload)
final bibleDownloadProvider = BibleDownloadFamily._();

/// The whole of a version on the phone (about 7 MB): to read and search
/// without network.
final class BibleDownloadProvider
    extends $AsyncNotifierProvider<BibleDownload, BibleDownloadState> {
  /// The whole of a version on the phone (about 7 MB): to read and search
  /// without network.
  BibleDownloadProvider._({
    required BibleDownloadFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bibleDownloadProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bibleDownloadHash();

  @override
  String toString() {
    return r'bibleDownloadProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BibleDownload create() => BibleDownload();

  @override
  bool operator ==(Object other) {
    return other is BibleDownloadProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bibleDownloadHash() => r'2f6f73d8f4a322151807321f273c735c9b13e230';

/// The whole of a version on the phone (about 7 MB): to read and search
/// without network.

final class BibleDownloadFamily extends $Family
    with
        $ClassFamilyOverride<
          BibleDownload,
          AsyncValue<BibleDownloadState>,
          BibleDownloadState,
          FutureOr<BibleDownloadState>,
          String
        > {
  BibleDownloadFamily._()
    : super(
        retry: null,
        name: r'bibleDownloadProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// The whole of a version on the phone (about 7 MB): to read and search
  /// without network.

  BibleDownloadProvider call(String version) =>
      BibleDownloadProvider._(argument: version, from: this);

  @override
  String toString() => r'bibleDownloadProvider';
}

/// The whole of a version on the phone (about 7 MB): to read and search
/// without network.

abstract class _$BibleDownload extends $AsyncNotifier<BibleDownloadState> {
  late final _$args = ref.$arg as String;
  String get version => _$args;

  FutureOr<BibleDownloadState> build(String version);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<BibleDownloadState>, BibleDownloadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BibleDownloadState>, BibleDownloadState>,
              AsyncValue<BibleDownloadState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(bibleSearch)
final bibleSearchProvider = BibleSearchFamily._();

final class BibleSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<BibleSearch>,
          BibleSearch,
          FutureOr<BibleSearch>
        >
    with $FutureModifier<BibleSearch>, $FutureProvider<BibleSearch> {
  BibleSearchProvider._({
    required BibleSearchFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'bibleSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bibleSearchHash();

  @override
  String toString() {
    return r'bibleSearchProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<BibleSearch> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BibleSearch> create(Ref ref) {
    final argument = this.argument as (String, String);
    return bibleSearch(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is BibleSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bibleSearchHash() => r'7660ad1258c3a2fd617a9b0a5fe37ab268db4bdb';

final class BibleSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BibleSearch>, (String, String)> {
  BibleSearchFamily._()
    : super(
        retry: null,
        name: r'bibleSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BibleSearchProvider call(String version, String query) =>
      BibleSearchProvider._(argument: (version, query), from: this);

  @override
  String toString() => r'bibleSearchProvider';
}

/// The concordance of [word] in the downloaded [version]; null when it is
/// not on the phone.

@ProviderFor(bibleConcordance)
final bibleConcordanceProvider = BibleConcordanceFamily._();

/// The concordance of [word] in the downloaded [version]; null when it is
/// not on the phone.

final class BibleConcordanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<Concordance?>,
          Concordance?,
          FutureOr<Concordance?>
        >
    with $FutureModifier<Concordance?>, $FutureProvider<Concordance?> {
  /// The concordance of [word] in the downloaded [version]; null when it is
  /// not on the phone.
  BibleConcordanceProvider._({
    required BibleConcordanceFamily super.from,
    required (String, String, {bool prefix}) super.argument,
  }) : super(
         retry: null,
         name: r'bibleConcordanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bibleConcordanceHash();

  @override
  String toString() {
    return r'bibleConcordanceProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Concordance?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Concordance?> create(Ref ref) {
    final argument = this.argument as (String, String, {bool prefix});
    return bibleConcordance(
      ref,
      argument.$1,
      argument.$2,
      prefix: argument.prefix,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BibleConcordanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bibleConcordanceHash() => r'8e89ea21611c0d7ce43507ab55a7d518a2e18f1e';

/// The concordance of [word] in the downloaded [version]; null when it is
/// not on the phone.

final class BibleConcordanceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Concordance?>,
          (String, String, {bool prefix})
        > {
  BibleConcordanceFamily._()
    : super(
        retry: null,
        name: r'bibleConcordanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The concordance of [word] in the downloaded [version]; null when it is
  /// not on the phone.

  BibleConcordanceProvider call(
    String version,
    String word, {
    bool prefix = false,
  }) => BibleConcordanceProvider._(
    argument: (version, word, prefix: prefix),
    from: this,
  );

  @override
  String toString() => r'bibleConcordanceProvider';
}
