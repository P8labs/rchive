part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthAuthenticate extends AuthEvent {}
