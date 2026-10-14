// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disciples.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The members who chose the user as disciple maker ("Mes disciples").

@ProviderFor(disciples)
final disciplesProvider = DisciplesProvider._();

/// The members who chose the user as disciple maker ("Mes disciples").

final class DisciplesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Disciple>>,
          List<Disciple>,
          FutureOr<List<Disciple>>
        >
    with $FutureModifier<List<Disciple>>, $FutureProvider<List<Disciple>> {
  /// The members who chose the user as disciple maker ("Mes disciples").
  DisciplesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'disciplesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$disciplesHash();

  @$internal
  @override
  $FutureProviderElement<List<Disciple>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Disciple>> create(Ref ref) {
    return disciples(ref);
  }
}

String _$disciplesHash() => r'd29e4c0b6ae7899f81b0c668eefd2b8648d976bb';
