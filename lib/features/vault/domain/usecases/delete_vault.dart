import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class DeleteVault implements UseCase<Unit, DeleteVaultParams> {
  final VaultRepository repository;
  const DeleteVault(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteVaultParams params) async {
    return await repository.deleteVault(vaultId: params.vaultId);
  }
}

class DeleteVaultParams {
  final String vaultId;
  const DeleteVaultParams({required this.vaultId});
}
