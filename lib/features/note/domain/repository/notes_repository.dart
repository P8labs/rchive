import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/features/note/domain/entities/note.dart';

abstract interface class NotesRepository {
  Future<Either<Failure, List<Note>>> getNotes();

  Future<Either<Failure, Note>> getNote({required String path});

  Future<Either<Failure, Unit>> createNote({required String path, String? raw});

  Future<Either<Failure, String>> readNote({required String path});

  Future<Either<Failure, Unit>> writeNote({
    required String path,
    required String content,
  });

  Future<Either<Failure, String>> renameNote({
    required String path,
    required String newName,
  });

  Future<Either<Failure, Unit>> moveNote({
    required String source,
    required String destination,
  });

  Future<Either<Failure, Unit>> moveToTrash({required String path});
  Future<Either<Failure, Unit>> deleteNote({required String path});
}
