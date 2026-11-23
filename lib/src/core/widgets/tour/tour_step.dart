/// The spaces of the app that present themselves the first time the member
/// arrives there (23/11/2026).
enum TourSpace {
  home,
  reports,

  /// The History and Summary views of the report: what can be done with
  /// the days (export), the first time one of them opens.
  reportsData,
  games,
  bible,
  you,
  prayer,
  hymns,
  teachings,
  ministry,
  events,
  donate,
  premium,
  documents,
  notifications;

  /// Its steps, in the order of the tour. The first one is always drawn
  /// with the screen: the tour waits for it.
  List<TourStep> get steps => [
    for (final step in TourStep.values)
      if (step.space == this) step,
  ];
}

/// One element lit by the tour of a space. Some are only there in some
/// cases (a retreat left to pray, the card payment, a category…): the tour
/// skips them when they are not on screen.
enum TourStep {
  homeDay(TourSpace.home),
  homeReport(TourSpace.home),
  homeShortcuts(TourSpace.home),
  homeBell(TourSpace.home),

  reportsViews(TourSpace.reports),
  reportsDay(TourSpace.reports),
  reportsStopwatch(TourSpace.reports),
  reportsItems(TourSpace.reports),

  reportsExport(TourSpace.reportsData),

  gamesStats(TourSpace.games),
  gamesExtras(TourSpace.games),

  biblePassage(TourSpace.bible),
  bibleVersion(TourSpace.bible),
  bibleListen(TourSpace.bible),
  bibleMore(TourSpace.bible),

  youCard(TourSpace.you),
  youNumbers(TourSpace.you),
  youDiscover(TourSpace.you),
  youSettings(TourSpace.you),

  prayerToday(TourSpace.prayer),
  prayerReminders(TourSpace.prayer),
  prayerRoutine(TourSpace.prayer),
  prayerTogether(TourSpace.prayer),

  hymnsBook(TourSpace.hymns),
  hymnsNumber(TourSpace.hymns),
  hymnsSearch(TourSpace.hymns),
  hymnsViews(TourSpace.hymns),

  teachingsSearch(TourSpace.teachings),
  teachingsFilters(TourSpace.teachings),
  teachingsCategories(TourSpace.teachings),

  ministryNations(TourSpace.ministry),
  ministryLives(TourSpace.ministry),
  ministryMenu(TourSpace.ministry),

  eventsNext(TourSpace.events),

  donateAmounts(TourSpace.donate),
  donateMethod(TourSpace.donate),
  donateGive(TourSpace.donate),

  premiumBenefits(TourSpace.premium),
  premiumPlans(TourSpace.premium),

  documentsSearch(TourSpace.documents),
  documentsCategories(TourSpace.documents),

  notificationsInbox(TourSpace.notifications);

  const TourStep(this.space);

  final TourSpace space;
}
