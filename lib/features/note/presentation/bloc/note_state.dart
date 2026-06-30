part of 'note_bloc.dart';

@immutable
sealed class NoteState {
  const NoteState();
}

final class NoteInitial extends NoteState {
  const NoteInitial();
}

final class NoteLoading extends NoteState {
  const NoteLoading();
}

final class NotesLoaded extends NoteState {
  final List<Note> notes;

  const NotesLoaded(this.notes);
}

final class NoteLoaded extends NoteState {
  final Note note;
  final String content;

  const NoteLoaded({required this.note, required this.content});

  NoteLoaded copyWith({Note? note, String? content}) {
    return NoteLoaded(
      note: note ?? this.note,
      content: content ?? this.content,
    );
  }
}

final class NoteOperationSuccess extends NoteState {
  const NoteOperationSuccess();
}

final class NoteFailure extends NoteState {
  final String message;

  const NoteFailure(this.message);
}
