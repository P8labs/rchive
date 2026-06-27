import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/entities/app_config.dart';
import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/core/database/database_provider.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final DatabaseProvider _databaseProvider;

  AppCubit(this._databaseProvider) : super(const AppInitializing());

  Future<void> initialize() async {
    try {
      // this need to be done at top will create config table in db.
      await _databaseProvider.syncAppConfig(AppConfig.initial());
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
      await _databaseProvider.syncAppConfig(
        _databaseProvider.appConfig.copyWith(defaultVaultId: vault.id),
      );
      emit(AppReady(currentVault: vault));
    } catch (e) {
      emit(AppFailure(e.toString()));
    }
  }

  Future<void> closeVault() async {
    await _databaseProvider.closeVault();
    await _databaseProvider.syncAppConfig(
      _databaseProvider.appConfig.copyWith(defaultVaultId: null),
    );
    emit(const AppReady());
  }
}
