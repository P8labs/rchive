import 'package:rchive/features/vault/data/storage/vault_storage.dart';

class Note {
  final String path;
  final String name;
  final String folder;
  final VaultEntryType type;
  final int size;

  final DateTime? lastModified;

  const Note({
    required this.path,
    required this.name,
    required this.type,
    required this.folder,
    required this.size,
    this.lastModified,
  });

  Note copyWith({
    String? path,
    String? name,
    String? folder,
    int? size,
    DateTime? lastModified,
    VaultEntryType? type,
  }) {
    return Note(
      type: type ?? this.type,
      path: path ?? this.path,
      name: name ?? this.name,
      folder: folder ?? this.folder,
      size: size ?? this.size,
      lastModified: lastModified ?? this.lastModified,
    );
  }
}
