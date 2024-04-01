import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/repositories/product_repository.dart';

import '../../../../core/usecase/usecase.dart';

class UpdateProductUseCase extends UseCase<Product, UpdateParams> {
  final ProductRepository repository;
  UpdateProductUseCase({required this.repository});

  Future<Either<Failure, Product>> call(
    UpdateParams updateParams,
  ) async {
    return await repository.updateProduct(updateParams.product, updateParams.id);
  }
}

class UpdateParams extends Equatable {
  final Product product;
  final String id;
  const UpdateParams({required this.product, required this.id});

  @override
  List<Object?> get props => [product, id];
}
