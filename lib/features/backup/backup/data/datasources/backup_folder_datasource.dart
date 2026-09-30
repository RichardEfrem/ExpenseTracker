import 'dart:io';

import 'package:flutter/services.dart';

/// A folder the user granted through the Storage Access Framework, kept
/// across restarts (persisted URI permission) so auto-backups can write to
/// it without asking (PRD BAK-05). Implemented in `MainActivity.kt`.
class BackupFolderDataSource {
  const BackupFolderDataSource();

  static const _channel = MethodChannel('expense_tracker/backup_folder');

  /// `(uri, name)` of the chosen folder, or null when cancelled.
  Future<({String uri, String name})?> pick() => _call(() async {
    final folder = await _channel.invokeMapMethod<String, String>('pickFolder');
    if (folder == null) return null;
    return (uri: folder['uri']!, name: folder['name'] ?? '');
  });

  Future<void> write(String uri, String fileName, String contents) => _call(
    () => _channel.invokeMethod<void>('writeFile', {
      'uri': uri,
      'name': fileName,
      'mimeType': 'application/json',
      'contents': contents,
    }),
  );

  Future<void> release(String uri) =>
      _call(() => _channel.invokeMethod<void>('releaseFolder', {'uri': uri}));

  /// Platform errors are file errors here (e.g. access revoked), so the
  /// shared error mapping reports them as such.
  static Future<T> _call<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on PlatformException catch (e) {
      throw FileSystemException(e.message ?? e.code);
    }
  }
}
