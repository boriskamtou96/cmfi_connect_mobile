import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/image_picking.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/zoned_time.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/dashed_outline.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/inline_error.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/sub_page.dart';
import '../../../../routing/app_router.dart';
import '../../application/event_admin.dart';
import '../../application/events_providers.dart';
import '../../domain/event.dart';
import '../../domain/event_draft.dart';
import '../widgets/event_format.dart';
import '../widgets/event_picture.dart';

/// Creates an event ([eventId] null) or changes one: poster, theme, dates,
/// venue, registrations, visibility.
@RoutePage()
class EventFormScreen extends ConsumerWidget {
  const EventFormScreen({@PathParam('eventId') this.eventId, super.key});

  final int? eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = eventId;
    if (id == null) {
      return const _EventForm(event: null);
    }
    final t = context.t.events.admin;
    return switch (ref.watch(eventDetailProvider(id))) {
      AsyncValue(value: final event?) => _EventForm(event: event),
      AsyncValue(:final error?) => SubPage(
        title: t.edit,
        child: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(eventDetailProvider(id)),
        ),
      ),
      _ => SubPage(
        title: t.edit,
        child: const Center(child: CircularProgressIndicator()),
      ),
    };
  }
}

class _EventForm extends HookConsumerWidget {
  const _EventForm({required this.event});

  final CommunityEvent? event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events.admin;
    final scheme = Theme.of(context).colorScheme;
    final event = this.event;
    final timeZone = event?.timeZone ?? CommunityEvent.defaultTimeZone;
    final formKey = useMemoized(GlobalKey<FormState>.new);

    // the dates as the venue's clocks show them
    DateTime wall(DateTime instant) {
      final local = instant.inZone(timeZone);
      return DateTime(
        local.year,
        local.month,
        local.day,
        local.hour,
        local.minute,
      );
    }

    final defaultDay = DateTime.now().add(const Duration(days: 30));
    final poster = useState(event?.poster);
    final uploading = useState(false);
    final title = useTextEditingController(text: event?.title);
    final theme = useTextEditingController(text: event?.theme);
    final verse = useTextEditingController(text: event?.themeVerse);
    final description = useTextEditingController(text: event?.description);
    final venue = useTextEditingController(text: event?.venue);
    final address = useTextEditingController(text: event?.address);
    final city = useTextEditingController(text: event?.city);
    final country = useTextEditingController(text: event?.country);
    final mapsUrl = useTextEditingController(text: event?.mapsUrl);
    final contactName = useTextEditingController(text: event?.contactName);
    final contactPhone = useTextEditingController(text: event?.contactPhone);
    final capacity = useTextEditingController(
      text: event?.capacity?.toString(),
    );
    final fees = useTextEditingController(text: event?.feeNote);
    final start = useState(
      event == null
          ? DateTime(defaultDay.year, defaultDay.month, defaultDay.day, 9)
          : wall(event.startsAt),
    );
    final end = useState(
      event == null
          ? DateTime(defaultDay.year, defaultDay.month, defaultDay.day, 17)
          : wall(event.endsAt),
    );
    final deadline = useState(
      event?.registrationDeadline == null
          ? null
          : wall(event!.registrationDeadline!),
    );
    final registrationOpen = useState(event?.registrationOpen ?? true);
    final asksLodging = useState(event?.asksLodging ?? false);
    final asksDeparture = useState(event?.asksDepartureCity ?? false);
    final status = useState(event?.status ?? EventStatus.draft);
    final saving = useState(false);
    final endsBeforeStart = !end.value.isAfter(start.value);

    Future<void> pickPoster() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final picked = await ref.read(imagePickingProvider).pickOne();
      if (picked == null) {
        return;
      }
      uploading.value = true;
      try {
        poster.value = await ref.read(eventAdminProvider).upload(picked);
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      } finally {
        if (context.mounted) {
          uploading.value = false;
        }
      }
    }

    Future<void> save() async {
      if (!(formKey.currentState?.validate() ?? false) || endsBeforeStart) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      final router = context.router;
      final admin = ref.read(eventAdminProvider);
      final lastDay = deadline.value;
      final draft = EventDraft(
        title: title.text.trim(),
        theme: theme.text.trim(),
        themeVerse: verse.text.trim(),
        description: description.text.trim(),
        startsAt: instantAt(timeZone, start.value),
        endsAt: instantAt(timeZone, end.value),
        timeZone: timeZone,
        venue: venue.text.trim(),
        address: address.text.trim(),
        city: city.text.trim(),
        country: country.text.trim(),
        mapsUrl: mapsUrl.text.trim(),
        contactName: contactName.text.trim(),
        contactPhone: contactPhone.text.trim(),
        posterId: poster.value?.id,
        registrationOpen: registrationOpen.value,
        registrationDeadline: lastDay == null
            ? null
            : instantAt(
                timeZone,
                DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59),
              ),
        capacity: int.tryParse(capacity.text.trim()),
        asksLodging: asksLodging.value,
        asksDepartureCity: asksDeparture.value,
        feeNote: fees.text.trim(),
        status: status.value,
      );
      saving.value = true;
      try {
        final saved = event == null
            ? await admin.create(draft)
            : await admin.save(event.id, draft);
        toast.success(t.saved);
        navigator.pop();
        if (event == null) {
          await router.push(EventRoute(eventId: saved.id));
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          saving.value = false;
        }
      }
    }

    Widget field(
      TextEditingController controller,
      String label, {
      String? hint,
      int maxLines = 1,
      TextInputType? keyboard,
      String? Function(String?)? validator,
    }) => LabeledField(
      label: label,
      child: TextFormField(
        controller: controller,
        minLines: maxLines > 1 ? 2 : 1,
        maxLines: maxLines,
        keyboardType: keyboard,
        textCapitalization: keyboard == null
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        decoration: InputDecoration(hintText: hint),
        validator: validator,
      ),
    );

    const gap = SizedBox(height: AppSpacing.lg);

    return SubPage(
      title: event == null ? t.create : t.edit,
      bottom: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: AppButton(
          label: context.t.common.save,
          isLoading: saving.value,
          onPressed: uploading.value ? null : save,
        ),
      ),
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            // the poster first: it is what members see
            SectionLabel(t.poster),
            const SizedBox(height: AppSpacing.md),
            _PosterPicker(
              poster: poster.value,
              uploading: uploading.value,
              onPick: pickPoster,
              onRemove: () => poster.value = null,
            ),
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(t.general),
            const SizedBox(height: AppSpacing.md),
            field(
              title,
              t.titleField,
              hint: t.titleHint,
              validator: (value) =>
                  (value ?? '').trim().isEmpty ? t.titleRequired : null,
            ),
            gap,
            field(theme, t.theme, hint: t.themeHint),
            gap,
            field(verse, t.verse, maxLines: 3),
            gap,
            field(description, t.description, maxLines: 6),
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(t.when),
            const SizedBox(height: AppSpacing.md),
            _DateTimeField(
              label: t.starts,
              value: start.value,
              onChanged: (value) {
                // the end follows when the start moves past it
                final length = end.value.difference(start.value);
                start.value = value;
                if (!end.value.isAfter(value)) {
                  end.value = value.add(
                    length.isNegative ? const Duration(hours: 2) : length,
                  );
                }
              },
            ),
            gap,
            _DateTimeField(
              label: t.ends,
              value: end.value,
              onChanged: (value) => end.value = value,
            ),
            if (endsBeforeStart) ...[
              const SizedBox(height: AppSpacing.sm),
              InlineError(t.endsBeforeStart),
            ],
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.timeZone(zone: timeZone),
              style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(t.where),
            const SizedBox(height: AppSpacing.md),
            field(venue, t.venue, hint: t.venueHint),
            gap,
            field(address, t.address),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: field(city, t.city)),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: field(country, t.country)),
              ],
            ),
            gap,
            field(mapsUrl, t.mapsUrl, keyboard: TextInputType.url),
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(t.registration),
            const SizedBox(height: AppSpacing.sm),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: registrationOpen.value,
              onChanged: (value) => registrationOpen.value = value,
              title: Text(t.registrationOpen),
            ),
            _DateField(
              label: t.deadline,
              empty: t.noDeadline,
              value: deadline.value,
              last: start.value,
              onChanged: (value) => deadline.value = value,
            ),
            gap,
            field(
              capacity,
              t.capacity,
              hint: t.capacityHint,
              keyboard: TextInputType.number,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: asksLodging.value,
              onChanged: (value) => asksLodging.value = value,
              title: Text(t.asksLodging),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: asksDeparture.value,
              onChanged: (value) => asksDeparture.value = value,
              title: Text(t.asksDeparture),
            ),
            gap,
            field(fees, t.fees, hint: t.feesHint, maxLines: 3),
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(t.contact),
            const SizedBox(height: AppSpacing.md),
            field(contactName, t.contactName),
            gap,
            field(contactPhone, t.contactPhone, keyboard: TextInputType.phone),
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(t.visibility),
            const SizedBox(height: AppSpacing.sm),
            RadioGroup<EventStatus>(
              groupValue: status.value,
              onChanged: (value) => status.value = value ?? status.value,
              child: Column(
                children: [
                  for (final (value, label, hint) in [
                    (EventStatus.draft, t.statusDraft, t.statusDraftHint),
                    (
                      EventStatus.published,
                      t.statusPublished,
                      t.statusPublishedHint,
                    ),
                    if (event != null)
                      (
                        EventStatus.cancelled,
                        t.statusCancelled,
                        t.statusCancelledHint,
                      ),
                  ])
                    RadioListTile<EventStatus>(
                      contentPadding: EdgeInsets.zero,
                      value: value,
                      title: Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(hint),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The poster chosen (with change / remove), or a dashed box to choose one.
class _PosterPicker extends StatelessWidget {
  const _PosterPicker({
    required this.poster,
    required this.uploading,
    required this.onPick,
    required this.onRemove,
  });

  final EventImage? poster;
  final bool uploading;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final t = context.t.events.admin;
    final scheme = Theme.of(context).colorScheme;
    final preview = SizedBox(
      width: 144,
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (poster != null)
                EventPicture(poster)
              else
                DashedOutline(
                  color: scheme.outline,
                  strokeWidth: 1.5,
                  radius: AppRadius.md,
                  child: Center(
                    child: Icon(
                      AppIcons.image,
                      size: 32,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              if (uploading)
                ColoredBox(
                  color: scheme.surface.withValues(alpha: 0.7),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          button: true,
          label: poster == null ? t.posterAdd : t.posterChange,
          child: GestureDetector(
            onTap: uploading ? null : onPick,
            child: preview,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlinedButton.icon(
                onPressed: uploading ? null : onPick,
                icon: const Icon(AppIcons.image, size: 18),
                label: Text(poster == null ? t.posterAdd : t.posterChange),
              ),
              if (poster != null)
                TextButton(
                  onPressed: uploading ? null : onRemove,
                  child: Text(t.posterRemove),
                ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                uploading ? t.uploading : t.posterHint,
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Début   ven. 20 nov. 2026   08:00": a date button and a time button.
class _DateTimeField extends StatelessWidget {
  const _DateTimeField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    Future<void> pickDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        onChanged(
          DateTime(
            picked.year,
            picked.month,
            picked.day,
            value.hour,
            value.minute,
          ),
        );
      }
    }

    Future<void> pickTime() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(value),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      );
      if (picked != null) {
        onChanged(
          DateTime(
            value.year,
            value.month,
            value.day,
            picked.hour,
            picked.minute,
          ),
        );
      }
    }

    return LabeledField(
      label: label,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: OutlinedButton.icon(
              onPressed: pickDate,
              icon: const Icon(AppIcons.calendar, size: 18),
              label: Text(context.formatDate(value, 'EEE d MMM y')),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 2,
            child: OutlinedButton.icon(
              onPressed: pickTime,
              icon: const Icon(AppIcons.time, size: 18),
              label: Text(context.time(value)),
            ),
          ),
        ],
      ),
    );
  }
}

/// A day that may stay empty (the registration deadline).
class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.empty,
    required this.value,
    required this.last,
    required this.onChanged,
  });

  final String label;
  final String empty;
  final DateTime? value;
  final DateTime last;
  final ValueChanged<DateTime?> onChanged;

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    return LabeledField(
      label: label,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: value ?? last,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  onChanged(picked);
                }
              },
              icon: const Icon(AppIcons.calendarCheck, size: 18),
              label: Text(
                value == null
                    ? empty
                    : context.formatDate(value, 'EEEE d MMMM y').capitalized,
              ),
            ),
          ),
          if (value != null)
            IconButton(
              tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
              icon: const Icon(AppIcons.close),
              onPressed: () => onChanged(null),
            ),
        ],
      ),
    );
  }
}
