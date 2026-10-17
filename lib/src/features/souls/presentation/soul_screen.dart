import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/adaptive_pickers.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routing/app_router.dart';
import '../application/souls.dart';
import '../domain/soul.dart';
import 'souls_screen.dart';

/// A person followed: call, WhatsApp or SMS; the stage reached (a tap
/// moves it); the next contact (a reminder at 9 o'clock that day); the
/// notes of the follow-up, the newest first.
@RoutePage()
class SoulScreen extends HookConsumerWidget {
  const SoulScreen({@PathParam('id') required this.soulId, super.key});

  final String soulId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.souls;
    ref.watch(soulsProvider);
    final notifier = ref.read(soulsProvider.notifier);
    final soul = notifier.byId(soulId);
    final note = useTextEditingController();
    final typed = useValueListenable(note).text.trim();

    if (soul == null) {
      return const Scaffold(body: SizedBox.shrink());
    }
    final links = ref.read(linkLauncherProvider);
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.reports.tone(context);

    Future<void> remove() async {
      final toast = ref.read(toasterProvider).of(context);
      final yes = await showConfirmDialog(
        context,
        title: t.deleteTitle(name: soul.name),
        text: t.deleteText,
        confirmLabel: t.delete,
        destructive: true,
      );
      if (!yes) {
        return;
      }
      await notifier.remove(soul.id);
      toast.success(t.deleted);
      if (context.mounted) {
        await context.router.maybePop();
      }
    }

    Future<void> planContact() async {
      final first = today();
      final picked = await showAppDatePicker(
        context,
        initialDate: soul.nextContact ?? first.add(const Duration(days: 7)),
        firstDate: first,
        lastDate: first.add(const Duration(days: 365)),
        helpText: t.nextContact,
      );
      if (picked != null) {
        await notifier.save(
          soul.copyWith(
            nextContact: () => DateTime(picked.year, picked.month, picked.day),
          ),
        );
      }
    }

    Future<void> addNote() async {
      await notifier.addNote(soul.id, note.text);
      note.clear();
      if (context.mounted) {
        FocusScope.of(context).unfocus();
      }
    }

    final contact = contactLabel(context, soul);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
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
                    children: [
                      Row(
                        children: [
                          const IconTheme(
                            data: IconThemeData(color: Colors.white),
                            child: AppBackButton(),
                          ),
                          const Spacer(),
                          AdaptiveMenuButton<int>(
                            tooltip: context.t.bible.more,
                            icon: const Icon(
                              AppIcons.moreOptions,
                              color: Colors.white,
                            ),
                            onSelected: (value) => value == 0
                                ? context.router.push(
                                    SoulFormRoute(soulId: soul.id),
                                  )
                                : remove(),
                            actions: [
                              AdaptiveAction(
                                value: 0,
                                label: t.edit,
                                icon: AppIcons.edit,
                              ),
                              AdaptiveAction(
                                value: 1,
                                label: t.delete,
                                icon: AppIcons.delete,
                                destructive: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.gold,
                        foregroundColor: Colors.white,
                        child: Text(
                          soul.initials,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Semantics(
                        header: true,
                        child: Text(
                          soul.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        [
                          t.metAt(
                            date: context.formatDate(soul.metOn, 'd MMMM yyyy'),
                          ),
                          if (soul.place.isNotEmpty) soul.place,
                        ].join(' · '),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.onPrimaryMuted),
                      ),
                      if (soul.dialable.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _Action(
                              icon: AppIcons.phone,
                              label: t.call,
                              onTap: () => links.call(soul.dialable),
                            ),
                            _Action(
                              icon: AppIcons.whatsApp,
                              label: t.whatsApp,
                              onTap: () => links.open(
                                Uri.https(
                                  'wa.me',
                                  '/${soul.dialable.replaceAll('+', '')}',
                                ),
                              ),
                            ),
                            _Action(
                              icon: AppIcons.sms,
                              label: t.sms,
                              onTap: () => links.open(
                                Uri(scheme: 'sms', path: soul.dialable),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionLabel(t.stage),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final stage in SoulStage.values)
                        ChoiceChip(
                          label: Text(t.stages[stage.name] ?? stage.name),
                          selected: soul.stage == stage,
                          showCheckmark: false,
                          selectedColor: tone.soft,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: soul.stage == stage ? tone.onSoft : null,
                          ),
                          avatar: stage.index < soul.stage.index
                              ? Icon(
                                  AppIcons.check,
                                  size: 16,
                                  color: tone.onSoft,
                                )
                              : null,
                          onSelected: (_) {
                            HapticFeedback.selectionClick();
                            notifier.save(soul.copyWith(stage: stage));
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SectionCard(
                    header: t.nextContact,
                    children: [
                      ListTile(
                        leading: Icon(
                          AppIcons.reminder,
                          color: soul.dueBy(today())
                              ? AppColors.gold
                              : scheme.onSurfaceVariant,
                        ),
                        title: Text(
                          contact ?? t.noContact,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: soul.nextContact == null
                            ? null
                            : IconButton(
                                tooltip: t.clear,
                                onPressed: () => notifier.save(
                                  soul.copyWith(nextContact: () => null),
                                ),
                                icon: const Icon(AppIcons.close),
                              ),
                        onTap: planContact,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          0,
                          AppSpacing.lg,
                          AppSpacing.md,
                        ),
                        child: OutlinedButton(
                          onPressed: planContact,
                          child: Text(
                            soul.nextContact == null ? t.plan : t.change,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SectionLabel(t.notes),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: note,
                    minLines: 1,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: t.noteHint,
                      suffixIcon: IconButton(
                        tooltip: t.addNote,
                        onPressed: typed.isEmpty ? null : addNote,
                        icon: const Icon(AppIcons.addNote),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (soul.notes.isEmpty)
                    Text(
                      t.noNotes,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    )
                  else
                    SectionCard(
                      children: [
                        for (final item in soul.notes)
                          ListTile(
                            title: Text(item.text),
                            subtitle: Text(
                              context.formatDate(item.at, 'd MMMM yyyy'),
                            ),
                            trailing: IconButton(
                              tooltip: t.deleteNote,
                              onPressed: () =>
                                  notifier.removeNote(soul.id, item),
                              icon: Icon(
                                AppIcons.delete,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    child: Column(
      children: [
        IconButton.filled(
          tooltip: label,
          onPressed: onTap,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.12),
            foregroundColor: Colors.white,
            fixedSize: const Size.square(52),
          ),
          icon: Icon(icon),
        ),
        const SizedBox(height: AppSpacing.xs),
        ExcludeSemantics(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}
