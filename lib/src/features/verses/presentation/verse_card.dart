import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/app_invite.dart';
import '../../../core/services/deep_links.dart';
import '../../../core/services/image_picking.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/widget_image.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/photo_kit.dart';
import '../application/verse_of_the_day.dart';
import '../application/verse_share_background.dart';
import '../domain/verse.dart';
import 'verse_backgrounds.dart';

/// Today's verse on the home screen, on the photo of a brother reading his
/// Bible, graded toward the night blue: a frosted "Verset du jour", a gold
/// rule, the words in Lora, the reference and the Bible it comes from. The
/// book opens it in the Bible ([onRead], with its key: "JHN.3.16"), the
/// arrow makes a card of it to share.
class VerseOfTheDayCard extends ConsumerWidget {
  const VerseOfTheDayCard({this.onRead, super.key});

  final ValueChanged<String>? onRead;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verse = ref.watch(verseOfTheDayProvider).value;
    if (verse == null) {
      return const SizedBox.shrink();
    }
    final t = context.t.verses;
    final osis = verse.osis;
    final read = onRead == null || osis == null ? null : () => onRead!(osis);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: floatingShadow(),
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: GradedPhoto(
              StockPhotos.reading,
              grade: PhotoGrade.night,
              alignment: Alignment(0.05, -0.2),
            ),
          ),
          const Positioned.fill(
            child: PhotoScrim(
              colors: [
                Color(0x66061F40),
                Color(0x00061F40),
                Color(0xB3061F40),
                Color(0xF2061F40),
              ],
              stops: [0, 0.25, 0.55, 1],
            ),
          ),
          // no fixed height: a long verse makes the card taller
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 400),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg + 2,
                AppSpacing.lg + 2,
                AppSpacing.md + 2,
                AppSpacing.md + 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FrostedGlass(
                    radius: 99,
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 14, 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          AppIcons.verse,
                          size: 15,
                          color: AppColors.goldLight,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          t.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // the face of the photo
                  const SizedBox(height: 150),
                  Semantics(
                    button: read != null,
                    hint: read == null ? null : context.t.bible.readInBible,
                    child: GestureDetector(
                      onTap: read,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 28,
                              height: 3,
                              decoration: BoxDecoration(
                                color: AppColors.goldLight,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              verse.text,
                              style: const TextStyle(
                                fontFamily: 'Lora',
                                fontStyle: FontStyle.italic,
                                fontSize: 19,
                                height: 1.45,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                verse.reference,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.goldLight,
                                ),
                              ),
                              Text(
                                verse.source,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withValues(alpha: 0.65),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (read != null)
                        _FrostedButton(
                          icon: AppIcons.bible,
                          tooltip: context.t.bible.readInBible,
                          onPressed: read,
                        ),
                      const SizedBox(width: AppSpacing.sm),
                      _FrostedButton(
                        icon: AppIcons.share,
                        tooltip: t.share,
                        onPressed: () => showVerseShareSheet(context, verse),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A round frosted button over the photo (48 dp to touch).
class _FrostedButton extends StatelessWidget {
  const _FrostedButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FrostedGlass(
    radius: 99,
    padding: EdgeInsets.zero,
    tint: Colors.white.withValues(alpha: 0.15),
    child: IconButton(
      tooltip: tooltip,
      color: Colors.white,
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
    ),
  );
}

/// The verse as a card to share (image or text).
Future<void> showVerseShareSheet(BuildContext context, Verse verse) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => _VerseShareSheet(verse: verse),
    );

class _VerseShareSheet extends HookConsumerWidget {
  const _VerseShareSheet({required this.verse});

  final Verse verse;

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
    final day = today();
    final name =
        'verset_${day.month.toString().padLeft(2, '0')}'
        '-${day.day.toString().padLeft(2, '0')}.png';

    Future<void> share({required bool image}) async {
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
            name: name,
            mimeType: 'image/png',
            subject: t.verses.title,
            // the link goes with the image, not on it (like a song shared
            // from Spotify): the verse opens in the app, or the site offers
            // the stores
            text: _verseCaption(t, verse),
            origin: origin,
          );
        } else {
          await service.shareText(
            withAppInvite(
              t,
              _withLink(verse, '« ${verse.text} »\n${verse.reference}'),
            ),
            subject: t.verses.title,
            origin: origin,
          );
        }
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
                child: _VerseImage(verse: verse, background: background),
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
              onPressed: () => share(image: true),
            ),
            TextButton(
              onPressed: busy.value ? null : () => share(image: false),
              child: Text(t.verses.shareText),
            ),
          ],
        ),
      ),
    );
  }
}

/// [text], then the link of [verse] when it has a key: it opens the verse
/// in the Bible of the app, or the site offers the stores.
String _withLink(Verse verse, String text) => switch (verse.osis) {
  final osis? => BibleLink(osis).under(text),
  null => text,
};

/// The words sent with the image (14/11/2026, like a song shared from
/// Spotify): the reference, its link, then the invitation to get the app.
String _verseCaption(Translations t, Verse verse) =>
    withAppInvite(t, _withLink(verse, verse.reference));

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
  const _VerseImage({required this.verse, required this.background});

  final Verse verse;
  final VerseBackground background;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final photo = background.image();
    final long = verse.text.length;
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
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
                      t.verses.title.toUpperCase(),
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
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          verse.text,
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
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  verse.reference,
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
                  verse.source,
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
