// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_authority_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// State of the "new authority" form: AsyncLoading while sending, AsyncError(AppException).

@ProviderFor(AddAuthorityController)
final addAuthorityControllerProvider = AddAuthorityControllerProvider._();

/// State of the "new authority" form: AsyncLoading while sending, AsyncError(AppException).
final class AddAuthorityControllerProvider
    extends $AsyncNotifierProvider<AddAuthorityController, void> {
  /// State of the "new authority" form: AsyncLoading while sending, AsyncError(AppException).
  AddAuthorityControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addAuthorityControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addAuthorityControllerHash();

  @$internal
  @override
  AddAuthorityController create() => AddAuthorityController();
}

String _$addAuthorityControllerHash() =>
    r'bf19408cc405cb31dabec69f52474bbee93914fd';

/// State of the "new authority" form: AsyncLoading while sending, AsyncError(AppException).

abstract class _$AddAuthorityController extends $AsyncNotifier<void> {
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
