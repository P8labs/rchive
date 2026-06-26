import 'package:fpdart/fpdart.dart';

extension EitherAsync<L, R> on Either<L, R> {
  Future<void> when({
    required Future<void> Function(L) left,
    required Future<void> Function(R) right,
  }) async {
    if (isLeft()) {
      await left(getLeft().toNullable() as L);
    } else {
      await right(getRight().toNullable() as R);
    }
  }
}
