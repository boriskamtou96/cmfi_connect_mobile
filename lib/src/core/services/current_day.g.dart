// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_day.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Today, read again each time the app comes back to the front: an app left
/// open in the background overnight shows the new day (the verse of the
/// day, the date of Home, the steps of the day) without being restarted.
/// What depends on the day watches it instead of calling [today] once.

@ProviderFor(CurrentDay)
final currentDayProvider = CurrentDayProvider._();

/// Today, read again each time the app comes back to the front: an app left
/// open in the background overnight shows the new day (the verse of the
/// day, the date of Home, the steps of the day) without being restarted.
/// What depends on the day watches it instead of calling [today] once.
final class CurrentDayProvider extends $NotifierProvider<CurrentDay, DateTime> {
  /// Today, read again each time the app comes back to the front: an app left
  /// open in the background overnight shows the new day (the verse of the
  /// day, the date of Home, the steps of the day) without being restarted.
  /// What depends on the day watches it instead of calling [today] once.
  CurrentDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentDayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentDayHash();

  @$internal
  @override
  CurrentDay create() => CurrentDay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$currentDayHash() => r'4087df61a601b58f93d6f9b25aaec0b06667ce66';

/// Today, read again each time the app comes back to the front: an app left
/// open in the background overnight shows the new day (the verse of the
/// day, the date of Home, the steps of the day) without being restarted.
/// What depends on the day watches it instead of calling [today] once.

abstract class _$CurrentDay extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
