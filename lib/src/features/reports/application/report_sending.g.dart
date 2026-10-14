// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_sending.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The regular sending of the report to the authorities, kept on the phone:
/// the next moments are planned as notifications (replanned at launch); a
/// tap opens the report ready to send ([sendingDayOf]).

@ProviderFor(ReportSending)
final reportSendingProvider = ReportSendingProvider._();

/// The regular sending of the report to the authorities, kept on the phone:
/// the next moments are planned as notifications (replanned at launch); a
/// tap opens the report ready to send ([sendingDayOf]).
final class ReportSendingProvider
    extends $NotifierProvider<ReportSending, SendingSettings> {
  /// The regular sending of the report to the authorities, kept on the phone:
  /// the next moments are planned as notifications (replanned at launch); a
  /// tap opens the report ready to send ([sendingDayOf]).
  ReportSendingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportSendingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportSendingHash();

  @$internal
  @override
  ReportSending create() => ReportSending();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendingSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendingSettings>(value),
    );
  }
}

String _$reportSendingHash() => r'f021c99d9a7c05ce5b3544260c43b8f6e8f5a3c1';

/// The regular sending of the report to the authorities, kept on the phone:
/// the next moments are planned as notifications (replanned at launch); a
/// tap opens the report ready to send ([sendingDayOf]).

abstract class _$ReportSending extends $Notifier<SendingSettings> {
  SendingSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SendingSettings, SendingSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SendingSettings, SendingSettings>,
              SendingSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The reports sent, the last first (the last 12, on the phone).

@ProviderFor(SentReports)
final sentReportsProvider = SentReportsProvider._();

/// The reports sent, the last first (the last 12, on the phone).
final class SentReportsProvider
    extends $NotifierProvider<SentReports, List<SentReport>> {
  /// The reports sent, the last first (the last 12, on the phone).
  SentReportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sentReportsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sentReportsHash();

  @$internal
  @override
  SentReports create() => SentReports();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SentReport> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SentReport>>(value),
    );
  }
}

String _$sentReportsHash() => r'1c295744df57fd447b5b432ca59f7927c0200646';

/// The reports sent, the last first (the last 12, on the phone).

abstract class _$SentReports extends $Notifier<List<SentReport>> {
  List<SentReport> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<SentReport>, List<SentReport>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<SentReport>, List<SentReport>>,
              List<SentReport>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
