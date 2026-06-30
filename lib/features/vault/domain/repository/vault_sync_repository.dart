import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure.dart';

abstract interface class VaultSyncRepository {
  Future<Either<Failure, Unit>> sync();
  Future<Either<Failure, Unit>> syncFile({required String path});
}
