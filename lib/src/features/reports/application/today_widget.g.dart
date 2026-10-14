// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_widget.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// What the widget shows for today: saved or to fill in, and how far the
/// goals go. null while the day loads.

@ProviderFor(todayWidget)
final todayWidgetProvider = TodayWidgetProvider._();

/// What the widget shows for today: saved or to fill in, and how far the
/// goals go. null while the day loads.

final class TodayWidgetProvider
    extends
        $FunctionalProvider<
          TodayWidgetData?,
          TodayWidgetData?,
          TodayWidgetData?
        >
    with $Provider<TodayWidgetData?> {
  /// What the widget shows for today: saved or to fill in, and how far the
  /// goals go. null while the day loads.
  TodayWidgetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayWidgetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayWidgetHash();

  @$internal
  @override
  $ProviderElement<TodayWidgetData?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodayWidgetData? create(Ref ref) {
    return todayWidget(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodayWidgetData? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodayWidgetData?>(value),
    );
  }
}

String _$todayWidgetHash() => r'e92900f19775eca62d65f60022aff8e2b899b7d7';
