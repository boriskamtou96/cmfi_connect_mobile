import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/services/share_service.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/phone.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../../authorities/application/authorities_controller.dart';
import '../../authorities/domain/authority.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../../profile/application/current_profile.dart';
import '../application/report_files.dart';
import '../application/report_goals.dart';
import '../application/report_sending.dart';
import '../application/reports_providers.dart';
import '../domain/report_export.dart';
import '../domain/report_sending.dart';
import 'report_sending_screen.dart';

/// The report of a period ready to send (opened by the notification of a
/// sending, or "Prepare now"): the message, then one tap per authority,
/// WhatsApp or e-mail; or the PDF through the share sheet. [day] is the day
/// of the sending ("2026-10-18"): the period ends that day, or is the month
/// before.
@RoutePage()
class ReportSendScreen extends HookConsumerWidget {
  const ReportSendScreen({@PathParam('day') required this.day, super.key});

  final String day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final s = t.sending;
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final settings = ref.watch(reportSendingProvider);
    final sendDay = DateTime.tryParse(day)?.dateOnly ?? today();
    final period = sendingPeriod(settings.rhythm, sendDay);
    final history = ref.watch(
      reportHistoryProvider(from: period.from, to: period.to),
    );
    final activities = ref.watch(activitiesProvider);
    final profile = ref.watch(currentProfileProvider).value;
    final recipients = [
      for (final authority
          in ref.watch(authoritiesControllerProvider).value ??
              const <Authority>[])
        if (authority.status == AuthorityStatus.accepted &&
            settings.authorityIds.contains(authority.id))
          authority,
    ];
    // who it went to on this screen
    final sentTo = useState(<int>{});
    final busy = useState(false);
    final periodLabel = exportPeriodLabel(t, locale, period.from, period.to);

    final days = history.value;
    final items = activities.value;
    if (days == null || items == null) {
      final error = history.error ?? activities.error;
      return SubPage(
        title: s.readyTitle,
        child: error == null
            // the period, the authorities, then the text of the report
            ? SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: Shimmer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SkeletonLine(widthFactor: 0.5),
                      const SizedBox(height: AppSpacing.lg),
                      const SkeletonList(count: 2),
                      const SizedBox(height: AppSpacing.xl),
                      for (final width in const [0.9, 1.0, 0.8, 0.95, 0.6]) ...[
                        SkeletonLine(widthFactor: width),
                        const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
              )
            : ErrorView(
                error: error,
                onRetry: () => ref
                  ..invalidate(reportHistoryProvider)
                  ..invalidate(activitiesProvider),
              ),
      );
    }

    final owner = (name: profile?.fullName ?? '', church: profile?.church);
    final data = ReportExport.build(
      from: period.from,
      to: period.to,
      history: days,
      activities: items,
      goals: ref.read(reportGoalsProvider),
    );
    final text = reportAsText(data, t: t, locale: locale, owner: owner);
    final subject = t.export.subject(period: periodLabel);
    String message(Authority authority) =>
        '${s.greeting(name: authority.firstName)}\n\n$text';

    Future<void> recordSent(String name) => ref
        .read(sentReportsProvider.notifier)
        .add(from: period.from, to: period.to, name: name);

    Future<void> send(Authority authority, Uri uri) async {
      final links = ref.read(linkLauncherProvider);
      if (await links.open(uri)) {
        sentTo.value = {...sentTo.value, authority.id};
        await recordSent(authority.fullName);
      }
    }

    // wa.me wants the international number, digits only
    Uri whatsApp(Authority authority) {
      final country = ref.read(phoneCountryProvider);
      final raw = authority.phoneNumber ?? '';
      final number = parsePhone(raw, country);
      final digits = (number == null ? raw : number.international).replaceAll(
        RegExp('[^0-9]'),
        '',
      );
      return Uri.https('wa.me', '/$digits', {'text': message(authority)});
    }

    // spaces as %20, not "+", which mail apps show as is
    Uri email(Authority authority) => Uri.parse(
      'mailto:${authority.email}'
      '?subject=${Uri.encodeComponent(subject)}'
      '&body=${Uri.encodeComponent(message(authority))}',
    );

    Future<void> share({required bool pdf, Rect? origin}) async {
      final toast = ref.read(toasterProvider).of(context);
      final service = ref.read(shareServiceProvider);
      final sharedName = s.shared;
      busy.value = true;
      try {
        if (pdf) {
          await service.shareFile(
            await reportAsPdf(data, t: t, locale: locale, owner: owner),
            name:
                '${t.export.fileName}_${period.from.toApiDate()}_'
                '${period.to.toApiDate()}.pdf',
            mimeType: 'application/pdf',
            subject: subject,
            origin: origin,
          );
        } else {
          await service.shareText(text, subject: subject, origin: origin);
        }
        await recordSent(sharedName);
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    Rect? originOf(BuildContext context) {
      final box = context.findRenderObject() as RenderBox?;
      return box == null ? null : box.localToGlobal(Offset.zero) & box.size;
    }

    return SubPage(
      title: s.readyTitle,
      actions: [
        IconButton(
          tooltip: s.settings,
          icon: const Icon(AppIcons.settings),
          onPressed: () => context.router.push(const ReportSendingRoute()),
        ),
      ],
      bottom: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: SafeArea(
          top: false,
          child: Builder(
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppButton(
                  label: s.sharePdf,
                  isLoading: busy.value,
                  onPressed: () => share(pdf: true, origin: originOf(context)),
                ),
                TextButton(
                  onPressed: busy.value
                      ? null
                      : () => share(pdf: false, origin: originOf(context)),
                  child: Text(s.shareText),
                ),
              ],
            ),
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          FadeSlideIn(
            child: Text(
              periodLabel,
              style: TextStyle(fontSize: 15, color: scheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FadeSlideIn(
            index: 1,
            child: SectionCard(
              header: s.recipients,
              children: [
                if (recipients.isEmpty)
                  ListTile(
                    title: Text(s.noRecipients),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () =>
                        context.router.push(const ReportSendingRoute()),
                  )
                else
                  for (final authority in recipients)
                    _Recipient(
                      authority: authority,
                      sent: sentTo.value.contains(authority.id),
                      onWhatsApp: (authority.phoneNumber ?? '').isEmpty
                          ? null
                          : () => send(authority, whatsApp(authority)),
                      onEmail: (authority.email ?? '').isEmpty
                          ? null
                          : () => send(authority, email(authority)),
                    ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FadeSlideIn(
            index: 2,
            child: SectionCard(
              header: s.preview,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.xs,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  child: SelectableText(
                    text,
                    style: const TextStyle(fontSize: 14, height: 1.45),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// An authority it goes to: WhatsApp and e-mail when known, "Envoyé" once
/// done.
class _Recipient extends StatelessWidget {
  const _Recipient({
    required this.authority,
    required this.sent,
    required this.onWhatsApp,
    required this.onEmail,
  });

  final Authority authority;
  final bool sent;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onEmail;

  @override
  Widget build(BuildContext context) {
    final s = context.t.sending;
    final tones = AppTones.of(context);

    return ListTile(
      leading: MemberAvatar(
        initials: authority.initials,
        photo: authority.avatar,
        size: 40,
      ),
      title: Text(
        authority.fullName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: sent
          ? Text(
              s.sent,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: tones.personal,
              ),
            )
          : Text(sendingChannels(context.t, authority)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onWhatsApp case final open?)
            IconButton.filledTonal(
              tooltip: s.whatsApp,
              onPressed: open,
              icon: const Icon(AppIcons.whatsApp),
            ),
          if (onEmail case final open?)
            IconButton.filledTonal(
              tooltip: s.email,
              onPressed: open,
              icon: const Icon(AppIcons.email),
            ),
        ],
      ),
    );
  }
}
