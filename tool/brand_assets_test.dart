// Generates the brand images (app icons, splash) from the CmfiLogo painter (the emblem),
// so the icons always match the logo drawn in the app, and the images of Zoé, the
// mascot, from the DovePainter (for the native home-screen widget).
//
// Run, then regenerate icons and splash:
//   flutter test tool/brand_assets_test.dart
//   dart run flutter_launcher_icons
//   dart run flutter_native_splash:create
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cmfi_connect/src/core/theme/app_colors.dart';
import 'package:cmfi_connect/src/core/widgets/cmfi_logo.dart';
import 'package:cmfi_connect/src/core/widgets/dove_mascot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _writePng(
  String name, {
  required int size,
  required double logoRatio,
  bool disc = false,
  Color? background,
  bool gradient = false,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final full = size.toDouble();
  final square = Rect.fromLTWH(0, 0, full, full);

  if (gradient) {
    // the prod icon: CMFI blue, lighter in the upper right
    canvas.drawRect(
      square,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(full * 0.75, full * 0.05),
          full * 1.1,
          const [AppColors.primary, AppColors.primaryDeep],
        ),
    );
  } else if (background != null) {
    canvas.drawRect(square, Paint()..color = background);
  }

  final logo = full * logoRatio;
  canvas.translate((full - logo) / 2, (full - logo) / 2);
  CmfiLogoPainter(disc: disc).paint(canvas, Size.square(logo));

  await _save(name, recorder, size);
}

/// Zoé in [pose], filling a transparent square.
Future<void> _writeMascotPng(DovePose pose, {required int size}) async {
  final recorder = ui.PictureRecorder();
  DovePainter(pose: pose).paint(Canvas(recorder), Size.square(size.toDouble()));
  await _save('mascot_${pose.name}.png', recorder, size);
}

Future<void> _save(String name, ui.PictureRecorder recorder, int size) async {
  final image = await recorder.endRecording().toImage(size, size);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  final file = File('assets/brand/$name')..createSync(recursive: true);
  file.writeAsBytesSync(bytes!.buffer.asUint8List());
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('generate brand images', () async {
    // iOS icons must be opaque squares: iOS rounds the corners itself.
    // Prod: the emblem on a white disc, on the CMFI blue.
    await _writePng(
      'icon_prod.png',
      size: 1024,
      logoRatio: 0.78,
      disc: true,
      gradient: true,
    );
    // Dev: the emblem alone on light blue, to tell them apart
    await _writePng(
      'icon_dev.png',
      size: 1024,
      logoRatio: 0.74,
      background: AppColors.primarySoft,
    );

    // Android adaptive icons: transparent foreground inside the 66 % safe zone
    await _writePng(
      'icon_foreground_prod.png',
      size: 1024,
      logoRatio: 0.56,
      disc: true,
    );
    await _writePng('icon_foreground_dev.png', size: 1024, logoRatio: 0.54);

    // Splash, on the dark blue: the image is treated as xxxhdpi (4x): 480 px ≈ 120 dp
    await _writePng('splash_logo.png', size: 480, logoRatio: 1, disc: true);
    // Android 12+: 960 px canvas, only the inner circle (≈ 2/3) is visible
    await _writePng(
      'splash_logo_android12.png',
      size: 960,
      logoRatio: 0.56,
      disc: true,
    );
  });

  test('generate mascot images', () async {
    // mascot_joy.png, mascot_cheer.png…: one per pose, for the home-screen widget
    for (final pose in DovePose.values) {
      await _writeMascotPng(pose, size: 512);
    }
  });
}
