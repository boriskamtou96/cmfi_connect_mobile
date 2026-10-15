import 'package:flutter/gestures.dart' show Drag;
import 'package:flutter/material.dart';

/// Swipes a [PageView] of selectable text (a hymn, a Bible chapter). On Android
/// the text selection takes every horizontal drag that starts on the words, so
/// the drag is caught here first and handed to the pages.
class PageSwipe extends StatefulWidget {
  const PageSwipe({
    required this.controller,
    required this.enabled,
    required this.child,
    super.key,
  });

  final PageController controller;
  final bool enabled;
  final Widget child;

  @override
  State<PageSwipe> createState() => _PageSwipeState();
}

class _PageSwipeState extends State<PageSwipe> {
  Drag? _drag;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }
    return GestureDetector(
      onHorizontalDragStart: (details) =>
          _drag = widget.controller.position.drag(details, () => _drag = null),
      onHorizontalDragUpdate: (details) => _drag?.update(details),
      onHorizontalDragEnd: (details) => _drag?.end(details),
      onHorizontalDragCancel: () => _drag?.cancel(),
      child: widget.child,
    );
  }
}
