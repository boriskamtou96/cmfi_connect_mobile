import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/widgets/reader/reader_palette.dart';
import '../domain/bible_version.dart';

part 'bible_settings.freezed.dart';
part 'bible_settings.g.dart';

/// How the Bible is read, remembered on the phone.
@freezed
abstract class BibleSettings with _$BibleSettings {
  const factory BibleSettings({
    /// The version chosen (its id); null: the one of the app's language.
    String? version,

    /// 1 = normal size. From [minScale] to [maxScale].
    @Default(1.0) double textScale,
    @Default(ReaderTheme.auto) ReaderTheme theme,

    /// The classic font (Lora), else the app's.
    @Default(true) bool serif,

    /// The words of Jesus in red, as in many printed Bibles.
    @Default(true) bool jesusInRed,

    /// Keep the screen on while a chapter is open.
    @Default(true) bool keepScreenOn,
  }) = _BibleSettings;

  const BibleSettings._();

  factory BibleSettings.fromJson(Map<String, dynamic> json) =>
      _$BibleSettingsFromJson(json);

  static const minScale = 0.8;
  static const maxScale = 2.4;
  static const step = 0.15;
}

@Riverpod(keepAlive: true)
class BibleSettingsController extends _$BibleSettingsController {
  static const _key = 'bible_reader';

  @override
  BibleSettings build() {
    final json = ref.watch(sharedPreferencesProvider).getString(_key);
    if (json == null) {
      return const BibleSettings();
    }
    try {
      return BibleSettings.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } on Object {
      return const BibleSettings();
    }
  }

  Future<void> update(
    BibleSettings Function(BibleSettings settings) change,
  ) async {
    state = change(state);
    await ref
        .read(sharedPreferencesProvider)
        .setString(_key, jsonEncode(state.toJson()));
  }

  /// While pinching: shows the new size without writing it each frame. [save]
  /// at the end.
  void preview(double scale) => state = state.copyWith(
    textScale: scale.clamp(BibleSettings.minScale, BibleSettings.maxScale),
  );

  Future<void> save() => setScale(state.textScale);

  /// Changes the text size by [steps] (negative: smaller), within the limits.
  Future<void> zoom(int steps) =>
      setScale(state.textScale + steps * BibleSettings.step);

  Future<void> setScale(double scale) => update(
    (settings) => settings.copyWith(
      textScale: double.parse(
        scale
            .clamp(BibleSettings.minScale, BibleSettings.maxScale)
            .toStringAsFixed(2),
      ),
    ),
  );
}

/// The version read: the one chosen, else the one of the app's language.
@Riverpod(keepAlive: true)
BibleVersion bibleVersion(Ref ref) {
  final chosen = ref.watch(bibleSettingsControllerProvider).version;
  // read again when the language of the app changes
  ref.watch(savedLanguageProvider);
  return bibleVersionOf(chosen) ??
      defaultBibleVersion(LocaleSettings.currentLocale.languageCode);
}
