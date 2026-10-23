import 'package:flutter/material.dart';

/// The settings of a story, like the knobs of a storybook: the story asks
/// for them while it builds ([boolean], [slider], [options], [text]); the
/// first ask gives the starting value, the panel under the preview changes
/// it, and the story builds again.
class Knobs extends ChangeNotifier {
  final _knobs = <String, Knob>{};

  /// The knobs asked by the story, in the order it asked them.
  Iterable<Knob> get all => _knobs.values;

  bool boolean(String label, {bool initial = false}) =>
      (_knobs.putIfAbsent(label, () => _BoolKnob(label, initial)) as _BoolKnob)
          .value;

  double slider(
    String label, {
    required double initial,
    required double min,
    required double max,
    int? divisions,
  }) =>
      (_knobs.putIfAbsent(
                label,
                () => _SliderKnob(label, initial, min, max, divisions),
              )
              as _SliderKnob)
          .value;

  /// One of [values], shown by [name].
  T options<T>(
    String label, {
    required List<T> values,
    required String Function(T value) name,
    T? initial,
  }) {
    final knob =
        _knobs.putIfAbsent(
              label,
              () =>
                  _OptionsKnob<T>(label, values, name, initial ?? values.first),
            )
            as _OptionsKnob<T>;
    return knob.value;
  }

  String text(String label, {required String initial}) =>
      (_knobs.putIfAbsent(label, () => _TextKnob(label, initial)) as _TextKnob)
          .value;

  void _changed() => notifyListeners();
}

/// A knob: its label and its control in the panel.
sealed class Knob {
  Knob(this.label);

  final String label;

  /// Its control in the panel.
  Widget control(Knobs knobs);
}

final class _BoolKnob extends Knob {
  _BoolKnob(super.label, this.value);

  bool value;

  @override
  Widget control(Knobs knobs) => SwitchListTile(
    title: Text(label),
    value: value,
    onChanged: (next) {
      value = next;
      knobs._changed();
    },
  );
}

final class _SliderKnob extends Knob {
  _SliderKnob(super.label, this.value, this.min, this.max, this.divisions);

  double value;
  final double min;
  final double max;
  final int? divisions;

  @override
  Widget control(Knobs knobs) => ListTile(
    title: Text('$label : ${value.toStringAsFixed(value < 10 ? 2 : 0)}'),
    subtitle: Slider(
      value: value,
      min: min,
      max: max,
      divisions: divisions,
      onChanged: (next) {
        value = next;
        knobs._changed();
      },
    ),
  );
}

final class _OptionsKnob<T> extends Knob {
  _OptionsKnob(super.label, this.values, this.name, this.value);

  final List<T> values;
  final String Function(T value) name;
  T value;

  @override
  Widget control(Knobs knobs) => ListTile(
    title: Text(label),
    subtitle: Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final option in values)
          ChoiceChip(
            label: Text(name(option)),
            selected: option == value,
            onSelected: (_) {
              value = option;
              knobs._changed();
            },
          ),
      ],
    ),
  );
}

final class _TextKnob extends Knob {
  _TextKnob(super.label, this.value);

  String value;

  @override
  Widget control(Knobs knobs) => ListTile(
    title: Text(label),
    subtitle: TextFormField(
      initialValue: value,
      onChanged: (next) {
        value = next;
        knobs._changed();
      },
    ),
  );
}
