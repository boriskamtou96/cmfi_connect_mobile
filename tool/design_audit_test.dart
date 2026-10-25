// Temporary: raw screens of the app for a design audit.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../test/helpers/bible_fakes.dart';
import '../test/helpers/fakes.dart';
import '../test/helpers/pump_app.dart';

const _activities = [
  ActivityType(
    id: 1,
    code: 'LB',
    label: 'Lecture biblique',
    tracksQuantity: true,
    quantityUnit: 'chapitres',
    isStandard: true,
  ),
  ActivityType(
    id: 2,
    code: 'PS',
    label: 'Prière seule',
    tracksDuration: true,
    isStandard: true,
  ),
  ActivityType(
    id: 3,
    code: 'EV',
    label: 'Évangélisation',
    tracksQuantity: true,
    quantityUnit: 'personnes',
    isStandard: true,
  ),
  ActivityType(
    id: 4,
    code: 'MV',
    label: 'Mémorisation',
    tracksQuantity: true,
    quantityUnit: 'versets',
    isStandard: true,
  ),
];

ReportEntry _entry(int id, {int? quantity, int? minutes}) {
  final a = _activities.firstWhere((a) => a.id == id);
  return ReportEntry(
    activityTypeId: id,
    code: a.code,
    label: a.label,
    tracksQuantity: a.tracksQuantity,
    quantityUnit: a.quantityUnit,
    tracksDuration: a.tracksDuration,
    quantity: quantity,
    durationMinutes: minutes,
  );
}

Map<DateTime, DailyReport> _days() {
  final now = today();
  final days = <DateTime, DailyReport>{};
  for (var i = 0; i < 30; i++) {
    if (i % 9 == 4) continue;
    final day = DateTime(now.year, now.month, now.day - i);
    days[day] = DailyReport(
      date: day,
      submitted: true,
      entries: [
        _entry(1, quantity: 2 + (i % 3)),
        _entry(2, minutes: 45 + (i % 4) * 10),
        if (i % 2 == 0) _entry(3, quantity: 1 + (i % 2)),
        if (i % 3 == 0) _entry(4, quantity: 2),
      ],
    );
  }
  return days;
}

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(file).readAsBytesSync())),
    );
  }
  await loader.load();
}

Future<void> _settle(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 250)),
  );
  await tester.pumpAndSettle();
}

Future<void> _save(WidgetTester tester, GlobalKey key, String name) async {
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File('build/design_audit/$name.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}

AppRouter _router(TestApp app) => app.container.read(appRouterProvider);

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
    await _loadFont('Onest', [
      for (final weight in [
        'Regular',
        'Medium',
        'SemiBold',
        'Bold',
        'ExtraBold',
      ])
        'assets/fonts/Onest-$weight.ttf',
    ]);
    await _loadFont('Lora', [
      'assets/fonts/Lora-Regular.ttf',
      'assets/fonts/Lora-SemiBold.ttf',
      'assets/fonts/Lora-Italic.ttf',
    ]);
    final phosphor =
        '${Platform.environment['HOME']}/.pub-cache/hosted/pub.dev/'
        'phosphor_flutter-2.1.0/lib/fonts';
    for (final (family, file) in [
      ('Regular', 'Phosphor'),
      ('Bold', 'Phosphor-Bold'),
      ('Fill', 'Phosphor-Fill'),
      ('Duotone', 'Phosphor-Duotone'),
    ]) {
      await _loadFont('packages/phosphor_flutter/Phosphor$family', [
        '$phosphor/$file.ttf',
      ]);
    }
    await _loadFont('Noto Color Emoji', [
      '/System/Library/Fonts/Apple Color Emoji.ttc',
    ]);
  });
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  for (final dark in [false, true]) {
    testWidgets('audit ${dark ? 'dark' : 'light'}', (tester) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      tester.view.padding = const FakeViewPadding(top: 177, bottom: 102);
      tester.view.viewPadding = const FakeViewPadding(top: 177, bottom: 102);
      final key = GlobalKey();
      const books = [sampleHymnBook, sampleEnglishBook];
      final app = await pumpApp(
        tester,
        token: 't',
        account: sampleAccount,
        profile: const Profile(
          firstName: 'Grâce',
          lastName: 'Nkodo',
          phoneNumber: '+237690000001',
          city: 'Yaoundé',
          country: 'CM',
          church: 'CMCI Yaoundé',
          assembly: 'Assemblée de Mvolyé',
        ),
        activities: _activities,
        reportDays: _days(),
        hymnsApi: FakeHymnsApi(books: books),
        hymnStorage: FakeHymnBookStorage(bundled: books),
        bibleApi: FakeBibleApi(),
        screenKey: key,
        initialPreferences: {
          'report_goals': '{"1":{"quantity":3},"2":{"minutes":60}}',
          'theme_mode': dark ? 'dark' : 'light',
        },
      );
      final suffix = dark ? 'dark' : 'light';
      await _settle(tester);
      // the grace day popup, if the demo data has a missed day
      if (find.text('Merci !').evaluate().isNotEmpty) {
        await tester.tap(find.text('Merci !'));
        await _settle(tester);
      }
      await _save(tester, key, '01_home_$suffix');

      unawaitedNavigate(tester, _router(app).navigate(const ReportsRoute()));
      await _settle(tester);
      await _save(tester, key, '02_reports_$suffix');

      await tester.tap(find.text('Bilan'));
      await _settle(tester);
      await _save(tester, key, '03_summary_$suffix');

      unawaitedNavigate(tester, _router(app).navigate(const HymnsRoute()));
      await _settle(tester);
      await _save(tester, key, '04_hymns_$suffix');

      unawaitedNavigate(tester, _router(app).navigate(const PrayerRoute()));
      await _settle(tester);
      await _save(tester, key, '05_prayer_$suffix');

      unawaitedNavigate(tester, _router(app).navigate(const BibleRoute()));
      await _settle(tester);
      await _save(tester, key, '06_bible_$suffix');

      unawaitedNavigate(tester, _router(app).push(const ProfileRoute()));
      await _settle(tester);
      await _save(tester, key, '07_profile_$suffix');

      unawaitedNavigate(tester, _router(app).push(const SettingsRoute()));
      await _settle(tester);
      await _save(tester, key, '08_settings_$suffix');

      unawaitedNavigate(
        tester,
        _router(app).push(
          HymnReaderRoute(
            bookCode: 'rendons-ministere-1',
            number: 1,
          ),
        ),
      );
      await _settle(tester);
      await _save(tester, key, '09_hymn_reader_$suffix');

      unawaitedNavigate(
        tester,
        _router(app).push(EventRoute(eventId: 2)),
      );
      await _settle(tester);
      await _save(tester, key, '10_event_$suffix');

      unawaitedNavigate(tester, _router(app).navigate(const HomeRoute()));
      await _settle(tester);
      await tester.tap(find.byTooltip('Ouvrir le menu'));
      await _settle(tester);
      await _save(tester, key, '13_drawer_$suffix');
    });

    testWidgets('welcome and login ${dark ? 'dark' : 'light'}', (tester) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      tester.view.padding = const FakeViewPadding(top: 177, bottom: 102);
      tester.view.viewPadding = const FakeViewPadding(top: 177, bottom: 102);
      final key = GlobalKey();
      final app = await pumpApp(
        tester,
        onboardingSeen: false,
        screenKey: key,
        initialPreferences: {'theme_mode': dark ? 'dark' : 'light'},
      );
      final suffix = dark ? 'dark' : 'light';
      await _settle(tester);
      await _save(tester, key, '11_welcome_$suffix');
      unawaitedNavigate(tester, _router(app).push(const LoginRoute()));
      await _settle(tester);
      await _save(tester, key, '12_login_$suffix');
    });
  }
}

/// Opens a route without awaiting it (the router future only ends with the route).
void unawaitedNavigate(WidgetTester tester, Future<void> future) {
  // ignore: unawaited_futures
  future;
}
