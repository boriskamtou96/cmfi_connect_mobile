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
import '../application/flight_journey.dart';
import '../application/flight_verses.dart';
import '../domain/flight_journey.dart';
import '../domain/verse_flight.dart';
import 'flight/verse_flight_game.dart';
import 'widgets/game_widgets.dart';

/// « Verset en vol » (spec: docs/specs/jeux.md, § 0 ter): the game of
/// Flame full screen, and above it, in Flutter, the verse being built, the
/// hearts and the way out. Won, the verse shines whole; lost, it starts
/// again. A bonus: no points from the server.
///
/// With a [stage], it is that stage of the journey « La conquête de Canaan »
/// (see `FlightJourneyScreen`): its verse, its sky, its pace; won, the stage
/// is kept and the next one can follow. Without, the free flight: a verse of
/// the day at random.
@RoutePage()
class VerseFlightScreen extends HookConsumerWidget {
  const VerseFlightScreen({@QueryParam('stage') this.stage, super.key});

  /// The stage of the journey to play (from 0), null for the free flight.
  final int? stage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final language = LocaleSettings.currentLocale.languageCode;
    final verses = ref.watch(flightVersesProvider(language));
    final journey = ref.watch(journeyVersesProvider(language));
    // a stage that does not exist, or not open yet: the free flight
    final open =
        stage != null && ref.read(flightJourneyProvider).isOpen(stage!);

    return switch ((verses, journey)) {
      (AsyncData(:final value), AsyncData(value: final stages))
          when value.isNotEmpty =>
        _Flight(
          verses: value,
          journey: stages,
          firstStage: open ? stage : null,
          language: language,
        ),
      (AsyncError(:final error), _) || (_, AsyncError(:final error)) => SubPage(
        title: t.games.flightTitle,
        child: ErrorView(
          error: error,
          onRetry: () => ref
            ..invalidate(flightVersesProvider(language))
            ..invalidate(journeyVersesProvider(language)),
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
  const _Flight({
    required this.verses,
    required this.journey,
    required this.firstStage,
    required this.language,
  });

  /// The verses of the free flight, and those of the journey.
  final List<FlightVerse> verses;
  final JourneyVerses journey;

  /// The stage of the journey to start with, null for the free flight.
  final int? firstStage;
  final String language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final random = useMemoized(math.Random.new);
    // a round: a verse, flown once; « Recommencer » flies it again
    final round = useState(0);
    // on the journey: the stage being played (« Étape suivante » moves on)
    final stage = useState(firstStage);
    final verse = useState(
      firstStage == null
          ? verses[random.nextInt(verses.length)]
          : journey.verses[firstStage!],
    );
    final flight = useState(VerseFlight.of(verse.value, language: language));
    final game = useMemoized(() {
      final played = stage.value;
      final setting = played == null ? null : canaanStages[played];
      return VerseFlightGame(
        flight: VerseFlight.of(verse.value, language: language),
        scenery: setting?.scenery ?? FlightScenery.night,
        pace: setting?.pace ?? 1,
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
              if (played != null) {
                // the stage is kept, the next one opens
                ref
                    .read(flightJourneyProvider.notifier)
                    .won(played, flight.value.hearts);
              }
            case Catch.lost:
              HapticFeedback.heavyImpact();
          }
        },
      );
    }, [round.value]);

    void again({required bool another}) {
      if (another) {
        final played = stage.value;
        if (played == null) {
          verse.value = verses[random.nextInt(verses.length)];
        } else if (played + 1 < journey.verses.length) {
          stage.value = played + 1;
          verse.value = journey.verses[played + 1];
        }
      }
      flight.value = VerseFlight.of(verse.value, language: language);
      round.value++;
    }

    final current = flight.value;
    final played = stage.value;
    final last = played != null && played == journey.verses.length - 1;
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
                          child: played == null
                              ? Text(
                                  t.games.flightTitle,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                )
                              : _StageTitle(
                                  stage: played,
                                  total: journey.verses.length,
                                ),
                        ),
                        _Hearts(hearts: current.hearts),
                      ],
                    ),
                    if (played != null)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          12,
                          6,
                          0,
                          6,
                        ),
                        child: _JourneyBar(
                          stage: played,
                          total: journey.verses.length,
                          flown: current.words.isEmpty
                              ? 0
                              : current.caught / current.words.length,
                        ),
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
                stage: played,
                last: last,
                source: played == null ? null : journey.source,
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
    required this.stage,
    required this.last,
    required this.source,
    required this.onAgain,
    required this.onNext,
    required this.onDone,
  });

  final VerseFlight flight;

  /// On the journey: the stage just played, whether it is the last one, and
  /// the Bible its verse comes from.
  final int? stage;
  final bool last;
  final String? source;
  final VoidCallback onAgain;
  final VoidCallback onNext;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final texts = t.games.journey;
    final won = flight.won;
    final onJourney = stage != null;
    final title = !won
        ? t.games.flightLost
        : !onJourney
        ? t.games.flightWon
        : last
        ? texts.finished
        : texts.won;
    return Positioned.fill(
      child: ColoredBox(
        color: AppColors.night.withValues(alpha: 0.86),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
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
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (won && onJourney) ...[
                        const SizedBox(height: 6),
                        Text(
                          texts.places[stage!],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.gold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(child: _Hearts(hearts: flight.hearts)),
                      ],
                      const SizedBox(height: 12),
                      Text(
                        won
                            ? '« ${flight.verse.text} »'
                            : t.games.flightLostText,
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
                          source == null
                              ? flight.verse.reference
                              : '${flight.verse.reference} · $source',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.gold,
                          ),
                        ),
                      ],
                      if (won && onJourney) ...[
                        const SizedBox(height: 14),
                        Text(
                          last ? texts.finishedText : texts.stories[stage!],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.35,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                      const Spacer(),
                      const SizedBox(height: 16),
                      if (won && onJourney && last)
                        GameButton(
                          label: texts.map,
                          color: AppColors.gold,
                          foreground: AppColors.ink,
                          onPressed: onDone,
                        )
                      else
                        GameButton(
                          label: !won
                              ? t.games.flightAgain
                              : onJourney
                              ? texts.next
                              : t.games.flightNext,
                          color: AppColors.gold,
                          foreground: AppColors.ink,
                          onPressed: won ? onNext : onAgain,
                        ),
                      const SizedBox(height: 8),
                      if (!(won && onJourney && last))
                        TextButton(
                          onPressed: onDone,
                          child: Text(
                            onJourney ? texts.map : t.games.flightDone,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
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

/// On the journey, in place of the name of the game: the place Zoé flies
/// to, and the stage it is.
class _StageTitle extends StatelessWidget {
  const _StageTitle({required this.stage, required this.total});

  final int stage;
  final int total;

  @override
  Widget build(BuildContext context) {
    final texts = context.t.games.journey;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          texts.places[stage],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Text(
          texts.stage(n: stage + 1, total: total),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.gold.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}

/// The journey as a line of dots, one per stage: gold for those behind, the
/// one being flown a ring that fills up word after word, faint ahead. Dots,
/// not dashes: the dashes under it are the words of the verse.
class _JourneyBar extends StatelessWidget {
  const _JourneyBar({
    required this.stage,
    required this.total,
    required this.flown,
  });

  final int stage;
  final int total;

  /// How much of the verse of this stage is caught, from 0 to 1.
  final double flown;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Row(
      children: [
        for (var i = 0; i < total; i++)
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 6),
            child: i == stage
                ? SizedBox.square(
                    dimension: 14,
                    child: CircularProgressIndicator(
                      value: flown.clamp(0, 1).toDouble(),
                      strokeWidth: 3,
                      color: AppColors.gold,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                    ),
                  )
                : Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < stage
                          ? AppColors.gold
                          : Colors.white.withValues(alpha: 0.22),
                    ),
                  ),
          ),
      ],
    ),
  );
}
