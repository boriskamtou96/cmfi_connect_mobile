import 'dart:convert';

import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/bible_api.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/bible_storage.dart';

/// A few books, as the API lists them (French names, as Louis Segond).
const sampleBibleBooks = [
  BibleBook(id: 'GEN', name: 'Genèse', order: 1, chapters: 50),
  BibleBook(id: 'PSA', name: 'Psaumes', order: 19, chapters: 150),
  BibleBook(id: 'JHN', name: 'Jean', order: 43, chapters: 21),
  BibleBook(id: '1JN', name: '1 Jean', order: 62, chapters: 5),
  BibleBook(id: 'JUD', name: 'Jude', order: 65, chapters: 1),
];

/// A chapter as the API writes it. John 3 and Psalm 23 have their words (a
/// section title, the words of Jesus, a poem); the others say where they are.
Map<String, dynamic> sampleBibleChapter(String book, int number) {
  if (book == 'JHN' && number == 3) {
    return {
      'number': 3,
      'content': [
        {
          'type': 'heading',
          'content': ['Entretien de Jésus avec Nicodème'],
        },
        {
          'type': 'verse',
          'number': 1,
          'content': [
            'Mais il y eut un homme d’entre les pharisiens, nommé Nicodème, '
                'un chef des Juifs,',
          ],
        },
        {
          'type': 'verse',
          'number': 2,
          'content': [
            'qui vint, lui, auprès de Jésus, de nuit, et lui dit: Rabbi, nous '
                'savons que tu es un docteur venu de Dieu.',
          ],
        },
        {
          'type': 'verse',
          'number': 3,
          'content': [
            'Jésus lui répondit:',
            {
              'text':
                  'En vérité, en vérité, je te le dis, si un homme ne naît de '
                  'nouveau, il ne peut voir le royaume de Dieu.',
              'wordsOfJesus': true,
            },
          ],
        },
        {
          'type': 'verse',
          'number': 16,
          'content': [
            {
              'text':
                  'Car Dieu a tant aimé le monde qu’il a donné son Fils '
                  'unique, afin que quiconque croit en lui ne périsse point, '
                  'mais qu’il ait la vie éternelle.',
              'wordsOfJesus': true,
            },
            {'noteId': 4},
          ],
        },
        {
          'type': 'verse',
          'number': 17,
          'content': [
            {
              'text':
                  'Dieu, en effet, n’a pas envoyé son Fils dans le monde pour '
                  'qu’il juge le monde, mais pour que le monde soit sauvé par '
                  'lui.',
              'wordsOfJesus': true,
            },
          ],
        },
      ],
    };
  }
  if (book == 'PSA' && number == 23) {
    return {
      'number': 23,
      'content': [
        {
          'type': 'verse',
          'number': 1,
          'content': [
            {'text': 'Cantique de David.', 'poem': 1},
            {'lineBreak': true},
            {
              'text': 'L’Éternel est mon berger: je ne manquerai de rien.',
              'poem': 1,
            },
          ],
        },
        {
          'type': 'verse',
          'number': 2,
          'content': [
            {'lineBreak': true},
            {'text': 'Il me fait reposer dans de verts pâturages,', 'poem': 1},
            {'lineBreak': true},
            {'text': 'Il me dirige près des eaux paisibles.', 'poem': 1},
          ],
        },
      ],
    };
  }
  final name = sampleBibleBooks.firstWhere((b) => b.id == book).name;
  return {
    'number': number,
    'content': [
      for (var verse = 1; verse <= 5; verse++)
        {
          'type': 'verse',
          'number': verse,
          'content': ['Texte de $name $number:$verse.'],
        },
    ],
  };
}

/// complete.json of the sample books.
Map<String, dynamic> sampleCompleteBible() => {
  'translation': {'id': 'fra_lsg'},
  'books': [
    for (final book in sampleBibleBooks)
      {
        ...book.toJson(),
        'commonName': book.name,
        'chapters': [
          for (var number = 1; number <= book.chapters; number++)
            {'chapter': sampleBibleChapter(book.id, number)},
        ],
      },
  ],
};

/// The Bible API: the sample books for every version; [offline] answers as
/// without network.
class FakeBibleApi implements BibleApi {
  bool offline = false;

  /// "fra_lsg/JHN.3": the chapters fetched.
  final chaptersAsked = <String>[];
  final downloads = <String>[];

  @override
  Future<List<BibleBook>> books(String version) async {
    if (offline) {
      throw const NetworkException();
    }
    return sampleBibleBooks;
  }

  @override
  Future<Map<String, dynamic>> chapter(
    String version,
    String book,
    int number,
  ) async {
    if (offline) {
      throw const NetworkException();
    }
    chaptersAsked.add('$version/$book.$number');
    return sampleBibleChapter(book, number);
  }

  @override
  Future<List<int>> complete(
    String version, {
    void Function(int received, int total)? onProgress,
  }) async {
    if (offline) {
      throw const NetworkException();
    }
    onProgress?.call(1, 2);
    downloads.add(version);
    return utf8.encode(jsonEncode(sampleCompleteBible()));
  }
}

/// The files of the Bible kept in memory ("fra_lsg/JHN.3.json").
class FakeBibleStorage implements BibleStorage {
  final files = <String, String>{};

  @override
  Future<String?> read(String version, String name) async =>
      files['$version/$name'];

  @override
  Future<bool> has(String version, String name) async =>
      files.containsKey('$version/$name');

  @override
  Future<void> write(String version, String name, List<int> bytes) async =>
      files['$version/$name'] = utf8.decode(bytes);

  @override
  Future<void> remove(String version, String name) async =>
      files.remove('$version/$name');
}
