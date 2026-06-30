import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/entities/note.dart';
import 'package:rchive/features/note/domain/usecases/create_note.dart';
import 'package:rchive/features/note/domain/usecases/delete_note.dart';
import 'package:rchive/features/note/domain/usecases/get_note.dart';
import 'package:rchive/features/note/domain/usecases/get_notes.dart';
import 'package:rchive/features/note/domain/usecases/move_note.dart';
import 'package:rchive/features/note/domain/usecases/read_note.dart';
import 'package:rchive/features/note/domain/usecases/rename_note.dart';
import 'package:rchive/features/note/domain/usecases/trash_note.dart';
import 'package:rchive/features/note/domain/usecases/write_note.dart';
part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotes _getNotes;
  final GetNote _getNote;
  final ReadNote _readNote;
  final CreateNote _createNote;
  final WriteNote _writeNote;
  final RenameNote _renameNote;
  final MoveNote _moveNote;
  final DeleteNote _deleteNote;
  final TrashNote _trashNote;

  NoteBloc({
    required this._getNotes,
    required this._getNote,
    required this._readNote,
    required this._createNote,
    required this._writeNote,
    required this._renameNote,
    required this._moveNote,
    required this._deleteNote,
    required this._trashNote,
  }) : super(const NoteInitial()) {
    on<LoadNotesEvent>(_onLoadNotes);
    on<OpenNoteEvent>(_onOpenNote);
    on<CreateNoteEvent>(_onCreateNote);
    on<SaveNoteEvent>(_onSaveNote);
    on<RenameNoteEvent>(_onRenameNote);
    on<MoveNoteEvent>(_onMoveNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<TrashNoteEvent>(_onTrashNote);
  }

  Future<void> _onLoadNotes(
    LoadNotesEvent event,
    Emitter<NoteState> emit,
  ) async {
    emit(const NoteLoading());

    final result = await _getNotes(NoParams());

    result.fold(
      (failure) {
        emit(NoteFailure(failure.message));
      },
      (notes) {
        emit(NotesLoaded(notes));
      },
    );
  }

  Future<void> _onOpenNote(OpenNoteEvent event, Emitter<NoteState> emit) async {
    emit(const NoteLoading());

    final noteResult = await _getNote(GetNoteParams(path: event.path));

    await noteResult.fold(
      (failure) async {
        emit(NoteFailure(failure.message));
      },
      (note) async {
        final contentResult = await _readNote(ReadNoteParams(path: event.path));

        contentResult.fold(
          (failure) {
            emit(NoteFailure(failure.message));
          },
          (content) {
            emit(NoteLoaded(note: note, content: content));
          },
        );
      },
    );
  }

  Future<void> _onCreateNote(
    CreateNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    emit(const NoteLoading());

    final result = await _createNote(
      CreateNoteParams(path: event.path, content: event.content),
    );

    await result.fold(
      (failure) async {
        emit(NoteFailure(failure.message));
      },
      (_) async {
        add(const LoadNotesEvent());
        add(OpenNoteEvent(event.path));
      },
    );
  }

  Future<void> _onSaveNote(SaveNoteEvent event, Emitter<NoteState> emit) async {
    final result = await _writeNote(
      WriteNoteParams(path: event.path, content: event.content),
    );

    result.fold(
      (failure) {
        emit(NoteFailure(failure.message));
      },
      (_) {
        add(OpenNoteEvent(event.path));
      },
    );
  }

  Future<void> _onRenameNote(
    RenameNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    final result = await _renameNote(
      RenameNoteParams(path: event.path, newName: event.newName),
    );

    await result.fold(
      (failure) async {
        emit(NoteFailure(failure.message));
      },
      (newPath) async {
        add(const LoadNotesEvent());
        add(OpenNoteEvent(newPath));
      },
    );
  }

  Future<void> _onMoveNote(MoveNoteEvent event, Emitter<NoteState> emit) async {
    final result = await _moveNote(
      MoveNoteParams(source: event.source, destination: event.destination),
    );

    await result.fold(
      (failure) async {
        emit(NoteFailure(failure.message));
      },
      (_) async {
        add(const LoadNotesEvent());
        add(OpenNoteEvent(event.destination));
      },
    );
  }

  Future<void> _onDeleteNote(
    DeleteNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    final result = await _deleteNote(DeleteNoteParams(path: event.path));

    result.fold(
      (failure) {
        emit(NoteFailure(failure.message));
      },
      (_) {
        add(const LoadNotesEvent());
      },
    );
  }

  Future<void> _onTrashNote(
    TrashNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    final result = await _trashNote(TrashNoteParams(path: event.path));

    result.fold(
      (failure) {
        emit(NoteFailure(failure.message));
      },
      (_) {
        add(const LoadNotesEvent());
      },
    );
  }
}
