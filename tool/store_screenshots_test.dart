// Generates the screenshots of the store pages: the real screens of the app,
// filled with demo data, set in bold frames (the color of each module, the
// giant open ring of the mark, the headline with its gold words, the phone
// running off the bottom), and the feature graphic of Google Play (the poster
// of the icon). Also the screens of the landing page, in the 7 languages.
//
//   flutter test tool/store_screenshots_test.dart
//
// Writes store/screenshots/ios/fr (1290 × 2796, iPhone 6.9"),
// store/screenshots/android/fr (1080 × 2160),
// store/screenshots/feature_graphic.png (1024 × 500) and
// build/landing_screens/<language>/<screen>.png (600 × 1298, to turn into
// WebP for public/screens of the landing page).
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/theme/app_colors.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/core/widgets/cmfi_logo.dart';
import 'package:cmfi_connect/src/core/widgets/dove_mascot.dart';
import 'package:cmfi_connect/src/core/widgets/goal_ring.dart';
import 'package:cmfi_connect/src/features/authorities/domain/authority.dart';
import 'package:cmfi_connect/src/features/hymns/domain/hymn.dart';
import 'package:cmfi_connect/src/features/ministry/domain/nation.dart';
import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../test/helpers/fakes.dart';
import '../test/helpers/pump_app.dart';

// ----- the demo account -------------------------------------------------------

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

const _goals = {
  '1': {'quantity': 3},
  '2': {'minutes': 60},
  '3': {'quantity': 2},
  '4': {'quantity': 2},
};

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

/// Three months of reports, growing: the last 23 days without a gap, today
/// every goal reached.
Map<DateTime, DailyReport> _reportDays() {
  final random = math.Random(3);
  final now = today();
  final days = <DateTime, DailyReport>{};
  for (var i = 0; i < 90; i++) {
    if (i >= 23 && i % 7 == 3) {
      continue;
    }
    final day = DateTime(now.year, now.month, now.day - i);
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

const _profile = Profile(
  firstName: 'Grâce',
  lastName: 'Nkodo',
  phoneNumber: '+237690000001',
  city: 'Yaoundé',
  country: 'CM',
  church: 'CMCI Yaoundé',
  assembly: 'Assemblée de Mvolyé',
);

const _authorities = [
  Authority(
    id: 7,
    firstName: 'Paul',
    lastName: 'Ndi',
    phoneNumber: '+237 6 77 00 00 07',
    email: 'paul.ndi@example.com',
    isDiscipleMaker: true,
  ),
  Authority(
    id: 8,
    firstName: 'Marie',
    lastName: 'Ekane',
    phoneNumber: '+237 6 99 00 00 08',
  ),
];

List<HymnBook> _books() => [
  for (final code in ['chants-edification-1', 'christ-est-vainqueur'])
    HymnBook.fromJson(
      jsonDecode(File('assets/hymns/$code.json').readAsStringSync())
          as Map<String, dynamic>,
    ),
];

List<Nation> _nations() => [
  for (final json
      in jsonDecode(File('assets/ministry/nations.json').readAsStringSync())
          as List)
    Nation.fromJson(json as Map<String, dynamic>),
];

// ----- posters of the demo events -----------------------------------------------

typedef _PosterLook = ({List<Color> colors, String title, String theme});

const _posterLooks = <String, _PosterLook>{
  '/v1/media/poster.jpg': (
    colors: [Color(0xFF0B3B70), Color(0xFF041C3A)],
    title: 'Conférence\nannuelle 2026',
    theme: "Marcher dans l'Esprit",
  ),
  '/v1/media/youth.jpg': (
    colors: [Color(0xFF6A2C91), Color(0xFF2A0F45)],
    title: 'Retraite\ndes jeunes',
    theme: 'Brûlants pour Lui',
  ),
  '/v1/media/mission.jpg': (
    colors: [Color(0xFFB4532A), Color(0xFF4A1A0C)],
    title: "Campagne\nd'évangélisation",
    theme: 'Allez par tout le monde',
  ),
};

Future<Uint8List> _poster(_PosterLook look) async {
  const size = Size(1080, 1350);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final rect = Offset.zero & size;
  canvas.drawRect(
    rect,
    Paint()
      ..shader = ui.Gradient.linear(
        rect.topCenter,
        rect.bottomCenter,
        look.colors,
      ),
  );
  // rays of light from the top
  final rays = Paint()..color = Colors.white.withValues(alpha: 0.06);
  for (var i = 0; i < 9; i++) {
    final angle = -math.pi / 2 + (i - 4) * 0.18;
    final path = Path()
      ..moveTo(size.width / 2, -80)
      ..lineTo(
        size.width / 2 + math.cos(angle - 0.04) * 2200,
        -80 - math.sin(angle - 0.04) * -2200,
      )
      ..lineTo(
        size.width / 2 + math.cos(angle + 0.04) * 2200,
        -80 - math.sin(angle + 0.04) * -2200,
      )
      ..close();
    canvas.drawPath(path, rays);
  }
  canvas
    ..save()
    ..translate(size.width / 2 - 90, 140);
  const CmfiLogoPainter(disc: true).paint(canvas, const Size.square(180));
  canvas.restore();

  void text(String value, TextStyle style, double top) {
    final painter = TextPainter(
      text: TextSpan(text: value, style: style),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 140);
    painter.paint(canvas, Offset((size.width - painter.width) / 2, top));
  }

  text(
    look.title.toUpperCase(),
    const TextStyle(
      fontFamily: 'Onest',
      fontSize: 104,
      height: 1.02,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
    470,
  );
  text(
    look.theme,
    const TextStyle(
      fontFamily: 'Lora',
      fontStyle: FontStyle.italic,
      fontSize: 62,
      color: AppColors.goldLight,
    ),
    760,
  );
  text(
    'YAOUNDÉ · CAMEROUN',
    TextStyle(
      fontFamily: 'Onest',
      fontSize: 38,
      letterSpacing: 8,
      fontWeight: FontWeight.w700,
      color: Colors.white.withValues(alpha: 0.8),
    ),
    1180,
  );
  final image = await recorder.endRecording().toImage(
    size.width.toInt(),
    size.height.toInt(),
  );
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return bytes!.buffer.asUint8List();
}

// ----- taking the app ------------------------------------------------------------

/// The app signed in with the demo account, on an iPhone (status bar and
/// home indicator areas included).
Future<(TestApp, GlobalKey)> _pumpDemo(
  WidgetTester tester,
  Map<String, Uint8List> posters,
) async {
  final key = GlobalKey();
  final next = sampleEvents(daysAhead: 12).next;
  final books = _books();
  final app = await pumpApp(
    tester,
    token: 't',
    account: sampleAccount.copyWith(
      firstName: 'Grâce',
      lastName: 'Nkodo',
      username: 'grace.nkodo',
    ),
    profile: _profile,
    activities: _activities,
    reportDays: _reportDays(),
    authoritiesApi: FakeAuthoritiesApi(_authorities),
    hymnsApi: FakeHymnsApi(books: books),
    hymnStorage: FakeHymnBookStorage(bundled: books),
    premium: FakePremiumStore(active: true),
    ministryApi: FakeMinistryApi(list: _nations()),
    mediaImages: FakeMediaImages(posters),
    eventsApi: FakeEventsApi(
      upcoming: [
        next.copyWith(poster: samplePoster.copyWith(color: '#082B55')),
        next.copyWith(
          id: 3,
          title: 'Retraite des jeunes',
          theme: 'Brûlants pour Lui',
          startsAt: next.startsAt.add(const Duration(days: 21)),
          endsAt: next.endsAt.add(const Duration(days: 21)),
          city: 'Douala',
          poster: samplePoster.copyWith(
            id: 3,
            url: '/v1/media/youth.jpg',
            color: '#4A1F6B',
          ),
        ),
        next.copyWith(
          id: 4,
          title: "Campagne d'évangélisation",
          theme: 'Allez par tout le monde',
          startsAt: next.startsAt.add(const Duration(days: 40)),
          endsAt: next.endsAt.add(const Duration(days: 40)),
          city: 'Bafoussam',
          poster: samplePoster.copyWith(
            id: 4,
            url: '/v1/media/mission.jpg',
            color: '#7A2E14',
          ),
        ),
      ],
    ),
    initialPreferences: {
      'report_goals': jsonEncode(_goals),
      'report_sending': jsonEncode({
        'enabled': true,
        'rhythm': 'weekly',
        'weekday': DateTime.sunday,
        'minutes': 20 * 60,
        'authorities': [7, 8],
      }),
    },
    screenKey: key,
  );
  // an iPhone: the status bar and the home indicator
  tester.view.padding = const FakeViewPadding(top: 59 * 3, bottom: 34 * 3);
  tester.view.viewPadding = const FakeViewPadding(top: 59 * 3, bottom: 34 * 3);
  await _settle(tester, posters);
  return (app, key);
}

/// Lets the images (posters) decode, then the screen settle.
Future<void> _settle(
  WidgetTester tester, [
  Map<String, Uint8List> posters = const {},
]) async {
  await tester.pumpAndSettle();
  await tester.runAsync(() async {
    final context = tester.element(find.byType(MaterialApp).first);
    for (final bytes in posters.values) {
      await precacheImage(MemoryImage(bytes), context);
    }
    await Future<void>.delayed(const Duration(milliseconds: 200));
  });
  await tester.pumpAndSettle();
}

Future<ui.Image> _shoot(WidgetTester tester, GlobalKey key) async {
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  return (await tester.runAsync(() => boundary.toImage(pixelRatio: 3)))!;
}

Future<void> _openTab(WidgetTester tester, String label) async {
  await tester.tap(find.text(label).last);
  await tester.pumpAndSettle();
}

AppRouter _router(TestApp app) => app.container.read(appRouterProvider);

// ----- the frames -------------------------------------------------------------------

/// A headline: plain words, and the words in gold italic.
typedef _Words = List<(String, bool)>;

class _Shot {
  const _Shot({
    required this.name,
    required this.eyebrow,
    required this.headline,
    required this.colors,
    this.lightStatusBar = false,
    this.tilt = 0,
    this.headlineScale = 1,
    this.extra,
  });

  final String name;

  /// The background, bold and flat like the stores' best pages: the color of
  /// the module shown, lighter at the top.
  final List<Color> colors;
  final String eyebrow;
  final _Words headline;

  /// White status bar text (a dark screen).
  final bool lightStatusBar;

  /// The phone turned a little (radians).
  final double tilt;

  /// A long headline, a little smaller.
  final double headlineScale;

  /// What comes out of the phone: a ring, a bubble, Zoé…
  final Widget Function(double u)? extra;
}

/// An iPhone around a screen of the app: bezel, Dynamic Island, status bar.
class _Phone extends StatelessWidget {
  const _Phone({
    required this.screen,
    required this.width,
    required this.lightStatusBar,
  });

  final ui.Image screen;
  final double width;
  final bool lightStatusBar;

  @override
  Widget build(BuildContext context) {
    final bezel = width * 0.032;
    final screenWidth = width - bezel * 2;
    final screenHeight = screenWidth * screen.height / screen.width;
    // the app's points, on this screen
    final pt = screenWidth / 390;
    final ink = lightStatusBar ? Colors.white : AppColors.ink;

    return Container(
      width: width,
      padding: EdgeInsets.all(bezel),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1118),
        borderRadius: BorderRadius.circular(width * 0.155),
        border: Border.all(color: const Color(0xFF4A5468), width: pt * 1.4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: width * 0.08,
            offset: Offset(0, width * 0.04),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.125),
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: RawImage(image: screen, fit: BoxFit.cover),
              ),
              // status bar
              Positioned(
                left: 38 * pt,
                top: 18 * pt,
                child: Text(
                  '9:41',
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 17 * pt,
                    fontWeight: FontWeight.w700,
                    color: ink,
                  ),
                ),
              ),
              Positioned(
                right: 30 * pt,
                top: 19 * pt,
                child: Row(
                  children: [
                    Icon(
                      PhosphorIconsFill.cellSignalFull,
                      size: 18 * pt,
                      color: ink,
                    ),
                    SizedBox(width: 5 * pt),
                    Icon(PhosphorIconsFill.wifiHigh, size: 18 * pt, color: ink),
                    SizedBox(width: 5 * pt),
                    Icon(
                      PhosphorIconsFill.batteryFull,
                      size: 24 * pt,
                      color: ink,
                    ),
                  ],
                ),
              ),
              // Dynamic Island
              Positioned(
                top: 11 * pt,
                left: (screenWidth - 124 * pt) / 2,
                child: Container(
                  width: 124 * pt,
                  height: 36 * pt,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20 * pt),
                  ),
                ),
              ),
              // home indicator
              Positioned(
                bottom: 8 * pt,
                left: (screenWidth - 140 * pt) / 2,
                child: Container(
                  width: 140 * pt,
                  height: 5 * pt,
                  decoration: BoxDecoration(
                    color: AppColors.ink.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(3 * pt),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A white card that comes out of the phone.
Widget _bubble(
  double u, {
  required Widget child,
  Color color = Colors.white,
  double radius = 44,
}) => Container(
  padding: EdgeInsets.symmetric(horizontal: 36 * u, vertical: 28 * u),
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius * u),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.30),
        blurRadius: 50 * u,
        offset: Offset(0, 22 * u),
      ),
    ],
  ),
  child: child,
);

/// A frame of the stores (validated on 23/10/2026, after the new icon): the
/// color of the module, the giant open ring of the mark, the headline big and
/// on the left with its gold words, the phone large and running off the
/// bottom, and what comes out of it.
class _Frame extends StatelessWidget {
  const _Frame({required this.shot, required this.screen, required this.size});

  final _Shot shot;
  final ui.Image screen;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final u = size.width / 1290;
    // taller frames (iPhone) give the headline more air
    final top = size.height * (size.height / size.width > 2.1 ? 0.07 : 0.05);
    final phoneWidth = size.width * 0.80;

    return SizedBox.fromSize(
      size: size,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: shot.colors,
                ),
              ),
            ),
          ),
          // the open ring of the mark, giant and faint
          Positioned(
            right: -520 * u,
            top: -260 * u,
            child: BrandRing(
              size: 1500 * u,
              color: Colors.white.withValues(alpha: 0.08),
              strokeWidth: 9,
            ),
          ),
          // a soft light behind the phone
          Positioned(
            left: -200 * u,
            right: -200 * u,
            top: size.height * 0.34,
            height: size.height * 0.7,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.18),
                    Colors.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 96 * u,
            right: 96 * u,
            top: top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // the mark and the module, in a pill
                Container(
                  padding: EdgeInsets.fromLTRB(14 * u, 12 * u, 30 * u, 12 * u),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(60 * u),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CmfiLogo.onDark(size: 60 * u),
                      SizedBox(width: 16 * u),
                      Text(
                        shot.eyebrow,
                        style: TextStyle(
                          fontFamily: 'Onest',
                          fontSize: 32 * u,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 4 * u,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40 * u),
                Text.rich(
                  TextSpan(
                    children: [
                      for (final (words, accent) in shot.headline)
                        TextSpan(
                          text: words,
                          style: accent
                              ? TextStyle(
                                  fontFamily: 'Lora',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 138 * u * shot.headlineScale,
                                  color: AppColors.goldLight,
                                )
                              : null,
                        ),
                    ],
                  ),
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 128 * u * shot.headlineScale,
                    height: 1.02,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -3 * u,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: (size.width - phoneWidth) / 2,
            top: top + 620 * u,
            child: Transform.rotate(
              angle: shot.tilt,
              child: _Phone(
                screen: screen,
                width: phoneWidth,
                lightStatusBar: shot.lightStatusBar,
              ),
            ),
          ),
          if (shot.extra case final extra?) ...[extra(u)],
        ],
      ),
    );
  }
}

// ----- the shots ------------------------------------------------------------------

final _shots = <_Shot>[
  _Shot(
    name: '01_accueil',
    colors: const [Color(0xFF0E4682), Color(0xFF061F40)],
    eyebrow: 'CMFI CONNECT',
    headline: const [('Grandis avec Dieu,\n', false), ('chaque jour', true)],
    extra: (u) => Positioned(
      right: 30 * u,
      top: 470 * u,
      child: DoveMascot(pose: DovePose.cheer, size: 330 * u),
    ),
  ),
  _Shot(
    name: '02_compte_rendu',
    colors: const [Color(0xFF1A7BD0), Color(0xFF0A4E92)],
    eyebrow: 'COMPTE RENDU',
    headline: const [('Ton compte rendu\nen ', false), ('une minute', true)],
    tilt: -0.035,
    extra: (u) => Positioned(
      left: 50 * u,
      top: 2080 * u,
      child: _bubble(
        u,
        child: Row(
          children: [
            GoalRing(value: 1, label: '', size: 120 * u),
            SizedBox(width: 26 * u),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Objectifs du jour',
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 36 * u,
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted,
                  ),
                ),
                Text(
                  'Tous atteints !',
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 46 * u,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
  _Shot(
    name: '03_bilan',
    colors: const [Color(0xFF6B4FD0), Color(0xFF33206E)],
    eyebrow: 'BILAN',
    headline: const [
      ('Vois ta ', false),
      ('croissance', true),
      (',\nsemaine après semaine', false),
    ],
    headlineScale: 0.84,
    tilt: 0.03,
    extra: (u) => Positioned(
      right: 46 * u,
      top: 1420 * u,
      child: _bubble(
        u,
        color: AppColors.gold,
        child: Row(
          children: [
            Icon(AppIcons.streak, size: 64 * u, color: AppColors.ink),
            SizedBox(width: 18 * u),
            Text(
              '24 jours\nd\'affilée',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 42 * u,
                height: 1.1,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  const _Shot(
    name: '04_cantiques',
    colors: [Color(0xFF18A091), Color(0xFF0A4E48)],
    eyebrow: 'CANTIQUES',
    headline: [('Tous les cantiques,\n', false), ('même hors ligne', true)],
  ),
  _Shot(
    name: '05_priere',
    colors: const [Color(0xFF8E5BC2), Color(0xFF45226E)],
    eyebrow: 'PRIÈRE',
    headline: const [('15 minutes\n', false), ('avec le Seigneur', true)],
    tilt: -0.03,
    extra: (u) => Positioned(
      left: 40 * u,
      top: 2080 * u,
      child: _bubble(
        u,
        child: Row(
          children: [
            Icon(
              PhosphorIconsFill.bellRinging,
              size: 64 * u,
              color: const Color(0xFF6A3FA0),
            ),
            SizedBox(width: 20 * u),
            Text(
              'Matin, midi, soir, nuit :\nun rappel pour prier',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 40 * u,
                height: 1.15,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  _Shot(
    name: '06_evenements',
    colors: const [Color(0xFFE0603A), Color(0xFF962E16)],
    eyebrow: 'ÉVÈNEMENTS',
    headline: const [
      ('Ne manque ', false),
      ('aucune', true),
      ('\nrencontre', false),
    ],
    lightStatusBar: true,
    tilt: 0.03,
    extra: (u) => Positioned(
      right: 40 * u,
      top: 2050 * u,
      child: _bubble(
        u,
        child: Row(
          children: [
            Icon(
              PhosphorIconsFill.bellRinging,
              size: 60 * u,
              color: const Color(0xFFB4532A),
            ),
            SizedBox(width: 18 * u),
            Text(
              'Rappel la veille\net une heure avant',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 40 * u,
                height: 1.15,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  const _Shot(
    name: '07_ministere',
    colors: [Color(0xFF16305E), Color(0xFF050B1A)],
    eyebrow: 'NOTRE MINISTÈRE',
    headline: [('Présente dans\n', false), ('154 nations', true)],
    lightStatusBar: true,
  ),
  _Shot(
    name: '08_autorites',
    colors: const [Color(0xFF2E9E62), Color(0xFF0F4A2E)],
    eyebrow: 'AUTORITÉS SPIRITUELLES',
    headline: const [('À tes autorités,\n', false), ('en un geste', true)],
    tilt: -0.03,
    extra: (u) => Stack(
      children: [
        Positioned(
          left: 40 * u,
          top: 1900 * u,
          child: SizedBox(
            width: 760 * u,
            child: _bubble(
              u,
              color: const Color(0xFFDCF8C6),
              radius: 36,
              child: Text(
                'Bonjour Paul, voici mon compte rendu de la semaine : '
                '7 jours sur 7, objectifs atteints. Gloire à Dieu !',
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontSize: 38 * u,
                  height: 1.3,
                  color: AppColors.ink,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 30 * u,
          top: 1700 * u,
          child: DoveMascot(pose: DovePose.celebrate, size: 300 * u),
        ),
      ],
    ),
  ),
];

/// Takes each screen of the app.
final _scenes = <String, Future<void> Function(WidgetTester, TestApp)>{
  '01_accueil': (tester, app) async {},
  '02_compte_rendu': (tester, app) async {
    await _openTab(tester, 'Compte rendu');
  },
  '03_bilan': (tester, app) async {
    await _openTab(tester, 'Compte rendu');
    await tester.tap(find.text('Bilan'));
    await tester.pumpAndSettle();
  },
  '04_cantiques': (tester, app) async {
    unawaited(
      _router(
        app,
      ).push(HymnReaderRoute(bookCode: 'chants-edification-1', number: 1)),
    );
    await tester.pumpAndSettle();
  },
  '05_priere': (tester, app) async {
    await _openTab(tester, 'Prière');
  },
  '06_evenements': (tester, app) async {
    unawaited(_router(app).push(EventRoute(eventId: 2)));
    await tester.pumpAndSettle();
  },
  '07_ministere': (tester, app) async {
    unawaited(_router(app).push(const NationsRoute()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Voyage'));
    await tester.pump(const Duration(milliseconds: 1500));
  },
  '08_autorites': (tester, app) async {
    unawaited(_router(app).push(ReportSendRoute(day: today().toApiDate())));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('WhatsApp').first);
  },
};

/// The Mac's fonts of the scripts Onest doesn't draw, for the landing
/// screens.
const _scriptFonts = {
  'ar': '/System/Library/Fonts/SFArabic.ttf',
  'zh': '/System/Library/Fonts/Hiragino Sans GB.ttc',
  'hi': '/System/Library/Fonts/Kohinoor.ttc',
};

// ----- writing -----------------------------------------------------------------------

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(file).readAsBytesSync())),
    );
  }
  await loader.load();
}

Future<void> _render(
  WidgetTester tester,
  Widget child,
  Size size,
  String path,
) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  tester.view.padding = FakeViewPadding.zero;
  tester.view.viewPadding = FakeViewPadding.zero;
  final key = GlobalKey();
  // the app goes first: TranslationProvider keeps a global key, it would
  // carry the app over into the frame
  await tester.pumpWidget(const SizedBox());
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Onest'),
        home: Material(
          type: MaterialType.transparency,
          child: RepaintBoundary(key: key, child: child),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File(path)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}

void main() {
  late Map<String, Uint8List> posters;

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
    // the flags (Notre ministère): the Mac's colour font
    await _loadFont('Apple Color Emoji', [
      '/System/Library/Fonts/Apple Color Emoji.ttc',
    ]);
    posters = {
      for (final MapEntry(:key, :value) in _posterLooks.entries)
        key: await _poster(value),
    };
  });
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  for (final shot in _shots) {
    testWidgets('store screenshot ${shot.name}', (tester) async {
      final (app, key) = await _pumpDemo(tester, posters);
      await _scenes[shot.name]!(tester, app);
      await _settle(tester, posters);
      final screen = await _shoot(tester, key);
      if (shot.name == '07_ministere') {
        // the journey stops before the app goes
        await tester.tap(find.text('Pause'));
        await tester.pump();
      }

      for (final (folder, size) in [
        ('ios', const Size(1290, 2796)),
        ('android', const Size(1080, 2160)),
      ]) {
        await _render(
          tester,
          _Frame(shot: shot, screen: screen, size: size),
          size,
          'store/screenshots/$folder/fr/${shot.name}.png',
        );
      }
    });
  }

  // the poster of the icon (validated on 23/10/2026): the matte night, the
  // glowing tile, the wordmark spaced out
  testWidgets('feature graphic', (tester) async {
    const size = Size(1024, 500);
    const tile = 250.0;
    await _render(
      tester,
      SizedBox.fromSize(
        size: size,
        child: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(-0.6, -0.9),
                    radius: 1.6,
                    colors: [
                      Color(0xFF1A2F5C),
                      Color(0xFF0A1530),
                      Color(0xFF03070F),
                    ],
                    stops: [0, 0.45, 1],
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.9, 1),
                    radius: 0.9,
                    colors: [Color(0x8C0A5EA8), Color(0x000A5EA8)],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 80,
              top: (size.height - tile) / 2,
              child: Container(
                width: tile,
                height: tile,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(tile * 0.225),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7FC8F0).withValues(alpha: 0.45),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(tile * 0.225),
                  child: const CustomPaint(
                    size: Size.square(tile),
                    painter: AppIconPainter(),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 380,
              right: 40,
              top: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // one line, whatever the width
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'CMFI CONNECT',
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Onest',
                        fontSize: 56,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 9,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'GRANDIS AVEC DIEU, CHAQUE JOUR',
                    style: TextStyle(
                      fontFamily: 'Onest',
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 6,
                      color: Color(0xFF9FB6D8),
                    ),
                  ),
                  SizedBox(height: 34),
                  Text(
                    'Compte rendu · Cantiques · Prière · Bible',
                    style: TextStyle(
                      fontFamily: 'Onest',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.goldLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      size,
      'store/screenshots/feature_graphic.png',
    );
  });

  // the landing page: the screens that changed, bare, in every language
  for (final locale in AppLocale.values) {
    testWidgets('landing screens ${locale.languageCode}', (tester) async {
      // Onest has no Arabic, Chinese or Devanagari letters: the Mac's font
      // of the script, as the fallback the app names (run these one by one:
      // a second one would not be used)
      if (_scriptFonts[locale.languageCode] case final font?) {
        await _loadFont('Noto Color Emoji', [font]);
      }
      await LocaleSettings.setLocale(locale);
      final (app, key) = await _pumpDemo(tester, posters);
      Future<void> save(String name) async {
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: 600 / 390);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          File('build/landing_screens/${locale.languageCode}/$name.png')
            ..createSync(recursive: true)
            ..writeAsBytesSync(bytes!.buffer.asUint8List());
        });
      }

      await save('home');
      unawaited(_router(app).navigate(const ReportsRoute()));
      await _settle(tester, posters);
      await save('report');
      unawaited(_router(app).navigate(const HymnsRoute()));
      await _settle(tester, posters);
      await save('hymns');
    });
  }
}
