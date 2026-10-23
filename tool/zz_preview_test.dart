// Temporary: captures of the redesign, with the real fonts (deleted after).
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../test/helpers/pump_app.dart';

Future<void> _font(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    loader.addFont(Future.value(ByteData.sublistView(File(file).readAsBytesSync())));
  }
  await loader.load();
}

Future<void> _shot(WidgetTester tester, String name) async {
  // let the photos decode
  for (var i = 0; i < 3; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 400)));
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.pumpAndSettle();
  final render = tester.binding.renderViews.first;
  final layer = render.debugLayer! as OffsetLayer;
  await tester.runAsync(() async {
    final image = await layer.toImage(Offset.zero & tester.view.physicalSize);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File('build/preview/$name.png').writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
    await _font('Onest', [
      for (final w in ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold'])
        'assets/fonts/Onest-$w.ttf',
    ]);
    await _font('Lora', ['assets/fonts/Lora-Regular.ttf', 'assets/fonts/Lora-SemiBold.ttf']);
    final ph = '${Platform.environment['HOME']}/.pub-cache/hosted/pub.dev/phosphor_flutter-2.1.0/lib/fonts';
    for (final (f, file) in [('Regular', 'Phosphor'), ('Bold', 'Phosphor-Bold'), ('Fill', 'Phosphor-Fill'), ('Duotone', 'Phosphor-Duotone')]) {
      await _font('packages/phosphor_flutter/Phosphor$f', ['$ph/$file.ttf']);
    }
  });
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  void phone(WidgetTester tester) {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    tester.view.padding = const FakeViewPadding(top: 141, bottom: 102);
    tester.view.viewPadding = const FakeViewPadding(top: 141, bottom: 102);
    addTearDown(tester.view.reset);
  }

  for (final dark in [false, true]) {
    testWidgets('welcome ${dark ? 'dark' : 'light'}', (tester) async {
      phone(tester);
      tester.platformDispatcher.platformBrightnessTestValue = dark ? Brightness.dark : Brightness.light;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
      await pumpApp(tester, onboardingSeen: false);
      for (var i = 1; i <= (dark ? 1 : 3); i++) {
        await _shot(tester, 'welcome_${dark ? 'dark' : 'light'}_$i');
        if (i < 3) {
          await tester.tap(find.text('Continuer'));
          await tester.pumpAndSettle();
        }
      }
    });
  }

  testWidgets('home, menu, profile, settings', (tester) async {
    phone(tester);
    await pumpApp(tester, token: 'saved-token');
    await _shot(tester, 'home');
    await openMenu(tester);
    await _shot(tester, 'menu');
    await tester.tap(find.text('Voir mon profil'));
    await tester.pumpAndSettle();
    await _shot(tester, 'profile');
    await tester.tap(find.byTooltip('Réglages'));
    await tester.pumpAndSettle();
    await _shot(tester, 'settings');
  });
}
