import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/setup/domain/repository/onboard_repository.dart';

class OnboardNewVault implements UseCase<Vault, NewVaultParams> {
  final OnboardRepository onboardRepository;
  const OnboardNewVault(this.onboardRepository);

  @override
  Future<Either<Failure, Vault>> call(NewVaultParams params) async {
    return await onboardRepository.onboardNewVault(
      name: params.name,
      path: params.path,
    );
  }
}

class NewVaultParams {
  final String name;
  final String path;

  NewVaultParams({required this.name, required this.path});
}
