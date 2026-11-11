// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_item_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Creates a personal report item, or renames one.

@ProviderFor(NewItemController)
final newItemControllerProvider = NewItemControllerProvider._();

/// Creates a personal report item, or renames one.
final class NewItemControllerProvider
    extends $AsyncNotifierProvider<NewItemController, void> {
  /// Creates a personal report item, or renames one.
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

String _$newItemControllerHash() => r'1db9ba5635e21660c14e2dc7e243d61807a7f677';

/// Creates a personal report item, or renames one.

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
