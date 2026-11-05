// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_shield.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appShield)
final appShieldProvider = AppShieldProvider._();

final class AppShieldProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppShield>,
          AppShield,
          FutureOr<AppShield>
        >
    with $FutureModifier<AppShield>, $FutureProvider<AppShield> {
  AppShieldProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appShieldProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appShieldHash();

  @$internal
  @override
  $FutureProviderElement<AppShield> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppShield> create(Ref ref) {
    return appShield(ref);
  }
}

String _$appShieldHash() => r'6daedd1a75e116cd57245004f8bd4a571fc6e65c';
