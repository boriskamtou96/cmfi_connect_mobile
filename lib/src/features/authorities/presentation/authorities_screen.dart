import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../application/authorities_controller.dart';
import '../domain/authority.dart';
import 'authority_form_screen.dart';

/// "My spiritual authorities": the disciple maker first, then the other leaders.
@RoutePage()
class AuthoritiesScreen extends ConsumerWidget {
  const AuthoritiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final authorities = ref.watch(authoritiesControllerProvider);
    final requests =
        ref.watch(authorityRequestsProvider).value ??
        const <AuthorityRequest>[];

    Future<void> answer(
      AuthorityRequest request, {
      required bool accept,
    }) async {
      final toast = ref.read(toasterProvider).of(context);
      final name = request.from.fullName;
      try {
        await ref
            .read(authorityRequestsProvider.notifier)
            .answer(request, accept: accept);
        toast.success(
          accept
              ? t.authorities.acceptedRequest(name: name)
              : t.authorities.declinedRequest(name: name),
        );
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      }
    }

    Future<void> remove(Authority authority) async {
      final confirmed = await showConfirmDialog(
        context,
        title: t.authorities.removeTitle(name: authority.fullName),
        text: t.authorities.removeText(name: authority.fullName),
        confirmLabel: t.authorities.remove,
        destructive: true,
      );
      if (!confirmed || !context.mounted) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      try {
        await ref
            .read(authoritiesControllerProvider.notifier)
            .remove(authority);
        toast.success(t.authorities.removed(name: authority.fullName));
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      }
    }

    Future<void> makeDiscipleMaker(Authority authority) async {
      final current = (authorities.value ?? const <Authority>[]).where(
        (other) => other.isDiscipleMaker,
      );
      final former = current.isEmpty ? null : current.first.fullName;
      final confirmed = await showConfirmDialog(
        context,
        title: t.authorities.makeMakerTitle(name: authority.fullName),
        text: former == null
            ? t.authorities.makeMakerText(name: authority.fullName)
            : t.authorities.makeMakerTextFormer(
                name: authority.fullName,
                former: former,
              ),
        confirmLabel: t.authorities.makeMaker,
      );
      if (!confirmed || !context.mounted) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      try {
        await ref
            .read(authoritiesControllerProvider.notifier)
            .chooseDiscipleMaker(authority);
        toast.success(t.authorities.madeMaker(name: authority.fullName));
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      }
    }

    return SubPage(
      title: t.authorities.title,
      child: switch (authorities) {
        AsyncValue(value: final list?) => RefreshIndicator.adaptive(
          onRefresh: () {
            ref.invalidate(authorityRequestsProvider);
            return ref
                .refresh(authoritiesControllerProvider.future)
                .then((_) {}, onError: (_) {});
          },
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              FadeSlideIn(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: Text(
                    t.authorities.intro,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // members who ask the user to accompany them
              if (requests.isNotEmpty) ...[
                FadeSlideIn(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SectionLabel(t.authorities.requests),
                      const SizedBox(height: AppSpacing.md),
                      SectionCard(
                        children: [
                          for (final request in requests)
                            _RequestRow(
                              request: request,
                              onAnswer: (accept) =>
                                  answer(request, accept: accept),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
              ],
              if (list.isEmpty)
                FadeSlideIn(index: 1, child: const _EmptyState())
              else ...[
                FadeSlideIn(
                  index: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SectionLabel(t.authorities.discipleMaker),
                      const SizedBox(height: AppSpacing.md),
                      if (list
                              .where((authority) => authority.isDiscipleMaker)
                              .firstOrNull
                          case final maker?)
                        SectionCard(
                          children: [
                            _AuthorityRow(
                              authority: maker,
                              onRemove: () => remove(maker),
                            ),
                            // a member: receives the user's reports
                            if (maker.username != null &&
                                maker.status != AuthorityStatus.declined)
                              _SharingSwitch(maker: maker),
                          ],
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                          ),
                          child: Text(
                            t.authorities.noDiscipleMaker,
                            style: TextStyle(color: scheme.onSurfaceVariant),
                          ),
                        ),
                    ],
                  ),
                ),
                if (list.any((authority) => !authority.isDiscipleMaker)) ...[
                  const SizedBox(height: 22),
                  FadeSlideIn(
                    index: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SectionLabel(t.authorities.others),
                        const SizedBox(height: AppSpacing.md),
                        SectionCard(
                          children: [
                            for (final authority in list.where(
                              (authority) => !authority.isDiscipleMaker,
                            )) ...[
                              _AuthorityRow(
                                authority: authority,
                                onRemove: () => remove(authority),
                                onMakeDiscipleMaker:
                                    authority.status == AuthorityStatus.declined
                                    ? null
                                    : () => makeDiscipleMaker(authority),
                              ),
                              // a member: receives the user's reports
                              if (authority.username != null &&
                                  authority.status != AuthorityStatus.declined)
                                _SharingSwitch(maker: authority),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                FadeSlideIn(index: 3, child: const _AddButton()),
              ],
            ],
          ),
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(authoritiesControllerProvider),
        ),
        _ => const LoadingList(count: 3, leading: 44),
      },
    );
  }
}

class _AuthorityRow extends StatelessWidget {
  const _AuthorityRow({
    required this.authority,
    required this.onRemove,
    this.onMakeDiscipleMaker,
  });

  final Authority authority;
  final VoidCallback onRemove;

  /// Another authority: can become the disciple maker.
  final VoidCallback? onMakeDiscipleMaker;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    // final email = (authority.email ?? '').isEmpty ? null : authority.email;
    // final phone = authority.phoneNumber ?? '';
    final contact = [
      if (authority.username case final username?) '@$username',
      // if (phone.isNotEmpty) formatPhone(phone),
      // ?email,
    ];

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        14,
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          MemberAvatar(
            initials: authority.initials,
            photo: authority.avatar,
            size: 44,
            background: authority.isDiscipleMaker
                ? tones.personalSoft
                : scheme.primaryContainer,
            foreground: authority.isDiscipleMaker
                ? tones.personal
                : scheme.primary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      authority.fullName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    switch (authority.status) {
                      AuthorityStatus.pending => StatusPill(
                        t.authorities.statusPending,
                      ),
                      AuthorityStatus.declined => StatusPill(
                        t.authorities.statusDeclined,
                        background: scheme.errorContainer,
                        foreground: scheme.onErrorContainer,
                      ),
                      AuthorityStatus.accepted => const SizedBox.shrink(),
                    },
                  ],
                ),
                for (final line in contact)
                  Text(
                    line,
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          if (onMakeDiscipleMaker != null)
            IconButton(
              tooltip: t.authorities.makeMaker,
              onPressed: onMakeDiscipleMaker,
              icon: Icon(
                AppIcons.makeDiscipleMaker,
                color: scheme.onSurfaceVariant,
              ),
            ),
          IconButton(
            tooltip: t.authorities.remove,
            onPressed: onRemove,
            icon: Icon(AppIcons.userRemove, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: PhosphorIcon(
              AppIcons.authoritiesTile,
              size: 32,
              color: scheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            t.authorities.empty,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.lg),
          const _AddButton(),
        ],
      ),
    );
  }
}

/// "Marc Tientcheu (@marc.t) te demande d'être son faiseur de disciples"
class _RequestRow extends StatelessWidget {
  const _RequestRow({required this.request, required this.onAnswer});

  final AuthorityRequest request;
  final ValueChanged<bool> onAnswer;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final from = request.from;

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              MemberAvatar(
                initials: from.initials,
                photo: from.avatar,
                size: 44,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      from.fullName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      [
                        '@${from.username}',
                        if (from.place.isNotEmpty) from.place,
                      ].join(' · '),
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            request.isDiscipleMaker
                ? t.authorities.requestDiscipleMaker
                : t.authorities.requestAuthority,
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () => onAnswer(false),
                  child: Text(t.authorities.decline),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () => onAnswer(true),
                  child: Text(t.authorities.accept),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// "Ajouter une autorité": the button grows into the form.
class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) {
    return OpenPage(
      page: const AuthorityFormScreen(),
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      builder: (context, open) => FilledButton.icon(
        onPressed: open,
        icon: const Icon(AppIcons.userAdd),
        label: Text(context.t.authorities.add),
      ),
    );
  }
}

/// Whether an authority (the disciple maker or another one, a member of the
/// app) receives the user's reports: the items filled in, the regularity and
/// the percentages, never the note. On by default.
class _SharingSwitch extends HookConsumerWidget {
  const _SharingSwitch({required this.maker});

  final Authority maker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.authorities.sharing;
    final scheme = Theme.of(context).colorScheme;
    final busy = useState(false);
    final name = maker.firstName.isEmpty ? maker.fullName : maker.firstName;

    Future<void> change(bool shares) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      busy.value = true;
      try {
        await ref
            .read(authoritiesControllerProvider.notifier)
            .setSharing(maker, shares: shares);
        toast.success(
          shares
              ? messages.authorities.sharing.on(name: name)
              : messages.authorities.sharing.off(name: name),
        );
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    return MergeSemantics(
      child: SwitchListTile.adaptive(
        contentPadding: const EdgeInsetsDirectional.fromSTEB(
          14,
          AppSpacing.xs,
          AppSpacing.md,
          AppSpacing.xs,
        ),
        title: Text(
          t.title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          t.help(name: name),
          style: TextStyle(
            fontSize: 13,
            height: 1.4,
            color: scheme.onSurfaceVariant,
          ),
        ),
        value: maker.sharesRegularity,
        onChanged: busy.value ? null : change,
      ),
    );
  }
}
