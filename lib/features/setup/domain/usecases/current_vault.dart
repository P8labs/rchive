import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/setup/domain/repository/onboard_repository.dart';

class CurrentVault implements UseCase<Vault, NoParams> {
  final OnboardRepository onboardRepository;
  const CurrentVault(this.onboardRepository);

  @override
  Future<Either<Failure, Vault>> call(NoParams params) async {
    return await onboardRepository.currentVault();
  }
}
