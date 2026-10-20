import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/share_service.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/widget_image.dart';
import '../../../../core/widgets/app_toast.dart';

/// Full-screen pages told like stories ("Ta semaine avec Dieu", "Ton année
/// avec Dieu"). Each page goes on by itself after [pageDuration] (not with
/// "reduce motion"); a tap on the right goes on, on the left goes back, a
/// long press holds. The button at the bottom shares the page shown as an
/// image (1080 px wide).
class StoryPager extends HookConsumerWidget {
  const StoryPager({
    required this.length,
    required this.pageBuilder,
    required this.pageLabel,
    required this.shareLabel,
    required this.shareName,
    required this.shareSubject,
    this.shareColor = const Color(0xFF14123A),
    super.key,
  });

  /// How long a page stays before the next one.
  static const pageDuration = Duration(seconds: 8);

  final int length;

  /// The page at an index, as it is shared (its background included).
  final Widget Function(BuildContext context, int index) pageBuilder;

  /// "2 sur 5", for screen readers.
  final String Function(int current, int total) pageLabel;
  final String shareLabel;

  /// The name of the image shared ("ma-semaine-avec-dieu-2026-10-12.png").
  final String shareName;
  final String shareSubject;

  /// The text of the white share button.
  final Color shareColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final index = useState(0);
    final keys = useMemoized(
      () => [for (var i = 0; i < length; i++) GlobalKey()],
      [length],
    );
    final reduced = AppMotion.reduced(context);
    final clock = useAnimationController(duration: pageDuration);
    final sharing = useState(false);

    void go(int delta) {
      final next = index.value + delta;
      if (next >= 0 && next < length) {
        index.value = next;
      } else if (delta < 0) {
        clock.forward(from: 0);
      }
    }

    // each page runs its clock, then gives way to the next (the last stays)
    useEffect(() {
      if (reduced) {
        clock.value = 1;
        return null;
      }
      void listener(AnimationStatus status) {
        if (status == AnimationStatus.completed && index.value < length - 1) {
          index.value += 1;
        }
      }

      clock
        ..addStatusListener(listener)
        ..forward(from: 0);
      return () => clock.removeStatusListener(listener);
    }, [index.value, reduced]);

    void hold() => clock.stop();
    void resume() {
      if (!reduced && !sharing.value && !clock.isCompleted) {
        clock.forward();
      }
    }

    Future<void> share(Rect? origin) async {
      final service = ref.read(shareServiceProvider);
      final toast = ref.read(toasterProvider).of(context);
      sharing.value = true;
      hold();
      try {
        final bytes = await pngOf(keys[index.value], width: 1080);
        await service.shareFile(
          bytes,
          name: shareName,
          mimeType: 'image/png',
          subject: shareSubject,
          origin: origin,
        );
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          sharing.value = false;
          resume();
        }
      }
    }

    final padding = MediaQuery.paddingOf(context);
    final localizations = MaterialLocalizations.of(context);

    return Stack(
      children: [
        // the page, as shared: its colors, the logo, what it tells
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: AppMotion.of(context, AppMotion.medium),
            child: RepaintBoundary(
              key: keys[index.value],
              child: pageBuilder(context, index.value),
            ),
          ),
        ),
        // a tap on the right goes on, on the left goes back; held, it waits
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (details) => go(
              details.globalPosition.dx < MediaQuery.sizeOf(context).width / 3
                  ? -1
                  : 1,
            ),
            onLongPressStart: (_) => hold(),
            onLongPressEnd: (_) => resume(),
            // the same sides as the taps, in Arabic too
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                Expanded(
                  child: Semantics(
                    button: true,
                    label: localizations.previousPageTooltip,
                    onTap: () => go(-1),
                    child: const SizedBox.expand(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Semantics(
                    button: true,
                    label: localizations.nextPageTooltip,
                    onTap: () => go(1),
                    child: const SizedBox.expand(),
                  ),
                ),
              ],
            ),
          ),
        ),
        // the pages, like stories: done, going, to come
        Positioned(
          left: 16,
          right: 16,
          top: padding.top + 10,
          child: Semantics(
            label: pageLabel(index.value + 1, length),
            child: AnimatedBuilder(
              animation: clock,
              builder: (context, _) => Row(
                children: [
                  for (var i = 0; i < length; i++) ...[
                    if (i > 0) const SizedBox(width: 4),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: i < index.value
                              ? 1
                              : i == index.value
                              ? clock.value
                              : 0,
                          minHeight: 3,
                          color: Colors.white,
                          backgroundColor: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          end: 4,
          top: padding.top + 20,
          child: IconButton(
            tooltip: localizations.closeButtonTooltip,
            onPressed: () => context.router.maybePop(),
            icon: const Icon(AppIcons.close, color: Colors.white, size: 26),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: padding.bottom + 30,
          child: Builder(
            builder: (button) => FilledButton.icon(
              onPressed: sharing.value
                  ? null
                  : () {
                      final box = button.findRenderObject() as RenderBox?;
                      share(
                        box == null
                            ? null
                            : box.localToGlobal(Offset.zero) & box.size,
                      );
                    },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: shareColor,
                minimumSize: const Size.fromHeight(54),
                shape: const StadiumBorder(),
                textStyle: const TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              icon: const Icon(AppIcons.share, size: 20),
              label: Text(shareLabel),
            ),
          ),
        ),
      ],
    );
  }
}
