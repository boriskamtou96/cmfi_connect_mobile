// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The single HTTP client of the app. Feature APIs receive it, they never create their own.
/// A request to another host (absolute URL) goes without the user's token.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// The single HTTP client of the app. Feature APIs receive it, they never create their own.
/// A request to another host (absolute URL) goes without the user's token.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// The single HTTP client of the app. Feature APIs receive it, they never create their own.
  /// A request to another host (absolute URL) goes without the user's token.
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'd3db9d28ef8ff2b9a11ac67bf1b6118b3da229c5';
