// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorities_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's authorities, disciple maker first.

@ProviderFor(AuthoritiesController)
final authoritiesControllerProvider = AuthoritiesControllerProvider._();

/// The user's authorities, disciple maker first.
final class AuthoritiesControllerProvider
    extends $AsyncNotifierProvider<AuthoritiesController, List<Authority>> {
  /// The user's authorities, disciple maker first.
  AuthoritiesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authoritiesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authoritiesControllerHash();

  @$internal
  @override
  AuthoritiesController create() => AuthoritiesController();
}

String _$authoritiesControllerHash() =>
    r'4d7f6ce87b9ed7ad668fc7874e8422fe4403aad3';

/// The user's authorities, disciple maker first.

abstract class _$AuthoritiesController extends $AsyncNotifier<List<Authority>> {
  FutureOr<List<Authority>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Authority>>, List<Authority>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Authority>>, List<Authority>>,
              AsyncValue<List<Authority>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The members who ask the user to accompany them.

@ProviderFor(AuthorityRequests)
final authorityRequestsProvider = AuthorityRequestsProvider._();

/// The members who ask the user to accompany them.
final class AuthorityRequestsProvider
    extends $AsyncNotifierProvider<AuthorityRequests, List<AuthorityRequest>> {
  /// The members who ask the user to accompany them.
  AuthorityRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authorityRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authorityRequestsHash();

  @$internal
  @override
  AuthorityRequests create() => AuthorityRequests();
}

String _$authorityRequestsHash() => r'3708f84ebcf37eda1943138b10ae2782fb45d50f';

/// The members who ask the user to accompany them.

abstract class _$AuthorityRequests
    extends $AsyncNotifier<List<AuthorityRequest>> {
  FutureOr<List<AuthorityRequest>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AuthorityRequest>>, List<AuthorityRequest>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AuthorityRequest>>,
                List<AuthorityRequest>
              >,
              AsyncValue<List<AuthorityRequest>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
