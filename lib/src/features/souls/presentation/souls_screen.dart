import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/biometrics.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/biometric_method.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/reminder_row.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../routing/app_router.dart';
import '../application/souls.dart';
import '../domain/soul.dart';

/// "À recontacter aujourd'hui", "En retard de 3 jours", "Prochain contact
/// le 21 oct."; null without a day planned.
String? contactLabel(BuildContext context, Soul soul) {
  final t = context.t.souls;
  final next = soul.nextContact;
  if (next == null) {
    return null;
  }
  final days = today().difference(next).inDays;
  if (days > 0) {
    return t.contactLate(n: days);
  }
  if (days == 0) {
    return t.contactToday;
  }
  return t.contactOn(date: context.formatDate(next, 'd MMM'));
}

/// Plus › Accompagnement › Suivi des âmes: the people the member
/// evangelised, where each stands (rencontré → baptisé), those to contact
/// again first; a search, a chip per stage, « Ajouter ». Kept on the phone
/// only; Face ID or the fingerprint can lock it.
@RoutePage()
class SoulsScreen extends HookConsumerWidget {
  const SoulsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.souls;
    final locked = ref.watch(soulsLockProvider);
    final unlocked = useState(!locked);
    final souls = ref.watch(soulsProvider);
    final controller = useTextEditingController();
    final search = useValueListenable(controller).text.trim().toLowerCase();
    final stage = useState<SoulStage?>(null);
    final kind = ref.watch(biometricKindProvider).value;

    Future<void> unlock() async {
      final reason = context.t.souls.unlockReason;
      if (await ref.read(biometricsProvider).authenticate(reason)) {
        unlocked.value = true;
      }
    }

    // locked: Face ID asked at once
    useEffect(() {
      if (locked && !unlocked.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) => unlock());
      }
      return null;
    }, const []);

    Future<void> export(BuildContext anchor) async {
      final list = souls.value ?? const <Soul>[];
      final box = anchor.findRenderObject() as RenderBox?;
      final csv = soulsAsCsv(
        list,
        header: [
          t.csv.name,
          t.csv.phone,
          t.csv.place,
          t.csv.metOn,
          t.csv.stage,
          t.csv.next,
          t.csv.notes,
        ],
        stageName: (stage) => t.stages[stage.name] ?? stage.name,
        day: (day) => context.formatDate(day, 'dd/MM/yyyy'),
      );
      await ref
          .read(shareServiceProvider)
          .shareFile(
            utf8.encode(csv),
            name: '${t.title}.csv',
            mimeType: 'text/csv',
            subject: t.title,
            origin: box == null
                ? null
                : box.localToGlobal(Offset.zero) & box.size,
          );
    }

    if (locked && !unlocked.value) {
      return _Locked(onUnlock: unlock);
    }

    final all = souls.value ?? const <Soul>[];
    final day = today();
    final matching = [
      for (final soul in all)
        if ((stage.value == null || soul.stage == stage.value) &&
            (search.isEmpty ||
                '${soul.name} ${soul.place} ${soul.phone}'
                    .toLowerCase()
                    .contains(search)))
          soul,
    ];
    final toContact = [
      for (final soul in matching)
        if (soul.dueBy(day)) soul,
    ]..sort((a, b) => a.nextContact!.compareTo(b.nextContact!));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.router.push(SoulFormRoute()),
          icon: const Icon(AppIcons.userAdd),
          label: Text(t.add),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _Header(
                controller: controller,
                stats: [
                  (all.length, t.people),
                  (
                    all
                        .where((s) => s.stage.index >= SoulStage.received.index)
                        .length,
                    t.received,
                  ),
                  (all.where((s) => s.dueBy(day)).length, t.toContact),
                ],
                menu: Builder(
                  builder: (anchor) => AdaptiveMenuButton<int>(
                    tooltip: context.t.bible.more,
                    icon: const Icon(AppIcons.moreOptions, color: Colors.white),
                    onSelected: (value) => switch (value) {
                      0 => export(anchor),
                      _ =>
                        ref
                            .read(soulsLockProvider.notifier)
                            .set(!ref.read(soulsLockProvider)),
                    },
                    actions: [
                      if (all.isNotEmpty)
                        AdaptiveAction(
                          value: 0,
                          label: t.export,
                          icon: AppIcons.share,
                        ),
                      if (kind != null)
                        AdaptiveAction(
                          value: 1,
                          label: t.lock(
                            method: biometricMethod(context.t, kind),
                          ),
                          icon: biometricIcon(kind),
                          selected: locked,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (all.isNotEmpty)
              SliverToBoxAdapter(
                child: _Chips(
                  souls: all,
                  selected: stage.value,
                  onSelect: (value) => stage.value = value,
                ),
              ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                96,
              ),
              sliver: SliverToBoxAdapter(
                child: switch (souls) {
                  AsyncValue(value: _?) when all.isEmpty => const _Empty(),
                  AsyncValue(value: _?) when matching.isEmpty => Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Text(t.none, textAlign: TextAlign.center),
                  ),
                  AsyncValue(value: _?) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (ref.read(soulsProvider.notifier).toPrayFor(day)
                          case final soul?
                          when stage.value == null && search.isEmpty) ...[
                        _PrayFor(soul: soul),
                        const SizedBox(height: AppSpacing.md),
                      ],
                      if (toContact.isNotEmpty) ...[
                        SectionCard(
                          header: t.contactSection,
                          children: [
                            for (final soul in toContact) SoulRow(soul: soul),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                      SectionCard(
                        header: t.everyone,
                        children: [
                          for (final soul in matching) SoulRow(soul: soul),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _Privacy(text: t.privacy),
                    ],
                  ),
                  AsyncValue(:final error?) => ErrorView(
                    error: error,
                    onRetry: () => ref.invalidate(soulsProvider),
                  ),
                  _ => const LoadingList(count: 4, card: false),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.controller,
    required this.stats,
    required this.menu,
  });

  final TextEditingController controller;
  final List<(int, String)> stats;
  final Widget menu;

  @override
  Widget build(BuildContext context) {
    final t = context.t.souls;
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
            AppSpacing.xs,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: AppBackButton(),
                  ),
                  const Spacer(),
                  menu,
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.md,
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
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      t.subtitle,
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        color: AppColors.goldLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        for (final (index, (value, label))
                            in stats.indexed) ...[
                          if (index > 0) const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.md,
                                horizontal: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.lg,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '$value',
                                    style: TextStyle(
                                      color: index == 2 && value > 0
                                          ? AppColors.goldLight
                                          : Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    label,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.onPrimaryMuted,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
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

/// « Toutes », then each stage with how many are at it.
class _Chips extends StatelessWidget {
  const _Chips({
    required this.souls,
    required this.selected,
    required this.onSelect,
  });

  final List<Soul> souls;
  final SoulStage? selected;
  final ValueChanged<SoulStage?> onSelect;

  @override
  Widget build(BuildContext context) {
    final t = context.t.souls;
    final tone = AppModule.reports.tone(context);

    Widget chip(String label, SoulStage? value) => Padding(
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
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          chip(t.all, null),
          for (final stage in SoulStage.values)
            if (souls.where((soul) => soul.stage == stage).length
                case final count when count > 0)
              chip('${t.stages[stage.name]} · $count', stage),
        ],
      ),
    );
  }
}

/// The person to pray for today, and the reminder of it each morning.
class _PrayFor extends ConsumerWidget {
  const _PrayFor({required this.soul});

  final Soul soul;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.souls;
    final notifier = ref.read(soulsProvider.notifier);
    final reminder = notifier.prayerReminder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: AppColors.gold.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => context.router.push(SoulRoute(soulId: soul.id)),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  const Icon(
                    AppIcons.prayerTile,
                    color: AppColors.gold,
                    size: 30,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.prayToday,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gold,
                          ),
                        ),
                        Text(
                          soul.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(t.stages[soul.stage.name] ?? ''),
                      ],
                    ),
                  ),
                  const Icon(AppIcons.chevronRight),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ReminderRow(
          label: t.prayerReminder,
          timeLabel: t.prayerReminderAt,
          on: reminder.on,
          minutes: reminder.minutes,
          onChanged: (on) => notifier.setPrayerReminder(on: on),
          onTime: (minutes) => notifier.setPrayerReminder(minutes: minutes),
        ),
      ],
    );
  }
}

/// A person: the initials, the name, the stage and the next contact.
class SoulRow extends StatelessWidget {
  const SoulRow({required this.soul, super.key});

  final Soul soul;

  @override
  Widget build(BuildContext context) {
    final t = context.t.souls;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.reports.tone(context);
    final contact = contactLabel(context, soul);
    final late = soul.dueBy(today());

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: tone.soft,
        foregroundColor: tone.onSoft,
        child: Text(
          soul.initials,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      title: Text(
        soul.name,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: t.stages[soul.stage.name]),
            if (contact != null)
              TextSpan(
                text: ' · $contact',
                style: TextStyle(
                  color: late ? AppColors.gold : scheme.onSurfaceVariant,
                  fontWeight: late ? FontWeight.w700 : null,
                ),
              ),
          ],
        ),
      ),
      trailing: const Icon(AppIcons.chevronRight),
      onTap: () => context.router.push(SoulRoute(soulId: soul.id)),
    );
  }
}

class _Privacy extends StatelessWidget {
  const _Privacy({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(AppIcons.private, size: 18, color: scheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final t = context.t.souls;
    final tone = AppModule.reports.tone(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: tone.soft, shape: BoxShape.circle),
            child: Icon(AppIcons.soulsTile, color: tone.onSoft, size: 34),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            t.empty,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.4),
          ),
          const SizedBox(height: AppSpacing.lg),
          _Privacy(text: t.privacy),
        ],
      ),
    );
  }
}

/// The list hidden until Face ID (or the fingerprint) opens it.
class _Locked extends StatelessWidget {
  const _Locked({required this.onUnlock});

  final VoidCallback onUnlock;

  @override
  Widget build(BuildContext context) {
    final t = context.t.souls;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryDeep,
        body: SafeArea(
          child: Column(
            children: [
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: AppBackButton(),
                ),
              ),
              const Spacer(),
              const Icon(
                AppIcons.premiumLock,
                size: 56,
                color: AppColors.goldLight,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                t.lockedTitle,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: onUnlock,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: Colors.white,
                ),
                child: Text(t.unlock),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
