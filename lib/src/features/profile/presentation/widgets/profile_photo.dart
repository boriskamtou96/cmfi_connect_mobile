import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/image_picking.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../routing/app_router.dart';
import '../../../members/presentation/widgets/member_avatar.dart';
import '../../application/current_profile.dart';
import '../../infrastructure/profile_api.dart';

/// The user's photo with a camera badge: a tap takes a new one, picks one in
/// the gallery or removes it. Seen by the other members wherever the user's
/// name appears.
class ProfilePhotoButton extends HookConsumerWidget {
  const ProfilePhotoButton({this.size = 96, super.key});

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.profilePhoto;
    final scheme = Theme.of(context).colorScheme;
    final profile = ref.watch(currentProfileProvider).value;
    final busy = useState(false);
    final hasPhoto = profile?.avatar != null;
    final badge = size * 0.32;

    return Semantics(
      button: true,
      label: hasPhoto ? t.change : t.add,
      excludeSemantics: true,
      child: InkResponse(
        onTap: busy.value
            ? null
            : () => changeProfilePhoto(context, ref, busy: busy),
        radius: size / 2 + 4,
        child: SizedBox.square(
          dimension: size,
          child: Stack(
            children: [
              MemberAvatar(
                initials: profile?.initials ?? '',
                photo: profile?.avatar,
                size: size,
              ),
              if (busy.value)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: scheme.surface.withValues(alpha: 0.6),
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              PositionedDirectional(
                end: 0,
                bottom: 0,
                child: Container(
                  width: badge,
                  height: badge,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: scheme.surface, width: 2),
                  ),
                  child: Icon(
                    AppIcons.camera,
                    size: badge * 0.55,
                    color: scheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _PhotoChoice { camera, gallery, remove }

/// Asks how to change the photo (camera, gallery, or remove it), then
/// crops, sends and shows it; [busy] is on while the server works.
Future<void> changeProfilePhoto(
  BuildContext context,
  WidgetRef ref, {
  required ValueNotifier<bool> busy,
}) async {
  final t = context.t;
  final toast = ref.read(toasterProvider).of(context);
  final router = context.router;
  // still usable once the screen is gone (the sending goes on)
  final container = ProviderScope.containerOf(context, listen: false);
  final hasPhoto = container.read(currentProfileProvider).value?.avatar != null;

  final choice = await showModalBottomSheet<_PhotoChoice>(
    context: context,
    useSafeArea: true,
    builder: (context) => _PhotoSheet(hasPhoto: hasPhoto),
  );
  if (choice == null) {
    return;
  }

  Future<void> send(Future<void> Function() call, String done) async {
    busy.value = true;
    try {
      await call();
      container.invalidate(currentProfileProvider);
      await container.read(currentProfileProvider.future);
      toast.success(done);
    } on Object catch (error) {
      toast.error(userMessageFor(error, t));
    } finally {
      if (context.mounted) {
        busy.value = false;
      }
    }
  }

  final api = container.read(profileApiProvider);
  if (choice == _PhotoChoice.remove) {
    await send(api.removeAvatar, t.profilePhoto.removed);
    return;
  }
  final picked = await container
      .read(imagePickingProvider)
      .pickOne(camera: choice == _PhotoChoice.camera);
  if (picked == null || !context.mounted) {
    return;
  }
  final square = await router.push<Uint8List>(
    PhotoCropRoute(bytes: picked.bytes),
  );
  if (square == null || !context.mounted) {
    return;
  }
  await send(() => api.setAvatar(square), t.profilePhoto.saved);
}

class _PhotoSheet extends StatelessWidget {
  const _PhotoSheet({required this.hasPhoto});

  final bool hasPhoto;

  @override
  Widget build(BuildContext context) {
    final t = context.t.profilePhoto;
    final scheme = Theme.of(context).colorScheme;

    Widget option(_PhotoChoice choice, IconData icon, String label) {
      final color = choice == _PhotoChoice.remove ? scheme.error : null;
      return ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
        onTap: () => Navigator.of(context).pop(choice),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                0,
                AppSpacing.xl,
                AppSpacing.xs,
              ),
              child: Text(
                t.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                0,
                AppSpacing.xl,
                AppSpacing.sm,
              ),
              child: Text(
                t.seenBy,
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
            ),
            option(_PhotoChoice.camera, AppIcons.camera, t.camera),
            option(_PhotoChoice.gallery, AppIcons.image, t.gallery),
            if (hasPhoto)
              option(_PhotoChoice.remove, AppIcons.delete, t.remove),
          ],
        ),
      ),
    );
  }
}
