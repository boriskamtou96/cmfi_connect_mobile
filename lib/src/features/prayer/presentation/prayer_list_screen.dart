import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/prayer_people.dart';
import '../domain/prayer.dart';
import '../domain/retreat.dart';
import 'widgets/prayer_look.dart';

/// One of the user's lists: the people prayed for in turn by the retreats
/// (the next ones first), then those for whom the prayer was answered.
@RoutePage()
class PrayerListScreen extends ConsumerWidget {
  const PrayerListScreen({required this.list, super.key});

  final PrayerList list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final tones = AppTones.of(context);
    final people = ref.watch(prayerPeopleProvider);
    final all = people.value ?? const <PrayerPerson>[];
    // in the order the retreats take them
    final waiting = nextPeople(all, list, count: all.length);
    final next = {
      for (final person in nextPeople(all, list, count: 10)) person.id,
    };
    final answered = [
      for (final person in all)
        if (person.list == list && person.answered) person,
    ]..sort((a, b) => b.answeredOn!.compareTo(a.answeredOn!));
    final day = today();

    return SubPage(
      title: list.label(t),
      actions: [
        IconButton(
          tooltip: t.prayer.lists.add,
          onPressed: () => showPersonSheet(context, list: list),
          icon: Icon(AppIcons.add, color: scheme.primary, size: 26),
        ),
      ],
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: tone.soft,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(AppIcons.private, size: 20, color: tone.onSoft),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${t.prayer.lists.uses[list.name]!} ${t.prayer.lists.privateNote}',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: tone.onSoft,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (people.hasError && people.value == null)
            Text(userMessageFor(people.error!, t))
          else if (people.isLoading && people.value == null)
            // the people of the list
            const Shimmer(child: SkeletonList(count: 4))
          else ...[
            SectionLabel(t.prayer.lists.count(n: waiting.length)),
            const SizedBox(height: AppSpacing.sm),
            if (waiting.isEmpty)
              _EmptyList(onAdd: () => showPersonSheet(context, list: list))
            else
              SectionCard(
                children: [
                  for (final person in waiting)
                    _PersonRow(
                      person: person,
                      trailing: person.lastPrayedOn?.isSameDay(day) ?? false
                          ? Text(
                              t.prayer.lists.prayedToday,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: tone.onSoft,
                              ),
                            )
                          : next.contains(person.id)
                          ? Text(
                              t.prayer.lists.next,
                              style: TextStyle(
                                fontSize: 13,
                                color: scheme.onSurfaceVariant,
                              ),
                            )
                          : null,
                    ),
                ],
              ),
            if (answered.isNotEmpty) ...[
              const SizedBox(height: 20),
              SectionLabel(t.prayer.lists.answeredTitle[list.name]!),
              const SizedBox(height: AppSpacing.sm),
              SectionCard(
                children: [
                  for (final person in answered)
                    _PersonRow(
                      person: person,
                      icon: PhosphorIcon(
                        AppIcons.answeredTile,
                        color: tones.personal,
                        size: 22,
                      ),
                      iconBackground: tones.personalSoft,
                      subtitle: list.answeredOn(
                        t,
                        context.formatDate(person.answeredOn!, 'd MMMM y'),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.prayer.lists.empty,
          style: TextStyle(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.md),
        OutlinedButton.icon(
          onPressed: onAdd,
          icon: const Icon(AppIcons.add, size: 18),
          label: Text(t.prayer.lists.add),
        ),
      ],
    );
  }
}

class _PersonRow extends StatelessWidget {
  const _PersonRow({
    required this.person,
    this.trailing,
    this.icon,
    this.iconBackground,
    this.subtitle,
  });

  final PrayerPerson person;
  final Widget? trailing;
  final Widget? icon;
  final Color? iconBackground;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final initials = person.name
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .take(2)
        .map((word) => word.characters.first.toUpperCase())
        .join();
    final detail = subtitle ?? person.note;

    return InkWell(
      onTap: () => showPersonSheet(context, list: person.list, person: person),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 11, 14, 11),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBackground ?? tone.soft,
                shape: BoxShape.circle,
              ),
              child:
                  icon ??
                  Text(
                    initials,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: tone.onSoft,
                    ),
                  ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (detail.isNotEmpty)
                    Text(
                      detail,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

/// Adds someone to [list], or changes [person]: name, note, the list, the
/// answered prayer, or removes them.
Future<void> showPersonSheet(
  BuildContext context, {
  required PrayerList list,
  PrayerPerson? person,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: SingleChildScrollView(
      child: _PersonSheet(list: list, person: person),
    ),
  ),
);

class _PersonSheet extends HookConsumerWidget {
  const _PersonSheet({required this.list, this.person});

  final PrayerList list;
  final PrayerPerson? person;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final name = useTextEditingController(text: person?.name ?? '');
    final note = useTextEditingController(text: person?.note ?? '');
    final selected = useState(person?.list ?? list);
    final sending = useState(false);
    useListenable(name);
    final people = ref.read(prayerPeopleProvider.notifier);

    Future<void> run(Future<void> Function() action, {String? done}) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      sending.value = true;
      try {
        await action();
        navigator.pop();
        if (done != null) {
          toast.success(done);
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          sending.value = false;
        }
      }
    }

    Future<void> save() => run(() async {
      final existing = person;
      if (existing == null) {
        await people.add(selected.value, name.text, note: note.text);
      } else {
        await people.save(
          existing.copyWith(
            name: name.text,
            note: note.text,
            list: selected.value,
          ),
        );
      }
    });

    Future<void> remove(PrayerPerson existing) async {
      final confirmed = await showAppDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(t.prayer.lists.sheet.removeTitle(name: existing.name)),
          content: Text(t.prayer.lists.sheet.removeText),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.common.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: scheme.error,
                foregroundColor: scheme.onError,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.prayer.lists.sheet.remove),
            ),
          ],
        ),
      );
      if ((confirmed ?? false) && context.mounted) {
        await run(() => people.remove(existing));
      }
    }

    final existing = person;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            existing == null
                ? t.prayer.lists.sheet.addTitle
                : t.prayer.lists.sheet.editTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          LabeledField(
            label: t.prayer.lists.sheet.name,
            child: TextField(
              controller: name,
              autofocus: existing == null,
              textCapitalization: TextCapitalization.words,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: t.prayer.lists.sheet.namePlaceholder,
                counterText: '',
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: t.prayer.lists.sheet.note,
            optionalText: t.common.optional,
            child: TextField(
              controller: note,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 300,
              decoration: InputDecoration(
                hintText: t.prayer.lists.sheet.notePlaceholder,
                counterText: '',
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: t.prayer.lists.sheet.list,
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final option in PrayerList.values)
                  ChoiceChip(
                    label: Text(option.label(t)),
                    selected: selected.value == option,
                    onSelected: (_) => selected.value = option,
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: sending.value || name.text.trim().isEmpty ? null : save,
            style: FilledButton.styleFrom(
              backgroundColor: tone.color,
              minimumSize: const Size.fromHeight(52),
            ),
            child: Text(t.prayer.lists.sheet.save),
          ),
          if (existing != null) ...[
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: sending.value
                  ? null
                  : () => run(
                      () => people.setAnswered(
                        existing,
                        answered: !existing.answered,
                      ),
                      done: existing.answered
                          ? null
                          : t.prayer.lists.answeredToast,
                    ),
              icon: PhosphorIcon(
                existing.answered ? AppIcons.prayerTile : AppIcons.answeredTile,
                size: 20,
              ),
              label: Text(
                existing.answered
                    ? t.prayer.lists.putBack
                    : t.prayer.lists.markAnswered[existing.list.name]!,
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            TextButton(
              onPressed: sending.value ? null : () => remove(existing),
              style: TextButton.styleFrom(foregroundColor: scheme.error),
              child: Text(t.prayer.lists.sheet.remove),
            ),
          ],
        ],
      ),
    );
  }
}
