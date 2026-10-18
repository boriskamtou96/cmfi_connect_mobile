import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/widget_image.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/photo_kit.dart';
import '../application/verse_of_the_day.dart';
import '../domain/verse.dart';

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
            origin: origin,
          );
        } else {
          await service.shareText(
            '« ${verse.text} »\n${verse.reference}\n\n${t.app.name}',
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

    return SafeArea(
      child: Padding(
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
            Center(
              child: RepaintBoundary(
                key: key,
                child: _VerseImage(verse: verse),
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

/// The square card shared: the night blue of the app, the verse in gold
/// light.
class _VerseImage extends StatelessWidget {
  const _VerseImage({required this.verse});

  final Verse verse;

  @override
  Widget build(BuildContext context) {
    final long = verse.text.length;
    final size = long > 180 ? 15.0 : (long > 110 ? 17.0 : 20.0);

    return Container(
      width: 320,
      height: 320,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B3B70), AppColors.primaryDeep],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '“',
            style: TextStyle(
              fontFamily: 'Lora',
              fontSize: 54,
              height: 0.8,
              color: AppColors.gold,
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                verse.text,
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontStyle: FontStyle.italic,
                  fontSize: size,
                  height: 1.4,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            verse.reference,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.goldLight,
            ),
          ),
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
          Row(
            children: [
              const CmfiLogo.onDark(size: 22),
              const SizedBox(width: 8),
              Text(
                context.t.app.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onPrimaryMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
