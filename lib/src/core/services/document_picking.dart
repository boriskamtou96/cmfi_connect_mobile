import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'document_picking.g.dart';

typedef PickedDocument = ({Uint8List bytes, String name});

/// A PDF or a Word file chosen on the phone (Fichiers on iPhone, the
/// documents of Android), for Nos documents. Behind a provider so tests
/// replace it.
class DocumentPicking {
  const DocumentPicking();

  static const extensions = ['pdf', 'docx', 'doc'];

  /// null when the user gives up.
  Future<PickedDocument?> pickOne() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: extensions,
    );
    if (file == null) {
      return null;
    }
    return (bytes: await file.xFile.readAsBytes(), name: file.name);
  }
}

@Riverpod(keepAlive: true)
DocumentPicking documentPicking(Ref ref) => const DocumentPicking();
