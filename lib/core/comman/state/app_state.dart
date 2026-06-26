part of 'app_cubit.dart';

@immutable
sealed class AppState {
  const AppState();
}

final class AppInitializing extends AppState {
  const AppInitializing();
}

final class AppReady extends AppState {
  final Vault? currentVault;

  const AppReady({this.currentVault});
}

final class AppFailure extends AppState {
  final String message;
  final Object? error;

  const AppFailure(this.message, {this.error});
}
