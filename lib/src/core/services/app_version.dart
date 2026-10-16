import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_version.g.dart';

/// "1.0.0 (1)": the version of the app and its build, at the bottom of Plus.
/// Answered by MainActivity.kt and AppDelegate.swift; '' when they can't
/// (tests, web).
@Riverpod(keepAlive: true)
Future<String> appVersion(Ref ref) async {
  const channel = MethodChannel('cmficonnect/app');
  try {
    final version = await channel.invokeMethod<String>('version') ?? '';
    final build = await channel.invokeMethod<String>('build') ?? '';
    return build.isEmpty || version.isEmpty ? version : '$version ($build)';
  } on PlatformException {
    return '';
  } on MissingPluginException {
    return '';
  }
}
