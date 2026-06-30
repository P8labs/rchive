import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:flutter_saf/flutter_saf.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';

final class SafStorage implements VaultStorage {
  final String _treeUri;
  final String root;
  const SafStorage({required this._treeUri, this.root = ""});

  @override
  Future<bool> exists([String path = ""]) {
    return FlutterSafChannel.exists(treeUri: treeUri, path: path);
  }

  @override
  String get treeUri => _treeUri;

  @override
  Future<List<VaultEntry>> list(String path) async {
    final entries = await FlutterSafChannel.list(treeUri: treeUri, path: path);

    return entries
        .map(
          (entry) => VaultEntry(
            name: entry.name,
            path: entry.path,
            type: switch (entry.type) {
              DocumentType.file => VaultEntryType.file,
              DocumentType.directory => VaultEntryType.directory,
            },
            size: entry.size,
            modifiedAt: entry.lastModified,
          ),
        )
        .toList();
  }

  @override
  Future<String> createDirectory(String path) {
    return FlutterSafChannel.createDirectory(
      treeUri: treeUri,
      path: _resolve(path),
    );
  }

  @override
  Future<void> delete(String path, {bool recursive = false}) {
    return FlutterSafChannel.delete(
      treeUri: treeUri,
      path: _resolve(path),
      recursive: recursive,
    );
  }

  @override
  Future<void> rename(String path, String newName) {
    return FlutterSafChannel.rename(
      treeUri: treeUri,
      path: _resolve(path),
      newName: newName,
    );
  }

  @override
  Future<void> move(String source, String destination) {
    throw UnimplementedError('move() is not implemented yet.');
  }

  @override
  Future<Uint8List> read(String path) {
    return FlutterSafChannel.read(treeUri: treeUri, path: _resolve(path));
  }

  @override
  Future<void> write(String path, Uint8List bytes) {
    return FlutterSafChannel.write(
      treeUri: treeUri,
      path: _resolve(path),
      bytes: bytes,
    );
  }

  String _resolve(String path) {
    if (root.isEmpty) {
      return path;
    }
    return p.join(root, path);
  }
}
