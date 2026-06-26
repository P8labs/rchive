import 'package:rchive/core/comman/database/database.dart';
import 'package:rchive/core/comman/database/database_service.dart';
import 'package:rchive/core/comman/entities/vault.dart';

abstract interface class VaultManager {
  bool get isOpen;
  Vault? get currentVault;
  AppDatabase get database;

  Future<void> activate(Vault vault);
  Future<void> deactivate();
  Future<void> switchVault(Vault vault);
}

class VaultManagerImpl implements VaultManager {
  final DatabaseService _databaseService;

  Vault? _currentVault;
  VaultManagerImpl(this._databaseService);

  @override
  bool get isOpen => _databaseService.isOpen;

  @override
  Vault? get currentVault => _currentVault;

  @override
  AppDatabase get database => _databaseService.database;

  @override
  Future<void> activate(Vault vault) async {
    if (_currentVault?.path == vault.path && _databaseService.isOpen) {
      return;
    }
    await _databaseService.open(vaultPath: vault.path);
    _currentVault = vault;
  }

  @override
  Future<void> deactivate() async {
    await _databaseService.close();
    _currentVault = null;
  }

  @override
  Future<void> switchVault(Vault vault) async {
    await deactivate();
    await activate(vault);
  }
}
