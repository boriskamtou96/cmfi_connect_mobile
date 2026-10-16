import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/countries.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/media_picture.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../routing/app_router.dart';
import '../application/ministry_people.dart';
import '../domain/ministry_person.dart';
import 'widgets/portrait_page.dart';

MinistryPersonKind _kindOf(String name) => MinistryPersonKind.values.firstWhere(
  (kind) => kind.name == name,
  orElse: () => MinistryPersonKind.missionary,
);

/// "🇹🇩 Tchad · Depuis 2004" for a missionary, "1920–1998" for a hero.
String _lineOf(BuildContext context, MinistryPerson person) {
  final t = context.t.ministry;
  if (person.kind == MinistryPersonKind.hero) {
    return person.years;
  }
  final language = TranslationProvider.of(context).locale.languageCode;
  final country = Country.tryCode(person.countryCode);
  return [
    if (country != null) '${country.flag} ${country.name(language)}',
    if (person.sinceYear case final year?) t.since(year: year),
  ].join(' · ');
}

/// Notre ministère › Nos missionnaires, Nos héros: the portraits written by
/// the admins, in their order. Each opens on its story.
@RoutePage()
class MinistryPeopleScreen extends ConsumerWidget {
  const MinistryPeopleScreen({
    @PathParam('kind') required this.kind,
    super.key,
  });

  /// "missionary" or "hero".
  final String kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.ministry;
    final kind = _kindOf(this.kind);
    final provider = ministryPeopleProvider(kind);
    final people = ref.watch(provider);
    final missionaries = kind == MinistryPersonKind.missionary;

    final body = switch (people) {
      AsyncValue(value: final people?) when people.isEmpty => _Empty(
        text: missionaries ? t.missionariesEmpty : t.heroesEmpty,
        icon: missionaries ? AppIcons.missionariesTile : AppIcons.heroesTile,
      ),
      AsyncValue(value: final people?) => FadeSlideIn(
        child: SectionCard(
          children: [
            for (final person in people)
              _PersonRow(
                person: person,
                onTap: () => context.router.push(
                  MinistryPersonRoute(kind: kind.name, personId: person.id),
                ),
              ),
          ],
        ),
      ),
      AsyncValue(:final error?) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(provider),
      ),
      _ => Shimmer(
        child: Column(
          children: [
            for (var i = 0; i < 3; i++)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: SkeletonRow(leading: 56),
              ),
          ],
        ),
      ),
    };

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: RefreshIndicator.adaptive(
          onRefresh: () => ref.read(provider.notifier).refresh(),
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
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
                      AppSpacing.lg,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const IconTheme(
                          data: IconThemeData(color: Colors.white),
                          child: AppBackButton(),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: AppSpacing.md,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Semantics(
                                header: true,
                                child: Text(
                                  missionaries ? t.missionaries : t.heroes,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                missionaries
                                    ? t.missionariesSubtitle
                                    : t.heroesSubtitle,
                                style: const TextStyle(
                                  fontFamily: 'Lora',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  color: AppColors.goldLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.events.tone(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: tone.soft, shape: BoxShape.circle),
            child: PhosphorIcon(icon, color: tone.onSoft, size: 36),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

/// The photo of a portrait, or the initials on gold without one.
class _Photo extends StatelessWidget {
  const _Photo({required this.person});

  final MinistryPerson person;

  @override
  Widget build(BuildContext context) {
    if (person.photo case final photo?) {
      return MediaPicture(url: photo.url, argb: photo.argb);
    }
    final initials = person.name
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .take(2)
        .map((word) => word.characters.first.toUpperCase())
        .join();
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.goldLight, AppColors.gold],
        ),
      ),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Text(
            initials,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryDeep,
            ),
          ),
        ),
      ),
    );
  }
}

class _PersonRow extends StatelessWidget {
  const _PersonRow({required this.person, required this.onTap});

  final MinistryPerson person;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final line = _lineOf(context, person);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 56,
              child: ClipOval(child: _Photo(person: person)),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (line.isNotEmpty)
                    Text(
                      line,
                      style: TextStyle(fontSize: 13, color: scheme.primary),
                    ),
                  if (person.role.isNotEmpty)
                    Text(
                      person.role,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(AppIcons.chevronRight, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

/// One portrait: the photo, the name, the nation or the years, what they
/// do, and their story.
@RoutePage()
class MinistryPersonScreen extends ConsumerWidget {
  const MinistryPersonScreen({
    @PathParam('kind') required this.kind,
    @PathParam('personId') required this.personId,
    super.key,
  });

  final String kind;
  final int personId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.ministry;
    final kind = _kindOf(this.kind);
    final people = ref.watch(ministryPeopleProvider(kind));
    final person = people.value
        ?.where((person) => person.id == personId)
        .firstOrNull;

    if (person == null) {
      return Scaffold(
        appBar: AppBar(leading: const AppBackButton()),
        body: switch (people) {
          AsyncValue(:final error?) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(ministryPeopleProvider(kind)),
          ),
          AsyncValue(hasValue: true) => Center(child: Text(t.personGone)),
          _ => const Center(child: CircularProgressIndicator.adaptive()),
        },
      );
    }

    final line = _lineOf(context, person);
    final paragraphs = person.paragraphs;

    return PortraitPage(
      label: kind == MinistryPersonKind.missionary ? t.missionaries : t.heroes,
      name: person.name,
      line: line.isEmpty ? null : line,
      detail: person.role.isEmpty ? null : person.role,
      photo: _Photo(person: person),
      photoLabel: t.photoOf(name: person.name),
      children: [
        if (paragraphs.isNotEmpty) ...[
          PortraitSection(t.story),
          PortraitStory(paragraphs: paragraphs),
        ],
      ],
    );
  }
}
