import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';

class CreateNote implements UseCase<Unit, CreateNoteParams> {
  final NotesRepository repository;

  const CreateNote(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CreateNoteParams params) {
    return repository.createNote(path: params.path, raw: params.content);
  }
}

class CreateNoteParams {
  final String path;
  final String content;

  const CreateNoteParams({required this.path, this.content = ''});
}
