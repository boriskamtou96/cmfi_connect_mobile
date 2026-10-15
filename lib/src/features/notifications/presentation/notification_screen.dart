import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/services/media_images.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/text_direction.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/media_picture.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/inbox.dart';
import '../domain/announcement.dart';

/// One notification of the admins, whole: text, images and PDF. Opening it
/// marks it read.
@RoutePage()
class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({
    @PathParam('notificationId') required this.notificationId,
    super.key,
  });

  final int notificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.notifications;
    final announcement = ref.watch(announcementProvider(notificationId));

    useEffect(() {
      unawaited(ref.read(inboxProvider.notifier).markRead(notificationId));
      return null;
    }, [notificationId]);

    return SubPage(
      title: t.title,
      child: switch (announcement) {
        AsyncValue(value: final item?) => _Content(announcement: item),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(announcementProvider(notificationId)),
        ),
        _ => const LoadingDetail(
          padding: EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
        ),
      },
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final sent = announcement.createdAt.toLocal();

    Future<void> open(AnnouncementFile file) async {
      final toast = ref.read(toasterProvider).of(context);
      final url = ref.read(mediaImagesProvider).resolve(file.url);
      if (!await ref.read(linkLauncherProvider).open(Uri.parse(url))) {
        toast.error(t.errors.unknown);
      }
    }

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      children: [
        FadeSlideIn(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.formatDate(sent, 'EEEE d MMMM · HH:mm').capitalized,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                announcement.title,
                textDirection: contentDirection(announcement.title),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              SelectableText(
                announcement.body,
                textDirection: contentDirection(announcement.body),
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
        for (final (index, image) in announcement.images.indexed) ...[
          const SizedBox(height: AppSpacing.lg),
          FadeSlideIn(
            index: index + 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: AspectRatio(
                aspectRatio: image.aspectRatio,
                child: MediaPicture(
                  url: image.url,
                  argb: image.argb,
                  fit: BoxFit.contain,
                  semanticLabel: t.notifications.image(n: index + 1),
                ),
              ),
            ),
          ),
        ],
        for (final document in announcement.documents) ...[
          const SizedBox(height: AppSpacing.md),
          Material(
            color: scheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              side: BorderSide(color: scheme.outlineVariant),
            ),
            child: ListTile(
              onTap: () => open(document),
              leading: Icon(AppIcons.pdf, size: 28, color: scheme.error),
              title: Text(
                document.name.isEmpty
                    ? t.notifications.document
                    : document.name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: document.sizeBytes > 0
                  ? Text(
                      t.notifications.documentSize(
                        kb: (document.sizeBytes / 1024).ceil(),
                      ),
                    )
                  : null,
              trailing: Icon(
                AppIcons.chevronRight,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
