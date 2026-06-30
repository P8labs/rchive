import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/features/vault/constants/vault_constants.dart';
import 'package:rchive/features/vault/data/models/vault_metadata_model.dart';
import 'package:rchive/features/vault/data/storage/saf/saf_storage.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';
import 'package:uuid/uuid.dart';

abstract interface class VaultStorageDataSource {
  Future<Vault> create({required String name, required String treeUri});
  Future<Vault> open({required String treeUri, required String location});
  Future<void> delete({required String treeUri, required String location});
  Future<bool> exists({required String treeUri, required String location});
}

class VaultStorageDataSourceImpl implements VaultStorageDataSource {
  static const _uuid = Uuid();

  VaultStorage storage(String treeUri, [String root = ""]) {
    return SafStorage(treeUri: treeUri, root: root);
  }

  @override
  Future<Vault> create({required String name, required String treeUri}) async {
    final rootStorage = storage(treeUri);

    if (await rootStorage.exists(name)) {
      throw LocalException('A vault with this name already exists.');
    }

    await rootStorage.createDirectory(name);

    final vaultStorage = storage(treeUri, name);

    await vaultStorage.createDirectory(VaultConstants.notesDirectory);
    await vaultStorage.createDirectory(VaultConstants.attachmentsDirectory);
    await vaultStorage.createDirectory(VaultConstants.trashDirectory);

    final metadata = VaultMetadataModel(
      id: _uuid.v4(),
      name: name,
      treeUri: vaultStorage.treeUri,
      location: name,
      storageType: VaultStorageType.saf,
      version: VaultConstants.currentVersion,
      createdAt: DateTime.now().toUtc(),
    );

    await metadata.save(
      storageType: VaultStorageType.saf,
      vaultStorage: vaultStorage,
    );

    return metadata;
  }

  @override
  Future<Vault> open({
    required String treeUri,
    required String location,
  }) async {
    final vaultStorage = storage(treeUri, location);

    await validate(vaultStorage);

    final metadata = await VaultMetadataModel.load(
      vaultStorage: vaultStorage,
      storageType: VaultStorageType.saf,
    );

    return metadata;
  }

  @override
  Future<void> delete({
    required String treeUri,
    required String location,
  }) async {
    final vaultStorage = storage(treeUri, location);
    if (!await vaultStorage.exists()) {
      throw LocalException('Vault not found.');
    }

    await vaultStorage.delete("", recursive: true);
  }

  @override
  Future<bool> exists({
    required String treeUri,
    required String location,
  }) async {
    final vaultStorage = storage(treeUri, location);
    return !await vaultStorage.exists();
  }

  Future<void> validate(VaultStorage vaultStorage) async {
    final metadata = await vaultStorage.exists(VaultConstants.metadataFile);
    final notes = await vaultStorage.exists(VaultConstants.notesDirectory);

    final attachments = await vaultStorage.exists(
      VaultConstants.attachmentsDirectory,
    );

    if (!metadata || !notes || !attachments) {
      throw LocalException('Invalid vault.');
    }
  }
}
