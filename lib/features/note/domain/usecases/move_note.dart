import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';

class MoveNote implements UseCase<Unit, MoveNoteParams> {
  final NotesRepository repository;

  const MoveNote(this.repository);

  @override
  Future<Either<Failure, Unit>> call(MoveNoteParams params) {
    return repository.moveNote(
      source: params.source,
      destination: params.destination,
    );
  }
}

class MoveNoteParams {
  final String source;
  final String destination;

  const MoveNoteParams({required this.source, required this.destination});
}
