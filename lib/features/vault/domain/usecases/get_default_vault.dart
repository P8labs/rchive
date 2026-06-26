import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class GetDefaultVault implements UseCase<Vault?, NoParams> {
  final VaultRepository repository;
  const GetDefaultVault(this.repository);

  @override
  Future<Either<Failure, Vault?>> call(NoParams params) async {
    return await repository.getDefaultVault();
  }
}
