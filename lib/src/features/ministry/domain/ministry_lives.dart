/// Notre fondateur, Notre leader: their portrait (assets/ministry), the
/// numbers of their facts and the years of their dates. The words are in the
/// i18n files (ministry.lives), in the same order.
class MinistryLife {
  const MinistryLife({
    required this.asset,
    required this.facts,
    required this.years,
  });

  final String asset;
  final List<String> facts;
  final List<int> years;

  static const founder = MinistryLife(
    asset: 'assets/ministry/founder.jpg',
    facts: ['1975', '150+', '70+'],
    years: [1945, 1956, 1966, 1970, 1975, 2005, 2009],
  );

  static const leader = MinistryLife(
    asset: 'assets/ministry/leader.jpg',
    facts: ['50+', '14', '2009'],
    years: [1978, 1989, 1994, 2009, 2019],
  );
}
