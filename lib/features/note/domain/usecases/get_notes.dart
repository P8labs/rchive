import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/entities/note.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';

class GetNotes implements UseCase<List<Note>, NoParams> {
  final NotesRepository repository;

  const GetNotes(this.repository);

  @override
  Future<Either<Failure, List<Note>>> call(NoParams params) {
    return repository.getNotes();
  }
}
