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
/// [BibleMarksScreen]
class BibleMarksRoute extends PageRouteInfo<void> {
  const BibleMarksRoute({List<PageRouteInfo>? children})
    : super(BibleMarksRoute.name, initialChildren: children);

  static const String name = 'BibleMarksRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BibleMarksScreen();
    },
  );
}

/// generated route for
/// [BibleScreen]
class BibleRoute extends PageRouteInfo<void> {
  const BibleRoute({List<PageRouteInfo>? children})
    : super(BibleRoute.name, initialChildren: children);

  static const String name = 'BibleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BibleScreen();
    },
  );
}

/// generated route for
/// [BibleSearchScreen]
class BibleSearchRoute extends PageRouteInfo<void> {
  const BibleSearchRoute({List<PageRouteInfo>? children})
    : super(BibleSearchRoute.name, initialChildren: children);

  static const String name = 'BibleSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BibleSearchScreen();
    },
  );
}

/// generated route for
/// [BlockedMembersScreen]
class BlockedMembersRoute extends PageRouteInfo<void> {
  const BlockedMembersRoute({List<PageRouteInfo>? children})
    : super(BlockedMembersRoute.name, initialChildren: children);

  static const String name = 'BlockedMembersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BlockedMembersScreen();
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
/// [DiscipleReportsScreen]
class DiscipleReportsRoute extends PageRouteInfo<DiscipleReportsRouteArgs> {
  DiscipleReportsRoute({
    required int authorityId,
    String name = '',
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         DiscipleReportsRoute.name,
         args: DiscipleReportsRouteArgs(
           authorityId: authorityId,
           name: name,
           key: key,
         ),
         rawPathParams: {'authorityId': authorityId},
         initialChildren: children,
       );

  static const String name = 'DiscipleReportsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<DiscipleReportsRouteArgs>(
        orElse: () => DiscipleReportsRouteArgs(
          authorityId: pathParams.getInt('authorityId'),
        ),
      );
      return DiscipleReportsScreen(
        authorityId: args.authorityId,
        name: args.name,
        key: args.key,
      );
    },
  );
}

class DiscipleReportsRouteArgs {
  const DiscipleReportsRouteArgs({
    required this.authorityId,
    this.name = '',
    this.key,
  });

  final int authorityId;

  final String name;

  final Key? key;

  @override
  String toString() {
    return 'DiscipleReportsRouteArgs{authorityId: $authorityId, name: $name, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DiscipleReportsRouteArgs) return false;
    return authorityId == other.authorityId &&
        name == other.name &&
        key == other.key;
  }

  @override
  int get hashCode => authorityId.hashCode ^ name.hashCode ^ key.hashCode;
}

/// generated route for
/// [DisciplesScreen]
class DisciplesRoute extends PageRouteInfo<void> {
  const DisciplesRoute({List<PageRouteInfo>? children})
    : super(DisciplesRoute.name, initialChildren: children);

  static const String name = 'DisciplesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DisciplesScreen();
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
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({String? phone, Key? key, List<PageRouteInfo>? children})
    : super(
        ForgotPasswordRoute.name,
        args: ForgotPasswordRouteArgs(phone: phone, key: key),
        initialChildren: children,
      );

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>(
        orElse: () => const ForgotPasswordRouteArgs(),
      );
      return ForgotPasswordScreen(phone: args.phone, key: args.key);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.phone, this.key});

  final String? phone;

  final Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{phone: $phone, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ForgotPasswordRouteArgs) return false;
    return phone == other.phone && key == other.key;
  }

  @override
  int get hashCode => phone.hashCode ^ key.hashCode;
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
/// [MinistryScreen]
class MinistryRoute extends PageRouteInfo<void> {
  const MinistryRoute({List<PageRouteInfo>? children})
    : super(MinistryRoute.name, initialChildren: children);

  static const String name = 'MinistryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MinistryScreen();
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
/// [NationsScreen]
class NationsRoute extends PageRouteInfo<void> {
  const NationsRoute({List<PageRouteInfo>? children})
    : super(NationsRoute.name, initialChildren: children);

  static const String name = 'NationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NationsScreen();
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
/// [NotificationScreen]
class NotificationRoute extends PageRouteInfo<NotificationRouteArgs> {
  NotificationRoute({
    required int notificationId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         NotificationRoute.name,
         args: NotificationRouteArgs(notificationId: notificationId, key: key),
         rawPathParams: {'notificationId': notificationId},
         initialChildren: children,
       );

  static const String name = 'NotificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<NotificationRouteArgs>(
        orElse: () => NotificationRouteArgs(
          notificationId: pathParams.getInt('notificationId'),
        ),
      );
      return NotificationScreen(
        notificationId: args.notificationId,
        key: args.key,
      );
    },
  );
}

class NotificationRouteArgs {
  const NotificationRouteArgs({required this.notificationId, this.key});

  final int notificationId;

  final Key? key;

  @override
  String toString() {
    return 'NotificationRouteArgs{notificationId: $notificationId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NotificationRouteArgs) return false;
    return notificationId == other.notificationId && key == other.key;
  }

  @override
  int get hashCode => notificationId.hashCode ^ key.hashCode;
}

/// generated route for
/// [NotificationsScreen]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute({List<PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationsScreen();
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
/// [PhotoCropScreen]
class PhotoCropRoute extends PageRouteInfo<PhotoCropRouteArgs> {
  PhotoCropRoute({
    required Uint8List bytes,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         PhotoCropRoute.name,
         args: PhotoCropRouteArgs(bytes: bytes, key: key),
         initialChildren: children,
       );

  static const String name = 'PhotoCropRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhotoCropRouteArgs>();
      return PhotoCropScreen(bytes: args.bytes, key: args.key);
    },
  );
}

class PhotoCropRouteArgs {
  const PhotoCropRouteArgs({required this.bytes, this.key});

  final Uint8List bytes;

  final Key? key;

  @override
  String toString() {
    return 'PhotoCropRouteArgs{bytes: $bytes, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PhotoCropRouteArgs) return false;
    return bytes == other.bytes && key == other.key;
  }

  @override
  int get hashCode => bytes.hashCode ^ key.hashCode;
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
/// [PremiumScreen]
class PremiumRoute extends PageRouteInfo<void> {
  const PremiumRoute({List<PageRouteInfo>? children})
    : super(PremiumRoute.name, initialChildren: children);

  static const String name = 'PremiumRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PremiumScreen();
    },
  );
}

/// generated route for
/// [PurposeScreen]
class PurposeRoute extends PageRouteInfo<void> {
  const PurposeRoute({List<PageRouteInfo>? children})
    : super(PurposeRoute.name, initialChildren: children);

  static const String name = 'PurposeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PurposeScreen();
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
/// [ReportSendScreen]
class ReportSendRoute extends PageRouteInfo<ReportSendRouteArgs> {
  ReportSendRoute({
    required String day,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ReportSendRoute.name,
         args: ReportSendRouteArgs(day: day, key: key),
         rawPathParams: {'day': day},
         initialChildren: children,
       );

  static const String name = 'ReportSendRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ReportSendRouteArgs>(
        orElse: () => ReportSendRouteArgs(day: pathParams.getString('day')),
      );
      return ReportSendScreen(day: args.day, key: args.key);
    },
  );
}

class ReportSendRouteArgs {
  const ReportSendRouteArgs({required this.day, this.key});

  final String day;

  final Key? key;

  @override
  String toString() {
    return 'ReportSendRouteArgs{day: $day, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReportSendRouteArgs) return false;
    return day == other.day && key == other.key;
  }

  @override
  int get hashCode => day.hashCode ^ key.hashCode;
}

/// generated route for
/// [ReportSendingScreen]
class ReportSendingRoute extends PageRouteInfo<void> {
  const ReportSendingRoute({List<PageRouteInfo>? children})
    : super(ReportSendingRoute.name, initialChildren: children);

  static const String name = 'ReportSendingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReportSendingScreen();
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
/// [WeekStoryScreen]
class WeekStoryRoute extends PageRouteInfo<WeekStoryRouteArgs> {
  WeekStoryRoute({
    required String monday,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         WeekStoryRoute.name,
         args: WeekStoryRouteArgs(monday: monday, key: key),
         rawPathParams: {'monday': monday},
         initialChildren: children,
       );

  static const String name = 'WeekStoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<WeekStoryRouteArgs>(
        orElse: () =>
            WeekStoryRouteArgs(monday: pathParams.getString('monday')),
      );
      return WeekStoryScreen(monday: args.monday, key: args.key);
    },
  );
}

class WeekStoryRouteArgs {
  const WeekStoryRouteArgs({required this.monday, this.key});

  final String monday;

  final Key? key;

  @override
  String toString() {
    return 'WeekStoryRouteArgs{monday: $monday, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WeekStoryRouteArgs) return false;
    return monday == other.monday && key == other.key;
  }

  @override
  int get hashCode => monday.hashCode ^ key.hashCode;
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
