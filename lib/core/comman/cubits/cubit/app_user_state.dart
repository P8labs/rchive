part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserOnboarded extends AppUserState {
  final Vault vault;
  AppUserOnboarded(this.vault);
}
