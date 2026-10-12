// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AdminEventsScreen]
class AdminEventsRoute extends PageRouteInfo<void> {
  const AdminEventsRoute({List<PageRouteInfo>? children})
    : super(AdminEventsRoute.name, initialChildren: children);

  static const String name = 'AdminEventsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminEventsScreen();
    },
  );
}

/// generated route for
/// [AdminScreen]
class AdminRoute extends PageRouteInfo<void> {
  const AdminRoute({List<PageRouteInfo>? children})
    : super(AdminRoute.name, initialChildren: children);

  static const String name = 'AdminRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminScreen();
    },
  );
}

/// generated route for
/// [AppShellScreen]
class AppShellRoute extends PageRouteInfo<void> {
  const AppShellRoute({List<PageRouteInfo>? children})
    : super(AppShellRoute.name, initialChildren: children);

  static const String name = 'AppShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppShellScreen();
    },
  );
}

/// generated route for
/// [AuthoritiesScreen]
class AuthoritiesRoute extends PageRouteInfo<void> {
  const AuthoritiesRoute({List<PageRouteInfo>? children})
    : super(AuthoritiesRoute.name, initialChildren: children);

  static const String name = 'AuthoritiesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthoritiesScreen();
    },
  );
}

/// generated route for
/// [AuthorityFormScreen]
class AuthorityFormRoute extends PageRouteInfo<void> {
  const AuthorityFormRoute({List<PageRouteInfo>? children})
    : super(AuthorityFormRoute.name, initialChildren: children);

  static const String name = 'AuthorityFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthorityFormScreen();
    },
  );
}

/// generated route for
/// [ChurchFormScreen]
class ChurchFormRoute extends PageRouteInfo<ChurchFormRouteArgs> {
  ChurchFormRoute({
    bool isEditing = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ChurchFormRoute.name,
         args: ChurchFormRouteArgs(isEditing: isEditing, key: key),
         initialChildren: children,
       );

  static const String name = 'ChurchFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChurchFormRouteArgs>(
        orElse: () => const ChurchFormRouteArgs(),
      );
      return ChurchFormScreen(isEditing: args.isEditing, key: args.key);
    },
  );
}

class ChurchFormRouteArgs {
  const ChurchFormRouteArgs({this.isEditing = false, this.key});

  final bool isEditing;

  final Key? key;

  @override
  String toString() {
    return 'ChurchFormRouteArgs{isEditing: $isEditing, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChurchFormRouteArgs) return false;
    return isEditing == other.isEditing && key == other.key;
  }

  @override
  int get hashCode => isEditing.hashCode ^ key.hashCode;
}

/// generated route for
/// [DeleteAccountScreen]
class DeleteAccountRoute extends PageRouteInfo<void> {
  const DeleteAccountRoute({List<PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DeleteAccountScreen();
    },
  );
}

/// generated route for
/// [EventFormScreen]
class EventFormRoute extends PageRouteInfo<EventFormRouteArgs> {
  EventFormRoute({int? eventId, Key? key, List<PageRouteInfo>? children})
    : super(
        EventFormRoute.name,
        args: EventFormRouteArgs(eventId: eventId, key: key),
        rawPathParams: {'eventId': eventId},
        initialChildren: children,
      );

  static const String name = 'EventFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EventFormRouteArgs>(
        orElse: () => EventFormRouteArgs(eventId: pathParams.optInt('eventId')),
      );
      return EventFormScreen(eventId: args.eventId, key: args.key);
    },
  );
}

class EventFormRouteArgs {
  const EventFormRouteArgs({this.eventId, this.key});

  final int? eventId;

  final Key? key;

  @override
  String toString() {
    return 'EventFormRouteArgs{eventId: $eventId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventFormRouteArgs) return false;
    return eventId == other.eventId && key == other.key;
  }

  @override
  int get hashCode => eventId.hashCode ^ key.hashCode;
}

/// generated route for
/// [EventProgramScreen]
class EventProgramRoute extends PageRouteInfo<EventProgramRouteArgs> {
  EventProgramRoute({
    required int eventId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         EventProgramRoute.name,
         args: EventProgramRouteArgs(eventId: eventId, key: key),
         rawPathParams: {'eventId': eventId},
         initialChildren: children,
       );

  static const String name = 'EventProgramRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EventProgramRouteArgs>(
        orElse: () =>
            EventProgramRouteArgs(eventId: pathParams.getInt('eventId')),
      );
      return EventProgramScreen(eventId: args.eventId, key: args.key);
    },
  );
}

class EventProgramRouteArgs {
  const EventProgramRouteArgs({required this.eventId, this.key});

  final int eventId;

  final Key? key;

  @override
  String toString() {
    return 'EventProgramRouteArgs{eventId: $eventId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventProgramRouteArgs) return false;
    return eventId == other.eventId && key == other.key;
  }

  @override
  int get hashCode => eventId.hashCode ^ key.hashCode;
}

/// generated route for
/// [EventRegistrantsScreen]
class EventRegistrantsRoute extends PageRouteInfo<EventRegistrantsRouteArgs> {
  EventRegistrantsRoute({
    required int eventId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         EventRegistrantsRoute.name,
         args: EventRegistrantsRouteArgs(eventId: eventId, key: key),
         rawPathParams: {'eventId': eventId},
         initialChildren: children,
       );

  static const String name = 'EventRegistrantsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EventRegistrantsRouteArgs>(
        orElse: () =>
            EventRegistrantsRouteArgs(eventId: pathParams.getInt('eventId')),
      );
      return EventRegistrantsScreen(eventId: args.eventId, key: args.key);
    },
  );
}

class EventRegistrantsRouteArgs {
  const EventRegistrantsRouteArgs({required this.eventId, this.key});

  final int eventId;

  final Key? key;

  @override
  String toString() {
    return 'EventRegistrantsRouteArgs{eventId: $eventId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventRegistrantsRouteArgs) return false;
    return eventId == other.eventId && key == other.key;
  }

  @override
  int get hashCode => eventId.hashCode ^ key.hashCode;
}

/// generated route for
/// [EventScreen]
class EventRoute extends PageRouteInfo<EventRouteArgs> {
  EventRoute({required int eventId, Key? key, List<PageRouteInfo>? children})
    : super(
        EventRoute.name,
        args: EventRouteArgs(eventId: eventId, key: key),
        rawPathParams: {'eventId': eventId},
        initialChildren: children,
      );

  static const String name = 'EventRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EventRouteArgs>(
        orElse: () => EventRouteArgs(eventId: pathParams.getInt('eventId')),
      );
      return EventScreen(eventId: args.eventId, key: args.key);
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({required this.eventId, this.key});

  final int eventId;

  final Key? key;

  @override
  String toString() {
    return 'EventRouteArgs{eventId: $eventId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventRouteArgs) return false;
    return eventId == other.eventId && key == other.key;
  }

  @override
  int get hashCode => eventId.hashCode ^ key.hashCode;
}

/// generated route for
/// [EventsScreen]
class EventsRoute extends PageRouteInfo<void> {
  const EventsRoute({List<PageRouteInfo>? children})
    : super(EventsRoute.name, initialChildren: children);

  static const String name = 'EventsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EventsScreen();
    },
  );
}

/// generated route for
/// [ExportReportScreen]
class ExportReportRoute extends PageRouteInfo<void> {
  const ExportReportRoute({List<PageRouteInfo>? children})
    : super(ExportReportRoute.name, initialChildren: children);

  static const String name = 'ExportReportRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExportReportScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [HymnProjectionScreen]
class HymnProjectionRoute extends PageRouteInfo<HymnProjectionRouteArgs> {
  HymnProjectionRoute({
    required String bookCode,
    required int number,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         HymnProjectionRoute.name,
         args: HymnProjectionRouteArgs(
           bookCode: bookCode,
           number: number,
           key: key,
         ),
         rawPathParams: {'bookCode': bookCode, 'number': number},
         initialChildren: children,
       );

  static const String name = 'HymnProjectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<HymnProjectionRouteArgs>(
        orElse: () => HymnProjectionRouteArgs(
          bookCode: pathParams.getString('bookCode'),
          number: pathParams.getInt('number'),
        ),
      );
      return HymnProjectionScreen(
        bookCode: args.bookCode,
        number: args.number,
        key: args.key,
      );
    },
  );
}

class HymnProjectionRouteArgs {
  const HymnProjectionRouteArgs({
    required this.bookCode,
    required this.number,
    this.key,
  });

  final String bookCode;

  final int number;

  final Key? key;

  @override
  String toString() {
    return 'HymnProjectionRouteArgs{bookCode: $bookCode, number: $number, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HymnProjectionRouteArgs) return false;
    return bookCode == other.bookCode &&
        number == other.number &&
        key == other.key;
  }

  @override
  int get hashCode => bookCode.hashCode ^ number.hashCode ^ key.hashCode;
}

/// generated route for
/// [HymnReaderScreen]
class HymnReaderRoute extends PageRouteInfo<HymnReaderRouteArgs> {
  HymnReaderRoute({
    required String bookCode,
    required int number,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         HymnReaderRoute.name,
         args: HymnReaderRouteArgs(
           bookCode: bookCode,
           number: number,
           key: key,
         ),
         rawPathParams: {'bookCode': bookCode, 'number': number},
         initialChildren: children,
       );

  static const String name = 'HymnReaderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<HymnReaderRouteArgs>(
        orElse: () => HymnReaderRouteArgs(
          bookCode: pathParams.getString('bookCode'),
          number: pathParams.getInt('number'),
        ),
      );
      return HymnReaderScreen(
        bookCode: args.bookCode,
        number: args.number,
        key: args.key,
      );
    },
  );
}

class HymnReaderRouteArgs {
  const HymnReaderRouteArgs({
    required this.bookCode,
    required this.number,
    this.key,
  });

  final String bookCode;

  final int number;

  final Key? key;

  @override
  String toString() {
    return 'HymnReaderRouteArgs{bookCode: $bookCode, number: $number, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HymnReaderRouteArgs) return false;
    return bookCode == other.bookCode &&
        number == other.number &&
        key == other.key;
  }

  @override
  int get hashCode => bookCode.hashCode ^ number.hashCode ^ key.hashCode;
}

/// generated route for
/// [HymnsScreen]
class HymnsRoute extends PageRouteInfo<void> {
  const HymnsRoute({List<PageRouteInfo>? children})
    : super(HymnsRoute.name, initialChildren: children);

  static const String name = 'HymnsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HymnsScreen();
    },
  );
}

/// generated route for
/// [ImportunityScreen]
class ImportunityRoute extends PageRouteInfo<ImportunityRouteArgs> {
  ImportunityRoute({
    required int importunityId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ImportunityRoute.name,
         args: ImportunityRouteArgs(importunityId: importunityId, key: key),
         rawPathParams: {'importunityId': importunityId},
         initialChildren: children,
       );

  static const String name = 'ImportunityRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ImportunityRouteArgs>(
        orElse: () => ImportunityRouteArgs(
          importunityId: pathParams.getInt('importunityId'),
        ),
      );
      return ImportunityScreen(
        importunityId: args.importunityId,
        key: args.key,
      );
    },
  );
}

class ImportunityRouteArgs {
  const ImportunityRouteArgs({required this.importunityId, this.key});

  final int importunityId;

  final Key? key;

  @override
  String toString() {
    return 'ImportunityRouteArgs{importunityId: $importunityId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ImportunityRouteArgs) return false;
    return importunityId == other.importunityId && key == other.key;
  }

  @override
  int get hashCode => importunityId.hashCode ^ key.hashCode;
}

/// generated route for
/// [ItemsScreen]
class ItemsRoute extends PageRouteInfo<void> {
  const ItemsRoute({List<PageRouteInfo>? children})
    : super(ItemsRoute.name, initialChildren: children);

  static const String name = 'ItemsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ItemsScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [MoreScreen]
class MoreRoute extends PageRouteInfo<void> {
  const MoreRoute({List<PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MoreScreen();
    },
  );
}

/// generated route for
/// [NewItemScreen]
class NewItemRoute extends PageRouteInfo<void> {
  const NewItemRoute({List<PageRouteInfo>? children})
    : super(NewItemRoute.name, initialChildren: children);

  static const String name = 'NewItemRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewItemScreen();
    },
  );
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
    },
  );
}

/// generated route for
/// [PrayerListScreen]
class PrayerListRoute extends PageRouteInfo<PrayerListRouteArgs> {
  PrayerListRoute({
    required PrayerList list,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         PrayerListRoute.name,
         args: PrayerListRouteArgs(list: list, key: key),
         initialChildren: children,
       );

  static const String name = 'PrayerListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrayerListRouteArgs>();
      return PrayerListScreen(list: args.list, key: args.key);
    },
  );
}

class PrayerListRouteArgs {
  const PrayerListRouteArgs({required this.list, this.key});

  final PrayerList list;

  final Key? key;

  @override
  String toString() {
    return 'PrayerListRouteArgs{list: $list, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PrayerListRouteArgs) return false;
    return list == other.list && key == other.key;
  }

  @override
  int get hashCode => list.hashCode ^ key.hashCode;
}

/// generated route for
/// [PrayerScreen]
class PrayerRoute extends PageRouteInfo<void> {
  const PrayerRoute({List<PageRouteInfo>? children})
    : super(PrayerRoute.name, initialChildren: children);

  static const String name = 'PrayerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PrayerScreen();
    },
  );
}

/// generated route for
/// [PrayerTopicScreen]
class PrayerTopicRoute extends PageRouteInfo<PrayerTopicRouteArgs> {
  PrayerTopicRoute({
    required int topicId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         PrayerTopicRoute.name,
         args: PrayerTopicRouteArgs(topicId: topicId, key: key),
         rawPathParams: {'topicId': topicId},
         initialChildren: children,
       );

  static const String name = 'PrayerTopicRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PrayerTopicRouteArgs>(
        orElse: () =>
            PrayerTopicRouteArgs(topicId: pathParams.getInt('topicId')),
      );
      return PrayerTopicScreen(topicId: args.topicId, key: args.key);
    },
  );
}

class PrayerTopicRouteArgs {
  const PrayerTopicRouteArgs({required this.topicId, this.key});

  final int topicId;

  final Key? key;

  @override
  String toString() {
    return 'PrayerTopicRouteArgs{topicId: $topicId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PrayerTopicRouteArgs) return false;
    return topicId == other.topicId && key == other.key;
  }

  @override
  int get hashCode => topicId.hashCode ^ key.hashCode;
}

/// generated route for
/// [PrayerTopicsScreen]
class PrayerTopicsRoute extends PageRouteInfo<void> {
  const PrayerTopicsRoute({List<PageRouteInfo>? children})
    : super(PrayerTopicsRoute.name, initialChildren: children);

  static const String name = 'PrayerTopicsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PrayerTopicsScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterScreen();
    },
  );
}

/// generated route for
/// [ReportsScreen]
class ReportsRoute extends PageRouteInfo<void> {
  const ReportsRoute({List<PageRouteInfo>? children})
    : super(ReportsRoute.name, initialChildren: children);

  static const String name = 'ReportsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReportsScreen();
    },
  );
}

/// generated route for
/// [RetreatScreen]
class RetreatRoute extends PageRouteInfo<RetreatRouteArgs> {
  RetreatRoute({
    required RetreatMoment moment,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         RetreatRoute.name,
         args: RetreatRouteArgs(moment: moment, key: key),
         initialChildren: children,
       );

  static const String name = 'RetreatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RetreatRouteArgs>();
      return RetreatScreen(moment: args.moment, key: args.key);
    },
  );
}

class RetreatRouteArgs {
  const RetreatRouteArgs({required this.moment, this.key});

  final RetreatMoment moment;

  final Key? key;

  @override
  String toString() {
    return 'RetreatRouteArgs{moment: $moment, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RetreatRouteArgs) return false;
    return moment == other.moment && key == other.key;
  }

  @override
  int get hashCode => moment.hashCode ^ key.hashCode;
}

/// generated route for
/// [RetreatSessionScreen]
class RetreatSessionRoute extends PageRouteInfo<RetreatSessionRouteArgs> {
  RetreatSessionRoute({
    required RetreatMoment moment,
    bool timed = true,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         RetreatSessionRoute.name,
         args: RetreatSessionRouteArgs(moment: moment, timed: timed, key: key),
         initialChildren: children,
       );

  static const String name = 'RetreatSessionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RetreatSessionRouteArgs>();
      return RetreatSessionScreen(
        moment: args.moment,
        timed: args.timed,
        key: args.key,
      );
    },
  );
}

class RetreatSessionRouteArgs {
  const RetreatSessionRouteArgs({
    required this.moment,
    this.timed = true,
    this.key,
  });

  final RetreatMoment moment;

  final bool timed;

  final Key? key;

  @override
  String toString() {
    return 'RetreatSessionRouteArgs{moment: $moment, timed: $timed, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RetreatSessionRouteArgs) return false;
    return moment == other.moment && timed == other.timed && key == other.key;
  }

  @override
  int get hashCode => moment.hashCode ^ timed.hashCode ^ key.hashCode;
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomeScreen();
    },
  );
}
