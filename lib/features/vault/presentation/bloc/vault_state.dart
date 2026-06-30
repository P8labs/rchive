part of 'vault_bloc.dart';

@immutable
class VaultState {
  const VaultState();
}

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
