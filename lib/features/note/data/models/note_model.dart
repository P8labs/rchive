import 'package:rchive/core/database/app_database.dart';
import 'package:rchive/features/note/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.path,
    required super.name,
    required super.folder,
    required super.type,
    required super.size,
    super.lastModified,
  });

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      path: note.path,
      name: note.name,
      folder: note.folder,
      type: note.type,
      size: note.size,
      lastModified: note.lastModified,
    );
  }

  factory NoteModel.fromDrift(VaultFileTableData row) {
    return NoteModel(
      path: row.path,
      type: row.type,
      name: _nameFromPath(row.path),
      folder: _folderFromPath(row.path),
      size: row.size ?? 0,
      lastModified: row.lastModified,
    );
  }

  Note toEntity() {
    return Note(
      path: path,
      name: name,
      folder: folder,
      type: type,
      size: size,
      lastModified: lastModified,
    );
  }

  static String _nameFromPath(String path) {
    final fileName = path.split('/').last;
    final dot = fileName.lastIndexOf('.');

    return dot == -1 ? fileName : fileName.substring(0, dot);
  }

  static String _folderFromPath(String path) {
    final parts = path.split('/');

    if (parts.length <= 2) {
      return '';
    }

    return parts.sublist(1, parts.length - 1).join('/');
  }
}
