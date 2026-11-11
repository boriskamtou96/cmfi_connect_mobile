// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overdue.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The disciples with no report for [days] days or more.

@ProviderFor(overdueDisciples)
final overdueDisciplesProvider = OverdueDisciplesFamily._();

/// The disciples with no report for [days] days or more.

final class OverdueDisciplesProvider
    extends $FunctionalProvider<AsyncValue<Overdue>, Overdue, FutureOr<Overdue>>
    with $FutureModifier<Overdue>, $FutureProvider<Overdue> {
  /// The disciples with no report for [days] days or more.
  OverdueDisciplesProvider._({
    required OverdueDisciplesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'overdueDisciplesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$overdueDisciplesHash();

  @override
  String toString() {
    return r'overdueDisciplesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Overdue> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Overdue> create(Ref ref) {
    final argument = this.argument as int;
    return overdueDisciples(ref, days: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OverdueDisciplesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$overdueDisciplesHash() => r'4ca5d652d9ebf03842e7b9ad430255be419e208f';

/// The disciples with no report for [days] days or more.

final class OverdueDisciplesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Overdue>, int> {
  OverdueDisciplesFamily._()
    : super(
        retry: null,
        name: r'overdueDisciplesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The disciples with no report for [days] days or more.

  OverdueDisciplesProvider call({int days = 3}) =>
      OverdueDisciplesProvider._(argument: days, from: this);

  @override
  String toString() => r'overdueDisciplesProvider';
}
