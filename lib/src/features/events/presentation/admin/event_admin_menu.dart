import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/image_picking.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/motion.dart';
import '../../../../routing/app_router.dart';
import '../../application/event_admin.dart';
import '../../domain/event.dart';
import '../widgets/event_picture.dart';

enum _Action { edit, program, registrants, post, photos, nextEdition, delete }

/// The admins' "⋮" on the event page: change it, its program, see who
/// comes, post news, add photos, prepare next year, delete.
class EventAdminMenu extends ConsumerWidget {
  const EventAdminMenu({
    required this.event,
    this.overPoster = false,
    super.key,
  });

  final CommunityEvent event;

  /// Drawn over the poster: a round dark button.
  final bool overPoster;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events.admin;
    final scheme = Theme.of(context).colorScheme;

    PopupMenuItem<_Action> item(_Action action, IconData icon, String label) =>
        PopupMenuItem(
          value: action,
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: action == _Action.delete
                    ? scheme.error
                    : scheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.md),
              Flexible(
                child: Text(
                  label,
                  style: action == _Action.delete
                      ? TextStyle(color: scheme.error)
                      : null,
                ),
              ),
            ],
          ),
        );

    return PopupMenuButton<_Action>(
      tooltip: t.menu,
      icon: const Icon(AppIcons.moreOptions),
      style: overPoster
          ? IconButton.styleFrom(
              backgroundColor: Colors.black.withValues(alpha: 0.32),
              foregroundColor: Colors.white,
            )
          : null,
      onSelected: (action) => switch (action) {
        _Action.edit => context.router.push(EventFormRoute(eventId: event.id)),
        _Action.program => context.router.push(
          EventProgramRoute(eventId: event.id),
        ),
        _Action.registrants => context.router.push(
          EventRegistrantsRoute(eventId: event.id),
        ),
        _Action.post => showPostSheet(context, event),
        _Action.photos => _addPhotos(context, ref, event),
        _Action.nextEdition => _prepareNextEdition(context, ref, event),
        _Action.delete => _delete(context, ref, event),
      },
      itemBuilder: (context) => [
        item(_Action.edit, AppIcons.edit, t.edit),
        item(_Action.program, AppIcons.dateRange, t.program),
        item(_Action.registrants, AppIcons.people, t.registrants),
        item(_Action.post, AppIcons.announcements, t.post),
        item(_Action.photos, AppIcons.photos, t.photos),
        item(_Action.nextEdition, AppIcons.copy, t.nextEdition),
        item(_Action.delete, AppIcons.delete, t.delete),
      ],
    );
  }
}

/// Asks before doing something that can't be undone.
Future<bool> _confirm(
  BuildContext context, {
  required String title,
  required String text,
  required String action,
  bool destructive = true,
}) async {
  final scheme = Theme.of(context).colorScheme;
  final confirmed = await showAppDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.t.common.cancel),
        ),
        FilledButton(
          style: destructive
              ? FilledButton.styleFrom(
                  backgroundColor: scheme.error,
                  foregroundColor: scheme.onError,
                )
              : null,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(action),
        ),
      ],
    ),
  );
  return confirmed == true && context.mounted;
}

Future<void> _addPhotos(
  BuildContext context,
  WidgetRef ref,
  CommunityEvent event,
) async {
  final t = context.t;
  final toast = ref.read(toasterProvider).of(context);
  final admin = ref.read(eventAdminProvider);
  final picked = await ref.read(imagePickingProvider).pickMany();
  if (picked.isEmpty) {
    return;
  }
  toast.info(t.events.admin.photosSending(done: 0, total: picked.length));
  try {
    final ids = <int>[];
    for (final image in picked) {
      ids.add((await admin.upload(image)).id);
    }
    await admin.addPhotos(event.id, ids);
    toast.success(t.events.admin.photosAdded(n: ids.length));
  } on Object catch (error) {
    toast.error(userMessageFor(error, t));
  }
}

Future<void> _prepareNextEdition(
  BuildContext context,
  WidgetRef ref,
  CommunityEvent event,
) async {
  final t = context.t;
  if (!await _confirm(
    context,
    title: t.events.admin.nextEditionTitle,
    text: t.events.admin.nextEditionText,
    action: t.events.admin.nextEditionConfirm,
    destructive: false,
  )) {
    return;
  }
  if (!context.mounted) {
    return;
  }
  final toast = ref.read(toasterProvider).of(context);
  final router = context.router;
  try {
    final next = await ref
        .read(eventAdminProvider)
        .prepareNextEdition(event.id);
    toast.success(t.events.admin.nextEditionDone);
    await router.push(EventFormRoute(eventId: next.id));
  } on Object catch (error) {
    toast.error(userMessageFor(error, t));
  }
}

Future<void> _delete(
  BuildContext context,
  WidgetRef ref,
  CommunityEvent event,
) async {
  final t = context.t;
  if (!await _confirm(
    context,
    title: t.events.admin.deleteTitle,
    text: t.events.admin.deleteText,
    action: t.events.admin.deleteConfirm,
  )) {
    return;
  }
  if (!context.mounted) {
    return;
  }
  final toast = ref.read(toasterProvider).of(context);
  final router = context.router;
  try {
    await ref.read(eventAdminProvider).delete(event.id);
    toast.success(t.events.admin.deleted);
    await router.maybePop();
  } on Object catch (error) {
    toast.error(userMessageFor(error, t));
  }
}

/// Removes a news item, after asking.
Future<void> deletePost(
  BuildContext context,
  WidgetRef ref,
  CommunityEvent event,
  EventPost post,
) async {
  final t = context.t;
  if (!await _confirm(
    context,
    title: t.events.admin.postDelete,
    text: post.body,
    action: t.events.admin.confirmDelete,
  )) {
    return;
  }
  if (!context.mounted) {
    return;
  }
  final toast = ref.read(toasterProvider).of(context);
  try {
    await ref.read(eventAdminProvider).deletePost(event, post.id);
    toast.success(t.events.admin.postDeleted);
  } on Object catch (error) {
    toast.error(userMessageFor(error, t));
  }
}

/// Removes a photo of the gallery, after asking. true when it's gone.
Future<bool> deletePhoto(
  BuildContext context,
  WidgetRef ref,
  CommunityEvent event,
  EventPhoto photo,
) async {
  final t = context.t;
  final toast = ref.read(toasterProvider).of(context);
  final admin = ref.read(eventAdminProvider);
  if (!await _confirm(
    context,
    title: t.events.admin.photoDelete,
    text: t.events.admin.deleteText,
    action: t.events.admin.confirmDelete,
  )) {
    return false;
  }
  try {
    await admin.deletePhoto(event, photo.id);
    toast.success(t.events.admin.photoDeleted);
    return true;
  } on Object catch (error) {
    toast.error(userMessageFor(error, t));
    return false;
  }
}

/// Writes a news item for the event, with an image if wanted.
Future<void> showPostSheet(BuildContext context, CommunityEvent event) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(child: _PostSheet(event: event)),
      ),
    );

class _PostSheet extends HookConsumerWidget {
  const _PostSheet({required this.event});

  final CommunityEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events.admin;
    final scheme = Theme.of(context).colorScheme;
    final body = useTextEditingController();
    useListenable(body);
    final image = useState<EventImage?>(null);
    final pinned = useState(false);
    final busy = useState(false);
    final admin = ref.read(eventAdminProvider);

    Future<void> pickImage() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final picked = await ref.read(imagePickingProvider).pickOne();
      if (picked == null) {
        return;
      }
      busy.value = true;
      try {
        image.value = await admin.upload(picked);
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    Future<void> publish() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      busy.value = true;
      try {
        await admin.addPost(
          event.id,
          body: body.text,
          imageId: image.value?.id,
          pinned: pinned.value,
        );
        navigator.pop();
        toast.success(t.postDone);
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.post, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 2),
          Text(
            event.title,
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: body,
            minLines: 3,
            maxLines: 8,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: t.postBody,
              hintText: t.postBodyHint,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (image.value != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: AspectRatio(
                    aspectRatio: image.value!.aspectRatio.clamp(0.8, 2),
                    child: EventPicture(image.value),
                  ),
                ),
                PositionedDirectional(
                  top: AppSpacing.xs,
                  end: AppSpacing.xs,
                  child: IconButton.filledTonal(
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).deleteButtonTooltip,
                    icon: const Icon(AppIcons.close),
                    onPressed: () => image.value = null,
                  ),
                ),
              ],
            )
          else
            OutlinedButton.icon(
              onPressed: busy.value ? null : pickImage,
              icon: const Icon(AppIcons.image),
              label: Text(t.postImage),
            ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: pinned.value,
            onChanged: (value) => pinned.value = value,
            secondary: const Icon(AppIcons.pin),
            title: Text(t.postPinned),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: t.postSend,
            isLoading: busy.value,
            onPressed: body.text.trim().isEmpty ? null : publish,
          ),
        ],
      ),
    );
  }
}
