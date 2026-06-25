import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/auth/domain/repository/auth_repository.dart';

class AuthenticateUser implements UseCase<String, NoParams> {
  final AuthRepository authRepository;

  const AuthenticateUser(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.loginWithGoogle();
  }
}
