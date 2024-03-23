import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/repositories/product_repository.dart';

import '../../../../core/usecase/usecase.dart';

class AddProduct extends UseCase<Product, Params> {
  final ProductRepository repository;
  AddProduct({required this.repository});

  Future<Either<Failure, Product>> call(Params params,) async {
    return await repository.addProduct(params.product);
  }
}

class Params extends Equatable {
  final Product product;
  Params({required this.product});

  @override
  List<Object?> get props => [product];
}


