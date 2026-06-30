import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';

class RenameNote implements UseCase<String, RenameNoteParams> {
  final NotesRepository repository;

  const RenameNote(this.repository);

  @override
  Future<Either<Failure, String>> call(RenameNoteParams params) {
    return repository.renameNote(path: params.path, newName: params.newName);
  }
}

class RenameNoteParams {
  final String path;
  final String newName;

  const RenameNoteParams({required this.path, required this.newName});
}
