part of 'vault_bloc.dart';

class VaultState {
  final bool loading;

  final List<Vault> vaults;

  final String? error;

  const VaultState({this.loading = false, this.vaults = const [], this.error});

  VaultState copyWith({bool? loading, List<Vault>? vaults, String? error}) {
    return VaultState(
      loading: loading ?? this.loading,
      vaults: vaults ?? this.vaults,
      error: error,
    );
  }
}
