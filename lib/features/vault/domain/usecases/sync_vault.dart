import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/repository/vault_sync_repository.dart';

class SyncVaultUseCase implements UseCase<Unit, NoParams> {
  final VaultSyncRepository repository;

  const SyncVaultUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.sync();
  }
}
