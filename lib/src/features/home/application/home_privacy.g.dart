// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_privacy.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The eye of the home screen: the numbers of the summary hidden (••), as
/// in a bank app, when someone looks at the screen. Kept on the phone.

@ProviderFor(HomeNumbersHidden)
final homeNumbersHiddenProvider = HomeNumbersHiddenProvider._();

/// The eye of the home screen: the numbers of the summary hidden (••), as
/// in a bank app, when someone looks at the screen. Kept on the phone.
final class HomeNumbersHiddenProvider
    extends $NotifierProvider<HomeNumbersHidden, bool> {
  /// The eye of the home screen: the numbers of the summary hidden (••), as
  /// in a bank app, when someone looks at the screen. Kept on the phone.
  HomeNumbersHiddenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeNumbersHiddenProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeNumbersHiddenHash();

  @$internal
  @override
  HomeNumbersHidden create() => HomeNumbersHidden();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$homeNumbersHiddenHash() => r'1b15d6e0c7e35bdae801ba93173e7c8e0c09e4ba';

/// The eye of the home screen: the numbers of the summary hidden (••), as
/// in a bank app, when someone looks at the screen. Kept on the phone.

abstract class _$HomeNumbersHidden extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
