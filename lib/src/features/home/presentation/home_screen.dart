import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/media_picture.dart';
import '../../../core/widgets/photo_kit.dart';
import '../../../routing/app_router.dart';
import '../../bible/application/bible_library.dart';
import '../../bible/application/bible_plan.dart';
import '../../bible/application/bible_position.dart';
import '../../bible/application/bible_settings.dart';
import '../../bible/application/memory_verses.dart';
import '../../bible/domain/bible.dart';
import '../../bible/domain/reading_plan.dart';
import '../../events/application/events_providers.dart';
import '../../events/domain/event.dart';
import '../../events/infrastructure/events_api.dart';
import '../../fasts/application/fasts.dart';
import '../../hymns/application/hymn_collections.dart';
import '../../hymns/application/hymn_library.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../../ministry/application/nations.dart';
import '../../ministry/domain/ministry_lives.dart';
import '../../notifications/application/inbox.dart';
import '../../prayer/application/retreats.dart';
import '../../prayer/domain/retreat.dart';
import '../../prayer/presentation/prayer_screen.dart';
import '../../prayer/presentation/widgets/prayer_look.dart';
import '../../profile/application/current_profile.dart';
import '../../reports/application/day_report_controller.dart';
import '../../reports/application/report_goals.dart';
import '../../reports/application/reports_providers.dart';
import '../../verses/presentation/verse_card.dart';
import '../application/home_privacy.dart';
import '../domain/week_story.dart';

/// The home screen, "Nuit et or" (validated on 2026-10-16): the summary of
/// the day first, in the night blue of CMFI (the report, the goals, the
/// retreats, the streak and the week, then "Continuer mon compte rendu");
/// under it, calm: what to pick up (the retreat of the moment, the hymn sung
/// last), the verse of the day, and the community in rows.
@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final now = today();
    final top = MediaQuery.paddingOf(context).top;

    void openReports(ReportsView view) {
      ref.read(selectedReportsViewProvider.notifier).select(view);
      if (view == ReportsView.today) {
        ref.read(selectedReportDayProvider.notifier).select(now);
      }
      context.navigateTo(const ReportsRoute());
    }

    // the verse of the day, in its chapter
    Future<void> readVerse(BibleRef place) async {
      await ref.read(bibleFocusProvider.notifier).show(place);
      if (context.mounted) {
        await context.navigateTo(const BibleRoute());
      }
    }

    Future<void> refresh() async {
      ref
        ..invalidate(currentProfileProvider)
        ..invalidate(dayReportControllerProvider(now))
        ..invalidate(reportHistoryProvider)
        ..invalidate(eventListProvider);
      await ref
          .read(dayReportControllerProvider(now).future)
          .then((_) {}, onError: (_) {});
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // the summary is night blue, under the status bar
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            RefreshIndicator.adaptive(
              onRefresh: refresh,
              edgeOffset: top,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 36),
                children: [
                  FadeSlideIn(
                    child: _Summary(
                      onOpen: () => openReports(ReportsView.today),
                      onWeek: () => openReports(ReportsView.history),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Sunday evening and Monday: the week told, first
                        if (storyWeekAt(DateTime.now()) case final week?) ...[
                          const SizedBox(height: 24),
                          FadeSlideIn(
                            index: 1,
                            child: _WeekStoryCard(monday: week),
                          ),
                        ],
                        const SizedBox(height: 28),
                        FadeSlideIn(index: 1, child: _Title(t.home.resume)),
                        const FadeSlideIn(index: 1, child: _Resume()),
                        const SizedBox(height: 30),
                        FadeSlideIn(
                          index: 2,
                          child: VerseOfTheDayCard(
                            onRead: (osis) {
                              if (BibleRef.parse(osis) case final place?) {
                                readVerse(place);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        FadeSlideIn(
                          index: 3,
                          child: _Title(
                            t.home.community,
                            action: t.home.seeAll,
                            onAction: () =>
                                context.router.push(const EventsRoute()),
                          ),
                        ),
                        const FadeSlideIn(index: 3, child: _Community()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // the status bar stays on night blue when the page scrolls
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: top,
              child: const ColoredBox(color: _Night.top),
            ),
          ],
        ),
      ),
    );
  }
}

/// The night blue of the summary.
/// A number hidden by the eye.
const _masked = '••';

abstract final class _Night {
  static const top = Color(0xFF0B3B70);
  static const colors = [top, Color(0xFF072D5A), Color(0xFF061F40)];
  static const lavender = Color(0xFFD9BCEB);
  static const muted = Color(0xA6FFFFFF);
}

/// The card style of the page: round, a soft shadow (a hairline in the
/// dark).
BoxDecoration _card(BuildContext context) {
  final dark = Theme.of(context).brightness == Brightness.dark;
  return BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(AppRadius.xxl - 4),
    border: dark
        ? Border.all(color: Colors.white.withValues(alpha: 0.06))
        : null,
    boxShadow: dark
        ? null
        : [
            BoxShadow(
              color: AppColors.ink.withValues(alpha: 0.04),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
            BoxShadow(
              color: AppColors.ink.withValues(alpha: 0.06),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
  );
}

class _Title extends StatelessWidget {
  const _Title(this.text, {this.action, this.onAction});

  final String text;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 12),
    child: Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action!)),
      ],
    ),
  );
}

/// The summary of the day, in night blue: the date and the greeting, the
/// ring of the report, the goals, the retreats and the streak, the week,
/// then "Continuer mon compte rendu".
class _Summary extends ConsumerWidget {
  const _Summary({required this.onOpen, required this.onWeek});

  final VoidCallback onOpen;
  final VoidCallback onWeek;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final now = today();
    final top = MediaQuery.paddingOf(context).top;
    final profile = ref.watch(currentProfileProvider).value;
    final draft = ref.watch(dayReportControllerProvider(now)).value;
    final filled = draft?.filledCount ?? 0;
    final total = draft?.entries.length ?? 0;
    final goals = ref.watch(goalsOfDayProvider(now));
    final retreats = ref.watch(retreatsTodayProvider).length;
    final streak = ref.watch(reportStreakProvider).value ?? 0;
    final reported =
        ref.watch(reportedDaysOfWeekProvider(now)).value ?? const <DateTime>{};
    final monday = now.startOfWeek;
    final week = [
      for (var i = 0; i < 7; i++)
        DateTime(monday.year, monday.month, monday.day + i),
    ];
    final letters = [
      for (final day in week) context.formatDate(day, 'EEEEE').toUpperCase(),
    ];
    // the eye: the numbers as •• (the ring empty, the days plain)
    final hidden = ref.watch(homeNumbersHiddenProvider);
    String shown(String value) => hidden ? _masked : value;

    return Container(
      padding: EdgeInsets.fromLTRB(20, top + 18, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _Night.colors,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PositionedDirectional(
            end: -120,
            top: -40,
            child: BrandRing(
              size: 300,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.formatDate(now, 'EEEE d MMMM').capitalized,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _Night.muted,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Semantics(
                          header: true,
                          child: Text(
                            profile == null
                                ? t.home.greetingNoName
                                : t.home.greeting(name: profile.firstName),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.6,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: hidden ? t.home.showNumbers : t.home.hideNumbers,
                    color: Colors.white,
                    onPressed: () =>
                        ref.read(homeNumbersHiddenProvider.notifier).toggle(),
                    icon: Icon(hidden ? AppIcons.hidden : AppIcons.visible),
                  ),
                  const IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: _Bell(),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Tooltip(
                    message: t.home.profile,
                    child: InkResponse(
                      onTap: () => context.router.push(const MoreRoute()),
                      radius: 28,
                      // light on the night blue, in both modes
                      child: MemberAvatar(
                        initials: profile?.initials ?? '',
                        photo: profile?.avatar,
                        size: 42,
                        background: Colors.white,
                        foreground: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                children: [
                  Semantics(
                    label: hidden
                        ? '${t.home.items} : ${t.home.numbersHidden}'
                        : '${t.home.progress(filled: filled, total: total)} '
                              '${t.home.progressLabel}',
                    excludeSemantics: true,
                    child: SizedBox.square(
                      dimension: 118,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox.expand(
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(
                                end: total == 0 || hidden ? 0 : filled / total,
                              ),
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, _) => CustomPaint(
                                painter: ProgressRingPainter(
                                  progress: value,
                                  color: AppColors.goldLight,
                                  track: Colors.white.withValues(alpha: 0.12),
                                  stroke: 9,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                draft == null ? '—' : shown('$filled/$total'),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.8,
                                  height: 1,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                t.home.items,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _Night.muted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Stat(
                          label: t.home.goalsTitle,
                          value: goals == null
                              ? '—'
                              : shown(
                                  '${(goals.progress * 100).round()}\u00a0%',
                                ),
                          hidden: hidden,
                          color: AppColors.goldLight,
                        ),
                        const _Hairline(),
                        _Stat(
                          label: t.home.retreatsTitle,
                          value: shown(t.home.retreatsValue(n: retreats)),
                          hidden: hidden,
                          color: _Night.lavender,
                        ),
                        const _Hairline(),
                        _Stat(
                          label: t.home.streakTitle,
                          value: shown(t.home.days(n: streak)),
                          hidden: hidden,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Semantics(
                button: true,
                label: t.home.weekTitle,
                child: InkWell(
                  onTap: onWeek,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        for (final (i, day) in week.indexed)
                          Expanded(
                            child: _Day(
                              letter: letters[i],
                              today: day == now,
                              done:
                                  !hidden &&
                                  (reported.contains(day) ||
                                      (day == now && filled > 0)),
                              future: day.isAfter(now),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onOpen,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryDeep,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  child: Text(
                    filled == 0
                        ? t.home.startMyReport
                        : t.home.continueMyReport,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Hairline extends StatelessWidget {
  const _Hairline();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Divider(height: 1, color: Colors.white.withValues(alpha: 0.10)),
  );
}

/// A number of the summary, its label above with a coloured dot.
class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    required this.color,
    this.hidden = false,
  });

  final String label;
  final String value;
  final Color color;

  /// The eye is closed: read as "masqué".
  final bool hidden;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '$label : ${hidden ? context.t.home.numbersHidden : value}',
    excludeSemantics: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: _Night.muted,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

/// A day of the week: gold with a check once the report is in.
class _Day extends StatelessWidget {
  const _Day({
    required this.letter,
    required this.today,
    required this.done,
    required this.future,
  });

  final String letter;
  final bool today;
  final bool done;
  final bool future;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        letter,
        style: TextStyle(
          fontSize: 12,
          fontWeight: today ? FontWeight.w800 : FontWeight.w600,
          color: Colors.white.withValues(alpha: today ? 1 : 0.6),
        ),
      ),
      const SizedBox(height: 6),
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: done
              ? AppColors.goldLight
              : Colors.white.withValues(alpha: future ? 0.06 : 0.12),
          border: today && !done
              ? Border.all(color: AppColors.goldLight, width: 2)
              : null,
        ),
        child: done
            ? const Icon(AppIcons.check, size: 14, color: AppColors.primaryDeep)
            : null,
      ),
    ],
  );
}

/// What to pick up: the retreat of the moment (or the four made), the hymn
/// sung last.
class _Resume extends ConsumerWidget {
  const _Resume();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final moment = nextRetreat(ref.watch(retreatsTodayProvider), now);
    final last = ref.watch(recentHymnsProvider).firstOrNull;
    // the books are only loaded when there is a hymn to go back to
    final hymn = last == null
        ? null
        : ref.watch(hymnBookProvider(last.bookCode))?.hymn(last.number);
    final hymns = AppModule.hymns.tone(context);
    final prayer = AppModule.prayer.tone(context);
    final bible = AppModule.bible.tone(context);
    // the reading plan: today's chapters, while not all read
    final plan = ref.watch(biblePlanProvider);
    final day = today();
    final reading = plan == null || plan.doneOn(day)
        ? const <BibleRef>[]
        : plan.chaptersOf(day);
    // a fast under way: its day and what is left of it
    final fast = ref.watch(fastsProvider).current;
    final fastDay = fast == null || fast.isOverAt(DateTime.now())
        ? null
        : fast.dayAt(DateTime.now()).clamp(0, fast.days - 1);
    // the verses learnt by heart: those to review today
    ref.watch(memoryVersesProvider);
    final memory = ref.read(memoryVersesProvider.notifier).dueOn(day).length;
    final version = ref.watch(bibleVersionProvider);
    final names = <String, String>{
      for (final BibleBook book
          in ref.watch(bibleBooksProvider(version.id)).value ?? const [])
        book.id: book.name,
    };

    return Container(
      decoration: _card(context),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            if (moment == null)
              _Row(
                leading: _Tile(
                  color: prayer.soft,
                  child: PhosphorIcon(
                    AppIcons.prayerTile,
                    size: 22,
                    color: prayer.onSoft,
                  ),
                ),
                title: t.nav.prayer,
                text: t.home.retreatsDone,
                onTap: () => context.navigateTo(const PrayerRoute()),
              )
            else
              _Row(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: moment.colors,
                    ),
                  ),
                  child: Icon(moment.icon, color: Colors.white, size: 20),
                ),
                title: moment.retreat(t),
                text: moment == momentAt(now)
                    ? t.prayer.routine.now
                    : t.prayer.routine.next,
                onTap: () => context.router.push(RetreatRoute(moment: moment)),
                trailing: IconButton.filled(
                  tooltip: t.prayer.hero.start,
                  onPressed: () =>
                      context.router.push(RetreatSessionRoute(moment: moment)),
                  style: IconButton.styleFrom(
                    backgroundColor: scheme.onSurface,
                    foregroundColor: scheme.surface,
                    fixedSize: const Size.square(38),
                    minimumSize: const Size.square(38),
                  ),
                  icon: const Icon(AppIcons.play, size: 16),
                ),
              ),
            if (reading.isNotEmpty) ...[
              Divider(
                height: 1,
                indent: 74,
                endIndent: 16,
                color: scheme.outlineVariant,
              ),
              _Row(
                leading: _Tile(
                  color: bible.soft,
                  child: PhosphorIcon(
                    AppIcons.readingPlan,
                    size: 22,
                    color: bible.onSoft,
                  ),
                ),
                title: t.biblePlan.homeTitle,
                text: readingLabel(reading, (book) => names[book] ?? book),
                onTap: () => context.router.push(const BiblePlanRoute()),
              ),
            ],
            if (fast != null && fastDay != null) ...[
              Divider(
                height: 1,
                indent: 74,
                endIndent: 16,
                color: scheme.outlineVariant,
              ),
              _Row(
                leading: _Tile(
                  color: prayer.soft,
                  child: PhosphorIcon(
                    AppIcons.fastsTile,
                    size: 22,
                    color: prayer.onSoft,
                  ),
                ),
                title: t.fasts.homeTitle(day: fastDay + 1, total: fast.days),
                text: t.fasts.homeText(
                  time: context.formatDate(fast.endOfDay(fastDay), 'HH:mm'),
                ),
                onTap: () => context.router.push(const FastsRoute()),
              ),
            ],
            if (memory > 0) ...[
              Divider(
                height: 1,
                indent: 74,
                endIndent: 16,
                color: scheme.outlineVariant,
              ),
              _Row(
                leading: _Tile(
                  color: bible.soft,
                  child: PhosphorIcon(
                    AppIcons.memorizeTile,
                    size: 22,
                    color: bible.onSoft,
                  ),
                ),
                title: t.memorize.homeTitle,
                text: t.memorize.homeText(n: memory),
                onTap: () => context.router.push(MemoryReviewRoute()),
              ),
            ],
            Divider(
              height: 1,
              indent: 74,
              endIndent: 16,
              color: scheme.outlineVariant,
            ),
            _Row(
              leading: _Tile(
                color: hymns.soft,
                child: PhosphorIcon(
                  AppIcons.hymnsTile,
                  size: 22,
                  color: hymns.onSoft,
                ),
              ),
              title: hymn == null
                  ? t.home.hymnsTitle
                  : t.home.hymnNumber(number: hymn.number),
              text: hymn?.title ?? t.home.hymnsOpen,
              onTap: () => last != null && hymn != null
                  ? context.router.push(
                      HymnReaderRoute(
                        bookCode: last.bookCode,
                        number: last.number,
                      ),
                    )
                  : context.navigateTo(const HymnsRoute()),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: 44,
    height: 44,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(child: child),
  );
}

/// A row of the cards of the page: a picture, two lines, an action.
class _Row extends StatelessWidget {
  const _Row({
    required this.leading,
    required this.title,
    required this.text,
    required this.onTap,
    this.trailing,
    this.badge,
  });

  final Widget leading;
  final String title;
  final String text;
  final VoidCallback onTap;
  final Widget? trailing;

  /// At the end instead of the chevron ("J-12").
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            trailing ??
                badge ??
                Icon(
                  AppIcons.chevronRight,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
          ],
        ),
      ),
    );
  }
}

/// The community in rows: the next two events (a small poster, when, the
/// days left), then the ministry.
class _Community extends ConsumerWidget {
  const _Community();

  /// The rest is in "Tout voir".
  static const _max = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);
    final upcoming = [
      for (final event
          in ref.watch(eventListProvider(EventPeriod.upcoming)).value ??
              const <CommunityEvent>[])
        if (event.status == EventStatus.published) event,
    ];
    final nations = ref.watch(nationsProvider).value?.length ?? 154;
    final now = DateTime.now();

    String countdown(CommunityEvent event) {
      if (event.isOn(now)) {
        return t.events.onNow;
      }
      return switch (event.daysUntil(now)) {
        <= 0 => t.events.today,
        1 => t.events.tomorrow,
        final days => t.events.daysLeft(n: days),
      };
    }

    final divider = Divider(
      height: 1,
      indent: 74,
      endIndent: 16,
      color: scheme.outlineVariant,
    );

    return Container(
      decoration: _card(context),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            if (upcoming.isEmpty)
              _Row(
                leading: _Tile(
                  color: tone.soft,
                  child: PhosphorIcon(
                    AppIcons.eventsTile,
                    size: 22,
                    color: tone.onSoft,
                  ),
                ),
                title: t.home.eventsTitle,
                text: t.events.homeText,
                onTap: () => context.router.push(const EventsRoute()),
              ),
            for (final event in upcoming.take(_max)) ...[
              _Row(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 44,
                    height: 55,
                    child: event.poster == null
                        ? _Tile(
                            color: tone.soft,
                            child: PhosphorIcon(
                              AppIcons.eventsTile,
                              size: 22,
                              color: tone.onSoft,
                            ),
                          )
                        : MediaPicture(
                            url: event.poster!.url,
                            argb: event.poster!.argb,
                          ),
                  ),
                ),
                title: event.title,
                text: [
                  context.formatDayRange(
                    event.startsAt,
                    event.endsAt,
                    timeZone: event.timeZone,
                  ),
                  event.city,
                  if (event.registration.registered) t.events.registered,
                ].where((part) => part.isNotEmpty).join(' · '),
                onTap: () => context.router.push(EventRoute(eventId: event.id)),
                badge: Text(
                  countdown(event),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: tone.onSoft,
                  ),
                ),
              ),
              divider,
            ],
            if (upcoming.isEmpty) divider,
            _Row(
              // our founder and our leader: real faces of the ministry
              leading: FaceStack(
                faces: [
                  for (final life in const [
                    MinistryLife.founder,
                    MinistryLife.leader,
                  ])
                    Image.asset(
                      life.asset,
                      fit: BoxFit.cover,
                      excludeFromSemantics: true,
                    ),
                ],
                ring: scheme.surface,
                size: 44,
                overlap: 0.3,
              ),
              title: t.ministry.title,
              text: t.ministry.homeText(n: nations),
              onTap: () => context.router.push(const MinistryRoute()),
            ),
          ],
        ),
      ),
    );
  }
}

/// The notifications of the admins, with the number not read yet.
class _Bell extends ConsumerWidget {
  const _Bell();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.notifications;
    final unread = ref.watch(inboxProvider).value?.unread ?? 0;

    return IconButton(
      tooltip: unread > 0 ? '${t.title} · ${t.unread(n: unread)}' : t.title,
      onPressed: () => context.router.push(const NotificationsRoute()),
      icon: Badge(
        isLabelVisible: unread > 0,
        label: Text(unread > 9 ? '9+' : '$unread'),
        child: const Icon(AppIcons.notifications),
      ),
    );
  }
}

/// "Ta semaine avec Dieu est prête": from Sunday 18:00 to Monday evening.
class _WeekStoryCard extends StatelessWidget {
  const _WeekStoryCard({required this.monday});

  final DateTime monday;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final sunday = DateTime(monday.year, monday.month, monday.day + 6);
    void open() =>
        context.router.push(WeekStoryRoute(monday: monday.toApiDate()));
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl + 4),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F6BFF), Color(0xFF6A2FB8)],
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: open,
          child: Stack(
            children: [
              PositionedDirectional(
                end: -40,
                top: -50,
                child: BrandRing(
                  size: 160,
                  color: Colors.white.withValues(alpha: 0.14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CmfiLogo(size: 26, disc: true),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            t.weekStory.range(
                              from: context.formatDate(monday, 'd MMM'),
                              to: context.formatDate(sunday, 'd MMM'),
                            ),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFD6DCFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t.weekStory.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.weekStory.homeText,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.35,
                        color: Color(0xE6FFFFFF),
                      ),
                    ),
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: open,
                      icon: const Icon(AppIcons.play, size: 18),
                      label: Text(t.weekStory.open),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF3A2A9A),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
