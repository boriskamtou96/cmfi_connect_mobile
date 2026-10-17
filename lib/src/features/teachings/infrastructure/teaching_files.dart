import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/teaching.dart';

part 'teaching_files.g.dart';

/// The teachings kept on the phone to listen without network, in the
/// support folder (`teachings/<id>.mp3`): not in the backups, not in Files.
/// Behind a provider so tests keep nothing.
abstract class TeachingFiles {
  /// The file of [teaching], null when not kept.
  Future<File?> fileOf(Teaching teaching);

  /// Downloads [url] for [teaching]; [onProgress] from 0 to 1.
  Future<void> download(
    Teaching teaching,
    String url, {
    required void Function(double progress) onProgress,
    CancelToken? cancel,
  });

  Future<void> delete(Teaching teaching);
}

class DeviceTeachingFiles implements TeachingFiles {
  DeviceTeachingFiles();

  final _dio = Dio();

  Future<File> _file(Teaching teaching) async {
    final folder = Directory(
      '${(await getApplicationSupportDirectory()).path}/teachings',
    );
    await folder.create(recursive: true);
    return File('${folder.path}/${teaching.id}.${teaching.audio.format.name}');
  }

  @override
  Future<File?> fileOf(Teaching teaching) async {
    final file = await _file(teaching);
    return await file.exists() ? file : null;
  }

  @override
  Future<void> download(
    Teaching teaching,
    String url, {
    required void Function(double progress) onProgress,
    CancelToken? cancel,
  }) async {
    final file = await _file(teaching);
    // written beside, then renamed: never half a file under its name
    final part = File('${file.path}.part');
    try {
      await _dio.download(
        url,
        part.path,
        cancelToken: cancel,
        onReceiveProgress: (received, total) {
          final size = total > 0 ? total : teaching.audio.sizeBytes;
          if (size > 0) {
            onProgress((received / size).clamp(0, 1));
          }
        },
      );
      await part.rename(file.path);
    } finally {
      if (await part.exists()) {
        await part.delete();
      }
    }
  }

  @override
  Future<void> delete(Teaching teaching) async {
    final file = await _file(teaching);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

@Riverpod(keepAlive: true)
TeachingFiles teachingFiles(Ref ref) => DeviceTeachingFiles();
