import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/countries.dart';
import '../../../core/utils/phone.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routing/app_router.dart';
import '../../members/application/my_account.dart';
import '../application/current_profile.dart';
import 'widgets/profile_photo.dart';

/// « Mon profil », the member's card (validated on 23/10/2026, reduced on
/// 19/11/2026 after the design critique): the photo (crowned with Premium),
/// the name, the pseudo and the church, « Modifier mon profil »; under it,
/// what the member filled in (number, church, assembly, city, country), a
/// touch opening the form. Their numbers, their way and the people they walk
/// with are in « Vous », the tab this card opens from; the settings too.
@RoutePage()
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final profile = ref.watch(currentProfileProvider).value;
    final account = ref.watch(myAccountProvider).value;
    // an incomplete profile (no name on the server) invites to fill it in
    final missingName = profile != null && !profile.hasName;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          children: [
            _Header(
              name: missingName
                  ? t.more.completeProfile
                  : profile?.fullName ?? '',
              details: [
                if ((account?.username ?? '').isNotEmpty)
                  '@${account!.username}',
                ?profile?.church,
                ?profile?.assembly,
              ].where((part) => part.isNotEmpty).join(' · '),
            ),
            if (profile != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  22,
                  AppSpacing.lg,
                  0,
                ),
                child: FadeSlideIn(
                  child: _Details(
                    rows: [
                      (
                        icon: AppIcons.phone,
                        label: t.auth.phone,
                        // isolated left to right: in Arabic the digits of
                        // the number would show reversed
                        value:
                            '\u2066${formatPhone(profile.phoneNumber)}\u2069',
                      ),
                      (
                        icon: AppIcons.churchTile,
                        label: t.auth.church.church,
                        value: profile.church ?? '',
                      ),
                      (
                        icon: AppIcons.churchTile,
                        label: t.auth.church.assembly,
                        value: profile.assembly ?? '',
                      ),
                      (
                        icon: AppIcons.place,
                        label: t.auth.church.city,
                        value: profile.city ?? '',
                      ),
                      (
                        icon: AppIcons.nationsTile,
                        label: t.auth.church.country,
                        value: switch (Country.tryParse(profile.country)) {
                          final country? =>
                            '${country.flag} ${country.name(LocaleSettings.currentLocale.languageCode)}',
                          null => profile.country ?? '',
                        },
                      ),
                    ].where((row) => row.value.trim().isNotEmpty).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// The card, on the night blue: back and the title; the photo, the name, the
/// pseudo and the church; « Modifier mon profil ».
class _Header extends StatelessWidget {
  const _Header({required this.name, required this.details});

  final String name;
  final String details;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final top = MediaQuery.paddingOf(context).top;
    void edit() => context.router.push(ChurchFormRoute(isEditing: true));

    return Container(
      padding: EdgeInsets.fromLTRB(0, top, 0, 26),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0B3B70), AppColors.primaryDeep],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PositionedDirectional(
            end: -90,
            top: -40,
            child: BrandRing(
              size: 260,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          Column(
            children: [
              IconTheme(
                data: const IconThemeData(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      const AppBackButton(),
                      Expanded(
                        child: Text(
                          t.me.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // the width of the back button: the title stays centred
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const ProfilePhotoButton(onNight: true),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Column(
                  children: [
                    // the name opens the form too (« Ajoute ton nom »)
                    Semantics(
                      button: true,
                      child: GestureDetector(
                        onTap: edit,
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                    ),
                    if (details.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        details,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    // a pill of 36 pt in a target of 48 dp at least
                    InkWell(
                      onTap: edit,
                      customBorder: const StadiumBorder(),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 48),
                        child: Center(
                          widthFactor: 1,
                          child: DecoratedBox(
                            decoration: ShapeDecoration(
                              color: Colors.white.withValues(alpha: 0.14),
                              shape: const StadiumBorder(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 9,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    AppIcons.edit,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      t.me.edit,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

typedef _Row = ({IconData icon, String label, String value});

/// What the member filled in, label above value; a touch opens the form.
class _Details extends StatelessWidget {
  const _Details({required this.rows});

  final List<_Row> rows;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (rows.isEmpty) {
      return const SizedBox.shrink();
    }
    return SectionCard(
      children: [
        for (final row in rows)
          ListTile(
            leading: Icon(row.icon, color: scheme.onSurfaceVariant),
            title: Text(
              row.label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: scheme.onSurfaceVariant,
              ),
            ),
            subtitle: Text(
              row.value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            onTap: () => context.router.push(ChurchFormRoute(isEditing: true)),
          ),
      ],
    );
  }
}
