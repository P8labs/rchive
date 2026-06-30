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
  _initNote();
  _initCore();
}

void _initNote() {
  serviceLocator
    ..registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImpl(
        provider: serviceLocator<DatabaseProvider>(),
        syncRepository: serviceLocator<VaultSyncRepository>(),
      ),
    )
    // usecases
    ..registerLazySingleton(() => CreateNote(serviceLocator<NotesRepository>()))
    ..registerLazySingleton(() => DeleteNote(serviceLocator<NotesRepository>()))
    ..registerLazySingleton(() => GetNote(serviceLocator<NotesRepository>()))
    ..registerLazySingleton(() => GetNotes(serviceLocator<NotesRepository>()))
    ..registerLazySingleton(() => MoveNote(serviceLocator<NotesRepository>()))
    ..registerLazySingleton(() => ReadNote(serviceLocator<NotesRepository>()))
    ..registerLazySingleton(() => RenameNote(serviceLocator<NotesRepository>()))
    ..registerLazySingleton(() => TrashNote(serviceLocator<NotesRepository>()))
    ..registerLazySingleton(() => WriteNote(serviceLocator<NotesRepository>()))
    ..registerFactory(
      () => NoteBloc(
        getNotes: serviceLocator(),
        getNote: serviceLocator(),
        readNote: serviceLocator(),
        createNote: serviceLocator(),
        writeNote: serviceLocator(),
        renameNote: serviceLocator(),
        moveNote: serviceLocator(),
        deleteNote: serviceLocator(),
        trashNote: serviceLocator(),
      ),
    );
}

void _initVault() {
  serviceLocator
    // data sources
    ..registerLazySingleton<VaultStorageDataSource>(
      () => VaultStorageDataSourceImpl(),
    )
    ..registerLazySingleton<VaultRegistryLocalDataSource>(
      () => VaultRegistryDatabaseDataSourceImpl(serviceLocator<AppDatabase>()),
    )
    // repositories
    ..registerLazySingleton<VaultRepository>(
      () => VaultRepositoryImpl(
        filesystem: serviceLocator<VaultStorageDataSource>(),
        registry: serviceLocator<VaultRegistryLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<VaultSyncRepository>(
      () =>
          VaultSyncRepositoryImpl(provider: serviceLocator<DatabaseProvider>()),
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
    ..registerLazySingleton(() => GetVaults(serviceLocator<VaultRepository>()))
    ..registerLazySingleton(() => OpenVault(serviceLocator<VaultRepository>()))
    ..registerLazySingleton(
      () => SyncVaultUseCase(repository: serviceLocator<VaultSyncRepository>()),
    )
    // bloc
    ..registerFactory(
      () => VaultBloc(
        getVaults: serviceLocator(),
        openVault: serviceLocator(),
        createVault: serviceLocator(),
        deleteVault: serviceLocator(),
        forgetVault: serviceLocator(),
      ),
    );
}

void _initCore() {
  serviceLocator.registerLazySingleton(
    () => AppCubit(
      serviceLocator<DatabaseProvider>(),
      serviceLocator<SyncVaultUseCase>(),
    ),
  );
}
