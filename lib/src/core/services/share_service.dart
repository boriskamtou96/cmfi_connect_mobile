import 'dart:typed_data';
import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'share_service.g.dart';

/// The system share sheet (WhatsApp, mail, Files…). Behind a provider so tests
/// replace it.
class ShareService {
  const ShareService();

  /// [origin]: where the sheet points from on iPad (the button tapped).
  Future<void> shareText(String text, {String? subject, Rect? origin}) =>
      SharePlus.instance.share(
        ShareParams(text: text, subject: subject, sharePositionOrigin: origin),
      );

  Future<void> shareFile(
    Uint8List bytes, {
    required String name,
    required String mimeType,
    String? subject,
    Rect? origin,
  }) => SharePlus.instance.share(
    ShareParams(
      files: [XFile.fromData(bytes, name: name, mimeType: mimeType)],
      fileNameOverrides: [name],
      subject: subject,
      sharePositionOrigin: origin,
    ),
  );
}

@Riverpod(keepAlive: true)
ShareService shareService(Ref ref) => const ShareService();
