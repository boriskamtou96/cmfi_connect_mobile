import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../application/teaching_library.dart';
import '../application/teachings.dart';
import '../domain/teaching.dart';
import '../domain/teaching_query.dart';
import 'widgets/teaching_widgets.dart';

/// Plus › Communauté › Enseignements: the audio messages of the community,
/// like the episodes of a podcast. A chip per category (its latest edition
/// opens, as a season: its card, « Reprendre », its days as tabs), «
/// Téléchargés », the search behind the magnifier, the advanced filters
/// (speaker, year, edition, day) in a sheet, the next page at the end of
/// the list. Without network, the messages kept on the phone. The one heard
/// now stays at the foot of the screen.
@RoutePage()
class TeachingsScreen extends HookConsumerWidget {
  const TeachingsScreen({super.key});

  /// The chip of the messages kept on the phone (not a category).
  static const _downloaded = '\u0000downloaded';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final controller = useTextEditingController();
    final typed = useValueListenable(controller).text.trim();
    final search = useDebounced(typed, const Duration(milliseconds: 300)) ?? '';
    final searching = useState(false);
    // the category and the advanced filters, kept apart from the typing
    final chosen = useState(const TeachingQuery());
    final onlyKept = chosen.value.category == _downloaded;
    final query = chosen.value.copyWith(
      search: search,
      category: onlyKept ? '' : chosen.value.category,
    );
    final provider = teachingsProvider(query);
    final teachings = ref.watch(provider);
    final categories = ref.watch(teachingCategoriesProvider).value ?? const [];
    final base = ref.watch(teachingFacetsProvider(null)).value;
    final facets = ref
        .watch(teachingFacetsProvider(chosen.value.edition))
        .value;
    final kept = ref.watch(teachingDownloadsProvider).value?.kept ?? const {};
    final edition = chosen.value.edition == null || onlyKept
        ? null
        : base?.editions
              .where((one) => one.id == chosen.value.edition)
              .firstOrNull;

    // the messages kept, newest first, that answer the search
    List<Teaching> keptMatching() {
      final words = search.toLowerCase().split(' ').where((w) => w.isNotEmpty);
      return [
        for (final teaching in kept.values.toList().reversed)
          if (words.every(
            (word) =>
                '${teaching.title} ${teaching.speaker} ${teaching.category}'
                    .toLowerCase()
                    .contains(word),
          ))
            teaching,
      ];
    }

    /// The editions of a category, the latest first.
    List<TeachingEditionFacet> editionsOf(String category) => [
      for (final one in base?.editions ?? const <TeachingEditionFacet>[])
        if (category.isNotEmpty &&
            (one.categorySlug == category || one.categoryName == category))
          one,
    ]..sort((a, b) => b.year != a.year ? b.year - a.year : b.id - a.id);

    // a category whose messages all belong to editions opens the latest
    // one, like a season; otherwise all its messages, none left out
    void selectCategory(String value) {
      final editions = value == _downloaded
          ? const <TeachingEditionFacet>[]
          : editionsOf(value);
      final category = categories
          .where((one) => one.slug == value || one.name == value)
          .firstOrNull;
      final covered =
          category != null &&
          editions.fold(0, (sum, one) => sum + one.count) >= category.count;
      final latest = covered ? editions.firstOrNull : null;
      chosen.value = chosen.value.copyWith(
        category: value,
        edition: latest?.id,
        day: null,
      );
    }

    final body = switch (teachings) {
      _ when onlyKept => _List(items: keptMatching(), empty: t.noneDownloaded),
      // without network: what is kept on the phone, before the list kept
      // (its messages wouldn't play offline)
      AsyncValue(error: _?) when kept.isNotEmpty => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _OfflineNote(text: t.offline),
          const SizedBox(height: AppSpacing.md),
          _List(items: keptMatching(), empty: t.none),
        ],
      ),
      AsyncValue(value: final state?) when state.items.isEmpty => _Message(
        text: query.narrowed ? t.none : t.empty,
      ),
      AsyncValue(value: final state?) => _List(
        items: state.items,
        inEdition: edition != null,
        hasMore: state.hasMore,
        loadingMore: state.loadingMore,
        onEnd: () => ref.read(provider.notifier).loadMore(),
      ),
      AsyncValue(:final error?) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(provider),
      ),
      _ => const LoadingList(count: 6, card: false),
    };

    Future<void> openFilters() async {
      final result = await showModalBottomSheet<TeachingQuery>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        builder: (_) => _FiltersSheet(
          initial: onlyKept
              ? chosen.value.copyWith(category: '')
              : chosen.value,
          search: search,
        ),
      );
      if (result != null) {
        chosen.value = result;
      }
    }

    Future<void> switchEdition(TeachingEditionFacet current) async {
      final category = current.categorySlug.isNotEmpty
          ? current.categorySlug
          : current.categoryName;
      final editions = category.isEmpty
          ? base?.editions ?? const <TeachingEditionFacet>[]
          : editionsOf(category);
      final picked = await showModalBottomSheet<({int? id})>(
        context: context,
        useSafeArea: true,
        showDragHandle: true,
        builder: (_) => _EditionsSheet(editions: editions, current: current.id),
      );
      if (picked != null) {
        chosen.value = chosen.value.copyWith(edition: picked.id, day: null);
      }
    }

    final shown = teachings.value;
    // the edition and its day are in sight on the card and its tabs
    final advanced = [
      chosen.value.speaker.isNotEmpty,
      chosen.value.year != null,
      edition == null && chosen.value.edition != null,
      edition == null && chosen.value.day != null,
    ].where((on) => on).length;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        bottomNavigationBar: const MiniPlayer(),
        body: NotificationListener<ScrollNotification>(
          // near the end: the next page
          onNotification: (notification) {
            final metrics = notification.metrics;
            if (!onlyKept &&
                metrics.axis == Axis.vertical &&
                metrics.pixels > metrics.maxScrollExtent - 400) {
              ref.read(provider.notifier).loadMore();
            }
            return false;
          },
          child: RefreshIndicator.adaptive(
            onRefresh: () async {
              ref.invalidate(teachingCategoriesProvider);
              ref.invalidate(teachingFacetsProvider);
              await ref.read(provider.notifier).refresh();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _Header(
                    controller: controller,
                    searching: searching.value || typed.isNotEmpty,
                    onSearch: () {
                      if (searching.value || typed.isNotEmpty) {
                        controller.clear();
                        searching.value = false;
                      } else {
                        searching.value = true;
                      }
                    },
                    activeFilters: advanced,
                    onFilters: openFilters,
                  ),
                ),
                if (categories.isNotEmpty || kept.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _Chips(
                      categories: categories,
                      withDownloaded: kept.isNotEmpty,
                      selected: chosen.value.category,
                      onSelect: selectCategory,
                    ),
                  ),
                if (edition != null)
                  SliverToBoxAdapter(
                    child: _EditionCard(
                      edition: edition,
                      items: shown?.items ?? const [],
                      complete: shown != null && !shown.hasMore,
                      days: facets?.days.length ?? 0,
                      onEditions: () => switchEdition(edition),
                    ),
                  ),
                if (edition != null && (facets?.days.length ?? 0) > 1)
                  SliverToBoxAdapter(
                    child: _Days(
                      days: facets!.days,
                      selected: chosen.value.day,
                      onSelect: (day) =>
                          chosen.value = chosen.value.copyWith(day: day),
                    ),
                  ),
                if (chosen.value.speaker.isNotEmpty ||
                    chosen.value.year != null)
                  SliverToBoxAdapter(
                    child: _ActiveFilters(
                      query: chosen.value,
                      onChanged: (next) => chosen.value = next,
                    ),
                  ),
                if (shown != null &&
                    shown.total > 0 &&
                    !onlyKept &&
                    edition == null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.xl,
                        AppSpacing.md,
                        AppSpacing.xl,
                        AppSpacing.xs,
                      ),
                      child: Text(
                        t.count(n: shown.total),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.xxl,
                  ),
                  sliver: SliverToBoxAdapter(child: body),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A slim bar on the light background: the back arrow, the title, the
/// magnifier and the filters (their number on them); the search field
/// below once the magnifier is touched.
class _Header extends StatelessWidget {
  const _Header({
    required this.controller,
    required this.searching,
    required this.onSearch,
    required this.activeFilters,
    required this.onFilters,
  });

  final TextEditingController controller;
  final bool searching;
  final VoidCallback onSearch;
  final int activeFilters;
  final VoidCallback onFilters;

  @override
  Widget build(BuildContext context) {
    final t = context.t.teachings;
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.sm,
          AppSpacing.xs,
          AppSpacing.sm,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const AppBackButton(),
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      t.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: searching ? t.searchClose : t.searchOpen,
                  onPressed: onSearch,
                  icon: Icon(searching ? AppIcons.close : AppIcons.search),
                ),
                IconButton(
                  tooltip: t.filters,
                  onPressed: onFilters,
                  icon: Badge(
                    isLabelVisible: activeFilters > 0,
                    label: Text('$activeFilters'),
                    child: Icon(
                      AppIcons.items,
                      color: activeFilters > 0 ? AppColors.primary : null,
                    ),
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: !searching
                  ? const SizedBox(width: double.infinity)
                  : Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.sm,
                        0,
                        AppSpacing.sm,
                        AppSpacing.xs,
                      ),
                      child: TextField(
                        controller: controller,
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: t.search,
                          filled: true,
                          fillColor: scheme.surface,
                          prefixIcon: const Icon(
                            AppIcons.search,
                            color: AppColors.muted,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// « Tous », « Téléchargés » (when some are kept), then a chip per category.
class _Chips extends StatelessWidget {
  const _Chips({
    required this.categories,
    required this.withDownloaded,
    required this.selected,
    required this.onSelect,
  });

  final List<TeachingCategory> categories;
  final bool withDownloaded;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final t = context.t.teachings;
    final tone = AppModule.reports.tone(context);

    Widget chip(String label, String value, {IconData? icon}) => Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: ChoiceChip(
        avatar: icon == null
            ? null
            : Icon(
                icon,
                size: 18,
                color: selected == value ? tone.onSoft : null,
              ),
        label: Text(label),
        selected: selected == value,
        onSelected: (_) => onSelect(value),
        selectedColor: tone.soft,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: selected == value ? tone.onSoft : null,
        ),
        showCheckmark: false,
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          chip(t.all, ''),
          for (final category in categories)
            chip(
              category.name,
              category.slug.isEmpty ? category.name : category.slug,
            ),
          if (withDownloaded)
            chip(
              t.downloadedChip,
              TeachingsScreen._downloaded,
              icon: AppIcons.downloaded,
            ),
        ],
      ),
    );
  }
}

/// "Croisade de prière et de jeûne 2026": the edition as a podcast's
/// season, in night blue: its cover, the speaker, how many messages, days
/// and hours, « Reprendre » (the first message not heard yet) and the other
/// editions.
class _EditionCard extends ConsumerWidget {
  const _EditionCard({
    required this.edition,
    required this.items,
    required this.complete,
    required this.days,
    required this.onEditions,
  });

  final TeachingEditionFacet edition;

  /// The messages of the list, in the order of the days.
  final List<Teaching> items;

  /// Whether [items] hold the whole edition (its total length is known).
  final bool complete;
  final int days;
  final VoidCallback onEditions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    ref.watch(teachingProgressProvider);
    final progress = ref.read(teachingProgressProvider.notifier);
    final title = edition.title.isNotEmpty
        ? edition.title
        : '${edition.categoryName} ${edition.year}'.trim();

    // the speaker heard most, and how many others
    final speakers = <String, int>{};
    for (final teaching in items) {
      if (teaching.speaker.isNotEmpty) {
        speakers.update(teaching.speaker, (n) => n + 1, ifAbsent: () => 1);
      }
    }
    final ranked = speakers.keys.toList()
      ..sort((a, b) => speakers[b]! - speakers[a]!);
    final speaker = switch (ranked.length) {
      0 => '',
      1 => ranked.first,
      _ => t.andOthers(n: ranked.length - 1, name: ranked.first),
    };

    final length = items.fold(
      Duration.zero,
      (sum, teaching) => sum + (teaching.duration ?? Duration.zero),
    );
    final facts = [
      t.count(n: edition.count),
      if (days > 1) t.daysCount(n: days),
      if (complete && length > Duration.zero) durationLabel(context, length),
    ].join(' · ');

    final begun = items.any((one) => progress.fraction(one.id) > 0);
    final next =
        items.where((one) => !progress.finished(one.id)).firstOrNull ??
        items.firstOrNull;
    final cover = items.where((one) => one.cover != null).firstOrNull;

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.night,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cover != null)
            TeachingCover(teaching: cover, size: 92)
          else
            _SeasonArt(
              kind: edition.categoryName,
              year: edition.year,
              size: 92,
            ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (speaker.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      speaker,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        color: AppColors.goldLight,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    facts,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.onPrimaryMuted,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    if (next != null)
                      _CardPill(
                        icon: AppIcons.play,
                        label: begun ? t.resume : t.play,
                        gold: true,
                        onTap: () => openTeaching(context, ref, next),
                      ),
                    _CardPill(
                      icon: AppIcons.chevronDown,
                      label: t.editions,
                      trailing: true,
                      onTap: onEditions,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The cover of an edition without one: night blue, the kind of it in small
/// capitals and the year in gold.
class _SeasonArt extends StatelessWidget {
  const _SeasonArt({
    required this.kind,
    required this.year,
    required this.size,
  });

  final String kind;
  final int year;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    padding: EdgeInsets.all(size * 0.11),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size * 0.17),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, AppColors.primaryDeep],
      ),
      border: Border.all(color: AppColors.goldLight.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (kind.isNotEmpty)
          // its share of the cover, the year always whole
          Flexible(
            child: Text(
              kind.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: size * 0.085,
                height: 1.15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: AppColors.onPrimaryMuted,
              ),
            ),
          ),
        if (year > 0)
          Text(
            '$year',
            style: TextStyle(
              fontSize: size * 0.28,
              height: 1.1,
              fontWeight: FontWeight.w800,
              color: AppColors.goldLight,
            ),
          ),
      ],
    ),
  );
}

/// « ▶ Reprendre » in gold, « Éditions ▾ » in a veil of white.
class _CardPill extends StatelessWidget {
  const _CardPill({
    required this.icon,
    required this.label,
    required this.onTap,
    this.gold = false,
    this.trailing = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool gold;

  /// The icon after the label (a chevron), not before.
  final bool trailing;

  @override
  Widget build(BuildContext context) {
    final color = gold ? AppColors.night : Colors.white;
    final glyph = Icon(icon, size: 14, color: color);
    return Material(
      color: gold ? AppColors.goldLight : Colors.white.withValues(alpha: 0.12),
      shape: const StadiumBorder(),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!trailing) ...[glyph, const SizedBox(width: 6)],
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (trailing) ...[const SizedBox(width: 4), glyph],
            ],
          ),
        ),
      ),
    );
  }
}

/// The editions of the category, the latest first, and all its messages.
class _EditionsSheet extends StatelessWidget {
  const _EditionsSheet({required this.editions, required this.current});

  final List<TeachingEditionFacet> editions;
  final int current;

  @override
  Widget build(BuildContext context) {
    final t = context.t.teachings;
    final scheme = Theme.of(context).colorScheme;

    Widget row({
      required Widget leading,
      required String title,
      String subtitle = '',
      required bool selected,
      required VoidCallback onTap,
    }) => ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      leading: leading,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: subtitle.isEmpty ? null : Text(subtitle),
      trailing: selected
          ? const Icon(AppIcons.check, color: AppColors.primary)
          : null,
      onTap: onTap,
    );

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                0,
                AppSpacing.xl,
                AppSpacing.sm,
              ),
              child: Text(
                t.editions,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            for (final edition in editions)
              row(
                leading: _SeasonArt(kind: '', year: edition.year, size: 40),
                title: edition.title.isNotEmpty
                    ? edition.title
                    : '${edition.categoryName} ${edition.year}'.trim(),
                subtitle: t.count(n: edition.count),
                selected: edition.id == current,
                onTap: () => Navigator.of(context).pop((id: edition.id)),
              ),
            row(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(AppIcons.teachingsTile),
              ),
              title: t.allOfCategory,
              selected: false,
              onTap: () => Navigator.of(context).pop((id: null)),
            ),
          ],
        ),
      ),
    );
  }
}

/// The days of the edition as tabs: « Tous », then day 1, 2…; the one
/// chosen in ink.
class _Days extends StatelessWidget {
  const _Days({
    required this.days,
    required this.selected,
    required this.onSelect,
  });

  final List<TeachingDayFacet> days;
  final int? selected;
  final ValueChanged<int?> onSelect;

  @override
  Widget build(BuildContext context) {
    final t = context.t.teachings;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          _Pill(
            label: t.dayAll,
            selected: selected == null,
            onTap: () => onSelect(null),
          ),
          for (final day in days)
            _Pill(
              label: t.dayChip(n: day.day),
              selected: selected == day.day,
              onTap: () => onSelect(day.day),
            ),
        ],
      ),
    );
  }
}

/// A round tab: ink when chosen, white with a fine line otherwise.
class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: Semantics(
        selected: selected,
        button: true,
        child: Material(
          color: selected ? scheme.onSurface : scheme.surface,
          shape: StadiumBorder(
            side: BorderSide(
              color: selected ? scheme.onSurface : scheme.outlineVariant,
            ),
          ),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: selected ? scheme.surface : scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The speaker and the year in force (the edition and its day have their
/// card and tabs), each removed by a tap; « Tout effacer » drops them all.
class _ActiveFilters extends StatelessWidget {
  const _ActiveFilters({required this.query, required this.onChanged});

  final TeachingQuery query;
  final ValueChanged<TeachingQuery> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t.teachings;

    Widget chip(String label, VoidCallback onDeleted) => Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: InputChip(
        label: Text(label),
        onDeleted: onDeleted,
        deleteIcon: const Icon(AppIcons.close, size: 16),
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          if (query.speaker.isNotEmpty)
            chip(query.speaker, () => onChanged(query.copyWith(speaker: ''))),
          if (query.year != null)
            chip('${query.year}', () => onChanged(query.copyWith(year: null))),
          TextButton(
            onPressed: () => onChanged(query.withoutAdvanced),
            child: Text(t.clearFilters),
          ),
        ],
      ),
    );
  }
}

/// "ZF" for "Pr Zacharias Tanee Fomum": the first and the last name, the
/// titles left aside.
String _initials(String name) {
  const titles = {'pr', 'pasteur', 'dr', 'rév', 'rev', 'frère', 'sœur'};
  final words = [
    for (final word in name.split(RegExp(r'\s+')))
      if (word.isNotEmpty &&
          !titles.contains(word.toLowerCase().replaceAll('.', '')))
        word,
  ];
  if (words.isEmpty) {
    return '';
  }
  final first = words.first.characters.first;
  return words.length == 1
      ? first.toUpperCase()
      : '$first${words.last.characters.first}'.toUpperCase();
}

/// The bottom sheet of the advanced filters, all in sight: the speakers
/// with their initials, the years, the editions as small covers and, once
/// one is chosen, its days; a tap chooses, a second one lets go. The button
/// says how many messages it will show.
class _FiltersSheet extends HookConsumerWidget {
  const _FiltersSheet({required this.initial, required this.search});

  final TeachingQuery initial;

  /// The words typed, for the number on the button.
  final String search;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final scheme = Theme.of(context).colorScheme;
    final draft = useState(initial);
    // the speakers, the years and the editions never depend on the edition;
    // only its days do (the lists stay while those load)
    final base =
        ref.watch(teachingFacetsProvider(null)).value ?? const TeachingFacets();
    final days = draft.value.edition == null
        ? const <TeachingDayFacet>[]
        : ref.watch(teachingFacetsProvider(draft.value.edition)).value?.days ??
              const <TeachingDayFacet>[];
    final total = ref
        .watch(teachingsProvider(draft.value.copyWith(search: search)))
        .value
        ?.total;

    // a value kept while the lists load, so the sheet never loses it
    final speakers = [
      ...base.speakers,
      if (draft.value.speaker.isNotEmpty &&
          !base.speakers.any((one) => one.name == draft.value.speaker))
        TeachingSpeakerFacet(name: draft.value.speaker),
    ];
    final years = [
      ...base.years,
      if (draft.value.year case final year?
          when !base.years.any((one) => one.year == year))
        TeachingYearFacet(year: year),
    ];

    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
          color: scheme.onSurfaceVariant,
        ),
      ),
    );

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                0,
                AppSpacing.xl,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.filtersTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (speakers.isNotEmpty) ...[
                    label(t.speakerLabel),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final speaker in speakers)
                          _FilterChoice(
                            label: speaker.name,
                            count: speaker.count,
                            initials: _initials(speaker.name),
                            selected: draft.value.speaker == speaker.name,
                            onTap: () => draft.value = draft.value.copyWith(
                              speaker: draft.value.speaker == speaker.name
                                  ? ''
                                  : speaker.name,
                            ),
                          ),
                      ],
                    ),
                  ],
                  if (years.isNotEmpty) ...[
                    label(t.yearLabel),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final year in years)
                          _FilterChoice(
                            label: '${year.year}',
                            selected: draft.value.year == year.year,
                            onTap: () => draft.value = draft.value.copyWith(
                              year: draft.value.year == year.year
                                  ? null
                                  : year.year,
                            ),
                          ),
                      ],
                    ),
                  ],
                  if (base.editions.isNotEmpty) ...[
                    label(t.editionLabel),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemCount: base.editions.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          final edition = base.editions[index];
                          final selected = draft.value.edition == edition.id;
                          return _EditionChoice(
                            edition: edition,
                            selected: selected,
                            onTap: () => draft.value = draft.value.copyWith(
                              edition: selected ? null : edition.id,
                              // the day belongs to an edition, the edition
                              // to its category
                              day: null,
                              category: selected
                                  ? null
                                  : edition.categorySlug.isNotEmpty
                                  ? edition.categorySlug
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  if (draft.value.edition != null && days.isNotEmpty) ...[
                    label(t.dayLabel),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final day in days)
                          _FilterChoice(
                            label: t.dayChip(n: day.day),
                            count: day.count,
                            selected: draft.value.day == day.day,
                            onTap: () => draft.value = draft.value.copyWith(
                              day: draft.value.day == day.day ? null : day.day,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: scheme.outlineVariant)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.xl,
                  AppSpacing.md,
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () =>
                          draft.value = draft.value.withoutAdvanced,
                      child: Text(
                        t.clearFilters,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(0, 52),
                        ),
                        onPressed: () => Navigator.of(context).pop(draft.value),
                        child: Text(
                          total == null ? t.showResults : t.showCount(n: total),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A choice of the filters: a pill, the initials of a speaker before his
/// name, how many messages after it.
class _FilterChoice extends StatelessWidget {
  const _FilterChoice({
    required this.label,
    required this.selected,
    required this.onTap,
    this.count = 0,
    this.initials = '',
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final int count;
  final String initials;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.reports.tone(context);
    final ink = selected ? tone.onSoft : scheme.onSurface;

    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? tone.soft : scheme.surface,
        shape: StadiumBorder(
          side: BorderSide(
            width: 1.5,
            color: selected ? tone.onSoft : scheme.outlineVariant,
          ),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              initials.isEmpty ? 14 : 6,
              6,
              14,
              6,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (initials.isNotEmpty) ...[
                  Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.night,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.goldLight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: initials.isEmpty ? 3 : 0,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ink,
                    ),
                  ),
                ),
                if (count > 0) ...[
                  const SizedBox(width: 6),
                  Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// An edition of the filters: its small cover with the year, its name and
/// how many messages.
class _EditionChoice extends StatelessWidget {
  const _EditionChoice({
    required this.edition,
    required this.selected,
    required this.onTap,
  });

  final TeachingEditionFacet edition;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t.teachings;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.reports.tone(context);
    final name = edition.categoryName.isNotEmpty
        ? edition.categoryName
        : edition.title;

    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? tone.soft : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(
            width: 1.5,
            color: selected ? tone.onSoft : scheme.outlineVariant,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: onTap,
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 56,
                  width: double.infinity,
                  alignment: AlignmentDirectional.bottomStart,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.night],
                    ),
                  ),
                  child: Text(
                    edition.year > 0 ? '${edition.year}' : '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.goldLight,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                    color: selected ? tone.onSoft : scheme.onSurface,
                  ),
                ),
                const Spacer(),
                Text(
                  t.count(n: edition.count),
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
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

class _List extends StatelessWidget {
  const _List({
    required this.items,
    this.inEdition = false,
    this.empty,
    this.hasMore = false,
    this.loadingMore = false,
    this.onEnd,
  });

  final List<Teaching> items;
  final bool inEdition;
  final String? empty;
  final bool hasMore;
  final bool loadingMore;
  final VoidCallback? onEnd;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _Message(text: empty ?? context.t.teachings.none);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionCard(
          children: [
            for (final teaching in items)
              TeachingRow(teaching: teaching, inEdition: inEdition),
          ],
        ),
        if (hasMore)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Center(
              child: loadingMore
                  ? const AppSpinner()
                  : TextButton(
                      onPressed: onEnd,
                      child: Text(context.t.teachings.more),
                    ),
            ),
          ),
      ],
    );
  }
}

class _OfflineNote extends StatelessWidget {
  const _OfflineNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.gold.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(AppRadius.lg),
    ),
    child: Row(
      children: [
        const Icon(AppIcons.offline, color: AppColors.gold),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Text(text, style: const TextStyle(height: 1.3))),
      ],
    ),
  );
}

class _Message extends StatelessWidget {
  const _Message({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.reports.tone(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: tone.soft, shape: BoxShape.circle),
            child: Icon(AppIcons.teachingsTile, color: tone.onSoft, size: 34),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
