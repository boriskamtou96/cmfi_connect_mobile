import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// The picture of what the `RepaintBoundary` with [key] paints, as a PNG
/// [width] pixels wide (a card shared as an image). It must be on screen.
Future<Uint8List> pngOf(GlobalKey key, {required double width}) async {
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: width / boundary.size.width);
  try {
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  } finally {
    image.dispose();
  }
}
