import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/services/deep_links.dart';
import '../../../../core/services/photo_saver.dart';
import '../../../../core/services/share_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/cmfi_logo.dart';
import '../../../journey/application/journey_steps.dart';
import '../../../journey/domain/journey_step.dart';
import '../../domain/hymn.dart';
import '../../domain/hymn_text.dart';
import 'book_cover.dart';

/// The colors a card of words can take: the book's first, then the night,
/// the earth, the purple, the rose and the black.
List<Color> lyricsCardColors(List<Color> book) => [
  book.first,
  const Color(0xFF14284A),
  const Color(0xFFB5562F),
  const Color(0xFF8E5BC2),
  const Color(0xFFB94A6C),
  const Color(0xFF2B2B2B),
];

/// Shares [lines] of [hymn]: as an image (a card in the color chosen, to
/// save or share) or as text (between quotes, with the hymn and its link).
Future<void> showLyricsShare(
  BuildContext context, {
  required HymnBook book,
  required List<Color> bookColors,
  required Hymn hymn,
  required List<String> lines,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  showDragHandle: true,
  builder: (context) => _LyricsShareSheet(
    book: book,
    bookColors: bookColors,
    hymn: hymn,
    lines: lines,
  ),
);

class _LyricsShareSheet extends HookConsumerWidget {
  const _LyricsShareSheet({
    required this.book,
    required this.bookColors,
    required this.hymn,
    required this.lines,
  });

  final HymnBook book;
  final List<Color> bookColors;
  final Hymn hymn;
  final List<String> lines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.hymns;
    final s = t.lyrics;
    final scheme = Theme.of(context).colorScheme;
    final module = AppModule.hymns.tone(context);
    final asImage = useState(true);
    final colors = lyricsCardColors(bookColors);
    final color = useState(colors.first);
    final busy = useState(false);
    final cardKey = useMemoized(GlobalKey.new);

    final text = HymnLink(book.code, hymn.number).under(
      excerptAsText(
        lines,
        reference: s.reference(number: hymn.number, title: hymn.title),
        bookTitle: book.title,
      ),
    );
    final fileName = 'cantique-${hymn.number}.png';

    // « Un chant partagé »
    void shared() => unawaited(
      ref.read(journeyStepsProvider.notifier).reach(JourneyStep.lyricsShared),
    );

    // the card as a story (9:16): on its color, darker
    Future<Uint8List?> image() async {
      final boundary =
          cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        return null;
      }
      final card = await boundary.toImage(pixelRatio: 3);
      return lyricsStoryPng(card, color.value);
    }

    // [anchor]: where the iPad share sheet points from
    Rect? origin(BuildContext anchor) {
      final box = anchor.findRenderObject() as RenderBox?;
      return box == null ? null : box.localToGlobal(Offset.zero) & box.size;
    }

    Future<void> run(Future<void> Function() action) async {
      if (busy.value) {
        return;
      }
      busy.value = true;
      try {
        await action();
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    Future<void> save() => run(() async {
      final toast = ref.read(toasterProvider).of(context);
      final png = await image();
      if (png == null) {
        return;
      }
      try {
        final saved = await ref
            .read(photoSaverProvider)
            .save(png, name: fileName);
        saved ? toast.success(s.saved) : toast.error(s.saveDenied);
        if (saved) {
          shared();
        }
      } on Object {
        toast.error(s.saveFailed);
      }
    });

    Future<void> shareImage(BuildContext anchor) => run(() async {
      final where = origin(anchor);
      final png = await image();
      if (png == null) {
        return;
      }
      await ref
          .read(shareServiceProvider)
          .shareFile(
            png,
            name: fileName,
            mimeType: 'image/png',
            subject: hymn.title,
            origin: where,
          );
      shared();
    });

    Future<void> copy() async {
      final toast = ref.read(toasterProvider).of(context);
      await Clipboard.setData(ClipboardData(text: text));
      toast.success(t.reader.copied);
    }

    Future<void> shareText(BuildContext anchor) async {
      await ref
          .read(shareServiceProvider)
          .shareText(text, subject: hymn.title, origin: origin(anchor));
      shared();
    }

    final buttonStyle = FilledButton.styleFrom(
      backgroundColor: module.color,
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(52),
    );
    // its own width: the main button takes the rest
    final outlineStyle = OutlinedButton.styleFrom(
      minimumSize: const Size(0, 52),
      padding: const EdgeInsets.symmetric(horizontal: 18),
    );

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: true, label: Text(s.image)),
              ButtonSegment(value: false, label: Text(s.text)),
            ],
            selected: {asImage.value},
            onSelectionChanged: (value) => asImage.value = value.single,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (asImage.value) ...[
            Center(
              child: RepaintBoundary(
                key: cardKey,
                child: LyricsCard(
                  book: book,
                  bookColors: bookColors,
                  hymn: hymn,
                  lines: lines,
                  color: color.value,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final (index, swatch) in colors.indexed)
                  Semantics(
                    button: true,
                    selected: swatch == color.value,
                    label: '${s.color} ${index + 1}',
                    excludeSemantics: true,
                    child: GestureDetector(
                      onTap: () => color.value = swatch,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: swatch,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: swatch == color.value
                                ? module.color
                                : Colors.transparent,
                            width: 3,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                OutlinedButton.icon(
                  style: outlineStyle,
                  onPressed: busy.value ? null : save,
                  icon: const Icon(AppIcons.download),
                  label: Text(s.save),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Builder(
                    builder: (anchor) => FilledButton.icon(
                      style: buttonStyle,
                      onPressed: busy.value ? null : () => shareImage(anchor),
                      icon: const Icon(AppIcons.share),
                      label: Text(s.shareImage),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Text(text, style: const TextStyle(height: 1.5)),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                OutlinedButton.icon(
                  style: outlineStyle,
                  onPressed: copy,
                  icon: const Icon(AppIcons.copy),
                  label: Text(s.copy),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Builder(
                    builder: (anchor) => FilledButton.icon(
                      style: buttonStyle,
                      onPressed: () => shareText(anchor),
                      icon: const Icon(AppIcons.share),
                      label: Text(s.shareText),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Words of a hymn as a card: the cover, the number and title, the book,
/// the lines in bold, then CMFI Connect. White on [color].
class LyricsCard extends StatelessWidget {
  const LyricsCard({
    required this.book,
    required this.bookColors,
    required this.hymn,
    required this.lines,
    required this.color,
    super.key,
  });

  final HymnBook book;
  final List<Color> bookColors;
  final Hymn hymn;
  final List<String> lines;
  final Color color;

  static const width = 320.0;

  @override
  Widget build(BuildContext context) {
    // the books are in French and English
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BookCover(book: book, colors: bookColors, size: 52),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${hymn.number} · ${hymn.title}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          book.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                lines.join('\n'),
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  height: 1.38,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox.square(
                    dimension: 24,
                    child: CustomPaint(
                      painter: CmfiLogoPainter(disc: true, details: false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'CMFI Connect',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [card] (an image of [LyricsCard]) in the middle of a story, 1080 × 1920,
/// on [color] made darker, with a soft shadow under it. As a PNG.
Future<Uint8List> lyricsStoryPng(ui.Image card, Color color) async {
  const size = Size(1080, 1920);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawRect(
    Offset.zero & size,
    Paint()..color = Color.lerp(color, Colors.black, 0.28)!,
  );
  // the card takes most of the width
  final scale = size.width * 0.86 / card.width;
  final width = card.width * scale;
  final height = card.height * scale;
  final rect = Rect.fromLTWH(
    (size.width - width) / 2,
    (size.height - height) / 2,
    width,
    height,
  );
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      rect.shift(const Offset(0, 24)),
      const Radius.circular(54),
    ),
    Paint()
      ..color = Colors.black.withValues(alpha: 0.28)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40),
  );
  canvas.drawImageRect(
    card,
    Offset.zero & Size(card.width.toDouble(), card.height.toDouble()),
    rect,
    Paint()..filterQuality = FilterQuality.high,
  );
  final story = await recorder.endRecording().toImage(
    size.width.toInt(),
    size.height.toInt(),
  );
  final data = await story.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}
