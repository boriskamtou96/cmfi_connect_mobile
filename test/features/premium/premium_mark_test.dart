import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('with Premium, a gold seal on the photo (home and Plus)', (
    tester,
  ) async {
    await pumpApp(tester, token: 't', premium: FakePremiumStore(active: true));

    expect(find.byIcon(AppIcons.premiumSeal), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Membre Premium')), findsOneWidget);

    await openProfile(tester);
    expect(find.byIcon(AppIcons.premiumSeal), findsWidgets);
  });

  testWidgets('without Premium, no seal', (tester) async {
    await pumpApp(tester, token: 't');

    expect(find.byIcon(AppIcons.premiumSeal), findsNothing);
    await openProfile(tester);
    expect(find.byIcon(AppIcons.premiumSeal), findsNothing);
  });
}
