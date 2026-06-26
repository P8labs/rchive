import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/repository/vault_repository.dart';

class GetVaults implements UseCase<List<Vault>, NoParams> {
  final VaultRepository repository;
  const GetVaults(this.repository);

  @override
  Future<Either<Failure, List<Vault>>> call(NoParams params) async {
    return await repository.getVaults();
  }
}
