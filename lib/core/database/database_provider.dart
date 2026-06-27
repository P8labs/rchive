import 'package:rchive/core/comman/entities/app_config.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/app_database.dart';
import 'package:rchive/core/database/vault_database.dart';
import 'package:rchive/features/vault/data/models/app_vault_model.dart';

abstract interface class DatabaseProvider {
  AppDatabase get appDatabase;
  VaultDatabase? get vaultDatabase;
  Vault? get currentVault;

  AppConfig get appConfig;

  Future<void> openVault(Vault vault);
  Future<void> closeVault();

  Future<Vault?> getDefaultVault();
  Future<void> setDefaultVaultId(String id);
  Future<void> removeDefaultVaultId();

  Future<AppConfig> syncAppConfig(AppConfig config);
}

class DatabaseProviderImpl implements DatabaseProvider {
  @override
  final AppDatabase appDatabase;

  AppConfig _appConfig = AppConfig.initial();
  VaultDatabase? _vaultDatabase;
  Vault? _currentVault;

  DatabaseProviderImpl({required this.appDatabase});

  @override
  VaultDatabase? get vaultDatabase => _vaultDatabase;

  @override
  AppConfig get appConfig => _appConfig;

  @override
  Vault? get currentVault => _currentVault;

  @override
  Future<void> openVault(Vault vault) async {
    if (_vaultDatabase != null) {
      await _vaultDatabase!.close();
      _currentVault = vault;
    }

    _vaultDatabase = VaultDatabase(vaultPath: vault.location);
  }

  @override
  Future<void> closeVault() async {
    await _vaultDatabase?.close();
    _vaultDatabase = null;
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
  Future<AppConfig> syncAppConfig(AppConfig config) async {
    await appDatabase
        .into(appDatabase.appConfigTable)
        .insertOnConflictUpdate(config.toCompanion());

    final row = await (appDatabase.select(
      appDatabase.appConfigTable,
    )..where((t) => t.id.equals(AppConfig.defaultConfigId))).getSingle();

    _appConfig = AppConfig.fromDrift(row);

    return _appConfig;
  }
}
