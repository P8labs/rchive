import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';

import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/mixins/repository_mixin.dart';

import 'package:rchive/features/vault/data/datasources/vault_filesystem_datasource.dart';
import 'package:rchive/features/vault/data/datasources/vault_registry_local_datasource.dart';

import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class VaultRepositoryImpl with RepositoryMixin implements VaultRepository {
  final VaultFilesystemDataSource _filesystem;
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
      final vault = await _filesystem.create(
        name: name,
        parentPath: parentPath,
      );

      await _registry.register(vault);
      await _registry.setDefault(vault.id);
      return vault;
    });
  }

  @override
  Future<Either<Failure, Vault>> openVault({required String path}) async {
    return guard(() async {
      final vault = await _filesystem.open(path: path);

      final existing = await _registry.getById(vault.id);

      if (existing == null) {
        await _registry.register(vault);
      }

      await _registry.setDefault(vault.id);

      return vault;
    });
  }

  @override
  Future<Either<Failure, List<Vault>>> getVaults() async {
    return guard(() async => await _registry.getAll());
  }

  @override
  Future<Either<Failure, Vault?>> getDefaultVault() async {
    return guard(() async => await _registry.getDefault());
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
      await _filesystem.delete(path: vault.path);
      await _registry.forget(vaultId);

      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> setDefaultVault({
    required String vaultId,
  }) async {
    return guard(() async {
      await _registry.setDefault(vaultId);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> closeDefaultVault({required String vaultId}) {
    return guard(() async {
      await _registry.resetDefault(vaultId);
      return unit;
    });
  }
}
