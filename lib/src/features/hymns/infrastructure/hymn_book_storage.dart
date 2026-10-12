import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/hymn.dart';

part 'hymn_book_storage.g.dart';

/// The hymn books on the phone: those shipped in assets/hymns (in the API format), and the
/// newer versions downloaded since, kept in the app's support directory.
class HymnBookStorage {
  HymnBookStorage({
    required Future<Directory> Function() directory,
    AssetBundle? bundle,
  }) : _directory = directory,
       _bundle = bundle ?? rootBundle;

  static const _assets = 'assets/hymns';

  final Future<Directory> Function() _directory;
  final AssetBundle _bundle;

  /// Codes of the books shipped with the app, in display order.
  Future<List<String>> bundledCodes() async {
    final index =
        jsonDecode(await _bundle.loadString('$_assets/index.json'))
            as List<dynamic>;
    return index.cast<String>();
  }

  Future<HymnBook?> readBundled(String code) async {
    try {
      return _parse(
        await _bundle.loadString('$_assets/$code.json', cache: false),
      );
    } on FlutterError {
      return null; // not shipped with this version of the app
    }
  }

  /// The downloaded copy of [code], or null.
  Future<HymnBook?> readSaved(String code) async {
    final file = await _file('$code.json');
    if (!file.existsSync()) {
      return null;
    }
    try {
      return _parse(await file.readAsString());
    } on Object {
      return null; // a broken file: the shipped copy or the server will replace it
    }
  }

  Future<void> save(HymnBook book) async {
    final file = await _file('${book.code}.json');
    // write then rename: never a half-written book
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString(jsonEncode(book.toJson()), flush: true);
    await temporary.rename(file.path);
  }

  /// Display order of the books, as last given by the server.
  Future<List<String>?> readOrder() async {
    final file = await _file('order.json');
    if (!file.existsSync()) {
      return null;
    }
    return (jsonDecode(await file.readAsString()) as List<dynamic>)
        .cast<String>();
  }

  Future<void> saveOrder(List<String> codes) async =>
      (await _file('order.json')).writeAsString(jsonEncode(codes));

  Future<File> _file(String name) async {
    final directory = Directory('${(await _directory()).path}/hymns');
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    return File('${directory.path}/$name');
  }

  /// A book is a few hundred KB of JSON: parsed off the UI thread.
  static Future<HymnBook> _parse(String json) => compute(
    (String source) =>
        HymnBook.fromJson(jsonDecode(source) as Map<String, dynamic>),
    json,
  );
}

@Riverpod(keepAlive: true)
HymnBookStorage hymnBookStorage(Ref ref) =>
    HymnBookStorage(directory: getApplicationSupportDirectory);
