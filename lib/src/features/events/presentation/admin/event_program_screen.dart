import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/zoned_time.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../core/widgets/sub_page.dart';
import '../../application/event_admin.dart';
import '../../application/events_providers.dart';
import '../../domain/event.dart';
import '../../domain/event_draft.dart';
import '../widgets/event_format.dart';
import '../widgets/program_view.dart';

/// The main CMFI hymn book (first of assets/hymns/index.json): the one of the
/// numbers typed in the program, unless the session already names another.
const _defaultHymnBook = 'rendons-ministere-1';

/// The admins write the program: moments by day, saved all at once.
@RoutePage()
class EventProgramScreen extends ConsumerWidget {
  const EventProgramScreen({
    @PathParam('eventId') required this.eventId,
    super.key,
  });

  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events.admin;
    return switch (ref.watch(eventDetailProvider(eventId))) {
      AsyncValue(value: final event?) => _ProgramEditor(event: event),
      AsyncValue(:final error?) => SubPage(
        title: t.program,
        child: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(eventDetailProvider(eventId)),
        ),
      ),
      _ => SubPage(
        title: t.program,
        // the moments of a day
        child: const LoadingList(count: 5, leading: 0),
      ),
    };
  }
}

class _ProgramEditor extends HookConsumerWidget {
  const _ProgramEditor({required this.event});

  final CommunityEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events.admin;
    final scheme = Theme.of(context).colorScheme;
    final sessions = useState([
      for (final session in event.sessions) SessionDraft.of(session),
    ]);
    final saving = useState(false);
    final zone = event.timeZone;

    // the days of the program, on the venue's calendar
    final days = <DateTime, List<(int, SessionDraft)>>{};
    final sorted = sessions.value.indexed.toList()
      ..sort((a, b) => a.$2.startsAt.compareTo(b.$2.startsAt));
    for (final entry in sorted) {
      final local = entry.$2.startsAt.inZone(zone);
      days
          .putIfAbsent(DateTime(local.year, local.month, local.day), () => [])
          .add(entry);
    }

    Future<void> edit([int? index]) async {
      final current = index == null ? null : sessions.value[index];
      final last = sorted.lastOrNull?.$2;
      final result = await showModalBottomSheet<_SheetResult>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: SingleChildScrollView(
            child: _SessionSheet(
              event: event,
              session: current,
              after: last?.endsAt ?? last?.startsAt,
            ),
          ),
        ),
      );
      if (result == null) {
        return;
      }
      final list = [...sessions.value];
      if (index != null) {
        list.removeAt(index);
      }
      if (result.session != null) {
        list.add(result.session!);
      }
      sessions.value = list;
    }

    Future<void> save() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      saving.value = true;
      try {
        await ref
            .read(eventAdminProvider)
            .saveProgram(event.id, sessions.value);
        toast.success(t.programSaved);
        navigator.pop();
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          saving.value = false;
        }
      }
    }

    return SubPage(
      title: t.program,
      bottom: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: AppButton(
          label: t.saveProgram,
          isLoading: saving.value,
          onPressed: save,
        ),
      ),
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          Text(
            event.title,
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          if (days.isEmpty) TabEmpty(t.programEmpty),
          for (final MapEntry(key: day, value: entries) in days.entries) ...[
            SectionLabel(context.formatDate(day, 'EEEE d MMMM').capitalized),
            const SizedBox(height: AppSpacing.sm),
            SectionCard(
              children: [
                for (final (index, session) in entries)
                  ListTile(
                    onTap: () => edit(index),
                    leading: SizedBox(
                      width: 48,
                      child: Text(
                        context.time(session.startsAt.inZone(zone)),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                    title: Text(
                      session.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: session.speaker.isEmpty && session.place.isEmpty
                        ? null
                        : Text(
                            [
                              session.speaker,
                              session.place,
                            ].where((part) => part.isNotEmpty).join(' · '),
                          ),
                    trailing: const Icon(AppIcons.edit, size: 20),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          OutlinedButton.icon(
            onPressed: edit,
            icon: const Icon(AppIcons.add),
            label: Text(t.addSession),
          ),
        ],
      ),
    );
  }
}

/// The session written, or removed (session null).
typedef _SheetResult = ({SessionDraft? session});

class _SessionSheet extends HookWidget {
  const _SessionSheet({required this.event, this.session, this.after});

  final CommunityEvent event;
  final SessionDraft? session;

  /// When the program ends so far: a new moment starts there.
  final DateTime? after;

  @override
  Widget build(BuildContext context) {
    final t = context.t.events.admin;
    final zone = event.timeZone;
    final first = event.startsAt.inZone(zone);
    final lastDay = event.endsAt.inZone(zone);
    final eventDays = [
      for (
        var day = DateTime(first.year, first.month, first.day);
        !day.isAfter(DateTime(lastDay.year, lastDay.month, lastDay.day));
        day = DateTime(day.year, day.month, day.day + 1)
      )
        day,
    ];
    final startAt = (session?.startsAt ?? after ?? event.startsAt).inZone(zone);
    final endAt = session?.endsAt?.inZone(zone);
    final initialDay = eventDays.firstWhere(
      (day) =>
          day.year == startAt.year &&
          day.month == startAt.month &&
          day.day == startAt.day,
      orElse: () => eventDays.first,
    );

    final day = useState(initialDay);
    final from = useState(TimeOfDay.fromDateTime(startAt));
    final to = useState(
      endAt == null
          ? TimeOfDay(hour: (startAt.hour + 1) % 24, minute: startAt.minute)
          : TimeOfDay.fromDateTime(endAt),
    );
    final title = useTextEditingController(text: session?.title);
    final speaker = useTextEditingController(text: session?.speaker);
    final place = useTextEditingController(text: session?.place);
    final hymns = useTextEditingController(
      text: session?.hymns.map((hymn) => hymn.number).join(', '),
    );
    useListenable(title);
    final book = session?.hymns.firstOrNull?.book ?? _defaultHymnBook;

    DateTime at(TimeOfDay time) => instantAt(
      zone,
      DateTime(
        day.value.year,
        day.value.month,
        day.value.day,
        time.hour,
        time.minute,
      ),
    );

    Future<void> pick(ValueNotifier<TimeOfDay> time) async {
      final picked = await showTimePicker(
        context: context,
        initialTime: time.value,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      );
      if (picked != null) {
        time.value = picked;
      }
    }

    void done() {
      final start = at(from.value);
      var end = at(to.value);
      if (!end.isAfter(start)) {
        // past midnight (a prayer night)
        end = end.add(const Duration(days: 1));
      }
      Navigator.of(context).pop<_SheetResult>((
        session: SessionDraft(
          startsAt: start,
          endsAt: end,
          title: title.text.trim(),
          speaker: speaker.text.trim(),
          place: place.text.trim(),
          description: session?.description ?? '',
          hymns: [
            for (final number in RegExp(r'\d+').allMatches(hymns.text))
              SessionHymn(book: book, number: int.parse(number.group(0)!)),
          ],
        ),
      ));
    }

    String timeLabel(TimeOfDay time) =>
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            session == null ? t.addSession : t.editSession,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          LabeledField(
            label: t.day,
            child: DropdownButtonFormField<DateTime>(
              initialValue: day.value,
              items: [
                for (final option in eventDays)
                  DropdownMenuItem(
                    value: option,
                    child: Text(
                      context.formatDate(option, 'EEEE d MMMM').capitalized,
                    ),
                  ),
              ],
              onChanged: (value) => day.value = value ?? day.value,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: LabeledField(
                  label: t.from,
                  child: OutlinedButton.icon(
                    onPressed: () => pick(from),
                    icon: const Icon(AppIcons.time, size: 18),
                    label: Text(timeLabel(from.value)),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: LabeledField(
                  label: t.to,
                  child: OutlinedButton.icon(
                    onPressed: () => pick(to),
                    icon: const Icon(AppIcons.time, size: 18),
                    label: Text(timeLabel(to.value)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          LabeledField(
            label: t.sessionTitle,
            child: TextField(
              controller: title,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(hintText: t.sessionTitleHint),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          LabeledField(
            label: t.speaker,
            optionalText: context.t.common.optional,
            child: TextField(
              controller: speaker,
              textCapitalization: TextCapitalization.words,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          LabeledField(
            label: t.place,
            optionalText: context.t.common.optional,
            child: TextField(
              controller: place,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          LabeledField(
            label: t.hymns,
            optionalText: context.t.common.optional,
            child: TextField(
              controller: hymns,
              decoration: InputDecoration(hintText: t.hymnsHint),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          FilledButton(
            onPressed: title.text.trim().isEmpty ? null : done,
            child: Text(context.t.common.save),
          ),
          if (session != null) ...[
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () =>
                  Navigator.of(context).pop<_SheetResult>((session: null)),
              child: Text(t.removeSession),
            ),
          ],
        ],
      ),
    );
  }
}
