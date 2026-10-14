import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../../authorities/application/authorities_controller.dart';
import '../../authorities/domain/authority.dart';
import '../application/report_files.dart';
import '../application/report_sending.dart';
import '../domain/report_sending.dart';

/// "Par WhatsApp", "Par e-mail"…: how an authority can get the report.
String sendingChannels(Translations t, Authority authority) {
  final phone = (authority.phoneNumber ?? '').isNotEmpty;
  final email = (authority.email ?? '').isNotEmpty;
  return switch ((phone, email)) {
    (true, true) => t.sending.viaBoth,
    (true, false) => t.sending.viaWhatsApp,
    (false, true) => t.sending.viaEmail,
    _ => t.sending.viaShare,
  };
}

/// The settings of the regular sending of the report to the authorities:
/// on or off, the rhythm, the day and time, who it goes to; then the last
/// reports sent.
@RoutePage()
class ReportSendingScreen extends ConsumerWidget {
  const ReportSendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final s = t.sending;
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final settings = ref.watch(reportSendingProvider);
    final notifier = ref.read(reportSendingProvider.notifier);
    final sent = ref.watch(sentReportsProvider);
    final authorities = [
      for (final authority
          in ref.watch(authoritiesControllerProvider).value ??
              const <Authority>[])
        if (authority.status == AuthorityStatus.accepted) authority,
    ];
    final next = settings.enabled
        ? sendingTimes(settings, now: DateTime.now(), count: 1).firstOrNull
        : null;

    Future<void> toggle(bool on) async {
      if (!on) {
        await notifier.disable();
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final denied = s.permissionDenied;
      if (!await notifier.enable()) {
        toast.info(denied);
      }
    }

    Future<void> pickTime() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: settings.time,
      );
      if (picked != null) {
        await notifier.save(settings.copyWith(time: picked));
      }
    }

    // Monday to Sunday, in the order and the words of the language
    final weekdays = [
      for (var day = DateTime.monday; day <= DateTime.sunday; day++) day,
    ];
    String weekdayName(int weekday) => DateFormat.E(
      locale,
    ).format(DateTime(2024, 1, weekday)); // 1 January 2024: a Monday

    return SubPage(
      title: s.title,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        children: [
          FadeSlideIn(
            child: Text(
              s.intro,
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FadeSlideIn(
            index: 1,
            child: SectionCard(
              children: [
                SwitchListTile(
                  value: settings.enabled,
                  onChanged: toggle,
                  title: Text(
                    s.enabled,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: next == null
                      ? null
                      : Text(
                          s.next(
                            date: DateFormat(
                              'EEEE d MMMM, HH:mm',
                              locale,
                            ).format(next),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FadeSlideIn(
            index: 2,
            child: SectionCard(
              header: s.rhythm,
              children: [
                RadioGroup<SendingRhythm>(
                  groupValue: settings.rhythm,
                  onChanged: (rhythm) {
                    if (rhythm != null) {
                      notifier.save(settings.copyWith(rhythm: rhythm));
                    }
                  },
                  child: Column(
                    children: [
                      for (final rhythm in SendingRhythm.values)
                        RadioListTile<SendingRhythm>(
                          value: rhythm,
                          title: Text(switch (rhythm) {
                            SendingRhythm.weekly => s.weekly,
                            SendingRhythm.biweekly => s.biweekly,
                            SendingRhythm.monthly => s.monthly,
                          }),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.day,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      if (settings.rhythm == SendingRhythm.monthly)
                        Text(
                          s.monthlyDay,
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        )
                      else
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            for (final weekday in weekdays)
                              ChoiceChip(
                                label: Text(weekdayName(weekday)),
                                selected: settings.weekday == weekday,
                                onSelected: (_) => notifier.save(
                                  settings.copyWith(weekday: weekday),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    s.time,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        settings.time.format(context),
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Icon(AppIcons.chevronRight),
                    ],
                  ),
                  onTap: pickTime,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FadeSlideIn(
            index: 3,
            child: SectionCard(
              header: s.recipients,
              children: [
                if (authorities.isEmpty)
                  ListTile(
                    title: Text(s.noAuthorities),
                    subtitle: Text(
                      s.addAuthorities,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: scheme.primary,
                      ),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const AuthoritiesRoute()),
                  )
                else
                  for (final authority in authorities)
                    CheckboxListTile(
                      value: settings.authorityIds.contains(authority.id),
                      onChanged: (checked) => notifier.save(
                        settings.copyWith(
                          authorityIds: [
                            ...settings.authorityIds.where(
                              (id) => id != authority.id,
                            ),
                            if (checked ?? false) authority.id,
                          ],
                        ),
                      ),
                      title: Text(
                        authority.fullName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(sendingChannels(t, authority)),
                    ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FadeSlideIn(
            index: 4,
            child: OutlinedButton.icon(
              onPressed: () => context.router.push(
                ReportSendRoute(day: today().toApiDate()),
              ),
              icon: const Icon(AppIcons.share),
              label: Text(s.prepareNow),
            ),
          ),
          if (sent.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            SectionCard(
              header: s.history,
              children: [
                for (final report in sent)
                  ListTile(
                    leading: Icon(
                      AppIcons.checkCircle,
                      color: AppTones.of(context).personal,
                    ),
                    title: Text(
                      exportPeriodLabel(t, locale, report.from, report.to),
                    ),
                    subtitle: Text(
                      '${DateFormat.MMMd(locale).format(report.at)} · '
                      '${report.names.join(', ')}',
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
