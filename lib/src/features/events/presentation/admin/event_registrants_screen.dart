import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/link_launcher.dart';
import '../../../../core/services/share_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/rolling_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../core/widgets/sub_page.dart';
import '../../../members/presentation/widgets/member_avatar.dart';
import '../../application/event_admin.dart';
import '../../application/events_providers.dart';
import '../../domain/event.dart';
import '../widgets/event_format.dart';
import '../widgets/program_view.dart';

/// Who comes: totals for the organizers (people, beds, departure cities),
/// then each registration, to call or export.
@RoutePage()
class EventRegistrantsScreen extends ConsumerWidget {
  const EventRegistrantsScreen({
    @PathParam('eventId') required this.eventId,
    super.key,
  });

  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events.admin;
    final registrations = ref.watch(eventRegistrationsProvider(eventId));
    final title = ref.watch(eventDetailProvider(eventId)).value?.title ?? '';
    final data = registrations.value;

    Future<void> export(Rect? origin) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      try {
        await ref
            .read(shareServiceProvider)
            .shareFile(
              registrantsCsv(context, data!),
              name: '${_slug(title)}.csv',
              mimeType: 'text/csv',
              subject: title,
              origin: origin,
            );
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      }
    }

    return SubPage(
      title: t.registrants,
      actions: [
        if (data != null && data.registrants.isNotEmpty)
          Builder(
            builder: (context) => IconButton(
              tooltip: t.exportCsv,
              icon: const Icon(AppIcons.download),
              onPressed: () {
                final box = context.findRenderObject() as RenderBox?;
                export(
                  box == null
                      ? null
                      : box.localToGlobal(Offset.zero) & box.size,
                );
              },
            ),
          ),
      ],
      child: switch (registrations) {
        AsyncValue(value: final data?) => RefreshIndicator(
          onRefresh: () => ref
              .refresh(eventRegistrationsProvider(eventId).future)
              .then((_) {}, onError: (_) {}),
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              if (title.isNotEmpty) ...[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              FadeSlideIn(
                child: Row(
                  children: [
                    _Total(
                      label: t.totalRegistrations,
                      value: data.registrations,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _Total(label: t.totalPeople, value: data.people),
                    const SizedBox(width: AppSpacing.sm),
                    _Total(label: t.totalLodging, value: data.lodging),
                  ],
                ),
              ),
              if (data.registrants.isEmpty)
                TabEmpty(t.registrantsEmpty)
              else ...[
                if (data.cities.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  FadeSlideIn(
                    index: 1,
                    child: SectionCard(
                      header: t.byCity,
                      children: [
                        for (final city in data.cities)
                          ListTile(
                            dense: true,
                            leading: const Icon(AppIcons.departure, size: 20),
                            title: Text(
                              city.city,
                              style: const TextStyle(fontSize: 15),
                            ),
                            trailing: Text(
                              context.t.events.people(
                                n: city.people,
                                count: context.count(city.people),
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                FadeSlideIn(
                  index: 2,
                  child: SectionCard(
                    header: t.list,
                    children: [
                      for (final registrant in data.registrants)
                        _RegistrantRow(registrant: registrant),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        AsyncValue(:final error?) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(eventRegistrationsProvider(eventId)),
        ),
        // the totals, then the members registered
        _ => const SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          child: Shimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SkeletonBox(height: 70, radius: AppRadius.lg),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: SkeletonBox(height: 70, radius: AppRadius.lg),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: SkeletonBox(height: 70, radius: AppRadius.lg),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xl),
                SkeletonList(count: 5, lines: 3),
              ],
            ),
          ),
        ),
      },
    );
  }
}

class _Total extends StatelessWidget {
  const _Total({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.events.tone(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tone.soft,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RollingText(
              NumberFormat.decimalPattern(
                Localizations.localeOf(context).toLanguageTag(),
              ).format(value),
              value: value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: tone.onSoft,
              ),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: tone.onSoft),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegistrantRow extends ConsumerWidget {
  const _RegistrantRow({required this.registrant});

  final Registrant registrant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final card = registrant.card;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          MemberAvatar(initials: card.initials, photo: card.avatar, size: 40),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.fullName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (card.place.isNotEmpty)
                  Text(
                    card.place,
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                Text(
                  [
                    t.people(
                      n: registrant.people,
                      count: context.count(registrant.people),
                    ),
                    if (registrant.needsLodging) t.register.lodgingShort,
                    if (registrant.departureCity.isNotEmpty)
                      registrant.departureCity,
                  ].join(' · '),
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (registrant.phoneNumber.isNotEmpty)
            IconButton(
              tooltip: t.call(name: card.fullName),
              icon: const Icon(AppIcons.phone),
              onPressed: () =>
                  ref.read(linkLauncherProvider).call(registrant.phoneNumber),
            ),
        ],
      ),
    );
  }
}

/// The registrations as a spreadsheet: ";" in French (Excel), UTF-8 BOM.
Uint8List registrantsCsv(BuildContext context, EventRegistrations data) {
  final t = context.t.events.admin;
  final separator = t.csvHeader.contains(';') ? ';' : ',';
  String cell(String text) =>
      text.contains(separator) || text.contains('"') || text.contains('\n')
      ? '"${text.replaceAll('"', '""')}"'
      : text;
  final day = DateFormat.yMd(Localizations.localeOf(context).toLanguageTag());
  final lines = [
    t.csvHeader,
    for (final registrant in data.registrants)
      [
        registrant.card.fullName,
        registrant.username,
        registrant.phoneNumber,
        registrant.church,
        registrant.assembly,
        '${registrant.people}',
        registrant.needsLodging ? t.yes : t.no,
        registrant.departureCity,
        day.format(registrant.createdAt.toLocal()),
      ].map(cell).join(separator),
  ];
  return Uint8List.fromList([
    0xEF,
    0xBB,
    0xBF,
    ...utf8.encode('${lines.join('\r\n')}\r\n'),
  ]);
}

/// "Conférence annuelle 2026" -> "conference-annuelle-2026-inscrits".
String _slug(String title) {
  const accents = {
    'à': 'a',
    'â': 'a',
    'ä': 'a',
    'é': 'e',
    'è': 'e',
    'ê': 'e',
    'ë': 'e',
    'î': 'i',
    'ï': 'i',
    'ô': 'o',
    'ö': 'o',
    'ù': 'u',
    'û': 'u',
    'ü': 'u',
    'ç': 'c',
  };
  final plain = title
      .toLowerCase()
      .split('')
      .map((char) => accents[char] ?? char)
      .join()
      .replaceAll(RegExp('[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');
  return plain.isEmpty ? 'inscrits' : '$plain-inscrits';
}
