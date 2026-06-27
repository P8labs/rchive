import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class OpenVault implements UseCase<Vault, OpenVaultParams> {
  final VaultRepository repository;
  const OpenVault(this.repository);

  @override
  Future<Either<Failure, Vault>> call(OpenVaultParams params) async {
    return await repository.openVault(path: params.path);
  }
}

class OpenVaultParams {
  final String path;
  const OpenVaultParams({required this.path});
}
