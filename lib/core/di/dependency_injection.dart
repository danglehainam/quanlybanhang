import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../data/datasources/local/settings_local_datasource.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/usecases/get_layout_preference_usecase.dart';
import '../../domain/usecases/save_layout_preference_usecase.dart';
import '../../presentation/bloc/settings/settings_bloc.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // Database
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // DataSource
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSource(getIt<SharedPreferences>()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()),
  );

  // UseCase
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetLayoutPreferenceUseCase>(
    () => GetLayoutPreferenceUseCase(getIt<SettingsRepository>()),
  );
  getIt.registerLazySingleton<SaveLayoutPreferenceUseCase>(
    () => SaveLayoutPreferenceUseCase(getIt<SettingsRepository>()),
  );

  // Bloc
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      authRepository: getIt<AuthRepository>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );
  getIt.registerFactory<SettingsBloc>(
    () => SettingsBloc(
      getLayoutPreferenceUseCase: getIt<GetLayoutPreferenceUseCase>(),
      saveLayoutPreferenceUseCase: getIt<SaveLayoutPreferenceUseCase>(),
    ),
  );
}
