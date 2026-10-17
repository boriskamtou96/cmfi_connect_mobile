// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teaching_files.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teachingFiles)
final teachingFilesProvider = TeachingFilesProvider._();

final class TeachingFilesProvider
    extends $FunctionalProvider<TeachingFiles, TeachingFiles, TeachingFiles>
    with $Provider<TeachingFiles> {
  TeachingFilesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teachingFilesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teachingFilesHash();

  @$internal
  @override
  $ProviderElement<TeachingFiles> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeachingFiles create(Ref ref) {
    return teachingFiles(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeachingFiles value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeachingFiles>(value),
    );
  }
}

String _$teachingFilesHash() => r'ee7fa6bac585befe14d6fb5bcafd37b5cead19ed';
