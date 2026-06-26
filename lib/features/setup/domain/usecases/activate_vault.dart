import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/comman/vault/vault_manager.dart';
import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';

class ActivateVault implements UseCase<Unit, ActivateVaultParams> {
  final VaultManager vaultManager;

  const ActivateVault(this.vaultManager);

  @override
  Future<Either<Failure, Unit>> call(ActivateVaultParams params) async {
    try {
      await vaultManager.activate(params.vault);
      return right(unit);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

class ActivateVaultParams {
  final Vault vault;
  const ActivateVaultParams({required this.vault});
}
