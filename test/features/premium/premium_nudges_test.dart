import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/features/premium/application/premium_end.dart';
import 'package:cmfi_connect/src/features/premium/application/premium_nudge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  test('Premium ending: told 7 days and 1 day before, at 10:00', () async {
    final notifications = FakeLocalNotifications();
    final now = DateTime(2026, 11, 5, 9);
    await planPremiumEnd(
      notifications,
      until: DateTime(2026, 12, 12, 15),
      now: now,
    );

    final planned = notifications.groups[NotificationGroup.premiumEnd]!;
    expect(planned.map((n) => n.at), [
      DateTime(2026, 12, 5, 10),
      DateTime(2026, 12, 11, 10),
    ]);
    expect(planned.first.title, 'Ton Premium se termine bientôt');
    expect(planned.first.body, contains('12 décembre'));
    expect(planned.last.title, 'Ton Premium se termine demain');
    expect(planned.every((n) => n.payload == premiumEndPayload), isTrue);

    // 3 days left: only tomorrow's is still ahead
    expect(premiumEndTimes(DateTime(2026, 11, 8, 12), now: now), [
      DateTime(2026, 11, 7, 10),
    ]);

    // for life, or no Premium: nothing
    await planPremiumEnd(notifications, until: null, now: now);
    expect(notifications.groups[NotificationGroup.premiumEnd] ?? [], isEmpty);
  });

  test(
    'the Premium card of the home screen: a week in a row, once a month',
    () {
      final now = DateTime(2026, 11, 5);
      bool shown({bool premium = false, int streak = 7, DateTime? hidden}) =>
          showPremiumNudge(
            premium: premium,
            streak: streak,
            hidden: hidden,
            now: now,
          );

      expect(shown(), isTrue);
      expect(shown(premium: true), isFalse);
      expect(shown(streak: 6), isFalse);
      expect(shown(hidden: now.subtract(const Duration(days: 10))), isFalse);
      expect(shown(hidden: now.subtract(const Duration(days: 30))), isTrue);
    },
  );
}
