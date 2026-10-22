/// A Bible the app offers, from the Free Use Bible API (bible.helloao.org):
/// public domain texts, or under a free licence that only asks for
/// [attribution].
class BibleVersion {
  const BibleVersion({
    required this.id,
    required this.abbreviation,
    required this.name,
    required this.language,
    required this.megabytes,
    this.rtl = false,
    this.attribution,
  });

  /// The API's id ("fra_lsg").
  final String id;
  final String abbreviation;
  final String name;

  /// The language code of the app it fits ("fr").
  final String language;

  /// The room it takes once downloaded, rounded.
  final int megabytes;

  /// Read right to left (Arabic).
  final bool rtl;

  /// To show with the text when the licence asks for it.
  final String? attribution;
}

/// The versions, the default of each language first: the same Bible as the
/// verse of the day, so a verse opens on the words the user just read.
const bibleVersions = [
  BibleVersion(
    id: 'fra_lsg',
    abbreviation: 'LSG',
    name: 'Louis Segond 1910',
    language: 'fr',
    megabytes: 7,
  ),
  BibleVersion(
    id: 'fra_jnd',
    abbreviation: 'JND',
    name: 'Darby',
    language: 'fr',
    megabytes: 7,
  ),
  BibleVersion(
    id: 'fra_ost',
    abbreviation: 'OST',
    name: 'Ostervald',
    language: 'fr',
    megabytes: 6,
  ),
  BibleVersion(
    id: 'ENGWEBP',
    abbreviation: 'WEB',
    name: 'World English Bible',
    language: 'en',
    megabytes: 6,
  ),
  BibleVersion(
    id: 'BSB',
    abbreviation: 'BSB',
    name: 'Berean Standard Bible',
    language: 'en',
    megabytes: 8,
  ),
  BibleVersion(
    id: 'eng_kjv',
    abbreviation: 'KJV',
    name: 'King James Version',
    language: 'en',
    megabytes: 7,
  ),
  BibleVersion(
    id: 'deu_l12',
    abbreviation: 'L12',
    name: 'Lutherbibel 1912',
    language: 'de',
    megabytes: 6,
  ),
  BibleVersion(
    id: 'deu_elo',
    abbreviation: 'ELO',
    name: 'Elberfelder 1905',
    language: 'de',
    megabytes: 6,
  ),
  BibleVersion(
    id: 'spa_r09',
    abbreviation: 'RV1909',
    name: 'Reina-Valera 1909',
    language: 'es',
    megabytes: 5,
  ),
  BibleVersion(
    id: 'arb_vdv',
    abbreviation: 'SVD',
    name: 'ترجمة فاندايك',
    language: 'ar',
    megabytes: 9,
    rtl: true,
  ),
  BibleVersion(
    id: 'cmn_cu1',
    abbreviation: '和合本',
    name: '新标点和合本',
    language: 'zh',
    megabytes: 6,
  ),
  BibleVersion(
    id: 'cmn_cuv',
    abbreviation: '和合本（繁）',
    name: '新標點和合本',
    language: 'zh',
    megabytes: 6,
  ),
  BibleVersion(
    id: 'HINIRV',
    abbreviation: 'IRV',
    name: 'इंडियन रिवाइज्ड वर्जन',
    language: 'hi',
    megabytes: 13,
    attribution:
        'Indian Revised Version, © 2017–2019 Bridge Connectivity Solutions, '
        'CC BY-SA 4.0',
  ),
];

/// The version of [id], or null.
BibleVersion? bibleVersionOf(String? id) =>
    bibleVersions.where((version) => version.id == id).firstOrNull;

/// The first version of [language], English otherwise.
BibleVersion defaultBibleVersion(String language) =>
    bibleVersions
        .where((version) => version.language == language)
        .firstOrNull ??
    bibleVersions.firstWhere((version) => version.language == 'en');

/// A Bible under copyright the app may not keep nor show itself: read on a
/// site its publisher allows (for personal reading), at the chapter the
/// member is on. La Bible du Semeur (© Biblica) on Bibleserver.
class ExternalBible {
  const ExternalBible({
    required this.abbreviation,
    required this.name,
    required this.language,
    required this.site,
  });

  /// Bibleserver's code of the version ("BDS").
  final String abbreviation;
  final String name;
  final String language;

  /// Where it is read ("Bibleserver").
  final String site;

  /// The chapter [book] (USFM) [chapter] on Bibleserver:
  /// https://www.bibleserver.com/BDS/1Cor13.
  Uri chapterUrl(String book, int chapter) => Uri.https(
    'www.bibleserver.com',
    '/$abbreviation/${_bibleserverBooks[book] ?? 'Gen'}$chapter',
  );
}

const externalBibles = [
  ExternalBible(
    abbreviation: 'BDS',
    name: 'La Bible du Semeur',
    language: 'fr',
    site: 'Bibleserver',
  ),
];

/// The books as Bibleserver reads them, by their USFM code.
const _bibleserverBooks = {
  'GEN': 'Gen',
  'EXO': 'Exod',
  'LEV': 'Lev',
  'NUM': 'Num',
  'DEU': 'Deut',
  'JOS': 'Josh',
  'JDG': 'Judg',
  'RUT': 'Ruth',
  '1SA': '1Sam',
  '2SA': '2Sam',
  '1KI': '1Kgs',
  '2KI': '2Kgs',
  '1CH': '1Chr',
  '2CH': '2Chr',
  'EZR': 'Ezra',
  'NEH': 'Neh',
  'EST': 'Esth',
  'JOB': 'Job',
  'PSA': 'Ps',
  'PRO': 'Prov',
  'ECC': 'Eccl',
  'SNG': 'Song',
  'ISA': 'Isa',
  'JER': 'Jer',
  'LAM': 'Lam',
  'EZK': 'Ezek',
  'DAN': 'Dan',
  'HOS': 'Hos',
  'JOL': 'Joel',
  'AMO': 'Amos',
  'OBA': 'Obad',
  'JON': 'Jonah',
  'MIC': 'Mic',
  'NAM': 'Nah',
  'HAB': 'Hab',
  'ZEP': 'Zeph',
  'HAG': 'Hag',
  'ZEC': 'Zech',
  'MAL': 'Mal',
  'MAT': 'Matt',
  'MRK': 'Mark',
  'LUK': 'Luke',
  'JHN': 'John',
  'ACT': 'Acts',
  'ROM': 'Rom',
  '1CO': '1Cor',
  '2CO': '2Cor',
  'GAL': 'Gal',
  'EPH': 'Eph',
  'PHP': 'Phil',
  'COL': 'Col',
  '1TH': '1Thess',
  '2TH': '2Thess',
  '1TI': '1Tim',
  '2TI': '2Tim',
  'TIT': 'Titus',
  'PHM': 'Phlm',
  'HEB': 'Heb',
  'JAS': 'Jas',
  '1PE': '1Pet',
  '2PE': '2Pet',
  '1JN': '1John',
  '2JN': '2John',
  '3JN': '3John',
  'JUD': 'Jude',
  'REV': 'Rev',
};
