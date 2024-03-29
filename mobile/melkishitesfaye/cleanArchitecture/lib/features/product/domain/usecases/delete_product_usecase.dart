import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/faliure.dart';
import '../repositories/product_repository.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteProductUseCase extends UseCase<String, DeleteParams>{
  final ProductRepository repository;
  DeleteProductUseCase({required this.repository});

  Future<Either<Failure, String>> call(DeleteParams deleteparams,) async {
    return await repository.deleteProduct(deleteparams.id);
  }
}

class DeleteParams extends Equatable {
  final String id;
  DeleteParams({required this.id});

  @override
  List<Object?> get props => [id];
}



