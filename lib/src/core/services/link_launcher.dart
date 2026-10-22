import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'link_launcher.g.dart';

/// Opens a link outside the app: a map, a phone number. Behind a provider so
/// tests replace it.
class LinkLauncher {
  const LinkLauncher();

  /// false when nothing could open it.
  Future<bool> open(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Object {
      return false;
    }
  }

  /// A web page inside the app (Safari View Controller, Custom Tabs), the
  /// way back at hand; the browser when that fails.
  Future<bool> openInApp(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.inAppBrowserView) ||
          await open(uri);
    } on Object {
      return open(uri);
    }
  }

  /// The phone app, ready to call [number].
  Future<bool> call(String number) =>
      open(Uri(scheme: 'tel', path: number.replaceAll(' ', '')));

  /// Directions in the maps app: [mapsUrl] when the event gives one, a search
  /// of [place] otherwise.
  Future<bool> directions({String mapsUrl = '', String place = ''}) => open(
    mapsUrl.isNotEmpty
        ? Uri.parse(mapsUrl)
        : Uri.https('www.google.com', '/maps/search/', {
            'api': '1',
            'query': place,
          }),
  );
}

@Riverpod(keepAlive: true)
LinkLauncher linkLauncher(Ref ref) => const LinkLauncher();
