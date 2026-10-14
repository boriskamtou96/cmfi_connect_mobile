// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The member's notifications, the latest first, and how many are not read
/// (the badge of the bell). Kept alive: the home screen and Plus show the
/// badge; refreshed when a push arrives.

@ProviderFor(Inbox)
final inboxProvider = InboxProvider._();

/// The member's notifications, the latest first, and how many are not read
/// (the badge of the bell). Kept alive: the home screen and Plus show the
/// badge; refreshed when a push arrives.
final class InboxProvider extends $AsyncNotifierProvider<Inbox, InboxState> {
  /// The member's notifications, the latest first, and how many are not read
  /// (the badge of the bell). Kept alive: the home screen and Plus show the
  /// badge; refreshed when a push arrives.
  InboxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inboxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inboxHash();

  @$internal
  @override
  Inbox create() => Inbox();
}

String _$inboxHash() => r'952405a2a9160600582c2c1fd077ead20775f4e1';

/// The member's notifications, the latest first, and how many are not read
/// (the badge of the bell). Kept alive: the home screen and Plus show the
/// badge; refreshed when a push arrives.

abstract class _$Inbox extends $AsyncNotifier<InboxState> {
  FutureOr<InboxState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<InboxState>, InboxState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<InboxState>, InboxState>,
              AsyncValue<InboxState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// One notification: from the list when it is there, else from the server
/// (opened from a push).

@ProviderFor(announcement)
final announcementProvider = AnnouncementFamily._();

/// One notification: from the list when it is there, else from the server
/// (opened from a push).

final class AnnouncementProvider
    extends
        $FunctionalProvider<
          AsyncValue<Announcement>,
          Announcement,
          FutureOr<Announcement>
        >
    with $FutureModifier<Announcement>, $FutureProvider<Announcement> {
  /// One notification: from the list when it is there, else from the server
  /// (opened from a push).
  AnnouncementProvider._({
    required AnnouncementFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'announcementProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$announcementHash();

  @override
  String toString() {
    return r'announcementProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Announcement> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Announcement> create(Ref ref) {
    final argument = this.argument as int;
    return announcement(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnouncementProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$announcementHash() => r'1648080946e58d08dc5c31fcb15d208bee7411fa';

/// One notification: from the list when it is there, else from the server
/// (opened from a push).

final class AnnouncementFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Announcement>, int> {
  AnnouncementFamily._()
    : super(
        retry: null,
        name: r'announcementProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One notification: from the list when it is there, else from the server
  /// (opened from a push).

  AnnouncementProvider call(int id) =>
      AnnouncementProvider._(argument: id, from: this);

  @override
  String toString() => r'announcementProvider';
}
