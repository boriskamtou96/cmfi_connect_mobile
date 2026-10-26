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
/// the newest first; a search on their words (the speaker's name too), a
/// chip per category, the advanced filters (speaker, year, annual edition,
/// day of it) and « Téléchargés », the next page at the end of the list.
/// Without network, the messages kept on the phone. The one heard now stays
/// at the foot of the screen.
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
    final facets = ref
        .watch(teachingFacetsProvider(chosen.value.edition))
        .value;
    final kept = ref.watch(teachingDownloadsProvider).value?.kept ?? const {};

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
        builder: (_) => _FiltersSheet(initial: chosen.value),
      );
      if (result != null) {
        chosen.value = result;
      }
    }

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
                    activeFilters: chosen.value.filterCount,
                    onFilters: openFilters,
                  ),
                ),
                if (categories.isNotEmpty || kept.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _Chips(
                      categories: categories,
                      withDownloaded: kept.isNotEmpty,
                      selected: chosen.value.category,
                      onSelect: (value) =>
                          chosen.value = chosen.value.copyWith(category: value),
                    ),
                  ),
                if (chosen.value.edition != null &&
                    (facets?.days.isNotEmpty ?? false))
                  SliverToBoxAdapter(
                    child: _Days(
                      days: facets!.days,
                      selected: chosen.value.day,
                      onSelect: (day) =>
                          chosen.value = chosen.value.copyWith(day: day),
                    ),
                  ),
                if (chosen.value.speaker.isNotEmpty ||
                    chosen.value.year != null ||
                    chosen.value.edition != null ||
                    chosen.value.day != null)
                  SliverToBoxAdapter(
                    child: _ActiveFilters(
                      query: chosen.value,
                      facets: facets,
                      onChanged: (next) => chosen.value = next,
                    ),
                  ),
                if (teachings.value case final state?
                    when state.total > 0 && !onlyKept)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.xl,
                        AppSpacing.md,
                        AppSpacing.xl,
                        AppSpacing.xs,
                      ),
                      child: Text(
                        t.count(n: state.total),
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

/// A slim bar on the light background: the back arrow, the title and the
/// filters; the search below, without the tall night-blue header.
class _Header extends StatelessWidget {
  const _Header({
    required this.controller,
    required this.activeFilters,
    required this.onFilters,
  });

  final TextEditingController controller;
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
          AppSpacing.lg,
          AppSpacing.sm,
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
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppSpacing.sm,
                end: AppSpacing.sm,
              ),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: t.search,
                  filled: true,
                  fillColor: scheme.surface,
                  prefixIcon: const Icon(
                    AppIcons.search,
                    color: AppColors.muted,
                  ),
                  suffixIcon: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, _) => value.text.isEmpty
                        ? const SizedBox.shrink()
                        : IconButton(
                            tooltip: MaterialLocalizations.of(
                              context,
                            ).deleteButtonTooltip,
                            onPressed: controller.clear,
                            icon: const Icon(
                              AppIcons.close,
                              color: AppColors.muted,
                            ),
                          ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    borderSide: BorderSide.none,
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
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          chip(t.all, ''),
          if (withDownloaded)
            chip(
              t.downloadedChip,
              TeachingsScreen._downloaded,
              icon: AppIcons.downloaded,
            ),
          for (final category in categories)
            chip(
              category.name,
              category.slug.isEmpty ? category.name : category.slug,
            ),
        ],
      ),
    );
  }
}

/// The days of the edition chosen: « Tous les jours », then day 1, 2… with
/// how many messages each (several may share a day).
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
    final tone = AppModule.reports.tone(context);

    Widget chip(String label, int? value) => Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: ChoiceChip(
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
          chip(t.allDays, null),
          for (final day in days) chip(t.dayChip(n: day.day), day.day),
        ],
      ),
    );
  }
}

/// The advanced filters in force, each one removed by a tap; « Tout
/// effacer » drops them all.
class _ActiveFilters extends StatelessWidget {
  const _ActiveFilters({
    required this.query,
    required this.facets,
    required this.onChanged,
  });

  final TeachingQuery query;
  final TeachingFacets? facets;
  final ValueChanged<TeachingQuery> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t.teachings;
    final edition = query.edition == null
        ? null
        : facets?.editions.where((one) => one.id == query.edition).firstOrNull;

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
          if (query.edition != null)
            chip(
              edition?.title.isNotEmpty == true
                  ? edition!.title
                  : '${edition?.categoryName ?? ''} ${edition?.year ?? ''}'
                        .trim(),
              () => onChanged(query.copyWith(edition: null, day: null)),
            ),
          if (query.day != null)
            chip(
              t.dayChip(n: query.day!),
              () => onChanged(query.copyWith(day: null)),
            ),
          TextButton(
            onPressed: () => onChanged(query.withoutAdvanced),
            child: Text(t.clearFilters),
          ),
        ],
      ),
    );
  }
}

/// The bottom sheet of the advanced filters: a speaker, a year, an edition
/// and, once an edition is chosen, one of its days.
class _FiltersSheet extends HookConsumerWidget {
  const _FiltersSheet({required this.initial});

  final TeachingQuery initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final draft = useState(initial);
    // the speakers, the years and the editions never depend on the edition;
    // only its days do (the lists stay while those load)
    final base =
        ref.watch(teachingFacetsProvider(null)).value ?? const TeachingFacets();
    final days = draft.value.edition == null
        ? const <TeachingDayFacet>[]
        : ref.watch(teachingFacetsProvider(draft.value.edition)).value?.days ??
              const <TeachingDayFacet>[];

    /// "Théodore Andoseh (2)"; the name alone while the counts load.
    String counted(String label, int? count) =>
        count != null && count > 0 ? '$label ($count)' : label;

    Widget dropdown<T>({
      required String label,
      required T value,
      required List<DropdownMenuItem<T>> items,
      required ValueChanged<T> onChanged,
    }) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: DropdownButtonFormField<T>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(labelText: label),
        items: items,
        onChanged: (next) {
          if (next != null) {
            onChanged(next);
          }
        },
      ),
    );

    // a value kept while the lists load, so the form never loses it
    final speakerNames = [
      for (final speaker in base.speakers) speaker.name,
      if (draft.value.speaker.isNotEmpty &&
          !base.speakers.any((one) => one.name == draft.value.speaker))
        draft.value.speaker,
    ];
    final years = <int>[for (final year in base.years) year.year];
    final chosenYear = draft.value.year;
    if (chosenYear != null && !years.contains(chosenYear)) {
      years.add(chosenYear);
    }
    final editions = <({int id, String title})>[
      for (final edition in base.editions)
        (
          id: edition.id,
          title: edition.title.isNotEmpty
              ? edition.title
              : '${edition.categoryName} ${edition.year}'.trim(),
        ),
    ];
    final chosenEdition = draft.value.edition;
    if (chosenEdition != null &&
        !editions.any((one) => one.id == chosenEdition)) {
      editions.add((
        id: chosenEdition,
        title: '${t.editionLabel} $chosenEdition',
      ));
    }
    final dayNumbers = <int>[for (final day in days) day.day];
    final chosenDay = draft.value.day;
    if (chosenDay != null && !dayNumbers.contains(chosenDay)) {
      dayNumbers.add(chosenDay);
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xl,
          0,
          AppSpacing.xl,
          AppSpacing.xl + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.filtersTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.lg),
            dropdown<String>(
              label: t.speakerLabel,
              value: draft.value.speaker,
              items: [
                DropdownMenuItem(value: '', child: Text(t.allSpeakers)),
                for (final name in speakerNames)
                  DropdownMenuItem(
                    value: name,
                    child: Text(
                      counted(
                        name,
                        base.speakers
                            .where((one) => one.name == name)
                            .firstOrNull
                            ?.count,
                      ),
                    ),
                  ),
              ],
              onChanged: (value) =>
                  draft.value = draft.value.copyWith(speaker: value),
            ),
            dropdown<String>(
              label: t.yearLabel,
              value: draft.value.year == null ? '' : '${draft.value.year}',
              items: [
                DropdownMenuItem(value: '', child: Text(t.allYears)),
                for (final year in years)
                  DropdownMenuItem(
                    value: '$year',
                    child: Text(
                      counted(
                        '$year',
                        base.years
                            .where((one) => one.year == year)
                            .firstOrNull
                            ?.count,
                      ),
                    ),
                  ),
              ],
              onChanged: (value) => draft.value = draft.value.copyWith(
                year: value.isEmpty ? null : int.tryParse(value),
              ),
            ),
            dropdown<String>(
              label: t.editionLabel,
              value: draft.value.edition == null
                  ? ''
                  : '${draft.value.edition}',
              items: [
                DropdownMenuItem(value: '', child: Text(t.allEditions)),
                for (final edition in editions)
                  DropdownMenuItem(
                    value: '${edition.id}',
                    child: Text(edition.title),
                  ),
              ],
              onChanged: (value) => draft.value = draft.value.copyWith(
                edition: value.isEmpty ? null : int.tryParse(value),
                // the day belongs to an edition
                day: null,
              ),
            ),
            if (draft.value.edition != null && dayNumbers.isNotEmpty)
              dropdown<String>(
                label: t.dayLabel,
                value: draft.value.day == null ? '' : '${draft.value.day}',
                items: [
                  DropdownMenuItem(value: '', child: Text(t.allDays)),
                  for (final day in dayNumbers)
                    DropdownMenuItem(
                      value: '$day',
                      child: Text(
                        counted(
                          t.dayChip(n: day),
                          days
                              .where((one) => one.day == day)
                              .firstOrNull
                              ?.count,
                        ),
                      ),
                    ),
                ],
                onChanged: (value) => draft.value = draft.value.copyWith(
                  day: value.isEmpty ? null : int.tryParse(value),
                ),
              ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => draft.value = draft.value.withoutAdvanced,
                    child: Text(t.clearFilters),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(draft.value),
                    child: Text(t.showResults),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    required this.items,
    this.empty,
    this.hasMore = false,
    this.loadingMore = false,
    this.onEnd,
  });

  final List<Teaching> items;
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
            for (final teaching in items) TeachingRow(teaching: teaching),
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
