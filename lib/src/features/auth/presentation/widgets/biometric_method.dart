import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/services/biometrics.dart';
import '../../../../core/theme/app_icons.dart';

/// "Face ID", "Touch ID" on iPhone; "ton empreinte", "ton visage" on
/// Android, as the phones name them.
String biometricMethod(Translations t, BiometricKind kind) {
  final b = t.auth.biometric;
  final apple = defaultTargetPlatform == TargetPlatform.iOS;
  return switch (kind) {
    BiometricKind.face => apple ? b.faceId : b.face,
    BiometricKind.fingerprint => apple ? b.touchId : b.fingerprint,
  };
}

IconData biometricIcon(BiometricKind kind) => switch (kind) {
  BiometricKind.face => AppIcons.faceId,
  BiometricKind.fingerprint => AppIcons.fingerprint,
};
