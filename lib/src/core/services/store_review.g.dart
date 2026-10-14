// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_review.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storeReview)
final storeReviewProvider = StoreReviewProvider._();

final class StoreReviewProvider
    extends $FunctionalProvider<StoreReview, StoreReview, StoreReview>
    with $Provider<StoreReview> {
  StoreReviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storeReviewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storeReviewHash();

  @$internal
  @override
  $ProviderElement<StoreReview> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StoreReview create(Ref ref) {
    return storeReview(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StoreReview value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StoreReview>(value),
    );
  }
}

String _$storeReviewHash() => r'6ebd975d57d6e6a10f0f0ae66713ef152952880f';

@ProviderFor(ratingPrompt)
final ratingPromptProvider = RatingPromptProvider._();

final class RatingPromptProvider
    extends $FunctionalProvider<RatingPrompt, RatingPrompt, RatingPrompt>
    with $Provider<RatingPrompt> {
  RatingPromptProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ratingPromptProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ratingPromptHash();

  @$internal
  @override
  $ProviderElement<RatingPrompt> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RatingPrompt create(Ref ref) {
    return ratingPrompt(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RatingPrompt value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RatingPrompt>(value),
    );
  }
}

String _$ratingPromptHash() => r'6124b087805e8e567f703b5b9f49bf65345edaf9';
