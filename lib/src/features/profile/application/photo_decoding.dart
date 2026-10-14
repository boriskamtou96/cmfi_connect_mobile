import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_decoding.g.dart';

/// Reads a picked picture into pixels, upright.
typedef PhotoDecoder = Future<ui.Image> Function(Uint8List bytes);

/// Behind a provider: the tests give pictures decoded beforehand (decoding
/// needs real time, which widget tests don't have).
@riverpod
PhotoDecoder photoDecoder(Ref ref) => decodeImageFromList;
