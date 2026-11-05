// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youversion_bible.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(youVersionBible)
final youVersionBibleProvider = YouVersionBibleProvider._();

final class YouVersionBibleProvider
    extends
        $FunctionalProvider<YouVersionBible, YouVersionBible, YouVersionBible>
    with $Provider<YouVersionBible> {
  YouVersionBibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'youVersionBibleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$youVersionBibleHash();

  @$internal
  @override
  $ProviderElement<YouVersionBible> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  YouVersionBible create(Ref ref) {
    return youVersionBible(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(YouVersionBible value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<YouVersionBible>(value),
    );
  }
}

String _$youVersionBibleHash() => r'3678064267af8bc244335566c91c7f140553920d';
