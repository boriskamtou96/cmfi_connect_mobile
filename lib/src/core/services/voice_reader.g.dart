// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(voiceReader)
final voiceReaderProvider = VoiceReaderProvider._();

final class VoiceReaderProvider
    extends $FunctionalProvider<VoiceReader, VoiceReader, VoiceReader>
    with $Provider<VoiceReader> {
  VoiceReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceReaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceReaderHash();

  @$internal
  @override
  $ProviderElement<VoiceReader> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VoiceReader create(Ref ref) {
    return voiceReader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceReader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceReader>(value),
    );
  }
}

String _$voiceReaderHash() => r'252103e88de01c5830e7f130dc636c71b4a4a4e0';
