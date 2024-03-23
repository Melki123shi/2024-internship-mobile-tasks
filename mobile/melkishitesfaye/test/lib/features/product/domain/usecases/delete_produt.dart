import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/repositories/product_repository.dart';

import '../../../../core/usecase/usecase.dart';

class DeleteProduct extends UseCase<String, Params>{
  final ProductRepository repository;
  DeleteProduct({required this.repository});

  Future<Either<Failure, String>> call(Params params,) async {
    return await repository.deleteProduct(params.id);
  }
}

class Params extends Equatable {
  final String id;
  Params({required this.id});

  @override
  List<Object?> get props => [id];
}



