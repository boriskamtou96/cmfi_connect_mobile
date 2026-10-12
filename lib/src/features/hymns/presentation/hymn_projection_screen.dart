import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/screen_awake.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../application/hymn_library.dart';
import '../domain/hymn.dart';
import '../domain/hymn_text.dart';

/// One stanza at a time, as big as the screen allows, to lead the singing or show it to
/// others. Tap on the right to go on, on the left to go back. The chorus comes back after
/// each verse, the screen stays on, and the phone can be turned sideways.
@RoutePage()
class HymnProjectionScreen extends HookConsumerWidget {
  const HymnProjectionScreen({
    @PathParam('bookCode') required this.bookCode,
    @PathParam('number') required this.number,
    super.key,
  });

  final String bookCode;
  final int number;

  static const background = Color(0xFF0E0D0B);
  static const foreground = Color(0xFFF2EDE3);
  static const muted = Color(0xFF9C9686);
  static const accent = Color(0xFFE2C27A);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final hymn = ref.watch(hymnBookProvider(bookCode))?.hymn(number);
    final stanza = useState(0);

    final awake = ref.read(screenAwakeProvider);
    useEffect(() {
      awake.keepOn(on: true);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      return () {
        awake.keepOn(on: false);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      };
    }, const []);

    if (hymn == null) {
      return const Scaffold(backgroundColor: background);
    }

    final parts = sungParts(hymn, repeatChorus: true);
    final index = stanza.value.clamp(0, parts.length - 1);
    final part = parts[index].part;

    void go(int delta) {
      final next = (index + delta).clamp(0, parts.length - 1);
      if (next != index) {
        HapticFeedback.selectionClick();
        stanza.value = next;
      }
    }

    final label = part.kind == HymnPartKind.chorus
        ? (part.label == null
              ? t.hymns.chorus
              : t.hymns.chorusNumber(label: part.label!))
        : (part.label == null ? '' : t.hymns.verse(label: part.label!));

    final topBar = Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xs,
        AppSpacing.xs,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: t.hymns.projection.exit,
            icon: const Icon(AppIcons.close, color: muted),
            onPressed: () => context.router.maybePop(),
          ),
          Expanded(
            child: Text(
              '${t.hymns.number(number: hymn.number)} · ${hymn.title}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 14,
                color: muted,
              ),
            ),
          ),
          Text(
            t.hymns.projection.position(
              current: index + 1,
              total: parts.length,
            ),
            style: const TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: muted,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Stack(
          children: [
            // left third: back; the rest: next
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: t.hymns.projection.previous,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => go(-1),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Semantics(
                      button: true,
                      label: t.hymns.projection.next,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => go(1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // the stanza, above the tap zones without catching the taps
            Positioned.fill(
              child: IgnorePointer(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.xl,
                    64,
                    AppSpacing.xl,
                    AppSpacing.xl,
                  ),
                  child: AnimatedSwitcher(
                    duration: AppMotion.of(context, AppMotion.medium),
                    child: _Stanza(
                      key: ValueKey(index),
                      label: label,
                      lines: part.lines,
                      chorus: part.kind == HymnPartKind.chorus,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(top: 0, left: 0, right: 0, child: topBar),
          ],
        ),
      ),
    );
  }
}

/// A stanza with the largest text that fits the space.
class _Stanza extends StatelessWidget {
  const _Stanza({
    required this.label,
    required this.lines,
    required this.chorus,
    super.key,
  });

  final String label;
  final List<String> lines;
  final bool chorus;

  @override
  Widget build(BuildContext context) {
    final text = lines.join('\n');
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScaler = MediaQuery.textScalerOf(context);
        // measured with exactly the style the Text will use (the inherited one included)
        final inherited = DefaultTextStyle.of(context).style;
        TextStyle style(double size) => inherited.merge(
          TextStyle(
            fontFamily: 'Lora',
            fontSize: size,
            height: 1.4,
            fontStyle: chorus ? FontStyle.italic : FontStyle.normal,
            color: HymnProjectionScreen.foreground,
          ),
        );

        // the biggest size whose text fits in the space under the label
        final available = Size(
          constraints.maxWidth,
          constraints.maxHeight - 40,
        );
        var low = 16.0;
        var high = 72.0;
        for (var i = 0; i < 12; i++) {
          final size = (low + high) / 2;
          final painter = TextPainter(
            text: TextSpan(text: text, style: style(size)),
            textDirection: Directionality.of(context),
            textScaler: textScaler,
            textAlign: TextAlign.center,
          )..layout(maxWidth: available.width);
          if (painter.height <= available.height) {
            low = size;
          } else {
            high = size;
          }
          painter.dispose();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (label.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    color: HymnProjectionScreen.accent,
                  ),
                ),
              ),
            // a little under the limit found, for rounding
            Text(text, textAlign: TextAlign.center, style: style(low * 0.97)),
          ],
        );
      },
    );
  }
}
