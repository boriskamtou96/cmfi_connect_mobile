// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_verification.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Firebase started in bootstrap.dart (firebase_options.dart), or not.

@ProviderFor(phoneVerification)
final phoneVerificationProvider = PhoneVerificationProvider._();

/// Firebase started in bootstrap.dart (firebase_options.dart), or not.

final class PhoneVerificationProvider
    extends
        $FunctionalProvider<
          PhoneVerification,
          PhoneVerification,
          PhoneVerification
        >
    with $Provider<PhoneVerification> {
  /// Firebase started in bootstrap.dart (firebase_options.dart), or not.
  PhoneVerificationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneVerificationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneVerificationHash();

  @$internal
  @override
  $ProviderElement<PhoneVerification> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneVerification create(Ref ref) {
    return phoneVerification(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneVerification value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneVerification>(value),
    );
  }
}

String _$phoneVerificationHash() => r'20a1ad9c72d441146f9c273a3bd133bee2dd2d12';
