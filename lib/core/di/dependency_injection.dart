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
import '../../domain/usecases/update_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../presentation/bloc/settings/settings_bloc.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/categories/categories_bloc.dart';
import '../../data/datasources/local/product_local_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../presentation/bloc/products/products_bloc.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/repositories/order_repository.dart';
import '../../presentation/bloc/sell/sell_bloc.dart';
import '../../data/datasources/local/transaction_local_datasource.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/get_transactions_usecase.dart';
import '../../domain/usecases/create_transaction_usecase.dart';
import '../../domain/usecases/update_transaction_usecase.dart';
import '../../domain/usecases/delete_transaction_usecase.dart';
import '../../presentation/screens/transactions/bloc/transactions_bloc.dart';
import '../../data/datasources/local/customer_table_local_datasource.dart';
import '../../data/repositories/customer_table_repository_impl.dart';
import '../../domain/repositories/customer_table_repository.dart';
import '../../domain/usecases/get_customer_tables_usecase.dart';
import '../../domain/usecases/create_customer_table_usecase.dart';
import '../../domain/usecases/update_customer_table_usecase.dart';
import '../../domain/usecases/delete_customer_table_usecase.dart';
import '../../presentation/screens/tables/bloc/customer_tables_bloc.dart';
import '../../data/datasources/local/customer_local_datasource.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../domain/repositories/customer_repository.dart';
import '../../domain/usecases/find_customer_by_phone_usecase.dart';
import '../../domain/usecases/create_customer_usecase.dart';
import '../../domain/usecases/update_order_usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../presentation/screens/orders/bloc/orders_bloc.dart';
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
  getIt.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSource(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSource(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<CustomerTableLocalDataSource>(
    () => CustomerTableLocalDataSource(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<CustomerLocalDataSource>(
    () => CustomerLocalDataSourceImpl(getIt<AppDatabase>()),
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
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt<ProductLocalDataSource>()),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(localDatabase: getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<TransactionLocalDataSource>()),
  );
  getIt.registerLazySingleton<CustomerTableRepository>(
    () => CustomerTableRepositoryImpl(getIt<CustomerTableLocalDataSource>()),
  );
  getIt.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(getIt<CustomerLocalDataSource>()),
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
  getIt.registerLazySingleton<UpdateCategoryUseCase>(
    () => UpdateCategoryUseCase(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton<DeleteCategoryUseCase>(
    () => DeleteCategoryUseCase(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<CreateProductUseCase>(
    () => CreateProductUseCase(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<UpdateProductUseCase>(
    () => UpdateProductUseCase(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<DeleteProductUseCase>(
    () => DeleteProductUseCase(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<GetTransactionsUseCase>(
    () => GetTransactionsUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<CreateTransactionUseCase>(
    () => CreateTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<UpdateTransactionUseCase>(
    () => UpdateTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<DeleteTransactionUseCase>(
    () => DeleteTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetCustomerTablesUseCase>(
    () => GetCustomerTablesUseCase(getIt<CustomerTableRepository>()),
  );
  getIt.registerLazySingleton<CreateCustomerTableUseCase>(
    () => CreateCustomerTableUseCase(getIt<CustomerTableRepository>()),
  );
  getIt.registerLazySingleton<UpdateCustomerTableUseCase>(
    () => UpdateCustomerTableUseCase(getIt<CustomerTableRepository>()),
  );
  getIt.registerLazySingleton<DeleteCustomerTableUseCase>(
    () => DeleteCustomerTableUseCase(getIt<CustomerTableRepository>()),
  );
  getIt.registerLazySingleton<FindCustomerByPhoneUseCase>(
    () => FindCustomerByPhoneUseCase(getIt<CustomerRepository>()),
  );
  getIt.registerLazySingleton<CreateCustomerUseCase>(
    () => CreateCustomerUseCase(getIt<CustomerRepository>()),
  );
  getIt.registerLazySingleton<UpdateOrderUseCase>(
    () => UpdateOrderUseCase(getIt<OrderRepository>()),
  );
  getIt.registerLazySingleton<GetOrdersUseCase>(
    () => GetOrdersUseCase(getIt<OrderRepository>()),
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
      updateCategoryUseCase: getIt<UpdateCategoryUseCase>(),
      deleteCategoryUseCase: getIt<DeleteCategoryUseCase>(),
    ),
  );
  getIt.registerFactory<ProductsBloc>(
    () => ProductsBloc(
      getProductsUseCase: getIt<GetProductsUseCase>(),
      createProductUseCase: getIt<CreateProductUseCase>(),
      updateProductUseCase: getIt<UpdateProductUseCase>(),
      deleteProductUseCase: getIt<DeleteProductUseCase>(),
    ),
  );
  getIt.registerFactory<SellBloc>(
    () => SellBloc(
      productRepository: getIt<ProductRepository>(),
      categoryRepository: getIt<CategoryRepository>(),
      orderRepository: getIt<OrderRepository>(),
      updateOrderUseCase: getIt<UpdateOrderUseCase>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );
  getIt.registerFactory<OrdersBloc>(
    () => OrdersBloc(getIt<GetOrdersUseCase>()),
  );
  getIt.registerFactory<TransactionsBloc>(
    () => TransactionsBloc(
      getIt<GetTransactionsUseCase>(),
      getIt<CreateTransactionUseCase>(),
      getIt<UpdateTransactionUseCase>(),
      getIt<DeleteTransactionUseCase>(),
    ),
  );
  getIt.registerFactory<CustomerTablesBloc>(
    () => CustomerTablesBloc(
      getIt<GetCustomerTablesUseCase>(),
      getIt<CreateCustomerTableUseCase>(),
      getIt<UpdateCustomerTableUseCase>(),
      getIt<DeleteCustomerTableUseCase>(),
    ),
  );
}
