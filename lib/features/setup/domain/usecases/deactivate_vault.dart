import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/vault/vault_manager.dart';
import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';

class DeactivateVault implements UseCase<Unit, NoParams> {
  final VaultManager vaultManager;

  const DeactivateVault(this.vaultManager);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    try {
      await vaultManager.deactivate();
      return right(unit);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
