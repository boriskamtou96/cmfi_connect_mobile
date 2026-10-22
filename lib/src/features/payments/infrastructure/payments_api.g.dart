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

/// The operators taking [currency], and cards, asked once per sheet.

@ProviderFor(paymentOptions)
final paymentOptionsProvider = PaymentOptionsFamily._();

/// The operators taking [currency], and cards, asked once per sheet.

final class PaymentOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaymentOptions>,
          PaymentOptions,
          FutureOr<PaymentOptions>
        >
    with $FutureModifier<PaymentOptions>, $FutureProvider<PaymentOptions> {
  /// The operators taking [currency], and cards, asked once per sheet.
  PaymentOptionsProvider._({
    required PaymentOptionsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'paymentOptionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paymentOptionsHash();

  @override
  String toString() {
    return r'paymentOptionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PaymentOptions> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PaymentOptions> create(Ref ref) {
    final argument = this.argument as String;
    return paymentOptions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentOptionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paymentOptionsHash() => r'4b1df801573b93d2d3c47fa6b07651057a0967cc';

/// The operators taking [currency], and cards, asked once per sheet.

final class PaymentOptionsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PaymentOptions>, String> {
  PaymentOptionsFamily._()
    : super(
        retry: null,
        name: r'paymentOptionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The operators taking [currency], and cards, asked once per sheet.

  PaymentOptionsProvider call(String currency) =>
      PaymentOptionsProvider._(argument: currency, from: this);

  @override
  String toString() => r'paymentOptionsProvider';
}
