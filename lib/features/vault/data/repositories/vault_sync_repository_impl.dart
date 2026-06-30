import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/app_database.dart';
import 'package:rchive/core/database/database_provider.dart';
import 'package:rchive/core/database/tables/file_table.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/features/vault/constants/vault_constants.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';
import 'package:path/path.dart' as p;
import 'package:rchive/features/vault/domain/repository/vault_sync_repository.dart';

class VaultSyncRepositoryImpl implements VaultSyncRepository {
  final DatabaseProvider provider;
  const VaultSyncRepositoryImpl({required this.provider});

  VaultStorage get storage => provider.currentStorage!;
  AppDatabase get database => provider.appDatabase;
  Vault get vault => provider.currentVault!;

  @override
  Future<Either<Failure, Unit>> sync() async {
    try {
      final entries = <VaultEntry>[];
      await _scanDirectory('', entries);

      final scannedPaths = entries.map((e) => e.path).toSet();

      for (final entry in entries) {
        await _upsert(entry);
      }

      await _cleanup(scannedPaths);

      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> syncFile({required String path}) async {
    try {
      final parent = p.dirname(path);

      final entries = await storage.list(parent == '.' ? '' : parent);

      final entry = entries.where((e) => e.path == path).firstOrNull;

      if (entry == null) {
        await (database.delete(
          database.vaultFileTable,
        )..where((t) => t.vaultId.equals(vault.id) & t.path.equals(path))).go();
      } else {
        await _upsert(entry);
      }

      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> _cleanup(Set<String> scannedPaths) async {
    final files = await (database.select(
      database.vaultFileTable,
    )..where((t) => t.vaultId.equals(vault.id))).get();

    for (final file in files) {
      if (!scannedPaths.contains(file.path)) {
        await (database.delete(database.vaultFileTable)..where(
              (t) => t.vaultId.equals(vault.id) & t.path.equals(file.path),
            ))
            .go();
      }
    }
  }

  Future<void> _scanDirectory(
    String path,
    List<VaultEntry> output, {
    Set<String>? visited,
    int depth = 0,
  }) async {
    final storage = provider.currentStorage;
    if (storage == null) {
      throw StateError('No vault is currently open.');
    }

    visited ??= <String>{};

    if (!visited.add(path)) {
      return;
    }

    // Prevent pathological recursion.
    if (depth > 128) {
      throw StateError('Maximum directory depth exceeded.');
    }

    List<VaultEntry> entries;

    try {
      entries = await storage.list(path);
    } catch (e) {
      debugPrint('Failed to scan "$path": $e');
      return;
    }

    for (final entry in entries) {
      output.add(entry);

      if (entry.type == VaultEntryType.directory) {
        await _scanDirectory(
          entry.path,
          output,
          visited: visited,
          depth: depth + 1,
        );
      }
    }
  }

  Future<void> _upsert(VaultEntry entry) async {
    final vault = provider.currentVault!;

    await database
        .into(database.vaultFileTable)
        .insertOnConflictUpdate(
          VaultFileTableCompanion(
            vaultId: Value(vault.id),
            path: Value(entry.path),
            type: Value(entry.type),
            category: Value(_category(entry.path)),
            size: Value(entry.size),
            lastModified: Value(entry.modifiedAt),
            indexedAt: Value(DateTime.now().toUtc()),
          ),
        );
  }

  VaultFileCategory _category(String path) {
    if (path == VaultConstants.metadataFile) {
      return VaultFileCategory.metadata;
    }

    if (path.startsWith('${VaultConstants.notesDirectory}/') ||
        path == VaultConstants.notesDirectory) {
      return VaultFileCategory.note;
    }

    if (path.startsWith('${VaultConstants.attachmentsDirectory}/') ||
        path == VaultConstants.attachmentsDirectory) {
      return VaultFileCategory.attachment;
    }

    return VaultFileCategory.trash;
  }
}
