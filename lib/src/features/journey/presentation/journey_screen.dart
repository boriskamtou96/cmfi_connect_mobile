import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/segmented_tabs.dart';
import '../../../core/widgets/sub_page.dart';
import '../../verses/application/verse_of_the_day.dart';
import '../application/journey_progress.dart';
import '../application/journey_steps.dart';
import '../domain/journey_step.dart';
import 'collective_card.dart';
import 'next_step_hero.dart';
import 'step_card.dart';
import 'step_card_dialog.dart';
import 'step_look.dart';
import 'step_medal.dart';
import 'weekly_cap_card.dart';

/// « Mes étapes »: the next step and the weekly cap on « Le chemin », then
/// the steps by what they reward, the ones reached in color with their date,
/// the others grey with how to reach them; and « Mes cartes », the cards of
/// the steps reached. For the member only: nobody else sees them.
@RoutePage()
class JourneyScreen extends HookConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final tab = useState(0);
    return SubPage(
      title: t.journey.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.xs,
              AppSpacing.lg,
              0,
            ),
            child: SegmentedTabs(
              labels: [t.gamification.tabs.path, t.gamification.tabs.cards],
              selectedIndex: tab.value,
              onChanged: (index) => tab.value = index,
            ),
          ),
          Expanded(
            child: tab.value == 0 ? const _PathTab() : const _CardsTab(),
          ),
        ],
      ),
    );
  }
}

class _PathTab extends ConsumerWidget {
  const _PathTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final reached =
        ref.watch(journeyStepsProvider).value ??
        const <JourneyStep, DateTime>{};
    final overview = ref.watch(journeyOverviewProvider);
    final week = today().startOfWeek;

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        Text(
          t.journey.subtitle,
          style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          t.journey.count(n: reached.length, total: JourneyStep.values.length),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: reached.length / JourneyStep.values.length,
            minHeight: 8,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        if (overview.next case final next?)
          NextStepHero(progress: next)
        else
          const _AllReached(),
        const SizedBox(height: AppSpacing.xl),
        WeeklyCapCard(week: week),
        const SizedBox(height: AppSpacing.xl),
        const CollectiveCard(),
        for (final group in JourneyGroup.values) ...[
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              SectionLabel(groupName(t, group), padded: false),
              const Spacer(),
              SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(
                  value: overview.ratioIn(group),
                  strokeWidth: 2.5,
                  color: stepColors(group).last,
                  backgroundColor: scheme.surfaceContainerHighest,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                t.gamification.next.family(
                  done: overview.reachedIn(group),
                  total: overview.totalIn(group),
                ),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          SectionCard(
            children: [
              for (final step in JourneyStep.values)
                if (step.group == group)
                  _StepRow(step: step, reachedOn: reached[step]),
            ],
          ),
        ],
      ],
    );
  }
}

class _AllReached extends StatelessWidget {
  const _AllReached();

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.xxl - 4),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const DoveMascot(pose: DovePose.celebrate, size: 52),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              t.gamification.next.allReached,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),
          ),
          Icon(AppIcons.checkCircleFilled, color: scheme.primary, size: 22),
        ],
      ),
    );
  }
}

class _CardsTab extends ConsumerWidget {
  const _CardsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final reached =
        ref.watch(journeyStepsProvider).value ??
        const <JourneyStep, DateTime>{};
    ref.watch(savedLanguageProvider);
    final calendar = ref
        .watch(verseCalendarProvider(LocaleSettings.currentLocale.languageCode))
        .value;

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        Text(
          t.gamification.cards.subtitle,
          style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          t.gamification.next.cardsCount(
            n: reached.length,
            total: JourneyStep.values.length,
          ),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.lg),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 210,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 1,
          ),
          itemCount: JourneyStep.values.length,
          itemBuilder: (context, index) {
            final step = JourneyStep.values[index];
            final reachedOn = reached[step];
            final verse = reachedOn == null ? null : calendar?.of(reachedOn);
            final title = stepTexts(context.t, step).title;
            final label = reachedOn == null
                ? '$title, ${t.gamification.cards.locked}'
                : '$title, ${t.journey.reachedOn(date: context.formatDate(reachedOn, 'd MMMM y'))}';
            return Semantics(
              button: true,
              label: label,
              excludeSemantics: true,
              child: GestureDetector(
                onTap: () => reachedOn == null
                    ? showLockedStepDialog(context, step)
                    : showStepCardDialog(
                        context,
                        step: step,
                        reachedOn: reachedOn,
                        verse: verse,
                      ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  child: StepCard(
                    step: step,
                    reachedOn: reachedOn,
                    verse: verse,
                  ),
                ),
              ),
            );
          },
        ),
        if (reached.isEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            t.gamification.cards.empty,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.reachedOn});

  final JourneyStep step;
  final DateTime? reachedOn;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final texts = stepTexts(t, step);
    final reached = reachedOn != null;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          StepMedal(step: step, reached: reached, size: 56),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  texts.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: reached ? null : scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  texts.text,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reached
                      ? t.journey.reachedOn(
                          date: context.formatDate(reachedOn!, 'd MMMM y'),
                        )
                      : t.journey.toReach,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    // darker than the medal: readable on the card
                    color: reached
                        ? Color.lerp(
                            stepColors(step.group).last,
                            scheme.onSurface,
                            0.3,
                          )
                        : scheme.outline,
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
