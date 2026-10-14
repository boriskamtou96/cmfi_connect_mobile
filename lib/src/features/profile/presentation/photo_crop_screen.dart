import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_spacing.dart';
import '../application/photo_decoding.dart';
import '../domain/photo_crop.dart';

/// The chosen picture in a circle: the user moves it and zooms with two
/// fingers, then keeps it. Gives back the square the circle shows, as a PNG
/// of [photoSide] pixels (null when the user gives up).
@RoutePage()
class PhotoCropScreen extends HookConsumerWidget {
  const PhotoCropScreen({required this.bytes, super.key});

  /// The picture as picked (JPEG or PNG).
  final Uint8List bytes;

  /// The circle, at most this wide on a large screen.
  static const _maxViewport = 420.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.profilePhoto;
    final decode = ref.watch(photoDecoderProvider);
    final decoding = useMemoized(() => decode(bytes), [bytes]);
    final snapshot = useFuture(decoding);
    final image = snapshot.data;
    final controller = useTransformationController();
    final saving = useState(false);
    final viewport = math.min(
      MediaQuery.sizeOf(context).width - AppSpacing.xl * 2,
      _maxViewport,
    );

    useEffect(
      () =>
          () => image?.dispose(),
      [image],
    );

    // the picture covers the circle, centered
    final size = image == null
        ? null
        : Size(image.width.toDouble(), image.height.toDouble());
    final laidOut = size == null ? null : size * coverScale(size, viewport);
    useEffect(() {
      if (laidOut != null) {
        controller.value = Matrix4.translationValues(
          -(laidOut.width - viewport) / 2,
          -(laidOut.height - viewport) / 2,
          0,
        );
      }
      return null;
    }, [image, viewport]);

    Future<void> keep() async {
      if (image == null || size == null) {
        return;
      }
      final matrix = controller.value;
      final translation = matrix.getTranslation();
      final part = visiblePart(
        image: size,
        viewport: viewport,
        zoom: matrix.getMaxScaleOnAxis(),
        offset: Offset(translation.x, translation.y),
      );
      saving.value = true;
      final png = await squarePng(image, part);
      if (context.mounted) {
        await context.router.maybePop(png);
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 56,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => context.router.maybePop(),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: Text(context.t.common.cancel),
                    ),
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          t.cropTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    // balances the cancel button, so the title is centered
                    const SizedBox(width: 88),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: snapshot.hasError
                      ? Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Text(
                            t.unreadable,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      : laidOut == null
                      ? const CircularProgressIndicator(color: Colors.white)
                      : SizedBox.square(
                          dimension: viewport,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRect(
                                child: InteractiveViewer(
                                  transformationController: controller,
                                  constrained: false,
                                  minScale: 1,
                                  maxScale: 6,
                                  child: SizedBox(
                                    width: laidOut.width,
                                    height: laidOut.height,
                                    child: RawImage(
                                      image: image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              const IgnorePointer(
                                child: CustomPaint(painter: _CircleMask()),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  0,
                  AppSpacing.xl,
                  AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      t.cropHint,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    FilledButton(
                      onPressed: laidOut == null || saving.value ? null : keep,
                      child: saving.value
                          ? const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Text(t.use),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The square [part] of [image] (in its pixels), as a PNG of [photoSide]
/// pixels.
Future<Uint8List> squarePng(ui.Image image, Rect part) async {
  const side = photoSide;
  final recorder = ui.PictureRecorder();
  Canvas(recorder).drawImageRect(
    image,
    part,
    Rect.fromLTWH(0, 0, side.toDouble(), side.toDouble()),
    Paint()..filterQuality = FilterQuality.high,
  );
  final picture = recorder.endRecording();
  final square = await picture.toImage(side, side);
  picture.dispose();
  try {
    final data = await square.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  } finally {
    square.dispose();
  }
}

/// Darkens what is outside the circle, and draws the circle.
class _CircleMask extends CustomPainter {
  const _CircleMask();

  @override
  void paint(Canvas canvas, Size size) {
    final square = Offset.zero & size;
    canvas
      ..drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(square),
          Path()..addOval(square),
        ),
        Paint()..color = Colors.black.withValues(alpha: 0.6),
      )
      ..drawCircle(
        square.center,
        size.shortestSide / 2 - 1,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.white.withValues(alpha: 0.9),
      );
  }

  @override
  bool shouldRepaint(_CircleMask oldDelegate) => false;
}
