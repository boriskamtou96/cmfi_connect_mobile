import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../../../core/widgets/reader/reader_palette.dart';

export '../../../core/widgets/reader/reader_palette.dart' show ReaderTheme;

part 'hymn_reader_settings.freezed.dart';
part 'hymn_reader_settings.g.dart';

/// auto: the modern font for normal sizes, the serif one when the text gets big.
enum HymnTypeface { auto, sans, serif }

/// How hymns are displayed, remembered on the phone.
@freezed
abstract class HymnReaderSettings with _$HymnReaderSettings {
  const factory HymnReaderSettings({
    /// 1 = normal size. From [minScale] to [maxScale].
    @Default(1.0) double textScale,
    @Default(HymnTypeface.auto) HymnTypeface typeface,
    @Default(ReaderTheme.auto) ReaderTheme theme,

    /// Show the chorus again after each verse.
    @Default(false) bool repeatChorus,

    /// Keep the screen on while a hymn is open.
    @Default(true) bool keepScreenOn,
  }) = _HymnReaderSettings;

  const HymnReaderSettings._();

  factory HymnReaderSettings.fromJson(Map<String, dynamic> json) =>
      _$HymnReaderSettingsFromJson(json);

  static const minScale = 0.8;
  static const maxScale = 2.6;
  static const step = 0.15;

  /// From this size on, auto switches to the serif font.
  static const serifFrom = 1.3;

  bool get usesSerif =>
      typeface == HymnTypeface.serif ||
      (typeface == HymnTypeface.auto && textScale >= serifFrom);
}

@Riverpod(keepAlive: true)
class HymnReaderSettingsController extends _$HymnReaderSettingsController {
  static const _key = 'hymn_reader';

  @override
  HymnReaderSettings build() {
    final json = ref.watch(sharedPreferencesProvider).getString(_key);
    if (json == null) {
      return const HymnReaderSettings();
    }
    try {
      return HymnReaderSettings.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
    } on Object {
      return const HymnReaderSettings();
    }
  }

  Future<void> update(
    HymnReaderSettings Function(HymnReaderSettings settings) change,
  ) async {
    state = change(state);
    await ref
        .read(sharedPreferencesProvider)
        .setString(_key, jsonEncode(state.toJson()));
  }

  /// While pinching: shows the new size without writing it each frame. [save] at the end.
  void preview(double scale) => state = state.copyWith(
    textScale: scale.clamp(
      HymnReaderSettings.minScale,
      HymnReaderSettings.maxScale,
    ),
  );

  Future<void> save() => setScale(state.textScale);

  /// Changes the text size by [steps] (negative: smaller), within the limits.
  Future<void> zoom(int steps) =>
      setScale(state.textScale + steps * HymnReaderSettings.step);

  Future<void> setScale(double scale) => update(
    (settings) => settings.copyWith(
      textScale: double.parse(
        scale
            .clamp(HymnReaderSettings.minScale, HymnReaderSettings.maxScale)
            .toStringAsFixed(2),
      ),
    ),
  );
}
