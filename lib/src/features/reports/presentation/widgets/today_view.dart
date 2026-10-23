import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/store_review.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../../../core/widgets/animated_progress_bar.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/goal_ring.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/motion.dart';
import '../../../../core/widgets/rolling_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../journey/application/journey_steps.dart';
import '../../../journey/domain/journey_step.dart';
import '../../application/day_report_controller.dart';
import '../../application/report_goals.dart';
import '../../application/report_item_texts.dart';
import '../../application/report_reminder.dart';
import '../../application/report_timer.dart';
import '../../application/reports_providers.dart';
import '../../application/streak_milestones.dart';
import '../../domain/daily_report.dart';
import '../../domain/report_goal.dart';
import '../../domain/report_streak.dart';
import '../new_item_screen.dart';
import 'entry_row.dart';
import 'entry_sheet.dart';
import 'reminder_sheets.dart';
import 'streak_celebration.dart';
import 'timer_banner.dart';
import 'week_strip.dart';

/// "Today" view: fill in the items of the selected day.
class TodayView extends ConsumerWidget {
  const TodayView({required this.day, super.key});

  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final provider = dayReportControllerProvider(day);
    final report = ref.watch(provider);
    final goals = ref.watch(reportGoalsProvider);

    // the stopwatch of an item counted in time, today only
    Future<void> startTimer(ReportEntry entry) => startStopwatch(
      context,
      ref,
      activityTypeId: entry.activityTypeId,
      code: entry.code,
      label: entry.label,
    );

    Future<void> edit(ReportEntry entry, {required bool personal}) async {
      final goal = goals[entry.activityTypeId];
      final running = ref.read(reportTimerProvider);
      final values = await showEntrySheet(
        context,
        entry: entry,
        personal: personal,
        onStartTimer: entry.tracksDuration && day == today()
            ? () => startTimer(entry)
            : null,
        timerRunning: running?.activityTypeId == entry.activityTypeId,
        caption: goal == null
            ? null
            : t.items.goal(
                value: goalLabel(
                  goal,
                  t.itemUnit(entry.code, entry.quantityUnit),
                ),
              ),
      );
      if (values != null) {
        ref
            .read(provider.notifier)
            .updateEntry(
              entry.activityTypeId,
              quantity: values.quantity,
              durationMinutes: values.durationMinutes,
            );
      }
    }

    final header = Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: WeekStrip(
        selected: day,
        onSelect: ref.read(selectedReportDayProvider.notifier).select,
      ),
    );

    // One list for every state: the week strip stays the same element, so the
    // selected day animates when another day is picked.
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        ref
          ..invalidate(provider)
          ..invalidate(reportedDaysOfWeekProvider(day));
        await ref.read(provider.future).then((_) {}, onError: (_) {});
      },
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          header,
          ...switch (report) {
            AsyncValue(value: final draft?) => [
              FadeSlideIn(
                child: _Progress(draft: draft, goals: goals),
              ),
              const SizedBox(height: 14),
              if (draft.entries.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(t.reports.noItems, textAlign: TextAlign.center),
                ),
              if (draft.standardEntries.isNotEmpty) ...[
                FadeSlideIn(
                  index: 1,
                  child: SectionCard(
                    header: t.reports.standard,
                    children: [
                      for (final entry in draft.standardEntries)
                        EntryRow(
                          entry: entry,
                          personal: false,
                          goal: goals[entry.activityTypeId],
                          onTap: () => edit(entry, personal: false),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],
              FadeSlideIn(
                index: 2,
                child: SectionCard(
                  header: t.reports.personal,
                  children: [
                    for (final entry in draft.personalEntries)
                      EntryRow(
                        entry: entry,
                        personal: true,
                        goal: goals[entry.activityTypeId],
                        onTap: () => edit(entry, personal: true),
                      ),
                    const _CreateItemRow(),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              FadeSlideIn(
                index: 3,
                child: _NoteCard(
                  key: ValueKey(day),
                  initialNote: draft.note,
                  onChanged: ref.read(provider.notifier).updateNote,
                ),
              ),
            ],
            AsyncError(:final error) => [
              ErrorView(error: error, onRetry: () => ref.invalidate(provider)),
            ],
            // the progress of the day, then its items
            _ => [
              const Shimmer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SkeletonLine(widthFactor: 0.45, height: 15),
                          SizedBox(height: AppSpacing.sm),
                          SkeletonBox(height: 6, radius: 999),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    SkeletonList(count: 6, leading: 36, round: false),
                  ],
                ),
              ),
            ],
          },
        ],
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({required this.draft, required this.goals});

  final DayDraft draft;
  final Map<int, ReportGoal> goals;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final total = draft.entries.length;
    final isToday = draft.date.isSameDay(today());
    final goalsOfDay = dayGoals(goals, draft.entries);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isToday)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                context.formatDate(draft.date, 'EEEE d MMMM').capitalized,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: RollingText(
                  t.reports.filled(filled: draft.filledCount, total: total),
                  value: draft.filledCount,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: AppMotion.of(context, AppMotion.medium),
                switchInCurve: AppMotion.standard,
                switchOutCurve: Curves.easeInCubic,
                layoutBuilder: (current, previous) => Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [...previous, ?current],
                ),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation.drive(Tween(begin: 0.85, end: 1)),
                    child: child,
                  ),
                ),
                child: draft.dirty
                    ? StatusPill(
                        t.reports.statusModified,
                        key: const ValueKey('modified'),
                        background: tones.personalSoft,
                        foreground: tones.personal,
                      )
                    : draft.pending
                    ? StatusPill(
                        t.reports.statusPending,
                        key: const ValueKey('pending'),
                      )
                    : draft.submitted
                    ? StatusPill(
                        t.reports.statusSaved,
                        key: const ValueKey('saved'),
                        background: scheme.primaryContainer,
                        foreground: scheme.primary,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          AnimatedProgressBar(
            value: total == 0 ? 0 : draft.filledCount / total,
            backgroundColor: scheme.outlineVariant,
          ),
          if (goalsOfDay != null) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                GoalRing(
                  value: goalsOfDay.progress,
                  label: t.reports.dayGoals,
                  size: 48,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.reports.dayGoals,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.reports.goalsReached(
                          reached: goalsOfDay.reached,
                          total: goalsOfDay.total,
                        ),
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// "Créer un élément": the row grows into the form.
class _CreateItemRow extends StatelessWidget {
  const _CreateItemRow();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = scheme.primary;

    return OpenPage(
      page: const NewItemScreen(),
      color: scheme.surface,
      builder: (context, open) => _createRow(context, color, open),
    );
  }

  static Widget _createRow(
    BuildContext context,
    Color color,
    VoidCallback open,
  ) {
    return InkWell(
      onTap: open,
      child: SizedBox(
        height: 52,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              Icon(AppIcons.addCircle, size: 20, color: color),
              const SizedBox(width: 10),
              Text(
                context.t.reports.createItem,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoteCard extends HookWidget {
  const _NoteCard({
    required this.initialNote,
    required this.onChanged,
    super.key,
  });

  final String initialNote;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final controller = useTextEditingController(text: initialNote);

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        14,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: LabeledField(
        label: t.reports.note,
        optionalText: t.common.optional,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          minLines: 2,
          maxLines: 5,
          maxLength: 1000,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: t.reports.noteHint,
            counterText: '',
            fillColor: scheme.surfaceContainerLow,
          ),
        ),
      ),
    );
  }
}

/// Bottom bar of the "Today" view: saves the whole day.
class SaveDayBar extends HookConsumerWidget {
  const SaveDayBar({required this.day, super.key});

  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final draft = ref.watch(dayReportControllerProvider(day)).value;
    // runs for a moment after a save: the button shows a check meanwhile
    final savedFlash = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );
    final showCheck = useListenableSelector(
      savedFlash,
      () => savedFlash.isAnimating,
    );

    Future<void> save() async {
      final toast = ref.read(toasterProvider).of(context);
      final milestones = ref.read(streakMilestonesProvider.notifier);
      // the streak before this save (shown on Home), to see if it crosses
      // a milestone
      final before = ref.read(reportStreakProvider).value;
      try {
        final outcome = await ref
            .read(dayReportControllerProvider(day).notifier)
            .save();
        if (context.mounted) {
          savedFlash.forward(from: 0);
        }
        // no network: kept on the phone, a notice rather than a success
        if (outcome == SaveOutcome.sent) {
          toast.success(t.reports.saved);
        } else {
          toast.info(t.reports.savedOffline);
        }
        // 7, 30, 100 or 365 days in a row: Zoé celebrates (once each), and
        // after the first week, the store rating may be asked
        final milestone = await ref
            .read(reportStreakProvider.future)
            .then<int?>(
              (after) => milestones.reached(before: before, after: after),
              // no network: the streak is unknown, nothing to celebrate
              onError: (Object _) => null,
            );
        if (milestone != null && context.mounted) {
          final rating = ref.read(ratingPromptProvider);
          await showStreakCelebration(context, days: milestone);
          if (milestone == streakMilestones.first) {
            await rating.maybeAsk();
          }
        }
        // the first saved day is the moment to offer the evening reminder
        if (context.mounted && !ref.read(reportReminderProvider).offered) {
          await showReminderOffer(context, ref);
        }
        // « Premier pas », after the other dialogs of a first save
        await ref
            .read(journeyStepsProvider.notifier)
            .reach(JourneyStep.firstReport);
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      }
    }

    final saving = draft?.saving ?? false;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: FilledButton(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          // the day is saved (nothing left to save) but the check stays blue
          disabledBackgroundColor: showCheck ? scheme.primary : null,
          disabledForegroundColor: showCheck ? scheme.onPrimary : null,
        ),
        onPressed: draft != null && draft.dirty && !saving ? save : null,
        child: AnimatedSwitcher(
          duration: AppMotion.of(context, AppMotion.fast),
          switchInCurve: AppMotion.standard,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(Tween(begin: 0.7, end: 1)),
              child: child,
            ),
          ),
          child: saving
              ? AppSpinner(
                  key: const ValueKey('saving'),
                  size: 20,
                  strokeWidth: 2.4,
                  color: scheme.onPrimary,
                )
              : showCheck
              ? Icon(
                  AppIcons.check,
                  key: const ValueKey('saved'),
                  semanticLabel: t.reports.saved,
                )
              : Text(t.reports.save, key: const ValueKey('save')),
        ),
      ),
    );
  }
}
