import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/usecase/usecase.dart';

class GetProductsUseCase {
  final ProductRepository repository;
  GetProductsUseCase({required this.repository});

  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}





