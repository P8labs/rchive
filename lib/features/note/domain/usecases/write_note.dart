import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';

class WriteNote implements UseCase<Unit, WriteNoteParams> {
  final NotesRepository repository;

  const WriteNote(this.repository);

  @override
  Future<Either<Failure, Unit>> call(WriteNoteParams params) {
    return repository.writeNote(path: params.path, content: params.content);
  }
}

class WriteNoteParams {
  final String path;
  final String content;

  const WriteNoteParams({required this.path, required this.content});
}
