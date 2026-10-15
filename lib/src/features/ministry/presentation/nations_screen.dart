import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/countries.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../application/land.dart';
import '../application/nations.dart';
import '../domain/nation.dart';
import 'widgets/nation_globe.dart';

/// The name of [nation] in the app language: a country by its code, a
/// region (Écosse…) as the list writes it.
String nationName(Nation nation, String language) =>
    Country.tryCode(nation.countryCode)?.name(language) ?? nation.name;

/// How long the journey stays on each nation.
const journeyStep = Duration(seconds: 3);

/// The nations of our ministry on a globe (a journey from one to the next,
/// in the order the ministry reached them), then the list.
@RoutePage()
class NationsScreen extends HookConsumerWidget {
  const NationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nations = ref.watch(nationsProvider);
    final land = ref.watch(landDotsProvider).value ?? const [];
    final selected = useState<int?>(null);
    final journey = useState(false);
    final scroll = useScrollController();

    final list = nations.value ?? const <Nation>[];

    // the journey: one nation after another, then again from the first
    useEffect(() {
      if (!journey.value || list.isEmpty) {
        return null;
      }
      void next() =>
          selected.value = ((selected.value ?? -1) + 1) % list.length;
      next();
      final timer = Timer.periodic(journeyStep, (_) => next());
      return timer.cancel;
    }, [journey.value, list.length]);

    void select(int index) {
      journey.value = false;
      selected.value = index;
    }

    void step(int delta) {
      if (list.isEmpty) {
        return;
      }
      select(((selected.value ?? 0) + delta) % list.length);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: switch (nations) {
          AsyncValue(value: final _?) => CustomScrollView(
            controller: scroll,
            slivers: [
              SliverToBoxAdapter(
                child: _Hero(
                  nations: list,
                  land: land,
                  selected: selected.value,
                  journey: journey.value,
                  onSelect: select,
                  onDrag: () => journey.value = false,
                  onToggleJourney: () => journey.value = !journey.value,
                  onStep: step,
                ),
              ),
              const SliverToBoxAdapter(child: _ListTitle()),
              _NationList(
                nations: list,
                onTap: (index) {
                  select(index);
                  scroll.animateTo(
                    0,
                    duration: AppMotion.of(context, AppMotion.slow),
                    curve: AppMotion.standard,
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
            ],
          ),
          AsyncError(:final error) => SafeArea(
            child: ErrorView(
              error: error,
              onRetry: () => ref.invalidate(nationsProvider),
            ),
          ),
          // the title, the globe, then the nations
          _ => const SafeArea(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: kToolbarHeight,
                bottom: AppSpacing.xl,
              ),
              child: Shimmer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SkeletonLine(widthFactor: 0.55, height: 24),
                          SizedBox(height: AppSpacing.sm),
                          SkeletonLine(widthFactor: 0.4),
                          SizedBox(height: AppSpacing.xl),
                          Center(child: SkeletonBox(height: 300, circle: true)),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSpacing.xl),
                    SkeletonList(count: 6, leading: 24, lines: 1, card: false),
                  ],
                ),
              ),
            ),
          ),
        },
      ),
    );
  }
}

/// Night blue, like the splash: the globe, the journey and the nation shown.
class _Hero extends StatelessWidget {
  const _Hero({
    required this.nations,
    required this.land,
    required this.selected,
    required this.journey,
    required this.onSelect,
    required this.onDrag,
    required this.onToggleJourney,
    required this.onStep,
  });

  final List<Nation> nations;
  final List<dynamic> land;
  final int? selected;
  final bool journey;
  final ValueChanged<int> onSelect;
  final VoidCallback onDrag;
  final VoidCallback onToggleJourney;
  final ValueChanged<int> onStep;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;
    final index = selected;
    final nation = index == null ? null : nations[index];

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.primaryDeep,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -80,
            top: -60,
            child: BrandRing(
              size: 240,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xs,
                AppSpacing.xs,
                AppSpacing.xs,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: IconTheme(
                      data: IconThemeData(color: Colors.white),
                      child: AppBackButton(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          header: true,
                          child: Text(
                            t.title,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          t.tagline,
                          style: const TextStyle(
                            fontFamily: 'Lora',
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: AppColors.goldLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: NationGlobe(
                          nations: nations,
                          land: land.cast(),
                          selected: selected,
                          onSelect: onSelect,
                          onDrag: onDrag,
                          semanticLabel: t.globeLabel(n: nations.length),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    t.dragHint,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.onPrimaryMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _JourneyControls(
                    journey: journey,
                    onToggle: onToggleJourney,
                    onStep: onStep,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    // the card of the nation shown, or the count
                    child: AnimatedSwitcher(
                      duration: AppMotion.of(context, AppMotion.medium),
                      switchInCurve: AppMotion.standard,
                      child: KeyedSubtree(
                        key: ValueKey(nation?.id),
                        child: nation == null
                            ? _Count(total: nations.length)
                            : _NationCard(nation: nation),
                      ),
                    ),
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

class _JourneyControls extends StatelessWidget {
  const _JourneyControls({
    required this.journey,
    required this.onToggle,
    required this.onStep,
  });

  final bool journey;
  final VoidCallback onToggle;
  final ValueChanged<int> onStep;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: t.previous,
          color: Colors.white,
          onPressed: () => onStep(-1),
          icon: const Icon(AppIcons.chevronLeft),
        ),
        const SizedBox(width: AppSpacing.sm),
        FilledButton.icon(
          onPressed: onToggle,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.gold,
            foregroundColor: AppColors.ink,
            minimumSize: const Size(140, 48),
            textStyle: const TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          icon: Icon(
            journey ? AppIcons.journeyPause : AppIcons.journeyPlay,
            size: 18,
          ),
          label: Text(journey ? t.pause : t.voyage),
        ),
        const SizedBox(width: AppSpacing.sm),
        IconButton(
          tooltip: t.next,
          color: Colors.white,
          onPressed: () => onStep(1),
          icon: const Icon(AppIcons.chevronRight),
        ),
      ],
    );
  }
}

/// No nation picked yet: how many, and where it all started.
class _Count extends StatelessWidget {
  const _Count({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;

    return Column(
      children: [
        Text(
          t.count(n: total),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          t.fromYaounde,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: AppColors.onPrimaryMuted),
        ),
      ],
    );
  }
}

/// The nation shown: flag, name, number in the list, year, and a prayer.
class _NationCard extends StatelessWidget {
  const _NationCard({required this.nation});

  final Nation nation;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;
    final language = TranslationProvider.of(context).locale.languageCode;
    final country = Country.tryCode(nation.countryCode);
    final name = nationName(nation, language);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Row(
        children: [
          ExcludeSemantics(
            child: country == null
                ? const Icon(AppIcons.region, color: Colors.white, size: 30)
                : Text(country.flag, style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  [
                    t.number(n: nation.position),
                    if (nation.arrivalYear case final year?)
                      t.since(year: year),
                  ].join(' · '),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.onPrimaryMuted,
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () => _showPrayer(context, name),
            style: TextButton.styleFrom(foregroundColor: AppColors.goldLight),
            icon: const Icon(AppIcons.prayer, size: 18),
            label: Text(t.pray),
          ),
        ],
      ),
    );
  }
}

/// Three points to pray for a nation.
Future<void> _showPrayer(BuildContext context, String country) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        final t = context.t.ministry;
        final scheme = Theme.of(context).colorScheme;
        final points = [
          t.prayThanks(country: country),
          t.prayAssemblies(country: country),
          t.prayUnreached(country: country),
        ];
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xl,
              0,
              AppSpacing.xl,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t.prayTitle(country: country),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                for (final (i, point) in points.indexed)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: scheme.primaryContainer,
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: scheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            point,
                            style: const TextStyle(fontSize: 15, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(context.t.common.close),
                ),
              ],
            ),
          ),
        );
      },
    );

class _ListTitle extends StatelessWidget {
  const _ListTitle();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.xl,
      AppSpacing.lg,
      AppSpacing.sm,
    ),
    child: SectionLabel(context.t.ministry.nations),
  );
}

/// Every nation, numbered, with a search; a touch shows it on the globe.
class _NationList extends HookWidget {
  const _NationList({required this.nations, required this.onTap});

  final List<Nation> nations;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;
    final scheme = Theme.of(context).colorScheme;
    final language = TranslationProvider.of(context).locale.languageCode;
    final query = useState('');
    final wanted = foldForSearch(query.value);
    final shown = [
      for (final (i, nation) in nations.indexed)
        if (wanted.isEmpty ||
            foldForSearch(nationName(nation, language)).contains(wanted) ||
            foldForSearch(nation.name).contains(wanted))
          i,
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      sliver: SliverList.builder(
        itemCount: shown.length + 1,
        itemBuilder: (context, row) {
          if (row == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    onChanged: (value) => query.value = value,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: t.search,
                      prefixIcon: const Icon(AppIcons.search, size: 20),
                    ),
                  ),
                  if (shown.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        t.none,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    ),
                ],
              ),
            );
          }
          final index = shown[row - 1];
          final nation = nations[index];
          final country = Country.tryCode(nation.countryCode);
          return InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: 10,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: Text(
                      '${nation.position}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurfaceVariant,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                  ExcludeSemantics(
                    child: SizedBox(
                      width: 32,
                      child: country == null
                          ? Icon(
                              AppIcons.region,
                              size: 20,
                              color: scheme.onSurfaceVariant,
                            )
                          : Text(
                              country.flag,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(fontSize: 20),
                            ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      nationName(nation, language),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (nation.arrivalYear case final year?)
                    Text(
                      t.since(year: year),
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
