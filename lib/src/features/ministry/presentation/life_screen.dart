import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_spacing.dart';
import '../domain/ministry_lives.dart';
import 'widgets/portrait_page.dart';

/// Notre ministère › Notre fondateur: the life of Pr Zacharias Tanee Fomum.
@RoutePage()
class FounderScreen extends StatelessWidget {
  const FounderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;
    final life = t.lives.founder;

    return _LifePage(
      label: t.founder,
      life: MinistryLife.founder,
      name: life.name,
      line: life.line,
      facts: life.facts,
      dates: life.dates,
      story: life.story,
    );
  }
}

/// Notre ministère › Notre leader: the life of Théodore Andoseh.
@RoutePage()
class LeaderScreen extends StatelessWidget {
  const LeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;
    final life = t.lives.leader;

    return _LifePage(
      label: t.leader,
      life: MinistryLife.leader,
      name: life.name,
      line: life.line,
      facts: life.facts,
      dates: life.dates,
      story: life.story,
    );
  }
}

class _LifePage extends StatelessWidget {
  const _LifePage({
    required this.label,
    required this.life,
    required this.name,
    required this.line,
    required this.facts,
    required this.dates,
    required this.story,
  });

  final String label;
  final MinistryLife life;
  final String name;
  final String line;
  final List<String> facts;
  final List<String> dates;
  final List<String> story;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;

    return PortraitPage(
      label: label,
      name: name,
      line: line,
      photo: Image.asset(life.asset, fit: BoxFit.cover),
      photoLabel: t.photoOf(name: name),
      facts: [
        for (final (i, value) in life.facts.indexed)
          if (i < facts.length) (value, facts[i]),
      ],
      children: [
        PortraitSection(t.keyDates),
        PortraitDates(
          dates: [
            for (final (i, year) in life.years.indexed)
              if (i < dates.length) (year, dates[i]),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        PortraitSection(t.life),
        PortraitStory(paragraphs: story),
      ],
    );
  }
}
