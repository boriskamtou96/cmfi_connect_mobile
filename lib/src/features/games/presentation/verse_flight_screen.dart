import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/game_sounds.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/flight_verses.dart';
import '../domain/verse_flight.dart';
import 'flight/verse_flight_game.dart';
import 'widgets/game_widgets.dart';

/// « Verset en vol » (spec: docs/specs/jeux.md, § 0 ter): the game of
/// Flame full screen, and above it, in Flutter, the verse being built, the
/// hearts and the way out. Won, the verse shines whole; lost, it starts
/// again. A bonus: no points from the server.
@RoutePage()
class VerseFlightScreen extends HookConsumerWidget {
  const VerseFlightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final language = LocaleSettings.currentLocale.languageCode;
    final verses = ref.watch(flightVersesProvider(language));

    return switch (verses) {
      AsyncData(:final value) when value.isNotEmpty => _Flight(
        verses: value,
        language: language,
      ),
      AsyncError(:final error) => SubPage(
        title: t.games.flightTitle,
        child: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(flightVersesProvider(language)),
        ),
      ),
      _ => const Scaffold(
        backgroundColor: AppColors.night,
        body: Center(child: AppSpinner(color: Colors.white)),
      ),
    };
  }
}

class _Flight extends HookConsumerWidget {
  const _Flight({required this.verses, required this.language});

  final List<FlightVerse> verses;
  final String language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final random = useMemoized(math.Random.new);
    // a round: a verse, flown once; « Recommencer » flies it again
    final round = useState(0);
    final verse = useState(verses[random.nextInt(verses.length)]);
    final flight = useState(VerseFlight.of(verse.value, language: language));
    final game = useMemoized(
      () => VerseFlightGame(
        flight: VerseFlight.of(verse.value, language: language),
        onFlight: (after) => flight.value = after,
        onCatch: (result) {
          switch (result) {
            case Catch.right:
              HapticFeedback.lightImpact();
            case Catch.wrong:
              HapticFeedback.mediumImpact();
            case Catch.won:
              HapticFeedback.mediumImpact();
              ref.read(gameSoundsProvider).lessonDone(level: true);
            case Catch.lost:
              HapticFeedback.heavyImpact();
          }
        },
      ),
      [round.value],
    );

    void again({required bool another}) {
      if (another) {
        verse.value = verses[random.nextInt(verses.length)];
      }
      flight.value = VerseFlight.of(verse.value, language: language);
      round.value++;
    }

    final current = flight.value;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.night,
        body: Stack(
          children: [
            Positioned.fill(
              child: Semantics(
                label: t.games.flightHint,
                child: GameWidget(key: ValueKey(round.value), game: game),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: t.games.flightDone,
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(AppIcons.close, color: Colors.white),
                        ),
                        Expanded(
                          child: Text(
                            t.games.flightTitle,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        _Hearts(hearts: current.hearts),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        12,
                        6,
                        0,
                        0,
                      ),
                      child: _VerseSoFar(flight: current),
                    ),
                  ],
                ),
              ),
            ),
            if (!current.over)
              Positioned(
                left: 24,
                right: 24,
                bottom: MediaQuery.paddingOf(context).bottom + 18,
                child: IgnorePointer(
                  child: Text(
                    t.games.flightHint,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
            if (current.over)
              _End(
                flight: current,
                onAgain: () => again(another: false),
                onNext: () => again(another: true),
                onDone: () => Navigator.of(context).pop(),
              ),
          ],
        ),
      ),
    );
  }
}

/// The hearts left, gold, the lost ones faint.
class _Hearts extends StatelessWidget {
  const _Hearts({required this.hearts});

  final int hearts;

  @override
  Widget build(BuildContext context) => Semantics(
    label: context.t.games.flightHearts(n: hearts),
    excludeSemantics: true,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < VerseFlight.maxHearts; i++)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 3),
            child: Icon(
              AppIcons.heartFilled,
              size: 22,
              color: i < hearts
                  ? AppColors.gold
                  : Colors.white.withValues(alpha: 0.2),
            ),
          ),
      ],
    ),
  );
}

/// The verse as it is caught: the words found in white, the next one as a
/// gold blank, the rest as faint dots; its reference under it.
class _VerseSoFar extends StatelessWidget {
  const _VerseSoFar({required this.flight});

  final VerseFlight flight;

  @override
  Widget build(BuildContext context) {
    final words = flight.words;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (var i = 0; i < words.length; i++)
              if (i < flight.caught)
                Text(
                  words[i],
                  style: const TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 18,
                    height: 1.3,
                    color: Colors.white,
                  ),
                )
              else
                Container(
                  width: i == flight.caught ? 34 : 16,
                  height: 4,
                  margin: const EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    color: i == flight.caught
                        ? AppColors.gold
                        : Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          flight.verse.reference,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.gold.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}

/// The end of a flight, on a dimmed sky: won, the verse whole and Zoé who
/// celebrates; lost, Zoé rests and the verse waits.
class _End extends StatelessWidget {
  const _End({
    required this.flight,
    required this.onAgain,
    required this.onNext,
    required this.onDone,
  });

  final VerseFlight flight;
  final VoidCallback onAgain;
  final VoidCallback onNext;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final won = flight.won;
    return Positioned.fill(
      child: ColoredBox(
        color: AppColors.night.withValues(alpha: 0.82),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                ExcludeSemantics(
                  child: Center(
                    child: DoveMascot(
                      pose: won ? DovePose.celebrate : DovePose.rest,
                      size: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  header: true,
                  liveRegion: true,
                  child: Text(
                    won ? t.games.flightWon : t.games.flightLost,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  won ? '« ${flight.verse.text} »' : t.games.flightLostText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: won ? 'Lora' : null,
                    fontSize: won ? 18 : 15,
                    height: 1.4,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                if (won) ...[
                  const SizedBox(height: 8),
                  Text(
                    flight.verse.reference,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.gold,
                    ),
                  ),
                ],
                const Spacer(),
                GameButton(
                  label: won ? t.games.flightNext : t.games.flightAgain,
                  color: AppColors.gold,
                  foreground: AppColors.ink,
                  onPressed: won ? onNext : onAgain,
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: onDone,
                  child: Text(
                    t.games.flightDone,
                    style: const TextStyle(color: Colors.white),
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
