part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class GetSingleProductLoading extends ProductState {}

final class SucessLoadSingleProduct extends ProductState {
  final Product product;

  const SucessLoadSingleProduct({required this.product});

  @override
  List<Object> get props => [product];
}

// get list of products
final class GetProductsLoading extends ProductState {}

final class SucessLoadProducts extends ProductState {
  final List<Product> products;
  const SucessLoadProducts({required this.products});

  @override
  List<Object> get props => [];
}

// add product
final class AddProductLoading extends ProductState {}

final class SucessAddProduct extends ProductState {
  final Product product;
  const SucessAddProduct({required this.product});

  @override
  List<Object> get props => [product];
}

//Update product
final class UpdateProductLoading extends ProductState {}

final class SucessUpdateProduct extends ProductState {
  final Product product;
  const SucessUpdateProduct({required this.product});

  @override
  List<Object> get props => [product];
}

//Delete product
final class DeleteProductLoading extends ProductState {}

final class SucessDeleteProduct extends ProductState {
  final String sucessMessage;
  const SucessDeleteProduct({required this.sucessMessage});

  @override
  List<Object> get props => [sucessMessage];
}


// Failure state
final class FailureState extends ProductState {
  final String message;

  const FailureState(this.message);

  @override
  List<Object> get props => [message];
}
