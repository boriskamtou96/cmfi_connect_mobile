import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/goal_ring.dart';
import '../../prayer/domain/prayer.dart';
import '../../prayer/presentation/widgets/prayer_look.dart';
import '../../reports/application/report_item_texts.dart';
import '../../reports/domain/measure_format.dart';
import '../../reports/domain/report_export.dart';
import '../../verses/application/verse_of_the_day.dart';
import '../../verses/domain/verse.dart';
import '../application/week_story.dart';
import '../domain/week_story.dart';
import 'widgets/story_pager.dart';

enum _Page { intro, faithful, prayer, goals, summary }

/// "Ta semaine avec Dieu": the week told in a few full-screen pages, like
/// stories. Each page goes on by itself (not with "reduce motion"); a tap on
/// the right goes on, on the left goes back, a long press holds. Each page can
/// be shared as an image.
@RoutePage()
class WeekStoryScreen extends HookConsumerWidget {
  const WeekStoryScreen({@PathParam('monday') required this.monday, super.key});

  /// The Monday of the week ("2026-10-12").
  final String monday;

  /// How long a page stays before the next one.
  static const pageDuration = StoryPager.pageDuration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final day = (DateTime.tryParse(monday) ?? today()).startOfWeek;
    final story = ref.watch(weekStoryProvider(day));
    ref.watch(savedLanguageProvider);
    final calendar = ref.watch(
      verseCalendarProvider(LocaleSettings.currentLocale.languageCode),
    );
    final verse = story.value == null
        ? null
        : calendar.value?.of(story.value!.end);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: _colorsOf(_Page.intro).last,
        body: switch (story) {
          AsyncValue(value: final value?) => _Story(story: value, verse: verse),
          AsyncError(:final error) => _Message(
            text: userMessageFor(error, t),
            onRetry: () => ref.invalidate(weekStoryProvider(day)),
          ),
          _ => const _Message(),
        },
      ),
    );
  }
}

List<Color> _colorsOf(_Page page) => switch (page) {
  _Page.intro => const [
    Color(0xFF0B2547),
    Color(0xFF2B2A7A),
    Color(0xFF4A2B8F),
  ],
  _Page.faithful => const [
    Color(0xFF2F6BFF),
    Color(0xFF6A2FB8),
    Color(0xFF1E1650),
  ],
  _Page.prayer => const [
    Color(0xFF7A4A98),
    Color(0xFFB9577A),
    Color(0xFF2A1430),
  ],
  _Page.goals => const [
    Color(0xFF0E7A72),
    Color(0xFF0A4E6E),
    Color(0xFF0C1E3A),
  ],
  _Page.summary => const [
    Color(0xFF0B1F45),
    Color(0xFF1B1550),
    Color(0xFF14123A),
  ],
};

const _soft = Color(0xDDFFFFFF);
const _faint = Color(0x99FFFFFF);

class _Story extends StatelessWidget {
  const _Story({required this.story, required this.verse});

  final WeekStory story;
  final Verse? verse;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final pages = [
      _Page.intro,
      _Page.faithful,
      _Page.prayer,
      // without goals, nothing to tell
      if (story.goals != null) _Page.goals,
      _Page.summary,
    ];
    return StoryPager(
      length: pages.length,
      pageBuilder: (context, index) => _PageFrame(
        key: ValueKey(pages[index]),
        colors: _colorsOf(pages[index]),
        child: switch (pages[index]) {
          _Page.intro => _IntroPage(story: story),
          _Page.faithful => _FaithfulPage(story: story),
          _Page.prayer => _PrayerPage(story: story),
          _Page.goals => _GoalsPage(story: story),
          _Page.summary => _SummaryPage(story: story, verse: verse),
        },
      ),
      pageLabel: (current, total) =>
          t.weekStory.page(current: current, total: total),
      shareLabel: t.weekStory.share,
      shareName: 'ma-semaine-avec-dieu-${story.monday.toApiDate()}.png',
      shareSubject: t.weekStory.title,
    );
  }
}

/// A page: its colors, the logo and the title at the top, "CMFI Connect" at
/// the bottom (for the image shared), the content in between.
class _PageFrame extends StatelessWidget {
  const _PageFrame({required this.colors, required this.child, super.key});

  final List<Color> colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
          stops: const [0, 0.55, 1],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          22,
          padding.top + 30,
          22,
          padding.bottom + 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const CmfiLogo(size: 30, disc: true),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    context.t.weekStory.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                // room for the close button
                const SizedBox(width: 40),
              ],
            ),
            Expanded(
              child: Padding(
                // room for the share button
                padding: const EdgeInsets.only(top: 28, bottom: 92),
                // a long verse, big text: the page shrinks to fit
                child: LayoutBuilder(
                  builder: (context, constraints) => FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.topStart,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        maxWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(child: child),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              'CMFI Connect',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: _faint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _lead() => const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: Color(0xFFD6DCFF),
);

TextStyle _huge(double size) => TextStyle(
  fontSize: size,
  fontWeight: FontWeight.w800,
  height: 0.98,
  letterSpacing: -size / 25,
  color: Colors.white,
);

class _IntroPage extends StatelessWidget {
  const _IntroPage({required this.story});

  final WeekStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final sunday = DateTime(
      story.monday.year,
      story.monday.month,
      story.monday.day + 6,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        const CmfiLogo.onDark(size: 84),
        const SizedBox(height: 28),
        Text(
          t.weekStory.range(
            from: context.formatDate(story.monday, 'd MMMM'),
            to: context.formatDate(sunday, 'd MMMM'),
          ),
          style: _huge(42),
        ),
        const SizedBox(height: 16),
        Text(
          t.weekStory.intro,
          style: const TextStyle(fontSize: 19, height: 1.35, color: _soft),
        ),
        const Spacer(flex: 2),
        Text(
          t.weekStory.tapHint,
          style: const TextStyle(fontSize: 14, color: _faint),
        ),
      ],
    );
  }
}

class _FaithfulPage extends StatelessWidget {
  const _FaithfulPage({required this.story});

  final WeekStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final empty = story.daysFilled == 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          empty ? t.weekStory.emptyLead : t.weekStory.faithfulLead,
          style: _lead(),
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            t.weekStory.days(n: story.daysFilled, total: story.daysInWeek),
            style: _huge(74),
          ),
        ),
        if (story.streak >= 2) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(AppIcons.streak, color: AppColors.gold, size: 24),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  story.streakIsRecord
                      ? t.weekStory.streakRecord(n: story.streak)
                      : t.weekStory.streak(n: story.streak),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFE3A8),
                  ),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 30),
        if (empty)
          Text(
            t.weekStory.emptyText,
            style: const TextStyle(fontSize: 18, height: 1.4, color: _soft),
          )
        else
          for (final (i, item) in story.items.take(4).indexed)
            _RankedItem(rank: i + 1, item: item, days: story.daysInWeek),
      ],
    );
  }
}

class _RankedItem extends StatelessWidget {
  const _RankedItem({
    required this.rank,
    required this.item,
    required this.days,
  });

  final int rank;
  final ExportItem item;
  final int days;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final standard = !item.personal;
    final value = MeasureFormat.value(
      quantity: item.tracksQuantity ? item.totalQuantity : null,
      minutes: item.tracksDuration ? item.totalMinutes : null,
      unit: t.itemUnit(item.code, item.unit, standard: standard),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 36,
                child: Text(
                  '#$rank',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB7C2FF),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  t.itemLabel(item.code, item.label, standard: standard),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 36),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: item.daysCount / days,
                minHeight: 6,
                color: Colors.white,
                backgroundColor: Colors.white.withValues(alpha: 0.18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrayerPage extends StatelessWidget {
  const _PrayerPage({required this.story});

  final WeekStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final faithful = story.faithfulMoment;
    if (faithful == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(t.weekStory.noRetreat, style: _huge(48)),
          const SizedBox(height: 16),
          Text(
            t.weekStory.noRetreatText,
            style: const TextStyle(fontSize: 19, height: 1.35, color: _soft),
          ),
          const Spacer(flex: 2),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.weekStory.prayerLead, style: _lead()),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            t.weekStory.retreats(n: story.retreats.length),
            style: _huge(64),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          t.weekStory.retreatsTime(
            time: story.retreatMinutes.toDurationLabel(),
          ),
          style: const TextStyle(fontSize: 17, color: _soft),
        ),
        const SizedBox(height: 28),
        _RetreatGrid(story: story),
        const SizedBox(height: 26),
        Row(
          children: [
            Icon(faithful.moment.icon, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                t.weekStory.faithfulMoment(
                  n: faithful.times,
                  moment: faithful.moment.label(t),
                ),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFE3A8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// The week, a square for each retreat: in its color when it was made.
class _RetreatGrid extends StatelessWidget {
  const _RetreatGrid({required this.story});

  final WeekStory story;

  @override
  Widget build(BuildContext context) {
    final days = [
      for (var i = 0; i < 7; i++)
        DateTime(story.monday.year, story.monday.month, story.monday.day + i),
    ];
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 30),
            for (final day in days)
              Expanded(
                child: Text(
                  context.formatDate(day, 'EEEEE'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _soft,
                  ),
                ),
              ),
          ],
        ),
        for (final moment in RetreatMoment.values)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Icon(moment.icon, size: 18, color: _soft),
                ),
                for (final day in days)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 34,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: story.prayed(day, moment)
                              ? null
                              : Colors.white.withValues(alpha: 0.14),
                          gradient: story.prayed(day, moment)
                              ? LinearGradient(colors: moment.colors)
                              : null,
                          border: story.prayed(day, moment)
                              ? Border.all(color: Colors.white, width: 1.5)
                              : null,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _GoalsPage extends StatelessWidget {
  const _GoalsPage({required this.story});

  final WeekStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final best = story.bestDay;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.weekStory.goalsLead, style: _lead()),
        const SizedBox(height: 24),
        Center(
          child: GoalRing(
            value: story.goals ?? 0,
            label: context.formatPercent(story.goals ?? 0),
            size: 190,
            color: AppColors.gold,
            trackColor: Colors.white.withValues(alpha: 0.18),
            textColor: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            t.weekStory.goalsReached,
            style: const TextStyle(fontSize: 18, color: _soft),
          ),
        ),
        const SizedBox(height: 30),
        // day by day
        SizedBox(
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final (i, value) in story.dailyGoals.indexed)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 26,
                        height: 8 + 70 * (value ?? 0),
                        decoration: BoxDecoration(
                          color: value == null
                              ? Colors.white.withValues(alpha: 0.14)
                              : best?.day.isSameDay(
                                      DateTime(
                                        story.monday.year,
                                        story.monday.month,
                                        story.monday.day + i,
                                      ),
                                    ) ??
                                    false
                              ? AppColors.gold
                              : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.formatDate(
                          DateTime(
                            story.monday.year,
                            story.monday.month,
                            story.monday.day + i,
                          ),
                          'EEEEE',
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _soft,
                        ),
                      ),
                    ],
                  ),
                ),
              // the days still to come
              for (var i = story.dailyGoals.length; i < 7; i++)
                const Expanded(child: SizedBox()),
            ],
          ),
        ),
        if (best != null) ...[
          const SizedBox(height: 22),
          Text(
            t.weekStory.bestDay(
              day: context.formatDate(best.day, 'EEEE').capitalized,
              percent: context.formatPercent(best.goals),
            ),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFE3A8),
            ),
          ),
        ],
      ],
    );
  }
}

class _SummaryPage extends StatelessWidget {
  const _SummaryPage({required this.story, required this.verse});

  final WeekStory story;
  final Verse? verse;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final top = story.items.firstOrNull;
    final sunday = DateTime(
      story.monday.year,
      story.monday.month,
      story.monday.day + 6,
    );
    Widget stat(String value, String label) => Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.gold,
                ),
              ),
            ),
            Text(
              label,
              maxLines: 2,
              style: const TextStyle(fontSize: 13.5, color: _soft),
            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.weekStory.summaryTitle, style: _huge(36)),
        const SizedBox(height: 6),
        Text(
          t.weekStory.range(
            from: context.formatDate(story.monday, 'd MMMM'),
            to: context.formatDate(sunday, 'd MMMM'),
          ),
          style: const TextStyle(fontSize: 16, color: _soft),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            stat(
              '${story.daysFilled}/${story.daysInWeek}',
              t.weekStory.statDays,
            ),
            const SizedBox(width: 10),
            stat('${story.streak}', t.weekStory.statStreak(n: story.streak)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            stat(
              '${story.retreats.length}',
              t.weekStory.statRetreats(n: story.retreats.length),
            ),
            const SizedBox(width: 10),
            if (story.goals case final goals?)
              stat(context.formatPercent(goals), t.weekStory.statGoals)
            else
              const Expanded(child: SizedBox()),
          ],
        ),
        if (top != null) ...[
          const SizedBox(height: 18),
          Text(
            '#1  ${t.itemLabel(top.code, top.label, standard: !top.personal)}'
            ' · ${MeasureFormat.value(
              quantity: top.tracksQuantity ? top.totalQuantity : null,
              minutes: top.tracksDuration ? top.totalMinutes : null,
              unit: t.itemUnit(top.code, top.unit, standard: !top.personal),
            )}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
        const Spacer(),
        if (verse case final verse?) ...[
          Text(
            verse.text,
            style: const TextStyle(
              fontFamily: 'Lora',
              fontStyle: FontStyle.italic,
              fontSize: 18,
              height: 1.4,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            verse.reference,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.gold,
            ),
          ),
        ],
      ],
    );
  }
}

/// Loading (the logo on the night of the first page), or what went wrong.
class _Message extends StatelessWidget {
  const _Message({this.text, this.onRetry});

  final String? text;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _PageFrame(
            colors: _colorsOf(_Page.intro),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CmfiLogo.onDark(size: 72),
                  if (text != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      text!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: _soft),
                    ),
                    if (onRetry != null) ...[
                      const SizedBox(height: 14),
                      OutlinedButton(
                        onPressed: onRetry,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        ),
                        child: Text(context.t.common.retry),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          end: 4,
          top: MediaQuery.paddingOf(context).top + 20,
          child: IconButton(
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            onPressed: () => context.router.maybePop(),
            icon: const Icon(AppIcons.close, color: Colors.white, size: 26),
          ),
        ),
      ],
    );
  }
}
