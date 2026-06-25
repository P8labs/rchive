import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/auth/domain/usecases/authenticate_user.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticateUser _authenticateUser;

  AuthBloc({required this._authenticateUser}) : super(AuthInitial()) {
    on<AuthAuthenticate>((event, emit) async {
      final res = await _authenticateUser(NoParams());

      res.fold(
        (f) => emit(AuthFailure(f.message)),
        (s) => emit(AuthFailure(s)),
      );
    });
  }
}
