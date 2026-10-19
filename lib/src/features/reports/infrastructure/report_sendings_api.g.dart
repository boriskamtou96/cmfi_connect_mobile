// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_sendings_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportSendingsApi)
final reportSendingsApiProvider = ReportSendingsApiProvider._();

final class ReportSendingsApiProvider
    extends
        $FunctionalProvider<
          ReportSendingsApi,
          ReportSendingsApi,
          ReportSendingsApi
        >
    with $Provider<ReportSendingsApi> {
  ReportSendingsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportSendingsApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportSendingsApiHash();

  @$internal
  @override
  $ProviderElement<ReportSendingsApi> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReportSendingsApi create(Ref ref) {
    return reportSendingsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportSendingsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportSendingsApi>(value),
    );
  }
}

String _$reportSendingsApiHash() => r'7261e6cca9800cfd5d246e12d05aaffd28e71969';
