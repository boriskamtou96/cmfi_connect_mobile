import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/globe_math.dart';

part 'land.g.dart';

/// The land of the globe: 4233 points of a regular grid of the sphere kept
/// where they fall on land, from Natural Earth 1:110m countries (public
/// domain, naturalearthdata.com). assets/ministry/land_dots.bin holds, for
/// each point, its latitude and longitude in hundredths of a degree (two
/// little-endian int16).
@Riverpod(keepAlive: true)
Future<List<SpherePoint>> landDots(Ref ref) async {
  final data = await rootBundle.load('assets/ministry/land_dots.bin');
  return decodeLandDots(data);
}

List<SpherePoint> decodeLandDots(ByteData data) => [
  for (var i = 0; i + 4 <= data.lengthInBytes; i += 4)
    spherePoint(
      data.getInt16(i, Endian.little) / 100,
      data.getInt16(i + 2, Endian.little) / 100,
    ),
];
