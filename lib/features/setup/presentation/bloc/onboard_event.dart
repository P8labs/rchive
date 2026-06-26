part of 'onboard_bloc.dart';

@immutable
sealed class OnboardEvent {}

final class OnboardOpenNewVault extends OnboardEvent {
  final String vaultName;
  final String vaultPath;

  OnboardOpenNewVault({required this.vaultName, required this.vaultPath});
}

final class OnboardOpenExistingVault extends OnboardEvent {
  final String vaultPath;

  OnboardOpenExistingVault({required this.vaultPath});
}

final class IsOnboarded extends OnboardEvent {}

final class DeactivateVault extends OnboardEvent {}
