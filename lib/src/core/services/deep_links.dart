import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';

part 'deep_links.g.dart';

/// A screen of the app a link opens: `https://cmfi-connect.com/open?to=…`
/// (Universal Links on iOS, App Links on Android; without the app, the site
/// shows a page with the stores) or `cmficonnect://open?to=…`.
sealed class AppLink {
  const AppLink();

  /// What follows `to=`: "events/42", "hymns/chants-edification-1/3",
  /// "prayer/topics/5", "prayer/importunities/7", "prayer/retreat",
  /// "bible/JHN.3.16", "reports/today".
  String get path;

  /// The link to share, which opens this screen.
  Uri get uri => Uri.parse('${AppConfig.siteUrl}/open?to=$path');

  /// [text] shared with the link under it.
  String under(String text) => '$text\n$uri';

  static final _event = RegExp(r'^events/(\d+)$');
  static final _hymn = RegExp(r'^hymns/([\w.-]+)/(\d+)$');
  static final _topic = RegExp(r'^prayer/topics/(\d+)$');
  static final _importunity = RegExp(r'^prayer/importunities/(\d+)$');
  static final _bible = RegExp(r'^bible/([1-3A-Z]{3}\.\d+(?:\.\d+)?)$');

  /// The screen of [uri], or null for a link that isn't one of ours (the
  /// links of the home screen widget, `cmficonnect://today`, are read by
  /// the widget's own code).
  static AppLink? parse(Uri uri) {
    final site = Uri.parse(AppConfig.siteUrl).host;
    final to = switch (uri.scheme) {
      'https' || 'http'
          when (uri.host == site || uri.host == 'www.$site') &&
              (uri.path == '/open' || uri.path == '/open/') =>
        uri.queryParameters['to'],
      'cmficonnect' when uri.host == 'open' => uri.queryParameters['to'],
      _ => null,
    };
    return fromPath(to);
  }

  /// The screen of a path ("events/42"), or null.
  static AppLink? fromPath(String? path) {
    final to = (path ?? '').trim().replaceAll(RegExp(r'^/+|/+$'), '');
    if (_event.firstMatch(to) case final m?) {
      return EventLink(int.parse(m[1]!));
    }
    if (_hymn.firstMatch(to) case final m?) {
      return HymnLink(m[1]!, int.parse(m[2]!));
    }
    if (_topic.firstMatch(to) case final m?) {
      return PrayerTopicLink(int.parse(m[1]!));
    }
    if (_importunity.firstMatch(to) case final m?) {
      return ImportunityLink(int.parse(m[1]!));
    }
    if (to == 'prayer/retreat') {
      return const RetreatLink();
    }
    if (to == 'reports/today') {
      return const TodayLink();
    }
    if (_bible.firstMatch(to) case final m?) {
      return BibleLink(m[1]!);
    }
    return null;
  }
}

class EventLink extends AppLink {
  const EventLink(this.eventId);

  final int eventId;

  @override
  String get path => 'events/$eventId';
}

class HymnLink extends AppLink {
  const HymnLink(this.bookCode, this.number);

  final String bookCode;
  final int number;

  @override
  String get path => 'hymns/$bookCode/$number';
}

class PrayerTopicLink extends AppLink {
  const PrayerTopicLink(this.topicId);

  final int topicId;

  @override
  String get path => 'prayer/topics/$topicId';
}

class ImportunityLink extends AppLink {
  const ImportunityLink(this.importunityId);

  final int importunityId;

  @override
  String get path => 'prayer/importunities/$importunityId';
}

/// The retreat of the moment (or the Prayer tab when the day's four are made).
class RetreatLink extends AppLink {
  const RetreatLink();

  @override
  String get path => 'prayer/retreat';
}

/// Today's report, to fill in (Siri, a closed app on Android).
class TodayLink extends AppLink {
  const TodayLink();

  @override
  String get path => 'reports/today';
}

/// A chapter or a verse of the Bible, the same in every version.
class BibleLink extends AppLink {
  const BibleLink(this.reference);

  /// "JHN.3.16" or "JHN.3".
  final String reference;

  @override
  String get path => 'bible/$reference';
}

/// The links that open the app, the one it was launched with first. Behind
/// a provider so tests give theirs.
abstract interface class IncomingLinks {
  Stream<Uri> get links;
}

class NoIncomingLinks implements IncomingLinks {
  const NoIncomingLinks();

  @override
  Stream<Uri> get links => const Stream.empty();
}

class AppLinksIncoming implements IncomingLinks {
  AppLinksIncoming();

  final _appLinks = AppLinks();

  /// app_links gives the launch link on this stream too.
  @override
  Stream<Uri> get links => _appLinks.uriLinkStream;
}

@Riverpod(keepAlive: true)
IncomingLinks incomingLinks(Ref ref) =>
    kIsWeb ? const NoIncomingLinks() : AppLinksIncoming();

/// The screen a link asked for, kept until the app can open it (signed in:
/// `SignedInTasks` opens it, then clears it). A link arriving signed out
/// waits for the sign-in.
@Riverpod(keepAlive: true)
class PendingDeepLink extends _$PendingDeepLink {
  @override
  AppLink? build() {
    final subscription = ref.watch(incomingLinksProvider).links.listen((uri) {
      if (AppLink.parse(uri) case final link?) {
        state = link;
      }
    });
    ref.onDispose(subscription.cancel);
    return null;
  }

  /// The link has been opened.
  void clear() => state = null;
}
