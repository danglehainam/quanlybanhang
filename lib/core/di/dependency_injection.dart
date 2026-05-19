import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../data/datasources/local/settings_local_datasource.dart';
import '../../data/datasources/local/category_local_datasource.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/get_layout_preference_usecase.dart';
import '../../domain/usecases/save_layout_preference_usecase.dart';
import '../../domain/usecases/get_language_usecase.dart';
import '../../domain/usecases/save_language_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/create_category_usecase.dart';
import '../../presentation/bloc/settings/settings_bloc.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/categories/categories_bloc.dart';

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
  getIt.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSource(getIt<AppDatabase>()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()),
  );
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryLocalDataSource>()),
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
  getIt.registerLazySingleton<GetLanguageUseCase>(
    () => GetLanguageUseCase(getIt<SettingsRepository>()),
  );
  getIt.registerLazySingleton<SaveLanguageUseCase>(
    () => SaveLanguageUseCase(getIt<SettingsRepository>()),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton<CreateCategoryUseCase>(
    () => CreateCategoryUseCase(getIt<CategoryRepository>()),
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
      getLanguageUseCase: getIt<GetLanguageUseCase>(),
      saveLanguageUseCase: getIt<SaveLanguageUseCase>(),
    ),
  );
  getIt.registerFactory<CategoriesBloc>(
    () => CategoriesBloc(
      getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
      createCategoryUseCase: getIt<CreateCategoryUseCase>(),
    ),
  );
}
