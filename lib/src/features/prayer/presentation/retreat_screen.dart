import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../application/retreat_reminders.dart';
import '../application/retreats.dart';
import '../domain/prayer.dart';
import '../domain/retreat.dart';
import 'retreat_reminders_sheet.dart';
import 'widgets/prayer_look.dart';

/// One retreat before praying it: its fifteen points, with what the app adds
/// (the user's assembly, the next names of a list…), and the two ways to
/// pray it: guided minute by minute, or at one's own pace.
@RoutePage()
class RetreatScreen extends HookConsumerWidget {
  const RetreatScreen({required this.moment, super.key});

  final RetreatMoment moment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final selected = useState(moment);
    final current = selected.value;
    final language = TranslationProvider.of(context).locale.languageCode;
    final plan = ref.watch(retreatPlanProvider(current, language));
    final reminder = ref.watch(retreatRemindersProvider)[current];
    final done = ref.watch(retreatsTodayProvider).contains(current);

    void start({required bool timed}) =>
        context.router.push(RetreatSessionRoute(moment: current, timed: timed));

    return SubPage(
      title: t.prayer.retreat.title,
      actions: [
        IconButton(
          tooltip: t.prayer.reminders.title,
          onPressed: () => showRetreatRemindersSheet(context),
          icon: Icon(AppIcons.reminder, color: scheme.onSurfaceVariant),
        ),
      ],
      bottom: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 8),
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton.icon(
                onPressed: () => start(timed: true),
                icon: const Icon(AppIcons.play, size: 18),
                label: Text(t.prayer.retreat.start),
                style: FilledButton.styleFrom(
                  backgroundColor: tone.color,
                  minimumSize: const Size.fromHeight(54),
                ),
              ),
              TextButton(
                onPressed: () => start(timed: false),
                style: TextButton.styleFrom(foregroundColor: tone.onSoft),
                child: Text(t.prayer.retreat.selfPaced),
              ),
            ],
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
        children: [
          Row(
            children: [
              for (final (i, other) in RetreatMoment.values.indexed) ...[
                if (i > 0) const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _MomentChip(
                    moment: other,
                    selected: other == current,
                    onTap: () => selected.value = other,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  [
                    t.prayer.retreat.hours[current.name]!,
                    if (reminder != null)
                      t.prayer.retreat.reminderAt(
                        time: reminder.format(context),
                      ),
                  ].join(' · '),
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              if (done)
                StatusPill(
                  t.prayer.retreat.done,
                  background: tone.soft,
                  foreground: tone.onSoft,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            t.prayer.retreat.intro,
            style: const TextStyle(fontSize: 15, height: 1.35),
          ),
          const SizedBox(height: 14),
          switch (plan) {
            AsyncData(:final value) => SectionCard(
              children: [
                for (final point in value)
                  _PointRow(point: point, moment: current),
              ],
            ),
            AsyncError(:final error) => Text(userMessageFor(error, t)),
            // the numbered points
            _ => const Shimmer(child: SkeletonList(count: 5, leading: 26)),
          },
        ],
      ),
    );
  }
}

class _MomentChip extends StatelessWidget {
  const _MomentChip({
    required this.moment,
    required this.selected,
    required this.onTap,
  });

  final RetreatMoment moment;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ink = selected ? moment.inkOf(context) : scheme.onSurfaceVariant;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected
            ? moment.colors.first.withValues(alpha: 0.16)
            : scheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: selected
              ? BorderSide(color: moment.colors.first, width: 1.5)
              : BorderSide.none,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: SizedBox(
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(moment.icon, size: 16, color: ink),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    moment.label(context.t),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PointRow extends StatelessWidget {
  const _PointRow({required this.point, required this.moment});

  final PlannedPoint point;
  final RetreatMoment moment;

  @override
  Widget build(BuildContext context) {
    final extra = pointHintText(context, point);
    final tone = AppModule.prayer.tone(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: moment.colors.first.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Text(
              '${point.number}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: moment.inkOf(context),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  point.text,
                  textDirection: null,
                  style: const TextStyle(fontSize: 15, height: 1.35),
                ),
                if (extra != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    extra,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: tone.onSoft,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The line the app adds under a point, or null.
String? pointHintText(BuildContext context, PlannedPoint point) {
  final t = context.t.prayer.retreat.hints;
  final lists = context.t;
  return switch (point.hint) {
    null => null,
    AssemblyHint() =>
      point.value == null ? t.assemblyMissing : t.assembly(name: point.value!),
    AuthoritiesHint() =>
      point.value == null
          ? t.authoritiesMissing
          : t.authorities(names: point.value!),
    ListHint(:final list) =>
      point.people.isEmpty
          ? t.listEmpty(list: list.label(lists))
          : point.people.map((person) => person.name).join(', '),
    NationHint() => point.value == null ? null : t.nation(name: point.value!),
    MyCountryHint() =>
      point.value == null ? null : t.myCountry(name: point.value!),
    HymnHint() => t.hymn,
  };
}
