import 'package:drift/drift.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/app_database.dart';

class AppVaultModel extends Vault {
  const AppVaultModel({
    required super.id,
    required super.name,
    required super.location,
    required super.storageType,
    required super.version,
    required super.createdAt,
    super.lastOpenedAt,
  });

  factory AppVaultModel.fromEntity(Vault vault) {
    return AppVaultModel(
      id: vault.id,
      name: vault.name,
      location: vault.location,
      storageType: vault.storageType,
      version: vault.version,
      createdAt: vault.createdAt,
      lastOpenedAt: vault.lastOpenedAt,
    );
  }

  factory AppVaultModel.fromDrift(VaultTableData row) {
    return AppVaultModel(
      id: row.id,
      name: row.name,
      location: row.location,
      storageType: VaultStorageType.values.byName(row.storageType),
      version: row.version,
      createdAt: row.createdAt,
      lastOpenedAt: row.lastOpenedAt,
    );
  }

  VaultTableCompanion toCompanion() {
    return VaultTableCompanion(
      id: Value(id),
      name: Value(name),
      location: Value(location),
      storageType: Value(storageType.name),
      version: Value(version),
      createdAt: Value(createdAt),
      lastOpenedAt: Value(lastOpenedAt),
    );
  }

  Vault toEntity() {
    return Vault(
      id: id,
      name: name,
      location: location,
      storageType: storageType,
      version: version,
      createdAt: createdAt,
      lastOpenedAt: lastOpenedAt,
    );
  }
}
