import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';

import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/mixins/repository_mixin.dart';

import 'package:rchive/features/vault/data/datasources/vault_registry_database_datasource.dart';
import 'package:rchive/features/vault/data/datasources/vault_storage_datasource.dart';

import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class VaultRepositoryImpl with RepositoryMixin implements VaultRepository {
  final VaultStorageDataSource _filesystem;
  final VaultRegistryLocalDataSource _registry;

  const VaultRepositoryImpl({
    required this._filesystem,
    required this._registry,
  });

  @override
  Future<Either<Failure, Vault>> createVault({
    required String name,
    required String parentPath,
  }) async {
    return guard(() async {
      final vault = await _filesystem.create(name: name, treeUri: parentPath);
      await _registry.register(vault);
      return vault;
    });
  }

  @override
  Future<Either<Failure, Vault>> openVault({required String path}) async {
    return guard(() async {
      final split = splitTreeUri(path);
      final vault = await _filesystem.open(
        treeUri: split.treeUri,
        location: split.rootPath,
      );
      final existing = await _registry.getById(vault.id);

      if (existing == null) {
        await _registry.register(vault);
      }

      return vault;
    });
  }

  @override
  Future<Either<Failure, List<Vault>>> getVaults() async {
    return guard(() async => await _registry.getAll());
  }

  @override
  Future<Either<Failure, Unit>> forgetVault({required String vaultId}) async {
    return guard(() async {
      await _registry.forget(vaultId);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteVault({required String vaultId}) async {
    return guard(() async {
      final vault = await _registry.getById(vaultId);
      if (vault == null) {
        throw LocalException('Vault not found.');
      }
      await _filesystem.delete(
        treeUri: vault.treeUri,
        location: vault.location,
      );
      await _registry.forget(vaultId);

      return unit;
    });
  }
}

({String treeUri, String rootPath}) splitTreeUri(String treeUri) {
  final uri = Uri.parse(treeUri);

  final treeIndex = uri.pathSegments.indexOf('tree');
  if (treeIndex == -1 || treeIndex + 1 >= uri.pathSegments.length) {
    throw ArgumentError('Invalid SAF tree URI.');
  }

  final treeId = Uri.decodeComponent(uri.pathSegments[treeIndex + 1]);
  // primary:Download/Vs/Demo

  final slash = treeId.lastIndexOf('/');
  if (slash == -1) {
    return (treeUri: treeUri, rootPath: '');
  }

  final parentTreeId = treeId.substring(0, slash);
  final rootPath = treeId.substring(slash + 1);

  final rootTreeUri = uri.replace(
    pathSegments: [
      ...uri.pathSegments.take(treeIndex + 1),
      Uri.encodeComponent(parentTreeId),
    ],
  );

  return (treeUri: rootTreeUri.toString(), rootPath: rootPath);
}
