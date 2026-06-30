import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';

class DeleteNote implements UseCase<Unit, DeleteNoteParams> {
  final NotesRepository repository;

  const DeleteNote(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteNoteParams params) {
    return repository.deleteNote(path: params.path);
  }
}

class DeleteNoteParams {
  final String path;

  const DeleteNoteParams({required this.path});
}
