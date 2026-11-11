import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'social_photo.g.dart';

/// The photo of the Google account a member just created their account with,
/// waiting to become their profile photo once they are signed in.
@Riverpod(keepAlive: true)
class PendingSocialPhoto extends _$PendingSocialPhoto {
  @override
  String? build() => null;

  // ignore: use_setters_to_change_properties
  void set(String? url) => state = url;
}

/// Downloads the picture of a Google account. Behind a provider so tests
/// replace it.
abstract interface class PhotoDownloader {
  /// The bytes of the picture at [url], null when it can't be had: not a
  /// Google picture, too big, a failure of the network.
  Future<Uint8List?> download(String url);
}

class HttpPhotoDownloader implements PhotoDownloader {
  HttpPhotoDownloader([Dio? dio]) : _dio = dio ?? Dio();

  // no token of the app goes there: a plain client
  final Dio _dio;

  /// The server takes 2 MB at most.
  static const maxBytes = 2 * 1024 * 1024;

  /// Only the pictures of Google accounts.
  static bool isGooglePhoto(Uri uri) =>
      uri.scheme == 'https' &&
      (uri.host == 'googleusercontent.com' ||
          uri.host.endsWith('.googleusercontent.com'));

  @override
  Future<Uint8List?> download(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !isGooglePhoto(uri)) {
      return null;
    }
    try {
      final response = await _dio.getUri<List<int>>(
        uri,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
          followRedirects: false,
        ),
      );
      final bytes = response.data;
      if (response.statusCode != 200 ||
          bytes == null ||
          bytes.isEmpty ||
          bytes.length > maxBytes) {
        return null;
      }
      return Uint8List.fromList(bytes);
    } on Object {
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
PhotoDownloader photoDownloader(Ref ref) => HttpPhotoDownloader();
