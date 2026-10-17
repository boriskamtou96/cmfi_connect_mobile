import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/segmented_tabs.dart';
import '../application/memory_verses.dart';
import '../domain/memory_verse.dart';

/// The reviews of the day, one verse at a time: its reference and a help
/// (the text with gaps, the first letters, or nothing) to recite it, then
/// the verse, and how well it was known (Encore, Difficile, Bien, Facile)
/// sets when it comes back. « Encore » puts it at the end of the session.
/// [verseId]: only that verse, reviewed now even if not due.
@RoutePage()
class MemoryReviewScreen extends HookConsumerWidget {
  const MemoryReviewScreen({@QueryParam('verse') this.verseId, super.key});

  final String? verseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.memorize;
    final notifier = ref.read(memoryVersesProvider.notifier);
    final verses = ref.watch(memoryVersesProvider);
    // the session's verses, set once: reviewing one moves its date
    final queue = useState<List<String>>(
      verseId != null
          ? [verseId!]
          : [for (final verse in notifier.dueOn(today())) verse.id],
    );
    final reviewed = useState(0);
    final total = useMemoized(() => queue.value.length);
    final revealed = useState(false);
    final current = queue.value.isEmpty
        ? null
        : verses.where((verse) => verse.id == queue.value.first).firstOrNull;
    final hint = useState<MemoryHint?>(null);
    useEffect(() {
      hint.value = current?.hint;
      revealed.value = false;
      return null;
    }, [current?.id, reviewed.value]);

    Future<void> grade(MemoryGrade grade) async {
      final verse = current;
      if (verse == null) {
        return;
      }
      HapticFeedback.selectionClick();
      await notifier.review(verse.id, grade);
      final rest = queue.value.skip(1).toList();
      queue.value = grade == MemoryGrade.again ? [...rest, verse.id] : rest;
      if (grade != MemoryGrade.again) {
        reviewed.value++;
      } else {
        // the same verse again: the useEffect above won't run
        revealed.value = false;
        hint.value = MemoryHint.gaps;
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryDeep,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: AppBackButton(),
                  ),
                  Expanded(
                    child: Text(
                      t.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: AppSpacing.lg,
                    ),
                    child: Text(
                      t.progress(
                        done: reviewed.value.clamp(0, total),
                        total: total,
                      ),
                      style: const TextStyle(
                        color: AppColors.goldLight,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: total == 0 ? 1 : reviewed.value / total,
                    minHeight: 4,
                    color: AppColors.goldLight,
                    backgroundColor: Colors.white12,
                  ),
                ),
              ),
              Expanded(
                child: current == null
                    ? _Done(count: reviewed.value)
                    : _Card(
                        verse: current,
                        hint: hint.value ?? current.hint,
                        revealed: revealed.value,
                        onHint: (value) => hint.value = value,
                      ),
              ),
              if (current != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  child: revealed.value
                      ? _Grades(verse: current, onGrade: grade)
                      : FilledButton(
                          onPressed: () => revealed.value = true,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(54),
                          ),
                          child: Text(t.show),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.verse,
    required this.hint,
    required this.revealed,
    required this.onHint,
  });

  final MemoryVerse verse;
  final MemoryHint hint;
  final bool revealed;
  final ValueChanged<MemoryHint> onHint;

  @override
  Widget build(BuildContext context) {
    final t = context.t.memorize;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    final shown = revealed
        ? verse.text
        : switch (hint) {
            MemoryHint.full => verse.text,
            MemoryHint.gaps => withGaps(verse.text, verse.id.hashCode),
            MemoryHint.initials => initialsOf(verse.text),
            MemoryHint.none => '',
          };

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                verse.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: tone.onSoft,
                ),
              ),
              if (verse.version.isNotEmpty)
                Text(
                  verse.version,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              const SizedBox(height: AppSpacing.lg),
              if (!revealed) ...[
                SegmentedTabs(
                  labels: [
                    for (final value in MemoryHint.values)
                      t.hints[value.name] ?? value.name,
                  ],
                  selectedIndex: hint.index,
                  onChanged: (index) => onHint(MemoryHint.values[index]),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Text(
                  shown.isEmpty ? t.recite : shown,
                  key: ValueKey('$revealed$hint'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lora',
                    fontSize: shown.isEmpty ? 16 : 19,
                    height: 1.6,
                    fontStyle: shown.isEmpty ? FontStyle.italic : null,
                    color: shown.isEmpty ? scheme.onSurfaceVariant : null,
                    letterSpacing: hint == MemoryHint.initials && !revealed
                        ? 2
                        : null,
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

/// Encore, Difficile, Bien, Facile, each with when the verse comes back.
class _Grades extends StatelessWidget {
  const _Grades({required this.verse, required this.onGrade});

  final MemoryVerse verse;
  final ValueChanged<MemoryGrade> onGrade;

  @override
  Widget build(BuildContext context) {
    final t = context.t.memorize;
    return Row(
      children: [
        for (final (index, grade) in MemoryGrade.values.indexed) ...[
          if (index > 0) const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: FilledButton(
              onPressed: () => onGrade(grade),
              style: FilledButton.styleFrom(
                backgroundColor: switch (grade) {
                  MemoryGrade.again => const Color(0xFFB4413A),
                  MemoryGrade.hard => const Color(0xFF8A6D3B),
                  MemoryGrade.good => AppColors.primary,
                  MemoryGrade.easy => AppColors.gold,
                },
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                minimumSize: const Size.fromHeight(60),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.grades[grade.name] ?? grade.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(switch (verse.intervalAfter(grade)) {
                    0 => t.now,
                    final days => t.later(n: days),
                  }, style: const TextStyle(fontSize: 11.5)),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Done extends StatelessWidget {
  const _Done({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final t = context.t.memorize;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              AppIcons.memorizeTile,
              size: 64,
              color: AppColors.goldLight,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              t.doneTitle,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.doneText(n: count),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.onPrimaryMuted,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              onPressed: () => context.router.maybePop(),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
              ),
              child: Text(t.back),
            ),
          ],
        ),
      ),
    );
  }
}
