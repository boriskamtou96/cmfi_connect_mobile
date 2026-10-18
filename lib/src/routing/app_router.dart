import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/admin/presentation/admin_screen.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/authorities/presentation/authorities_screen.dart';
import '../features/authorities/presentation/authority_form_screen.dart';
import '../features/bible/presentation/bible_marks_screen.dart';
import '../features/bible/presentation/bible_plan_screen.dart';
import '../features/bible/presentation/bible_screen.dart';
import '../features/bible/presentation/bible_search_screen.dart';
import '../features/bible/presentation/concordance_screen.dart';
import '../features/bible/presentation/memory_review_screen.dart';
import '../features/bible/presentation/memory_screen.dart';
import '../features/disciples/presentation/disciple_reports_screen.dart';
import '../features/disciples/presentation/disciples_screen.dart';
import '../features/documents/presentation/documents_screen.dart';
import '../features/events/presentation/admin/admin_events_screen.dart';
import '../features/events/presentation/admin/event_form_screen.dart';
import '../features/events/presentation/admin/event_program_screen.dart';
import '../features/events/presentation/admin/event_registrants_screen.dart';
import '../features/events/presentation/event_screen.dart';
import '../features/events/presentation/events_screen.dart';
import '../features/fasts/presentation/fasts_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/home/presentation/week_story_screen.dart';
import '../features/hymns/presentation/hymn_projection_screen.dart';
import '../features/hymns/presentation/hymn_reader_screen.dart';
import '../features/hymns/presentation/hymns_screen.dart';
import '../features/members/presentation/delete_account_screen.dart';
import '../features/ministry/presentation/life_screen.dart';
import '../features/ministry/presentation/ministry_people_screen.dart';
import '../features/ministry/presentation/ministry_screen.dart';
import '../features/ministry/presentation/nations_screen.dart';
import '../features/ministry/presentation/purpose_screen.dart';
import '../features/more/presentation/more_screen.dart';
import '../features/notifications/presentation/notification_screen.dart';
import '../features/notifications/presentation/notifications_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/onboarding/presentation/splash_screen.dart';
import '../features/onboarding/presentation/welcome_screen.dart';
import '../features/prayer/domain/prayer.dart';
import '../features/prayer/presentation/blocked_members_screen.dart';
import '../features/prayer/presentation/importunity_screen.dart';
import '../features/prayer/presentation/prayer_list_screen.dart';
import '../features/prayer/presentation/prayer_screen.dart';
import '../features/prayer/presentation/prayer_topics_screen.dart';
import '../features/prayer/presentation/retreat_screen.dart';
import '../features/prayer/presentation/retreat_session_screen.dart';
import '../features/premium/presentation/premium_screen.dart';
import '../features/profile/presentation/church_form_screen.dart';
import '../features/profile/presentation/photo_crop_screen.dart';
import '../features/reports/presentation/export_screen.dart';
import '../features/reports/presentation/items_screen.dart';
import '../features/reports/presentation/new_item_screen.dart';
import '../features/reports/presentation/report_send_screen.dart';
import '../features/reports/presentation/report_sending_screen.dart';
import '../features/reports/presentation/reports_screen.dart';
import '../features/seek_first/presentation/seek_first_screen.dart';
import '../features/shell/presentation/app_shell_screen.dart';
import '../features/souls/presentation/soul_form_screen.dart';
import '../features/souls/presentation/soul_screen.dart';
import '../features/souls/presentation/souls_screen.dart';
import '../features/teachings/presentation/teaching_player_screen.dart';
import '../features/teachings/presentation/teachings_screen.dart';
import 'auth_guard.dart';
import 'fade_through_route.dart';

part 'app_router.g.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this.authGuard});

  final AuthGuard authGuard;

  // Pushed pages (items, authorities, sign-in forms…) slide like the platform,
  // with the iOS back swipe. The root flows reached with replaceAll (launch,
  // presentation, welcome, the app) fade through instead: see FadeThroughRoute.
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    // decides where to go at launch (see SplashScreen)
    CustomRoute(
      path: '/',
      page: SplashRoute.page,
      initial: true,
      customRouteBuilder: FadeThroughRoute.darkBuilder,
    ),
    CustomRoute(
      path: '/onboarding',
      page: OnboardingRoute.page,
      customRouteBuilder: FadeThroughRoute.builder,
    ),
    CustomRoute(
      path: '/welcome',
      page: WelcomeRoute.page,
      customRouteBuilder: FadeThroughRoute.darkBuilder,
    ),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/register', page: RegisterRoute.page),
    AutoRoute(path: '/forgot-password', page: ForgotPasswordRoute.page),
    CustomRoute(
      path: '/church',
      page: ChurchFormRoute.page,
      guards: [authGuard],
      customRouteBuilder: _churchFormRoute,
    ),
    CustomRoute(
      path: '/app',
      page: AppShellRoute.page,
      guards: [authGuard],
      customRouteBuilder: FadeThroughRoute.builder,
      children: [
        AutoRoute(path: 'home', page: HomeRoute.page, initial: true),
        AutoRoute(path: 'reports', page: ReportsRoute.page),
        AutoRoute(path: 'hymns', page: HymnsRoute.page),
        AutoRoute(path: 'prayer', page: PrayerRoute.page),
        AutoRoute(path: 'bible', page: BibleRoute.page),
      ],
    ),
    // Plus: opened from the photo at the top of the home screen
    AutoRoute(path: '/more', page: MoreRoute.page, guards: [authGuard]),
    AutoRoute(
      path: '/bible/search',
      page: BibleSearchRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/bible/marks',
      page: BibleMarksRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/bible/plan',
      page: BiblePlanRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/bible/concordance',
      page: ConcordanceRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/bible/memory',
      page: MemoryRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/bible/memory/review',
      page: MemoryReviewRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(path: '/items', page: ItemsRoute.page, guards: [authGuard]),
    AutoRoute(
      path: '/documents',
      page: DocumentsRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/teachings',
      page: TeachingsRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/teachings/player',
      page: TeachingPlayerRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(path: '/souls', page: SoulsRoute.page, guards: [authGuard]),
    AutoRoute(path: '/fasts', page: FastsRoute.page, guards: [authGuard]),
    AutoRoute(
      path: '/souls/edit',
      page: SoulFormRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(path: '/souls/:id', page: SoulRoute.page, guards: [authGuard]),
    AutoRoute(
      path: '/seek-first',
      page: SeekFirstRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/prayer/retreat',
      page: RetreatRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/prayer/retreat/session',
      page: RetreatSessionRoute.page,
      guards: [authGuard],
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/week/:monday',
      page: WeekStoryRoute.page,
      guards: [authGuard],
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/prayer/topics',
      page: PrayerTopicsRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/prayer/lists',
      page: PrayerListRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/prayer/importunities/:importunityId',
      page: ImportunityRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/hymns/:bookCode/:number',
      page: HymnReaderRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/hymns/:bookCode/:number/projection',
      page: HymnProjectionRoute.page,
      guards: [authGuard],
      fullscreenDialog: true,
    ),
    AutoRoute(path: '/items/new', page: NewItemRoute.page, guards: [authGuard]),
    AutoRoute(path: '/admin', page: AdminRoute.page, guards: [authGuard]),
    AutoRoute(
      path: '/reports/export',
      page: ExportReportRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/reports/sending',
      page: ReportSendingRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/reports/send/:day',
      page: ReportSendRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/authorities',
      page: AuthoritiesRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/authorities/new',
      page: AuthorityFormRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/account/delete',
      page: DeleteAccountRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/disciples',
      page: DisciplesRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/disciples/:authorityId',
      page: DiscipleReportsRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/account/photo',
      page: PhotoCropRoute.page,
      guards: [authGuard],
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/account/blocked',
      page: BlockedMembersRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(path: '/premium', page: PremiumRoute.page, guards: [authGuard]),
    AutoRoute(path: '/ministry', page: MinistryRoute.page, guards: [authGuard]),
    AutoRoute(
      path: '/ministry/nations',
      page: NationsRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/ministry/purpose',
      page: PurposeRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/ministry/founder',
      page: FounderRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/ministry/leader',
      page: LeaderRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/ministry/people/:kind',
      page: MinistryPeopleRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/ministry/people/:kind/:personId',
      page: MinistryPersonRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/notifications',
      page: NotificationsRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/notifications/:notificationId',
      page: NotificationRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(path: '/events', page: EventsRoute.page, guards: [authGuard]),
    AutoRoute(
      path: '/events/:eventId',
      page: EventRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/admin/events',
      page: AdminEventsRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/admin/events/:eventId/edit',
      page: EventFormRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/admin/events/:eventId/program',
      page: EventProgramRoute.page,
      guards: [authGuard],
    ),
    AutoRoute(
      path: '/admin/events/:eventId/registrations',
      page: EventRegistrantsRoute.page,
      guards: [authGuard],
    ),
  ];
}

/// After sign-up the church step replaces everything (fade-through); opened
/// from "Plus" to edit the profile, it is a regular page with the back swipe.
Route<T> _churchFormRoute<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
) {
  final args = page.routeData.argsAs<ChurchFormRouteArgs>(
    orElse: () => const ChurchFormRouteArgs(),
  );
  return FadeThroughRoute<T>(page: page, root: !args.isEditing);
}

/// Raw: the router is a ChangeNotifier that Riverpod neither listens to nor disposes.
@Riverpod(keepAlive: true)
Raw<AppRouter> appRouter(Ref ref) {
  final router = AppRouter(authGuard: AuthGuard(ref));
  ref.onDispose(router.dispose);
  return router;
}
