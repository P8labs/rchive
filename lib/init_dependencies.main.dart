part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final dir = await getApplicationSupportDirectory();
  final appDatabase = openConnection(dir.path);

  serviceLocator
    ..registerSingleton<AppDatabase>(appDatabase)
    ..registerSingleton<DatabaseProvider>(
      DatabaseProviderImpl(appDatabase: appDatabase),
    )
    ..registerLazySingleton(() => AppCubit(serviceLocator(), serviceLocator()));

  _initVault();
}

void _initVault() {
  serviceLocator
    // data sources
    ..registerLazySingleton<VaultFilesystemDataSource>(
      () => VaultFilesystemDataSourceImpl(),
    )
    ..registerLazySingleton<VaultRegistryLocalDataSource>(
      () => VaultRegistryLocalDataSourceImpl(serviceLocator<AppDatabase>()),
    )
    // repositories
    ..registerLazySingleton<VaultRepository>(
      () => VaultRepositoryImpl(
        filesystem: serviceLocator<VaultFilesystemDataSource>(),
        registry: serviceLocator<VaultRegistryLocalDataSource>(),
      ),
    )
    // usecases
    ..registerFactory(() => CreateVault(serviceLocator<VaultRepository>()))
    ..registerFactory(() => DeleteVault(serviceLocator<VaultRepository>()))
    ..registerFactory(() => ForgetVault(serviceLocator<VaultRepository>()))
    ..registerFactory(() => GetDefaultVault(serviceLocator<VaultRepository>()))
    ..registerFactory(() => GetVaults(serviceLocator<VaultRepository>()))
    ..registerFactory(() => SetDefaultVault(serviceLocator<VaultRepository>()))
    // bloc
    ..registerFactory(() => VaultBloc());
}
