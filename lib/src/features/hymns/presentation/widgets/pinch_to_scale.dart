import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Pinch with two fingers to zoom the text. It listens to raw pointers, so it doesn't fight
/// the page swipe or the scroll; [onPinching] lets the parent freeze them meanwhile.
class PinchToScale extends StatefulWidget {
  const PinchToScale({
    required this.child,
    required this.scale,
    required this.onScale,
    required this.onEnd,
    required this.onPinching,
    super.key,
  });

  final Widget child;

  /// The current scale, when the pinch starts.
  final double scale;
  final ValueChanged<double> onScale;
  final VoidCallback onEnd;
  final ValueChanged<bool> onPinching;

  @override
  State<PinchToScale> createState() => _PinchToScaleState();
}

class _PinchToScaleState extends State<PinchToScale> {
  final _pointers = <int, Offset>{};
  double? _startDistance;
  double _startScale = 1;

  double get _distance {
    final points = _pointers.values.take(2).toList();
    return (points[0] - points[1]).distance;
  }

  void _down(PointerDownEvent event) {
    _pointers[event.pointer] = event.position;
    if (_pointers.length == 2) {
      _startDistance = math.max(_distance, 1);
      _startScale = widget.scale;
      widget.onPinching(true);
    }
  }

  void _move(PointerMoveEvent event) {
    if (!_pointers.containsKey(event.pointer)) {
      return;
    }
    _pointers[event.pointer] = event.position;
    final start = _startDistance;
    if (start != null && _pointers.length >= 2) {
      widget.onScale(_startScale * _distance / start);
    }
  }

  void _up(PointerEvent event) {
    _pointers.remove(event.pointer);
    if (_startDistance != null && _pointers.length < 2) {
      _startDistance = null;
      widget.onPinching(false);
      widget.onEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _down,
      onPointerMove: _move,
      onPointerUp: _up,
      onPointerCancel: _up,
      child: widget.child,
    );
  }
}
