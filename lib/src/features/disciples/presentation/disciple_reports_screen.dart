import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../../reports/application/report_item_texts.dart';
import '../../reports/domain/measure_format.dart';
import '../application/disciples.dart';
import '../domain/disciple.dart';

/// The reports a disciple sends the user, the newest day first: the items
/// filled in with their values, the share of the goals and of the items. Never
/// their note. 30 days at a time, up to 90.
@RoutePage()
class DiscipleReportsScreen extends HookConsumerWidget {
  const DiscipleReportsScreen({
    @PathParam('authorityId') required this.authorityId,
    this.name = '',
    super.key,
  });

  final int authorityId;

  /// Shown as the title until their reports arrive.
  final String name;

  /// 3 pages of 30 days: the server gives 92 days at most.
  static const _maxPages = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;
    final pages = useState(1);
    final reports = ref.watch(
      discipleReportsProvider(authorityId, pages: pages.value),
    );
    // the days already shown stay while older ones load
    final shown = useRef<DiscipleReports?>(null);
    if (reports.value case final value?) {
      shown.value = value;
    }
    final data = shown.value;

    return SubPage(
      title: data?.member.fullName ?? name,
      child: switch (reports) {
        AsyncError(error: ApiException(code: 'REPORTS_NOT_SHARED')) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text(
              t.notShared,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: scheme.onSurfaceVariant),
            ),
          ),
        ),
        AsyncError(:final error) when data == null => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(
            discipleReportsProvider(authorityId, pages: pages.value),
          ),
        ),
        _ when data == null => const LoadingCards(count: 4, height: 150),
        _ => ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            _Header(reports: data),
            const SizedBox(height: AppSpacing.lg),
            if (data.days.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
                child: Text(
                  t.noReports,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            for (final day in data.days) ...[
              _DayCard(day: day),
              const SizedBox(height: AppSpacing.md),
            ],
            // the older days loading: their cards, shimmering
            if (reports.isLoading)
              const Shimmer(
                child: SkeletonBox(height: 150, radius: AppRadius.xl),
              )
            else if (pages.value < _maxPages)
              Center(
                child: TextButton(
                  onPressed: () => pages.value++,
                  child: Text(t.older),
                ),
              ),
          ],
        ),
      },
    );
  }
}

/// Who they are, and what the user is to them.
class _Header extends StatelessWidget {
  const _Header({required this.reports});

  final DiscipleReports reports;

  @override
  Widget build(BuildContext context) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final member = reports.member;

    return Row(
      children: [
        MemberAvatar(initials: member.initials, photo: member.avatar, size: 52),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${member.username}',
                style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 6),
              StatusPill(
                reports.isDiscipleMaker ? t.roleMaker : t.roleAuthority,
                background: reports.isDiscipleMaker ? tones.personalSoft : null,
                foreground: reports.isDiscipleMaker ? tones.personal : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A day: its date, how far its goals and its items go, then each item
/// filled in with its value.
class _DayCard extends StatelessWidget {
  const _DayCard({required this.day});

  final DiscipleDay day;

  @override
  Widget build(BuildContext context) {
    final texts = context.t;
    final t = texts.disciples;
    final tones = AppTones.of(context);
    final reports = AppModule.reports.tone(context);

    return SectionCard(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.formatDate(day.date, 'EEEE d MMMM').capitalized,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  if (day.goalPercent case final percent?)
                    StatusPill(
                      t.dayGoals(percent: percent),
                      background: tones.personalSoft,
                      foreground: tones.personal,
                    ),
                  StatusPill(
                    t.dayItems(
                      filled: day.filled,
                      total: day.total,
                      percent: day.itemsPercent,
                    ),
                    background: reports.soft,
                    foreground: reports.onSoft,
                  ),
                ],
              ),
              if (day.entries.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                for (final entry in day.entries)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            texts.itemLabel(entry.code, entry.label),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _Value(entry: entry),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Value extends StatelessWidget {
  const _Value({required this.entry});

  final DiscipleEntry entry;

  @override
  Widget build(BuildContext context) {
    final texts = context.t;
    final scheme = Theme.of(context).colorScheme;
    final value = MeasureFormat.value(
      quantity: entry.quantity,
      minutes: entry.durationMinutes,
      unit: texts.itemUnit(entry.code, entry.quantityUnit),
    );
    // an item without measure: done
    if (value.isEmpty) {
      return Icon(AppIcons.check, size: 18, color: scheme.primary);
    }
    return Text(
      value,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    );
  }
}
