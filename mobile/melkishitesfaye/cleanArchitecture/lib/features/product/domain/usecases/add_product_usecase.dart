import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/repositories/product_repository.dart';

import '../../../../core/usecase/usecase.dart';

class AddProductUseCase extends UseCase<Product, AddParams> {
  final ProductRepository repository;
  AddProductUseCase({required this.repository});

  Future<Either<Failure, Product>> call(
    AddParams addparams,
  ) async {
    return await repository.addProduct(
      addparams.product,
    );
  }
}

class AddParams extends Equatable {
  final Product product;
  AddParams({
    required this.product,
    
  });

  @override
  List<Object?> get props => [
        product,
      
      ];
}
