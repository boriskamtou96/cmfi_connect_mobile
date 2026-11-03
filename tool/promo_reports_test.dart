// The screens of the promo video of the report and of the disciple maker
// (temporary: not committed): the real screens, with the demo people of the
// store screenshots. Writes build/promo_reports/<screen>.png (1170 × 2532).
//
//   flutter test tool/promo_reports_test.dart
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/authorities/domain/authority.dart';
import 'package:cmfi_connect/src/features/disciples/domain/disciple.dart';
import 'package:cmfi_connect/src/features/disciples/domain/received_report.dart';
import 'package:cmfi_connect/src/features/members/domain/member.dart';
import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/domain/in_app_sending.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  ActivityType(
    id: 5,
    code: 'JE',
    label: 'Jeûne',
    tracksDuration: true,
    isStandard: true,
  ),
];

ReportEntry _entry(int id, {int? quantity, int? minutes}) {
  final activity = _activities.firstWhere((a) => a.id == id);
  return ReportEntry(
    activityTypeId: id,
    code: activity.code,
    label: activity.label,
    tracksQuantity: activity.tracksQuantity,
    quantityUnit: activity.quantityUnit,
    tracksDuration: activity.tracksDuration,
    quantity: quantity,
    durationMinutes: minutes,
  );
}

DateTime _daysAgo(int n) {
  final now = today();
  return DateTime(now.year, now.month, now.day - n);
}

/// Three months of reports, growing; today every goal reached.
Map<DateTime, DailyReport> _reportDays() {
  final random = math.Random(3);
  final days = <DateTime, DailyReport>{};
  for (var i = 0; i < 90; i++) {
    if (i >= 23 && i % 7 == 3) {
      continue;
    }
    final day = _daysAgo(i);
    final growth = (90 - i) / 90;
    final entries = i == 0
        ? [
            _entry(1, quantity: 4),
            _entry(2, minutes: 75),
            _entry(3, quantity: 2),
            _entry(4, quantity: 2),
          ]
        : [
            _entry(1, quantity: 1 + (growth * 3).round() + random.nextInt(2)),
            _entry(
              2,
              minutes: 20 + (growth * 45).round() + random.nextInt(4) * 5,
            ),
            if (random.nextDouble() < 0.3 + growth * 0.5)
              _entry(3, quantity: 1 + random.nextInt(3)),
            if (random.nextDouble() < 0.4 + growth * 0.5)
              _entry(4, quantity: 1 + random.nextInt(2)),
            if (day.weekday == DateTime.friday) _entry(5, minutes: 720),
          ];
    days[day] = DailyReport(date: day, submitted: true, entries: entries);
  }
  return days;
}

// ----- the people (fictional) ----------------------------------------------------

const _grace = MemberCard(
  username: 'grace.nkodo',
  firstName: 'Grâce',
  lastName: 'Nkodo',
  church: 'CMCI Yaoundé',
  assembly: 'Assemblée de Mvolyé',
);
const _samuel = MemberCard(
  username: 'samuel.mbarga',
  firstName: 'Samuel',
  lastName: 'Mbarga',
  church: 'CMCI Yaoundé',
);
const _esther = MemberCard(
  username: 'esther.fouda',
  firstName: 'Esther',
  lastName: 'Fouda',
  church: 'CMCI Yaoundé',
);
const _daniel = MemberCard(
  username: 'daniel.atangana',
  firstName: 'Daniel',
  lastName: 'Atangana',
  church: 'CMCI Douala',
);
const _ruth = MemberCard(
  username: 'ruth.mballa',
  firstName: 'Ruth',
  lastName: 'Mballa',
  church: 'CMCI Yaoundé',
);
const _jean = MemberCard(
  username: 'jean.tchoupo',
  firstName: 'Jean',
  lastName: 'Tchoupo',
  church: 'CMCI Yaoundé',
);

Disciple _disciple(
  int id,
  MemberCard member, {
  required int streak,
  required int filled,
  required int goals,
  int items = 80,
  bool maker = true,
}) => Disciple(
  authorityId: id,
  member: member,
  isDiscipleMaker: maker,
  regularity: DiscipleRegularity(
    streak: streak,
    days: [for (var i = 0; i < filled; i++) _daysAgo(i)],
    filledLast30: filled,
    lastDay: _daysAgo(0),
    goalPercent: goals,
    itemsPercent: items,
  ),
);

final _disciples = [
  _disciple(21, _grace, streak: 24, filled: 28, goals: 92, items: 95),
  _disciple(22, _samuel, streak: 9, filled: 22, goals: 74),
  _disciple(23, _esther, streak: 4, filled: 17, goals: 61, maker: false),
  _disciple(24, _daniel, streak: 12, filled: 25, goals: 83),
  const Disciple(authorityId: 25, member: _ruth, sharesRegularity: false),
];

/// Grâce's last days, as her disciple maker reads them (never her note).
DiscipleReports _graceReports() {
  final days = _reportDays();
  return DiscipleReports(
    authorityId: 21,
    member: _grace,
    totalItems: 5,
    days: [
      for (var i = 0; i < 30; i++)
        if (days[_daysAgo(i)] case final day?)
          DiscipleDay(
            date: day.date,
            goalPercent: i == 0 ? 100 : 70 + (i * 7) % 30,
            filled: day.entries.length,
            total: 5,
            itemsPercent: day.entries.length * 20,
            entries: [
              for (final e in day.entries)
                DiscipleEntry(
                  activityTypeId: e.activityTypeId,
                  code: e.code,
                  label: e.label,
                  quantityUnit: e.quantityUnit,
                  quantity: e.quantity,
                  durationMinutes: e.durationMinutes,
                ),
            ],
          ),
    ],
  );
}

DateTime get _lastMonday {
  final now = today();
  return DateTime(now.year, now.month, now.day - (now.weekday - 1) - 7);
}

final _received = [
  ReceivedReport(
    id: 1,
    authorityId: 21,
    member: _grace,
    periodFrom: _lastMonday,
    periodTo: _lastMonday.add(const Duration(days: 6)),
    sentAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  ReceivedReport(
    id: 2,
    authorityId: 24,
    member: _daniel,
    periodFrom: _lastMonday,
    periodTo: _lastMonday.add(const Duration(days: 6)),
    sentAt: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  ReceivedReport(
    id: 3,
    authorityId: 22,
    member: _samuel,
    periodFrom: _lastMonday.subtract(const Duration(days: 7)),
    periodTo: _lastMonday.subtract(const Duration(days: 1)),
    sentAt: DateTime.now().subtract(const Duration(days: 7)),
    readAt: DateTime.now().subtract(const Duration(days: 6)),
    reply: 'Je prie pour toi.',
    repliedAt: DateTime.now().subtract(const Duration(days: 6)),
  ),
];

// ----- taking the app ------------------------------------------------------------------

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(file).readAsBytesSync())),
    );
  }
  await loader.load();
}

Future<(TestApp, GlobalKey)> _pump(
  WidgetTester tester, {
  required bool maker,
}) async {
  final key = GlobalKey();
  final app = await pumpApp(
    tester,
    token: 't',
    account: sampleAccount.copyWith(
      firstName: maker ? 'Paul' : 'Grâce',
      lastName: maker ? 'Ndi' : 'Nkodo',
      username: maker ? 'paul.ndi' : 'grace.nkodo',
    ),
    profile: Profile(
      firstName: maker ? 'Paul' : 'Grâce',
      lastName: maker ? 'Ndi' : 'Nkodo',
      phoneNumber: '+237690000001',
      city: 'Yaoundé',
      country: 'CM',
      church: 'CMCI Yaoundé',
      assembly: 'Assemblée de Mvolyé',
    ),
    activities: _activities,
    reportDays: _reportDays(),
    premium: FakePremiumStore(active: true),
    authoritiesApi: maker
        ? FakeAuthoritiesApi(const [], [
            AuthorityRequest(id: 31, from: _jean, isDiscipleMaker: true),
          ])
        : FakeAuthoritiesApi(const [
            Authority(
              id: 7,
              firstName: 'Paul',
              lastName: 'Ndi',
              username: 'paul.ndi',
              phoneNumber: '+237 6 77 00 00 07',
              isDiscipleMaker: true,
            ),
            Authority(
              id: 8,
              firstName: 'Marie',
              lastName: 'Ekane',
              username: 'marie.ekane',
              phoneNumber: '+237 6 99 00 00 08',
            ),
          ]),
    disciplesApi: maker
        ? (FakeDisciplesApi(_disciples, [..._received])
            ..reportsOf[21] = _graceReports())
        : null,
    reportSendingsApi: maker
        ? null
        : FakeReportSendingsApi(
            receivers: {7, 8},
            sent: [
              InAppSending(
                id: 9,
                authorityId: 7,
                periodFrom: _lastMonday,
                periodTo: _lastMonday.add(const Duration(days: 6)),
                sentAt: DateTime.now().subtract(const Duration(hours: 2)),
                readAt: DateTime.now().subtract(const Duration(hours: 1)),
                reply: 'Belle fidélité, continue !',
                repliedAt: DateTime.now().subtract(const Duration(hours: 1)),
              ),
            ],
          ),
    initialPreferences: {
      'report_goals':
          '{"1":{"quantity":3},"2":{"minutes":60},"3":{"quantity":2},"4":{"quantity":2}}',
      'report_sending':
          '{"enabled":true,"rhythm":"weekly","weekday":7,"minutes":1200,"authorities":[7,8]}',
    },
    screenKey: key,
  );
  tester.view.padding = const FakeViewPadding(top: 59 * 3, bottom: 34 * 3);
  tester.view.viewPadding = const FakeViewPadding(top: 59 * 3, bottom: 34 * 3);
  await tester.pumpAndSettle();
  return (app, key);
}

Future<void> _save(WidgetTester tester, GlobalKey key, String name) async {
  await tester.pumpAndSettle();
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 3);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File('build/promo_reports/$name.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}

AppRouter _router(TestApp app) => app.container.read(appRouterProvider);

Future<void> _go(WidgetTester tester, TestApp app, PageRouteInfo route) async {
  unawaited(_router(app).push(route));
  await tester.pumpAndSettle();
}

Future<void> _back(WidgetTester tester, TestApp app) async {
  await _router(app).maybePop();
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
    await _loadFont('Onest', [
      for (final w in ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold'])
        'assets/fonts/Onest-$w.ttf',
    ]);
    await _loadFont('Lora', [
      'assets/fonts/Lora-Regular.ttf',
      'assets/fonts/Lora-SemiBold.ttf',
      'assets/fonts/Lora-Italic.ttf',
    ]);
    final phosphor =
        '${Platform.environment['HOME']}/.pub-cache/hosted/pub.dev/phosphor_flutter-2.1.0/lib/fonts';
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
    await _loadFont('Apple Color Emoji', [
      '/System/Library/Fonts/Apple Color Emoji.ttc',
    ]);
  });
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('the disciple', (tester) async {
    final (app, key) = await _pump(tester, maker: false);
    unawaited(_router(app).navigate(const ReportsRoute()));
    await tester.pumpAndSettle();
    await _save(tester, key, 'd01_today');

    await tester.tap(find.text('Lecture biblique').first);
    await tester.pumpAndSettle();
    await _save(tester, key, 'd02_entry');
    await tester.tapAt(const Offset(195, 120));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Historique'));
    await tester.pumpAndSettle();
    // a whole month: the one before
    await tester.tap(find.byTooltip('Mois précédent'));
    await tester.pumpAndSettle();
    await _save(tester, key, 'd03_history');

    await tester.tap(find.text('Bilan'));
    await tester.pumpAndSettle();
    await _save(tester, key, 'd04_summary');
    await tester.drag(find.byType(Scrollable).last, const Offset(0, -700));
    await tester.pumpAndSettle();
    await _save(tester, key, 'd05_summary_more');
    await tester.scrollUntilVisible(
      find.text('Évolution de tes objectifs'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.drag(find.byType(Scrollable).last, const Offset(0, -250));
    await tester.pumpAndSettle();
    await _save(tester, key, 'd05b_evolution');
    await tester.scrollUntilVisible(
      find.text('Année'),
      -400,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Année'));
    await tester.pumpAndSettle();
    await _save(tester, key, 'd04b_year');

    await _go(tester, app, const ExportReportRoute());
    await _save(tester, key, 'd06_export');
    await _back(tester, app);

    await _go(tester, app, const ReportSendingRoute());
    await _save(tester, key, 'd07_sending');
    await tester.drag(find.byType(Scrollable).last, const Offset(0, -900));
    await tester.pumpAndSettle();
    await _save(tester, key, 'd08_sending_history');
    await _back(tester, app);

    await _go(tester, app, ReportSendRoute(day: today().toApiDate()));
    await _save(tester, key, 'd09_send');
    await _back(tester, app);

    await _go(tester, app, const AuthoritiesRoute());
    await _save(tester, key, 'd10_authorities');
    await _back(tester, app);

    await _go(tester, app, const AuthorityFormRoute());
    await _save(tester, key, 'd11_authority_form');
    await _back(tester, app);

    await _go(tester, app, WeekStoryRoute(monday: _lastMonday.toApiDate()));
    await tester.pump(const Duration(seconds: 2));
    await _save(tester, key, 'd12_week_story');
  });

  testWidgets('the disciple maker', (tester) async {
    final (app, key) = await _pump(tester, maker: true);

    await _go(tester, app, const DisciplesRoute());
    await _save(tester, key, 'm01_disciples');

    await _go(
      tester,
      app,
      DiscipleReportsRoute(authorityId: 21, name: 'Grâce Nkodo'),
    );
    await _save(tester, key, 'm02_disciple_reports');
    await _back(tester, app);
    await _back(tester, app);

    await _go(tester, app, const ReceivedReportsRoute());
    await _save(tester, key, 'm03_received');
    await tester.tap(find.text('Encourager').first);
    await tester.pumpAndSettle();
    await _save(tester, key, 'm04_encourage');
    await tester.tap(find.text('Belle fidélité, continue !').first);
    await tester.pumpAndSettle();
    await _save(tester, key, 'm05_encourage_picked');
    await tester.tapAt(const Offset(195, 120));
    await tester.pumpAndSettle();
    await _back(tester, app);

    await _go(tester, app, const AuthoritiesRoute());
    await _save(tester, key, 'm06_requests');
  });
}
