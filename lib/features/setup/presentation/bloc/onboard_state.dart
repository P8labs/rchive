part of 'onboard_bloc.dart';

@immutable
sealed class OnboardState {
  const OnboardState();
}

final class OnboardInitial extends OnboardState {}

final class OnboardLoading extends OnboardState {}

final class OnboardSuccess extends OnboardState {
  final Vault vault;

  const OnboardSuccess(this.vault);
}

final class OnboardFailure extends OnboardState {
  final String message;
  const OnboardFailure(this.message);
}
