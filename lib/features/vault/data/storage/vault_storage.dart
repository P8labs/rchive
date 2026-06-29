import 'dart:typed_data';

abstract interface class VaultStorage {
  String get location;

  /// Returns whether a file or directory exists.
  Future<bool> exists([String path = ""]);

  /// Lists the direct children of a directory.
  Future<List<VaultEntry>> list(String path);

  /// Creates a directory recursively.
  Future<void> createDirectory(String path);

  /// Reads a file.
  Future<Uint8List> read(String path);

  /// Writes a file.
  ///
  /// Creates the file if it doesn't already exist.
  Future<void> write(String path, Uint8List bytes);

  /// Deletes a file or directory.
  Future<void> delete(String path, {bool recursive = false});

  /// Renames a file or directory.
  Future<void> rename(String path, String newName);

  /// Moves a file or directory.
  Future<void> move(String source, String destination);
}

enum VaultEntryType { file, directory }

final class VaultEntry {
  final String name;

  /// Relative path from the vault root.
  ///
  /// Examples:
  /// notes
  /// notes/daily.md
  /// assets/logo.png
  final String path;

  final VaultEntryType type;

  final int? size;

  final DateTime? modifiedAt;

  const VaultEntry({
    required this.name,
    required this.path,
    required this.type,
    this.size,
    this.modifiedAt,
  });

  bool get isFile => type == VaultEntryType.file;

  bool get isDirectory => type == VaultEntryType.directory;
}
