import 'package:cmfi_connect/src/core/services/app_update.dart';
import 'package:flutter_test/flutter_test.dart';

AppVersion v(String text) => AppVersion.tryParse(text)!;

void main() {
  group('AppVersion', () {
    test('reads a version, with or without its build', () {
      expect(v('1.0.21').numbers, [1, 0, 21]);
      expect(v('1.0.21').build, isNull);
      expect(v(' 1.0.21+55 ').build, 55);
      expect('${v('1.0.21+55')}', '1.0.21');
    });

    test('anything else is no version', () {
      for (final text in ['', 'beta', '1.0.x', '1.0.21+b', '1..2', '1+2+3']) {
        expect(AppVersion.tryParse(text), isNull, reason: text);
      }
    });

    test('compares the numbers, then the builds when both have one', () {
      expect(v('1.0.9') < v('1.0.10'), isTrue);
      expect(v('1.2').compareTo(v('1.2.0')), 0);
      expect(v('2.0') < v('1.9.9'), isFalse);
      expect(v('1.0.21+55') < v('1.0.21+56'), isTrue);
      expect(v('1.0.21').compareTo(v('1.0.21+56')), 0);
    });
  });

  group('AppUpdateStatus', () {
    test('below the minimum: required, toward the latest version', () {
      final status = AppUpdateStatus.of(
        v('1.0.20+50'),
        UpdateRules(minimum: v('1.0.21'), latest: v('1.0.23')),
      );
      expect(status.need, UpdateNeed.required);
      expect('${status.target}', '1.0.23');
    });

    test('below the latest version only: optional', () {
      final status = AppUpdateStatus.of(
        v('1.0.21+55'),
        UpdateRules(minimum: v('1.0.21'), latest: v('1.0.22')),
      );
      expect(status.need, UpdateNeed.optional);
      expect('${status.target}', '1.0.22');
    });

    test('up to date, no rules, or the version unknown: nothing', () {
      final rules = UpdateRules(minimum: v('1.0.21'), latest: v('1.0.21'));
      expect(AppUpdateStatus.of(v('1.0.21'), rules).need, UpdateNeed.none);
      expect(
        AppUpdateStatus.of(v('1.0.21'), UpdateRules.none).need,
        UpdateNeed.none,
      );
      expect(AppUpdateStatus.of(null, rules).need, UpdateNeed.none);
    });

    test('a latest version below the minimum: the minimum is the target', () {
      final status = AppUpdateStatus.of(
        v('1.0.1'),
        UpdateRules(minimum: v('1.0.21'), latest: v('1.0.3')),
      );
      expect('${status.target}', '1.0.21');
    });

    test('the word of the admins, in the language of the phone', () {
      final status = AppUpdateStatus.of(
        v('1.0.1'),
        UpdateRules(
          latest: v('1.0.2'),
          messages: const {'fr': 'Bonjour', 'en': 'Hello'},
        ),
      );
      expect(status.messageIn('en'), 'Hello');
      expect(status.messageIn('de'), 'Bonjour');
      expect(const AppUpdateStatus().messageIn('fr'), '');
    });
  });
}
