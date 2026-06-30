import 'package:flutter/material.dart';
import 'package:rchive/features/note/domain/entities/note.dart';
import 'package:rchive/features/note/presentation/models/note_tree_node.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';
import 'package:path/path.dart' as p;

class NoteTreeView extends StatelessWidget {
  final NoteFolderNode root;

  final ValueChanged<Note> onOpenNote;
  final ValueChanged<NoteFolderNode>? onCreateNote;
  final ValueChanged<NoteFolderNode>? onCreateFolder;

  const NoteTreeView({
    super.key,
    required this.root,
    required this.onOpenNote,
    this.onCreateNote,
    this.onCreateFolder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...root.folders.map(
          (folder) => _FolderTile(
            folder: folder,
            onOpenNote: onOpenNote,
            onCreateNote: onCreateNote,
            onCreateFolder: onCreateFolder,
          ),
        ),
        ...root.notes.map(
          (note) => ListTile(
            dense: true,
            leading: const Icon(Icons.description_outlined),
            title: Text(note.name),
            onTap: () => onOpenNote(note),
          ),
        ),
      ],
    );
  }
}

class _FolderTile extends StatelessWidget {
  final NoteFolderNode folder;

  final ValueChanged<Note> onOpenNote;
  final ValueChanged<NoteFolderNode>? onCreateNote;
  final ValueChanged<NoteFolderNode>? onCreateFolder;

  const _FolderTile({
    required this.folder,
    required this.onOpenNote,
    this.onCreateNote,
    this.onCreateFolder,
  });
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: PageStorageKey(folder.path),
      leading: const Icon(Icons.folder_outlined),
      title: Text(folder.name, overflow: TextOverflow.ellipsis),
      initiallyExpanded: true,
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          switch (value) {
            case 'note':
              onCreateNote?.call(folder);
              break;
            case 'folder':
              onCreateFolder?.call(folder);
              break;
          }
        },
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'note', child: Text('New note')),
          PopupMenuItem(value: 'folder', child: Text('New folder')),
        ],
      ),
      children: [
        ...folder.folders.map(
          (child) => _FolderTile(
            folder: child,
            onOpenNote: onOpenNote,
            onCreateNote: onCreateNote,
            onCreateFolder: onCreateFolder,
          ),
        ),
        ...folder.notes.map(
          (note) => ListTile(
            dense: true,
            leading: const Icon(Icons.description_outlined),
            title: Text(note.name, overflow: TextOverflow.ellipsis),
            onTap: () => onOpenNote(note),
          ),
        ),
      ],
    );
  }
}

NoteFolderNode buildNoteTree(List<Note> entries) {
  final root = NoteFolderNode(name: '', path: '');

  final folders = <String, NoteFolderNode>{'': root};

  for (final entry in entries.where(
    (e) => e.type == VaultEntryType.directory,
  )) {
    final folder = NoteFolderNode(name: entry.name, path: entry.path);

    folders[entry.path] = folder;
  }

  for (final folder in folders.values) {
    if (folder.path.isEmpty) continue;

    final parentPath = p.dirname(folder.path);
    final parent = folders[parentPath == '.' ? '' : parentPath];

    parent?.folders.add(folder);
  }

  for (final note in entries.where((e) => e.type == VaultEntryType.file)) {
    final parentPath = note.folder;
    final parent = folders[parentPath] ?? root;

    parent.notes.add(note);
  }

  _sort(root);

  return root;
}

void _sort(NoteFolderNode folder) {
  folder.folders.sort((a, b) => a.name.compareTo(b.name));

  folder.notes.sort((a, b) => a.name.compareTo(b.name));

  for (final child in folder.folders) {
    _sort(child);
  }
}
