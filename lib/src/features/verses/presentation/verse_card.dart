import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_invite.dart';
import '../../../core/services/deep_links.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/photo_kit.dart';
import '../../../core/widgets/verse_share/verse_share_sheet.dart';
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
                        onPressed: () => showVerseShareSheet(
                          context,
                          verseShareOf(context.t, verse),
                        ),
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

/// The verse of the day as it is shared: on a card, with its link and the
/// invitation to get the app; or as text.
VerseShare verseShareOf(Translations t, Verse verse) {
  final day = today();
  return VerseShare(
    text: verse.text,
    reference: verse.reference,
    source: verse.source,
    eyebrow: t.verses.title,
    caption: _verseCaption(t, verse),
    shareText: withAppInvite(
      t,
      _withLink(verse, '« ${verse.text} »\n${verse.reference}'),
    ),
    subject: t.verses.title,
    fileName:
        'verset_${day.month.toString().padLeft(2, '0')}'
        '-${day.day.toString().padLeft(2, '0')}.png',
  );
}
