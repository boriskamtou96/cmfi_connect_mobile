import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../application/disciples.dart';
import '../domain/disciple.dart';

/// Plus › Mes disciples: the members who chose the user as disciple maker or
/// as another authority, each with how regular they are; a touch opens their
/// reports (never their note), when they share them. A search on top, then
/// the list, 20 at a time as it scrolls.
@RoutePage()
class DisciplesScreen extends HookConsumerWidget {
  const DisciplesScreen({super.key});

  /// Typing waits this long before asking the server.
  static const _searchDelay = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;
    final searchController = useTextEditingController();
    final typed = useValueListenable(searchController).text;
    final search = useState('');
    useEffect(() {
      final timer = Timer(_searchDelay, () => search.value = typed.trim());
      return timer.cancel;
    }, [typed]);

    final list = disciplesListProvider(search: search.value);
    final first = ref.watch(list);

    Future<void> refresh() async {
      ref.invalidate(list);
      await ref.read(list.future).then((_) {}, onError: (Object _) {});
    }

    final searchField = Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: t.searchHint,
          prefixIcon: const Icon(AppIcons.search),
          suffixIcon: typed.isEmpty
              ? null
              : IconButton(
                  tooltip: MaterialLocalizations.of(
                    context,
                  ).deleteButtonTooltip,
                  icon: const Icon(AppIcons.close),
                  onPressed: searchController.clear,
                ),
        ),
      ),
    );

    // nobody at all: no search to offer
    if (first case AsyncData(
      value: (items: [], total: 0),
    ) when search.value.isEmpty && typed.isEmpty) {
      return SubPage(title: t.title, child: const _Empty());
    }

    return SubPage(
      title: t.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          searchField,
          Expanded(
            child: switch (first) {
              AsyncData(value: (items: [], total: 0)) => Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  t.noMatch(search: search.value),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              AsyncData(value: (:final items, :final total)) =>
                RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.separated(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.lg,
                      0,
                      AppSpacing.lg,
                      AppSpacing.xl,
                    ),
                    // one more at the end while there are more to load
                    itemCount: items.length + (items.length < total ? 1 : 0),
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      if (index < items.length) {
                        return _DiscipleCard(disciple: items[index]);
                      }
                      // the end reached: the next page
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => ref.read(list.notifier).loadMore(),
                      );
                      return const _CardSkeleton();
                    },
                  ),
                ),
              AsyncError(:final error) => ErrorView(
                error: error,
                onRetry: () => ref.invalidate(list),
              ),
              _ => ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                children: [
                  for (var i = 0; i < 4; i++) ...[
                    const _CardSkeleton(),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
              ),
            },
          ),
        ],
      ),
    );
  }
}

/// Nobody chose the user yet: what this page is for.
class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DoveMascot(pose: DovePose.rest, size: 104),
            const SizedBox(height: AppSpacing.lg),
            Text(
              t.empty,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.emptyText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A disciple's card while it loads: the picture, the name, the role.
class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Shimmer(
          child: Row(
            children: [
              SkeletonBox(height: 44, circle: true),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLine(widthFactor: 0.55, height: 14),
                    SizedBox(height: 8),
                    SkeletonLine(widthFactor: 0.75, height: 11),
                    SizedBox(height: 10),
                    SkeletonBox(width: 150, height: 22, radius: 999),
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

/// A disciple: picture, name, pseudo and church, and what the user is to
/// them; a touch opens their reports (or says they don't share them).
class _DiscipleCard extends StatelessWidget {
  const _DiscipleCard({required this.disciple});

  final Disciple disciple;

  @override
  Widget build(BuildContext context) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final member = disciple.member;
    final shares = disciple.regularity != null;

    return SectionCard(
      children: [
        InkWell(
          onTap: !shares
              ? null
              : () => context.router.push(
                  DiscipleReportsRoute(
                    authorityId: disciple.authorityId,
                    name: member.fullName,
                  ),
                ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                MemberAvatar(
                  initials: member.initials,
                  photo: member.avatar,
                  size: 44,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        [
                          '@${member.username}',
                          if (member.place.isNotEmpty) member.place,
                        ].join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // what the user is to them
                      StatusPill(
                        disciple.isDiscipleMaker
                            ? t.roleMaker
                            : t.roleAuthority,
                        background: disciple.isDiscipleMaker
                            ? tones.personalSoft
                            : null,
                        foreground: disciple.isDiscipleMaker
                            ? tones.personal
                            : null,
                      ),
                      if (!shares) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              AppIcons.private,
                              size: 14,
                              color: scheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                t.notShared,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                if (shares)
                  Icon(AppIcons.chevronRight, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
