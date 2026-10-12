// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_item_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Creates a personal report item.

@ProviderFor(NewItemController)
final newItemControllerProvider = NewItemControllerProvider._();

/// Creates a personal report item.
final class NewItemControllerProvider
    extends $AsyncNotifierProvider<NewItemController, void> {
  /// Creates a personal report item.
  NewItemControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newItemControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newItemControllerHash();

  @$internal
  @override
  NewItemController create() => NewItemController();
}

String _$newItemControllerHash() => r'9964a54c4f200343136f1dda94ec688e0650f99c';

/// Creates a personal report item.

abstract class _$NewItemController extends $AsyncNotifier<void> {
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
