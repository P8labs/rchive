import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/app_database.dart';
import 'package:rchive/core/database/vault_database.dart';

abstract interface class DatabaseProvider {
  AppDatabase get appDatabase;

  VaultDatabase? get vaultDatabase;
  Vault? get currentVault;
  bool get isVaultOpen;

  Future<void> openVault(Vault vault);

  Future<void> closeVault();
}

class DatabaseProviderImpl implements DatabaseProvider {
  @override
  final AppDatabase appDatabase;

  VaultDatabase? _vaultDatabase;
  Vault? _currentVault;

  DatabaseProviderImpl({required this.appDatabase});

  @override
  VaultDatabase? get vaultDatabase => _vaultDatabase;

  @override
  bool get isVaultOpen => _vaultDatabase != null;

  @override
  Vault? get currentVault => _currentVault;

  @override
  Future<void> openVault(Vault vault) async {
    if (_vaultDatabase != null) {
      await _vaultDatabase!.close();
      _currentVault = vault;
    }

    _vaultDatabase = VaultDatabase(vaultPath: vault.path);
  }

  @override
  Future<void> closeVault() async {
    await _vaultDatabase?.close();
    _vaultDatabase = null;
    _currentVault = null;
  }
}
