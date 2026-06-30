import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';

class TrashNote implements UseCase<Unit, TrashNoteParams> {
  final NotesRepository repository;

  const TrashNote(this.repository);

  @override
  Future<Either<Failure, Unit>> call(TrashNoteParams params) {
    return repository.moveToTrash(path: params.path);
  }
}

class TrashNoteParams {
  final String path;

  const TrashNoteParams({required this.path});
}
