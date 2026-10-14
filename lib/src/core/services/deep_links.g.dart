// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_links.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(incomingLinks)
final incomingLinksProvider = IncomingLinksProvider._();

final class IncomingLinksProvider
    extends $FunctionalProvider<IncomingLinks, IncomingLinks, IncomingLinks>
    with $Provider<IncomingLinks> {
  IncomingLinksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingLinksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingLinksHash();

  @$internal
  @override
  $ProviderElement<IncomingLinks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IncomingLinks create(Ref ref) {
    return incomingLinks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IncomingLinks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IncomingLinks>(value),
    );
  }
}

String _$incomingLinksHash() => r'1d50b2d734d4925ffc26c7d8518afb2c46bda9e3';

/// The screen a link asked for, kept until the app can open it (signed in:
/// `SignedInTasks` opens it, then clears it). A link arriving signed out
/// waits for the sign-in.

@ProviderFor(PendingDeepLink)
final pendingDeepLinkProvider = PendingDeepLinkProvider._();

/// The screen a link asked for, kept until the app can open it (signed in:
/// `SignedInTasks` opens it, then clears it). A link arriving signed out
/// waits for the sign-in.
final class PendingDeepLinkProvider
    extends $NotifierProvider<PendingDeepLink, AppLink?> {
  /// The screen a link asked for, kept until the app can open it (signed in:
  /// `SignedInTasks` opens it, then clears it). A link arriving signed out
  /// waits for the sign-in.
  PendingDeepLinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingDeepLinkProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingDeepLinkHash();

  @$internal
  @override
  PendingDeepLink create() => PendingDeepLink();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLink? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLink?>(value),
    );
  }
}

String _$pendingDeepLinkHash() => r'506563562d75762b6f7b374db98f6844ceba8713';

/// The screen a link asked for, kept until the app can open it (signed in:
/// `SignedInTasks` opens it, then clears it). A link arriving signed out
/// waits for the sign-in.

abstract class _$PendingDeepLink extends $Notifier<AppLink?> {
  AppLink? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppLink?, AppLink?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLink?, AppLink?>,
              AppLink?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
