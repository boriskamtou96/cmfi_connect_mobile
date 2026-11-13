import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/sub_page.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../application/game_path.dart';
import '../application/leaderboard.dart';
import '../domain/game.dart';
import 'widgets/game_chip.dart';

/// The leaderboard of the games: the points of those who chose to appear,
/// this week (it starts again every Monday) or since ever, among all the
/// members or in the member's circle. Pseudos and photos only, never a name.
/// To appear is a choice: asked the first time, changed with the switch at
/// the bottom. Who says no still sees the others.
@RoutePage()
class LeaderboardScreen extends HookConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final period = useState('week');
    final scope = useState('all');
    final player = ref.watch(gamePathProvider).value?.player;
    final board = ref.watch(
      gameLeaderboardProvider(period: period.value, scope: scope.value),
    );
    final asked = useRef(false);

    Future<void> choose({required bool appear}) async {
      final toast = ref.read(toasterProvider).of(context);
      final settings = ref.read(gamePlayerSettingsProvider.notifier);
      if (!await settings.appear(inLeaderboard: appear)) {
        final error = ref.read(gamePlayerSettingsProvider).error;
        toast.error(userMessageFor(error ?? Object(), t));
      }
    }

    // the first time: to appear or not is the member's choice
    final undecided = player != null && player.inLeaderboard == null;
    useEffect(() {
      if (!undecided || asked.value) {
        return null;
      }
      asked.value = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!context.mounted) {
          return;
        }
        final yes = await showConfirmDialog(
          context,
          title: t.games.joinTitle,
          text: t.games.joinText,
          confirmLabel: t.games.joinYes,
          cancelLabel: t.games.joinNo,
        );
        await choose(appear: yes);
      });
      return null;
    }, [undecided]);

    final lines = board.value;
    final mine = lines?.me;
    final listed = lines?.entries.any((entry) => entry.me) ?? false;

    return SubPage(
      title: t.games.leaderboard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: GameChip(
                    title: t.games.week,
                    selected: period.value == 'week',
                    onTap: () => period.value = 'week',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GameChip(
                    title: t.games.ever,
                    selected: period.value == 'all',
                    onTap: () => period.value = 'all',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: GameChip(
                    title: t.games.scopeAll,
                    selected: scope.value == 'all',
                    onTap: () => scope.value = 'all',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GameChip(
                    title: t.games.scopeCircle,
                    selected: scope.value == 'circle',
                    onTap: () => scope.value = 'circle',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: switch (board) {
              AsyncValue(:final value?) when value.entries.isEmpty => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(
                    scope.value == 'circle'
                        ? t.games.boardEmptyCircle
                        : t.games.boardEmpty,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.5,
                      height: 1.35,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              AsyncValue(:final value?) => ListView.builder(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                itemCount: value.entries.length,
                itemBuilder: (context, index) =>
                    _Line(entry: value.entries[index]),
              ),
              AsyncError(:final error) => ErrorView(
                error: error,
                onRetry: () => ref.invalidate(gameLeaderboardProvider),
              ),
              _ => const Center(child: AppSpinner()),
            },
          ),
          // where the member stands, when they are beyond the 50 first
          if (mine != null && !listed)
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                border: Border(top: BorderSide(color: scheme.outlineVariant)),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                child: Row(
                  children: [
                    Text(
                      '${mine.rank}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        t.games.you,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      t.games.pointsLabel(n: mine.points),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          if (player != null)
            SafeArea(
              top: false,
              child: SwitchListTile.adaptive(
                title: Text(
                  t.games.appear,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                value: player.inLeaderboard ?? false,
                onChanged: (value) => choose(appear: value),
              ),
            ),
        ],
      ),
    );
  }
}

/// A line of the leaderboard: the rank (a medal for the first three), the
/// photo, the pseudo, the points.
class _Line extends StatelessWidget {
  const _Line({required this.entry});

  final GameLeaderboardEntry entry;

  static const _medals = [AppColors.gold, Color(0xFF9AA7B5), Color(0xFFB57F4A)];

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final podium = entry.rank >= 1 && entry.rank <= 3;
    final name = entry.username;

    return Semantics(
      label:
          '${t.games.rank(n: entry.rank)}, @$name, '
          '${t.games.pointsLabel(n: entry.points)}',
      excludeSemantics: true,
      child: Container(
        color: entry.me ? scheme.primaryContainer : null,
        padding: const EdgeInsetsDirectional.fromSTEB(16, 9, 20, 9),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: podium
                  ? BoxDecoration(
                      color: _medals[entry.rank - 1],
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Text(
                '${entry.rank}',
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w800,
                  color: podium ? Colors.white : scheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 12),
            MemberAvatar(
              initials: name.isEmpty
                  ? ''
                  : name.substring(0, name.length < 2 ? 1 : 2).toUpperCase(),
              photo: entry.avatar,
              size: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                entry.me ? '@$name · ${t.games.you}' : '@$name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${entry.points}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
