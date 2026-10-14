import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../application/disciples.dart';
import '../domain/disciple.dart';

/// Plus › Mes disciples: the members who chose the user as disciple maker,
/// each with how regular they are (never what their reports say), when they
/// share it.
@RoutePage()
class DisciplesScreen extends ConsumerWidget {
  const DisciplesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;
    final disciples = ref.watch(disciplesProvider);

    Future<void> refresh() async {
      ref.invalidate(disciplesProvider);
      await ref
          .read(disciplesProvider.future)
          .then((_) {}, onError: (Object _) {});
    }

    final intro = Text(
      t.intro,
      style: TextStyle(
        fontSize: 15,
        height: 1.4,
        color: scheme.onSurfaceVariant,
      ),
    );

    return SubPage(
      title: t.title,
      child: switch (disciples) {
        AsyncData(value: final list) when list.isEmpty => Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DoveMascot(pose: DovePose.rest, size: 104),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  t.empty,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  t.emptyText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        AsyncData(value: final list) => RefreshIndicator(
          onRefresh: refresh,
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              intro,
              const SizedBox(height: AppSpacing.lg),
              for (final disciple in list) ...[
                _DiscipleCard(disciple: disciple, today: today()),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          ),
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(disciplesProvider),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _DiscipleCard extends StatelessWidget {
  const _DiscipleCard({required this.disciple, required this.today});

  final Disciple disciple;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;
    final member = disciple.member;
    final regularity = disciple.regularity;

    return SectionCard(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  MemberAvatar(
                    initials: member.initials,
                    photo: member.avatar,
                    size: 44,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          [
                            '@${member.username}',
                            if (member.place.isNotEmpty) member.place,
                          ].join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
              const SizedBox(height: AppSpacing.md),
              if (regularity == null)
                Row(
                  children: [
                    Icon(
                      AppIcons.private,
                      size: 16,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        t.notShared,
                        style: TextStyle(
                          fontSize: 14,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                )
              else
                _Regularity(regularity: regularity, today: today),
            ],
          ),
        ),
      ],
    );
  }
}

/// The last 30 days as a strip (today at the end), then the streak, the last
/// day filled in and the goals.
class _Regularity extends StatelessWidget {
  const _Regularity({required this.regularity, required this.today});

  final DiscipleRegularity regularity;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final reports = AppModule.reports.tone(context);
    final filled = {for (final day in regularity.days) day.dateOnly};
    final lastDay = regularity.lastDay;
    final since = lastDay == null
        ? null
        : today.difference(lastDay.dateOnly).inDays;

    Widget pill(IconData icon, String text, Color background, Color ink) =>
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: ink),
              const SizedBox(width: 5),
              // a long text (large font) wraps rather than overflows
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ink,
                  ),
                ),
              ),
            ],
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          label: t.filled(n: regularity.filledLast30),
          excludeSemantics: true,
          child: SizedBox(
            height: 18,
            child: Row(
              children: [
                for (var i = 29; i >= 0; i--) ...[
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color:
                            filled.contains(
                              DateTime(today.year, today.month, today.day - i),
                            )
                            ? reports.color
                            : scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  if (i > 0) const SizedBox(width: 2),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          t.filled(n: regularity.filledLast30),
          style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            pill(
              AppIcons.streak,
              regularity.streak > 0
                  ? t.streak(n: regularity.streak)
                  : t.noStreak,
              tones.personalSoft,
              tones.personal,
            ),
            pill(
              AppIcons.calendarCheck,
              switch (since) {
                null => t.noReport,
                <= 0 => t.lastToday,
                1 => t.lastYesterday,
                final days => t.lastDaysAgo(n: days),
              },
              reports.soft,
              reports.onSoft,
            ),
            if (regularity.goalPercent case final percent?)
              pill(
                AppIcons.goal,
                t.goals(percent: percent),
                reports.soft,
                reports.onSoft,
              ),
          ],
        ),
      ],
    );
  }
}
