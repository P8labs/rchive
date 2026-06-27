import 'package:drift/drift.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/app_database.dart';

class AppVaultModel extends Vault {
  const AppVaultModel({
    required super.id,
    required super.name,
    required super.path,
    required super.version,
    required super.createdAt,
    super.lastOpenedAt,
  });

  factory AppVaultModel.fromEntity(Vault vault) {
    return AppVaultModel(
      id: vault.id,
      name: vault.name,
      path: vault.path,
      version: vault.version,
      createdAt: vault.createdAt,
      lastOpenedAt: vault.lastOpenedAt,
    );
  }

  factory AppVaultModel.fromDrift(VaultTableData row) {
    return AppVaultModel(
      id: row.id,
      name: row.name,
      path: row.path,
      version: row.version,
      createdAt: row.createdAt,
      lastOpenedAt: row.lastOpenedAt,
    );
  }

  VaultTableCompanion toCompanion() {
    return VaultTableCompanion(
      id: Value(id),
      name: Value(name),
      path: Value(path),
      version: Value(version),
      createdAt: Value(createdAt),
      lastOpenedAt: Value(lastOpenedAt),
    );
  }

  Vault toEntity() {
    return Vault(
      id: id,
      name: name,
      path: path,
      version: version,
      createdAt: createdAt,
      lastOpenedAt: lastOpenedAt,
    );
  }
}
