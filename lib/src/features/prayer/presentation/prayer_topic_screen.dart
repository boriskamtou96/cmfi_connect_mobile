import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/services/media_images.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/text_direction.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/prayer_topics.dart';
import '../domain/prayer.dart';
import 'widgets/prayer_look.dart';

/// A topic of the community: its points, each checked once prayed for today,
/// how many pray for it, and the PDF it was made from.
@RoutePage()
class PrayerTopicScreen extends ConsumerWidget {
  const PrayerTopicScreen({
    @PathParam('topicId') required this.topicId,
    super.key,
  });

  final int topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final current = ref.watch(prayerTopicsProvider);
    final past = ref.watch(pastPrayerTopicsProvider);
    final topic =
        current.value?.where((topic) => topic.id == topicId).firstOrNull ??
        past.value?.where((topic) => topic.id == topicId).firstOrNull;
    final ended = current.value?.every((other) => other.id != topicId) ?? false;

    if (topic == null) {
      final error = current.error ?? past.error;
      return SubPage(
        title: t.prayer.topics.screenTitle,
        child: Center(
          child: current.isLoading || past.isLoading
              ? const CircularProgressIndicator()
              : Text(
                  error == null ? t.errors.notFound : userMessageFor(error, t),
                ),
        ),
      );
    }
    return _TopicView(topic: topic, ended: ended);
  }
}

class _TopicView extends ConsumerWidget {
  const _TopicView({required this.topic, required this.ended});

  final PrayerTopic topic;

  /// A past topic: read only.
  final bool ended;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final category = topic.category.module.tone(context);
    final topics = ref.read(prayerTopicsProvider.notifier);

    Future<void> setPrayed(List<int> positions) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      unawaited(HapticFeedback.selectionClick());
      try {
        await topics.setPrayed(topic, positions);
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      }
    }

    void toggle(int position) => setPrayed(
      topic.prayedToday.contains(position)
          ? [...topic.prayedToday.where((other) => other != position)]
          : [...topic.prayedToday, position],
    );

    Future<void> openDocument(PrayerDocument document) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final url = ref.read(mediaImagesProvider).resolve(document.url);
      if (!await ref.read(linkLauncherProvider).open(Uri.parse(url))) {
        toast.error(messages.errors.unknown);
      }
    }

    void share() {
      final box = context.findRenderObject() as RenderBox?;
      ref
          .read(shareServiceProvider)
          .shareText(
            t.prayer.topics.shareText(
              title: topic.title,
              points: [
                for (final (i, point) in topic.points.indexed)
                  '${i + 1}. $point',
              ].join('\n'),
            ),
            origin: box == null
                ? null
                : box.localToGlobal(Offset.zero) & box.size,
          );
    }

    final period = topic.endsOn == null
        ? t.prayer.topics.since(
            date: context.formatDate(topic.startsOn, 'd MMMM'),
          )
        : t.prayer.topics.period(
            from: context.formatDate(topic.startsOn, 'd MMMM'),
            to: context.formatDate(topic.endsOn!, 'd MMMM'),
          );

    return SubPage(
      title: t.prayer.topics.screenTitle,
      actions: [
        IconButton(
          tooltip: MaterialLocalizations.of(context).shareButtonLabel,
          onPressed: share,
          icon: Icon(AppIcons.share, color: scheme.onSurfaceVariant),
        ),
      ],
      bottom: ended || topic.points.isEmpty
          ? null
          : Container(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 16),
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border(top: BorderSide(color: scheme.outlineVariant)),
              ),
              child: SafeArea(
                top: false,
                child: FilledButton.icon(
                  onPressed: topic.allPrayed
                      ? null
                      : () => setPrayed([
                          for (var i = 1; i <= topic.points.length; i++) i,
                        ]),
                  icon: Icon(
                    topic.allPrayed ? AppIcons.checkCircle : AppIcons.prayer,
                    size: 20,
                  ),
                  label: Text(
                    topic.allPrayed
                        ? t.prayer.topics.allPrayed
                        : t.prayer.topics.prayAll,
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: tone.color,
                    minimumSize: const Size.fromHeight(54),
                  ),
                ),
              ),
            ),
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              StatusPill(
                topic.category.label(t),
                background: category.soft,
                foreground: category.onSoft,
              ),
              StatusPill(period),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            topic.title,
            textDirection: contentDirection(topic.title),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.4,
            ),
          ),
          if (topic.verse.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(14, 4, 0, 4),
              decoration: BoxDecoration(
                border: BorderDirectional(
                  start: BorderSide(color: tone.color, width: 3),
                ),
              ),
              child: Text(
                topic.verse,
                textDirection: contentDirection(topic.verse),
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  height: 1.45,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: tone.soft,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              children: [
                PhosphorIcon(AppIcons.prayerTile, color: tone.onSoft, size: 26),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    t.prayer.topics.peopleBanner(n: topic.people),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: tone.onSoft,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SectionLabel(
            t.prayer.topics.prayedToday(
              count: t.prayer.topics.points(n: topic.points.length),
              prayed: topic.prayedToday.length,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SectionCard(
            children: [
              for (final (i, point) in topic.points.indexed)
                _PointTile(
                  number: i + 1,
                  text: point,
                  prayed: topic.prayedToday.contains(i + 1),
                  onTap: ended ? null : () => toggle(i + 1),
                ),
            ],
          ),
          if (topic.document case final document?) ...[
            const SizedBox(height: 12),
            Material(
              color: scheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                side: BorderSide(color: scheme.outlineVariant),
              ),
              child: ListTile(
                onTap: () => openDocument(document),
                leading: Icon(AppIcons.pdf, size: 28, color: scheme.error),
                title: Text(
                  t.prayer.topics.document,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  [
                    if (document.name.isNotEmpty) document.name,
                    if (document.sizeBytes > 0)
                      t.prayer.topics.documentSize(
                        kb: (document.sizeBytes / 1024).ceil(),
                      ),
                  ].join(' · '),
                ),
                trailing: Icon(
                  AppIcons.chevronRight,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PointTile extends StatelessWidget {
  const _PointTile({
    required this.number,
    required this.text,
    required this.prayed,
    required this.onTap,
  });

  final int number;
  final String text;
  final bool prayed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    return Semantics(
      checked: prayed,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 10, 12),
          child: Row(
            children: [
              SizedBox(
                width: 22,
                child: Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: tone.onSoft,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  textDirection: contentDirection(text),
                  style: const TextStyle(fontSize: 15, height: 1.35),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                prayed ? AppIcons.checkCircleFilled : AppIcons.radioOff,
                size: 26,
                color: prayed ? tone.color : scheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
