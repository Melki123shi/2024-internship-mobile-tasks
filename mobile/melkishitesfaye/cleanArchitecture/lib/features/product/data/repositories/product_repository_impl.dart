import 'package:dartz/dartz.dart';
import 'package:melkishitesfaye/core/error/exception.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/repositories/product_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote.dart';

typedef Future<Product> _CallProductmethods();

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> addProduct(Product product) async {
    return await _productMethods(() {
      return remoteDataSource.addProduct(product);
    });
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    return await _productMethods(() {
      return remoteDataSource.getProduct(id);
    });
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProducts();
        localDataSource.cacheProducts(remoteProduct);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProduct = await localDataSource.getAvailableProducts();
        return Right(localProduct);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(
      Product product, String id) async {
    return await _productMethods(() {
      return remoteDataSource.updateProduct(product, id);
    });
  }

  @override
  Future<Either<Failure, String>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.deleteProduct(id);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Product>> _productMethods(
    _CallProductmethods _callProductmethods,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await _callProductmethods();
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
