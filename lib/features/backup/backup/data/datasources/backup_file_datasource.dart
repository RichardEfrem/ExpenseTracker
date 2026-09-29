import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// The system share sheet and file pickers (Android Storage Access
/// Framework). The only place backup touches files.
class BackupFileDataSource {
  const BackupFileDataSource();

  static const _mimeType = 'application/json';

  /// False when the user dismissed the share sheet.
  Future<bool> share(String contents, String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsString(contents, flush: true);
    final result = await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: _mimeType)],
        fileNameOverrides: [fileName],
      ),
    );
    return result.status != ShareResultStatus.dismissed;
  }

  /// Save dialog; false when cancelled.
  Future<bool> save(String contents, String fileName) async =>
      await FilePicker.saveFile(
        fileName: fileName,
        bytes: utf8.encode(contents),
        mimeType: _mimeType,
      ) !=
      null;

  /// The picked file's text, or null when cancelled.
  Future<String?> pick() async {
    final file = await FilePicker.pickFile();
    return file?.xFile.readAsString();
  }
}
