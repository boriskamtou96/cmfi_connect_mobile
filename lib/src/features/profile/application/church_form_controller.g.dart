// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'church_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Saves the profile form: church fields, and the name when it is edited.

@ProviderFor(ChurchFormController)
final churchFormControllerProvider = ChurchFormControllerProvider._();

/// Saves the profile form: church fields, and the name when it is edited.
final class ChurchFormControllerProvider
    extends $AsyncNotifierProvider<ChurchFormController, void> {
  /// Saves the profile form: church fields, and the name when it is edited.
  ChurchFormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'churchFormControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$churchFormControllerHash();

  @$internal
  @override
  ChurchFormController create() => ChurchFormController();
}

String _$churchFormControllerHash() =>
    r'c3ce6c55aa9f2c78dc585d15c47cffd191edc188';

/// Saves the profile form: church fields, and the name when it is edited.

abstract class _$ChurchFormController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
