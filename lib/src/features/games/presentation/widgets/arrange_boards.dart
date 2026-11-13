import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_tones.dart';
import '../../domain/game.dart';

/// « Remets dans l'ordre »: the things wait in a pool; each one touched takes
/// the next place (1, 2, 3…); a placed one touched goes back to the pool.
/// Once all are placed, [onChanged] gets their ids in order ("c,a,d,b"),
/// empty while one is missing. Checked, each place says whether it is right.
class OrderBoard extends HookWidget {
  const OrderBoard({
    required this.question,
    required this.checked,
    required this.onChanged,
    super.key,
  });

  final GameQuestion question;
  final bool checked;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final missing = AppTones.of(context).missing;
    final placed = useState(<String>[]);
    final right = question.answer.split(',');
    final pool = [
      for (final choice in question.choices)
        if (!placed.value.contains(choice.id)) choice,
    ];
    String textOf(String id) =>
        question.choices.firstWhere((choice) => choice.id == id).text;

    void update(List<String> next) {
      HapticFeedback.selectionClick();
      placed.value = next;
      onChanged(next.length == question.choices.length ? next.join(',') : '');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.games.orderHint,
          style: TextStyle(fontSize: 13.5, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < question.choices.length; i++) ...[
          _Slot(
            number: i + 1,
            text: i < placed.value.length ? textOf(placed.value[i]) : null,
            state: !checked || i >= placed.value.length
                ? null
                : placed.value[i] == right[i],
            onTap: checked || i >= placed.value.length
                ? null
                : () => update([...placed.value]..removeAt(i)),
          ),
          const SizedBox(height: 8),
        ],
        if (pool.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final choice in pool)
                _Piece(
                  text: choice.text,
                  onTap: checked
                      ? null
                      : () => update([...placed.value, choice.id]),
                ),
            ],
          ),
        ],
        if (checked && placed.value.length < right.length)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Icon(AppIcons.wrong, color: missing),
          ),
      ],
    );
  }
}

/// A place of the order: its number, the thing put there (or a dashed
/// hollow), and once checked, a tick or the arrow « to see again ».
class _Slot extends StatelessWidget {
  const _Slot({
    required this.number,
    required this.text,
    required this.state,
    required this.onTap,
  });

  final int number;
  final String? text;

  /// Right, wrong, or not checked (null).
  final bool? state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final missing = AppTones.of(context).missing;
    final filled = text != null;
    final edge = switch (state) {
      true => AppColors.success,
      false => missing,
      null => filled ? scheme.primary : scheme.outlineVariant,
    };
    return Semantics(
      button: onTap != null,
      label: '$number. ${text ?? ''}',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppMotion.of(context, AppMotion.fast),
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 12, 10),
          decoration: BoxDecoration(
            color: filled
                ? Color.alphaBlend(edge.withValues(alpha: 0.1), scheme.surface)
                : scheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: edge, width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: filled ? edge : scheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: filled ? Colors.white : scheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text ?? '',
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
              ),
              if (state case final right?)
                Icon(
                  right ? AppIcons.right : AppIcons.wrong,
                  color: right ? AppColors.success : missing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A thing still to place, as a chip in relief.
class _Piece extends StatelessWidget {
  const _Piece({required this.text, required this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      enabled: onTap != null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 3),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant, width: 2),
            boxShadow: [
              BoxShadow(
                color: scheme.outlineVariant,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

/// The colors of the pairs linked, one per pair: never the color alone, the
/// number of the pair is written too.
const _pairColors = [
  Color(0xFF1E6FD9),
  Color(0xFFB4521E),
  Color(0xFF7A4A98),
  Color(0xFF0E7A72),
];

/// « Relie les paires »: the left column and the right one; touch one on
/// each side to link them (they take the same color and number); touch a
/// linked one to undo. Once all are linked, [onChanged] gets the pairs
/// ("l1=r2,…"), empty while one is missing. Checked, each pair says whether
/// it is right.
class MatchBoard extends HookWidget {
  const MatchBoard({
    required this.question,
    required this.checked,
    required this.onChanged,
    super.key,
  });

  final GameQuestion question;
  final bool checked;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final lefts = [
      for (final choice in question.choices)
        if (choice.id.startsWith('l')) choice,
    ];
    final rights = [
      for (final choice in question.choices)
        if (choice.id.startsWith('r')) choice,
    ];
    // left id → right id, in the order they were linked
    final pairs = useState(<String, String>{});
    final held = useState<String?>(null);
    final right = {
      for (final pair in question.answer.split(','))
        pair.split('=').first: pair.split('=').last,
    };

    void touch(String id) {
      if (checked) {
        return;
      }
      HapticFeedback.selectionClick();
      final next = {...pairs.value};
      // a linked one touched: the pair is undone
      final linkedLeft = id.startsWith('l')
          ? (next.containsKey(id) ? id : null)
          : next.entries
                .where((pair) => pair.value == id)
                .map((pair) => pair.key)
                .firstOrNull;
      if (linkedLeft != null) {
        next.remove(linkedLeft);
        pairs.value = next;
        held.value = null;
        onChanged('');
        return;
      }
      final other = held.value;
      if (other == null || other[0] == id[0]) {
        held.value = id;
        return;
      }
      final (left, rightId) = id.startsWith('l') ? (id, other) : (other, id);
      next[left] = rightId;
      pairs.value = next;
      held.value = null;
      onChanged(next.length == lefts.length ? matchAnswer(next) : '');
    }

    int? pairOf(String id) {
      final keys = pairs.value.keys.toList();
      final left = id.startsWith('l')
          ? id
          : pairs.value.entries
                .where((pair) => pair.value == id)
                .map((pair) => pair.key)
                .firstOrNull;
      if (left == null || !pairs.value.containsKey(left)) {
        return null;
      }
      return keys.indexOf(left);
    }

    bool? stateOf(String id) {
      if (!checked) {
        return null;
      }
      final left = id.startsWith('l')
          ? id
          : pairs.value.entries
                .where((pair) => pair.value == id)
                .map((pair) => pair.key)
                .firstOrNull;
      if (left == null || !pairs.value.containsKey(left)) {
        return false;
      }
      return pairs.value[left] == right[left];
    }

    Widget column(List<GameChoice> side) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final choice in side) ...[
          _MatchTile(
            text: choice.text,
            pair: pairOf(choice.id),
            held: held.value == choice.id,
            state: stateOf(choice.id),
            onTap: checked ? null : () => touch(choice.id),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.games.matchHint,
          style: TextStyle(fontSize: 13.5, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: column(lefts)),
            const SizedBox(width: 10),
            Expanded(child: column(rights)),
          ],
        ),
      ],
    );
  }
}

/// A side of a pair: its text; linked, the color and number of its pair;
/// held (waiting for its other side), the brand blue; checked, right or not.
class _MatchTile extends StatelessWidget {
  const _MatchTile({
    required this.text,
    required this.pair,
    required this.held,
    required this.state,
    required this.onTap,
  });

  final String text;
  final int? pair;
  final bool held;
  final bool? state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final missing = AppTones.of(context).missing;
    final color = switch (state) {
      true => AppColors.success,
      false => missing,
      null when pair != null => _pairColors[pair! % _pairColors.length],
      null when held => scheme.primary,
      null => scheme.outlineVariant,
    };
    final active = pair != null || held || state != null;
    return Semantics(
      button: onTap != null,
      selected: held,
      label: pair == null ? text : '$text (${pair! + 1})',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppMotion.of(context, AppMotion.fast),
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: active
                ? Color.alphaBlend(
                    color.withValues(alpha: 0.12),
                    scheme.surface,
                  )
                : scheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color, width: 2),
            boxShadow: [BoxShadow(color: color, offset: const Offset(0, 3))],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
              if (pair != null && state == null)
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${pair! + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (state case final right?)
                Icon(
                  right ? AppIcons.right : AppIcons.wrong,
                  size: 20,
                  color: right ? AppColors.success : missing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
