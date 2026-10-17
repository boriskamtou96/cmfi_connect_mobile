import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive_pickers.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/section_card.dart';
import '../application/souls.dart';
import '../domain/soul.dart';

/// A person to follow, new ([soulId] null) or changed: the name, the phone,
/// where and when they met, the stage; a first note when added.
@RoutePage()
class SoulFormScreen extends HookConsumerWidget {
  const SoulFormScreen({@QueryParam('id') this.soulId, super.key});

  final String? soulId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.souls;
    final notifier = ref.read(soulsProvider.notifier);
    final soul = soulId == null ? null : notifier.byId(soulId!);
    final name = useTextEditingController(text: soul?.name);
    final phone = useTextEditingController(text: soul?.phone);
    final place = useTextEditingController(text: soul?.place);
    final note = useTextEditingController();
    final metOn = useState(soul?.metOn ?? today());
    final stage = useState(soul?.stage ?? SoulStage.met);
    final tried = useState(false);
    final saving = useState(false);
    final typedName = useValueListenable(name).text.trim();
    final nameError = tried.value && typedName.isEmpty ? t.nameRequired : null;

    Future<void> save() async {
      tried.value = true;
      if (name.text.trim().isEmpty) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      saving.value = true;
      final values = Soul(
        id: soul?.id ?? '',
        name: name.text.trim(),
        phone: phone.text.trim(),
        place: place.text.trim(),
        metOn: metOn.value,
        stage: stage.value,
        nextContact: soul?.nextContact,
        notes: [
          if (note.text.trim().isNotEmpty)
            SoulNote(at: DateTime.now(), text: note.text.trim()),
          ...?soul?.notes,
        ],
      );
      if (soul == null) {
        await notifier.add(values);
      } else {
        await notifier.save(values);
      }
      toast.success(t.saved);
      if (context.mounted) {
        await context.router.maybePop();
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(soul == null ? t.addTitle : t.editTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TextField(
            controller: name,
            autofocus: soul == null,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: t.name,
              errorText: nameError,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: phone,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: t.phone,
              prefixIcon: const Icon(AppIcons.phone),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: place,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: t.place),
          ),
          const SizedBox(height: AppSpacing.md),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(AppIcons.calendar),
            title: Text(t.metOn),
            trailing: Text(
              context.formatDate(metOn.value, 'd MMM yyyy'),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            onTap: () async {
              final picked = await showAppDatePicker(
                context,
                initialDate: metOn.value,
                firstDate: DateTime(2000),
                lastDate: today(),
                helpText: t.metOn,
              );
              if (picked != null) {
                metOn.value = DateTime(picked.year, picked.month, picked.day);
              }
            },
          ),
          const SizedBox(height: AppSpacing.md),
          SectionLabel(t.stage),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final value in SoulStage.values)
                ChoiceChip(
                  label: Text(t.stages[value.name] ?? value.name),
                  selected: stage.value == value,
                  onSelected: (_) => stage.value = value,
                ),
            ],
          ),
          if (soul == null) ...[
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: note,
              minLines: 2,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: t.firstNote,
                hintText: t.noteHint,
                alignLabelWithHint: true,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          FilledButton(
            onPressed: saving.value ? null : save,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            child: Text(t.save),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            t.privacy,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
