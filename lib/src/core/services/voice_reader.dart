import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_reader.g.dart';

/// Reads a text aloud with the phone's own voice (flutter_tts: offline, in
/// the voices the phone has), a little slower than usual, for praying with
/// the eyes closed. Behind a provider so tests hear nothing.
abstract class VoiceReader {
  /// Reads [text] in [language] ("fr", "en"…), after stopping what was read.
  Future<void> speak(String text, String language);

  Future<void> stop();
}

class DeviceVoiceReader implements VoiceReader {
  DeviceVoiceReader();

  final _tts = FlutterTts();
  String? _language;

  /// The voice of each language of the app.
  static const _voices = {
    'fr': 'fr-FR',
    'en': 'en-US',
    'de': 'de-DE',
    'es': 'es-ES',
    'ar': 'ar-SA',
    'hi': 'hi-IN',
    'zh': 'zh-CN',
  };

  @override
  Future<void> speak(String text, String language) async {
    try {
      await _tts.stop();
      if (_language != language) {
        _language = language;
        await _tts.setLanguage(_voices[language] ?? 'fr-FR');
        await _tts.setSpeechRate(0.45);
        // the sound of a retreat goes on while it reads, with the music of
        // other apps lowered
        await _tts.setIosAudioCategory(IosTextToSpeechAudioCategory.playback, [
          IosTextToSpeechAudioCategoryOptions.duckOthers,
        ]);
      }
      await _tts.speak(text);
    } on Object {
      // a phone without the voice: the text is on screen anyway
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _tts.stop();
    } on Object {
      // nothing was being read
    }
  }
}

@Riverpod(keepAlive: true)
VoiceReader voiceReader(Ref ref) => DeviceVoiceReader();
