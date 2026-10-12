// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportsApi)
final reportsApiProvider = ReportsApiProvider._();

final class ReportsApiProvider
    extends $FunctionalProvider<ReportsApi, ReportsApi, ReportsApi>
    with $Provider<ReportsApi> {
  ReportsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsApiHash();

  @$internal
  @override
  $ProviderElement<ReportsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReportsApi create(Ref ref) {
    return reportsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsApi>(value),
    );
  }
}

String _$reportsApiHash() => r'e4d165a51e428e6f8f286a365d1ef0eaef05fb62';
