import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('the bottom of Plus: the name, the version and the copyright', (
    tester,
  ) async {
    final messenger = tester.binding.defaultBinaryMessenger;
    const channel = MethodChannel('cmficonnect/app');
    messenger.setMockMethodCallHandler(
      channel,
      (call) async => switch (call.method) {
        'version' => '1.0.0',
        'build' => '7',
        _ => null,
      },
    );
    addTearDown(() => messenger.setMockMethodCallHandler(channel, null));

    await pumpApp(tester, token: 't');
    await openMore(tester);
    await tester.pumpAndSettle();
    await scrollToEnd(tester);

    expect(find.text('CMFI Connect'), findsWidgets);
    expect(find.text('Version 1.0.0 (7)'), findsOneWidget);
    expect(
      find.text(
        '© ${DateTime.now().year} Communauté Missionnaire Chrétienne '
        'Internationale. Tous droits réservés.',
      ),
      findsOneWidget,
    );
  });
}
