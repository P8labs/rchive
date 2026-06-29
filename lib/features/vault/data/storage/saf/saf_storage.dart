import 'dart:typed_data';

import 'package:flutter_saf/flutter_saf.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';

final class SafStorage implements VaultStorage {
  final String treeUri;

  const SafStorage({required this.treeUri});

  @override
  Future<bool> exists([String path = ""]) {
    return FlutterSafChannel.exists(treeUri: treeUri, path: path);
  }

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
  Future<void> createDirectory(String path) {
    return FlutterSafChannel.createDirectory(treeUri: treeUri, path: path);
  }

  @override
  Future<void> delete(String path, {bool recursive = false}) {
    return FlutterSafChannel.delete(
      treeUri: treeUri,
      path: path,
      recursive: recursive,
    );
  }

  @override
  Future<void> rename(String path, String newName) {
    return FlutterSafChannel.rename(
      treeUri: treeUri,
      path: path,
      newName: newName,
    );
  }

  @override
  Future<void> move(String source, String destination) {
    throw UnimplementedError('move() is not implemented yet.');
  }

  @override
  Future<Uint8List> read(String path) {
    return FlutterSafChannel.read(treeUri: treeUri, path: path);
  }

  @override
  Future<void> write(String path, Uint8List bytes) {
    return FlutterSafChannel.write(treeUri: treeUri, path: path, bytes: bytes);
  }

  @override
  String get location => treeUri;
}
