// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_toast.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(toaster)
final toasterProvider = ToasterProvider._();

final class ToasterProvider
    extends $FunctionalProvider<Toaster, Toaster, Toaster>
    with $Provider<Toaster> {
  ToasterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toasterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toasterHash();

  @$internal
  @override
  $ProviderElement<Toaster> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Toaster create(Ref ref) {
    return toaster(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Toaster value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Toaster>(value),
    );
  }
}

String _$toasterHash() => r'8e123087a3cbbe80d13f7d52ad5ee3e0fdd3d3c3';
