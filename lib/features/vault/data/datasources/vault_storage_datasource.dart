import 'dart:convert';
import 'dart:typed_data';

import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/features/vault/constants/vault_constants.dart';
import 'package:rchive/features/vault/data/models/vault_metadata_model.dart';
import 'package:rchive/features/vault/data/storage/saf/saf_storage.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';
import 'package:uuid/uuid.dart';

abstract interface class VaultStorageDataSource {
  Future<Vault> create({required String name, required String treeUri});
  Future<Vault> open({required String treeUri});
  Future<void> delete({required String treeUri});
  Future<bool> exists({required String treeUri});
}

class VaultStorageDataSourceImpl implements VaultStorageDataSource {
  static const _uuid = Uuid();

  VaultStorage storage(String treeUri) {
    return SafStorage(treeUri: treeUri);
  }

  @override
  Future<Vault> create({required String name, required String treeUri}) async {
    final vaultStorage = storage(treeUri);
    if (await vaultStorage.exists(name)) {
      throw LocalException('A vault with this name already exists.');
    }

    await vaultStorage.createDirectory(name);
    await vaultStorage.createDirectory(
      '$name/${VaultConstants.notesDirectory}',
    );
    await vaultStorage.createDirectory(
      '$name/${VaultConstants.attachmentsDirectory}',
    );
    await vaultStorage.createDirectory(
      '$name/${VaultConstants.trashDirectory}',
    );

    final metadata = VaultMetadataModel(
      id: _uuid.v4(),
      name: name,
      location: name,
      storageType: VaultStorageType.saf,
      version: VaultConstants.currentVersion,
      createdAt: DateTime.now().toUtc(),
    );

    await vaultStorage.write(
      '$name/${VaultConstants.metadataFile}',
      Uint8List.fromList(
        utf8.encode(
          const JsonEncoder.withIndent('  ').convert(metadata.toJson()),
        ),
      ),
    );

    return metadata;
  }

  @override
  Future<Vault> open({required String treeUri}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String treeUri}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> exists({required String treeUri}) {
    throw UnimplementedError();
  }
}
