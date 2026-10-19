import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('with Premium, a crown on the photo (home and Plus)', (
    tester,
  ) async {
    await pumpApp(tester, token: 't', premium: FakePremiumStore(active: true));

    // the gold crown over its white outline
    expect(find.byIcon(AppIcons.premiumCrown), findsNWidgets(2));
    expect(find.bySemanticsLabel(RegExp('Membre Premium')), findsOneWidget);

    await openMore(tester);
    expect(find.byIcon(AppIcons.premiumCrown), findsWidgets);
  });

  testWidgets('without Premium, no crown', (tester) async {
    await pumpApp(tester, token: 't');

    expect(find.byIcon(AppIcons.premiumCrown), findsNothing);
    await openMore(tester);
    expect(find.byIcon(AppIcons.premiumCrown), findsNothing);
  });
}
