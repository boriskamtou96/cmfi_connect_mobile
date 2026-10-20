import 'dart:math' as math;

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
import '../../verses/application/verse_of_the_day.dart';
import '../../verses/domain/verse.dart';
import '../application/year_story.dart';
import '../domain/year_story.dart';
import 'widgets/story_pager.dart';
import 'widgets/story_stars.dart';

enum _Page { intro, faithful, prayer, word, fasts, goals, summary }

/// "Ton année avec Dieu": the year told in full-screen pages, like the week
/// (`WeekStoryScreen`), in the night blue and gold of the home screen. A page
/// without anything to tell is left out.
@RoutePage()
class YearStoryScreen extends ConsumerWidget {
  const YearStoryScreen({@PathParam('year') required this.year, super.key});

  final int year;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final story = ref.watch(yearStoryProvider(year));
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
        backgroundColor: _Night.colors.last,
        body: switch (story) {
          AsyncValue(value: final value?) => _Story(story: value, verse: verse),
          AsyncError(:final error) => _Message(
            year: year,
            text: userMessageFor(error, t),
            onRetry: () => ref.invalidate(yearStoryProvider(year)),
          ),
          _ => _Message(year: year),
        },
      ),
    );
  }
}

/// The night blue of the summary of the home screen, and what is written
/// on it (the gold is [AppColors.gold]).
abstract final class _Night {
  static const colors = [
    Color(0xFF0B3B70),
    AppColors.primaryDeep,
    AppColors.night,
  ];
  static const soft = Color(0xDDFFFFFF);
  static const faint = Color(0x99FFFFFF);
  static const cream = Color(0xFFFFE3A8);
  static const track = Color(0x2EFFFFFF);
}

/// Where the gold light of a page shines from.
AlignmentGeometry _glowOf(_Page page) => switch (page) {
  _Page.intro => AlignmentDirectional.topEnd,
  _Page.faithful => AlignmentDirectional.bottomStart,
  _Page.prayer => AlignmentDirectional.topStart,
  _Page.word => AlignmentDirectional.centerEnd,
  _Page.fasts => AlignmentDirectional.bottomEnd,
  _Page.goals => AlignmentDirectional.topCenter,
  _Page.summary => AlignmentDirectional.bottomCenter,
};

class _Story extends StatelessWidget {
  const _Story({required this.story, required this.verse});

  final YearStory story;
  final Verse? verse;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    // a page without anything to tell is left out
    final pages = [
      _Page.intro,
      if (story.daysFilled > 0) _Page.faithful,
      if (story.prayed) _Page.prayer,
      if (story.readTheWord) _Page.word,
      if (story.fastDays > 0) _Page.fasts,
      if (story.goals != null) _Page.goals,
      _Page.summary,
    ];
    return StoryPager(
      length: pages.length,
      pageBuilder: (context, index) => _PageFrame(
        key: ValueKey(pages[index]),
        year: story.year,
        glow: _glowOf(pages[index]),
        child: switch (pages[index]) {
          _Page.intro => _IntroPage(story: story),
          _Page.faithful => _FaithfulPage(story: story),
          _Page.prayer => _PrayerPage(story: story),
          _Page.word => _WordPage(story: story),
          _Page.fasts => _FastsPage(story: story),
          _Page.goals => _GoalsPage(story: story),
          _Page.summary => _SummaryPage(story: story, verse: verse),
        },
      ),
      pageLabel: (current, total) =>
          t.yearStory.page(current: current, total: total),
      shareLabel: t.yearStory.share,
      shareName: 'mon-annee-avec-dieu-${story.year}.png',
      shareSubject: t.yearStory.title,
      shareColor: _Night.colors[1],
    );
  }
}

/// A page: the night, a gold light from [glow] and a few stars; the logo,
/// the title and the year at the top, "CMFI Connect" at the bottom (for the
/// image shared), the content in between.
class _PageFrame extends StatelessWidget {
  const _PageFrame({
    required this.year,
    required this.glow,
    required this.child,
    super.key,
  });

  final int year;
  final AlignmentGeometry glow;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _Night.colors,
          stops: [0, 0.55, 1],
        ),
      ),
      child: Stack(
        children: [
          // decoration: the light and the stars (the same in both directions
          // of reading, but the light follows the page)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: glow,
                  radius: 0.9,
                  colors: [
                    AppColors.gold.withValues(alpha: 0.22),
                    AppColors.gold.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          const Positioned.fill(child: StoryStars()),
          Padding(
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
                      child: Text.rich(
                        TextSpan(
                          text: context.t.yearStory.title,
                          children: [
                            TextSpan(
                              text: '  $year',
                              style: const TextStyle(color: AppColors.gold),
                            ),
                          ],
                        ),
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
                    color: _Night.faint,
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

TextStyle _lead() => const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: AppColors.goldLight,
);

/// The big numbers, in Lora.
TextStyle _huge(double size, {Color color = Colors.white}) => TextStyle(
  fontFamily: 'Lora',
  fontSize: size,
  fontWeight: FontWeight.w600,
  height: 1.02,
  letterSpacing: -size / 40,
  color: color,
);

const _accent = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w700,
  color: _Night.cream,
);

/// "124 h" kept in this order inside a sentence read from right to left.
String _isolated(String text) => '\u2066$text\u2069';

String _month(BuildContext context, int year, int month) =>
    context.formatDate(DateTime(year, month), 'MMMM');

class _IntroPage extends StatelessWidget {
  const _IntroPage({required this.story});

  final YearStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            '${story.year}',
            style: _huge(124, color: AppColors.gold).copyWith(height: 1),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          t.yearStory.title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -0.6,
            color: Colors.white,
          ),
        ),
        if (story.startedDuring) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                AppIcons.calendar,
                color: AppColors.goldLight,
                size: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  t.yearStory.since(
                    date: context.formatDate(story.start, 'MMMMd'),
                  ),
                  style: _accent,
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 18),
        Text(
          t.yearStory.intro,
          style: const TextStyle(
            fontSize: 19,
            height: 1.35,
            color: _Night.soft,
          ),
        ),
        const Spacer(flex: 2),
        Text(
          t.yearStory.tapHint,
          style: const TextStyle(fontSize: 14, color: _Night.faint),
        ),
      ],
    );
  }
}

class _FaithfulPage extends StatelessWidget {
  const _FaithfulPage({required this.story});

  final YearStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final best = story.faithfulMonth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.yearStory.faithfulLead, style: _lead()),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            t.yearStory.days(n: story.daysFilled, total: story.daysCounted),
            style: _huge(72),
          ),
        ),
        if (story.bestStreak >= 2) ...[
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(AppIcons.streak, color: AppColors.gold, size: 24),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  t.yearStory.bestStreak(n: story.bestStreak),
                  style: _accent.copyWith(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 30),
        _MonthBars(
          year: story.year,
          // beside the most faithful month (a month begun counts as it is)
          values: [
            for (final (i, days) in story.monthDays.indexed)
              _counted(story, i + 1) ? days / (best?.days ?? 1) : null,
          ],
          highlight: best?.month,
        ),
        if (best != null) ...[
          const SizedBox(height: 20),
          Text(
            t.yearStory.faithfulMonth(
              n: best.days,
              month: _month(context, story.year, best.month),
            ),
            style: _accent,
          ),
        ],
      ],
    );
  }
}

/// Whether some days of [month] are counted in the story.
bool _counted(YearStory story, int month) =>
    !DateTime(story.year, month + 1, 0).isBefore(story.start) &&
    !DateTime(story.year, month).isAfter(story.end);

/// The twelve months, a bar each (from 0 to 1; null: not counted), the best
/// one in gold, with their initial underneath.
class _MonthBars extends StatelessWidget {
  const _MonthBars({required this.year, required this.values, this.highlight});

  final int year;
  final List<double?> values;

  /// The month in gold (1 to 12).
  final int? highlight;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        height: 116,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final (i, value) in values.indexed)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 16,
                      height: 6 + 78 * (value ?? 0).clamp(0, 1),
                      decoration: BoxDecoration(
                        color: value == null
                            ? Colors.white.withValues(alpha: 0.12)
                            : highlight == i + 1
                            ? AppColors.gold
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.formatDate(DateTime(year, i + 1), 'MMMMM'),
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: highlight == i + 1
                            ? AppColors.goldLight
                            : _Night.soft,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PrayerPage extends StatelessWidget {
  const _PrayerPage({required this.story});

  final YearStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final faithful = story.faithfulMoment;
    if (faithful == null) {
      // "Prière seule" only
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.yearStory.prayerLead, style: _lead()),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              _isolated(story.prayerMinutes.toDurationLabel()),
              style: _huge(84),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            t.yearStory.prayerAloneText,
            style: const TextStyle(fontSize: 19, color: _Night.soft),
          ),
        ],
      );
    }
    final counts = story.momentCounts;
    final most = counts.values.reduce(math.max);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.yearStory.prayerLead, style: _lead()),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            t.yearStory.retreats(n: story.retreats.length),
            style: _huge(64),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          t.yearStory.retreatsTime(
            time: _isolated(story.retreatMinutes.toDurationLabel()),
          ),
          style: const TextStyle(fontSize: 17, color: _Night.soft),
        ),
        if (story.prayerMinutes > 0) ...[
          const SizedBox(height: 6),
          Text(
            t.yearStory.prayerAlone(
              time: _isolated(story.prayerMinutes.toDurationLabel()),
            ),
            style: _accent,
          ),
        ],
        const SizedBox(height: 26),
        // the four moments of the day: their name, how often
        for (final moment in RetreatMoment.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: moment.colors),
                  ),
                  child: Icon(moment.icon, size: 19, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              moment.label(t),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: _Night.soft,
                              ),
                            ),
                          ),
                          Text(
                            '${counts[moment]}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: most == 0 ? 0 : counts[moment]! / most,
                          minHeight: 8,
                          color: moment == faithful.moment
                              ? AppColors.gold
                              : Colors.white,
                          backgroundColor: _Night.track,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
        Text(
          t.yearStory.faithfulMoment(
            n: faithful.times,
            moment: faithful.moment.label(t),
          ),
          style: _accent,
        ),
      ],
    );
  }
}

class _WordPage extends StatelessWidget {
  const _WordPage({required this.story});

  final YearStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final read = story.chapters > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          read ? t.yearStory.wordLead : t.yearStory.memoryLead,
          style: _lead(),
        ),
        if (read) ...[
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              t.yearStory.chapters(n: story.chapters),
              style: _huge(64),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            story.bibleShare >= 1
                ? t.yearStory.wholeBible
                : t.yearStory.bibleShare(
                    percent: context.formatPercent(story.bibleShare),
                  ),
            style: _accent.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 12),
          // the Bible, filled with gold as far as it was read
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              // a few chapters still show
              value: math.max(story.bibleShare.clamp(0, 1), 0.015),
              minHeight: 12,
              color: AppColors.gold,
              backgroundColor: _Night.track,
            ),
          ),
        ],
        const SizedBox(height: 28),
        if (story.versesKnown > 0)
          _CountRow(
            value: story.versesKnown,
            label: t.yearStory.versesKnown(n: story.versesKnown),
            big: !read,
          ),
        if (story.versesLearning > 0)
          _CountRow(
            value: story.versesLearning,
            label: t.yearStory.versesLearning(n: story.versesLearning),
            big: !read && story.versesKnown == 0,
          ),
      ],
    );
  }
}

/// A number in gold Lora, what it counts beside it.
class _CountRow extends StatelessWidget {
  const _CountRow({required this.value, required this.label, this.big = false});

  final int value;
  final String label;

  /// The main number of its page.
  final bool big;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$value', style: _huge(big ? 64 : 40, color: AppColors.gold)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: big ? 20 : 17,
                fontWeight: FontWeight.w600,
                height: 1.25,
                color: _Night.soft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FastsPage extends StatelessWidget {
  const _FastsPage({required this.story});

  final YearStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.yearStory.fastLead, style: _lead()),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            t.yearStory.fastDays(n: story.fastDays),
            style: _huge(84),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          t.yearStory.fastText,
          style: const TextStyle(fontSize: 19, color: _Night.soft),
        ),
        const SizedBox(height: 32),
        if (story.fullFasts > 0)
          _CountRow(
            value: story.fullFasts,
            label: t.yearStory.fullFasts(n: story.fullFasts),
          ),
        if (story.partialFasts > 0)
          _CountRow(
            value: story.partialFasts,
            label: t.yearStory.partialFasts(n: story.partialFasts),
          ),
      ],
    );
  }
}

class _GoalsPage extends StatelessWidget {
  const _GoalsPage({required this.story});

  final YearStory story;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final best = story.bestGoalsMonth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.yearStory.goalsLead, style: _lead()),
        const SizedBox(height: 22),
        Center(
          child: GoalRing(
            value: story.goals ?? 0,
            label: context.formatPercent(story.goals ?? 0),
            size: 176,
            color: AppColors.gold,
            trackColor: _Night.track,
            textColor: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            t.yearStory.goalsReached,
            style: const TextStyle(fontSize: 18, color: _Night.soft),
          ),
        ),
        const SizedBox(height: 28),
        _MonthBars(
          year: story.year,
          values: story.monthlyGoals,
          highlight: best?.month,
        ),
        if (best != null) ...[
          const SizedBox(height: 20),
          Text(
            t.yearStory.bestMonth(
              month: _month(context, story.year, best.month),
              percent: context.formatPercent(best.goals),
            ),
            style: _accent,
          ),
        ],
      ],
    );
  }
}

class _SummaryPage extends StatelessWidget {
  const _SummaryPage({required this.story, required this.verse});

  final YearStory story;
  final Verse? verse;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final stats = [
      if (story.daysFilled > 0)
        ('${story.daysFilled}/${story.daysCounted}', t.yearStory.statDays),
      if (story.bestStreak >= 2)
        ('${story.bestStreak}', t.yearStory.statStreak(n: story.bestStreak)),
      if (story.retreats.isNotEmpty)
        (
          '${story.retreats.length}',
          t.yearStory.statRetreats(n: story.retreats.length),
        )
      else if (story.prayerMinutes > 0)
        (
          _isolated(story.prayerMinutes.toDurationLabel()),
          t.yearStory.statPrayer,
        ),
      if (story.chapters > 0)
        ('${story.chapters}', t.yearStory.statChapters(n: story.chapters)),
      if (story.fastDays > 0)
        ('${story.fastDays}', t.yearStory.statFasts(n: story.fastDays)),
      if (story.goals case final goals?)
        (context.formatPercent(goals), t.yearStory.statGoals),
    ];

    Widget tile((String, String) stat) => Container(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 10, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(stat.$1, style: _huge(30, color: AppColors.gold)),
          ),
          const SizedBox(height: 2),
          Text(
            stat.$2,
            maxLines: 2,
            style: const TextStyle(fontSize: 13.5, color: _Night.soft),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${story.year}', style: _huge(52, color: AppColors.gold)),
        Text(
          t.yearStory.summaryTitle,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
        ),
        if (story.startedDuring) ...[
          const SizedBox(height: 6),
          Text(
            t.yearStory.since(date: context.formatDate(story.start, 'MMMMd')),
            style: const TextStyle(fontSize: 16, color: _Night.soft),
          ),
        ],
        const SizedBox(height: 20),
        if (stats.isEmpty)
          Text(
            t.yearStory.emptyText,
            style: const TextStyle(
              fontSize: 18,
              height: 1.4,
              color: _Night.soft,
            ),
          )
        else
          // two by two
          for (var i = 0; i < stats.length; i += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: tile(stats[i])),
                    const SizedBox(width: 10),
                    Expanded(
                      child: i + 1 < stats.length
                          ? tile(stats[i + 1])
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
        const Spacer(),
        if (verse case final verse?) ...[
          const SizedBox(height: 12),
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

/// Loading (the logo in the night of the pages), or what went wrong.
class _Message extends StatelessWidget {
  const _Message({required this.year, this.text, this.onRetry});

  final int year;
  final String? text;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _PageFrame(
            year: year,
            glow: _glowOf(_Page.intro),
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
                      style: const TextStyle(fontSize: 16, color: _Night.soft),
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
