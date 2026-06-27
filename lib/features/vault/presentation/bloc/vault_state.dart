part of 'vault_bloc.dart';

@immutable
class VaultState {
  final bool loading;
  final List<Vault> vaults;
  final String? error;

  const VaultState({this.loading = false, this.vaults = const [], this.error});

  VaultState copyWith({
    bool? loading,
    List<Vault>? vaults,
    String? error,
    bool clearError = false,
  }) {
    return VaultState(
      loading: loading ?? this.loading,
      vaults: vaults ?? this.vaults,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
