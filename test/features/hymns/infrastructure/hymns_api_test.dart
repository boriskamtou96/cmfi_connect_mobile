import 'package:cmfi_connect/src/features/hymns/domain/hymn.dart';
import 'package:cmfi_connect/src/features/hymns/infrastructure/hymns_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter server;
  late HymnsApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = HymnsApi(dio);
  });

  // exact shape of GET /v1/hymns/books/:code
  final bookJson = {
    'code': 'christ-est-vainqueur',
    'title': 'Christ est vainqueur',
    'language': 'fr',
    'hymn_count': 1,
    'version': '20261008T224132.567169Z',
    'hymns': [
      {
        'number': 1,
        'title': 'Grand Dieu, nous te bénissons',
        'author': 'EMPEYTAZ.',
        'first_line': 'Grand Dieu, nous te bénissons,',
        'parts': [
          {
            'kind': 'verse',
            'label': '1',
            'lines': [
              'Grand Dieu, nous te bénissons,',
              'Nous célébrons tes louanges ;',
            ],
          },
          {
            'kind': 'chorus',
            'repeat': 2,
            'lines': ['Quel beau nom'],
          },
        ],
      },
    ],
  };

  test('lists the books with their versions', () async {
    server.onGet(
      '/hymns/books',
      (s) => s.reply(200, {
        'status': 200,
        'content': [
          {
            'code': 'christ-est-vainqueur',
            'title': 'Christ est vainqueur',
            'language': 'fr',
            'hymn_count': 215,
            'version': '20261008T224132.567169Z',
          },
        ],
      }),
    );

    final books = await api.listBooks();

    expect(books.single.hymnCount, 215);
    expect(books.single.version, '20261008T224132.567169Z');
  });

  test('parses a whole book', () async {
    server.onGet(
      '/hymns/books/christ-est-vainqueur',
      (s) => s.reply(200, {'status': 200, 'content': bookJson}),
    );

    final book = (await api.getBook('christ-est-vainqueur'))!;

    final hymn = book.hymn(1)!;
    expect(hymn.author, 'EMPEYTAZ.');
    expect(hymn.firstLine, 'Grand Dieu, nous te bénissons,');
    expect(hymn.parts.first.label, '1');
    expect(hymn.parts.last.kind, HymnPartKind.chorus);
    expect(hymn.parts.last.repeat, 2);
  });

  test('an up to date book answers 304 and nothing is downloaded', () async {
    server.onGet(
      '/hymns/books/christ-est-vainqueur',
      (s) => s.reply(304, null),
      headers: {
        'If-None-Match': '"christ-est-vainqueur@20261008T224132.567169Z"',
      },
    );

    expect(
      await api.getBook(
        'christ-est-vainqueur',
        version: '20261008T224132.567169Z',
      ),
      isNull,
    );
  });
}
