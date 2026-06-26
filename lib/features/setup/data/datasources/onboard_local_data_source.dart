import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:rchive/core/comman/prefs/shared_config.dart';
import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/features/setup/data/models/vault_model.dart';

abstract interface class OnboardLocalDataSource {
  Future<VaultModel> openNewVault({required String name, required String path});
  Future<VaultModel> openExistingVault({required String path});
  Future<VaultModel> currentVault();
}

class OnboardLocalDataSourceImpl implements OnboardLocalDataSource {
  final SharedConfig prefs;

  OnboardLocalDataSourceImpl(this.prefs);

  @override
  Future<VaultModel> openExistingVault({required String path}) async {
    final vaultDir = Directory(path);

    if (!await vaultDir.exists()) {
      throw LocalException('Vault does not exist.');
    }

    if (!await Directory(p.join(path, 'notes')).exists() ||
        !await Directory(p.join(path, 'attachments')).exists() ||
        !await Directory(p.join(path, '.trash')).exists()) {
      throw LocalException('Invalid vault.');
    }

    final model = await VaultModel.load(path);
    await prefs.setDefaultVaultPath(path);
    return model;
  }

  @override
  Future<VaultModel> openNewVault({
    required String name,
    required String path,
  }) async {
    final parentDir = Directory(path);

    if (!await parentDir.exists()) {
      throw LocalException('Selected folder does not exist.');
    }

    final vaultPath = p.join(path, name);
    final vaultDir = Directory(vaultPath);

    if (await vaultDir.exists()) {
      throw LocalException('A vault with this name already exists.');
    }

    await vaultDir.create(recursive: true);

    await Directory(p.join(vaultPath, 'notes')).create(recursive: true);
    await Directory(p.join(vaultPath, 'attachments')).create(recursive: true);
    await Directory(p.join(vaultPath, '.trash')).create(recursive: true);

    final model = VaultModel.create(name: name, path: vaultPath);

    await model.save();

    await prefs.setDefaultVaultPath(vaultPath);

    return model;
  }

  @override
  Future<VaultModel> currentVault() async {
    final path = await prefs.defaultVaultPath();
    if (path == null || path.isEmpty) {
      throw LocalException('No vault selected.');
    }

    return openExistingVault(path: path);
  }
}
