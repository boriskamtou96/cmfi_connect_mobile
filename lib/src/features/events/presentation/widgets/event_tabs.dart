import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/services/link_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/text_direction.dart';
import '../../../../core/utils/zoned_time.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../routing/app_router.dart';
import '../../domain/event.dart';
import 'event_cards.dart';
import 'event_format.dart';
import 'event_picture.dart';
import 'program_view.dart';

/// The news of the event, pinned ones first. [onDelete]: the admins' menu.
class NewsView extends StatelessWidget {
  const NewsView({required this.event, this.onDelete, super.key});

  final CommunityEvent event;
  final void Function(EventPost post)? onDelete;

  @override
  Widget build(BuildContext context) {
    if (event.posts.isEmpty) {
      return TabEmpty(context.t.events.noNews);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final post in event.posts) ...[
          _PostCard(
            post: post,
            onDelete: onDelete == null ? null : () => onDelete!(post),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post, this.onDelete});

  final EventPost post;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);
    final image = post.image;
    final created = post.createdAt.toLocal();

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: post.pinned ? tone.soft : scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: post.pinned ? null : Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.xs,
              0,
            ),
            child: Row(
              children: [
                if (post.pinned) ...[
                  Icon(AppIcons.pinned, size: 16, color: tone.onSoft),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    t.pinned,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: tone.onSoft,
                    ),
                  ),
                  Text(' · ', style: TextStyle(color: scheme.onSurfaceVariant)),
                ],
                Expanded(
                  child: Text(
                    context.formatDate(created, 'd MMMM').capitalized,
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    tooltip: t.admin.postDelete,
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(AppIcons.delete, size: 20),
                    onPressed: onDelete,
                  )
                else
                  const SizedBox(height: 40),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.xs,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Text(
              post.body,
              textDirection: contentDirection(post.body),
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
          if (image != null)
            GestureDetector(
              onTap: () => showImageViewer(
                context,
                images: [image],
                heroTags: ['post-${post.id}'],
              ),
              child: Hero(
                tag: 'post-${post.id}',
                child: AspectRatio(
                  aspectRatio: image.aspectRatio.clamp(0.8, 2),
                  child: EventPicture(image),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// About, fees, deadline, address, contact and the other editions.
class InfoView extends ConsumerWidget {
  const InfoView({required this.event, super.key});

  final CommunityEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final links = ref.read(linkLauncherProvider);
    final deadline = event.registrationDeadline;
    final address = [
      event.venue,
      event.address,
      event.place,
    ].where((part) => part.isNotEmpty).join('\n');

    Future<void> openLink(Future<bool> Function() open) async {
      final toast = ref.read(toasterProvider).of(context);
      if (!await open()) {
        toast.error(t.linkFailed);
      }
    }

    final blocks = <Widget>[
      if (event.description.isNotEmpty)
        _Block(
          title: t.about,
          child: Text(
            event.description,
            textDirection: contentDirection(event.description),
            style: const TextStyle(fontSize: 15, height: 1.55),
          ),
        ),
      if (event.feeNote.isNotEmpty)
        _Block(
          title: t.fees,
          icon: AppIcons.fees,
          child: Text(event.feeNote, style: const TextStyle(fontSize: 15)),
        ),
      if (deadline != null && event.status == EventStatus.published)
        _Block(
          title: context.t.events.admin.registration,
          icon: AppIcons.calendarCheck,
          child: Text(
            t.deadline(
              date: context.formatDate(
                deadline.inZone(event.timeZone),
                'EEEE d MMMM',
              ),
            ),
            style: const TextStyle(fontSize: 15),
          ),
        ),
      if (address.isNotEmpty)
        _Block(
          title: context.t.events.admin.where,
          icon: AppIcons.place,
          trailing: TextButton.icon(
            onPressed: () => openLink(
              () => links.directions(
                mapsUrl: event.mapsUrl,
                place: address.replaceAll('\n', ', '),
              ),
            ),
            icon: const Icon(AppIcons.directions, size: 18),
            label: Text(t.directions),
          ),
          child: Text(
            address,
            style: const TextStyle(fontSize: 15, height: 1.45),
          ),
        ),
      if (event.contactName.isNotEmpty || event.contactPhone.isNotEmpty)
        _Block(
          title: t.contact,
          icon: AppIcons.phone,
          trailing: event.contactPhone.isEmpty
              ? null
              : IconButton.filledTonal(
                  tooltip: t.call(name: event.contactName),
                  icon: const Icon(AppIcons.phone),
                  onPressed: () =>
                      openLink(() => links.call(event.contactPhone)),
                ),
          child: Text(
            [
              event.contactName,
              event.contactPhone,
            ].where((part) => part.isNotEmpty).join('\n'),
            style: const TextStyle(fontSize: 15, height: 1.45),
          ),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, block) in blocks.indexed) ...[
          if (i > 0) Divider(height: 28, color: scheme.outlineVariant),
          block,
        ],
        if (event.editions.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          Text(t.otherEditions, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: EditionTile.height(context),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: event.editions.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) {
                final edition = event.editions[index];
                return EditionTile(
                  title: edition.title,
                  poster: edition.poster,
                  dates: context.eventDates(
                    edition.startsAt,
                    edition.endsAt,
                    edition.timeZone,
                  ),
                  onTap: () =>
                      context.router.push(EventRoute(eventId: edition.id)),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({
    required this.title,
    required this.child,
    this.icon,
    this.trailing,
  });

  final String title;
  final Widget child;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, size: 20, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              child,
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// The gallery: square thumbnails, opened full screen. [onDelete]: admins.
class PhotosView extends StatelessWidget {
  const PhotosView({required this.event, this.onDelete, super.key});

  final CommunityEvent event;
  final Future<bool> Function(EventPhoto photo)? onDelete;

  @override
  Widget build(BuildContext context) {
    final photos = event.photos;
    final tags = [for (final photo in photos) 'photo-${photo.id}'];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => showImageViewer(
          context,
          images: [for (final photo in photos) photo.image],
          initial: index,
          heroTags: tags,
          captions: [for (final photo in photos) photo.caption],
          onDelete: onDelete == null
              ? null
              : (index) => onDelete!(photos[index]),
        ),
        child: Hero(
          tag: tags[index],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: EventPicture(
              photos[index].image,
              semanticLabel: photos[index].caption.isEmpty
                  ? null
                  : photos[index].caption,
            ),
          ),
        ),
      ),
    );
  }
}
