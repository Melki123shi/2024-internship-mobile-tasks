import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:melkishitesfaye/core/network/network_info.dart';
import 'package:melkishitesfaye/features/product/data/datasources/product_local_data_source.dart';
import 'package:melkishitesfaye/features/product/data/datasources/product_remote_data_source.dart';
import 'package:melkishitesfaye/features/product/data/repositories/product_repository_impl.dart';
import 'package:melkishitesfaye/features/product/domain/repositories/product_repository.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/add_product_usecase.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/get_product_usecase.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/get_products_usecase.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/update_product_usecase.dart';
import 'package:melkishitesfaye/features/product/presentatoin/bloc/product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  //! Features
  getIt.registerFactory<ProductBloc>(() => ProductBloc(
        getProduct: getIt(),
        getProducts: getIt(),
        updateProduct: getIt(),
        deleteProduct: getIt(),
        addProduct: getIt(),
      ));

  //! Usecases
  getIt.registerLazySingleton<GetProductUseCase>(
    () => GetProductUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(repository: getIt()));

  getIt.registerLazySingleton<UpdateProductUseCase>(
      () => UpdateProductUseCase(repository: getIt()));

  getIt.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(repository: getIt()));

  //! repository
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt()));

  //! DataSources
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: getIt()),
  );
  getIt.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt()),
  );

  //! External dependency
  getIt.registerLazySingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  await GetIt.instance.isReady<SharedPreferences>();
  
  getIt.registerLazySingleton<InternetConnection>(
    () => InternetConnection(),
  );
  getIt.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
}
