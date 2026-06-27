import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/failure.dart';

abstract interface class VaultRepository {
  Future<Either<Failure, List<Vault>>> getVaults();

  Future<Either<Failure, Vault>> createVault({
    required String name,
    required String parentPath,
  });

  Future<Either<Failure, Vault>> openVault({required String path});
  Future<Either<Failure, Unit>> forgetVault({required String vaultId});
  Future<Either<Failure, Unit>> deleteVault({required String vaultId});
}
