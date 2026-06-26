import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class SetDefaultVault implements UseCase<Unit, SetVaultParams> {
  final VaultRepository repository;
  const SetDefaultVault(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SetVaultParams params) async {
    return await repository.setDefaultVault(vaultId: params.vaultId);
  }
}

class SetVaultParams {
  final String vaultId;
  const SetVaultParams({required this.vaultId});
}
