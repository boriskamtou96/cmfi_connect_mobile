// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(paymentsApi)
final paymentsApiProvider = PaymentsApiProvider._();

final class PaymentsApiProvider
    extends $FunctionalProvider<PaymentsApi, PaymentsApi, PaymentsApi>
    with $Provider<PaymentsApi> {
  PaymentsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentsApiHash();

  @$internal
  @override
  $ProviderElement<PaymentsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PaymentsApi create(Ref ref) {
    return paymentsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentsApi>(value),
    );
  }
}

String _$paymentsApiHash() => r'f93b714ce7f1f9d08f8e00d992b2a47c95555128';

/// The operators taking [currency], asked once per sheet.

@ProviderFor(mobileMoneyOperators)
final mobileMoneyOperatorsProvider = MobileMoneyOperatorsFamily._();

/// The operators taking [currency], asked once per sheet.

final class MobileMoneyOperatorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MobileMoneyCountry>>,
          List<MobileMoneyCountry>,
          FutureOr<List<MobileMoneyCountry>>
        >
    with
        $FutureModifier<List<MobileMoneyCountry>>,
        $FutureProvider<List<MobileMoneyCountry>> {
  /// The operators taking [currency], asked once per sheet.
  MobileMoneyOperatorsProvider._({
    required MobileMoneyOperatorsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'mobileMoneyOperatorsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mobileMoneyOperatorsHash();

  @override
  String toString() {
    return r'mobileMoneyOperatorsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MobileMoneyCountry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MobileMoneyCountry>> create(Ref ref) {
    final argument = this.argument as String;
    return mobileMoneyOperators(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MobileMoneyOperatorsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mobileMoneyOperatorsHash() =>
    r'4467f2613eafa8353e894535e89c7e6eeb464473';

/// The operators taking [currency], asked once per sheet.

final class MobileMoneyOperatorsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MobileMoneyCountry>>, String> {
  MobileMoneyOperatorsFamily._()
    : super(
        retry: null,
        name: r'mobileMoneyOperatorsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The operators taking [currency], asked once per sheet.

  MobileMoneyOperatorsProvider call(String currency) =>
      MobileMoneyOperatorsProvider._(argument: currency, from: this);

  @override
  String toString() => r'mobileMoneyOperatorsProvider';
}
