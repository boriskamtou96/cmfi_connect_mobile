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
import 'widgets/teaching_widgets.dart';

/// Plus › Communauté › Enseignements: the audio messages of the community,
/// the newest first; a search on their words (the speaker's name too), a
/// chip per category and « Téléchargés », the next page at the end of the
/// list. Without network, the messages kept on the phone. The one heard now
/// stays at the foot of the screen.
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
    final category = useState('');
    final onlyKept = category.value == _downloaded;
    final provider = teachingsProvider(search, onlyKept ? '' : category.value);
    final teachings = ref.watch(provider);
    final categories = ref.watch(teachingCategoriesProvider).value ?? const [];
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
      AsyncValue(value: final state?) when state.items.isEmpty => _Message(
        text: search.isEmpty && category.value.isEmpty ? t.empty : t.none,
      ),
      AsyncValue(value: final state?) => _List(
        items: state.items,
        hasMore: state.hasMore,
        loadingMore: state.loadingMore,
        onEnd: () => ref.read(provider.notifier).loadMore(),
      ),
      // without network: what is kept on the phone
      AsyncValue(error: _?) when kept.isNotEmpty => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _OfflineNote(text: t.offline),
          const SizedBox(height: AppSpacing.md),
          _List(items: keptMatching(), empty: t.none),
        ],
      ),
      AsyncValue(:final error?) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(provider),
      ),
      _ => const LoadingList(count: 6, card: false),
    };

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
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
              await ref.read(provider.notifier).refresh();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _Header(controller: controller)),
                if (categories.isNotEmpty || kept.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _Chips(
                      categories: categories,
                      withDownloaded: kept.isNotEmpty,
                      selected: category.value,
                      onSelect: (name) => category.value = name,
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

/// Night blue, like Nos documents: the title and the search.
class _Header extends StatelessWidget {
  const _Header({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final t = context.t.teachings;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryDeep,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xs,
            AppSpacing.xs,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconTheme(
                data: IconThemeData(color: Colors.white),
                child: AppBackButton(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: AppSpacing.md),
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
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      t.subtitle,
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: AppColors.goldLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TextField(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(color: AppColors.ink),
                      decoration: InputDecoration(
                        hintText: t.search,
                        filled: true,
                        fillColor: Colors.white,
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
                  ],
                ),
              ),
            ],
          ),
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
        AppSpacing.lg,
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
          for (final category in categories) chip(category.name, category.name),
        ],
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
