import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/entities/vault.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void initVault(Vault? vault) {
    if (vault == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserOnboarded(vault));
    }
  }
}
