import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/repositories/product_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetProductUseCase extends UseCase<Product, GetParams> {
  final ProductRepository repository;
  GetProductUseCase({required this.repository});

  Future<Either<Failure, Product>> call(GetParams params) async {
    return await repository.getProduct(params.id);
  }
}

class GetParams extends Equatable {
  final String id;
  GetParams({required this.id});

  @override
  List<Object?> get props => [id];
}
