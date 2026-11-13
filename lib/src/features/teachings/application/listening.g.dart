// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Plays the teachings one after the other, like a playlist: a message is
/// started with the list around it ([start]); when it ends the next one
/// plays (unless [ListeningState.continuous] is off, or the sleep timer said
/// to stop there), from the phone when it is kept, from the network
/// otherwise — and without network, the next one that is kept. At the end of
/// the pages the screen had read, the list is read further. The buttons
/// « next » and « previous » of the system (lock screen, notification,
/// headphones) come here too.

@ProviderFor(Listening)
final listeningProvider = ListeningProvider._();

/// Plays the teachings one after the other, like a playlist: a message is
/// started with the list around it ([start]); when it ends the next one
/// plays (unless [ListeningState.continuous] is off, or the sleep timer said
/// to stop there), from the phone when it is kept, from the network
/// otherwise — and without network, the next one that is kept. At the end of
/// the pages the screen had read, the list is read further. The buttons
/// « next » and « previous » of the system (lock screen, notification,
/// headphones) come here too.
final class ListeningProvider
    extends $NotifierProvider<Listening, ListeningState> {
  /// Plays the teachings one after the other, like a playlist: a message is
  /// started with the list around it ([start]); when it ends the next one
  /// plays (unless [ListeningState.continuous] is off, or the sleep timer said
  /// to stop there), from the phone when it is kept, from the network
  /// otherwise — and without network, the next one that is kept. At the end of
  /// the pages the screen had read, the list is read further. The buttons
  /// « next » and « previous » of the system (lock screen, notification,
  /// headphones) come here too.
  ListeningProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listeningProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listeningHash();

  @$internal
  @override
  Listening create() => Listening();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListeningState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListeningState>(value),
    );
  }
}

String _$listeningHash() => r'b9ef2a2f76ea76a37783fa63bfa6a915ea4ab8c3';

/// Plays the teachings one after the other, like a playlist: a message is
/// started with the list around it ([start]); when it ends the next one
/// plays (unless [ListeningState.continuous] is off, or the sleep timer said
/// to stop there), from the phone when it is kept, from the network
/// otherwise — and without network, the next one that is kept. At the end of
/// the pages the screen had read, the list is read further. The buttons
/// « next » and « previous » of the system (lock screen, notification,
/// headphones) come here too.

abstract class _$Listening extends $Notifier<ListeningState> {
  ListeningState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ListeningState, ListeningState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ListeningState, ListeningState>,
              ListeningState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
