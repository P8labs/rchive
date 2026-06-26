import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/cubits/cubit/app_user_cubit.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/setup/domain/usecases/activate_vault.dart';
import 'package:rchive/features/setup/domain/usecases/current_vault.dart';
import 'package:rchive/features/setup/domain/usecases/onboard_existing_vault.dart';
import 'package:rchive/features/setup/domain/usecases/onboard_new_vault.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final AppUserCubit _appUserCubit;
  final OnboardNewVault _onboardNewVault;
  final OnboardExistingVault _onboardExistingVault;
  final CurrentVault _currentVault;
  final ActivateVault _activateVault;

  OnboardBloc({
    required this._appUserCubit,
    required this._onboardNewVault,
    required this._onboardExistingVault,
    required this._currentVault,
    required this._activateVault,
  }) : super(OnboardInitial()) {
    on<OnboardEvent>((_, emit) => OnboardLoading());
    on<OnboardOpenNewVault>(_onOpenNewVault);
    on<OnboardOpenExistingVault>(_onOpenExistingVault);
    on<IsOnboarded>(_isOnboardedVault);
  }

  Future<void> _isOnboardedVault(
    IsOnboarded event,
    Emitter<OnboardState> emit,
  ) async {
    emit(OnboardLoading());
    final res = await _currentVault.call(NoParams());

    await res.fold(
      (failure) async {
        if (!emit.isDone) {
          emit(OnboardFailure(failure.message));
        }
      },
      (vault) async {
        await _emitSuccess(vault, emit);
      },
    );
  }

  Future<void> _onOpenNewVault(
    OnboardOpenNewVault event,
    Emitter<OnboardState> emit,
  ) async {
    emit(OnboardLoading());

    final res = await _onboardNewVault.call(
      NewVaultParams(name: event.vaultName, path: event.vaultPath),
    );

    await res.fold(
      (failure) async {
        if (!emit.isDone) {
          emit(OnboardFailure(failure.message));
        }
      },
      (vault) async {
        await _emitSuccess(vault, emit);
      },
    );
  }

  Future<void> _onOpenExistingVault(
    OnboardOpenExistingVault event,
    Emitter<OnboardState> emit,
  ) async {
    emit(OnboardLoading());

    final res = await _onboardExistingVault.call(
      ExistingVaultParams(path: event.vaultPath),
    );

    await res.fold(
      (failure) async {
        if (!emit.isDone) {
          emit(OnboardFailure(failure.message));
        }
      },
      (vault) async {
        await _emitSuccess(vault, emit);
      },
    );
  }

  Future<void> _emitSuccess(Vault vault, Emitter<OnboardState> emit) async {
    final result = await _activateVault(ActivateVaultParams(vault: vault));

    if (emit.isDone) return;

    result.match(
      (failure) {
        emit(OnboardFailure(failure.message));
      },
      (_) {
        _appUserCubit.initVault(vault);
        emit(OnboardSuccess(vault));
      },
    );
  }
}
