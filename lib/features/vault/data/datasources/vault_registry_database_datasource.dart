import 'package:drift/drift.dart';
import 'package:rchive/core/comman/entities/vault.dart';

import 'package:rchive/core/database/app_database.dart';
import 'package:rchive/features/vault/data/models/app_vault_model.dart';

abstract interface class VaultRegistryLocalDataSource {
  Future<List<Vault>> getAll();
  Future<Vault?> getById(String id);
  Future<void> register(Vault vault);
  Future<void> update(Vault vault);
  Future<void> forget(String id);
}

class VaultRegistryDatabaseDataSourceImpl
    implements VaultRegistryLocalDataSource {
  final AppDatabase database;

  VaultRegistryDatabaseDataSourceImpl(this.database);

  @override
  Future<List<Vault>> getAll() async {
    final rows = await database.select(database.vaultTable).get();

    return rows.map((row) => AppVaultModel.fromDrift(row)).toList();
  }

  @override
  Future<Vault?> getById(String id) async {
    final row = await (database.select(
      database.vaultTable,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (row == null) return null;

    return AppVaultModel.fromDrift(row).toEntity();
  }

  @override
  Future<void> register(Vault vault) async {
    await database
        .into(database.vaultTable)
        .insertOnConflictUpdate(
          VaultTableCompanion.insert(
            id: Value(vault.id),
            name: vault.name,
            treeUri: vault.treeUri,
            location: vault.location,
            storageType: vault.storageType.name,
            version: vault.version,
            createdAt: vault.createdAt,
            lastOpenedAt: Value(vault.lastOpenedAt),
          ),
        );
  }

  @override
  Future<void> update(Vault vault) async {
    await (database.update(
      database.vaultTable,
    )..where((t) => t.id.equals(vault.id))).write(
      VaultTableCompanion(
        id: Value(vault.id),
        name: Value(vault.name),
        location: Value(vault.location),
        storageType: Value(vault.storageType.name),
        version: Value(vault.version),
        lastOpenedAt: Value(vault.lastOpenedAt),
      ),
    );
  }

  @override
  Future<void> forget(String id) async {
    await (database.delete(
      database.vaultTable,
    )..where((t) => t.id.equals(id))).go();
  }
}
