import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class ForgetVault implements UseCase<Unit, ForgetVaultParams> {
  final VaultRepository repository;
  const ForgetVault(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ForgetVaultParams params) async {
    return await repository.forgetVault(vaultId: params.vaultId);
  }
}

class ForgetVaultParams {
  final String vaultId;
  const ForgetVaultParams({required this.vaultId});
}
