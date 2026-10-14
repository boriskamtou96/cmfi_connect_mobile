// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crash_reporting.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(crashReporting)
final crashReportingProvider = CrashReportingProvider._();

final class CrashReportingProvider
    extends $FunctionalProvider<CrashReporting, CrashReporting, CrashReporting>
    with $Provider<CrashReporting> {
  CrashReportingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'crashReportingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$crashReportingHash();

  @$internal
  @override
  $ProviderElement<CrashReporting> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CrashReporting create(Ref ref) {
    return crashReporting(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CrashReporting value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CrashReporting>(value),
    );
  }
}

String _$crashReportingHash() => r'2eb9fe9b34370e5afa9db8ce273a19b27d50b26a';
