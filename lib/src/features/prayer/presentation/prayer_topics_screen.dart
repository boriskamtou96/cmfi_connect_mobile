import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/prayer_topics.dart';
import '../domain/prayer.dart';
import 'prayer_screen.dart';

/// All the topics of the community: those of the moment, then the past ones.
@RoutePage()
class PrayerTopicsScreen extends ConsumerWidget {
  const PrayerTopicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final current = ref.watch(prayerTopicsProvider);
    final past = ref.watch(pastPrayerTopicsProvider);

    Widget section(
      String title,
      AsyncValue<List<PrayerTopic>> topics,
      String empty,
    ) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionLabel(title),
        const SizedBox(height: AppSpacing.sm),
        switch (topics) {
          AsyncData(:final value) when value.isEmpty => Text(
            empty,
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          AsyncData(:final value) => Column(
            children: [
              for (final topic in value) ...[
                PrayerTopicCard(topic: topic),
                const SizedBox(height: 10),
              ],
            ],
          ),
          AsyncError(:final error) => Text(
            userMessageFor(error, t),
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          // the cards of the topics
          _ => const Shimmer(child: SkeletonCards(count: 2, height: 96)),
        },
      ],
    );

    return SubPage(
      title: t.prayer.topics.title,
      child: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(prayerTopicsProvider)
            ..invalidate(pastPrayerTopicsProvider);
        },
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 32),
          children: [
            section(t.prayer.topics.current, current, t.prayer.topics.empty),
            const SizedBox(height: AppSpacing.xl),
            section(
              t.prayer.topics.archive,
              past,
              t.prayer.topics.archiveEmpty,
            ),
          ],
        ),
      ),
    );
  }
}
