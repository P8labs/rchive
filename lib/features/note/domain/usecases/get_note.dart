import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/entities/note.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';

class GetNote implements UseCase<Note, GetNoteParams> {
  final NotesRepository repository;

  const GetNote(this.repository);

  @override
  Future<Either<Failure, Note>> call(GetNoteParams params) {
    return repository.getNote(path: params.path);
  }
}

class GetNoteParams {
  final String path;

  const GetNoteParams({required this.path});
}
