import 'package:get_it/get_it.dart';
import 'package:rchive/core/comman/cubits/cubit/app_user_cubit.dart';
import 'package:rchive/core/comman/prefs/shared_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator
    ..registerLazySingleton(() => SharedPreferencesAsync())
    ..registerLazySingleton(() => AppUserCubit())
    ..registerFactory<SharedConfig>(
      () => SharedConfigImpl(serviceLocator<SharedPreferencesAsync>()),
    );
}
