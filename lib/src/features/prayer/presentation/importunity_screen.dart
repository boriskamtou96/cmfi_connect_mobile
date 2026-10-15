import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/text_direction.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../../members/domain/member.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../application/importunities.dart';
import '../domain/prayer.dart';
import 'widgets/invitation_menu.dart';
import 'widgets/prayer_look.dart';

/// An importunity topic: the counter of proclamations (one tap, one
/// proclamation), the progress toward the goal, who prays (names only), and
/// for its author the invitations, changes and closing.
@RoutePage()
class ImportunityScreen extends HookConsumerWidget {
  const ImportunityScreen({
    @PathParam('importunityId') required this.importunityId,
    super.key,
  });

  final int importunityId;

  /// Taps are sent together this long after the last one.
  static const sendDelay = Duration(seconds: 2);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final list = ref.watch(importunitiesProvider);
    final detail = ref.watch(importunityDetailProvider(importunityId));
    final fromList = list.value
        ?.where((topic) => topic.id == importunityId)
        .firstOrNull;
    final topic = fromList ?? detail.value;
    final notifier = ref.read(importunitiesProvider.notifier);
    final sendTimer = useRef<Timer?>(null);

    // what was counted leaves with the screen
    useEffect(
      () => () {
        sendTimer.value?.cancel();
        unawaited(notifier.sendCounts());
      },
      const [],
    );

    if (topic == null) {
      return SubPage(
        title: t.prayer.importunity.title,
        child: detail.hasError
            ? Center(child: Text(userMessageFor(detail.error!, t)))
            : const SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 32),
                // the title, then the counter
                child: Shimmer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SkeletonLine(widthFactor: 0.7, height: 26),
                      SizedBox(height: AppSpacing.md),
                      SkeletonLine(widthFactor: 0.9),
                      SizedBox(height: AppSpacing.xl),
                      Center(child: SkeletonBox(height: 220, circle: true)),
                    ],
                  ),
                ),
              ),
      );
    }

    void count(int amount) {
      unawaited(HapticFeedback.lightImpact());
      unawaited(notifier.count(topic, amount));
      sendTimer.value?.cancel();
      sendTimer.value = Timer(
        sendDelay,
        () => unawaited(notifier.sendCounts()),
      );
    }

    Future<void> addMany() async {
      final amount = await _askAmount(context);
      if (amount != null && amount > 0) {
        count(amount);
      }
    }

    final members = detail.value?.members ?? const <MemberCard>[];
    final canCount = topic.isOpen && !topic.isInvitation;

    return SubPage(
      title: t.prayer.importunity.title,
      actions: [_Menu(topic: topic)],
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 32),
        children: [
          Text(
            topic.title,
            textDirection: contentDirection(topic.title),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.4,
            ),
          ),
          if (topic.description.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              topic.description,
              textDirection: contentDirection(topic.description),
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          if (topic.isInvitation)
            _Invitation(topic: topic)
          else ...[
            Center(
              child: _Counter(
                topic: topic,
                onTap: canCount ? () => count(1) : null,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              t.prayer.importunity.mine(n: context.formatNumber(topic.myCount)),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: tone.onSoft,
              ),
            ),
            if (canCount)
              Center(
                child: TextButton.icon(
                  onPressed: addMany,
                  icon: const Icon(AppIcons.addCircle, size: 18),
                  label: Text(t.prayer.importunity.addMany),
                ),
              ),
          ],
          const SizedBox(height: AppSpacing.lg),
          if (topic.goal case final goal?) ...[
            GoalBar(progress: topic.progress!, reached: topic.reached),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Text(
                    t.prayer.importunity.progress(
                      total: context.formatNumber(topic.total),
                      goal: context.formatNumber(goal),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (topic.reached)
                  StatusPill(
                    t.prayer.importunity.reached,
                    background: AppTones.of(context).personalSoft,
                    foreground: AppTones.of(context).personal,
                  )
                else if (!topic.isOpen)
                  StatusPill(t.prayer.importunity.closed),
              ],
            ),
          ] else
            Text(
              t.prayer.importunity.total(
                n: topic.total,
                count: context.formatNumber(topic.total),
              ),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: SectionLabel(
                  '${t.prayer.importunity.members} · ${topic.participants}',
                ),
              ),
              if (topic.isOpen && !topic.isInvitation)
                TextButton.icon(
                  onPressed: () => showInviteSheet(context, topic),
                  icon: const Icon(AppIcons.userAdd, size: 18),
                  label: Text(t.prayer.importunity.invite),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          SectionCard(
            children: [
              for (final member in members)
                ListTile(
                  leading: MemberAvatar(
                    initials: member.initials,
                    photo: member.avatar,
                    size: 40,
                    background: tone.soft,
                    foreground: tone.onSoft,
                  ),
                  title: Text('${member.firstName} ${member.lastName}'.trim()),
                  subtitle: Text('@${member.username}'),
                ),
              if (members.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Text(
                    t.prayer.importunity.participants(n: topic.participants),
                  ),
                ),
            ],
          ),
          if (topic.invited > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.prayer.importunity.waiting(n: topic.invited),
              style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

/// The big round button: one tap, one proclamation; the ring is the goal.
class _Counter extends StatelessWidget {
  const _Counter({required this.topic, required this.onTap});

  final Importunity topic;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final tone = AppModule.prayer.tone(context);
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: t.prayer.importunity.tapHint,
      value: context.formatNumber(topic.total),
      child: SizedBox.square(
        dimension: 220,
        child: CustomPaint(
          painter: ProgressRingPainter(
            progress: topic.progress ?? 0,
            color: topic.reached ? AppColors.gold : tone.color,
            track: tone.soft,
            stroke: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Material(
              color: onTap == null
                  ? scheme.surfaceContainerHighest
                  : tone.color,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onTap,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            context.formatNumber(topic.total),
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w800,
                              height: 1,
                              color: onTap == null
                                  ? scheme.onSurfaceVariant
                                  : Colors.white,
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          onTap == null
                              ? t.prayer.importunity.closed
                              : t.prayer.importunity.tapHint,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: onTap == null
                                ? scheme.onSurfaceVariant
                                : Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Invitation extends ConsumerWidget {
  const _Invitation({required this.topic});

  final Importunity topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final tone = AppModule.prayer.tone(context);
    final inviter = topic.invitedBy ?? topic.owner;

    Future<void> answer({required bool join}) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final router = context.router;
      try {
        await ref
            .read(importunitiesProvider.notifier)
            .answer(topic, join: join);
        if (join) {
          ref.invalidate(importunityDetailProvider(topic.id));
          toast.success(messages.prayer.importunity.joined);
        } else {
          await router.maybePop();
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tone.soft,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              MemberAvatar(
                initials: inviter.initials,
                photo: inviter.avatar,
                size: 40,
                background: Theme.of(context).colorScheme.surface,
                foreground: tone.onSoft,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  t.prayer.importunity.invitedBy(
                    name: '${inviter.firstName} ${inviter.lastName}'.trim(),
                  ),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: tone.onSoft,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: () => answer(join: true),
            style: FilledButton.styleFrom(
              backgroundColor: tone.color,
              minimumSize: const Size.fromHeight(50),
            ),
            child: Text(t.prayer.importunity.join),
          ),
          TextButton(
            onPressed: () => answer(join: false),
            style: TextButton.styleFrom(foregroundColor: tone.onSoft),
            child: Text(t.prayer.importunity.decline),
          ),
        ],
      ),
    );
  }
}

/// The author's actions (change, close, delete) or a participant's (leave);
/// on an invitation, report it or block whoever sent it.
class _Menu extends ConsumerWidget {
  const _Menu({required this.topic});

  final Importunity topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.prayer.importunity;
    final scheme = Theme.of(context).colorScheme;
    if (topic.isInvitation) {
      final router = context.router;
      return InvitationMenu(
        topic: topic,
        onBlocked: () => unawaited(router.maybePop()),
      );
    }

    Future<bool> confirm(String title, String text, String action) async =>
        await showAppDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(context.t.common.cancel),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: scheme.error,
                  foregroundColor: scheme.onError,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(action),
              ),
            ],
          ),
        ) ??
        false;

    Future<void> run(
      Future<void> Function() action, {
      bool back = false,
    }) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final router = context.router;
      try {
        await action();
        if (back) {
          await router.maybePop();
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      }
    }

    final notifier = ref.read(importunitiesProvider.notifier);
    return PopupMenuButton<String>(
      icon: Icon(AppIcons.moreOptions, color: scheme.onSurfaceVariant),
      onSelected: (choice) async {
        switch (choice) {
          case 'edit':
            await showImportunityForm(context, topic: topic);
          case 'close':
            await run(
              () => notifier.edit(
                topic,
                title: topic.title,
                description: topic.description,
                goal: topic.goal,
                status: topic.isOpen
                    ? ImportunityStatus.closed
                    : ImportunityStatus.open,
              ),
            );
          case 'delete':
            if (await confirm(t.deleteTitle, t.deleteText, t.delete)) {
              await run(() => notifier.delete(topic), back: true);
            }
          case 'leave':
            if (await confirm(t.leaveTitle, t.leaveText, t.leave)) {
              await run(() => notifier.leave(topic), back: true);
            }
        }
      },
      itemBuilder: (context) => [
        if (topic.isOwner) ...[
          PopupMenuItem(value: 'edit', child: Text(t.edit)),
          PopupMenuItem(
            value: 'close',
            child: Text(topic.isOpen ? t.close : t.reopen),
          ),
          PopupMenuItem(value: 'delete', child: Text(t.delete)),
        ] else
          PopupMenuItem(value: 'leave', child: Text(t.leave)),
      ],
    );
  }
}

Future<int?> _askAmount(BuildContext context) async {
  final controller = TextEditingController();
  final t = context.t.prayer.importunity;
  final amount = await showAppDialog<int>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.addManyTitle),
      content: TextField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(5),
        ],
        decoration: InputDecoration(labelText: t.addManyLabel),
        onSubmitted: (value) => Navigator.of(context).pop(int.tryParse(value)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.common.cancel),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.of(context).pop(int.tryParse(controller.text)),
          child: Text(t.add),
        ),
      ],
    ),
  );
  controller.dispose();
  return amount;
}

/// Creates an importunity topic ([topic] null) or changes it.
Future<void> showImportunityForm(BuildContext context, {Importunity? topic}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(child: _ImportunityForm(topic: topic)),
      ),
    );

class _ImportunityForm extends HookConsumerWidget {
  const _ImportunityForm({this.topic});

  final Importunity? topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.prayer.importunity.form;
    final tone = AppModule.prayer.tone(context);
    final title = useTextEditingController(text: topic?.title ?? '');
    final description = useTextEditingController(
      text: topic?.description ?? '',
    );
    final goal = useTextEditingController(text: topic?.goal?.toString() ?? '');
    final sending = useState(false);
    useListenable(title);

    Future<void> save() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      final router = context.router;
      final notifier = ref.read(importunitiesProvider.notifier);
      final goalValue = int.tryParse(goal.text.replaceAll(RegExp(r'\D'), ''));
      sending.value = true;
      try {
        final existing = topic;
        if (existing == null) {
          final created = await notifier.create(
            title: title.text,
            description: description.text,
            goal: goalValue == 0 ? null : goalValue,
          );
          navigator.pop();
          unawaited(router.push(ImportunityRoute(importunityId: created.id)));
        } else {
          await notifier.edit(
            existing,
            title: title.text,
            description: description.text,
            goal: goalValue == 0 ? null : goalValue,
          );
          navigator.pop();
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          sending.value = false;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            topic == null ? t.newTitle : t.editTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          LabeledField(
            label: t.subject,
            child: TextField(
              controller: title,
              autofocus: topic == null,
              maxLength: 150,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: t.subjectPlaceholder,
                counterText: '',
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: t.description,
            optionalText: context.t.common.optional,
            child: TextField(
              controller: description,
              maxLength: 1000,
              minLines: 2,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: t.descriptionPlaceholder,
                counterText: '',
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: t.goal,
            optionalText: context.t.common.optional,
            helper: t.goalHint,
            child: TextField(
              controller: goal,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(9),
              ],
              decoration: InputDecoration(
                hintText: t.goalPlaceholder,
                prefixIcon: const Icon(AppIcons.importunityGoal),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: sending.value || title.text.trim().isEmpty ? null : save,
            style: FilledButton.styleFrom(
              backgroundColor: tone.color,
              minimumSize: const Size.fromHeight(52),
            ),
            child: Text(topic == null ? t.create : t.save),
          ),
        ],
      ),
    );
  }
}

/// Invites to pray: the user's spiritual family (their disciple maker and
/// the other disciples), or members by pseudo.
Future<void> showInviteSheet(BuildContext context, Importunity topic) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(child: _InviteSheet(topic: topic)),
      ),
    );

class _InviteSheet extends HookConsumerWidget {
  const _InviteSheet({required this.topic});

  final Importunity topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.prayer.importunity.inviteSheet;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final family = ref.watch(prayerFamilyProvider);
    final withFamily = useState(false);
    final usernames = useState(<String>[]);
    final field = useTextEditingController();
    final sending = useState(false);
    useListenable(field);

    void addUsername() {
      final username = field.text.trim().replaceFirst('@', '').toLowerCase();
      if (username.isNotEmpty && !usernames.value.contains(username)) {
        usernames.value = [...usernames.value, username];
      }
      field.clear();
    }

    Future<void> send() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      if (field.text.trim().isNotEmpty) {
        addUsername();
      }
      sending.value = true;
      try {
        final count = await ref
            .read(importunitiesProvider.notifier)
            .invite(
              topic,
              usernames: usernames.value,
              family: withFamily.value,
            );
        ref.invalidate(importunityDetailProvider(topic.id));
        navigator.pop();
        toast.success(messages.prayer.importunity.inviteSheet.sent(n: count));
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          sending.value = false;
        }
      }
    }

    final familyValue = family.value;
    final maker = familyValue?.discipleMaker;
    final ready =
        withFamily.value ||
        usernames.value.isNotEmpty ||
        field.text.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          SectionLabel(t.family),
          const SizedBox(height: AppSpacing.sm),
          if (family.isLoading)
            // the tile of the family
            const Shimmer(child: SkeletonList(count: 1, round: false))
          else if (maker == null || familyValue!.members == 0)
            Text(
              t.familyMissing,
              style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
            )
          else
            Material(
              color: withFamily.value ? tone.soft : scheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                side: BorderSide(
                  color: withFamily.value ? tone.color : scheme.outlineVariant,
                ),
              ),
              child: CheckboxListTile(
                value: withFamily.value,
                onChanged: (value) => withFamily.value = value ?? false,
                secondary: ToneTile(
                  icon: AppIcons.authoritiesTile,
                  tone: tone,
                  size: 40,
                ),
                title: Text(
                  t.familyText(
                    n: familyValue.members,
                    name: '${maker.firstName} ${maker.lastName}'.trim(),
                  ),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          SectionLabel(t.byUsername),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: field,
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => addUsername(),
                  decoration: InputDecoration(
                    hintText: '@pseudo',
                    labelText: t.usernameLabel,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton.filledTonal(
                tooltip: t.addUsername,
                onPressed: field.text.trim().isEmpty ? null : addUsername,
                icon: const Icon(AppIcons.add),
              ),
            ],
          ),
          if (usernames.value.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final username in usernames.value)
                  InputChip(
                    label: Text('@$username'),
                    onDeleted: () => usernames.value = [
                      for (final other in usernames.value)
                        if (other != username) other,
                    ],
                  ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          FilledButton(
            onPressed: sending.value || !ready ? null : send,
            style: FilledButton.styleFrom(
              backgroundColor: tone.color,
              minimumSize: const Size.fromHeight(52),
            ),
            child: Text(t.send),
          ),
        ],
      ),
    );
  }
}
