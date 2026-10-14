// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widgets.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeWidgets)
final homeWidgetsProvider = HomeWidgetsProvider._();

final class HomeWidgetsProvider
    extends $FunctionalProvider<HomeWidgets, HomeWidgets, HomeWidgets>
    with $Provider<HomeWidgets> {
  HomeWidgetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeWidgetsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeWidgetsHash();

  @$internal
  @override
  $ProviderElement<HomeWidgets> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeWidgets create(Ref ref) {
    return homeWidgets(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeWidgets value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeWidgets>(value),
    );
  }
}

String _$homeWidgetsHash() => r'a4d77142fc6e6500a15986b800102cdae11a9538';
