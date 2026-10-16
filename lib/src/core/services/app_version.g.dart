// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "1.0.0 (1)": the version of the app and its build, at the bottom of Plus.
/// Answered by MainActivity.kt and AppDelegate.swift; '' when they can't
/// (tests, web).

@ProviderFor(appVersion)
final appVersionProvider = AppVersionProvider._();

/// "1.0.0 (1)": the version of the app and its build, at the bottom of Plus.
/// Answered by MainActivity.kt and AppDelegate.swift; '' when they can't
/// (tests, web).

final class AppVersionProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// "1.0.0 (1)": the version of the app and its build, at the bottom of Plus.
  /// Answered by MainActivity.kt and AppDelegate.swift; '' when they can't
  /// (tests, web).
  AppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return appVersion(ref);
  }
}

String _$appVersionHash() => r'b3eee504deb382ad221c7654104c0f797815c385';
