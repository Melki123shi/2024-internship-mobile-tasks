import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, String>> deleteProduct(String id);
  Future<Either<Failure, Product>> updateProduct(Product product, String id);
  Future<Either<Failure, Product>> getProduct(String id);
  Future<Either<Failure, List<Product>>> getProducts();
}
