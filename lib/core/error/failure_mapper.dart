import 'package:fpdart/fpdart.dart';

import 'exceptions.dart';
import 'failure.dart';

class FailureMapper {
  static Either<Failure, T> map<T>(Object error) {
    if (error is LocalException) {
      return left(Failure(error.message));
    }
    return left(Failure('Unexpected error: ${error.toString()}'));
  }
}
