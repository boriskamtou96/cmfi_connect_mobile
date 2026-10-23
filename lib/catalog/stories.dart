import 'package:flutter/material.dart';

import '../src/core/theme/app_colors.dart';
import '../src/core/widgets/cmfi_logo.dart';
import '../src/core/widgets/code_chip.dart';
import '../src/core/widgets/dove_mascot.dart';
import '../src/core/widgets/goal_ring.dart';
import '../src/core/widgets/reader/reader_choices.dart';
import '../src/core/widgets/reader/reader_palette.dart';
import '../src/core/widgets/section_card.dart';
import '../src/features/hymns/domain/hymn.dart';
import '../src/features/hymns/presentation/widgets/book_cover.dart';
import '../src/features/hymns/presentation/widgets/hymn_tile.dart';
import '../src/features/hymns/presentation/widgets/lyrics_share_sheet.dart';
import '../src/features/journey/domain/journey_step.dart';
import '../src/features/journey/presentation/step_medal.dart';
import '../src/features/reports/presentation/widgets/streak_celebration.dart';
import 'knobs.dart';

/// A component shown in the catalog: its family, its name, and how to build
/// it from the [Knobs] it asks for.
class Story {
  const Story({required this.group, required this.name, required this.build});

  final String group;
  final String name;
  final Widget Function(BuildContext context, Knobs knobs) build;
}

// invented words and titles, for the look only
final _book = HymnBook(
  code: 'catalogue',
  title: 'Chants du catalogue, volume 1',
  version: '1',
  hymns: [
    _hymn(1, 'Grâce infinie', 'Ta grâce, Seigneur, me relève,'),
    _hymn(2, 'Ta fidélité', 'Chaque matin ta bonté se renouvelle'),
  ],
);

Hymn _hymn(int number, String title, String firstLine) => Hymn(
  number: number,
  title: title,
  firstLine: firstLine,
  parts: [
    HymnPart(kind: HymnPartKind.verse, label: '1', lines: [firstLine]),
  ],
);

const _lines = [
  'Je chanterai ta fidélité,',
  'tant que j’aurai du souffle en moi ;',
  'ton amour ne m’a jamais quitté,',
  'je marcherai toujours avec toi.',
];

/// The colors of the hymn books, by their place.
const _bookIndexes = [0, 1, 2, 3, 4, 5];

final stories = <Story>[
  // ----- the brand -----
  Story(
    group: 'Marque',
    name: 'Logo',
    build: (context, knobs) => CmfiLogo(
      size: knobs.slider('Taille', initial: 120, min: 24, max: 240),
      disc: knobs.boolean('Médaillon (fond sombre)'),
    ),
  ),
  Story(
    group: 'Marque',
    name: "Icône de l'app",
    build: (context, knobs) {
      final size = knobs.slider('Taille', initial: 200, min: 40, max: 320);
      return ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.225),
        child: CustomPaint(
          size: Size.square(size),
          painter: AppIconPainter(dev: knobs.boolean('Version dev')),
        ),
      );
    },
  ),
  Story(
    group: 'Marque',
    name: 'Nom « CMFI Connect »',
    build: (context, knobs) {
      final onDark = knobs.boolean('Sur fond sombre');
      return Container(
        padding: const EdgeInsets.all(16),
        color: onDark ? AppColors.primaryDeep : null,
        child: CmfiWordmark(
          fontSize: knobs.slider('Taille', initial: 30, min: 14, max: 60),
          onDark: onDark,
        ),
      );
    },
  ),
  Story(
    group: 'Marque',
    name: 'Anneau décoratif',
    build: (context, knobs) => BrandRing(
      size: 220,
      color: Theme.of(context).colorScheme.primary,
      strokeWidth: knobs.slider('Épaisseur', initial: 10, min: 2, max: 24),
    ),
  ),
  Story(
    group: 'Marque',
    name: 'Zoé, la colombe',
    build: (context, knobs) => DoveMascot(
      pose: knobs.options(
        'Humeur',
        values: DovePose.values,
        name: (pose) => pose.name,
      ),
      size: knobs.slider('Taille', initial: 160, min: 40, max: 300),
    ),
  ),

  // ----- the basics -----
  Story(
    group: 'Éléments de base',
    name: 'Pastille',
    build: (context, knobs) => StatusPill(
      knobs.text('Texte', initial: 'Tu es son faiseur de disciples'),
    ),
  ),
  Story(
    group: 'Éléments de base',
    name: 'Carte de section',
    build: (context, knobs) {
      final rows = knobs.slider(
        'Lignes',
        initial: 3,
        min: 1,
        max: 6,
        divisions: 5,
      );
      return SizedBox(
        width: 340,
        child: SectionCard(
          header: knobs.boolean('Titre', initial: true)
              ? 'Mes autorités'
              : null,
          children: [
            for (var i = 1; i <= rows; i++)
              ListTile(
                title: Text('Ligne $i'),
                subtitle: const Text('Un détail'),
              ),
          ],
        ),
      );
    },
  ),
  Story(
    group: 'Éléments de base',
    name: "Code d'un élément",
    build: (context, knobs) => CodeChip(
      code: knobs.text('Code', initial: 'LB'),
      personal: knobs.boolean('Élément personnel'),
      filled: knobs.boolean('Rempli', initial: true),
    ),
  ),
  Story(
    group: 'Éléments de base',
    name: 'Anneau des objectifs',
    build: (context, knobs) {
      final value = knobs.slider('Atteint', initial: 0.6, min: 0, max: 1);
      return GoalRing(
        value: value,
        label: '${(value * 100).round()} %',
        size: knobs.slider('Taille', initial: 96, min: 40, max: 180),
      );
    },
  ),

  // ----- the report -----
  Story(
    group: 'Compte rendu',
    name: 'Carte de série',
    build: (context, knobs) => SizedBox(
      width: 300,
      child: StreakCard(
        days: knobs.options(
          'Jours de suite',
          values: const [7, 30, 100, 365],
          name: (days) => '$days',
        ),
      ),
    ),
  ),

  // ----- the steps of the way -----
  Story(
    group: 'Mes étapes',
    name: "Médaille d'étape",
    build: (context, knobs) => StepMedal(
      step: knobs.options(
        'Étape',
        values: JourneyStep.values,
        name: (step) => step.name,
      ),
      reached: knobs.boolean('Atteinte', initial: true),
      size: knobs.slider('Taille', initial: 84, min: 32, max: 160),
    ),
  ),

  // ----- the hymns -----
  Story(
    group: 'Cantiques',
    name: 'Couverture de recueil',
    build: (context, knobs) => BookCover(
      book: _book,
      colors: bookCoverColors(
        knobs.options(
          'Couleur',
          values: _bookIndexes,
          name: (index) => '${index + 1}',
        ),
      ),
      size: knobs.slider('Taille', initial: 180, min: 52, max: 280),
    ),
  ),
  Story(
    group: 'Cantiques',
    name: 'Ligne de cantique',
    build: (context, knobs) => SizedBox(
      width: 380,
      child: HymnTile(
        hymn: _book.hymns.first,
        onTap: () {},
        favorite: knobs.boolean('Favori'),
        current: knobs.boolean('Ouvert en dernier'),
        numberColor:
            knobs.boolean('Grand numéro (couleur du recueil)', initial: true)
            ? bookCoverColors(0).first
            : null,
      ),
    ),
  ),
  Story(
    group: 'Cantiques',
    name: 'Carte de paroles',
    build: (context, knobs) {
      final colors = lyricsCardColors(bookCoverColors(0));
      return LyricsCard(
        book: _book,
        bookColors: bookCoverColors(0),
        hymn: _book.hymns.first,
        lines: _lines
            .take(
              knobs
                  .slider('Lignes', initial: 3, min: 1, max: 4, divisions: 3)
                  .round(),
            )
            .toList(),
        color: knobs.options(
          'Couleur',
          values: colors,
          name: (color) => '${colors.indexOf(color) + 1}',
        ),
      );
    },
  ),
  Story(
    group: 'Cantiques',
    name: 'Choix du fond',
    build: (context, knobs) => SizedBox(
      width: 80,
      child: ReaderThemeSwatch(
        theme: knobs.options(
          'Fond',
          values: ReaderTheme.values,
          name: (theme) => theme.name,
        ),
        name: 'Fond',
        selected: knobs.boolean('Choisi', initial: true),
        onTap: () {},
      ),
    ),
  ),
];
