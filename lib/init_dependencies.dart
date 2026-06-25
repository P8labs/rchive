import 'package:get_it/get_it.dart';
import 'package:rchive/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rchive/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:rchive/features/auth/domain/repository/auth_repository.dart';
import 'package:rchive/features/auth/domain/usecases/authenticate_user.dart';
import 'package:rchive/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl())
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => AuthenticateUser(serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(authenticateUser: serviceLocator()));
}
