import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show SelectedContent;

/// Puts [separator] between the selected texts of its children: Flutter glues them
/// together, so copied lines would run into each other.
class JoinedSelection extends StatefulWidget {
  const JoinedSelection({
    required this.separator,
    required this.child,
    super.key,
  });

  final String separator;
  final Widget child;

  @override
  State<JoinedSelection> createState() => _JoinedSelectionState();
}

class _JoinedSelectionState extends State<JoinedSelection> {
  late final _delegate = _JoinedDelegate(widget.separator);

  @override
  void dispose() {
    _delegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      SelectionContainer(delegate: _delegate, child: widget.child);
}

class _JoinedDelegate extends StaticSelectionContainerDelegate {
  _JoinedDelegate(this.separator);

  final String separator;

  @override
  SelectedContent? getSelectedContent() {
    final texts = [
      for (final selectable in selectables)
        ?selectable.getSelectedContent()?.plainText,
    ].where((text) => text.isNotEmpty);
    return texts.isEmpty
        ? null
        : SelectedContent(plainText: texts.join(separator));
  }
}
