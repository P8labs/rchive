part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final dir = await getApplicationSupportDirectory();
  final appDatabase = openConnection(dir.path);

  serviceLocator
    ..registerSingleton<AppDatabase>(appDatabase)
    ..registerSingleton<DatabaseProvider>(
      DatabaseProviderImpl(appDatabase: appDatabase),
    );

  _initVault();
  _initCore();
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
    ..registerLazySingleton(
      () => CreateVault(serviceLocator<VaultRepository>()),
    )
    ..registerLazySingleton(
      () => DeleteVault(serviceLocator<VaultRepository>()),
    )
    ..registerLazySingleton(
      () => ForgetVault(serviceLocator<VaultRepository>()),
    )
    ..registerLazySingleton(
      () => GetDefaultVault(serviceLocator<VaultRepository>()),
    )
    ..registerLazySingleton(() => GetVaults(serviceLocator<VaultRepository>()))
    ..registerLazySingleton(() => OpenVault(serviceLocator<VaultRepository>()))
    ..registerLazySingleton(
      () => CloseDefaultVault(serviceLocator<VaultRepository>()),
    )
    ..registerLazySingleton(
      () => SetDefaultVault(serviceLocator<VaultRepository>()),
    )
    // bloc
    ..registerFactory(
      () => VaultBloc(
        getVaults: serviceLocator(),
        openVault: serviceLocator(),
        createVault: serviceLocator(),
        deleteVault: serviceLocator(),
        forgetVault: serviceLocator(),
        setDefaultVault: serviceLocator(),
        closeDefaultVault: serviceLocator(),
      ),
    );
}

void _initCore() {
  serviceLocator.registerLazySingleton(
    () => AppCubit(serviceLocator(), serviceLocator()),
  );
}
