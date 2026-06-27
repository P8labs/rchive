import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class CloseDefaultVault implements UseCase<Unit, CloseVaultParams> {
  final VaultRepository repository;
  const CloseDefaultVault(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CloseVaultParams params) async {
    return await repository.closeDefaultVault(vaultId: params.vaultId);
  }
}

class CloseVaultParams {
  final String vaultId;
  const CloseVaultParams({required this.vaultId});
}
