import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/entities/app_config.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/database_provider.dart';
import 'package:rchive/core/usecase.dart';
import 'package:rchive/features/vault/domain/usecases/sync_vault.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final DatabaseProvider _databaseProvider;
  final SyncVaultUseCase _syncVault;
  AppCubit(this._databaseProvider, this._syncVault)
    : super(const AppInitializing());

  Future<void> initialize() async {
    try {
      // this need to be done at top will create config table in db.
      await _databaseProvider.syncAppConfig(AppConfig.initial(), init: true);
      final vault = await _databaseProvider.getDefaultVault();

      if (vault == null) {
        emit(const AppReady());
        return;
      }

      await _databaseProvider.openVault(vault);
      emit(AppReady(currentVault: vault));
    } catch (e) {
      emit(AppFailure(e.toString()));
    }
  }

  Future<void> openVault(Vault vault) async {
    try {
      await _databaseProvider.openVault(vault);
      final sync = await _syncVault(NoParams());
      sync.fold((failure) => throw Exception(failure.message), (_) {});
      await _databaseProvider.syncAppConfig(
        _databaseProvider.appConfig.copyWith(defaultVaultId: vault.id),
      );
      emit(AppReady(currentVault: vault));
    } catch (e) {
      emit(AppFailure(e.toString()));
    }
  }

  Future<void> closeVault() async {
    try {
      await _databaseProvider.closeVault();
      await _databaseProvider.syncAppConfig(
        _databaseProvider.appConfig.copyWith(defaultVaultId: ""),
      );
      emit(const AppReady());
    } catch (e) {
      emit(AppFailure(e.toString()));
    }
  }
}
