import 'package:flutter/widgets.dart';

import '../../i18n/strings.g.dart';
import '../../theme/app_icons.dart';
import 'tour_step.dart';

/// What a tour step shows: the name of its space, and what the lit element
/// does, in the app's language.
class TourLook {
  const TourLook({
    required this.space,
    required this.title,
    required this.text,
  });

  final String space;
  final String title;
  final String text;

  /// The key of each step: since showcaseview 5 a key only names the step
  /// (it is not put on a widget), so one key per step for the whole app.
  static final _keys = {
    for (final step in TourStep.values)
      step: GlobalKey(debugLabel: 'tour.${step.name}'),
  };

  static GlobalKey keyOf(TourStep step) => _keys[step]!;

  static IconData iconOf(TourSpace space) => switch (space) {
    TourSpace.home => AppIcons.home,
    TourSpace.reports || TourSpace.reportsData => AppIcons.reports,
    TourSpace.games => AppIcons.games,
    TourSpace.bible => AppIcons.bible,
    TourSpace.you => AppIcons.user,
    TourSpace.prayer => AppIcons.prayer,
    TourSpace.hymns => AppIcons.hymns,
    TourSpace.teachings => AppIcons.listen,
    TourSpace.ministry => AppIcons.ministry,
    TourSpace.events => AppIcons.events,
    TourSpace.donate => AppIcons.heartFilled,
    TourSpace.premium => AppIcons.premiumCrown,
    TourSpace.documents => AppIcons.pdf,
    TourSpace.notifications => AppIcons.notifications,
  };

  static String spaceName(TourSpace space, Translations t) {
    final s = t.tour.spaces;
    return switch (space) {
      TourSpace.home => s.home,
      TourSpace.reports || TourSpace.reportsData => s.reports,
      TourSpace.games => s.games,
      TourSpace.bible => s.bible,
      TourSpace.you => s.you,
      TourSpace.prayer => s.prayer,
      TourSpace.hymns => s.hymns,
      TourSpace.teachings => s.teachings,
      TourSpace.ministry => s.ministry,
      TourSpace.events => s.events,
      TourSpace.donate => s.donate,
      TourSpace.premium => s.premium,
      TourSpace.documents => s.documents,
      TourSpace.notifications => s.notifications,
    };
  }

  static TourLook of(TourStep step, Translations t) {
    final s = t.tour.steps;
    final (title, text) = switch (step) {
      TourStep.homeDay => (s.homeDay.title, s.homeDay.text),
      TourStep.homeReport => (s.homeReport.title, s.homeReport.text),
      TourStep.homeShortcuts => (s.homeShortcuts.title, s.homeShortcuts.text),
      TourStep.homeBell => (s.homeBell.title, s.homeBell.text),
      TourStep.reportsViews => (s.reportsViews.title, s.reportsViews.text),
      TourStep.reportsDay => (s.reportsDay.title, s.reportsDay.text),
      TourStep.reportsStopwatch => (
        s.reportsStopwatch.title,
        s.reportsStopwatch.text,
      ),
      TourStep.reportsItems => (s.reportsItems.title, s.reportsItems.text),
      TourStep.reportsExport => (s.reportsExport.title, s.reportsExport.text),
      TourStep.gamesStats => (s.gamesStats.title, s.gamesStats.text),
      TourStep.gamesExtras => (s.gamesExtras.title, s.gamesExtras.text),
      TourStep.biblePassage => (s.biblePassage.title, s.biblePassage.text),
      TourStep.bibleVersion => (s.bibleVersion.title, s.bibleVersion.text),
      TourStep.bibleListen => (s.bibleListen.title, s.bibleListen.text),
      TourStep.bibleMore => (s.bibleMore.title, s.bibleMore.text),
      TourStep.youCard => (s.youCard.title, s.youCard.text),
      TourStep.youNumbers => (s.youNumbers.title, s.youNumbers.text),
      TourStep.youDiscover => (s.youDiscover.title, s.youDiscover.text),
      TourStep.youSettings => (s.youSettings.title, s.youSettings.text),
      TourStep.prayerToday => (s.prayerToday.title, s.prayerToday.text),
      TourStep.prayerReminders => (
        s.prayerReminders.title,
        s.prayerReminders.text,
      ),
      TourStep.prayerRoutine => (s.prayerRoutine.title, s.prayerRoutine.text),
      TourStep.prayerTogether => (
        s.prayerTogether.title,
        s.prayerTogether.text,
      ),
      TourStep.hymnsBook => (s.hymnsBook.title, s.hymnsBook.text),
      TourStep.hymnsNumber => (s.hymnsNumber.title, s.hymnsNumber.text),
      TourStep.hymnsSearch => (s.hymnsSearch.title, s.hymnsSearch.text),
      TourStep.hymnsViews => (s.hymnsViews.title, s.hymnsViews.text),
      TourStep.teachingsSearch => (
        s.teachingsSearch.title,
        s.teachingsSearch.text,
      ),
      TourStep.teachingsFilters => (
        s.teachingsFilters.title,
        s.teachingsFilters.text,
      ),
      TourStep.teachingsCategories => (
        s.teachingsCategories.title,
        s.teachingsCategories.text,
      ),
      TourStep.ministryNations => (
        s.ministryNations.title,
        s.ministryNations.text,
      ),
      TourStep.ministryLives => (s.ministryLives.title, s.ministryLives.text),
      TourStep.ministryMenu => (s.ministryMenu.title, s.ministryMenu.text),
      TourStep.eventsNext => (s.eventsNext.title, s.eventsNext.text),
      TourStep.donateAmounts => (s.donateAmounts.title, s.donateAmounts.text),
      TourStep.donateMethod => (s.donateMethod.title, s.donateMethod.text),
      TourStep.donateGive => (s.donateGive.title, s.donateGive.text),
      TourStep.premiumBenefits => (
        s.premiumBenefits.title,
        s.premiumBenefits.text,
      ),
      TourStep.premiumPlans => (s.premiumPlans.title, s.premiumPlans.text),
      TourStep.documentsSearch => (
        s.documentsSearch.title,
        s.documentsSearch.text,
      ),
      TourStep.documentsCategories => (
        s.documentsCategories.title,
        s.documentsCategories.text,
      ),
      TourStep.notificationsInbox => (
        s.notificationsInbox.title,
        s.notificationsInbox.text,
      ),
    };
    return TourLook(space: spaceName(step.space, t), title: title, text: text);
  }
}

extension TourStepKey on TourStep {
  GlobalKey get key => TourLook.keyOf(this);
}
