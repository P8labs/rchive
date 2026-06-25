import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> loginWithGoogle();
}
