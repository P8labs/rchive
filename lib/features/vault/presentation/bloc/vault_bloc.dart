import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/usecases/close_default_vault.dart';

import '../../domain/usecases/create_vault.dart';
import '../../domain/usecases/delete_vault.dart';
import '../../domain/usecases/forget_vault.dart';
// import '../../domain/usecases/get_default_vault.dart';
import '../../domain/usecases/get_vaults.dart';
import '../../domain/usecases/open_vault.dart';
import '../../domain/usecases/set_default_vault.dart';

part 'vault_event.dart';
part 'vault_state.dart';

class VaultBloc extends Bloc<VaultEvent, VaultState> {
  final GetVaults _getVaults;
  final CreateVault _createVault;
  final OpenVault _openVault;
  final ForgetVault _forgetVault;
  final DeleteVault _deleteVault;
  final SetDefaultVault _setDefaultVault;
  // final GetDefaultVault _getDefaultVault;
  final CloseDefaultVault _closeDefaultVault;

  VaultBloc({
    required this._getVaults,
    required this._createVault,
    required this._openVault,
    required this._forgetVault,
    required this._deleteVault,
    required this._setDefaultVault,
    // required this._getDefaultVault,
    required this._closeDefaultVault,
  }) : super(const VaultState()) {
    on<LoadVaultsEvent>(_onLoadVaults);
    on<CreateVaultEvent>(_onCreateVault);
    on<OpenVaultEvent>(_onOpenVault);
    on<ForgetVaultEvent>(_onForgetVault);
    on<DeleteVaultEvent>(_onDeleteVault);
    on<SetDefaultVaultEvent>(_onSetDefaultVault);
    on<CloseDefaultVaultEvent>(_onCloseDefaultVault);
    // on<GetDefaultVaultEvent>(_onGetDefaultVault); // will remove it
  }

  void _onLoadVaults(LoadVaultsEvent event, Emitter<VaultState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    final result = await _getVaults(NoParams());

    result.fold(
      (failure) {
        emit(state.copyWith(loading: false, error: failure.message));
      },
      (vaults) {
        emit(state.copyWith(loading: false, vaults: vaults, clearError: true));
      },
    );
  }

  void _onCreateVault(CreateVaultEvent event, Emitter<VaultState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    final result = await _createVault(
      CreateVaultParams(name: event.name, parentPath: event.parentPath),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(loading: false, error: failure.message));
      },
      (vault) {
        emit(state.copyWith(loading: false, clearError: true));
      },
    );
  }

  void _onOpenVault(OpenVaultEvent event, Emitter<VaultState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    final result = await _openVault(OpenVaultParams(path: event.path));

    result.fold(
      (failure) {
        emit(state.copyWith(loading: false, error: failure.message));
      },
      (vault) {
        emit(state.copyWith(loading: false, clearError: true));
      },
    );
  }

  void _onForgetVault(ForgetVaultEvent event, Emitter<VaultState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    final result = await _forgetVault(
      ForgetVaultParams(vaultId: event.vaultId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(loading: false, error: failure.message));
      },
      (_) {
        emit(state.copyWith(loading: false, clearError: true));
      },
    );
  }

  void _onDeleteVault(DeleteVaultEvent event, Emitter<VaultState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    final result = await _deleteVault(
      DeleteVaultParams(vaultId: event.vaultId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(loading: false, error: failure.message));
      },
      (_) {
        emit(state.copyWith(loading: false, clearError: true));
      },
    );
  }

  void _onSetDefaultVault(
    SetDefaultVaultEvent event,
    Emitter<VaultState> emit,
  ) async {
    emit(state.copyWith(loading: true, error: null));

    final result = await _setDefaultVault(
      SetVaultParams(vaultId: event.vaultId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(loading: false, error: failure.message));
      },
      (_) {
        emit(state.copyWith(loading: false, clearError: true));
      },
    );
  }

  void _onCloseDefaultVault(
    CloseDefaultVaultEvent event,
    Emitter<VaultState> emit,
  ) async {
    emit(state.copyWith(loading: true, error: null));

    final result = await _closeDefaultVault(
      CloseVaultParams(vaultId: event.vaultId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(loading: false, error: failure.message));
      },
      (_) {
        emit(state.copyWith(loading: false, clearError: true));
      },
    );
  }

  // void _onGetDefaultVault(
  //   GetDefaultVaultEvent event,
  //   Emitter<VaultState> emit,
  // ) async {
  //   emit(state.copyWith(loading: true, error: null));

  //   final result = await _getDefaultVault(NoParams());

  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(loading: false, error: failure.message));
  //     },
  //     (vault) {
  //       emit(state.copyWith(loading: false, clearError: true));
  //     },
  //   );
  // }
}
