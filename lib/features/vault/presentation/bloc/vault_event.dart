part of 'vault_bloc.dart';

@immutable
sealed class VaultEvent {
  const VaultEvent();
}

final class LoadVaultsEvent extends VaultEvent {}

final class CreateVaultEvent extends VaultEvent {
  final String name;
  final String parentPath;

  const CreateVaultEvent({required this.name, required this.parentPath});
}

final class OpenVaultEvent extends VaultEvent {
  final String path;

  const OpenVaultEvent(this.path);
}

final class ForgetVaultEvent extends VaultEvent {
  final String vaultId;

  const ForgetVaultEvent(this.vaultId);
}

final class DeleteVaultEvent extends VaultEvent {
  final String vaultId;

  const DeleteVaultEvent(this.vaultId);
}

final class SetDefaultVaultEvent extends VaultEvent {
  final String vaultId;

  const SetDefaultVaultEvent(this.vaultId);
}
