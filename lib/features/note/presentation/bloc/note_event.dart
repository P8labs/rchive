part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {
  const NoteEvent();
}

final class LoadNotesEvent extends NoteEvent {
  const LoadNotesEvent();
}

final class OpenNoteEvent extends NoteEvent {
  final String path;

  const OpenNoteEvent(this.path);
}

final class CreateNoteEvent extends NoteEvent {
  final String path;
  final String content;

  const CreateNoteEvent({required this.path, this.content = ''});
}

final class SaveNoteEvent extends NoteEvent {
  final String path;
  final String content;

  const SaveNoteEvent({required this.path, required this.content});
}

final class RenameNoteEvent extends NoteEvent {
  final String path;
  final String newName;

  const RenameNoteEvent({required this.path, required this.newName});
}

final class MoveNoteEvent extends NoteEvent {
  final String source;
  final String destination;

  const MoveNoteEvent({required this.source, required this.destination});
}

final class DeleteNoteEvent extends NoteEvent {
  final String path;

  const DeleteNoteEvent(this.path);
}

final class TrashNoteEvent extends NoteEvent {
  final String path;

  const TrashNoteEvent(this.path);
}
