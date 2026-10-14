import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/text_direction.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/media_picture.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../application/inbox.dart';
import '../domain/announcement.dart';

/// The notifications sent by the admins, the latest first; the unread ones
/// stand out.
@RoutePage()
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.notifications;
    final inbox = ref.watch(inboxProvider);
    final notifier = ref.read(inboxProvider.notifier);

    return SubPage(
      title: t.title,
      child: switch (inbox) {
        AsyncValue(value: final state?) => RefreshIndicator(
          onRefresh: notifier.refresh,
          child: state.items.isEmpty
              ? ListView(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  children: const [FadeSlideIn(child: _NothingYet())],
                )
              : NotificationListener<ScrollNotification>(
                  // the next page, a little before the end
                  onNotification: (scroll) {
                    if (scroll.metrics.extentAfter < 400) {
                      notifier.loadMore();
                    }
                    return false;
                  },
                  child: ListView(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.lg,
                      AppSpacing.sm,
                      AppSpacing.lg,
                      AppSpacing.xxl,
                    ),
                    children: [
                      FadeSlideIn(
                        child: SectionCard(
                          children: [
                            for (final item in state.items)
                              _AnnouncementRow(
                                announcement: item,
                                onTap: () => context.router.push(
                                  NotificationRoute(notificationId: item.id),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (state.loadingMore)
                        const Padding(
                          padding: EdgeInsets.all(AppSpacing.lg),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(inboxProvider),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _NothingYet extends StatelessWidget {
  const _NothingYet();

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        const SizedBox(height: AppSpacing.xxl),
        const DoveMascot(pose: DovePose.rest, size: 132),
        const SizedBox(height: AppSpacing.lg),
        Text(
          t.empty,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          t.emptyHint,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

/// Unread: a dot and a bold title. The first image comes as a thumbnail.
class _AnnouncementRow extends ConsumerWidget {
  const _AnnouncementRow({required this.announcement, required this.onTap});

  final Announcement announcement;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.notifications;
    final scheme = Theme.of(context).colorScheme;
    final unread = !announcement.isRead;
    final sent = announcement.createdAt.toLocal();
    final image = announcement.images.firstOrNull;

    return Semantics(
      button: true,
      label: unread ? t.unreadLabel(title: announcement.title) : null,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            14,
            AppSpacing.lg,
            14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: unread ? scheme.primary : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            announcement.title,
                            textDirection: contentDirection(announcement.title),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: unread
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          sent.isSameDay(DateTime.now())
                              ? context.formatDate(sent, 'HH:mm')
                              : context.formatDate(sent, 'd MMM'),
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      announcement.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textDirection: contentDirection(announcement.body),
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.35,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    if (announcement.documents.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(AppIcons.pdf, size: 16, color: scheme.error),
                          const SizedBox(width: 4),
                          Text(
                            t.documents(n: announcement.documents.length),
                            style: TextStyle(
                              fontSize: 12,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (image != null) ...[
                const SizedBox(width: AppSpacing.md),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: SizedBox.square(
                    dimension: 56,
                    child: MediaPicture(url: image.url, argb: image.argb),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
