import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/database_provider.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/usecases/get_default_vault.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final GetDefaultVault _getDefaultVault;
  final DatabaseProvider _databaseProvider;

  AppCubit(this._getDefaultVault, this._databaseProvider)
    : super(const AppInitializing());

  Future<void> initialize() async {
    final result = await _getDefaultVault(NoParams());

    await result.fold(
      (failure) async {
        emit(AppFailure(failure.message));
      },
      (vault) async {
        if (vault == null) {
          emit(const AppReady());
          return;
        }

        try {
          await _databaseProvider.openVault(vault);
          emit(AppReady(currentVault: vault));
        } catch (e) {
          emit(AppFailure(e.toString()));
        }
      },
    );
  }

  Future<void> openVault(Vault vault) async {
    try {
      await _databaseProvider.openVault(vault);
      emit(AppReady(currentVault: vault));
    } catch (e) {
      emit(AppFailure(e.toString()));
    }
  }

  Future<void> closeVault() async {
    await _databaseProvider.closeVault();
    emit(const AppReady());
  }
}
