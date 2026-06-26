import 'package:fpdart/fpdart.dart';
import 'package:rchive/core/error/failure_mapper.dart';

import '../error/failure.dart';

mixin RepositoryMixin {
  Future<Either<Failure, T>> guard<T>(Future<T> Function() action) async {
    try {
      return right(await action());
    } catch (e) {
      return FailureMapper.map(e);
    }
  }
}
