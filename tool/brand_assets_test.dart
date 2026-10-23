// Generates the brand images (app icons, splash) from the CmfiLogo painter (the mark:
// the open ring and the gold cross) and AppIconPainter, so the icons always match the
// logo drawn in the app, and the images of Zoé, the
// mascot, from the DovePainter (for the native home-screen widget).
//
// Run, then regenerate icons and splash:
//   flutter test tool/brand_assets_test.dart
//   dart run flutter_launcher_icons
//   dart run flutter_native_splash:create
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cmfi_connect/src/core/widgets/cmfi_logo.dart';
import 'package:cmfi_connect/src/core/widgets/dove_mascot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The logo (the mark, or its night medallion with [disc]) at [logoRatio] of a
/// transparent square.
Future<void> _writePng(
  String name, {
  required int size,
  required double logoRatio,
  bool disc = false,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final full = size.toDouble();
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

/// The whole app icon (the night tile, its glowing edge, the mark).
Future<void> _writeIconPng(String name, {bool dev = false}) async {
  final recorder = ui.PictureRecorder();
  AppIconPainter(dev: dev).paint(Canvas(recorder), const Size.square(1024));
  await _save(name, recorder, 1024);
}

/// The mark alone, white ring and gold cross, centered on a transparent square.
Future<void> _writeMarkPng(
  String name, {
  required int size,
  required double ratio,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final full = size.toDouble();
  final mark = full * ratio;
  canvas
    ..translate((full - mark) / 2, (full - mark) / 2)
    ..scale(mark / 100);
  CmfiLogoPainter.paintMark(canvas, onDark: true);
  await _save(name, recorder, size);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('generate brand images', () async {
    // iOS icons must be opaque squares: iOS rounds the corners itself.
    // Prod: the night tile with its glowing edge; dev: on the CMFI blue
    await _writeIconPng('icon_prod.png');
    await _writeIconPng('icon_dev.png', dev: true);

    // Android adaptive icons: the mark inside the 66 % safe zone, on the
    // background color of flutter_launcher_icons-*.yaml
    await _writeMarkPng('icon_foreground_prod.png', size: 1024, ratio: 0.86);
    await _writeMarkPng('icon_foreground_dev.png', size: 1024, ratio: 0.86);

    // Splash, on the night: the image is treated as xxxhdpi (4x): 480 px ≈ 120 dp
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
