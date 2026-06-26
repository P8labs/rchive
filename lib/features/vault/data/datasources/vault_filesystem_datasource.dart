import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:uuid/uuid.dart';

import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/features/vault/constants/vault_constants.dart';
import 'package:rchive/features/vault/data/models/vault_metadata_model.dart';

abstract interface class VaultFilesystemDataSource {
  Future<Vault> create({required String name, required String parentPath});
  Future<Vault> open({required String path});
  Future<void> delete({required String path});
  Future<bool> exists({required String path});
}

class VaultFilesystemDataSourceImpl implements VaultFilesystemDataSource {
  static const _uuid = Uuid();

  @override
  Future<VaultMetadataModel> create({
    required String name,
    required String parentPath,
  }) async {
    final parentDir = Directory(parentPath);

    if (!await parentDir.exists()) {
      throw LocalException('Selected folder does not exist.');
    }

    final vaultPath = p.join(parentPath, name);
    final vaultDir = Directory(vaultPath);

    if (await vaultDir.exists()) {
      throw LocalException('A vault with this name already exists.');
    }

    await vaultDir.create(recursive: true);

    await Directory(p.join(vaultPath, VaultConstants.notesDirectory)).create();

    await Directory(
      p.join(vaultPath, VaultConstants.attachmentsDirectory),
    ).create();

    await Directory(p.join(vaultPath, VaultConstants.trashDirectory)).create();

    final metadata = VaultMetadataModel(
      id: _uuid.v4(),
      name: name,
      path: vaultPath,
      version: VaultConstants.currentVersion,
      createdAt: DateTime.now().toUtc(),
    );

    await metadata.save();

    return metadata;
  }

  @override
  Future<VaultMetadataModel> open({required String path}) async {
    final vaultDir = Directory(path);

    if (!await vaultDir.exists()) {
      throw LocalException('Vault not found.');
    }

    final metadata = await VaultMetadataModel.load(path);

    await validate(path);

    return metadata;
  }

  @override
  Future<void> delete({required String path}) async {
    final dir = Directory(path);

    if (!await dir.exists()) {
      throw LocalException('Vault not found.');
    }

    await dir.delete(recursive: true);
  }

  @override
  Future<bool> exists({required String path}) {
    return Directory(path).exists();
  }

  Future<void> validate(String path) async {
    final metadata = File(p.join(path, VaultConstants.metadataFile));

    final notes = Directory(p.join(path, VaultConstants.notesDirectory));

    final attachments = Directory(
      p.join(path, VaultConstants.attachmentsDirectory),
    );

    final trash = Directory(p.join(path, VaultConstants.trashDirectory));

    if (!await metadata.exists() ||
        !await notes.exists() ||
        !await attachments.exists() ||
        !await trash.exists()) {
      throw LocalException('Invalid vault.');
    }
  }
}
