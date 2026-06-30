import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';

class ReadNote implements UseCase<String, ReadNoteParams> {
  final NotesRepository repository;

  const ReadNote(this.repository);

  @override
  Future<Either<Failure, String>> call(ReadNoteParams params) {
    return repository.readNote(path: params.path);
  }
}

class ReadNoteParams {
  final String path;

  const ReadNoteParams({required this.path});
}
