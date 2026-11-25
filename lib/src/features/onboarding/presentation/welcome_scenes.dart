import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/photo_kit.dart';

/// The pictures of the welcome pages (25/11/2026): real pieces of the app,
/// tilted and laid one over the other on the colour of the page, with Zoé
/// and a photo of the community. Drawn on a 390 × 380 board, scaled to the
/// room left by the words; decorative (the title says it all), and never
/// bigger with the text size of the phone.
class WelcomeScene extends StatelessWidget {
  const WelcomeScene(this.page, {super.key});

  /// 0: the home, 1: the hymns and prayer, 2: the events and announcements.
  final int page;

  static const size = Size(390, 380);

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: MediaQuery.withNoTextScaling(
      child: FittedBox(
        child: SizedBox.fromSize(
          size: size,
          child: Stack(
            clipBehavior: Clip.none,
            children: switch (page) {
              0 => _home(context),
              1 => _worship(context),
              _ => _community(context),
            },
          ),
        ),
      ),
    ),
  );

  List<Widget> _home(BuildContext context) {
    final t = context.t;
    final s = t.welcome.sample;
    return [
      _place(
        end: 22,
        top: 6,
        turn: 5,
        child: _Chip(
          icon: AppIcons.bible,
          iconColor: Colors.white,
          disc: const Color(0xFF0A5EA8),
          text: '${s.bibleReading} · ${s.chapters}',
        ),
      ),
      _place(start: 38, top: 58, turn: -4, child: const _HomeCard()),
      _place(
        end: 18,
        top: 262,
        turn: -6,
        child: const DoveMascot(pose: DovePose.cheer, size: 118),
      ),
      _place(
        start: 30,
        top: 300,
        turn: -3,
        child: _Chip(
          icon: AppIcons.streak,
          iconColor: _gold,
          disc: const Color(0xFFFFF1D6),
          text: s.withGod,
        ),
      ),
    ];
  }

  List<Widget> _worship(BuildContext context) {
    final s = context.t.welcome.sample;
    return [
      _place(
        start: 26,
        top: 20,
        turn: -7,
        child: const _Polaroid(
          photo: StockPhotos.worship,
          alignment: Alignment(0.16, -0.4),
          size: Size(150, 178),
        ),
      ),
      _place(start: 92, top: 58, turn: 4, child: const _HymnCard()),
      _place(
        start: 24,
        top: 322,
        turn: -3,
        child: _Chip(
          icon: AppIcons.prayNow,
          iconColor: Colors.white,
          disc: const Color(0xFF8E5BC2),
          text: s.praying,
        ),
      ),
      _place(end: 22, top: 300, turn: 5, child: const DoveMascot(size: 92)),
    ];
  }

  List<Widget> _community(BuildContext context) => [
    _place(
      start: 22,
      top: 12,
      turn: -8,
      child: const _Polaroid(
        photo: StockPhotos.family,
        alignment: Alignment(0, -0.4),
        size: Size(132, 150),
      ),
    ),
    _place(start: 100, top: 18, turn: 3.5, child: const _EventCard()),
    _place(start: 26, top: 284, turn: -3, child: const _NoticeCard()),
    _place(
      end: 16,
      top: 268,
      turn: 4,
      child: const DoveMascot(pose: DovePose.celebrate, size: 96),
    ),
  ];

  /// [child] at its place on the board, turned by [turn] degrees.
  static Widget _place({
    required double top,
    required double turn,
    required Widget child,
    double? start,
    double? end,
  }) => PositionedDirectional(
    start: start,
    end: end,
    top: top,
    child: Transform.rotate(angle: turn * math.pi / 180, child: child),
  );
}

const _ink = Color(0xFF0F1A2A);
const _muted = Color(0xFF556375);
const _gold = Color(0xFFE2A93B);
const _goldLight = Color(0xFFF6D27A);

/// The app language, for the dates of the samples.
String _locale(BuildContext context) =>
    Localizations.localeOf(context).toLanguageTag();

/// A white card of the app, lifted off the page.
class _Card extends StatelessWidget {
  const _Card({
    required this.width,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = 24,
  });

  final double width;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    padding: padding,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: const [
        BoxShadow(
          color: Color(0x80000A1E),
          blurRadius: 36,
          spreadRadius: -14,
          offset: Offset(0, 18),
        ),
        BoxShadow(
          color: Color(0x26000A1E),
          blurRadius: 14,
          spreadRadius: -6,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: DefaultTextStyle.merge(
      style: const TextStyle(color: _ink),
      child: child,
    ),
  );
}

/// A white pill: a round icon and a few words.
class _Chip extends StatelessWidget {
  const _Chip({
    required this.icon,
    required this.iconColor,
    required this.disc,
    required this.text,
  });

  final IconData icon;
  final Color iconColor;
  final Color disc;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(maxWidth: 300),
    padding: const EdgeInsetsDirectional.fromSTEB(9, 9, 14, 9),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(99),
      boxShadow: const [
        BoxShadow(
          color: Color(0x73000A1E),
          blurRadius: 24,
          spreadRadius: -10,
          offset: Offset(0, 12),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(shape: BoxShape.circle, color: disc),
          child: Icon(icon, size: 17, color: iconColor),
        ),
        const SizedBox(width: 9),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _ink,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

/// A printed photo of the community, with its white border.
class _Polaroid extends StatelessWidget {
  const _Polaroid({
    required this.photo,
    required this.alignment,
    required this.size,
  });

  final String photo;
  final Alignment alignment;
  final Size size;

  @override
  Widget build(BuildContext context) => Container(
    width: size.width,
    height: size.height,
    padding: const EdgeInsets.fromLTRB(7, 7, 7, 26),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          color: Color(0x8C000000),
          blurRadius: 30,
          spreadRadius: -14,
          offset: Offset(0, 18),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: GradedPhoto(photo, alignment: alignment, grade: PhotoGrade.warm),
    ),
  );
}

/// Page 1: the home of a day, its ring, its goals, its streak and its week.
class _HomeCard extends StatelessWidget {
  const _HomeCard();

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = _locale(context);
    // a Sunday, the last day of its week
    final sunday = DateTime(2026, 11, 22);
    final date = DateFormat.MMMMEEEEd(locale).format(sunday);
    return _Card(
      width: 300,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date.substring(0, 1).toUpperCase() + date.substring(1),
            style: const TextStyle(
              fontSize: 12,
              color: _muted,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            t.home.greeting(name: t.welcome.sample.name),
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox.square(
                dimension: 78,
                child: CustomPaint(
                  painter: const _RingPainter(0.8),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '4/5',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          t.home.items,
                          style: const TextStyle(
                            fontSize: 10,
                            color: _muted,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _Stat(
                  label: t.home.goalsTitle,
                  dot: _gold,
                  value: const Text('100 %'),
                ),
              ),
              Expanded(
                child: _Stat(
                  label: t.home.streakTitle,
                  dot: _ink,
                  value: Row(
                    children: [
                      const Icon(AppIcons.streak, size: 17, color: _gold),
                      const SizedBox(width: 3),
                      Flexible(child: Text(t.welcome.sample.streakDays)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var day = 0; day < 7; day++)
                _Day(
                  letter: DateFormat.EEEEE(
                    locale,
                  ).format(sunday.subtract(Duration(days: 6 - day))),
                  done: day < 6,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.dot, required this.value});

  final String label;
  final Color dot;
  final Widget value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: dot),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: _muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 2),
      DefaultTextStyle.merge(
        maxLines: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        child: value,
      ),
    ],
  );
}

/// A day of the week: gold and ticked when done, today still open.
class _Day extends StatelessWidget {
  const _Day({required this.letter, required this.done});

  final String letter;
  final bool done;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        letter,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: done ? _muted : _ink,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: done ? _goldLight : Colors.white,
          border: done ? null : Border.all(color: _gold, width: 2.5),
        ),
        child: done
            ? const Icon(
                AppIcons.lessonDone,
                size: 14,
                color: Color(0xFF5A3D00),
              )
            : null,
      ),
    ],
  );
}

/// The ring of the day: [done] of it in gold.
class _RingPainter extends CustomPainter {
  const _RingPainter(this.done);

  final double done;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 8.0;
    final rect = (Offset.zero & size).deflate(stroke / 2 + 1);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawArc(
        rect,
        0,
        math.pi * 2,
        false,
        paint..color = const Color(0xFFF1EBDD),
      )
      ..drawArc(
        rect,
        -math.pi / 2,
        math.pi * 2 * done,
        false,
        paint..color = _gold,
      );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.done != done;
}

/// Page 2: the first hymn of the hymnbook, its first lines and its chorus.
class _HymnCard extends StatelessWidget {
  const _HymnCard();

  static const _green = Color(0xFF0A6A5F);

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final s = t.welcome.sample;
    return _Card(
      width: 262,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 5, 10, 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F5F2),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(AppIcons.hymn, size: 14, color: _green),
                const SizedBox(width: 6),
                Text(
                  s.hymnNumber,
                  style: const TextStyle(
                    color: _green,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            s.hymnTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            s.hymnBook,
            style: const TextStyle(
              fontSize: 11.5,
              color: _muted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 17,
                height: 17,
                margin: const EdgeInsets.only(top: 1),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF1F5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  '1',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: _muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  s.hymnLines,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F7F6),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.hymns.chorus.toUpperCase(),
                  style: const TextStyle(
                    color: _green,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  s.hymnChorus,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Page 3: the poster of an event, its place and « S'inscrire ».
class _EventCard extends StatelessWidget {
  const _EventCard();

  static const _ember = Color(0xFFC2410C);

  @override
  Widget build(BuildContext context) {
    final s = context.t.welcome.sample;
    final locale = _locale(context);
    final day = DateTime(2026, 12, 12);
    return _Card(
      width: 250,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 150,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF3A52B8), Color(0xFF151E55)],
                      ),
                    ),
                  ),
                ),
                // the sun rising behind the title
                PositionedDirectional(
                  end: -26,
                  bottom: -34,
                  child: Container(
                    width: 118,
                    height: 118,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF6C25A),
                      boxShadow: [
                        BoxShadow(color: Color(0x38F6C25A), spreadRadius: 14),
                        BoxShadow(color: Color(0x1AF6C25A), spreadRadius: 30),
                      ],
                    ),
                  ),
                ),
                PositionedDirectional(
                  start: 16,
                  top: 16,
                  width: 150,
                  child: Text(
                    s.retreat,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.02,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                PositionedDirectional(
                  start: 16,
                  bottom: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat.d(locale).format(day),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                        Text(
                          DateFormat.MMM(locale).format(day).toUpperCase(),
                          style: const TextStyle(
                            color: _ember,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 13, 16, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(AppIcons.place, size: 14, color: _muted),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        s.place,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: _muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 11),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _ember,
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Text(
                          s.register,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 46,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBEDE6),
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: const Icon(
                        AppIcons.addToCalendar,
                        size: 18,
                        color: Color(0xFF9A3412),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Page 3: an announcement of the assembly, not read yet.
class _NoticeCard extends StatelessWidget {
  const _NoticeCard();

  @override
  Widget build(BuildContext context) {
    final s = context.t.welcome.sample;
    return _Card(
      width: 252,
      radius: 20,
      padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 24, 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDEBE3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  AppIcons.notifications,
                  size: 20,
                  color: Color(0xFFC2410C),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.announcement,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      s.notice,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: _muted,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // not read yet
          PositionedDirectional(
            end: -12,
            top: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE0603A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
