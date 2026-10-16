import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('the eye hides the numbers of the summary, and remembers', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    expect(find.textContaining('/'), findsWidgets);
    expect(find.text('••'), findsNothing);

    await tester.tap(find.byTooltip('Masquer mes chiffres'));
    await tester.pumpAndSettle();

    // the items, the retreats and the streak (no goal set: —)
    expect(find.text('••'), findsNWidgets(3));
    expect(find.bySemanticsLabel(RegExp(r': masqué$')), findsWidgets);
    expect(app.preferences.getBool('home_numbers_hidden'), isTrue);

    await tester.tap(find.byTooltip('Afficher mes chiffres'));
    await tester.pumpAndSettle();
    expect(find.text('••'), findsNothing);
    expect(app.preferences.getBool('home_numbers_hidden'), isFalse);
  });

  testWidgets('hidden at the next launch too', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'home_numbers_hidden': true},
    );

    expect(find.text('••'), findsNWidgets(3));
    expect(find.byTooltip('Afficher mes chiffres'), findsOneWidget);
  });
}
