import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class CreateVault implements UseCase<Vault, CreateVaultParams> {
  final VaultRepository repository;
  const CreateVault(this.repository);

  @override
  Future<Either<Failure, Vault>> call(CreateVaultParams params) async {
    return await repository.createVault(
      name: params.name,
      parentPath: params.parentPath,
    );
  }
}

class CreateVaultParams {
  final String name;
  final String parentPath;
  const CreateVaultParams({required this.name, required this.parentPath});
}
