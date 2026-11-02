// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collective_walk.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The collective walk of the member's disciples this week (Monday to
/// Sunday), from the reports they sent in the app. null when the member
/// accompanies nobody.

@ProviderFor(collectiveWalk)
final collectiveWalkProvider = CollectiveWalkProvider._();

/// The collective walk of the member's disciples this week (Monday to
/// Sunday), from the reports they sent in the app. null when the member
/// accompanies nobody.

final class CollectiveWalkProvider
    extends
        $FunctionalProvider<
          AsyncValue<CollectiveWalk?>,
          CollectiveWalk?,
          FutureOr<CollectiveWalk?>
        >
    with $FutureModifier<CollectiveWalk?>, $FutureProvider<CollectiveWalk?> {
  /// The collective walk of the member's disciples this week (Monday to
  /// Sunday), from the reports they sent in the app. null when the member
  /// accompanies nobody.
  CollectiveWalkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectiveWalkProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectiveWalkHash();

  @$internal
  @override
  $FutureProviderElement<CollectiveWalk?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CollectiveWalk?> create(Ref ref) {
    return collectiveWalk(ref);
  }
}

String _$collectiveWalkHash() => r'b4e4ba0a49268a92fe0038e0fd05577244bbc914';
