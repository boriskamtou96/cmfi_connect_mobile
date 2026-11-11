// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(readingApi)
final readingApiProvider = ReadingApiProvider._();

final class ReadingApiProvider
    extends $FunctionalProvider<ReadingApi, ReadingApi, ReadingApi>
    with $Provider<ReadingApi> {
  ReadingApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingApiHash();

  @$internal
  @override
  $ProviderElement<ReadingApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReadingApi create(Ref ref) {
    return readingApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReadingApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReadingApi>(value),
    );
  }
}

String _$readingApiHash() => r'9fb095bab9ace47422f9e6e2d48e247f044bcdf5';
