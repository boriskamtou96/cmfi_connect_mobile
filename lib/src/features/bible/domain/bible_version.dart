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
