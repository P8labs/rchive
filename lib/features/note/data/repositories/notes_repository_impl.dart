import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/app_database.dart';
import 'package:rchive/core/database/database_provider.dart';
import 'package:rchive/core/database/tables/file_table.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/features/note/data/models/note_model.dart';
import 'package:rchive/features/note/domain/entities/note.dart';
import 'package:rchive/features/note/domain/repository/notes_repository.dart';
import 'package:rchive/features/vault/constants/vault_constants.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';
import 'package:rchive/features/vault/domain/repository/vault_sync_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final DatabaseProvider provider;
  final VaultSyncRepository syncRepository;

  const NotesRepositoryImpl({
    required this.provider,
    required this.syncRepository,
  });

  VaultStorage get storage => provider.currentStorage!;
  AppDatabase get database => provider.appDatabase;
  Vault get vault => provider.currentVault!;

  @override
  Future<Either<Failure, Unit>> createNote({
    required String path,
    String? raw,
  }) async {
    try {
      final content = Uint8List.fromList(utf8.encode(raw ?? ''));
      await storage.write(path, content);
      final result = await syncRepository.syncFile(path: path);
      result.fold(left, right);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote({required String path}) async {
    try {
      await storage.delete(path);
      final result = await syncRepository.syncFile(path: path);
      result.fold(left, right);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Note>> getNote({required String path}) async {
    try {
      final row =
          await (database.select(database.vaultFileTable)..where(
                (t) =>
                    t.vaultId.equals(vault.id) &
                    t.category.equals(VaultFileCategory.note.name) &
                    t.path.equals(path),
              ))
              .getSingle();

      return right(NoteModel.fromDrift(row));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final rows =
          await (database.select(database.vaultFileTable)
                ..where(
                  (t) =>
                      t.vaultId.equals(vault.id) &
                      t.category.equals(VaultFileCategory.note.name),
                )
                ..orderBy([(t) => OrderingTerm.asc(t.path)]))
              .get();

      return right(rows.map(NoteModel.fromDrift).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> moveToTrash({required String path}) async {
    try {
      final fileName = p.basename(path);
      final destination = p.join(VaultConstants.trashDirectory, fileName);

      await storage.move(path, destination);

      await syncRepository.syncFile(path: path);

      return await syncRepository.syncFile(path: destination);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> moveNote({
    required String source,
    required String destination,
  }) async {
    try {
      await storage.move(source, destination);

      await syncRepository.syncFile(path: source);
      return await syncRepository.syncFile(path: destination);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> readNote({required String path}) async {
    try {
      final bytes = await storage.read(path);

      return right(utf8.decode(bytes));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> renameNote({
    required String path,
    required String newName,
  }) async {
    try {
      await storage.rename(path, newName);

      final parent = p.dirname(path);
      final newPath = p.join(parent, newName);

      await syncRepository.syncFile(path: path);
      await syncRepository.syncFile(path: newPath);
      return right(newPath);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> writeNote({
    required String path,
    required String content,
  }) async {
    try {
      await storage.write(path, Uint8List.fromList(utf8.encode(content)));
      return await syncRepository.syncFile(path: path);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
