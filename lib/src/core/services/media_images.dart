import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';

part 'media_images.g.dart';

/// Images stored by the server ("/v1/media/KEY"): their full address, and
/// the image itself, kept on the phone once downloaded (cached_network_image)
/// so posters and photos show again without network. Behind a provider so
/// tests and screenshots give the images themselves.
class MediaImages {
  const MediaImages(this._apiBaseUrl);

  final String _apiBaseUrl;

  /// "/v1/media/3f91….jpg" -> "http://localhost:8080/v1/media/3f91….jpg".
  String resolve(String url) => Uri.parse(_apiBaseUrl).resolve(url).toString();

  ImageProvider of(String url) => CachedNetworkImageProvider(resolve(url));
}

@Riverpod(keepAlive: true)
MediaImages mediaImages(Ref ref) =>
    MediaImages(ref.watch(appConfigProvider).apiBaseUrl);
