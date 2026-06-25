import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/setup/domain/repository/onboard_repository.dart';

class OnboardExistingVault implements UseCase<Vault, ExistingVaultParams> {
  final OnboardRepository onboardRepository;
  const OnboardExistingVault(this.onboardRepository);

  @override
  Future<Either<Failure, Vault>> call(ExistingVaultParams params) async {
    return await onboardRepository.onboardExistingVault(path: params.path);
  }
}

class ExistingVaultParams {
  final String path;

  ExistingVaultParams({required this.path});
}
