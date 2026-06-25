import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/cubits/cubit/app_user_cubit.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/features/setup/domain/usecases/onboard_existing_vault.dart';
import 'package:rchive/features/setup/domain/usecases/onboard_new_vault.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final AppUserCubit _appUserCubit;
  final OnboardNewVault _onboardNewVault;
  final OnboardExistingVault _onboardExistingVault;

  OnboardBloc({
    required this._appUserCubit,
    required this._onboardNewVault,
    required this._onboardExistingVault,
  }) : super(OnboardInitial()) {
    on<OnboardEvent>((_, emit) => OnboardLoading());
    on<OnboardOpenNewVault>(_onOpenNewVault);
    on<OnboardOpenExistingVault>(_onOpenExistingVault);
  }

  void _onOpenNewVault(
    OnboardOpenNewVault event,
    Emitter<OnboardState> emit,
  ) async {
    final res = await _onboardNewVault.call(
      NewVaultParams(name: event.vaultName, path: event.vaultPath),
    );

    res.fold(
      (f) => emit(OnboardFailure(f.message)),
      (s) => _emitSuccess(s, emit),
    );
  }

  void _onOpenExistingVault(
    OnboardOpenExistingVault event,
    Emitter<OnboardState> emit,
  ) async {
    final res = await _onboardExistingVault.call(
      ExistingVaultParams(path: event.vaultPath),
    );

    res.fold(
      (f) => emit(OnboardFailure(f.message)),
      (s) => _emitSuccess(s, emit),
    );
  }

  void _emitSuccess(Vault vault, Emitter<OnboardState> emit) {
    _appUserCubit.initVault(vault);
    emit(OnboardSuccess(vault));
  }
}
