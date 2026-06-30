part of 'vault_bloc.dart';

@immutable
sealed class VaultState {
  const VaultState();
}

final class VaultInitial extends VaultState {}

final class VaultLoading extends VaultState {}

final class VaultError extends VaultState {
  final String message;
  const VaultError(this.message);
}

final class VaultInvokeInit extends VaultState {}

final class LoadVaults extends VaultState {
  final List<Vault> vaults;

  const LoadVaults(this.vaults);
}
