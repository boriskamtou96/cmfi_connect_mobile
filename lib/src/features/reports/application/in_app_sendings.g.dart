// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_app_sendings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The reports sent in the app to the authorities who are members, the
/// newest first, with their answers (Envoi à mes autorités); none without
/// network. Kept alive: read again when an answer comes (push
/// `report_reply`).

@ProviderFor(SentInApp)
final sentInAppProvider = SentInAppProvider._();

/// The reports sent in the app to the authorities who are members, the
/// newest first, with their answers (Envoi à mes autorités); none without
/// network. Kept alive: read again when an answer comes (push
/// `report_reply`).
final class SentInAppProvider
    extends $AsyncNotifierProvider<SentInApp, List<InAppSending>> {
  /// The reports sent in the app to the authorities who are members, the
  /// newest first, with their answers (Envoi à mes autorités); none without
  /// network. Kept alive: read again when an answer comes (push
  /// `report_reply`).
  SentInAppProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sentInAppProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sentInAppHash();

  @$internal
  @override
  SentInApp create() => SentInApp();
}

String _$sentInAppHash() => r'ee48cf1e1e9d4813e6a3ff5096b64238cd200b43';

/// The reports sent in the app to the authorities who are members, the
/// newest first, with their answers (Envoi à mes autorités); none without
/// network. Kept alive: read again when an answer comes (push
/// `report_reply`).

abstract class _$SentInApp extends $AsyncNotifier<List<InAppSending>> {
  FutureOr<List<InAppSending>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<InAppSending>>, List<InAppSending>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<InAppSending>>, List<InAppSending>>,
              AsyncValue<List<InAppSending>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
