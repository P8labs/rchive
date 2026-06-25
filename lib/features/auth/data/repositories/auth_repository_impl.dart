import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/core/error/failure.dart';
import 'package:rchive/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rchive/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithGoogle() async {
    try {
      final token = await remoteDataSource.loginWithGoogle();
      return right(token);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      print(e);
      return left(Failure("Unexpected problem found."));
    }
  }
}
