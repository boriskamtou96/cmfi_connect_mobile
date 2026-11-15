import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../i18n/strings.g.dart';
import '../../network/app_exception_message.dart';
import '../../services/image_picking.dart';
import '../../services/share_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';
import '../../theme/app_spacing.dart';
import '../../utils/widget_image.dart';
import '../adaptive_menus.dart';
import '../app_button.dart';
import '../app_toast.dart';
import '../cmfi_logo.dart';
import '../photo_kit.dart';
import 'verse_backgrounds.dart';
import 'verse_share_background.dart';

/// A verse to share (the verse of the day, or verses of the Bible): what
/// the image shows, the words sent with the image (its link, the invitation
/// to get the app), and the text shared instead of the image.
class VerseShare {
  const VerseShare({
    required this.text,
    required this.reference,
    required this.source,
    required this.eyebrow,
    required this.caption,
    required this.shareText,
    required this.subject,
    required this.fileName,
  });

  /// The words on the image.
  final String text;

  /// « Jean 3.16 », in gold under the words.
  final String reference;

  /// The Bible they come from (whole: some licences ask for it).
  final String source;

  /// The small title at the top (« Verset du jour », « Bible »).
  final String eyebrow;

  /// Sent with the image (like a song shared from Spotify): never on it.
  final String caption;

  /// Shared with « Partager le texte ».
  final String shareText;
  final String subject;

  /// The name of the PNG shared.
  final String fileName;
}

/// The verse as a square card to share (image or text): a background to
/// choose under the preview (the preview is the image shared), 14/11/2026.
/// [onShared]: once shared (image or text).
Future<void> showVerseShareSheet(
  BuildContext context,
  VerseShare share, {
  VoidCallback? onShared,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (context) => _VerseShareSheet(share: share, onShared: onShared),
);

class _VerseShareSheet extends HookConsumerWidget {
  const _VerseShareSheet({required this.share, this.onShared});

  final VerseShare share;
  final VoidCallback? onShared;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final key = useMemoized(GlobalKey.new);
    final busy = useState(false);
    // the member's own photo, for this share only
    final own = useState<Uint8List?>(null);
    final ownChosen = useState(false);
    final background = switch (own.value) {
      final bytes? when ownChosen.value => VerseBackground.own(bytes),
      _ => verseBackgroundOf(ref.watch(verseShareBackgroundProvider)),
    };

    Future<void> send({required bool image}) async {
      final toast = ref.read(toasterProvider).of(context);
      final service = ref.read(shareServiceProvider);
      final box = context.findRenderObject() as RenderBox?;
      final origin = box == null
          ? null
          : box.localToGlobal(Offset.zero) & box.size;
      busy.value = true;
      try {
        if (image) {
          await service.shareFile(
            await pngOf(key, width: 1080),
            name: share.fileName,
            mimeType: 'image/png',
            subject: share.subject,
            // the link goes with the image, not on it (like a song shared
            // from Spotify): the verse opens in the app, or the site offers
            // the stores
            text: share.caption,
            origin: origin,
          );
        } else {
          await service.shareText(
            share.shareText,
            subject: share.subject,
            origin: origin,
          );
        }
        onShared?.call();
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    void choose(VerseBackground chosen) {
      ownChosen.value = false;
      unawaited(
        ref.read(verseShareBackgroundProvider.notifier).choose(chosen.id),
      );
    }

    // « Ta photo »: chosen again if there is one, else taken or picked
    Future<void> chooseOwn() async {
      if (own.value != null && !ownChosen.value) {
        ownChosen.value = true;
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final camera = await showActionSheet<bool>(
        context,
        title: t.verses.ownPhoto,
        actions: [
          AdaptiveAction(
            value: true,
            icon: AppIcons.camera,
            label: t.profilePhoto.camera,
          ),
          AdaptiveAction(
            value: false,
            icon: AppIcons.image,
            label: t.profilePhoto.gallery,
          ),
        ],
      );
      if (camera == null) {
        return;
      }
      try {
        final picked = await ref
            .read(imagePickingProvider)
            .pickOne(camera: camera);
        if (picked != null && context.mounted) {
          own.value = picked.bytes;
          ownChosen.value = true;
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      }
    }

    final photos = [
      for (final option in verseBackgrounds)
        if (option.isPhoto) option,
    ];
    final colors = [
      for (final option in verseBackgrounds)
        if (!option.isPhoto) option,
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          0,
          AppSpacing.xl,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // the preview is the image shared
            Center(
              child: RepaintBoundary(
                key: key,
                child: _VerseImage(share: share, background: background),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _BackgroundLabel(t.verses.photos),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 56,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                // the photos, then « Ta photo » at the end
                itemCount: photos.length + 1,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) => index == photos.length
                    ? _OwnPhotoChoice(
                        photo: own.value,
                        label: t.verses.ownPhoto,
                        selected: background.id == VerseBackground.ownId,
                        onTap: chooseOwn,
                      )
                    : _BackgroundChoice(
                        background: photos[index],
                        label: t.verses.photoN(n: index + 1),
                        selected: photos[index].id == background.id,
                        onTap: () => choose(photos[index]),
                      ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _BackgroundLabel(t.verses.colors),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) => _BackgroundChoice(
                  background: colors[index],
                  label: t.verses.colorN(n: index + 1),
                  selected: colors[index].id == background.id,
                  round: true,
                  onTap: () => choose(colors[index]),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: t.verses.shareImage,
              isLoading: busy.value,
              onPressed: () => send(image: true),
            ),
            TextButton(
              onPressed: busy.value ? null : () => send(image: false),
              child: Text(t.verses.shareText),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundLabel extends StatelessWidget {
  const _BackgroundLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    ),
  );
}

/// A background to touch: a small photo (rounded) or a round color, ringed
/// in gold and checked once chosen.
class _BackgroundChoice extends StatelessWidget {
  const _BackgroundChoice({
    required this.background,
    required this.label,
    required this.selected,
    required this.onTap,
    this.round = false,
  });

  final VerseBackground background;
  final String label;
  final bool selected;
  final bool round;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final photo = background.image(width: 168);
    final size = round ? 48.0 : 56.0;
    final radius = BorderRadius.circular(round ? 99 : AppRadius.md);
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: size,
          height: size,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: selected ? AppColors.gold : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(round ? 99 : AppRadius.md - 3),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (photo != null)
                  Image(
                    image: photo,
                    fit: BoxFit.cover,
                    alignment: background.alignment,
                    excludeFromSemantics: true,
                    gaplessPlayback: true,
                  )
                else
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: background.colors,
                      ),
                    ),
                  ),
                if (selected)
                  const ColoredBox(
                    color: Color(0x55061F40),
                    child: Icon(AppIcons.check, size: 18, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// « Ta photo », after the photos offered: an image icon until the member
/// takes or picks one, then that photo (ringed in gold once chosen).
class _OwnPhotoChoice extends StatelessWidget {
  const _OwnPhotoChoice({
    required this.photo,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final Uint8List? photo;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final photo = this.photo;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 56,
          height: 56,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: selected ? AppColors.gold : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md - 3),
            child: photo == null
                ? ColoredBox(
                    color: scheme.surfaceContainerHighest,
                    child: Icon(
                      AppIcons.addImage,
                      size: 22,
                      color: scheme.onSurfaceVariant,
                    ),
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image(
                        image: ResizeImage(MemoryImage(photo), width: 168),
                        fit: BoxFit.cover,
                        excludeFromSemantics: true,
                      ),
                      if (selected)
                        const ColoredBox(
                          color: Color(0x55061F40),
                          child: Icon(
                            AppIcons.check,
                            size: 18,
                            color: Colors.white,
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

/// The square card shared (redrawn on 12/11/2026, a background to choose
/// since 14/11/2026): a photo graded toward the night blue under a veil, or
/// two colors with a glow of gold in a corner and the ring of the brand
/// behind; « Verset du jour » after a gold rule, the verse in Lora on a
/// large faded quotation mark, its reference in gold with the Bible it comes
/// from, then the app and its site under a hairline.
class _VerseImage extends StatelessWidget {
  const _VerseImage({required this.share, required this.background});

  final VerseShare share;
  final VerseBackground background;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final photo = background.image();
    final long = share.text.length;
    final size = long > 260
        ? 13.5
        : long > 180
        ? 15.0
        : long > 110
        ? 17.0
        : 20.0;

    return Container(
      width: 320,
      height: 320,
      clipBehavior: Clip.antiAlias,
      // square, without rounded corners (15/11/2026): the image shared is
      // the whole card
      decoration: BoxDecoration(
        color: AppColors.night,
        gradient: photo != null
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: background.colors,
              ),
      ),
      child: Stack(
        children: [
          if (photo != null) ...[
            Positioned.fill(
              child: Image(
                image: photo,
                fit: BoxFit.cover,
                alignment: background.alignment,
                excludeFromSemantics: true,
                gaplessPlayback: true,
              ),
            ),
            // a dark veil that keeps the warm light of the photo: the words
            // stay easy to read on any part of it
            const Positioned.fill(
              child: PhotoScrim(
                colors: [
                  Color(0x66000000),
                  Color(0x52000000),
                  Color(0x80000000),
                  Color(0xD9000000),
                ],
                stops: [0, 0.35, 0.65, 1],
              ),
            ),
          ] else ...[
            // a glow of gold from the corner the reading starts in
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(-1.1, -1.2),
                    radius: 1.1,
                    colors: [Color(0x38E2A93B), Color(0x00E2A93B)],
                  ),
                ),
              ),
            ),
            // the ring of the brand, large and faint (a decor: it stays
            // there in right-to-left languages too)
            Positioned(
              right: -92,
              bottom: -104,
              child: BrandRing(
                size: 300,
                color: Colors.white.withValues(alpha: 0.055),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 24, 26, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 22, height: 2, color: AppColors.gold),
                    const SizedBox(width: 8),
                    Text(
                      share.eyebrow.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.6,
                        color: AppColors.goldLight,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      // the quotation mark, behind the words
                      PositionedDirectional(
                        start: -6,
                        top: 2,
                        child: Text(
                          '“',
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 120,
                            height: 1,
                            color: AppColors.gold.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      // a long passage gets smaller rather than overflowing
                      LayoutBuilder(
                        builder: (context, box) => Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerStart,
                            child: SizedBox(
                              width: box.maxWidth,
                              child: Text(
                                share.text,
                                style: TextStyle(
                                  fontFamily: 'Lora',
                                  fontStyle: FontStyle.italic,
                                  fontSize: size,
                                  height: 1.42,
                                  color: Colors.white,
                                  shadows: photo == null
                                      ? null
                                      : const [
                                          Shadow(
                                            color: Color(0x66000000),
                                            blurRadius: 6,
                                          ),
                                        ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  share.reference,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.1,
                    color: AppColors.goldLight,
                  ),
                ),
                const SizedBox(height: 1),
                // the Bible it comes from, whole (some licences ask for it)
                Text(
                  share.source,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppColors.onPrimaryMuted,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.14),
                ),
                const SizedBox(height: 11),
                Row(
                  children: [
                    const CmfiLogo.onDark(size: 22),
                    const SizedBox(width: 8),
                    Text(
                      t.app.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.1,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
