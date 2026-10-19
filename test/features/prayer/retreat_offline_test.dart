import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/prayer/application/retreats.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/profile/application/current_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('a retreat opens at once on a network that does not answer, '
      'with what the phone keeps', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {
        'prayer_retreat_extras': jsonEncode({
          'assembly': 'Assemblée de Mvolyé',
        }),
      },
    );
    app.profileApi.slow = true;
    app.container.invalidate(currentProfileProvider);

    final plan = app.container.read(
      retreatPlanProvider(RetreatMoment.noon, 'fr').future,
    );
    // 2 seconds at most, not the 15 of the network
    await tester.pump(const Duration(seconds: 3));
    final points = await plan;
    expect(points, hasLength(15));
    expect(points[2].value, 'Assemblée de Mvolyé');
  });
}
