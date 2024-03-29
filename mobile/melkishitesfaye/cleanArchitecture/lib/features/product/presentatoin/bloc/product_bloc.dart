import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';

import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUseCase getProduct;
  final GetProductsUseCase getProducts;
  final DeleteProductUseCase deleteProduct;
  final AddProductUseCase addProduct;
  final UpdateProductUseCase updateProduct;

  ProductBloc({
    required this.getProduct,
    required this.getProducts,
    required this.deleteProduct,
    required this.addProduct,
    required this.updateProduct,
  }) : super(ProductInitial()) {
    on<GetProductEvent>((event, emit) async {
      emit(GetSingleProductLoading());
      final response = await getProduct(GetParams(id: event.id));

      response.fold(
          (left) => emit(
              const FailureState('error occured while loading the product')),
          (right) => emit(SucessLoadSingleProduct(product: right)));
    });

    on<GetProductsEvent>((event, emit) async {
      emit(GetProductsLoading());
      final response = await getProducts(NoParams());

      response.fold(
        (left) => emit(
            const FailureState('error occured while loading the products')),
        (right) => emit((SucessLoadProducts(products: right))),
      );
    });

    on<AddProductEvent>((event, emit) async {
      emit(AddProductLoading());
      final response = await addProduct(
        AddParams(product: event.product),
      );

      response.fold(
        (left) =>
            emit(const FailureState('error occured while adding the product')),
        (right) => emit(SucessAddProduct(product: right)),
      );
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(UpdateProductLoading());
      final response = await updateProduct(
          UpdateParams(product: event.product, id: event.id));

      response.fold(
        (left) =>
            emit(const FailureState('error occured while updating product')),
        (right) => emit(SucessUpdateProduct(product: right)),
      );
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(DeleteProductLoading());
      final response = await deleteProduct(DeleteParams(id: event.id));

      response.fold(
        (left) => emit(
            const FailureState('error occured while deleting the product')),
        (right) => emit(const SucessDeleteProduct(
            sucessMessage: 'sucessfluy deleted the product')),
      );
    });
  }
}
