import 'package:drift/drift.dart';
import 'package:rchive/core/comman/entities/vault.dart';

import 'package:rchive/core/database/app_database.dart';
import 'package:rchive/features/vault/data/models/app_vault_model.dart';

abstract interface class VaultRegistryLocalDataSource {
  Future<List<Vault>> getAll();
  Future<Vault?> getById(String id);
  Future<Vault?> getDefault();

  Future<void> register(Vault vault);
  Future<void> update(Vault vault);
  Future<void> forget(String id);
  Future<void> setDefault(String id);

  Future<void> resetDefault(String id);
}

class VaultRegistryLocalDataSourceImpl implements VaultRegistryLocalDataSource {
  final AppDatabase database;

  VaultRegistryLocalDataSourceImpl(this.database);

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
  Future<Vault?> getDefault() async {
    final row = await (database.select(
      database.vaultTable,
    )..where((t) => t.isDefault.equals(true))).getSingleOrNull();

    print('CALLED get default: $row');
    if (row == null) return null;

    return AppVaultModel(
      id: row.id,
      name: row.name,
      path: row.path,
      version: row.version,
      createdAt: row.createdAt,
      lastOpenedAt: row.lastOpenedAt,
    ).toEntity();
  }

  @override
  Future<void> register(Vault vault) async {
    await database
        .into(database.vaultTable)
        .insertOnConflictUpdate(
          VaultTableCompanion.insert(
            name: vault.name,
            path: vault.path,
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
        name: Value(vault.name),
        path: Value(vault.path),
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

  @override
  Future<void> setDefault(String id) async {
    await database.transaction(() async {
      await database
          .update(database.vaultTable)
          .write(const VaultTableCompanion(isDefault: Value(false)));

      await (database.update(database.vaultTable)
            ..where((t) => t.id.equals(id)))
          .write(const VaultTableCompanion(isDefault: Value(true)));
    });
  }

  @override
  Future<void> resetDefault(String id) async {
    // For now resetting all.
    await database.transaction(() async {
      await database
          .update(database.vaultTable)
          .write(const VaultTableCompanion(isDefault: Value(false)));
    });
  }
}
