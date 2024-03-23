import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/repositories/product_repository.dart';

import '../../../../core/usecase/usecase.dart';

class UpdateProduct extends UseCase<Product, Params> {
  final ProductRepository repository;
  UpdateProduct({required this.repository});

  Future<Either<Failure, Product>> call(
    Params params,
  ) async {
    return await repository.updateProduct(params.product, params.id);
  }
}

class Params extends Equatable {
  final Product product;
  final String id;
  Params({required this.product, required this.id});

  @override
  List<Object?> get props => [product, id];
}
