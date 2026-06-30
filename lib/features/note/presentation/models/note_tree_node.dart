import 'package:rchive/features/note/domain/entities/note.dart';

sealed class NoteTreeNode {
  const NoteTreeNode();
}

final class NoteFolderNode extends NoteTreeNode {
  final String name;
  final String path;

  final List<NoteFolderNode> folders;
  final List<Note> notes;

  NoteFolderNode({
    required this.name,
    required this.path,
    List<NoteFolderNode>? folders,
    List<Note>? notes,
  }) : folders = folders ?? [],
       notes = notes ?? [];
}
