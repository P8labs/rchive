import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/entities/vault.dart';

part 'vault_event.dart';
part 'vault_state.dart';

class VaultBloc extends Bloc<VaultEvent, VaultState> {
  VaultBloc() : super(VaultState()) {
    on<VaultEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
