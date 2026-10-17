import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/reminder_row.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routing/app_router.dart';
import '../application/memory_verses.dart';
import '../domain/memory_verse.dart';

/// Bible › ⋮ › Mémoriser des versets (and the home screen): the verses
/// learnt by heart, how many to review today, the reviews' reminder and the
/// list (new, being learnt, known). A verse is added from the Bible: touch
/// it, then the brain of the bar.
@RoutePage()
class MemoryScreen extends ConsumerWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.memorize;
    final verses = ref.watch(memoryVersesProvider);
    final notifier = ref.read(memoryVersesProvider.notifier);
    final day = today();
    final due = notifier.dueOn(day);
    final reminder = notifier.reminder();
    int count(MemoryStage stage) =>
        verses.where((verse) => verse.stage == stage).length;
    final next = verses.isEmpty
        ? null
        : verses
              .map((verse) => verse.due)
              .reduce((a, b) => a.isBefore(b) ? a : b);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            _Header(
              stats: [
                (due.length, t.toReview),
                (
                  count(MemoryStage.fresh) + count(MemoryStage.learning),
                  t.learning,
                ),
                (count(MemoryStage.known), t.known),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: FadeSlideIn(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (verses.isEmpty)
                      _Empty(
                        onBible: () {
                          context.router.root.popUntilRouteWithName(
                            AppShellRoute.name,
                          );
                          context.navigateTo(const BibleRoute());
                        },
                      )
                    else ...[
                      if (due.isNotEmpty)
                        FilledButton.icon(
                          onPressed: () =>
                              context.router.push(MemoryReviewRoute()),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                          ),
                          icon: const Icon(AppIcons.memorize),
                          label: Text(t.reviewCount(n: due.length)),
                        )
                      else
                        _Note(
                          text: [
                            t.nothingDue,
                            if (next != null)
                              t.nextOn(
                                date: next == day.add(const Duration(days: 1))
                                    ? t.tomorrow
                                    : context.formatDate(next, 'EEEE d MMMM'),
                              ),
                          ].join(' '),
                        ),
                      const SizedBox(height: AppSpacing.md),
                      ReminderRow(
                        label: t.reminder,
                        timeLabel: t.reminderAt,
                        on: reminder.on,
                        minutes: reminder.minutes,
                        onChanged: (on) => notifier.setReminder(on: on),
                        onTime: (minutes) =>
                            notifier.setReminder(minutes: minutes),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SectionCard(
                        header: t.myVerses,
                        children: [
                          for (final verse in verses) _VerseRow(verse: verse),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        t.howToAdd,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.stats});

  final List<(int, String)> stats;

  @override
  Widget build(BuildContext context) {
    final t = context.t.memorize;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryDeep,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xs,
            AppSpacing.xs,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconTheme(
                data: IconThemeData(color: Colors.white),
                child: AppBackButton(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        t.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      t.subtitle,
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: AppColors.goldLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        for (final (index, (value, label))
                            in stats.indexed) ...[
                          if (index > 0) const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.md,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.lg,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '$value',
                                    style: TextStyle(
                                      color: index == 0
                                          ? AppColors.goldLight
                                          : Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    label,
                                    style: const TextStyle(
                                      color: AppColors.onPrimaryMuted,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
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

class _Note extends StatelessWidget {
  const _Note({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.bible.tone(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: tone.soft,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Icon(AppIcons.calendarCheck, color: tone.onSoft),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: tone.onSoft,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onBible});

  final VoidCallback onBible;

  @override
  Widget build(BuildContext context) {
    final t = context.t.memorize;
    final tone = AppModule.bible.tone(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: tone.soft, shape: BoxShape.circle),
            child: Icon(AppIcons.memorizeTile, color: tone.onSoft, size: 34),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            t.empty,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.howToAdd,
            textAlign: TextAlign.center,
            style: const TextStyle(height: 1.4),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(
            onPressed: onBible,
            icon: const Icon(AppIcons.bible),
            label: Text(t.openBible),
          ),
        ],
      ),
    );
  }
}

/// A verse: its reference and version, its first words, when it comes
/// back (or « Su »). A tap shows it all, to review it now or remove it.
class _VerseRow extends ConsumerWidget {
  const _VerseRow({required this.verse});

  final MemoryVerse verse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.memorize;
    final scheme = Theme.of(context).colorScheme;
    final day = today();
    final days = verse.due.difference(day).inDays;
    final known = verse.stage == MemoryStage.known;
    final when = days < 0
        ? t.late
        : days == 0
        ? t.today
        : t.dueIn(n: days);

    return ListTile(
      title: Text(
        verse.version.isEmpty
            ? verse.label
            : '${verse.label} · ${verse.version}',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(verse.text, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: known
              ? AppColors.gold.withValues(alpha: 0.18)
              : days <= 0
              ? scheme.primaryContainer
              : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          known ? '${t.stages['known']} · $when' : when,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
      onTap: () => _showVerse(context, ref, verse),
    );
  }
}

Future<void> _showVerse(
  BuildContext context,
  WidgetRef ref,
  MemoryVerse verse,
) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (sheet) {
    final t = sheet.t.memorize;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          0,
          AppSpacing.xl,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              verse.version.isEmpty
                  ? verse.label
                  : '${verse.label} (${verse.version})',
              style: Theme.of(sheet).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            Flexible(
              child: SingleChildScrollView(
                child: Text(
                  verse.text,
                  style: const TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 18,
                    height: 1.55,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              t.stats(
                stage: t.stages[verse.stage.name] ?? '',
                lapses: verse.lapses,
              ),
              style: TextStyle(
                color: Theme.of(sheet).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(sheet).pop();
                context.router.push(MemoryReviewRoute(verseId: verse.id));
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              icon: const Icon(AppIcons.memorize),
              label: Text(t.reviewNow),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(sheet).colorScheme.error,
              ),
              onPressed: () async {
                final toast = ref.read(toasterProvider).of(context);
                final yes = await showConfirmDialog(
                  sheet,
                  title: t.removeTitle,
                  text: t.removeText,
                  confirmLabel: t.remove,
                  destructive: true,
                );
                if (!yes) {
                  return;
                }
                await ref.read(memoryVersesProvider.notifier).remove(verse.id);
                if (sheet.mounted) {
                  Navigator.of(sheet).pop();
                }
                toast.success(t.removed);
              },
              child: Text(t.remove),
            ),
          ],
        ),
      ),
    );
  },
);
