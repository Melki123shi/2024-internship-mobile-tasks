import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/faliure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/usecase/usecase.dart';

class SearchUseCase extends UseCase<List<Product>, SearchParams>{
  final ProductRepository repository;
  SearchUseCase({required this.repository});

  Future<Either<Failure, List<Product>>> call(SearchParams params) async {
    return await repository.getFilteredProducts(params.title);
  }
}

class SearchParams extends Equatable {
  final String title;
  SearchParams({required this.title});

  @override
  List<Object?> get props => [id];
}