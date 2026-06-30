import 'package:rchive/core/comman/entities/app_config.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/app_database.dart';
import 'package:rchive/features/vault/data/models/app_vault_model.dart';
import 'package:rchive/features/vault/data/storage/saf/saf_storage.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';

abstract interface class DatabaseProvider {
  AppDatabase get appDatabase;

  VaultStorage? get currentStorage;
  Vault? get currentVault;

  AppConfig get appConfig;

  Future<void> openVault(Vault vault);
  Future<void> closeVault();

  Future<Vault?> getDefaultVault();
  Future<void> setDefaultVaultId(String id);
  Future<void> removeDefaultVaultId();

  Future<AppConfig> syncAppConfig(AppConfig config, {bool init = false});
}

class DatabaseProviderImpl implements DatabaseProvider {
  @override
  final AppDatabase appDatabase;

  AppConfig _appConfig = AppConfig.initial();
  Vault? _currentVault;
  VaultStorage? _currentStorage;

  DatabaseProviderImpl({required this.appDatabase});

  @override
  VaultStorage? get currentStorage => _currentStorage;

  @override
  AppConfig get appConfig => _appConfig;

  @override
  Vault? get currentVault => _currentVault;

  @override
  Future<void> openVault(Vault vault) async {
    _currentVault = vault;

    _currentStorage = switch (vault.storageType) {
      VaultStorageType.saf => SafStorage(treeUri: vault.location),
      // TODO: Handle this case.
      VaultStorageType.filesystem => throw UnimplementedError(),
    };
  }

  @override
  Future<void> closeVault() async {
    _currentStorage = null;
    _currentVault = null;
  }

  @override
  Future<Vault?> getDefaultVault() async {
    final vaultId = _appConfig.defaultVaultId;
    if (vaultId == null) return null;

    final vault = await (appDatabase.select(
      appDatabase.vaultTable,
    )..where((t) => t.id.equals(vaultId))).getSingleOrNull();

    if (vault == null) {
      return null;
    }

    return AppVaultModel(
      id: vault.id,
      name: vault.name,
      location: vault.location,
      storageType: VaultStorageType.saf,
      version: vault.version,
      createdAt: vault.createdAt,
      lastOpenedAt: vault.lastOpenedAt,
    ).toEntity();
  }

  @override
  Future<void> removeDefaultVaultId() async {
    final c = _appConfig.copyWith(defaultVaultId: "");
    await syncAppConfig(c);
  }

  @override
  Future<void> setDefaultVaultId(String id) async {
    final c = _appConfig.copyWith(defaultVaultId: id);
    await syncAppConfig(c);
  }

  @override
  Future<AppConfig> syncAppConfig(AppConfig config, {bool init = false}) async {
    if (init) {
      final exists = await (appDatabase.select(
        appDatabase.appConfigTable,
      )..where((t) => t.id.equals(config.id))).getSingleOrNull();

      if (exists == null) {
        await appDatabase
            .into(appDatabase.appConfigTable)
            .insert(config.toCompanion());
      }
    } else {
      await appDatabase
          .into(appDatabase.appConfigTable)
          .insertOnConflictUpdate(config.toCompanion());
    }

    final row = await (appDatabase.select(
      appDatabase.appConfigTable,
    )..where((t) => t.id.equals(config.id))).getSingle();

    _appConfig = AppConfig.fromDrift(row);

    return _appConfig;
  }
}
