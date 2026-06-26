import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/features/setup/data/datasources/onboard_local_data_source.dart';
import 'package:rchive/features/setup/domain/repository/onboard_repository.dart';

class OnboardRepositoryImpl implements OnboardRepository {
  final OnboardLocalDataSource onboardLocalDataSource;

  OnboardRepositoryImpl(this.onboardLocalDataSource);

  @override
  Future<Either<Failure, Vault>> currentVault() async {
    return _getVault(() async => await onboardLocalDataSource.currentVault());
  }

  @override
  Future<Either<Failure, Vault>> onboardExistingVault({required String path}) {
    return _getVault(
      () async => await onboardLocalDataSource.openExistingVault(path: path),
    );
  }

  @override
  Future<Either<Failure, Vault>> onboardNewVault({
    required String name,
    required String path,
  }) {
    return _getVault(
      () async =>
          await onboardLocalDataSource.openNewVault(name: name, path: path),
    );
  }

  Future<Either<Failure, Vault>> _getVault(Future<Vault> Function() fn) async {
    try {
      final vault = await fn();
      return right(vault);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure("Unexpected Problem found. contact support"));
    }
  }
}
