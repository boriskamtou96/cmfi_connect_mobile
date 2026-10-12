// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_reminder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The reminder's settings (kept on the phone) and its planning: the next
/// [plannedDays] evenings are planned at once and planned again each time
/// the app starts or a day is saved, so a filled day stays silent.

@ProviderFor(ReportReminder)
final reportReminderProvider = ReportReminderProvider._();

/// The reminder's settings (kept on the phone) and its planning: the next
/// [plannedDays] evenings are planned at once and planned again each time
/// the app starts or a day is saved, so a filled day stays silent.
final class ReportReminderProvider
    extends $NotifierProvider<ReportReminder, ReminderSettings> {
  /// The reminder's settings (kept on the phone) and its planning: the next
  /// [plannedDays] evenings are planned at once and planned again each time
  /// the app starts or a day is saved, so a filled day stays silent.
  ReportReminderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportReminderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportReminderHash();

  @$internal
  @override
  ReportReminder create() => ReportReminder();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderSettings>(value),
    );
  }
}

String _$reportReminderHash() => r'ad8000c740f72d189e7ffd97a126935a4065e722';

/// The reminder's settings (kept on the phone) and its planning: the next
/// [plannedDays] evenings are planned at once and planned again each time
/// the app starts or a day is saved, so a filled day stays silent.

abstract class _$ReportReminder extends $Notifier<ReminderSettings> {
  ReminderSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ReminderSettings, ReminderSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReminderSettings, ReminderSettings>,
              ReminderSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
