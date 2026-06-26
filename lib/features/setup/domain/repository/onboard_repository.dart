import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/failure.dart';

abstract interface class OnboardRepository {
  Future<Either<Failure, Vault>> onboardNewVault({
    required String name,
    required String path,
  });
  Future<Either<Failure, Vault>> onboardExistingVault({required String path});
  Future<Either<Failure, Vault>> currentVault();
}
